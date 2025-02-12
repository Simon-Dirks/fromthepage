class BulkExport < ApplicationRecord
  require 'zip'
  include ExportHelper, ExportService
  store :report_arguments, accessors: [:preserve_linebreaks, :include_metadata, :include_contributors, :start_date, :end_date], coder: JSON

  belongs_to :user
  belongs_to :collection, optional: true
  belongs_to :document_set, optional: true
  belongs_to :work, optional: true


  module Status
    NEW = 'new'
    QUEUED = 'queued'
    PROCESSING = 'processing'
    FINISHED = 'finished'
    CLEANED = 'cleaned'
    ERROR = 'error'
  end

  module Organization
    FORMAT_THEN_WORK = 'by_format'
    WORK_THEN_FORMAT = 'by_work'
  end


  def work_level?
    self.attributes.detect{|k,v| k.match(/_work/) && v==true }
  end

  def page_level?
    self.attributes.detect{|k,v| k.match(/_page/) && v==true }
  end


  def export_to_zip
    self.status = Status::PROCESSING
    self.save

    begin
      if self.work
        works=[self.work]
      elsif self.document_set
        works = self.document_set.works.includes(pages: [:notes, {page_versions: :user}])
      elsif self.collection
        works = Work.includes(pages: [:notes, {page_versions: :user}]).where(collection_id: self.collection.id)
      else
        works = []
      end

      buffer = Zip::OutputStream.open(zip_file_name) do |out|
        write_work_exports(works, out, self.user, self)
        out.close
      end

      self.status = Status::FINISHED
      self.save

    rescue => ex
      self.status = Status::ERROR
      self.save

      raise
    end

  end

  def clean_zip_file
    File.unlink(zip_file_name) if File.exist?(zip_file_name)
    File.unlink(log_file) if File.exist?(log_file)
    self.status = Status::CLEANED
    self.save
  end


  def submit_export_process
    self.status = Status::QUEUED
    self.save
    rake_call = "#{RAKE} fromthepage:process_bulk_export[#{self.id}]  --trace >> #{log_file} 2>&1 &"

    # Nice-up the rake call if settings are present
    rake_call = "nice -n #{NICE_RAKE_LEVEL} " << rake_call if NICE_RAKE_ENABLED

    logger.info rake_call
    system(rake_call)
  end

  def log_file
    File.join(zip_file_path, "rake_bulk_export_#{self.id}.log")
  end

  def log_contents
    if File.exist?(log_file)
      File.read(log_file)
    else
      "Log file has been cleaned"
    end
  end

  def zip_file_path
    path = "/tmp/fromthepage_exports"
    FileUtils.mkdir_p(path)

    path
  end

  def zip_file_name
    File.join(zip_file_path, "export_#{self.id}.zip")
  end


end
