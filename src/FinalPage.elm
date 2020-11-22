module FinalPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Common exposing (fieldPlaceholder)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page


type Model
    = Model
        { navKey : Nav.Key
        , smallProjectRate : Maybe Float
        , bigProjectRate : Maybe Float
        , fullTimeSalary : Maybe Int
        , partTimeSalary : Maybe Int
        , hoursForTestProject : String
        , repoLinks : String
        , englishLevel : String
        , remoteExperience : String
        , teamInfo : String
        }


type Msg
    = UpdatedSmallProjectRate String
    | UpdatedBigProjectRate String
    | UpdatedFullTimeSalary String
    | UpdatedPartRimeSallary String
    | UpdatedHoursForTestProject String
    | UpdatedRepoLinks String
    | UpdatedEnglishLevel String
    | UpdatedRemoteExperience String
    | UpdatedTeamInfo String
    | ButtonClicked


init : Nav.Key -> Model
init navKey =
    Model
        { navKey = navKey
        , smallProjectRate = Nothing
        , bigProjectRate = Nothing
        , fullTimeSalary = Nothing
        , partTimeSalary = Nothing
        , hoursForTestProject = ""
        , repoLinks = ""
        , englishLevel = ""
        , remoteExperience = ""
        , teamInfo = ""
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        UpdatedSmallProjectRate rate ->
            let
                smallProjectRate =
                    String.toFloat rate
            in
            case smallProjectRate of
                Nothing ->
                    ( Model model, Cmd.none )

                Just _ ->
                    ( Model { model | smallProjectRate = smallProjectRate }, Cmd.none )

        UpdatedBigProjectRate rate ->
            let
                bigProjectRate =
                    String.toFloat rate
            in
            case bigProjectRate of
                Nothing ->
                    ( Model model, Cmd.none )

                Just _ ->
                    ( Model { model | bigProjectRate = bigProjectRate }, Cmd.none )

        UpdatedFullTimeSalary salary ->
            let
                fullTimeSalary =
                    String.toInt salary
            in
            case fullTimeSalary of
                Nothing ->
                    ( Model model, Cmd.none )

                Just _ ->
                    ( Model { model | fullTimeSalary = fullTimeSalary }, Cmd.none )

        UpdatedPartRimeSallary salary ->
            let
                partTimeSalary =
                    String.toInt salary
            in
            case partTimeSalary of
                Nothing ->
                    ( Model model, Cmd.none )

                Just _ ->
                    ( Model { model | partTimeSalary = partTimeSalary }, Cmd.none )

        UpdatedHoursForTestProject hours ->
            ( Model { model | hoursForTestProject = hours }, Cmd.none )

        UpdatedRepoLinks repos ->
            ( Model { model | repoLinks = repos }, Cmd.none )

        UpdatedEnglishLevel level ->
            ( Model { model | englishLevel = level }, Cmd.none )

        UpdatedRemoteExperience experience ->
            ( Model { model | remoteExperience = experience }, Cmd.none )

        UpdatedTeamInfo info ->
            ( Model { model | teamInfo = info }, Cmd.none )

        ButtonClicked ->
            ( Model model, Nav.pushUrl model.navKey (Page.toString Page.ThankYou) )


view : Model -> List (Element Msg)
view model =
    [ paragraph
        [ Font.color purple
        , Font.size 28
        , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
        ]
        [ text "Great job! Some final questions." ]
    , form model
    ]


form : Model -> Element Msg
form (Model model) =
    column [ spacing 40, Font.size 16, Font.light ]
        [ el [ width fill ] <|
            formFields (Model model)
        , paragraph []
            [ text "How many hours of work do you think this first job will take you minimum / maximum? So we know your hourly rate and hours of work and can calculate approx. how much this project will cost." ]
        , column [ spacing 5, width fill ]
            [ paragraph []
                [ text "Who else do you have in your team? Any programmers (frontend? backend? what stack?) Are you a team of freelancers or a company or just alone? How big is your company?" ]
            , Input.multiline [ height (px 80) ]
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , text = model.hoursForTestProject
                , onChange = UpdatedHoursForTestProject
                , spellcheck = False
                }
            ]
        , column [ spacing 5, width fill ]
            [ paragraph []
                [ text "Some URLs to repos to some most advanced pieces of code that you have written. Explain shortly why this part of the code is exciting? Why is it worth looking at? What value does it add?" ]
            , Input.multiline [ height (px 80) ]
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , text = model.repoLinks
                , onChange = UpdatedRepoLinks
                , spellcheck = False
                }
            ]
        , row [ spacing 10 ]
            [ paragraph [ width (fillPortion 3) ] [ text "How good is your spoken English? Are you ready to have an interview with us via video call?" ]
            , Input.text [ width (fillPortion 1) ]
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , text = model.englishLevel
                , onChange = UpdatedEnglishLevel
                }
            ]
        , column [ spacing 5, width fill ]
            [ paragraph []
                [ text "Are you used to work remotely or prefer office? Are you used to work with time tracker?" ]
            , Input.multiline [ height (px 80) ]
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , text = model.remoteExperience
                , onChange = UpdatedRemoteExperience
                , spellcheck = False
                }
            ]
        , column [ spacing 5, width fill ]
            [ paragraph []
                [ text "Who else do you have in your team? Any programmers (frontend? backend? what stack?) Are you a team of freelancers or a company or just alone? How big is your company?" ]
            , Input.multiline [ height (px 80) ]
                { label = Input.labelHidden ""
                , placeholder = fieldPlaceholder "Eg. 'We're a team of 3 mobile developers with designer' or 'I work with one designer.' or 'Single freelancer'"
                , text = model.teamInfo
                , onChange = UpdatedTeamInfo
                , spellcheck = False
                }
            ]
        , row []
            [ paragraph [ Font.size 9, width (fillPortion 2) ]
                [ text "By clicking the \" Finish \" button you agree that we store your data in our database and in the cookies like everybody else & agree: "
                , link [ Font.color blue ] { url = "", label = text "Terms & Conditions / Privacy Policy" }
                ]
            , row [ width (fillPortion 1) ]
                [ Input.button
                    [ paddingXY 32 15
                    , Font.size 13
                    , Background.color lightGrey
                    , Border.width 1
                    , Border.color grey
                    ]
                    { label = text "Finish!"
                    , onPress = Just ButtonClicked
                    }
                ]
            ]
        ]


