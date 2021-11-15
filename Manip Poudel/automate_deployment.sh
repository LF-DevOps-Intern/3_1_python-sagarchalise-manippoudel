#! /bin/bash
echo "Welcome to Automate Deployment of File using Python and Bash Scripting"

#function to check python version
function checkoutPython {
    #python version check
    if [[ $(python3 -V) ]]; then
        echo $(python3 -V) "is installed in your machine"
    fi
}

#function to check pip3 and installed it if not installed
function checkoutPip3 {
    #check if pip3 is installed
    if [[ $(pip3 --version) ]]; then
        echo "Pip3 is installed in your system"
    else
        echo "Installing Python3 Pip in Your System"
        sudo apt install python3-pip #installing pip3
        echo "Pip3 has been installed in your system"
    fi
}

#function to check virtualenv and installed it if not installed
function checkoutVirtualEnv {
    #check if virtualenv is installed.
    if [[ $(virtualenv --version) ]]; then
        echo "Virtual Enviroment is installed in your system"
    else
        echo "Installing Virtual Enviroment in Your System"
        sudo apt-get install virtualenv #installing virtualenv
        echo "Virtual Enviroment has been installed in your system"
    fi
}

#function for system requirement check and install the dependency
function checkoutSystem {
    checkoutPython
    checkoutPip3
    checkoutVirtualEnv
}

function checkoutArguments() {
    url=${var:-value}
    echo "$url"
    while [[ "$#" -gt 0 ]]; do
        args="$1"
        case "$args" in
        -u | --url)
            echo "Hello"
            url=$2
            shift
            shift
            echo "$url"
            ;;
        --http_server)
            shift
            ;;

        *)
            echo "Invalid Arguments"
            exit 0
            ;;
        esac

    done

}

#creating virtual enviroment and activating it.
function activateEnviroment {

    virtualenv venv #create the virtual enviroment

    source ./venv/bin/activate # activate the virtual enviroment.
    pip install --yes requests
    pip install --yes pywebcopy
    pip freeze

}

function main {
    checkoutSystem
    # checkoutArguments "$@"
    activateEnviroment
    python deployment.py "$@"

}

main "$@"
