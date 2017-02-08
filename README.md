# maven-concourse-pipeline-app1


```
$ git clone https://github.com/MarcialRosales/maven-concourse-pipeline
$ git clone https://github.com/MarcialRosales/maven-concourse-pipeline-app1
```



## Step 04_install_built_artifact

**Set up infrastucture**

Assuming Docker is running in your machine run the following commands:

```
cd maven-concourse-pipeline
nohup docker-compose up &
```

**Set pipeline**

Login to *Concourse* and set the pipeline
```
fly -t plan1 login -c http://192.168.99.100:8080 -u concourse -p changeme
fly -t plan1 sp -p 04_install_built_artifact -c ../maven-concourse-pipeline/pipeline.yml -l credentials.yml
```

**Trigger pipeline**

We manually trigger it or via a commit, lets try to make a small change to our application and push that change.

## Step 20_deploy_and_verify

We create an orphan branch where we are going to keep the acceptance tests, we could have dedicated a separate repository.
```
git checkout --orphan acceptance-test
git rm --cached -r .
rm -rf *
rm .gitignore .gitmodules
touch README.md
git add .
git commit -m "new branch"
git push origin acceptance-test
```

And we clone it onto a separate folder because we want to create in the source code and in the acceptance tests at the same time.

```
git clone -b acceptance-test https://github.com/MarcialRosales/maven-concourse-pipeline-app1 maven-concourse-pipeline-app1-test
```

## Step 40_provision_infra_with_terraform

We create an orphan branch where we are going to keep the terraform definitions for all the environments. We could have created a separate repository for each environment but we preferred to keep it simple for now.

```
git checkout --orphan terraform
git rm --cached -r .
rm -rf *
rm .gitignore .gitmodules
touch README.md
git add .
git commit -m "new branch"
git push origin terraform
```
