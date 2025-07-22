# handles administrative tasks for the page object
class PageController < ApplicationController
  require 'image_helper'
  include ImageHelper

  protect_from_forgery except: [:set_page_title]
  before_action :authorized?, except: [:alto_xml]

  def authorized?
    if user_signed_in?
      redirect_to dashboard_path if @work && !current_user.like_owner?(@work)
    else
      redirect_to dashboard_path
    end
  end

  def new
    @page = Page.new
    @page.title = @work.suggest_next_page_title
    @page.work = @work
  end

  def create
    result = Page::Create.new(work: @work, page_params: page_params).call

    if result.success?
      subaction = params[:subaction]

      flash[:notice] = t('.page_created')
      if subaction == 'save_and_new'
        ajax_redirect_to({ controller: 'dashboard', action: 'startproject', anchor: 'create-work' })
      else
        ajax_redirect_to({ controller: 'work', action: 'pages_tab', work_id: @work.id, anchor: 'create-page' })
      end
    else
      @page = result.page

      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Edit route
  end

  def update
    @result = Page::Update.new(page: @page, page_params: page_params).call

    @page = @result.page
    @collection = @page.collection
    @work = @page.work

    respond_to do |format|
      # TODO: other page settings tab
      template = 'page/update_general'

      format.turbo_stream { render template }
    end
  end

  def destroy
    result = Page::Destroy.new(page: @page).call

    flash[:notice] = t('.page_deleted')
    redirect_to work_pages_tab_path(work_id: result.page.work_id)
  end

  def rotate
    result = Page::Rotate.new(page: @page, orientation: params[:orientation].to_i).call

    redirect_back fallback_location: result.page
  end

  def reorder
    Page::Reorder.new(page: @page, direction: params[:direction]).call

    redirect_to work_pages_tab_path(work_id: @work.id)
  end

  def alto_xml
    # Transkribus ALTO does not include an ID on the String element, but we need one for Annotorious
    # we need to read the alto file and iterate over every string element, adding an ID attribute
    raw_alto = @page.alto_xml
    doc = Nokogiri::XML(raw_alto)

    doc.search('String').each_with_index do |string, i|
      string['ID'] = "string_#{i}"
    end

    render :plain => doc.to_xml, :layout => false, :content_type => 'text/xml'
  end


  # def create
  #   @page = Page.new(page_params)
  #   subaction = params[:subaction]
  #   @work.pages << @page

  #   if @page.save
  #     flash[:notice] = t('.page_created')

  #     if page_params[:base_image]
  #       process_uploaded_file(@page, page_params[:base_image])
  #     end

  #     if subaction == 'save_and_new'
  #       ajax_redirect_to({ :controller => 'dashboard', :action => 'startproject', :anchor => 'create-work' })
  #     else
  #       ajax_redirect_to({ :controller => 'work', :action => 'pages_tab', :work_id => @work.id, :anchor => 'create-page' })
  #     end
  #   else
  #     render :new
  #   end
  # end

  # def update
  #   page = Page.find(params[:id])
  #   attributes = page_params.to_h.except("base_image")

  #   if page_params[:status].blank?
  #     attributes['status'] = nil
  #   end

  #   page.update_columns(attributes) # bypass page version callbacks

  #   flash[:notice] = t('.page_updated')
  #   page.work.work_statistic.recalculate if page.work.work_statistic

  #   if params[:page][:base_image]
  #     process_uploaded_file(page, page_params[:base_image])
  #   end

  #   redirect_back fallback_location: page
  # end

  def update_labels
    page = Page.find(params[:page_id])
    if page.update(page_labels_params)
      flash[:notice] = t('transcribe.page_labels.page_labels_updated')
    else
      flash[:alert] = t('transcribe.page_labels.page_labels_update_failed')
    end

    redirect_back fallback_location: page
  end

  private

  def page_labels_params
    params.require(:page).permit(label_ids: [])
  end

  private

  def page_params
    params.require(:page).permit(:page, :title, :base_image, :status, :translation_status, label_ids: [])
  end

end
