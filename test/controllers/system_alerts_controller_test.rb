require "test_helper"

class SystemAlertsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_alert = system_alerts(:one)
  end

  test "should get index" do
    get system_alerts_url
    assert_response :success
  end

  test "should get new" do
    get new_system_alert_url
    assert_response :success
  end

  test "should create system_alert" do
    assert_difference("SystemAlert.count") do
      post system_alerts_url, params: { system_alert: { alert_content: @system_alert.alert_content, alert_id: @system_alert.alert_id } }
    end

    assert_redirected_to system_alert_url(SystemAlert.last)
  end

  test "should show system_alert" do
    get system_alert_url(@system_alert)
    assert_response :success
  end

  test "should get edit" do
    get edit_system_alert_url(@system_alert)
    assert_response :success
  end

  test "should update system_alert" do
    patch system_alert_url(@system_alert), params: { system_alert: { alert_content: @system_alert.alert_content, alert_id: @system_alert.alert_id } }
    assert_redirected_to system_alert_url(@system_alert)
  end

  test "should destroy system_alert" do
    assert_difference("SystemAlert.count", -1) do
      delete system_alert_url(@system_alert)
    end

    assert_redirected_to system_alerts_url
  end
end
