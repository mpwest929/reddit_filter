class FilterController < ApplicationController
  def get
    debugger
	  render :status => 200, :json => {}.to_json
  end

  def create
    debugger
	  render :status => 201, :json => {}.to_json
  end

  def update
    debugger
	  render :status => 201, :json => {}.to_json
  end
end
