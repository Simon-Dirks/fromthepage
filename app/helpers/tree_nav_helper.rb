module TreeNavHelper
  def box_contains_filename_prefix?(box_filename_prefixes_data, box_name, prefix)
    box_name_str = box_name.to_s
    logger.info(box_filename_prefixes_data.key?(box_name_str))
    logger.info(box_name_str)
    return false unless box_filename_prefixes_data.key?(box_name_str)
    box_filename_prefixes_data[box_name_str].any? { |filename| filename.start_with?(prefix) }
  end
end
