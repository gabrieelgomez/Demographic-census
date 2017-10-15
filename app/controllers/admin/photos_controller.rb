module Admin
  # PhotosController
  class PhotosController < AdminController
    before_action :set_album
    before_action :set_photo, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /photos
    def index
      @q = Photo.ransack(@album_photo)
      photos = @q.result(distinct: true).where(album_id: @album_photo)
      @objects = photos.page(@current_page)
      @total = photos.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to admin_album_photos_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /photos/1
    def show
    end

    # GET /photos/new
    def new
      @photo = Photo.new(album_id: params[:album_id])
    end

    # GET /photos/1/edit
    def edit
    end

    # POST /photos
    def create
      @photo = Photo.new(photo_params)
      @photo.album_id = @album_photo.id
      if @photo.save
        if params.key?('_add_other')
          redirect_to new_admin_album_photo_path, notice: actions_messages(@photo)
        else
          redirect_to admin_album_photos_path
        end
      else
        render :new
      end
    end

    # PATCH/PUT /photos/1
    def update
      if @photo.update(photo_params)
        if params.key?('_add_other')
          redirect_to new_admin_album_photo_path, notice: actions_messages(@photo)
        else
          redirect_to admin_album_photos_path
        end
      else
        render :edit
      end
    end

    def clone
      @photo = Photo.clone_record params[:photo_id]

      if @photo.save
        redirect_to admin_album_photos_path
      else
        render :new
      end
    end

    # DELETE /photos/1
    def destroy
      @photo.destroy
      redirect_to admin_album_photos_path, notice: actions_messages(@photo)
    end

    def destroy_multiple
      Photo.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_album_photos_path(page: @current_page, search: @query),
        notice: actions_messages(Photo.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_album
      @album_photo = Album.find(params[:album_id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:picture)
    end

    def show_history
      get_history(Photo)
    end
  end
end
