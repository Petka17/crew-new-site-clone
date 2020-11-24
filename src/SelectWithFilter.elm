module SelectWithFilter exposing (Msg, State, init, update, view)

import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Option exposing (Option)


type alias State =
    { filter : String
    , openFlag : Bool
    , selected : Maybe Option
    , placeholder : String
    }


init : Maybe Option -> String -> State
init selected placeholder =
    { filter = ""
    , openFlag = False
    , selected = selected
    , placeholder = placeholder
    }


type Msg
    = NoOp
    | Blur
    | Selected Option
    | Toggeled
    | UpdatedFilter String


update : Msg -> State -> State
update msg state =
    case msg of
        NoOp ->
            state

        Blur ->
            { state | openFlag = False }

        Selected item ->
            { state | openFlag = False, selected = Just item, filter = "" }

        Toggeled ->
            { state
                | openFlag = not state.openFlag
                , filter =
                    if state.openFlag then
                        ""

                    else
                        state.filter
            }

        UpdatedFilter filter ->
            { state | filter = filter }


view : List (Attribute msg) -> List Option -> State -> Element Msg
view attrs options { filter, openFlag, selected, placeholder } =
    let
        ( optionList, arrow ) =
            if openFlag then
                ( [ below <| optionsView options filter ], '▲' )

            else
                ( [], '▼' )

        ( mainText, mainTextColor ) =
            case selected of
                Just item ->
                    ( item.value, rgb255 0 0 0 )

                Nothing ->
                    ( placeholder, rgb255 0xC0 0xC0 0xC0 )

        cleanExtAttributes =
            List.map (mapAttribute (\msg -> NoOp)) attrs
    in
    el
        (basicStyles
            ++ cleanExtAttributes
            ++ optionList
        )
    <|
        row [ height fill, width fill, onClick Toggeled ]
            [ paragraph [ Font.color mainTextColor ] [ text mainText ]
            , String.fromChar arrow
                |> text
                |> el [ alignRight ]
            ]


basicStyles : List (Attribute msg)
basicStyles =
    [ Border.width 1
    , Border.rounded 3
    , Border.color grey
    , padding 10
    , pointer
    , height (px 40)
    , width fill
    ]


optionsView : List Option -> String -> Element Msg
optionsView optionsList filter =
    column [ width fill ] <|
        [ Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Search"
            , text = filter
            , onChange = UpdatedFilter
            }
        , column
            [ width fill
            , height (px 150)
            , scrollbarY
            ]
            (optionsList
                |> Option.filterByValue filter
                |> List.map optionView
            )
        ]


optionView : Option -> Element Msg
optionView item =
    el
        [ width fill
        , padding 10
        , Background.color white
        , Border.width 1
        , Border.color grey
        , onClick (Selected item)
        ]
    <|
        text item.value
