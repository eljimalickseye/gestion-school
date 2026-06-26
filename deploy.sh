#!/bin/bash
#===============================================================================
# Deploiement Docker de Gestion Ecole sur VPS
# Usage: bash deploy.sh
#===============================================================================

set -e

# Configuration
SERVER_IP="180.149.199.233"
SERVER_USER="root"
SERVER_PASS="GmGZVMa4C"
REMOTE_DIR="/root/gestion_ecole"
DOCKER_COMPOSE_FILE="docker-compose.yml"
ENV_FILE=".env"

echo "=========================================="
echo "  Deploiement Gestion Ecole - Docker"
echo "=========================================="

# 1. Copy files to server
echo ">>> Copie des fichiers vers le serveur..."
sshpass -p "$SERVER_PASS" scp -o StrictHostKeyChecking=no -r \
    Dockerfile \
    docker-compose.yml \
    gestion_ecole.war \
    init.sql \
    .env \
    "$SERVER_USER@$SERVER_IP:$REMOTE_DIR/"

# 2. SSH into server and deploy
echo ">>> Deploiement sur le serveur..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_IP" << 'EOF'
    set -e
    cd /root/gestion_ecole

    echo "[SERVER] Arret des conteneurs existants..."
    docker-compose down || true

    echo "[SERVER] Nettoyage des anciennes images..."
    docker system prune -af || true

    echo "[SERVER] Construction de l'image Docker de l'application..."
    docker-compose build --no-cache

    echo "[SERVER] Demarrage des conteneurs..."
    docker-compose up -d

    echo "[SERVER] Verification des conteneurs..."
    docker ps

    echo "[SERVER] Attente du demarrage de l'application (30s)..."
    sleep 30

    echo "[SERVER] Verification des logs de l'application..."
    docker-compose logs --tail=50 app
EOF

echo "=========================================="
echo "  Deploiement termine avec succes !"
echo "=========================================="
echo ""
echo "Application: http://$SERVER_IP:8181"
echo "Base de donnees: MySQL sur port 3307 (externe)"
echo ""
echo "Commandes utiles:"
echo "  - Voir les logs:          docker-compose logs -f"
echo "  - Redemarrer:             docker-compose restart"
echo "  - Arreter:                docker-compose down"
echo "  - Connexion MySQL:        docker exec -it gestion_ecole_mysql mysql -u root -p"
echo "=========================================="