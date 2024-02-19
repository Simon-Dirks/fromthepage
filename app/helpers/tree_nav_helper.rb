module TreeNavHelper
  def contains_page_title?(nav_data, page_title)
    nav_data.each do |_box_name, parts|
      parts.each do |_part_name, topics|
        topics.each do |_topic_name, filenames|
          return true if filenames.include?(page_title)
        end
      end
    end
    false
  end
end
