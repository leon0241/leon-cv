#!/bin/bash

# Init directory

current_date=$(date +%m-%y)
echo ${current_date}

read -p "Enter the Company Name: " company_name
dir_name="${current_date} - ${company_name}"
file_name="CV - Leon Lee - ${company_name}"

folder_loc="${PWD}/bank/${dir_name}"

echo "Creating directory - ${folder_loc}"

mkdir -p "${folder_loc}"
mkdir -p "${folder_loc}"/sections/

# Copying files

PS3='What type of company are you applying for? '
options=("Tech" "CS" "Maths" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Tech")
            # Grep in tech files and 
            cp "${PWD}/templates/cv-tech.tex" "${folder_loc}/${file_name}.tex"
            parts= ls -d "$PWD"/templates/sections/* | grep tech | xargs -I '{}' cp '{}' "${folder_loc}"/sections/
            break
            ;;
        "CS")
            cp "${PWD}/templates/cv-cs.tex" "${folder_loc}"
            parts= ls -d "$PWD"/templates/sections/* | grep cs | xargs -I '{}' cp '{}' "${folder_loc}"/sections/
            break
            ;;
        "Maths")
            cp "${PWD}/templates/cv-maths.tex" "${folder_loc}"
            parts= ls -d "$PWD"/templates/sections/* | grep math | xargs -I '{}' cp '{}' "${folder_loc}"/sections/
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo $type $company_name
