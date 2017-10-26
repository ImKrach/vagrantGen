## Vagrant configurator
:camel: :man_with_turban: :camel:

### Démarrer le script
`bash install.sh`


### Etape d'installation
Ce script propose l'installation de Virtualbox et Vagrant.
Si l'un ou l'autre est déjà installé, le script peut tout de même continuer.
Si l'utilisateur refuse d'installer l'un ou l'autre et qu'ils ne sont pas déjà installés, le script s'achève.


### Etape de configuration
Le script propose de configurer une nouvelle vagrant dans le dossier courant.
Si un Vagrantfile existe déjà, la fonction de configuration s'achève. Le script continue à l'étape suivante.
Veillez à lancer ce script à l'endroit où vous souhaitez créer une Vagrant, si vous souhaitez en créer une.


### Etape de monitoring/interaction
Le script affiche la liste des Vagrant présentent dans le système.
Il ne tient pas compte du cache natif de la commande `vagrant global-status`.
Ensuite, il propose différentes interactions avec les Vagrant.
Pour cela, il faut choisir l'interaction souhaitée, puis renseigner l'id de la Vagrant avec laquelle interagir.


### Licence
Ce script est sous licence [MIT](https://choosealicense.com/licenses/mit/).
