module SkillsPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Common exposing (fieldPlaceholder)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Option exposing (Option)
import Page
import Select


type Model
    = Model
        { navKey : Nav.Key
        , skills : List Skill
        }


type alias Skill =
    { name : String
    , level : Maybe Option
    , experience : Maybe Option
    , comments : String
    }


type Msg
    = UpdatedSkill Int String
    | UpdatedLevel Int (Maybe Option)
    | UpdatedExperience Int (Maybe Option)
    | UpdatedComment Int String
    | ButtonClicked


init : Nav.Key -> Model
init navKey =
    Model
        { navKey = navKey
        , skills = List.repeat 10 initSkill
        }


initSkill : Skill
initSkill =
    { name = ""
    , level = takeAt 5 levelOptions
    , experience = List.head experienceOptions
    , comments = ""
    }


takeAt : Int -> List a -> Maybe a
takeAt index list =
    list |> List.take (index + 1) |> List.drop index |> List.head


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        UpdatedSkill selectedIndex name ->
            let
                updateSkillName index skill =
                    if index == selectedIndex then
                        { skill | name = name }

                    else
                        skill

                skills =
                    List.indexedMap updateSkillName model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

        UpdatedLevel selectedIndex level ->
            let
                updateLevel index skill =
                    if index == selectedIndex then
                        { skill | level = level }

                    else
                        skill

                skills =
                    List.indexedMap updateLevel model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

        UpdatedExperience selectedIndex experience ->
            let
                updateExperience index skill =
                    if index == selectedIndex then
                        { skill | experience = experience }

                    else
                        skill

                skills =
                    List.indexedMap updateExperience model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

        UpdatedComment selectedIndex comments ->
            let
                updateComment index skill =
                    if index == selectedIndex then
                        { skill | comments = comments }

                    else
                        skill

                skills =
                    List.indexedMap updateComment model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

        ButtonClicked ->
            ( Model model, Nav.pushUrl model.navKey (Page.toString Page.Final) )


view : Model -> List (Element Msg)
view model =
    [ paragraph
        [ Font.color purple
        , Font.size 28
        , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
        ]
        [ text "Hi! Please, tell us about your top 10 skills that you're best at. Most\u{00A0}important information about you!" ]
    , form model
    ]


form : Model -> Element Msg
form model =
    column [ spacingXY 0 20, Font.light ]
        [ paragraph [ Font.size 16 ]
            [ text "* You must enter at least 3 skills! But profiles that have entered 10 skills will be proceeded much quicker! " ]
        , el [ width fill ] <|
            skillsTable model
        , paragraph [ Font.size 15 ]
            [ text "Please, note that the more details you add about your skillselt the bigger chance you will be contacted with jobs and jobs that are very relavant to your skillset!" ]
        , Input.button
            [ paddingXY 32 15
            , centerX
            , Font.size 13
            , Background.color lightGrey
            , Border.width 1
            , Border.color grey
            ]
            { label = text "Done!"
            , onPress = Just ButtonClicked
            }
        ]


skillsTable : Model -> Element Msg
skillsTable (Model { skills }) =
    column [ width fill, spacing 20 ] <|
        tableHeader
            :: List.indexedMap tableRow skills


tableHeader : Element msg
tableHeader =
    row [ width fill, Font.bold, Font.size 15, spacing 5 ]
        [ el [ countWidth ] <| text "#"
        , el [ skillWidth ] <| text "Skill"
        , el [ levelWidth ] <| text "Level"
        , el [ experienceWidth ] <| text "Experience"
        , el [ commentsWidth ] <| text "Comments"
        ]


tableRow : Int -> Skill -> Element Msg
tableRow index skill =
    row [ width fill, Font.size 16, spacing 5 ]
        [ el [ countWidth ] <| text (indexToString index)
        , el [ skillWidth ] <|
            Input.text []
                { label = Input.labelHidden ""
                , placeholder = fieldPlaceholder "Select Skill"
                , text = skill.name
                , onChange = UpdatedSkill index
                }
        , el [ levelWidth ] <|
            Select.view levelOptions skill.level (UpdatedLevel index)
        , el [ experienceWidth ] <|
            Select.view experienceOptions skill.experience (UpdatedExperience index)
        , el [ commentsWidth ] <|
            Input.multiline [ height (px 60) ]
                { label = Input.labelHidden ""
                , placeholder = fieldPlaceholder "Eg. 'since 2006 my main language' or 'Have done 3 bigger projects' or 'I have worked with almost all major APIs' etc."
                , text = skill.comments
                , onChange = UpdatedComment index
                , spellcheck = False
                }
        ]


indexToString : Int -> String
indexToString index =
    let
        strIndex =
            String.fromInt (index + 1) ++ "."
    in
    if index < 3 then
        strIndex ++ "*"

    else
        strIndex



-- WIDTH


countWidth : Attribute msg
countWidth =
    width (fillPortion 1)


skillWidth : Attribute msg
skillWidth =
    width (fillPortion 6)


levelWidth : Attribute msg
levelWidth =
    width (fillPortion 4)


experienceWidth : Attribute msg
experienceWidth =
    width (fillPortion 3)


commentsWidth : Attribute msg
commentsWidth =
    width (fillPortion 12)



-- OPTIONS


experienceOptions : List Option
experienceOptions =
    [ { id = "0.5", value = "<1 year" }
    , { id = "1", value = "1 year" }
    , { id = "1.5", value = "1,5 years" }
    , { id = "2", value = "2 years" }
    , { id = "3", value = "3 years" }
    , { id = "4", value = "4 years" }
    , { id = "5", value = "5 years" }
    , { id = "7.5", value = "7-8 years" }
    , { id = "9.5", value = "9-10 years" }
    , { id = "13", value = "11-15 years" }
    , { id = "17.5", value = "16-19 years" }
    , { id = "22", value = "20-24 years" }
    , { id = "27", value = "25-29 years" }
    , { id = "31", value = "30+ years" }
    ]


levelOptions : List Option
levelOptions =
    [ { id = "1", value = "1 - Started" }
    , { id = "2", value = "2 - Minimal" }
    , { id = "3", value = "3 - Little" }
    , { id = "4", value = "4 - Junior" }
    , { id = "5", value = "5 - Junior/Mid" }
    , { id = "6", value = "6 - Midlevel" }
    , { id = "7", value = "7 - Mid/Senior" }
    , { id = "8", value = "8 - Senior" }
    , { id = "9", value = "9 - Senior Expert" }
    , { id = "10", value = "10 - Top Expert" }
    ]
