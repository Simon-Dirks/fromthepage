module TreeNavHelper
  def box_contains_page_title?(nav_data, box_name, page_title)
    contains_page_title = nav_data.dig(box_name).to_a.flatten.any? { |item| item.is_a?(String) && item.include?(page_title) }
    logger.info("Page title #{page_title} is#{contains_page_title ? '' : ' not'} contained in box #{box_name}")
    contains_page_title
  end
end