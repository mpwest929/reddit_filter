class Filter < ActiveRecord::Base
  before_save :set_uuid

  has_many :filter_items

  def set_uuid
    return if !self.uuid.nil?

    self.uuid = UUID.timestamp_create.to_s
  end
end
