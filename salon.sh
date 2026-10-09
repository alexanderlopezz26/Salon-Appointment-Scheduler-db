#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"



MAIN_MENU(){
  echo -e "\n~~~~~ MY SALON ~~~~~\n\nWelcome to My Salon, how can I help you?\n"
  while true 
  do
    echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"
    #leer opcion
    read SERVICE_ID_SELECTED
    if [[ $SERVICE_ID_SELECTED == 1 ]]
    then
      CUT_MENU
      break

    elif [[ $SERVICE_ID_SELECTED == 2 ]]
    then
      COLOR_MENU
      break

    elif [[ $SERVICE_ID_SELECTED == 3 ]]
    then
      PERM_MENU
      break

    elif [[ $SERVICE_ID_SELECTED == 4 ]]
    then
      STYLE_MENU
      break

    elif [[ $SERVICE_ID_SELECTED == 5 ]]
    then
      TRIM_MENU
      break

    else
      echo -e "\nI could not find that service. What would you like today?"
    fi
  done
}

CUT_MENU(){
  GET_INFO "cut"

}

COLOR_MENU(){
  GET_INFO "color"

}

PERM_MENU(){
  GET_INFO "perm"

}

STYLE_MENU(){
  GET_INFO "style"

}

TRIM_MENU(){
  GET_INFO "trim"

}

GET_INFO(){
  SERVICE=$1

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_RESULT=$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # 2. Divides el texto usando la barra vertical '|' como separador
  IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< "$CUSTOMER_RESULT"

  if [[ -z $CUSTOMER_RESULT ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    #INSERT CUSTOMER INTO DATABASE
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi

  echo -e "\nWhat time would you like your $SERVICE, $CUSTOMER_NAME?"
  read SERVICE_TIME
  #INSERT APPOINTMENT
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) 
  VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."

}

MAIN_MENU