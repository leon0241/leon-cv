#!/bin/bash

# Init directory

current_date=$(date +%m-%y)
read -p "Enter the Company Name: " company_name
dir_name="${current_date} - ${company_name}"
cv_file_name="CV - Leon Lee - ${company_name}"
cl_file_name="Cover Letter - Leon Lee - ${company_name}"

folder_loc="${PWD}/bank/${dir_name}"

echo "Creating directory - ${folder_loc}"

mkdir -p "${folder_loc}"
mkdir -p "${folder_loc}"/sections/

# Copying files

printf "\nWhat type of company are you applying for?\n"
PS3="> "
options=("Tech" "CS" "Maths" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Tech")
            type=tech
            break
            ;;
        "CS")
            type=cs
            break
            ;;
        "Maths")
            type=math
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# Copy CV, and all section files with "type" prefix
cp "${PWD}/templates/cv-${type}.tex" "${folder_loc}/${cv_file_name}.tex"
parts= ls -d "$PWD"/templates/sections/* | grep "${type}" | xargs -I '{}' cp '{}' "${folder_loc}"/sections/

# Rename section files
perl-rename "s/(cs|math|tech)-//" "${folder_loc}"/sections/*.tex

# Optional create cover letter
printf "\nCreate a cover letter?\n"
PS3='> '
options=("Yes" "No")
select opt in "${options[@]}"
do
    case $opt in
        "Yes")
            cp "${PWD}/templates/cover-letter.tex" "${folder_loc}/${cl_file_name}.tex"
            break
            ;;
        "No")
            break
            ;;
    esac
done

printf "\nFiles Created! Location:\n"
printf "\'${folder_loc}\'"
