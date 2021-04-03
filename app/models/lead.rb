class Lead < ApplicationRecord
    require 'sendgrid-ruby'
    include SendGrid
    mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
    validates_presence_of :name
    validates_presence_of :company_name
    validates_presence_of :email
    validates_presence_of :phone
    validates_presence_of :project_name
    validates_presence_of :project_description
   
end
