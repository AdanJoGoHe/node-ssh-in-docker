# Remote Development Environment with Docker, Node.js

<!-- TOC -->
* [Remote Development Environment with Docker, Node.js](#remote-development-environment-with-docker-nodejs)
  * [Description](#description)
  * [Prerequisites](#prerequisites)
  * [Usage](#usage)
  * [Additional Notes](#additional-notes)
  * [Contribution](#contribution)
<!-- TOC -->

## Description
This project aims to provide a remote development environment using 
Docker, Node.js. With this setup, you can develop 
Node.js applications in a Docker container and use your IDE to
access and edit the code in the container remotely.

## Prerequisites
Before getting started, make sure you have the following components
installed on your system:

- Docker
- Powershell

## Usage
Follow the steps below to configure and use the remote development environment:

1. Clone this repository to your local machine:
```bash
git clone https://github.com/your-username/your-project.git
```
2. Open the project directory in your IDE (if applicable).

3. You have these options to build the docker image
- 1. Build the Docker image using the provided Dockerfile. 
```bash
docker build -t my-node-dev .
```
- 2. The Dockerfile sets up a Node.js environment and configures SSH for remote access:

```bash
.\run.ps1
```
also, you have an extended version of the script with a menu with options.
```bash
.\runExtended.ps1
```
4. OPTIONAL (For my use case) Configure WebStorm for remote development, 
should be similar in IDE's with similar capabilities:

- Go to File > New > Project from Existing Files....
- Select Node.js or NPM and then select Add Remote....
- Provide the requested information:
- - Host: localhost
- - Port: 2222 (port configured in the PowerShell script)
- - User name: developer
- - Password: password (password configured in the PowerShell script)
- - Directory: /home/developer

## Additional Notes
- If you want to adjust the configuration of the remote development environment, you can edit the Dockerfile and the PowerShell script according to your needs.
- Keep in mind that the remote development environment is only intended for development purposes. In a production environment, it is recommended to deploy the application appropriately.

Enjoy your remote development environment with Docker and Node.js!

## Contribution
If you encounter any issues or have any suggestions, feel free to create an issue or submit a pull request.

Feel free to customize this example to fit your project's specific needs. If you have any further questions, I'll be happy to assist you.