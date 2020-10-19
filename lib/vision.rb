require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(profile_image)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード
      base64_image = Base64.encode64(open("#{Rails.root}/tmp/uploads/store/#{profile_image.id}").read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'SAFE_SEARCH_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      # APIレスポンス出力
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      p JSON.parse(response.body)['responses'][0]['safeSearchAnnotation']

    end
  end
end