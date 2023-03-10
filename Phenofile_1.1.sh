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
#                                                 iB01@
#

WORKFLOW=$1
PATIENT_ID=$2


#sudo apt update
#sudo apt upgrade

#GET PRE-REQS *ADDED 3/7/2023
## WE CAN PROBABLY MAKE THIS A LOOP AND SAVE SPACE

#BCFtools
if [ ! -f /usr/bin/bcftools ]
then
        echo "BCFtools Is Missing, Would you like to Install it?"
        read prereq
                if (( prereq = "Y" )) || (( prereq = "y" )) || (( prereq = "Yes" )) || (( prereq = "yes")) || (( prereq = "YES" ));
                then
                        sudo apt install bcftools

                else (( prereq = "N" )) || (( prereq = "n" )) || (( prereq = "No" )) || (( prereq = "no")) || (( prereq = "NO" ));
                        echo "Aborting Program, BCFtools Is Required..."
                                kill
                fi
else
        echo "BCFtools Found!"
fi
#Samtools
if [ ! -f /usr/bin/samtools ]
then
        echo "SAMTools Is Missing, Would you like to Install it?"
        read prereq
                if (( prereq = "Y" )) || (( prereq = "y" )) || (( prereq = "Yes" )) || (( prereq = "yes")) || (( prereq = "YES" ));
                then
                        sudo apt install samtools
                else (( prereq = "N" )) || (( prereq = "n" )) || (( prereq = "No" )) || (( prereq = "no")) || (( prereq = "NO" ));
                        echo "Aborting Program, Samtools Is Required..."
                                kill
                fi
else
        echo "Samtools Was Found!"
fi
#BEDtools
if [ ! -f /usr/bin/bedtools ]
then
        echo "BEDtools Is Missing, Would you like to Install it?"
        read prereq
                if (( prereq = "Y" )) || (( prereq = "y" )) || (( prereq = "Yes" )) || (( prereq = "yes")) || (( prereq = "YES" ));
                then
                        sudo apt install bedtools
                else (( prereq = "N" )) || (( prereq = "n" )) || (( prereq = "No" )) || (( prereq = "no")) || (( prereq = "NO" ));
                        echo "Aborting Program, BEDTools Is Required..."
                                kill
                fi
else
        echo "BEDtools Was Found!"
fi
#VCFTOOLS
if [ ! -f /usr/bin/vcftools ]
then
        echo "VCFtools Is Missing, Would you like to Install it?"
        read prereq
                if (( prereq = "Y" )) || (( prereq = "y" )) || (( prereq = "Yes" )) || (( prereq = "yes")) || (( prereq = "YES" ));
                then
                        sudo apt install vcftools
                else (( prereq = "N" )) || (( prereq = "n" )) || (( prereq = "No" )) || (( prereq = "no")) || (( prereq = "NO" ));
                        echo "Aborting Program, VCFTools Is Required..."
                                kill
                fi
else
        echo "VCFtools Was Found!"
fi
#MiniMAP2
if [ ! -f /usr/bin/minimap2 ]
then
        echo "Minimap2 Is Missing, Would you like to Install it?"
        read prereq
                if (( prereq = "Y" )) || (( prereq = "y" )) || (( prereq = "Yes" )) || (( prereq = "yes")) || (( prereq = "YES" ));
                then
                        sudo apt install minimap2
                else (( prereq = "N" )) || (( prereq = "n" )) || (( prereq = "No" )) || (( prereq = "no")) || (( prereq = "NO" ));
                        echo "Aborting Program, Minimap2 Is Required..."
                                kill
                fi
else
        echo "MiniMap2 Was Found!\n"
fi

#Get Variables
echo "Please Enter A Workflow Number: "
read WORKFLOW
echo "How Many Family Units Are Contained In The Workflow? "
read FAM_COUNT

#Make Directories
sudo mkdir <DIRECTORY>/$WORKFLOW
cd <DIRECTORY>/
sudo chmod 775 *
cd

#Make Header for .ped *ADDED 3/5/2023
echo -e "#PED format pedigree\r" >>  <DIRECTORY>/$WORKFLOW/HDR.tab
echo -e "#\r" >>  <DIRECTORY>/$WORKFLOW/HDR.tab
echo -e "#fam-id/ind-id/pat-id/mat-id: 0=unknown\r" >>  <DIRECTORY>/$WORKFLOW/HDR.tab
echo -e "#sex: 1=male, 2=female, 0=unknown\r" >>  <DIRECTORY>/$WORKFLOW/HDR.tab
echo -e "#phenotype: -9=missing, 0=missing, 1=unaffected, 2=affected\r" >> <DIRECTORY>/$WORKFLOW/HDR.tab
echo -e "#\r" >> <DIRECTORY>/$WORKFLOW/HDR.tab

