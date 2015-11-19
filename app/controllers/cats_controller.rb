class CatsController < ApplicationController
  before_action :ensure_logged_in_to_register_cat, only: [:new, :create]
  before_action :ensure_current_user_is_cat_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def create
    @cat = current_user.cats.new(cat_params)
    if @cat.save
      render :show
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def new
    @cat = Cat.new
    render :new
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cat_params
    attributes = [:name, :birth_date, :color, :sex, :description]
    params.require(:cat).permit(attributes)
  end

  def ensure_logged_in_to_register_cat
    redirect_to new_session_url unless current_user
  end
end
