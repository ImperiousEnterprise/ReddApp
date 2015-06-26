require 'net/http'
class Link < ActiveRecord::Base
  belongs_to :user
  acts_as_votable
  has_many :comments
  before_validation :addhttp
  validates :title , presence: true , length: {minimum: 5, maximum:50}
  VALID_URL_REGEX = /^(http|https):\/\/?([a-z0-9]+)([-.]{1}[a-z0-9]+)([\/.]{1}[a-z0-9]+){1}$/
  validates :url, :presence => true, uniqueness: true, :uri => { :format => VALID_URL_REGEX, :multiline => true}


  private
  def addhttp
    unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end
