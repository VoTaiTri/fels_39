class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page], per_page: 10
    @total = Category.all.count
  end

  def show
    @category = Category.find params[:id]
  end

  def edit
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "New category created!"
      redirect_to admin_categories_path
    else
      redirect_to new_admin_category_path
    end
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      flash[:success] = "Category updated!"
      redirect_to edit_admin_category_path(@category)
    else
      redirect_to edit_admin_category_path(@category)
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    flash[:success] = "Category deleted!"
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :title, :body
  end    
end