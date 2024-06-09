#!/bin/bash
SCRIPT_VERSION=1.6
# Script for compiling Godot projects almost completely automatically.
# I believe it should just work for virtually any project.
# But anything else, sure. Probably. Tell me if you find one that it doesn't work for.
# greenfox@zombiejerky.net

# This entire script seems insane.
# Why would anyone write a system like this entirely in Bash?
# That's a good question.

set -e
THIS_EXPORT_SCRIPT=`realpath "$0"`

main()
{
    # read
    argParse "$@"
    

    #check if project file exists
    if [ ! -f "$PROJECT_FILE" ]; then
        error "Project file not found!: -p $PROJECT_FILE"
    fi

    #get project name, if not defined
    if [ -z "$PROJECT_NAME" ]
    then 
        PROJECT_NAME=$(cat $PROJECT_FILE | grep "config/name=" | cut -d "=" -f 2 | sed 's/"//g') 
    fi

    #check if export_presets.cfg exists
    EXPORTS_FILE="$(realpath $(dirname $PROJECT_FILE)/export_presets.cfg)"
    # error $EXPORTS_FILE
    if [ ! -f "$EXPORTS_FILE" ]; then
        error "Export file not found!: -e $EXPORTS_FILE"
    fi

    #check if TARGET_DIR exists
    if [ -d "$TARGET_DIR" ]
    then
        error "Target directory already exists!: -t $TARGET_DIR"
    fi
    # mkdir $TARGET_DIR #this should happen later

    #verify export name
    if [ -z "${EXPORT_NAME+xxx}" ]
    then
        mkdir -p "${TARGET_DIR}"
        cd "${TARGET_DIR}"
        #this should just call itself?
        # names=
        cat $EXPORTS_FILE | grep "^name=" | grep "\".*\"$" -o  | sed -e 's/^"//' -e 's/"$//' |
        while IFS= read -r line
        do
            # echo "${THIS_EXPORT_SCRIPT}" -p "${PROJECT_FILE}" -t "${TARGET_DIR}/$(echo ${line} | sed 's/\///g')" -e "${line}"

            if "${THIS_EXPORT_SCRIPT}" -p "${PROJECT_FILE}" -t "${TARGET_DIR}/$(echo ${line} | sed 's/\///g')" -e "${line}"
            then
                green "Export Succesful:${line}"
            else             
                error "Export Failed:${line}"
            fi

        done
        
        for i in *
        do
            HTMLFile="${i}/${PROJECT_NAME}.html"
            if [ -f "$HTMLFile" ]
            then
                echo "hit $i"
            else
                cd "$i"
                zip -mr "../${PROJECT_NAME}_${i}_$(git rev-parse --short HEAD).zip" *
                cd "${TARGET_DIR}"
                rm -r "$i"
            fi
        done

        generateHTMLFile > index.html
        return
        error "does this even hit?"

    fi
    if ! grep "name=\"${EXPORT_NAME}\"" "${EXPORTS_FILE}" > /dev/null
    then
        error "This export name not found: $EXPORT_NAME"
    fi
    #todo get exports from export-presets.cfg
    
    #get target platform ending
    PLATFORM=$(grep "name=\"$EXPORT_NAME\"" -A1 $EXPORTS_FILE | tail -n 1  | cut -d \" -f2)
    FILE_ENDING=$(fileEndings "$PLATFORM")
    

    mkdir "${TARGET_DIR}"
    godot --headless -v "${PROJECT_FILE}" --export-release "${EXPORT_NAME}" "${TARGET_DIR}/${PROJECT_NAME}${FILE_ENDING}"
    # green "Done exporting: ${EXPORT_NAME}"




}



fileEndings()
{
    declare -A FILE_ENDINGS
    FILE_ENDINGS["Web"]=".html"
    FILE_ENDINGS["Windows Desktop"]=".exe" #? do I need a different one for 64 bit?
    FILE_ENDINGS["Linux/X11"]=".x86_64"
    FILE_ENDINGS["Windows Universal"]=".appx" #does anyone actually use this? let me know!
    FILE_ENDINGS["Mac OSX"]=".app.zip" #I think is right, but I don't have a Mac to test this on.
    FILE_ENDINGS["Android"]=".apk" 

    if test "${FILE_ENDINGS["$1"]+isset}"
    then
        echo ${FILE_ENDINGS["$1"]}
    else
        error "File Ending Not Found For Platform (please create bug or add it to this script)!: $1"
    fi

    #todo, add more?
}

getExportsList()
{
    echo "working on this"
}

argParse()
{
    PROJECT_FILE="$(realpath ./project.godot)"
    TARGET_DIR="$(realpath ./public)"
    VERSION="3.1.1" #hard coded until further notice
    ACTION="EXPORT"
    EXPORT_ALL="FALSE"

    while [[ $# -gt 0 ]]
    do
    key="$1"
    # echo "key =$1"
    # echo "next=$2"
    case $key in
        -p|--project)
            PROJECT_FILE=$(realpath "$2")
            shift; shift
            ;;
            # -v|--version)
            # VERSION="$2"
            # shift; shift
            # ;;
        -t|--targetDir)
            TARGET_DIR=$(realpath "$2") #mangles paths here reletive to project file for some reason, so this is needed. 
            shift; shift
            ;;
        -T)
            TARGET_DIR=$(realpath "$2")
            rm -rf "${TARGET_DIR}"
            shift; shift
            ;;
        -n|--name)
            PROJECT_NAME="$2"
            shift; shift
            ;;
        -e|--export)
            EXPORT_NAME="$2"
            shift; shift
            ;;
        -h|--help)
            getHelp
            false
            ;;
        -v|--version)
            echo $SCRIPT_VERSION
            false
            ;;
        -a|--action)
            ACTION="$2"        
            shift; shift
            ;;
        --manifest)
            generateHTMLFile
            false
            shift; shift
            ;;
        # -E) #will add this feature later
        #     EXPORT_ALL="true"
        #     false
        #     shift; shift
        #     ;;
        --gitlab_ci)
            gitlab_ci
            false
            shift; shift
            ;;
        --dockerfile)
            dockerfile
            false
            shift; shift
            ;;
        *)
        error "Arguement Error: $1"

    esac
    done

}
getHelp()
{
    #/throws Loki
    cat << EOF
$0:
-v|--version   Script Version Number (does not include godot version).
-p|--project   default:"./project.godot"   Project file to use.   
-t|--targetDir default:"./public"          Compile to directory.
-T             Like -t, but no default and deletes target if it already exists.
-n|--name      Default taken from 'project.godot'
-e|--export    Export Name no default, must be defined until "export all" is finished
--manifest     Generate Manifest HTML, used internally
--gitlab_ci    Basic gitlab ci file, pipe this output to a new file called ".gitlab-ci.yml"
--dockerfile   Dockerfile used in this project.
-h|--help      This.

TODO add missing, let me know if you find something, different versions not supported yet
EOF

}

