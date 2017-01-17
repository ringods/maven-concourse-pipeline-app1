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
