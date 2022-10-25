# Test TigerGraph by LDBC
This repo is just used for learning how to use LDBC and do some queries test in Databases. Here, I test Tigergraph. And I mainly use docker to build the test environment. Just for recording my learning processing.
## Generate LDBC Social DATA
Hadoop-based LDBC SNB Datagen generates the Interactive workload's SF1-1000 data sets, where SF number means the scale of dataset generated (e.g. SF10=10GB, SF30=30GB). And there we use docker to run LDBC.
### 1. Configure the docker environment
#### Install on WSL2 (IF you use WSL2)
``` bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
```
### Install on Ubuntu
Please follow the offical instructions [here](https://docs.docker.com/engine/install/ubuntu/).
### 2. Download LDBC and Docker Image
``` bash
docker pull ldbc/datagen
```
### 3. Set SF Parameters And Run
``` bash
git clone https://github.com/ldbc/ldbc_snb_datagen_hadoop.git
cd ldbc_snb_datagen_hadoop/
cp params-csv-basic.ini params.ini
nano params.ini  # change the SF number in the first line to whatever you want
```
``` bash
rm -rf social_network/ substitution_parameters/ && docker run --rm --mount type=bind,source="$(pwd)/",target="/opt/ldbc_snb_datagen/out" --mount type=bind,source="$(pwd)/params.ini",target="/opt/ldbc_snb_datagen/params.ini" ldbc/datagen && sudo chown -R ${USER}:${USER} social_network/ substitution_parameters/
```
More info about this part you could reference this offical github [repo](https://github.com/ldbc/ldbc_snb_datagen_hadoop).
### 4. Figure Out the Output of Datagen
After you run `docker run` above, you will get two subfolders in the `$(pwd)`, `social_network` and `substitution_parameters`

## TigerGraph
We can use docker to avoid the configuaration of the database environment.
### 1. Download the TigerGraph
``` bash
docker pull tigergraph/tigergraph:3.7.0
```
### 2. Build a TigerGraph Container
About the docker parameters meaning, you can look in the tigergraph offical tutorial [here](https://docs.tigergraph.com/tigergraph-server/current/getting-started/docker).
``` bash
git clone https://github.com/chengkunli96/TigergraphLDBCTest.git --recursive
cd TigergraphLDBCTest

docker run -d -p 14022:22 -p 9000:9000 -p 14240:14240 --name tigergraph --ulimit nofile=1000000:1000000 -v `pwd`/TigergraphLDBCTest:/home/tigergraph/mydata -t tigergraph/tigergraph:3.7.0
```
``` bash
docker ps | grep tigergraph  # check whether generate container successfully
docker container stop tigergraph  # close current container
```
### 2. SSH connect to the TigerGraph Container Running
``` bash
docker container start tigergraph
ssh -p 14022 tigergraph@localhost  # the host passwd is "tigergraph"
```
## [Option 1] Load LDBC Generated Data By Official `Load_data.sh`
Put your generated `social_network` and `substitution_parameters` into a folder (like ldbc_snb_data_sf[n]) in to the folder which you mount with the docker container. Then run follows commands in tigergraph ssh terminal to set up this ldbc graph example.
``` bash
export LDBC_SNB_DATA_DIR=/home/tigergraph/mydata/ldbc_snb_data_sf1/social_network/  # set this path as yours
gadmin start all  # Start all TigerGraph services

cd /home/tigergraph/mydata/ldbc_snb_tigergraph_dataloader
gsql setup.gsql  # Setup ldbc hook based schema and loading job
bash ./load_data.sh
``` 
Then you can go to [View Tigergraph GUI in Brower](#view-tigergraph-gui-in-brower) and use Tigergraph by Brower GUI

## [Option 2] Load LDBC Generated Data By Official `ecosys repo's driver.py`
If you want to use this method to load data, you have to prepare the python env for the docker container. However the official docker of `tigergraph/tigergraph` does not include python env, you have to install them by yourself in the container. Pls, do follows:
``` bash
# enter docker container bash terminal
docker container start tigergraph
ssh -p 14022 tigergraph@localhost

# then, install python env
sudo apt update
sudo apt install python3 python3-pip
pip3 install requests 
```

Then You can go to [TigerGraph LDBC SNB Benchmark interactive-workload](https://github.com/tigergraph/ecosys/tree/ldbc/ldbc_benchmark/tigergraph/queries_v3#interactive-workload) to load official generated data and run the query. 

One thing you need to notice is that the schema of [option 1](#option-1-load-ldbc-generated-data-by-official-load_datash) and [option 2](#option-2-load-ldbc-generated-data-by-official-ecosys-repos-driverpy) is different, although the schema definition is the same. However, their edge and point name's case is not the same. And tigergraph syntax is case-sensitive.

## View Tigergraph GUI in Brower
After you do `gadmin start all`, you can view tigergraph in GUI by browser by opening URL below:
```
http://localhost:14240
```


## References
* [LDBC SNB Datagen (Hadoop-based) Github](https://github.com/ldbc/ldbc_snb_datagen_hadoop/)
* [Tigergraph Docker](https://docs.tigergraph.com/tigergraph-server/current/getting-started/docker)
* [Tigergraph Prepare Your Environment](https://docs.tigergraph.com/gsql-ref/current/tutorials/pattern-matching/prepare-environment)
* [TigerGraph LDBC SNB Benchmark](https://github.com/tigergraph/ecosys/tree/ldbc/ldbc_benchmark/tigergraph/queries_v3)