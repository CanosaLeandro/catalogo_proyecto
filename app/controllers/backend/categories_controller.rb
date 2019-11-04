module Backend
  class ProductsController < BackendController

    before_action :set_product, only: [
      :show,
      :edit,
      :update,
      :destroy
    ]
    def index
      @products = Product.all
    end

    def show; end

    def new
      @product = Product.new
      render :modal
    end

    def edit
      render :modal
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        flash.now[:notice] = 'Categoría creada'
      else
        flash.now[:alert] = 'Error creando categoría'
        render :modal
      end
    end

    def update
      if @product.update(product_params)
        flash.now[:notice] = 'Categoría modificada'
      else
        flash.now[:alert] = 'Error modificando categoría'
        render :modal
      end
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name)
    end
  end
end
