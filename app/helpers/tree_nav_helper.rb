module TreeNavHelper
  def box_contains_filename_prefix?(box_filename_prefixes_data, box_name, prefix)
    logger.info(box_filename_prefixes_data.key?(box_name))
    logger.info(box_name)
    logger.info(box_filename_prefixes_data)
    return false unless box_filename_prefixes_data.key?(box_name)
    box_filename_prefixes_data[box_name].any? { |filename| filename.start_with?(prefix) }
  end
end
