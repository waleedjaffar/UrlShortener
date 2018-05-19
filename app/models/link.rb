class Link < ActiveRecord::Base

  before_validation :generate_short_url
  validates :full_url, :short_url, presence: true
  validates :full_url, url: true

  private

  # Generate a unique short_url for a given web address
  def generate_short_url
    url = Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond).to_s(36)
    old_url = Link.where(short_url: url).last
    if old_url.present? 
      self.generate_short_url
    else
      self.short_url = url
    end
  end
end
