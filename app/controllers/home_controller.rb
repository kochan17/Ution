class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @personas = Persona.all
  end
end
