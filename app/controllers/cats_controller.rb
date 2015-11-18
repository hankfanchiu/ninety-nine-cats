class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      render :show
    else
      render :new
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def destroy
    # redirect
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      render :show
    else
      redirect_to edit_cat_url(@cat)
    end
  end

  private
  def cat_params
    attributes = [:name, :birth_date, :color, :sex, :description]
    params.require(:cat).permit(attributes)
  end
end
