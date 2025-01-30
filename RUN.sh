#!/bin/bash
# Curitiba 30 de Janeiro de 2025
# Editor Jeverson Dias da Silva ........Youtuba/@JCGAMESCLASSICOS
clear
sleep 1

######


echo "IMPLEMENTAÇÃO DO COMANDO UP by @JCGAMESCLASSICOS"
sleep 4
echo "COMANDO CRIA UMA ESTRUTURA ADICIONAL PARA QUE ALGUNS GAMES PASSEM A RODAR NO SISTEMA..."
sleep 5
echo -e "INSTALAÇÃO EM 10 SEGUNDOS OU \033[1;31m[CTRL+C]\033[0m PARA ABORTAR A INSTALAÇÃO"
sleep 5
clear
clear
echo "EM 10"
sleep 1
clear
echo "EM 9"
sleep 1
clear
echo "EM 8"
sleep 1
clear
echo "EM 7"
sleep 1
clear
echo "EM 6"
sleep 1
clear
echo "EM 5"
sleep 1
clear
echo "EM 4"
sleep 1
clear
echo "EM 3"
sleep 1
clear
echo "EM 2"
sleep 1
clear
echo "EM 1"
sleep 1
clear

##
echo ""
echo -e "\033[1;32mDETECTANDO A VERSÃO DO SISTEMA\033[0m"
sleep 0.5
clear
sleep 0.5
echo ""
echo -e "\033[1;32mDETECTANDO A VERSÃO DO SISTEMA\033[0m"
sleep 0.5
clear
sleep 0.5
echo ""
echo -e "\033[1;32mDETECTANDO A VERSÃO DO SISTEMA\033[0m"
sleep 0.5
clear
sleep 0.5
echo ""
echo -e "\033[1;32mDETECTANDO A VERSÃO DO SISTEMA\033[0m"
sleep 0.5
clear
sleep 0.5
echo ""
echo -e "\033[1;32mDETECTANDO A VERSÃO DO SISTEMA\033[0m"
sleep 0.5
clear
sleep 0.5
##

clear
echo "DETECTADO!"

######


# Caminho do arquivo onde a versão está localizada
file_path="/userdata/system/data.version"

# Verifica se o arquivo existe
if [ ! -f "$file_path" ]; then
    echo "Arquivo não encontrado!"
    exit 1
fi

# Lê o conteúdo do arquivo
line=$(cat "$file_path")

# Extrai o primeiro número de dois dígitos
version=$(echo "$line" | grep -oP '\b\d{2}\b' | head -n 1)

# Verifica se a versão foi encontrada
if [ -n "$version" ]; then
    sleep 2
    echo "Versão detectada: $version"
    sleep 2    
    # Função para configurar o ambiente, comum para versões 40 e 41
    configure_environment() {
        mkdir -p "/userdata/system/.dev"
        mkdir -p "/userdata/system/wine/custom"
        
        # Baixar o arquivo com as dependências do GitHub em segundo plano
        echo -e "\033[1;32mBaixando os arquivos...\033[0m"  # Verde limão em negrito
        curl -L -o "/userdata/system/.dev/OS_v1.0" "https://github.com/JeversonDiasSilva/my/releases/download/v1.0/OS_V1.1" > /dev/null 2>&1 &
        
        # Aguardar o download completar antes de prosseguir
        wait
        
        # Verificando se o arquivo foi baixado corretamente
        if [ ! -f "/userdata/system/.dev/OS_v1.0" ]; then
            echo "Erro: O arquivo OS_v1.0 não foi baixado corretamente."
            exit 1
        fi

        # Entrar na pasta onde foi baixado
        cd "/userdata/system/.dev"

        # Extrair o arquivo OS_v1.0
        echo -e "\033[1;32mDescompactando o arquivo...\033[0m"  # Verde limão em negrito
        unsquashfs -d scripts OS_v1.0 > /dev/null 2>&1 &
                
        # Aguardar o download completar antes de prosseguir
        wait


        # Verifica se a pasta 'scripts' foi criada
        if [ ! -d "scripts" ]; then
            echo "Erro: A pasta 'scripts' não foi criada durante a extração."
            exit 1
        fi

        # Excluir o arquivo após extração
        rm OS_v1.0

        # Verifica se a versão é 40, e se for, exclui a pasta ge-custom
        if [ "$version" == "40" ]; then
            #echo "Versão 40 detectada, excluindo pasta ge-custom..."
            if [ -d "scripts/ge-custom" ]; then
                rm -rf scripts/ge-custom
                #echo "Pasta ge-custom excluída."
            else
                echo "Pasta ge-custom não encontrada."
            fi
        fi

        cd scripts
        mv wine .wine
        mv ge-custom ~/wine/custom > /dev/null 2>&1 &
        mv Proton-GE-Proton7-42 ~/wine/custom > /dev/null 2>&1 &
        chmod +x up
        mv up /usr/bin
    }

    # Se a versão for 41 ou 40, executa a configuração
    if [ "$version" == "41" ]; then
        configure_environment
    elif [ "$version" == "40" ]; then
        configure_environment
    else
        echo "Versão detectada não é a 40 ou 41."
        exit 1
    fi

    echo -e "\033[1;32mProcesso de instalação concluído! [100%/100]\033[0m"  # Verde limão em negrito

else
    echo "Nenhuma versão válida encontrada no arquivo."
    exit 1
fi
