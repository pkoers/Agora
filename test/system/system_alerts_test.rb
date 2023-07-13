require "application_system_test_case"

class SystemAlertsTest < ApplicationSystemTestCase
  setup do
    @system_alert = system_alerts(:one)
  end

  test "visiting the index" do
    visit system_alerts_url
    assert_selector "h1", text: "System alerts"
  end

  test "should create system alert" do
    visit system_alerts_url
    click_on "New system alert"

    fill_in "Alert content", with: @system_alert.alert_content
    fill_in "Alert", with: @system_alert.alert_id
    click_on "Create System alert"

    assert_text "System alert was successfully created"
    click_on "Back"
  end

  test "should update System alert" do
    visit system_alert_url(@system_alert)
    click_on "Edit this system alert", match: :first

    fill_in "Alert content", with: @system_alert.alert_content
    fill_in "Alert", with: @system_alert.alert_id
    click_on "Update System alert"

    assert_text "System alert was successfully updated"
    click_on "Back"
  end

  test "should destroy System alert" do
    visit system_alert_url(@system_alert)
    click_on "Destroy this system alert", match: :first

    assert_text "System alert was successfully destroyed"
  end
end
