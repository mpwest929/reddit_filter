class FilterItem < ActiveRecord::Base
  belongs_to :filters

  validates :subreddit, :presence => true
  validates :weight, :presence => true
  validates :filter_id, :presence => true
end
