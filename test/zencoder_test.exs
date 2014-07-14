defmodule ZencoderTest do
  use ExUnit.Case

  setup context do

    if env_url = context[:env_url] do
      System.put_env("ZENCODER_BASE_URL", env_url)
    end

    if env_api_key = context[:env_api_key] do
      System.put_env("ZENCODER_API_KEY", env_api_key)
    end

    on_exit fn ->
      Zencoder.base_url(nil)
      Zencoder.api_key(nil)
      System.delete_env("ZENCODER_BASE_URL")
      System.delete_env("ZENCODER_API_KEY")
    end

    :ok
  end

  test "gets default base_url" do
    assert "https://app.zencoder.com/api/v2" == Zencoder.base_url
  end

  @tag env_url: "https://app.zencoder.com/api/v1"
  test "gets base_url from environment" do
    assert "https://app.zencoder.com/api/v1" == Zencoder.base_url
  end

  test "sets base_url" do
    assert "https://app.zencoder.com/api/v2" == Zencoder.base_url
    Zencoder.base_url "http://example.com"
    assert "http://example.com" == Zencoder.base_url
  end

  @tag env_api_key: "some-api-key"
  test "gets api_key from environment" do
    assert "some-api-key" == Zencoder.api_key
  end

  test "sets api_key" do
    assert nil == Zencoder.api_key
    Zencoder.api_key "api-key"
    assert "api-key" == Zencoder.api_key
  end

end