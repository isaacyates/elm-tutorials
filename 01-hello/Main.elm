import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String

{--
This page will ask for your name and then say hello to you.

Pieces:
 - a way of asking for your name
 - a way of sending your name to the app
 - a way of building up a string
 - a way of displaying that string
--}

sayHello : String -> String
sayHello name =
  if String.isEmpty name then
    "Who are you?"
  else
    "Hello" ++ " " ++ name

viewBuilder : Signal.Address String -> String -> Html
viewBuilder address message =
  div []
    [
      input [
        placeholder "Please enter your name"
        , on "input" targetValue (\v -> Signal.message address v)
      ] []
      ,div [] [text (sayHello message)]
    ]

name : Signal.Mailbox String
name =
  Signal.mailbox ""

main : Signal Html
main =
  Signal.map (viewBuilder name.address) name.signal
