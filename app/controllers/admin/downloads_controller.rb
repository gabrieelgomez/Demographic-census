module Admin
  # DownloadsController
  class DownloadsController < AdminController
    before_action :set_download, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /downloads
    def index
      @q = Download.ransack(params[:q])
      downloads = @q.result(distinct: true)
      @objects = downloads.page(@current_page)
      @total = downloads.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to downloads_path(page: @current_page.to_i.pred, search: @query)
      end
      @downloads = Download.all
      respond_to do |format|
        format.html
        # format.xls { send_data(@downloads.to_xls) }
      end
    end

    # GET /downloads/1
    def show
    end

    # GET /downloads/new
    def new
      @download = Download.new
    end

    # GET /downloads/1/edit
    def edit
    end

    # POST /downloads
    def create
      @download = Download.new(download_params)

      if @download.save
        redirect_to admin_downloads_path
      else
        render :new
      end
    end

    # PATCH/PUT /downloads/1
    def update
      if @download.update(download_params)
        redirect_to admin_downloads_path
      else
        render :edit
      end
    end

    def clone
      @download = Download.clone_record params[:download_id]

      if @download.save
        redirect_to admin_downloads_path
      else
        render :new
      end
    end

    # DELETE /downloads/1
    def destroy
      @download.destroy
      redirect_to admin_downloads_path, notice: actions_messages(@download)
    end

    def destroy_multiple
      Download.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_downloads_path(page: @current_page, search: @query),
        notice: actions_messages(Download.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def download_params
      params.require(:download).permit(:pdf, :title, :description)
    end

    def show_history
      get_history(Download)
    end
  end
end
