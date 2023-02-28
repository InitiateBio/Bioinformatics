#!/bin/bash

# :::::::::  :::    ::: :::::::::: ::::    :::  ::::::::  :::::::::: ::::::::::: :::        ::::::::::
# :+:    :+: :+:    :+: :+:        :+:+:   :+: :+:    :+: :+:            :+:     :+:        :+:
# +:+    +:+ +:+    +:+ +:+        :+:+:+  +:+ +:+    +:+ +:+            +:+     +:+        +:+
# +#++:++#+  +#++:++#++ +#++:++#   +#+ +:+ +#+ +#+    +:+ :#::+::#       +#+     +#+        +#++:++#
# +#+        +#+    +#+ +#+        +#+  +#+#+# +#+    +#+ +#+            +#+     +#+        +#+
# +#         #+#    #+# #+#        #+#   #+#+# #+#    #+# #+#            #+#     #+#        #+#
# ##         ###    ### ########## ###    ####  ########  ###        ########### ########## ##########
#
#
#                                            iB01@
#                  USE IT. LIKE IT? ( I LIKE == BEER ;) ) WRITE IT BETTER; SHARE IT! :) 
#                                      Initiatebio@gmail.com         
#
# USAGE:
# cd <Directory with this file>
# sudo chmod -u+x Phenofile_1.0.sh
# sudo bash ./Phenofile_1.0.sh
#
# SETUP -- 
# CTRL+F "<DIRECTORY PATH>"  -- REPLACE ALL WITH YOUR DESTINATION PATH
# CHECK DOB MIN VAL TO SET AN APPROPRIATE DOB TO ASSUME CHILD ROLE -- CURRENTLY SET TO 18 YEARS OLD

WORKFLOW=$1 # I use Workflows for volume; this doesnt need to exist for downstream
PATIENT_ID=$2

#sudo apt update
#sudo apt upgrade

#Get Variables
echo "Please Enter A Workflow Number: "
read WORKFLOW
echo "How Many Family Units Are Contained In The Workflow? "
read FAM_COUNT

#Make Directories
sudo mkdir /<DIRECTORY PATH>/$WORKFLOW
cd /<DIRECTORY PATH>/
sudo chmod 775 *
cd

#Make Header
echo -e 'Workflow\tFamily_ID\tPatient_ID\tMaternal_ID\tPaternal_ID\tDOB\tSex\tPheno\n' >> /<DIRECTORY PATH>/$WORKFLOW/PED_TEST.tab
#Iterations
#Loop For Total Family Counts
for (( i=1; i <= "$FAM_COUNT"; i++ ))
{

        echo "Please Enter A Family Identifier: "
        read FAM_ID
        echo "How Many Samples Are In This Family Test?"
        read SAMPLE_COUNT
#Iterate Patient Info Over Family Cluster Size
                for (( j=1; j <= "$SAMPLE_COUNT"; j++))
                {
                        echo "Please Enter The Patient ID, Birth Year, And Gender, If Unknown Enter - : \r"
                        echo "[ 0 = Female | 1 = Male ]..."
#Use 0/1 for downstream models                      
                        read PATIENT_ID DOB GENDER
#WHO IS WHO ??? (THIS IS A PRESUMPTIOUS ALLOCATION OF GENDER AND AGE; MAKE THIS BETTER -- MAKE NO PRESUMPTIONS ON AGE -- CURRENTLY AT 18!!!!!!!!)
                                if (( GENDER == "1" )) &&  (( DOB < "2005" ));
                                then    echo -e "$WORKFLOW\t$FAM_ID\t-\t-\t$PATIENT_ID\t$DOB\t$GENDER\t0" >> /<DIRECTORY PATH>/$WORKFLOW/PED_TEST.tab
                                
                                elif (( GENDER == "0" )) && (( DOB < "2005"));
                                then    echo -e "$WORKFLOW\t$FAM_ID\t-\t$PATIENT_ID\t-\t$DOB\t$GENDER\t0" >> /<DIRECTORY PATH>/$WORKFLOW/PED_TEST.tab

                                else (( DOB > "2005" ));
                                        echo -e "$WORKFLOW\t$FAM_ID\t$PATIENT_ID\t-\t-\t$DOB\t$GENDER\t0" >> /<DIRECTORY PATH>/$WORKFLOW/PED_TEST.tab
                                fi
        }
}

echo "Program Complete!"
