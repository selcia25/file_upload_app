class FileUploadsController < ApplicationController
    def new
      @file_upload = FileUpload.new
    end
  
    def create
      @file_upload = FileUpload.new(file_upload_params)
      if @file_upload.save
        redirect_to @file_upload, notice: 'File was successfully uploaded.'
      else
        render :new
      end
    end
  
    def show
      @file_upload = FileUpload.find(params[:id])
    end
  
    private
  
    def file_upload_params
      params.require(:file_upload).permit(:name, :file_data)
    end
  end
  