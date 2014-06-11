class Presentation < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  after_commit :async_convert_to_jpg, on: :create

  def async_convert_to_jpg
    PresentationsWorker.perform_async(id)
  end

  attr_accessor :upload

  # belongs_to :user_id
  has_and_belongs_to_many :categories

  mapping do
    indexes :id
    indexes :title
    indexes :qte_slides
    indexes :pdf_name
    indexes :category do
      indexes :id
      indexes :name
    end
    indexes :user do
      indexes :id
      indexes :name
    end
  end

  def self.save_file(upload, id)
    pres = Presentation.find(id)
    file_name = upload.original_filename  if upload.present?
    file = upload.read
    file_type = file_name.split('.').last

    pdf_root = "#{Rails.root}/app/assets/pdfs/"

    Dir.mkdir(pdf_root + "#{pres.id}")
      File.open(pdf_root + "#{pres.id}/" + "#{pres.id}.#{file_type}", "wb")  do |f|
        f.write(file)
      end
  end

  def self.search(params)
    tire.search do
      query { string params[:query] } if params[:query].present?
    end
  end

  def to_indexed_json
    to_json include: :categories
  end

end
