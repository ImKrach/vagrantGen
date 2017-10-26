#!/bin/bash

echo "*******************************************************************"
echo "Bienvenue dans l'assistant d'installation de Virtualbox et Vagrant"
echo "*******************************************************************"
echo
echo "**************************************"
echo "Souhaitez-vous installer Virtualbox ? "
echo -e "\t 1. Oui"
echo -e "\t 2. Non"
read -p "Choix : " installVirtualbox
echo "**************************************"
echo

case $installVirtualbox in
    1)
        # On vérifie d'abord que Virtualbox n'est pas déjà installé sur la machine
        if vboxmanage --version 1>/dev/null ; then
            echo "Virtualbox est déjà installé sur cette machine"
        else
            echo "Téléchargement de Virtualbox"
            # On télécharge Virtualbox et on le renomme plus facilement
            wget http://download.virtualbox.org/virtualbox/5.1.30/virtualbox-5.1_5.1.30-118389~Debian~jessie_amd64.deb -O virtualbox.deb
            echo
            echo
            echo "Installation de Virtualbox"
            sudo dpkg -i virtualbox.deb
            echo
            echo
        fi
        ;;
    2)
        # Si Virtualbox est bien installé, ça va on peut continuer le script
        if vboxmanage --version 1>/dev/null ; then
            echo "Nous avons détecté une version de Virtualbox existante, l'assistant d'installation peut continuer"
            echo
            echo
        # Si Virtualbox n'a pas été installé, le script ne pourra continuer
        else
            echo "Attention, Virtualbox n'est pas installé sur cette machine"
            echo "Veuillez installer Virtualbox pour pouvoir poursuivre"
            exit 1
        fi
        ;;
esac

# On fait la même chose pour vagrant
echo
echo "**************************************"
echo "Souhaitez-vous installer Vagrant ? "
echo -e "\t 1. Oui"
echo -e "\t 2. Non"
read -p "Choix : " installVagrant
echo "**************************************"
echo

case $installVagrant in
    1)
        # On vérifie d'abord que Vagrant n'est pas déjà installé sur la machine
        if vagrant -v 1>/dev/null ; then
            echo "Vagrant est déjà installé sur cette machine"
        else
            echo "Téléchargement de Vagrant"
            # On télécharge Virtualbox et on le renomme plus facilement
            wget http://download.virtualbox.org/virtualbox/5.1.30/virtualbox-5.1_5.1.30-118389~Debian~jessie_amd64.deb -O virtualbox.deb
            echo "Installation de Vagrant"
            sudo dpkg -i virtualbox.deb
        fi
        ;;
    2)
        # Si Vagrant est bien installé, ça va on peut continuer le script
        if vagrant -v 1>/dev/null ; then
            echo "Nous avons détecté une version de Vagrant existante, l'assistant d'installation peut continuer"
        # Si Vagrant n'a pas été installé, le script ne pourra continuer
        else
            echo "Attention, Vagrant n'est pas installé sur cette machine"
            echo "Veuillez installer Vagrant pour pouvoir poursuivre"
            exit 1
        fi
        ;;
esac

# wget https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb?_ga=2.169290337.1704800389.1509020209-657065665.1508919921
#
# wget http://download.virtualbox.org/virtualbox/5.2.0_BETA1/virtualbox-5.2_5.2.0~beta1-117406~Debian~jessie_amd64.deb
#
#
#
# echo "Initialisation du Vagrantfile..."
#
# # On vérifie qu'il n'y a pas déjà un Vagrantfile dans ce dossier
# if [ ! -f Vagrantfile ]; then
#     vagrant init 1> /dev/null
#     echo "Le fichier Vagrantfile a été généré !"
# else
#     echo "Un Vagrantfile existe déjà dans ce dossier !"
#     exit 1
# fi
#
# # On propose le choix de la box
# echo
# echo "Veuillez choisir votre box."
# echo -e "\t 1. xenial.box"
# echo -e "\t 2. ubuntu/xenial64 (en ligne)"
# read -p "Choix : " box
# echo
#
# # En fonction de la saisie
# case $box in
#
#     #### xenial.box ####
#     1)
#     # On remplace "base" par "xenial.box" (il n'existe qu'une occurrence de base dans le Vagrantfile par défaut donc c'est cool)
#     sed -i -e 's/base/xenial\.box/g' Vagrantfile
#     echo "La box xenial.box est en place et sera utilisée au lancement"
#     echo
#     ;;
#
#     #### xenial.box ####
#     2)
#     # On remplace "base" par "ubuntu/xenial64" (il n'existe qu'une occurrence de base dans le Vagrantfile par défaut donc c'est cool)
#     sed -i -e 's/base/ubuntu\/xenial64/g' Vagrantfile
#     echo "La box ubuntu/xenial64 sera téléchargée au lancement"
#     echo
#     ;;
#
#     #### Erreur ####
#     *)
#     echo "Choix incorrecte, c'était pourtant pas compliqué de choisir entre 1 et 2..."
#     echo "Annulation du processus de génération de Vagrantfile"
#     rm Vagrantfile
#     exit 1
#     ;;
#
# esac
#
# # Création du dossier host
# echo "Création du dossier host."
# read -p "Nom du dossier à créer : " dossierHost
#
# # Si le dossier existe deja pas besoin de le créer
# if [ ! -d "$dossierHost" ]; then
#     echo "Création du dossier host $dossierHost"
#     mkdir $dossierHost
# fi
#
# # Si l'utilisateur n'a pas écrit de la merde
# if [[ $dossierHost =~ ^(/)?([^/\0]+(/)?)+$ ]]; then
#     echo "Personnalisation du dossier host $dossierHost"
#     echo
#     # On remplace ../data par $dossierHost
#     sed -i -e "s,../data,$dossierHost,g" Vagrantfile
#     # On décommente la ligne en question
#     sed -i "/synced_folder/s/^  # /  /g" Vagrantfile
# # Il a écrit de la merde, on lui fait savoir
# else
#     echo "Nom de dossier incorrecte."
#     echo "Annulation du processus de génération de Vagrantfile"
#     rm Vagrantfile
#     exit 1
# fi
#
# # Choix du dossier guest
# echo "Choix du dossier guest (chemin absolu + dossier, ex : /var/www ou /toto/src )."
# read -p "Nom du dossier guest : " dossierGuest
#
# # Si l'utilisateur n'a pas écrit de la merde
# if [[ $dossierGuest =~ ^(/)?([^/\0]+(/)?)+$ ]]; then
#     echo "Personnalisation du dossier guest $dossierGuest"
#     echo
#     # On remplace ../vagrant_data par $dossierGuest (dans cette syntaxe on utilise la ',' comme séparateur pour sed pour éviter de devoir '\' les '/' contenus dans $dossierGuest )
#     sed -i -e "s,/vagrant_data,$dossierGuest,g" Vagrantfile
# # Il a écrit de la merde, on lui fait savoir
# else
#     echo "Nom de dossier incorrecte."
#     echo "Annulation du processus de génération de Vagrantfile"
#     rm Vagrantfile
#     exit 1
# fi
#
# # On décommente la ligne du private_network
# sed -i "/private_network/s/^  # /  /g" Vagrantfile
#
# # Cette syntaxe permet de lancer le ssh après avoir terminé le up
# vagrant up && vagrant ssh
