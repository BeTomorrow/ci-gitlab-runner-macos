# ci-macos-image

## Description

Provisionning Ansible d'un agent gitlab-runner pour le build des applications react-native

Logiciels provisionnés :
- homebrew
- Xcode
- nvm
- rbenv + bundler
- gitlab-runner

Note : 
Il faut au préalable récupérer le xip de la version de Xcode que vous souhaitez installer et mettre à jour la variable `xcode_src` dans le fichier `playbook.yml`
  
## Provisioning local
Vous pouvez tester en local via une box vagrant virtualbox.

Prérequis : 
- Vagrant 
- VirtualBox
- ansible

Il faut ensuite lancer les commandes suivantes

```bash
> ansible-galaxy install -r requirements.yml
> vagrant up
> vagrant provision # Pour appliquer à nouveau ansible sans avoir à relancer la VM
```

## Provisionning distant

Vous pouvez appliquer directement le provisionning ansible sur une machine distante via ssh : 

Prérequis : 
- Distant : 
  - Un machine MacOS
  - Un utilisateur de type Administrateur
  - SSH activé pour l'utilisateur en question
- Local : 
  - ansible
  - sshpass ou paramiko (sur la machine qui va executer ansible)


### Sans fichier d'inventaire
```
ansible-playbook -i MACHINE_IP, -u USERNAME -v -c ssh -kK playbook.yml
```
> Attention à la virgule après l'ip elle est nécessaire

### Avec un fichier d'inventaire

Ajoutez un fichier `inventory.yml` avec le contenu suivant :
```yml
---
ci-agents:
  hosts:
    agent1:
      ansible_host: MACHINE_IP
```

Et un fichier `hosts_vars/agent1/vault.yml` en complétant avec vos valeurs
```yml
---
ansible_connection: ssh
ansible_user: 
ansible_password: 
ansible_become_pass: 
gitlab_token:
```

Ensuite lancez la commande suivante :

```
ansible-playbook playbook.yml
```

#### Warning : 

Avant de commiter pensez à sécuriser vos fichiers `vault.yml` pour éviter de mettre des mots de passe en claire dans votre historique git.  
- Ajoutez un fichier `.vault_passwd` contenant votre mot de passe
- Ajouter le fichier `.vault_passwd` au `.gitignore`
- Décommentez la ligne "*# vault_password_file = .vault_passwd*" dans le fichier `ansible.cfg`
- Chiffrez votre fichier `vault.yml` en executant `./vault-cli.sh encrypt`