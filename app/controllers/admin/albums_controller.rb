module Admin
  # AlbumsController
  class AlbumsController < AdminController
    before_action :set_album, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /albums
    def index
      @q = Album.ransack(params[:q])
      albums = @q.result(distinct: true)
      @objects = albums.page(@current_page)
      @total = albums.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to albums_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /albums/1
    def show
    end

    # GET /albums/new
    def new
      @album = Album.new
    end

    # GET /albums/1/edit
    def edit
    end

    # POST /albums
    def create
      @album = Album.new(album_params)
      if @album.save
        if params.key?('_add_other')
          redirect_to new_admin_album_path, notice: actions_messages(@album)
        else
          redirect_to admin_albums_path
        end
      else
        render :new
      end
    end

    # PATCH/PUT /albums/1
    def update
      if @album.update(album_params)
        if params.key?('_add_other')
          redirect_to new_admin_album_path, notice: actions_messages(@album)
        else
          redirect_to admin_albums_path
        end
      else
        render :edit
      end
    end

    def clone
      @album = Album.clone_record params[:album_id]

      if @album.save
        redirect_to admin_albums_path
      else
        render :new
      end
    end

    # DELETE /albums/1
    def destroy
      @album.destroy
      redirect_to admin_albums_path, notice: actions_messages(@album)
    end

    def destroy_multiple
      Album.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_albums_path(page: @current_page, search: @query),
        notice: actions_messages(Album.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.require(:album).permit(:cover, :title)
    end

    def show_history
      get_history(Album)
    end
  end
end