# verifyAndInstall()
# {
#     #install bin, todo check version differences?
#     if [ ! -f bin/Godot*headless.64 ]
#     then 
#         echo "<<<Downloading Godot Headless>>>"
#         wget $binURL -O Godot.zip
#         unzip Godot.zip -d ./bin
#         rm Godot.zip
#     fi
#     godotHeadless="$(realpath bin/Godot*headless.64)"

#     #I don't know how to verify this exists ahead of time from script.
#     #install exportTemplates, todo check version?
#     if [ ! -d "~/.local/share/godot/templates" ]
#     then
#         wget $exportTemplateURL -O templates.zip
#         unzip templates.zip
#         rm templates.zip
#         version=$(cat templates/version.txt)
#         echo version $version
#         mkdir -p ~/.local/share/godot/templates
#         mv templates ~/.local/share/godot/templates/$version
#     fi
# }

exportAll()
{
    #these will be kept as as directory
    for exportName in ${!flatExports[@]}
    do
        outFile="${flatExports[${exportName}]}"
        export
    done

    #these will be zipped up after exporting
    for exportName in ${!zipExports[@]}
    do
        outFile="${zipExports[${exportName}]}"
        export
        zip -rm ${targetDir}.zip $targetDir

    done
}

export() #projectName #exportName
{
    echo "<<<Exporting Project:$projectName >>>"
    echo "<<<Export Name: $exportName >>>"
    echo "<<<Out File: $outFile >>>"
    targetDir="$(realpath ./public/$exportName)"

    #check if dir exists
    if [ -d "$targetDir" ]
    then
        #delete
        echo "dirExists, cleaning up"
        rm -rf "$targetDir"
    fi
    #mkdir
    mkdir "$targetDir"

    sync
    #export to dir
    
    $godotHeadless -v ./project.godot --export $exportName "$targetDir/$outFile"

    
}

