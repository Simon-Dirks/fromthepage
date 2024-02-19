module TreeNavHelper
  def box_contains_page_title?(nav_data, box_name, page_title)
    contains_page_title = nav_data[box_name].values.flatten.any? { |filenames| filenames.include?(page_title) }
    logger.info("Page title #{page_title} is#{contains_page_title ? '' : ' not'} contained in box #{box_name} #{nav_data[box_name].values.flatten}")
    contains_page_title
  end
end