class SystemAlertsController < ApplicationController
  # before_action :set_system_alert, only: %i[show edit update], unless: :destroy_all?, except: :destroy_all

  # GET /system_alerts or /system_alerts.json
  def index
    @system_alerts = SystemAlert.all
  end

  # GET /system_alerts/1 or /system_alerts/1.json
  def show
    # set_system_alert
    redirect_to root_path
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

    # respond_to do |format|
    # redirect_to root_path
      # format.json { head :no_content }
    # end
    log_alert(1001, "System Alerts Log Reset")
    redirect_to root_path
  end

  def destroy_all?
    action_name == 'destroy_all'
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

    def log_alert(alert_id, alert_content)
      alert = SystemAlert.new
      alert.alert_id = alert_id
      alert.alert_content = alert_content
      alert.save
    end
end
