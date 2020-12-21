class PageController < ApplicationController
  def index
    @page = Page.find_by(code:)
  end
end
