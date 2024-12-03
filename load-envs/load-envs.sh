# 許可された環境のリスト
ALLOWED_ENVS=("development" "staging" "production")

# スクリプトのディレクトリを取得
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# APP_ENVのセキュリティチェック
if [[ -z "${APP_ENV}" ]]; then
  echo "Error: APP_ENV is not set."
  exit 1
fi

# APP_ENVが許可された値かどうかを確認
if [[ ! " ${ALLOWED_ENVS[@]} " =~ " ${APP_ENV} " ]]; then
  echo "Error: APP_ENV '${APP_ENV}' is not allowed."
  exit 1
fi

# .env.${APP_ENV}から環境変数を読み込む
set -a  # 自動エクスポートを有効化
source "${SCRIPT_DIR}/.env"
source "${SCRIPT_DIR}/.env.${APP_ENV}"
set +a  # 自動エクスポートを無効化

# 渡されたコマンドを実行
exec "$@" 