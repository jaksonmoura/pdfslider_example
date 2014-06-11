require 'RMagick'
class PresentationsWorker
  include Sidekiq::Worker
  include Magick

  def perform(p_id)
    pres = Presentation.find(p_id)
    path = "#{Rails.root}/app/assets/pdfs/#{pres.id}"
    pdf = ImageList.new("#{path}/#{pres.id}.pdf")
    pdf.each do |p|
      p.write("#{Rails.root}/app/assets/pdfs/#{pres.id}/#{pres.id}-%d.jpg"){self.quality = 100}
    end
  end

end