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

    # Define the Slack URL to send the POST request to
    url = URI.parse('https://hooks.slack.com/triggers/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')

     # Create a hash representing the JSON payload to send to Slack
     payload = {
      "Notification" => "[#{@system_alert.alert_id}] #{@system_alert.alert_content}"
    }
    # Convert the hash to JSON format
    json_payload = payload.to_json
    # Create a new HTTP POST request
    request = Net::HTTP::Post.new(url.path)
    # Set the request headers to indicate that you are sending JSON data
    request.content_type = 'application/json'
    request['Accept'] = 'application/json'
    # Set the request body to the JSON payload
    request.body = json_payload
    # Create an HTTP object and send the request
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    response = http.request(request)
    # Check the response
    if response.code == '200'
      # Successful response
      puts "Response: #{response.body}"
    else
      # Handle error
      puts "Error: #{response.code} - #{response.message}"
    end

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
