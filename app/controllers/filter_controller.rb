class FilterController < ApplicationController
  def get
	  render :status => 200, :json => {}.to_json
  end

  def create
	  render :status => 201, :json => {}.to_json
  end

  def update
	  render :status => 201, :json => {}.to_json
  end
end
