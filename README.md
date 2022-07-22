[![CircleCI](https://dl.circleci.com/status-badge/img/gh/pman06/DevOps_Microservices/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/pman06/DevOps_Microservices/tree/main)

## Project Overview

Given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests my ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

The goal of the project is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project I:
* Test my project code using linting
* Complete a Dockerfile to containerize this application
* Deploy my containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that my code has been tested


**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

## Setup the Environment

* Create a virtualenv with Python 3.7 and activate it.
```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .devops
source .devops/bin/activate
```
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Kubernetes Steps

* Setup and Configure Docker locally: 

`To install Docker on your machine, go to https://docs.docker.com/engine/install/``

* Setup and Configure Kubernetes locally:

`To onstall Kubernetes on linux: `

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

`or go to https://kubernetes.io/docs/tasks/tools/ for other OS`

`Verify the installation with:`
kubectl version --client

* Create Flask app in Container: 

`docker build --tag=yourdockerhubusername/imagename:tag`

`docker run -p 8000:80 imagename'


* Run via kubectl: 

`To xecute via Kubectl`

`kubectl run preferedname --image=yourdockerhubusername/imagename:tag --port=80`

`Verify kubernetes pods started`

`kubectl get pods`

`Forward the container port to a host`

`kubectl port-forward pods/preferedname --address 0.0.0.0 8000:80`

`Verify port is forwarded by opening another terminal and execute`

`curl localhost:8000`

`or`

`run "make_prediction.sh"`


### Files In the Project

.circleci/config.yml: Contains CircleCI workflow configurations for testing and building our code. Can be extended to be deployed to a web server.

output_txt_files: Files containing outputs from the projuct run. Docker_out.txt contains docker run outputs and kubernetes_out.txt contains out from kubernetes

app.py: fask file that accepts json data, formatand scale the json input, and make predictions based on input.

Dockerfile: Our docker image setup file

make_prediction.sh: when executed, calls our running instance with json data needed to make predictions, and outputs the receuved prediction response.

Makefile: The Makefile includes instructions on environment setup and lint tests. Create and activate a virtual environment. Install dependencies in requirements.txt

requirements.txt: List of libraries needede for our app to run

run_docker.sh: Build image and add a descriptive tag, and Run flask app

run_kubernetes.sh: Run the Docker Hub container with kubernetes and Forward the container port to a host

upload_docker.sh: The file tags and uploads an image to Docker Hub