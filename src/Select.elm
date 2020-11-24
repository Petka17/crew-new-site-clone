module Select exposing (view)

import Element exposing (Element)
import Html exposing (..)
import Html.Attributes exposing (selected, style, value)
import Html.Events exposing (onInput, targetValue)
import Option exposing (Option)


view : List Option -> Maybe Option -> (Maybe Option -> msg) -> Element msg
view options selected onChange =
    let
        selectOption id =
            Option.getOptionById options id
                |> onChange
    in
    options
        |> List.map (optionItem selected)
        |> select
            [ onInput selectOption
            , style "height" "28px"
            , style "border" "1px solid #aaa"
            , style "border-radius" "4px"
            ]
        |> Element.html


optionItem : Maybe Option -> Option -> Html msg
optionItem selectedItem item =
    option [ value item.id, selected (isSelected selectedItem item) ] [ text item.value ]


isSelected : Maybe Option -> Option -> Bool
isSelected selected item =
    case selected of
        Just { id } ->
            id == item.id

        Nothing ->
            False
