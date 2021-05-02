require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Line < OmniAuth::Strategies::OAuth2

      option :scope, 'profile openid email'

      option :client_options, {
        site: 'https://api.line.me',
        authorize_url: "https://access.line.me/oauth2/v2.1/authorize",
        token_url: '/oauth2/v2.1/token'
      }

      uid do
        raw_info['userId']
      end

      info do
        prune({
          'user_id'     => raw_info['userId'],
          'email'       => email,
          'picture_url' => raw_info['pictureUrl'],
        })
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.line.me/v2/profile').parsed || {}
      end

      private

      # nonceをリクエストパラメータに追加するためoverride
      def authorize_params
        super.tap do |params|
          params[:nonce] = SecureRandom.uuid
          session["omniauth.nonce"] = params[:nonce]
        end
      end

      # デフォルトだとクエリパラメータがついてエラーになるのでoverride
      def callback_url
        full_host + script_name + callback_path
      end

      def email
        verify_id_token['email']
      end

      def verify_id_token
        @id_token_payload ||= client.request(:post, 'https://api.line.me/oauth2/v2.1/verify',
          {
            body: {
              client_id: options.client_id,
              id_token:  access_token['id_token'],
              user_id:   raw_info['userId'],
              nonce:     session.delete("omniauth.nonce")
            }
          }
        ).parsed
        
        @id_token_payload
      end

      def prune(hash)
        hash.reject { |_, v| v.blank? }
      end
    end
  end
end
