module TweetManagerHelper
  def mock_user
    mock_user = double('Twitter user')
    mock_client = Class.new do
      def self.update(content)
        content
      end
    end
    allow(mock_user).to receive(:client).and_return(mock_client)
    mock_user
  end
end