debug()
{
    echo PROJECT_FILE=$PROJECT_FILE
    echo VERSION=$VERSION
    echo TARGET_DIR=$TARGET_DIR
    echo PROJECT_NAME=$PROJECT_NAME
    echo FILE_ENDING=$FILE_ENDING
    echo ACTION=$ACTION
    echo THIS_EXPORT_SCRIPT=$THIS_EXPORT_SCRIPT
    echo EXPORT_ALL=$EXPORT_ALL
    echo EXPORT_NAME=$EXPORT_NAME
    # binURL="http://localhost/Project/godotBins/    echo VERSION=$VERSIONot_v3.1.1-stable_linux_headless.64.zip"
    # exportTemplateURL="http://localhost/Project    echo VERSION=$VERSIONdotBins/Godot_v3.1.1-stable_export_templates.tpz"
}


error()
{
    red ${@}
    red "(if this is your first time using the script, try -h)"
    false
}
red()
{
    echo -e "\033[31m${@}\033[m"
}

green()
{
    echo -e "\033[32m${@}\033[m"
}
blue()
{
    echo -e "\033[34m${@}\033[m"
}


#A stupid simple subroutine for creating a inventory file for the $(pwd)
generateHTMLFile()
{
    GetProjectDescription()
    {
        cat << EOF # this is an XSS attack vector. don't put HTML in your commit message!
<pre>$(git log -1 --pretty)</pre>
EOF
    }
    getJson()
    {
    echo "["
    ls *.zip */*.html 2> /dev/null | while read -r line
    do 
        echo "\"$line\""
    done | paste -sd,
    echo "]"
    }


    cat << EOF
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script>
        let manifest = $(getJson)
        function generateEntries(data) {
            let list = document.getElementById("entriesList")
            for( i in data){
                let element = data[i]

                let line = document.createElement("li")
                list.appendChild(line)

                let link = document.createElement("a")
                line.appendChild(link)

                link.href = "./" + element;
                link.innerText = element;

            }
        }
        generateEntries(manifest)

    </script>
    <title>${PROJECT_NAME}</title>
</head>
<body>
    <h1>${PROJECT_NAME}</h1>
    $(GetProjectDescription)
    <ul id="entriesList">
    </ul>
    <script>generateEntries(manifest)</script>
</body>
</html>
EOF

}

gitlab_ci()
{
cat << EOF
PLEASE REFER TO:
https://gitlab.com/greenfox/godot-build-automation/blob/master/.gitlab-ci.yml
EOF
}
dockerfile()
{
cat << EOF 
PLEASE REFER TO:
https://gitlab.com/greenfox/godot-build-automation/blob/master/Dockerfile
EOF
}


if [ ! -L $HOME/.local ] #maybe I'll throw a download detetion here some day? this is handled by the container for now
then
    #github action fix
    if [ "$GITHUB_ACTIONS" = "true" ] 
    then 
        echo "This continer is running in GitHub actions. Linking /root/.local to \$HOME." 
        ln -s /root/.local $HOME
    fi
fi

main "$@"