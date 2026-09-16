#! /usr/bin/env bash 
arr=("Create DB" "Delete DB" "Create Table" "Delete Table" "Connect to DB" "Exit") 

PS3="Choose an option from the menu (1-6): "  ;
select opt in "${arr[@]}"
do 
    case "$opt" in
        "Create DB")
            echo "Enter DB name" 
            read DB;
            if [[ ! "$DB" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
                echo "Error: Name must start with an English letter and contain only letters, numbers, or underscores."
            elif [[ -z "$DB" ]] ;  then
                echo "Error: Database name cannot be empty!"
            elif [[ -d "./DataBase/$DB" ]];    then    
                    echo "This database already exists "
            else    
                    mkdir -p "./DataBase/$DB"
                    echo "Database '$DB' created successfully."
            fi
            ;;
        "Delete DB") 
            read -p "Enter DB name : " DB 
            if [[ -z "$DB" ]]  ;  then
                    echo "Error: Database name cannot be empty!"
            elif [[ ! -d "./DataBase/$DB" ]]  ;  then    
                    echo " This database does not exist"
            else    
                    rm -rf "./DataBase/$DB"
                    echo "Database '$DB' deleted successfully."
            fi
            ;;
        "Create Table")
            read -p "Enter database that you want to insert table in it : "  DB
            if [[ -z "$DB" ]]  ;  then
                    echo "Error: Database name cannot be empty!"
            elif [[ ! -d "./DataBase/$DB" ]]  ;   then    
                echo "Error: This database does not exist"
            else    
                read -p "Enter Table name : " table
                if [[ -z "$table" ]] ;   then
                    echo "Error: Table name cannot be empty!"
                elif [[ -f "./DataBase/$DB/$table" ]] ;  then
                    echo "Error: This table already exists "
                else
                    touch "./DataBase/$DB/$table"
                    echo "Table '$table' created successfully inside '$DB'."
                fi
            fi
            ;;
        "Delete Table") 
            read -p "Enter the database name to delete the table from: " DB
            if [[ -z "$DB" ]];  then
                    echo "Error: Database name cannot be empty!"
            elif [[ ! -d "./DataBase/$DB" ]] ;    then    
                echo "Error: This database does not exist"
            else    
                read -p "Enter Table name : " table
                if [[ -z "$table" ]];   then
                    echo "Error: Table name cannot be empty!"
                elif [[ ! -f "./DataBase/$DB/$table" ]] ;  then
                    echo "Error: This table doesn't exist "
                else
                    rm -f "./DataBase/$DB/$table"
                    echo "Table '$table' deleted successfully from '$DB'."
                fi
            fi
            ;;
        "Connect to DB")
            read -p "Enter the database name to connect it: " DB
            if [[ -z "$DB" ]];   then
                    echo "Error: Database name cannot be empty!"
            elif [[ ! -d "./DataBase/$DB" ]] ;   then    
                echo "Error: This database does not exist"
            else    
                read -p "Enter Table name : " table
                if [[ -z "$table" ]];  then
                    echo "Error: Table name cannot be empty!"
                elif [[ ! -f "./DataBase/$DB/$table" ]] ;  then
                    echo "Error: This table doesn't exist "
                else
                    PS3="Chose one choice please "
                    arr2=("Create row" "Insert in row" "Select(search)" "Delete row" "Exit")
                    select option in "${arr2[@]}"
                    do 
                        case "$option" in
                            "Create row") 
                                read -p "Enter name : "  name
                                read -p "Enter id : "  id
                                read -p "Enter phone number : "  phone
                                if [[ -z "$name"  ||  -z "$id"  ||  -z "$phone" ]]  then
                                    echo "Error: name and id and phone number can't be empty" 
                                elif [[ ! "$id" =~ ^[0-9]+$ || ! "$phone" =~ ^[0-9]+$ ]]; then
                                    echo "Error: ID and Phone number must contain numbers only!" 
                                elif [[ ! "$name" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
                                    echo "Error: Name must start with an English letter and contain only letters, numbers, or underscores."
                                elif awk -F: -v num="$id" ' $2 == num  {found=1} END{exit !found} '   "./DataBase/$DB/$table" ; then
                                    echo "Error: This id $id is already exists";
                                else 
                                    echo "$name:$id:$phone"  >>  "./DataBase/$DB/$table" ;
                                    echo "Congrats! The row added successfully" ;
                                fi
                                ;;
                            "Insert in row")
                                read -p "Enter your id : " id
                                if [[ -z "$id"  ]]; then
                                    echo "Error: id can't be empty "  
                                elif [[ ! "$id" =~ ^[0-9]+$ ]]; then
                                    echo "Error: ID must contain numbers only!" 
                                elif awk -F: -v num="$id" ' $2 == num  {found=1} END{exit found} '   "./DataBase/$DB/$table" ; then
                                    echo "Error: This id $id doesn't exist";
                                else
                                    read -p "Enter comment to add : " NEWFIELD
                                    line=$(grep -n "$id" "./DataBase/$DB/$table"  |  cut -d: -f1)
                                    echo "line=[$line]"
                                    sed -i  "$line s/$/:$NEWFIELD/"  "./DataBase/$DB/$table" 
                                    echo "congrats!" ;
                    #awk -F: -v OFS=':' 'NR==$line { $2 = $2 ":$NEWFIELD"} {print}' "./DataBase/$DB/$table" > ./DataBase/"$DB"/temp && mv ./DataBase/"$DB"/temp "./DataBase/$DB/$table"  
                                fi
                                ;;
                            "Select(search)")
                                read -p "Enter id to search : "  id
                                if [[ -z "$id"  ]];  then
                                    echo "Error: id can't be empty " 
                                elif [[ ! "$id" =~ ^[0-9]+$ ]]; then
                                    echo "Error: ID must contain numbers only!" 
                                elif awk -F: -v num="$id" ' $2 == num  {found=1} END{exit found} '   "./DataBase/$DB/$table" ; then
                                    echo "Error: This id '$id' doesn't exist";
                                else
                                    sed -n "/$id/p" "./DataBase/$DB/$table"
                                fi
                                ;;
                            "Delete row")
                                read -p "Enter your id to delete : " id
                                if [[ -z "$id"  ]];  then
                                    echo "Error: id can't be empty "  
                                elif [[ ! "$id" =~ ^[0-9]+$ ]]; then
                                    echo "Error: ID must contain numbers only!" 
                                else
                                    grep -q -w "$id" "./DataBase/$DB/$table"
                                    if [[ $? -eq 0 ]]; then
                                        sed -i "/$id/d"  "./DataBase/$DB/$table"
                                        echo "Valid ID and deleted row successfully"
                                    else
                                        echo "Error: This id doesn't exist"
                                    fi
                                fi
                                ;;
                            "Exit")
                                break
                                ;;
                            *)  
                                echo "Invalid option, please try again." 
                                ;;
                        esac
                    done
                fi
            fi
            ;;
        "Exit")
            echo "Goodbye!"
            break
            ;;
        *) 
            echo "Invalid option, please try again." 
            ;;
    esac
done 

