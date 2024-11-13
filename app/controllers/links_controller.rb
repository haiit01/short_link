class LinksController < ApplicationController
  before_action :validate_url, only: :encode

  def encode
    short_url = generate_short_url
    new_link = Link.create(original_url:, short_url:)

    if new_link.persisted?
      render json: { short_url: }
    else
      render json: { error: "Unable to create short link" }, status: :internal_server_error
    end
  end

  def decode
    link = Link.find_by(short_url: params[:short_link])

    if link.present?
      render json: { original_url: link.original_url }
    else
      render json: { error: "Not Found" }, status: :not_found
    end
  end

  private

  def original_url
    @original_url ||= params[:original_link]
  end

  def validate_url
    uri = URI.parse(original_url)

    if !uri.is_a?(URI::HTTP) || original_url.include?(request.host)
      render json: { error: "URL is invalid" }, status: :bad_request
    end
  rescue URI::InvalidURIError
    render json: { error: "URL is invalid" }, status: :bad_request
  end

  def generate_short_url
    loop do
      short_url_code = Link.generate_short_code
      short_url_new = "#{request.base_url}/#{short_url_code}"

      break short_url_new unless Link.exists?(short_url: short_url_new)
    end
  end
end
