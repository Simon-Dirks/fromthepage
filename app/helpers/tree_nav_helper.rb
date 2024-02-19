module TreeNavHelper
  def box_contains_page_title?(nav_data, box_name, page_title)
    nav_data[box_name].values.flatten.any? { |filenames| filenames.include?(page_title) }
  end
end