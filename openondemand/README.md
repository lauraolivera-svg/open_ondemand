# Open OnDemand Installer
Author:Christian Bustelo (HPCNow!)
Date: 2/08/2024
Based on: Pau Balbas (HPCNow!) 

Open OnDemand v3 installer with ansible for Rocky 8.X using local RPMs. This installation adds basic Jupyter and Rstudio Apps. 

#### Upstream Links

* Bitbucket @ [HPCNow!/openondemand](https://bitbucket.org/hpcnow/openondemand/src/RPMs_EL8/)

## Important things 

* This automatized installation deactivates Selinux in case of have it working in the node.

* Add firewalld rules 

* The instalation of Open Ondemand will take all the Apache services, there are other apache
  services in the OOD node it will be necessary to add an apache virtualhost. 

## Custom installation in a specific cluster

In order to adapt the playbook to make a instalation in a specific cluster you must edit the next files for each case (all the files are in /ansible/files) :
  
  -  my_cluster.yml --> In this file you must put the information about the slurm configuration in the 
     job section, in order to avoid ssh problems and in the case that the slurm head machine and the
     OOD server are not the same node, you must put a copy of slurm.conf file in the server, then
     specify the route in the file. Another info that you must change is the name of the cluster 
     (metadata: title) and the node to conect via ssh (login:host). 
     !! Is impotant to change the file's name to the name your cluster has, this is because some apps
     like the template generator uses the name of the file as the name of the cluster, soo to avoid 
     errors change the name. !!
     
  - nginx_cluster.yml --> This is the file to customize the dashboard principal page, you can customize
    as is needed (check: https://osc.github.io/ood-documentation/latest/reference/files/ondemand-d-ymls.html),
     but to make fast changes you can change:
    
    	- OOD_BRAND_BG_COLOR : The main color of the menu-bar.
    	- OOD_DASHBOARD_LOGO* : Logo specifications to the logo that will appear in the main page.
        - OOD_ALLOWLIST_PATH: "/home:/var/www/ood" Top limitation of the Path of the users in the File Manager. We also add the /var/www/ood to keep the user acces to the main place of store for the templates in the job composer.
    	
  - ondemand.yml --> This file controls the distribution of many elements in the dashborad as the 
    pinned apps, the dashboard layout or the elements that appear in the menu bar. You can play with 
    this file to adapt to your configuration.
    
  - ood_portal.yml --> This file has the main configuration about many parts of OOD platform, in order
    to connect the portal to your case you must check the following sections:
  
  	- servername : the url that you will use to aced the resource.
  	- theme:  In this section you'r specifying the folder that contains the resources to custom the
  	  login page. This folder is saved in "/usr/share/ondemand-dex/web/themes/". If you wanna 
  	  custom your login page you can copy the default folder "ondemand" and update the files like
  	  "logo.png" or "nav-logo.png", then change the "theme" in the file to your new folder name.

	- issuer: You can change here the name of the OOD (this will appear in the tab of the nav), put
	  something like "Institution X OOD"

	- loginTitle/loginButtonText/usernamePlaceholder/passwordPlaceholder : This are the text to 
	  custom a bit the login page.
	  
	- connectors : This is a important section, in this you will specify the login method to use
	  in the Open Ondemand portal, the example that is given in the playbook mocks two login nodes.
	  You will need to modify this in order to put your LDAP login config or whatever the cluster 
	  is using.
	  
	  
Once you have this main files configured you will need to change the apps files. In this playbook we are installing three apps, Jupyter, Rstudio and Virtual Desktop
form the default source, that meens that it will be needed to adapt the apps once installed to the software in the compute nodes of the cluster.
This includes modification of scripts, submit files, forms...

  - desktop/form.ym --> You will need to modify the name of the cluster "my_cluster" to use the name of
    the YML file that we configure in the previous secction. (In this case "my_cluster.yml")
   
  - jupyter_files/form.yml --> In the same way you will need to change the name of the cluster.
  
  - rstudio_files/form.yml --> Again you must change the cluster name.
  
  
At last you need to do some modifications in the task files (/ansible/tasks):

  - modify_etc_host.yml --> In this file you'll need to modify "line" in order to specify the url that
    will be used to conect the portal "www.institutionX.ood.com"
    
  - install_apps.yml --> You can play with this file in order to add or remove apps to the automatized 
    instalation. If you wanna add some apps supported by the OSC repo you could clone the Jupyter example
    changing the URL to the repository that has the app. In the same way you will need to create a form.yml
    file for the app and copy it to the corresponding folder. 
    You can follow the schema used in the previous point.

## Quick Start

* This ansible is intended for execution on the target machine, in case you want to deploy it from another :

   - At your laptop or headnode modify the /etc/hosts file to add a new registry with the server IP you want to be deployed.
     Modify the ansible/inventory with the new name and the hosts line at the file "install_ondemand.yml"

* Run: ansible-playbook install_ondemand.yml . 

* Modify your /etc/hosts to add a new line with the ip of the machine and the url you are using:

	- X.X.X.X	www.institutionX.ood.com	
	
* Open a new tab on your browser and browse: www.institutionX.ood.com (or your custom url) or the ip of the machine with OOD. 

* Login with any user avaliable in your autentication service (example LDAP)

## Recommended disk space

* Open OnDemand requires a minimum of 7,5GB of disk space. Recommended 20GB or more 

## Issues

* No issues detected.

* If you detect any issue contact with christian.bustelo@hpcnow.com to fix it

## Originally Tested On

* Rocky 8.6 & Rocky 8.7


