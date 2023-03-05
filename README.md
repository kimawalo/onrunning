# Platform engineering challenge
> To be used in the live problem challenge

## Context

This code repository contains the blog rails app based on the [Getting Started with Rails guide](https://guides.rubyonrails.org/getting_started.html#creating-the-blog-application).

## Problems

There are some improvements and bug fixes that can be made in:

- `Dockerfile`
- `.github/workflows/build.yml`
- The automation of repetitive tasks

## Tasks

### Containers

- [x] Looking at the Dockerfile, how can we avoid busting the cache for the dependency update everytime we update the source code ?
```
- Placing the least likely to change commands at the top ensures an efficient usage of the Docker cache
- Only copying the files needed for the next step minimizes cache invalidation in the build process
# see: https://docs.docker.com/build/cache/

```
- [ ] Use build arguments so we can use the same ruby version as defined in file `blog/.ruby-version` as opposed of an hardcoded image version
- [x] Ideally the image size for running in production should be less than 1GB (**bonus**)
```
- Add .dockerignore file (akin to .gitignoe) to help keep only the essntial parts of our build image
- Opt for smaller base images, such as Alpine Linux
- Avoid installing any development and testing dependencies on prod image
    RUN bundle config set without 'development test'
- Combine dev, test, prod build processes into a single Dockerfile with multi-stage builds*
* A multi-stage build is done by creating different sections of a Dockerfile, each referencing a different base image
# see: https://docs.docker.com/build/building/multi-stage/
```
### Continuous Deployment

Using `.github/workflows/build.yml`:

- [x] Add the neccessary steps to tag the image based on the git commit hash
- [x] Uploaded to AWS ECR using `000000000000.dkr.ecr.us-east-1.amazonaws.com/blog` as registry and github actions secrets `AWS_SECRET_ACCESS_KEY` and `AWS_ACCESS_KEY_ID`
- [x] Add another job, that depends on the build job, which would call `kubectl` to set the image for the k8s deployment named `blog` (assume the kubectl config file exists locally with the name `k8s.config`)
- [ ] Alternatively, use the manifests under `kubernetes` to apply the change. There's a TAG placeholder that can be used in to replace with the actual commit hash.
- [x] Add a step on this job that would monitor the deployment progress (**bonus**)

### Infra with terraform

Looking at the `infra` directory, databases are defined in `rds.tf`
In `monitor.tf` there are two resources with an imaginary type that define database monitors

- [ ] How can we simplify the change of values that keep repeating ?
- [ ] If we get a request to create 20 more databases, how can we avoid duplicating some of the code for the required 40 extra monitors ? (hint: we might want to adjust the values for each monitor)

### Kubernetes

Looking at the `kubernetes` directory we can see the definition of a deployment and a service

- [x] What kubectl command would you use to create an HorizontalPodAutoscaler with 1 minimum and 20 max replicas triggered by a cpu usage threshold of 70% ?
```
kubectl autoscale deployment blog --min=1 --max=20 --cpu-percent=70
```
- [ ] Assuming the subdomain `blog.info` how would you expose this application to the world ?
```
kubectl expose deployment/blog --type="NodePort" --port 8080
```
- [ ] Write the necessary configuration manifest to make it happen









---------------------------------

# Platform engineering challenge 2
> To be used in the technical task
## Context

This code repository contains the blog rails app based on the [Getting Started with Rails guide](https://guides.rubyonrails.org/getting_started.html#creating-the-blog-application).

## Requirements

The rails app was setup using:
- ruby 2.7.3p183 (2021-04-05 revision 6847ee089d) [x86_64-linux]
- Rails 7.0.1
- Node v14.18.3
- Yarn 1.22.17
- Postgresql as a database engine. Tested with version 13.2

## Delivery

- Fork this repository
- Work on the solution
- Send us the link to your repository

## Objective

- Containerise the application
- Orchestrate its execution with a compatible database engine
- Make it locally accessible in http://localhost:3000/
- Provide some basic automated way of operate it (start, stop, run database migration, etc)
- Document, under `/docs`, any instructions required to setup or run the solution locally
- Create CI and build pipelines using github actions
- Using terraform, describe some basic infrastructure, under `/infra` where we would run the workloads at scale
- If possible provide some CD pipeline that would automate deployment after a pull request would be merged into the default branch
- Under `/docs` describe how would you handle scalability, security, logging, and monitoring