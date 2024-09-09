class DocumentUpload::ProcessJob < ApplicationJob
  queue_as :default

  def perform(id, log_file)
    args = { id: id }
    RakeInteractor.new(task_name: 'fromthepage:process_document_upload', args: args, log_file: log_file).call
  end
end
