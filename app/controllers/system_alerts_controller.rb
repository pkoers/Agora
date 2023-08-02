class SystemAlertsController < ApplicationController
  before_action :set_system_alert, only: %i[ show edit update destroy ]

  # GET /system_alerts or /system_alerts.json
  def index
    @system_alerts = SystemAlert.all
  end

  # GET /system_alerts/1 or /system_alerts/1.json
  def show
  end

  # GET /system_alerts/new
  def new
    @system_alert = SystemAlert.new
  end

  # GET /system_alerts/1/edit
  def edit
  end

  # POST /system_alerts or /system_alerts.json
  def create
    @system_alert = SystemAlert.new(system_alert_params)

    respond_to do |format|
      if @system_alert.save
        format.html { redirect_to system_alert_url(@system_alert), notice: "System alert was successfully created." }
        format.json { render :show, status: :created, location: @system_alert }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @system_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_alerts/1 or /system_alerts/1.json
  def update
    respond_to do |format|
      if @system_alert.update(system_alert_params)
        format.html { redirect_to system_alert_url(@system_alert), notice: "System alert was successfully updated." }
        format.json { render :show, status: :ok, location: @system_alert }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @system_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_alerts/1 or /system_alerts/1.json
  def destroy
    # @system_alert.destroy
    SystemAlert.destroy_all

    respond_to do |format|
      format.html { redirect_to system_alerts_url, notice: "System alerts were successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_alert
      @system_alert = SystemAlert.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def system_alert_params
      params.require(:system_alert).permit(:alert_id, :alert_content)
    end
end
