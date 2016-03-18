class Link < ActiveRecord::Base
  after_create :generate_slug
  # validates_presence_of :slug
  # validates_presence_of :given_url

  def generate_slug
    if slug.nil?
      self.slug = id.to_s << Array.new(5).map do |_variable|
        [*"0".."9", *"a".."z"].sample
      end.join
      
      save
    end
  end

  def display_slug
    ENV["BASE_URL"] + slug
  end

  def screenshot_scrape
    Screenshot.perform_async(id)
    Scrape.perform_async(id)
  end
end
