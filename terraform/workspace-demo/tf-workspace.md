# tf workspace 

Terraform worksapces is a very logical concept where you can have multiple states of your infrastructure configuration. To put this in simple words if you are running an infrastructure configuration in development environment then the same infrastructure can be run in the production environment.

The main benefit of terraforming workspaces we get is we can have more than one state associated with a single terraform configuration.

If you have not defined any workspace then there is always a default workspace created by terraform, so you always work in a default workspace of terraform. You can list the number of terraform workspaces by running the command terraform workspace show. Also, you can not delete the default workspace

1. Create a new tf workspace 
```
t workspace new <name-of-workspace>
```

2. select a workspace 
```
t workspace select <name-of-workspace>
```

We can use ${terraform.workspace} to get the current workspace in the code.

Whenever you work with terraform workspace and when you create multiple workspaces then you will get one directory created for each workspace inside your terraform project.

