class HomeController < ApplicationController
  def index
    @personas = Persona.all
  end
end
