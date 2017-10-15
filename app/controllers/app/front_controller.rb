module App
  # FrontsController
  class FrontController < AppController
    layout 'layouts/templates/application'
    before_action :set_categoria
    before_action :set_order_category
    before_action :set_ransack_params, :except => :directorio

    def index
      @banners = Banner.all
      @posts_carousel = KepplerBlog::Post.last(3)
      @albums = Album.last(3)
    end

    def directorio
      @list = false
      @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
      @param = params[:category]

      if params[:q]
        params[:letter] = nil
      end

      if params[:letter].nil?
        @q = Shop.ransack(params[:q])
        tiendas = @q.result(distinct: true).page(params[:page])
        @tiendas = tiendas.per(20).order(name: :asc)
      else
        if params[:letter].eql?('#')
          @q = Shop.ransack(params[:letter])
          tiendas = Shop.where("name REGEXP '^[0-9]'").page(params[:page])
          @tiendas = tiendas.order(name: :asc)
        else
          @q = Shop.ransack(:name_start => params[:letter])
          tiendas = @q.result(distinct: true).page(params[:page])
          @tiendas = tiendas.order(name: :asc)
        end
      end

      if !params[:q].nil? or !@param.nil?
        @list = true
      else
        @list = false
      end

      # if !@letter.nil?
      #   @list = true
      # else
      #   @list = false
      # end


      @count = tiendas.count
      # @tiendas = tiendas
      @tiendas = tiendas.page(params[:page]).per(20).order(name: :asc)
      #@categorias = categorias.page(params[:page]).per(4)

    end

    def category
      @list = false
      @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
      @param = params[:category]
      @letter = params[:letter]

      params[:q] = nil
      params[:letter] = nil
      # @tiendas = Shop.all.where(category_id: :category_id).order(name: :asc)
      @tiendas = @categoria_shop.order(name: :asc)

      @list = true

      @count = @tiendas.count
    end

    def ubicacion
      @message = KepplerContactUs::Message.new
    end

    def somos
    end

    def gallery
      @albums = Album.all
      @photos = Photo.where(album_id: params[:album])
    end

    def albums
      @albums = Album.all
    end

    private

    def set_order_category
      @categories = Category.order(:name)
    end

    def set_categoria
      @categoria_shop = Shop.where(params[:category_id])
    end

    def set_ransack_params
      @q = Shop.ransack(params[:q])

      if !params[:q].nil?
        redirect_to :action => :directorio, :q => params[:q]
      end
    end
  end
end