formFields : Model -> Element Msg
formFields (Model model) =
    column [ width (maximum 600 fill) ]
        [ formField "Hourly rate (USD) for a smaller project: *" <|
            Input.text [ Font.size 14, width (px 100) ]
                { label = Input.labelRight [] <| text "(eg. 15.2)"
                , placeholder = fieldPlaceholder "$"
                , text = maybeFloatToString model.smallProjectRate
                , onChange = UpdatedSmallProjectRate
                }
        , formField "Hourly rate (USD) for a bigger project: *" <|
            Input.text [ Font.size 14, width (px 100) ]
                { label = Input.labelRight [] <| text "(eg. 12.5)"
                , placeholder = fieldPlaceholder "$"
                , text = maybeFloatToString model.bigProjectRate
                , onChange = UpdatedBigProjectRate
                }
        , formField "Hourly rate (USD) for a bigger project: *" <|
            Input.text [ Font.size 14, width (px 100) ]
                { label = Input.labelRight [] <| text "(eg. 1300)"
                , placeholder = fieldPlaceholder "$"
                , text = maybeIntToString model.fullTimeSalary
                , onChange = UpdatedFullTimeSalary
                }
        , formField "Hourly rate (USD) for a bigger project: *" <|
            Input.text [ Font.size 14, width (px 100) ]
                { label = Input.labelRight [] <| text "(eg. 800)"
                , placeholder = fieldPlaceholder "$"
                , text = maybeIntToString model.partTimeSalary
                , onChange = UpdatedPartRimeSallary
                }
        ]


formField : String -> Element msg -> Element msg
formField labelText field =
    row [ width fill ]
        [ paragraph
            [ width (fillPortion 1)
            , Font.color <| rgb255 66 55 91
            , Font.size 16
            ]
            [ text labelText ]
        , el [ width (fillPortion 1) ] field
        ]


maybeFloatToString : Maybe Float -> String
maybeFloatToString maybe =
    case maybe of
        Just val ->
            String.fromFloat val

        Nothing ->
            ""


maybeIntToString : Maybe Int -> String
maybeIntToString maybe =
    case maybe of
        Just val ->
            String.fromInt val

        Nothing ->
            ""
