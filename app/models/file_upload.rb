class FileUpload < ApplicationRecord
    has_one_attached :file_data
end
