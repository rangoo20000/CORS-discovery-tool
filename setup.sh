  GNU nano 6.2                   setup.sh                            
#!/bin/bash
# Display logo
cat logo.txt
if ! command -v curl &> /dev/null; then
    echo "RANGOO is trying to install curl...!!"
    sudo apt-get update
    sudo apt-get install curl -y
    echo " curl was installed succesfuly"
else
    echo " curl tool was already installed"
fi


if ! command -v gau &> /dev/null; then
    echo "RANGOO is attempting to install gau...!"
    GO111MODULE=on go get -u -v github.com/lc/gau
    echo "gau was installed successfulyyy...!"

    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
    source ~/.bashrc
    echo " Now RANGOO made you able to use gau in every path you're in....!"
else
    echo "gau was already installed...!"
fi
    echo "*************************************"
    echo "******* LET'S GO TO FIND CORS********"
    echo "**********just run ./main.sh*********"
    echo "*************************************"



