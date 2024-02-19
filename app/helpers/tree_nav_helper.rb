module TreeNavHelper
  def contains_page_title?(nav_data, page_title, box_name = nil, part_name = nil, topic_name = nil)
    if nav_data.nil?
      return false
    end

    nav_data.each do |current_box_name, parts|
      current_part_name = nil
      current_topic_name = nil

      if box_name.nil?
        box_name = current_box_name
      elsif current_box_name == box_name
        parts.each do |current_part_name, topics|
          if part_name.nil?
            part_name = current_part_name
          elsif current_part_name == part_name
            topics.each do |current_topic_name, filenames|
              if topic_name.nil?
                topic_name = current_topic_name
              elsif current_topic_name == topic_name
                return filenames.include?(page_title)
              end
            end
          end
        end
      end

      if contains_page_title?(parts, page_title, box_name, current_part_name, current_topic_name)
        return true
      end
    end

    false
  end
end
