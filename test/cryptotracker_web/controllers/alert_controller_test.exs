defmodule CryptotrackerWeb.AlertControllerTest do
  use CryptotrackerWeb.ConnCase

  alias Cryptotracker.Notification

  @create_attrs %{lowAlert: true, price: 120.5, symbol: "some symbol"}
  @update_attrs %{lowAlert: false, price: 456.7, symbol: "some updated symbol"}
  @invalid_attrs %{lowAlert: nil, price: nil, symbol: nil}

  def fixture(:alert) do
    {:ok, alert} = Notification.create_alert(@create_attrs)
    alert
  end

  describe "index" do
    test "lists all alerts", %{conn: conn} do
      conn = get conn, alert_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Alerts"
    end
  end

  describe "new alert" do
    test "renders form", %{conn: conn} do
      conn = get conn, alert_path(conn, :new)
      assert html_response(conn, 200) =~ "New Alert"
    end
  end

  describe "create alert" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, alert_path(conn, :create), alert: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == alert_path(conn, :show, id)

      conn = get conn, alert_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Alert"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, alert_path(conn, :create), alert: @invalid_attrs
      assert html_response(conn, 200) =~ "New Alert"
    end
  end

  describe "edit alert" do
    setup [:create_alert]

    test "renders form for editing chosen alert", %{conn: conn, alert: alert} do
      conn = get conn, alert_path(conn, :edit, alert)
      assert html_response(conn, 200) =~ "Edit Alert"
    end
  end

  describe "update alert" do
    setup [:create_alert]

    test "redirects when data is valid", %{conn: conn, alert: alert} do
      conn = put conn, alert_path(conn, :update, alert), alert: @update_attrs
      assert redirected_to(conn) == alert_path(conn, :show, alert)

      conn = get conn, alert_path(conn, :show, alert)
      assert html_response(conn, 200) =~ "some updated symbol"
    end

    test "renders errors when data is invalid", %{conn: conn, alert: alert} do
      conn = put conn, alert_path(conn, :update, alert), alert: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Alert"
    end
  end

  describe "delete alert" do
    setup [:create_alert]

    test "deletes chosen alert", %{conn: conn, alert: alert} do
      conn = delete conn, alert_path(conn, :delete, alert)
      assert redirected_to(conn) == alert_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, alert_path(conn, :show, alert)
      end
    end
  end

  defp create_alert(_) do
    alert = fixture(:alert)
    {:ok, alert: alert}
  end
end
