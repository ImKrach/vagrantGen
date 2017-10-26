#!/bin/bash
VIOLET='\033[0;35m'
VERT='\033[0;32m'
BLEU='\033[0;34m'
GRIS='\033[0;37m'
ROUGE='\033[0;31m'
NORMAL='\033[0m'

clear
echo -e "${NORMAL}********************************************************************************"
echo -e "${BLEU}Bienvenue dans l'assistant d'installation de Virtualbox et Vagrant"
echo -e "${NORMAL}********************************************************************************"
echo -e
echo -e "${NORMAL}***************************************************"
echo -e "${BLEU}Souhaitez-vous installer Virtualbox ? "
echo -e "${BLEU}\t 1. Oui"
echo -e "${BLEU}\t 2. Non"
read -p "Réponse : " installVirtualbox
echo -e "${NORMAL}***************************************************"
echo

case $installVirtualbox in

    #### Oui ####
    1)
        # On vérifie d'abord que Virtualbox n'est pas déjà installé sur la machine
        if vboxmanage --version > /dev/null 2>&1 ; then
            echo -e "${VERT}Virtualbox est déjà installé sur cette machine"
            echo
        else
            echo -e "${VERT}Téléchargement de Virtualbox"
            # On télécharge Virtualbox et on le renomme plus facilement
            wget http://download.virtualbox.org/virtualbox/5.1.30/virtualbox-5.1_5.1.30-118389~Debian~jessie_amd64.deb -O virtualbox.deb
            echo
            # Installation
            echo -e "${VERT}Installation de Virtualbox"
            sudo dpkg -i virtualbox.deb
            echo
            # Il y a probablement des dépendances à satisfaire
            echo -e "${VERT}Installation des dépendances"
            sudo apt-get -f install
            echo
        fi
        ;;

    #### Non ####
    2)
        # Si Virtualbox est bien installé, ça va on peut continuer le script
        if vboxmanage --version > /dev/null 2>&1 ; then
            echo -e "${VERT}Nous avons détecté une version de Virtualbox existante, l'assistant d'installation peut continuer"
            echo
        # Si Virtualbox n'a pas été installé, le script ne pourra continuer
        else
            echo -e "${ROUGE}Attention, Virtualbox n'est pas installé sur cette machine"
            echo -e "${ROUGE}Veuillez installer Virtualbox pour pouvoir poursuivre"
            exit 1
        fi
        ;;

    #### Erreur ####
    *)
        echo
        echo -e "${VERT} - Ketchup ou Mayo ? "
        echo -e "${VERT} - Euh.. Tee-shirt ! (°_°)' "
        echo -e "${VERT} - ..."
        echo
        exit 1
esac

# On fait la même chose pour vagrant
echo
echo -e "${NORMAL}***************************************************"
echo -e "${BLEU}Souhaitez-vous installer Vagrant ? "
echo -e "${BLEU}\t 1. Oui"
echo -e "${BLEU}\t 2. Non"
read -p "Réponse : " installVagrant
echo -e "${NORMAL}***************************************************"
echo

case $installVagrant in

    #### Oui ####
    1)
        # On vérifie d'abord que Vagrant n'est pas déjà installé sur la machine
        if vagrant -v > /dev/null 2>&1 ; then
            echo -e "${VERT}Vagrant est déjà installé sur cette machine"
            echo
        else
            echo -e "${VERT}Téléchargement de Vagrant"
            # On télécharge Vagrant et on le renomme plus facilement
            wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb?_ga=2.169290337.1704800389.1509020209-657065665.1508919921 -O vagrant.deb
            echo
            # Installation
            echo -e "${VERT}Installation de Vagrant"
            sudo dpkg -i vagrant.deb
            echo
            # Il y a probablement des dépendances à satisfaire
            echo -e "${VERT}Installation des dépendances"
            sudo apt-get -f install
            echo
        fi
        ;;

    #### Non ####
    2)
        # Si Vagrant est bien installé, ça va on peut continuer le script
        if vagrant -v > /dev/null 2>&1 ; then
            echo -e "${VERT}Nous avons détecté une version de Vagrant existante, l'assistant d'installation peut continuer"
            echo
        # Si Vagrant n'a pas été installé, le script ne pourra continuer
        else
            echo -e "${ROUGE}Attention, Vagrant n'est pas installé sur cette machine"
            echo -e "${ROUGE}Veuillez installer Vagrant pour pouvoir poursuivre"
            exit 1
        fi
        ;;

    #### Erreur ####
    *)
        echo
        echo -e "${VERT} - Ketchup ou Mayo ? "
        echo -e "${VERT} - Euh.. Tee-shirt ! (°_°)' "
        echo -e "${VERT} - ..."
        echo
        exit 1
