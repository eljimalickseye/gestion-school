# Gestion School

Application de gestion scolaire déployée avec Docker.

## Structure
```
gestion_ecole-docker/
├── Dockerfile              # Image Docker (Java 17, Spring Boot)
├── docker-compose.yml      # MySQL 8.0 + Application
├── gestion_ecole.war       # Application Spring Boot
├── init.sql                # Initialisation base de données
├── .env                    # Variables d'environnement
├── .dockerignore
├── deploy.sh               # Script de déploiement
└── README.md
```

## Déploiement sur VPS

```bash
# Depuis le VPS
cd ~/gestion_ecole
docker compose build --no-cache
docker compose up -d
```

- **Application** : http://180.149.199.233:8181
- **MySQL** : port 3307