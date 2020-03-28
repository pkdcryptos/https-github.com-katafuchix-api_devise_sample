# v1, v2でつかう、APIによるユーザー作成とログイン時のパラメータ検証フォーム
class UserForm
  include ActiveModel::Model
  include ::UserFormValidation::Methods

  attr_accessor :id, :email, :password, :authentication_token

  validates :id, :password, presence: true

	def initialize(attrs = {})
		super
	end

	# 新規作成のとき
  with_options on: :users_create do |m|
    m.validates :email, :password, presence: true
    m.validates :password, length: { minimum: 4 }, if: :password
  end

	# 共通のカスタムバリデーションが複数のコンテキストにあるときは以下にまとめて定義
  # @note 最後に読み込まれたコンテキストで上書きされてしまうため
  validate :email_uniqueness?, on: [:users_create]
end