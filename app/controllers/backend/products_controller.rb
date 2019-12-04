# frozen_string_literal: true

module Backend
  class ProductsController < BackendController
    before_action :set_product, only: %i[
      show
      edit
      update
      destroy
    ]
    before_action :authorize_product
    def index
      @presenter = ProductPresenter.new(params)
    end

    def show; end

    def new
      @product = Product.new
    end

    def edit; end

    def create
      @product = Product.new(product_params)
      if @product.save
        flash.now[:notice] = '#Usar i18n'
        redirect_to backend_products_path
      else
        flash.now[:alert] = @product.decorate.errores
        render :new
      end
    end

    def update
      if @product.update(product_params)
        flash.now[:notice] = '#Usar i18n'
        redirect_to backend_products_path
      else
        flash.now[:alert] = '#Usar i18n'
        render :edit
      end
    end

    def destroy
      @product.destroy
      flash[:notice] = '#Usar i18n'
      redirect_to backend_products_path
    end

    private

    def authorize_product
      authorize! :authorize_product, :backendProductController
    end

    def set_product
      @product = Product.find(params[:id]).decorate
    end

    def product_params
      params.require(:product).permit(
        :name,
        :description,
        :active,
        :code,
        :price,
        :cost,
        :category_id,
        tag_ids: [],
        product_images_attributes: %i[
          id
          image
          principal
          _destroy
        ]
      )
    end
  end
end
