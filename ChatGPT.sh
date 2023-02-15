#!/bin/bash

echo "Hello, I'm a bash AI. How can I help you today?"

while :
do
  read -p "You: " input
  case $input in
    hello|Hi|hey)
      echo "AI: Hello there! How can I assist you today?"
      ;;
    how are you?
      echo "AI: I'm doing great, thank you for asking. How about you?"
      ;;
    what's your name?)
      echo "AI: My name is ChatGPT. What can I help you with?"
      ;;
    what do you do?)
      echo "AI: I'm an AI language model created by OpenAI. I can answer questions and provide information on a wide range of topics."
      ;;
    what's the weather like?)
      read -p "Where would you like the weather for? " location
      weather="$(curl -s wttr.in/$location?format=%t)"
      echo "AI: The current weather in $location is $weather"
      ;;
    what's the date?)
      date="$(date +"%A, %B %-d, %Y")"
      echo "AI: Today's date is $date"
      ;;
    tell me a joke)
      joke="$(curl -s https://icanhazdadjoke.com/)"
      echo "AI: $joke"
      ;;
    bye)
      echo "AI: Goodbye! Have a great day."
      exit 0
      ;;
    *)
      echo "AI: Sorry, I didn't understand what you meant. Can you please rephrase?"
      ;;
  esac

    what's the time?)
      time="$(date +"%T")"
      echo "AI: The current time is $time"
      ;;
    what's the news?)
      read -p "What news source would you like? " source
      case $source in
        CNN|cnn)
          news="$(curl -s https://edition.cnn.com/world | grep -o '<p>[^<]*</p>' | sed 's/<p>//g' | sed 's/<\/p>//g' | head -n 5)"
          echo "AI: Here's the latest news from CNN: "
          echo "$news"
          ;;
        BBC|bbc)
          news="$(curl -s https://www.bbc.com/news/world | grep -o '<p class="">[^<]*</p>' | sed 's/<p class="">//g' | sed 's/<\/p>//g' | head -n 5)"
          echo "AI: Here's the latest news from BBC: "
          echo "$news"
          ;;
        *)
          echo "AI: Sorry, I couldn't find a news source with that name. Please try again."
          ;;
      esac
      ;;
    what's the definition of*)
      word="${input#*of }"
      definition="$(curl -s https://www.dictionary.com/browse/$word | grep -o '<meta itemprop="definition" [^<]*>' | sed 's/<meta itemprop="definition" content="//g' | sed 's/">//g')"
      if [ -z "$definition" ]
      then
        echo "AI: Sorry, I couldn't find a definition for that word. Please try again."
      else
        echo "AI: The definition of $word is: $definition"
      fi
      ;;
    what's the population of*)
      place="${input#*of }"
      population="$(curl -s https://www.worldometers.info/world-population/population-by-country/ | grep -o "$place [0-9,]*" | grep -o "[0-9,]*")"
      if [ -z "$population" ]
      then
        echo "AI: Sorry, I couldn't find the population of that place. Please try again."
      else
        echo "AI: The population of $place is $population people."
      fi
      ;;
    what's the currency of*)
      country="${input#*of }"
      currency="$(curl -s https://www.currency-iso.org/dam/downloads/lists/list_one.xml | grep -o "$country.*</CcyNm>" | grep -o "<CcyNm>[A-Z]*" | sed 's/<CcyNm>//g')"
      if [ -z "$currency" ]
      then
        echo "AI: Sorry, I couldn't find the currency of that country. Please try again."
      else
        echo "AI: The currency of $country is $currency."
      fi
      ;;
    who is*)

          person="${input#*is }"
      bio="$(curl -s https://en.wikipedia.org/wiki/$person | grep -o '<p>[^<]*</p>' | sed 's/<p>//g' | sed 's/<\/p>//g' | head -n 5)"
      if [ -z "$bio" ]
      then
        echo "AI: Sorry, I couldn't find information about that person. Please try again."
      else
        echo "AI: Here's a brief summary about $person: "
        echo "$bio"
      fi
      ;;
    weather in*)
      location="${input#*in }"
      weather="$(curl -s "wttr.in/$location" | head -n 5)"
      if [ -z "$weather" ]
      then
        echo "AI: Sorry, I couldn't find the weather for that location. Please try again."
      else
        echo "AI: Here's the current weather for $location: "
        echo "$weather"
      fi
      ;;
    *)
      echo "AI: I'm sorry, I don't understand your request. Please try again."
      ;;
  esac
done

