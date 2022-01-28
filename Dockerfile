FROM ubuntu:20.04

ARG PROJECT_PATH=/home/handson-ml-notes

ARG KERNEL_NAME=jupyter_venv

# Update the system
RUN apt-get update && apt-get upgrade -y

# Install Python3 dependencies
RUN apt-get install -y python3 python3-pip python3-venv

# Create project path directory
RUN mkdir ${PROJECT_PATH}

# Set it as working directory
WORKDIR ${PROJECT_PATH}

# Copy project files to container
COPY . .

# Create & activate virtual environment
RUN python3 -m venv venv && . venv/bin/activate

# Install requirements dependencies
RUN pip3 install -r requirements.txt

# Make sure jupyter & ipykernel are installed
RUN pip3 install jupyter ipykernel

# Create ipykernel for virtual environment
RUN python3 -m ipykernel install --user --name ${KERNEL_NAME}

# Run jupyter notebook as server & expose ip
ENTRYPOINT jupyter notebook --allow-root --ip 0.0.0.0 --no-browser