esac

# Fonction qui configure une box
function configureBox {
    echo
    echo -e "${NORMAL}***************************************************"
    echo -e "${BLEU}Souhaitez-vous configurer une nouvelle Vagrant box ? "
    echo -e "${BLEU}\t 1. Oui"
    echo -e "${BLEU}\t 2. Non"
    read -p "Réponse : " configureVagrant
    echo -e "${NORMAL}***************************************************"
    echo

    case $configureVagrant in
        1)
            # Il veut configurer une nouvelle box, c'est parti
            echo -e "${VERT}Initialisation du Vagrantfile..."

            # On vérifie qu'il n'y a pas déjà un Vagrantfile dans ce dossier
            if [ ! -f Vagrantfile ]; then
                vagrant init 1> /dev/null
                echo -e "${VERT}Le fichier Vagrantfile a été généré !"
            else
                # On quitte la fonction
                echo -e "${ROUGE}Un Vagrantfile existe déjà dans ce dossier !"
                return
            fi

            # On propose le choix de la box
            echo
            echo -e "${NORMAL}***************************************************"
            echo -e "${BLEU}Veuillez choisir votre box."
            echo -e "${BLEU}\t 1. xenial.box"
            echo -e "${BLEU}\t 2. ubuntu/xenial64 (en ligne)"
            read -p "Réponse : " box
            echo -e "${NORMAL}***************************************************"
            echo

            # En fonction de la saisie
            case $box in

                #### xenial.box ####
                1)
                # On remplace "base" par "xenial.box" (il n'existe qu'une occurrence de base dans le Vagrantfile par défaut donc c'est cool)
                sed -i -e 's/base/xenial\.box/g' Vagrantfile
                echo -e "${VERT}La box xenial.box est en place et sera utilisée au lancement"
                echo
                ;;

                #### xenial.box ####
                2)
                # On remplace "base" par "ubuntu/xenial64" (il n'existe qu'une occurrence de base dans le Vagrantfile par défaut donc c'est cool)
                sed -i -e 's/base/ubuntu\/xenial64/g' Vagrantfile
                echo -e "${VERT}La box ubuntu/xenial64 sera téléchargée au lancement"
                echo
                ;;

                #### Erreur ####
                *)
                echo -e "${VERT} - Ketchup ou Mayo ? "
                echo -e "${VERT} - Euh.. Tee-shirt ! (°_°)' "
                echo -e "${VERT} - ..."
                echo -e "${ROUGE}Annulation du processus de génération de Vagrantfile"
                rm Vagrantfile
                exit 1

            esac

            # Création du dossier host
            echo -e "${VERT}Choix du dossier host."
            read -p "Nom du dossier à utiliser (il sera créé si inexistant) : " dossierHost

            # Si le dossier existe deja pas besoin de le créer
            if [ ! -d "$dossierHost" ]; then
                echo -e "${VERT}Création du dossier host $dossierHost"
                mkdir $dossierHost
            fi

            # Si l'utilisateur n'a pas écrit de la merde
            if [[ $dossierHost =~ ^(/)?([^/\0]+(/)?)+$ ]]; then
                echo -e "${VERT}Personnalisation du dossier host $dossierHost"
                echo
                # On remplace ../data par $dossierHost
                sed -i -e "s,../data,$dossierHost,g" Vagrantfile
                # On décommente la ligne en question
                sed -i "/synced_folder/s/^  # /  /g" Vagrantfile
                # Il a écrit de la merde, on lui fait savoir
            else
                echo -e "${ROUGE}Nom de dossier incorrecte."
                echo -e "${ROUGE}Annulation du processus de génération de Vagrantfile"
                rm Vagrantfile
                exit 1
            fi

            # Choix du dossier guest
            echo -e "${VERT}Choix du dossier guest (chemin absolu + dossier, ex : /var/www ou /toto/src )."
            read -p "Nom du dossier guest : " dossierGuest

            # Si l'utilisateur n'a pas écrit de la merde
            if [[ $dossierGuest =~ ^(/)?([^/\0]+(/)?)+$ ]]; then
                echo -e "${VERT}Personnalisation du dossier guest $dossierGuest"
                echo
                # On remplace ../vagrant_data par $dossierGuest (dans cette syntaxe on utilise la ',' comme séparateur pour sed pour éviter de devoir '\' les '/' contenus dans $dossierGuest )
                sed -i -e "s,/vagrant_data,$dossierGuest,g" Vagrantfile
                # Il a écrit de la merde, on lui fait savoir
            else
                echo -e "${ROUGE}Nom de dossier incorrecte."
                echo -e "${ROUGE}Annulation du processus de génération de Vagrantfile"
                rm Vagrantfile
                exit 1
            fi

            # On décommente la ligne du private_network
            sed -i "/private_network/s/^  # /  /g" Vagrantfile

            # On démarre la box
            vagrant up

            ;;

        #### NON ####
        2)
            echo
            echo -e "${VERT}OK OK ! Viens pas te plaindre si t'es en galère après !"
            echo
            ;;

        #### Erreur ####
        *)
            echo
            echo -e "${VERT} - Ketchup ou Mayo ? "
            echo -e "${VERT} - Euh.. Tee-shirt ! (°_°)' "
            echo -e "${VERT} - ..."
            echo
            ;;
    esac
}

