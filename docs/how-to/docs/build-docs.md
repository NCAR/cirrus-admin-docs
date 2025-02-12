# How to build this documentation

## Locally with mkdocs serve

#### 1.  Make sure you have MkDocs installed
    pip install mkdocs
#### 2.  Clone the git repository
    git clone https://github.com/NCAR/cisl-cloud.git
#### 3.  Change in to docs/directory
    cd docs/
#### 4.  Serve content with MkDocs
    mkdocs serve
<br>

## Locally with docker

#### 1. Pull image from Docker Hub
    docker pull ncote/mkdocs_test:latest

#### 2. Run image
    docker run -p 8000:8000 ncote/mkdocs_test

#### 3. Browse to Website
    [http://127.0.0.1:8000/secure/RapidBoard.jspa/](http://127.0.0.1:8000/secure/RapidBoard.jspa/)

<hr>
## Documentation file structure

    mkdocs.yml    # The configuration file.
    docs/
        css/
           extra.css # Contains extra styling for the site. 
        how-to/
            argo-cd/
                deploy.md # Instructions on deploying an application via Argo CD
                upgrade.md # Instructions on upgrading an application via Argo CD
            docs/
                build-docs.md # A how-to on building the documentation website
            encryption/
                sops-age.md # Details on getting setup with SOPS and age for sensitive information encryption
            GitHub/
                gha-docker-build.md # Walkthrough of setting up a GitHub action and workflow to build & push the Docker image
            harbor/
                add_users.md # Instructions on adding users to Harbor
            k8sJH/
                customize-docker.md # Instructions on creating a customized Jupyter Docker image
            stratus/
                add_user.md # Instructions on adding a user to Stratus
            agile.md # A description of the teams current Agile practices and policies
        images/
            * # All custom images used in the site
        img/
            favicon.ico # Overrides the default images used by readthedocs theme
        js/
            clipboard.js # Javascript to copy code to the clipboard
            extra.js # Defining how to implement the clipboard copy in our HTML
            popper.min.js # Used to have the Copied pop up on click
            tippy-bundle.umd.js # Used to have the Copied pop up on click
        overview/   
            about.md # The project about trading
            architecture.md # An overview of the project architecture and hardware
            use-cases.md # A collection of different potential use cases
        slas/
            slas.md # SLAs as defined by the CIRRUS team
        index.md  # The documentation homepage.
        

## GitHub Actions

There is a GitHub Actions workflow associated with this directory that will build a new container image and push it to Docker Hub when changes are made to the docs/ directory or the Dockerfile. That new container image can then be used in the values.yaml file found in the docs-helm/ directory. Once the new image tag is provided to the values.yaml and those changes are pushed the live website, [https://cirrus-admin-docs.k8s.ucar.edu/](https://cirrus-admin-docs.k8s.ucar.edu/), will be updated automatically in 3 minutes or less by Argo CD.   