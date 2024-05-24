*************************************
************R A N G O O**************
********powered by @jvdr2000*********
*************************************
*********cors-discovery-tool*********
*************************************

DESCRIPTION:
-----------

hi to all bug hunters and other security researchers.
this has been made to find the endpoints witch uses CORS(cross origin resource sharing)
on a given specific domain , in this way you can reduce the scope to exploit
the cors misconfiguration.
---------------------------------------------------------------------------------------

INSTALLATION:
-------------
git clone https://github.com/rangoo20000/CORS-discovery-tool
cd CORS-discovery-tool/
cd CORS_MISCONF/
chmod +x *.sh
cd ..  
chmod +x setup.sh
./setup.sh
cd CORS_MISCONF/
./main.sh

----------------------------------------------------------------------------------------

USAGE:
       1- chmod +x *.sh
       2- run "setup.sh"

       3- run "main.sh" and enjoy it lazy guys

    major point :
                after tool finished it's working you can see two text file such as
                result.txt and gau-links.txt:
                in gau-links.txt you can see all endpoints of given domain.
                and in the result.txt you can see those endpoints are using
                cors tech or "CROSS ORIGIN RESOURCE SHARING".



