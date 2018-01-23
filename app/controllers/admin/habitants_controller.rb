module Admin
  # HabitantsController
  class HabitantsController < AdminController
    before_action :set_habitant, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /habitants
    def index
      @q = Habitant.ransack(params[:q])
      habitants = @q.result(distinct: true).order(:identification)
      @objects = habitants.page(@current_page)
      @total = habitants.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to habitants_path(page: @current_page.to_i.pred, search: @query)
      end
      @habitants = Habitant.all
      respond_to do |format|
        format.html
        format.xls { send_data(@habitants.to_xls) }
      end
    end

    # GET /habitants/1
    def show
    end

    # GET /habitants/new
    def new
      @habitant = Habitant.new
    end

    # GET /habitants/1/edit
    def edit
    end

    # POST /habitants
    def create
      @habitant = Habitant.new(habitant_params)
      if @habitant.save
        if params.key?('_add_other')
          redirect_to new_admin_album_habitant_path, notice: actions_messages(@habitant)
        else
          redirect_to admin_habitants_path
        end
      else
        render :new
      end
    end

    # PATCH/PUT /habitants/1
    def update
      if @habitant.update(habitant_params)
        redirect(@habitant, params)
      else
        render :edit
      end
    end

    def clone
      @habitant = Habitant.clone_record params[:habitant_id]

      if @habitant.save
        redirect_to admin_habitants_path
      else
        render :new
      end
    end

    # DELETE /habitants/1
    def destroy
      @habitant.destroy
      redirect_to admin_habitants_path, notice: actions_messages(@habitant)
    end

    def destroy_multiple
      Habitant.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_habitants_path(page: @current_page, search: @query),
        notice: actions_messages(Habitant.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_habitant
      @habitant = Habitant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def habitant_params
      params.require(:habitant).permit(:identification, :full_name, :phone, :email, :address)
    end

    def show_history
      get_history(Habitant)
    end
  end
end
