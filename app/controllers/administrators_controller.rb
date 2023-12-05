class AdministratorsController < ApplicationController
  before_action :set_administrator, only: %i[ show edit update destroy ]

  # GET /administrators or /administrators.json
  def index
    @administrators = Administrator.all
  end

  # GET /administrators/1 or /administrators/1.json
  def show
  end

  # GET /administrators/new
  def new
    @administrator = Administrator.new
  end

  # GET /administrators/1/edit
  def edit
  end

  # POST /administrators or /administrators.json
  def create
    @administrator = Administrator.new(administrator_params)

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to administrator_url(@administrator), notice: "Administrator was successfully created." }
        format.json { render :show, status: :created, location: @administrator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administrators/1 or /administrators/1.json
  def update
    respond_to do |format|
      if @administrator.update(administrator_params)
        format.html { redirect_to administrator_url(@administrator), notice: "Administrator was successfully updated." }
        format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1 or /administrators/1.json
  def destroy
    # Find the associated user
    user = @administrator.user if @administrator

    if @administrator
      @administrator.destroy
      flash[:notice] = "Administrator and associated user were successfully destroyed."
    else
      flash[:alert] = "Administrator not found."
    end

    # Delete the associated user
    if user
      user.destroy
    else
      flash[:alert] = "Associated user not found."
    end

      respond_to do |format|
      format.html { redirect_to administrators_url }
      format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def administrator_params
      params.require(:administrator).permit(:trusted, :user_id)
    end
end