#Make Headers for temp, and full workflow .TAB files
echo -e 'Workflow\tFamily_ID\tPatient_ID\tPaternal_ID\tMaternal_ID\tDOB\tSex\tPheno\n' >> <DIRECTORY>/$WORKFLOW/AllSamples.tab
echo -e 'fam_id\tind_id\tpat_id\tmat_id\tsex\tpheno\n' >> <DIRECTORY>/$WORKFLOW/PED_temp.tab

#Iterations
#Loop For Total Family Counts
for (( i=1; i <= "$FAM_COUNT"; i++ ))
{
        echo "Please Enter A Family Identifier: "
        read FAM_ID
        echo "How Many Samples Are In This Family Test? "
        read SAMPLE_COUNT

#Iterate Patient Info Over Family Cluster Size
                for (( j=1; j <= "$SAMPLE_COUNT"; j++))
                {
                        echo "Please Enter The Patient ID, Birth Year, And Gender, If Unknown Enter 0: "
                        echo "[ 1 = Male | 2 = Female ]"
                        read PATIENT_ID DOB GENDER

#WHO IS WHO ??? (THIS IS A PRESUMPTIOUS ALLOCATION OF GENDER AND AGE; MAKE THIS BETTER -- NO PRESUMPTIONS!!!!!!!!)
                                if (( GENDER == "1" )) &&  (( DOB < "2005" ));
                                then    echo -e "$WORKFLOW\t$FAM_ID\t-\t$PATIENT_ID\t-\t$DOB\t$GENDER\t0" >> <DIRECTORY>/$WORKFLOW/AllSamples.tab
                                        echo -e "$FAM_ID\t\t$PATIENT_ID\t" >> <DIRECTORY>/$WORKFLOW/Patient_List.tab
                                        echo -e "$FAM_ID\t-\t$PATIENT_ID\t-\t$GENDER\t0" >> <DIRECTORY>/$WORKFLOW/PED_temp.tab

                                elif (( GENDER == "2" )) && (( DOB < "2005"));
                                then    echo -e "$WORKFLOW\t$FAM_ID\t-\t-\t$PATIENT_ID\t$DOB\t$GENDER\t0" >> <DIRECTORY>/$WORKFLOW/AllSamples.tab
                                        echo -e "$FAM_ID\t\t\t$PATIENT_ID" >> <DIRECTORY>/$WORKFLOW/Patient_List.tab
                                        echo -e "$FAM_ID\t-\t-\t$PATIENT_ID\t$GENDER\t0" >> <DIRECTORY>/$WORKFLOW/PED_temp.tab

                                else (( DOB > "2005" ));
                                        echo -e "$WORKFLOW\t$FAM_ID\t$PATIENT_ID\t-\t-\t$DOB\t$GENDER\t0" >> <DIRECTORY>/$WORKFLOW/AllSamples.tab
                                        echo -e "$FAM_ID\t$PATIENT_ID\t\t" >> <DIRECTORY>/$WORKFLOW/Patient_List.tab
                                        echo -e "$FAM_ID\t$PATIENT_ID\t-\t-\t$GENDER\t0" >> <DIRECTORY>/$WORKFLOW/PED_temp.tab
                                fi
        }
}

sudo cat <DIRECTORY>/$WORKFLOW/HDR.tab <DIRECTORY>/$WORKFLOW/PED_temp.tab >> <DIRECTORY>/$WORKFLOW/Analysis_PED.ped
# ADDED 3/5/2023
awk '$1=$1' <DIRECTORY>/$WORKFLOW/Patient_List.tab >> <DIRECTORY>/$WORKFLOW/Patient_List.sorted.tab
sudo rm  <DIRECTORY>/$WORKFLOW/HDR.tab
sudo rm <DIRECTORY>/$WORKFLOW/PED_temp.tab
sudo rm <DIRECTORY>/$WORKFLOW/Patient_List.tab
sudo mv <DIRECTORY>/$WORKFLOW/Patient_List.sorted.tab <DIRECTORY>/$WORKFLOW/Patient_List.tab

echo "Success!"
