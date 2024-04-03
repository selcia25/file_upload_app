# Web Programming Exercise 6 - File Upload Functionality

## Aim
This documentation outlines the implementation of file upload functionality in a Ruby on Rails application. The goal of this functionality is to allow users to upload files, such as images, documents, etc., and store them in the application.

## Required Web Tools and Methodology
- Ruby on Rails: The web framework will be used to develop the application.
- SQLite for database
- HTML, CSS, JavaScript for frontend
- Git for version control
- Web Browser: To test the functionality of the website.

## Implementation Procedure

### Setting Up the Rails Application
1. Use the `rails new` command to create a new Ruby on Rails application.
2. Change into the application directory.
3. Generate a new model called `FileUpload` with attributes `name` (string) and `file_data` (binary).
4. Install and configure active storage if it is not already done.
5. Run `rails db:migrate` to update the database schema.

### Setting Up the File Upload Form
1. Go to `app\views` and create a new folder named `file_uploads`.
2. Create new files `app\views\file_uploads\new.html.erb` and `app\views\file_uploads\show.html.erb`.

#### app\views\file_uploads\new.html.erb
```erb
<%= form_with(model: @file_upload, url: file_uploads_path, multipart: true) do |form| %>
  <div class="field">
    <%= form.label :name %>
    <%= form.text_field :name %>
  </div>
  <div class="field">
    <%= form.label :file_data, 'Upload File' %>
    <%= form.file_field :file_data %>
  </div>
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

#### app\views\file_uploads\show.html.erb
```erb
<h1>File Details</h1>
<p>This is the file that you uploaded!</p>
<p><strong>Name:</strong> <%= @file_upload.name %></p>
<%= image_tag @file_upload.file_data if @file_upload.file_data.attached? %>
```

### Implement the File Upload Controller
1. Go to `app\controllers` and create a new file `app\controllers\file_uploads_controller.rb`.

#### app\controllers\file_uploads_controller.rb
```ruby
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
```

### Implement the File Upload Model
1. Go to `app\models` and create a new file `app\models\file_upload.rb`.

#### app\models\file_upload.rb
```ruby
class FileUpload < ApplicationRecord
  has_one_attached :file_data
end
```

### Configure Routes
1. Go to `config\routes.rb` and modify the file.

#### config\routes.rb
```ruby
Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :file_uploads, only: [:new, :create, :show]
end
```

### Running the Application
- Use the `rails server` command to start the Rails development server.
- Access the application through a web browser at `http://127.0.0.1:3000`.

## Conclusion
The file upload functionality has been successfully implemented in the Rails application. Users can now upload files, which are stored in the database and can be displayed using the show action of the `FileUploadsController`.
