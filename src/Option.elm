module Option exposing (..)


type alias Option =
    { id : String, value : String }


getOptionById : List Option -> String -> Maybe Option
getOptionById optionList id =
    List.filter (\option -> option.id == id) optionList
        |> List.head


filterByValue : String -> List Option -> List Option
filterByValue filter list =
    List.filter
        (\item ->
            String.contains
                (String.toLower filter)
                (String.toLower item.value)
        )
        list
