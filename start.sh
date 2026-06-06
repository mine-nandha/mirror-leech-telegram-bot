bash aria-nox-nzb.sh 2>/dev/null || true
python3 update.py
echo "$TOKEN_PICKLE_B64" | base64 -d > /app/token.pickle 2>/dev/null
echo "$RCLONE_CONF_B64" | base64 -d > /app/rclone.conf 2>/dev/null
python3 -m bot
