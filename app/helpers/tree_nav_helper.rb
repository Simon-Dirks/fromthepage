module TreeNavHelper
  def box_contains_filename_prefix?(box_filename_prefixes_data, box_number, prefix)
    box_number_str = box_number.to_s
    logger.info(box_filename_prefixes_data.key?(box_number_str))
    logger.info(box_number_str)
    return false unless box_filename_prefixes_data.key?(box_number_str)
    box_filename_prefixes_data[box_number_str].any? { |filename| filename.start_with?(prefix) }
  end
end
