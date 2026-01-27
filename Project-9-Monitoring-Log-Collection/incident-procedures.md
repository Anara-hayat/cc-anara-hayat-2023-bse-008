# Incident Procedures

## Procedure 1: App Server Down (Nginx Stopped)

**Check status:**
ssh -i ~/.ssh/project9-key ubuntu@10.0.10.25
sudo systemctl status nginx

**Restart:**
sudo systemctl start nginx
sudo systemctl status nginx

## Procedure 2: High CPU Usage

**Check what's using CPU:**
top -bn1 | head -20

**Kill process if needed:**
kill -9 <PID>

## Procedure 3: Health Check Failing

**Manual test:**
curl http://10.0.10.25/health

**Check Nginx:**
sudo systemctl status nginx