# Maintenant on propose de démarrer la configuration
configureBox

# P'tit trick des familles pour boucler le menu suivant
choixPostInstall=9
while [[ $choixPostInstall -ne 0 ]]; do

    # Menu post installation
    echo
    echo
    echo -e "${VIOLET}\t\t LISTE DES MACHINES VIRTUELLES"
    echo -e "${VIOLET}============================================================================="
    # L'option prune permet d'éviter des "faux-positifs" à cause du cache utilisé par global-status
    # Et on enlève les 7 dernières lignes de cette commande car trop verbeux
    vagrant global-status --prune | head --lines=-7
    echo -e "${VIOLET}============================================================================="
    echo
    echo -e "${NORMAL}***************************************************"
    echo -e "${BLEU}\t 1. Configurer une nouvelle vagrant"
    echo -e "${BLEU}\t 2. Me connecter en ssh à une vagrant"
    echo -e "${BLEU}\t 3. Eteindre une vagrant"
    echo -e "${BLEU}\t 4. Redémarrer une vagrant"
    echo -e "${BLEU}\t 5. 100 balles et 1 mars"
    echo -e "${BLEU}\t 0. Quitter"
    read -p "Réponse : " choixPostInstall
    echo -e "${NORMAL}***************************************************"
    echo

    case $choixPostInstall in

        #### new ####
        1)
            # Appel de notre fonction qui réalise la configuration d'une box
            configureBox

        #### ssh ####
        2)
            echo -e "${VERT}Connexion SSH"
            read -p "Id de la vagrant : " idVagrant
            vagrant ssh $idVagrant
            echo
            ;;

        #### halt ####
        3)
            echo -e "${VERT}Extinction de la vagrant"
            read -p "Id de la vagrant : " idVagrant
            echo
            vagrant halt $idVagrant
            echo
            ;;

        #### reload ####
        4)
            echo -e "${VERT}Redémarrage de la vagrant (hard-reboot)"
            read -p "Id de la vagrant : " idVagrant
            echo
            vagrant reload $idVagrant --provision
            echo
            ;;

        #### (O_O)? ####
        5)
            # Petit troll
            wget -q http://jmhauchard.free.fr/perso/matos/100balles.png
            xdg-open 100balles.png
            exit 0
            ;;
    esac
done
