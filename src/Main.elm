module Main exposing (main)

import Browser
import Colors exposing (..)
import Common exposing (checkboxIcon, logo)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Footer exposing (..)
import Html
import NavBar exposing (navBar)


type alias Flags =
    ()


type alias Model =
    { email : String
    , password : String
    , confirmationPassword : String
    , fullName : String
    , mobileNumber : String
    , whatsAppFlag : Bool
    , linkedInLink : String
    , freelanceUrl : String
    , country : String
    , town : String
    }


type FormField
    = Email String
    | Password String
    | ConfirmationPassword String
    | FullName String
    | MobilePhone String
    | WhatsAppFlag Bool
    | LinkedInLink String
    | FreelancerLink String
    | Country String
    | Town String


type Msg
    = UpdateForm FormField


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { email = ""
      , password = ""
      , confirmationPassword = ""
      , fullName = ""
      , mobileNumber = ""
      , whatsAppFlag = False
      , linkedInLink = ""
      , freelanceUrl = ""
      , country = ""
      , town = ""
      }
    , Cmd.none
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateForm field ->
            case field of
                Email email ->
                    ( { model | email = email }, Cmd.none )

                Password password ->
                    ( { model | password = password }, Cmd.none )

                ConfirmationPassword password ->
                    ( { model | confirmationPassword = password }, Cmd.none )

                FullName fullName ->
                    ( { model | fullName = fullName }, Cmd.none )

                MobilePhone mobileNumber ->
                    ( { model | mobileNumber = mobileNumber }, Cmd.none )

                WhatsAppFlag flag ->
                    ( { model | whatsAppFlag = flag }, Cmd.none )

                LinkedInLink url ->
                    ( { model | linkedInLink = url }, Cmd.none )

                FreelancerLink url ->
                    ( { model | freelanceUrl = url }, Cmd.none )

                Country country ->
                    ( { model | country = country }, Cmd.none )

                Town town ->
                    ( { model | town = town }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Freelancer Sign Up - CrewNew"
    , body =
        [ layout
            [ Font.family [ Font.typeface "Montserrat", Font.sansSerif ] ]
          <|
            column [ width fill, height fill ]
                [ navBar
                , column [ width fill, height fill, scrollbarY, spacing 40 ]
                    [ mainContent model
                    , footer
                    ]
                ]
        ]
    }


mainContent : Model -> Element Msg
mainContent model =
    column
        [ width <| maximum 900 fill
        , paddingXY 20 0
        , centerX
        ]
    <|
        [ paragraph
            [ Font.color purple
            , Font.size 28
            , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
            ]
            [ text "Apply to join the coolest freelancers' & PM's startup!" ]
        , firstStep model
        ]


firstStep : Model -> Element Msg
firstStep model =
    column [ spacingXY 0 20 ]
        [ paragraph
            [ Font.color purple
            , Font.size 16
            ]
            [ text "We're super excited to have you here joining us! We're all great at what we do and hope you're the same! Let's get started and hopefully we'll be all one big family very soon:)" ]
        , paragraph
            [ Font.size 16
            , Font.bold
            , Font.family [ Font.typeface "Gibbs", Font.sansSerif ]
            ]
            [ text "All fields marked with * are required!" ]
        , row [ width fill, Font.family [ Font.typeface "Gibbs", Font.sansSerif ] ]
            [ column [ width (fillPortion 1), spacing 10 ] <| formFields model
            , column [ width (fillPortion 1) ]
                [ image
                    [ centerX, width fill, padding 20 ]
                    { src = "https://crewnew.com/_nuxt/cc9f8459dfcf22cabb5f7f5e1933f36a.svg", description = "" }
                ]
            ]
        ]


formFields : Model -> List (Element Msg)
formFields model =
    [ formField "Email: *" <|
        Input.email []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "@"
            , text = model.email
            , onChange = UpdateForm << Email
            }
    , formField "Password x2: *" <|
        column [ width fill, spacing 10 ]
            [ Input.newPassword []
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , show = False
                , text = model.password
                , onChange = UpdateForm << Password
                }
            , Input.newPassword []
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , show = False
                , text = model.confirmationPassword
                , onChange = UpdateForm << ConfirmationPassword
                }
            ]
    , formField "Name: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Full name"
            , text = model.fullName
            , onChange = UpdateForm << FullName
            }
    , formField "Mobile: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "+ country code"
            , text = model.mobileNumber
            , onChange = UpdateForm << MobilePhone
            }
    , formField "" <|
        Input.checkbox []
            { label = Input.labelRight [] <| text "WhatsApp"
            , checked = model.whatsAppFlag
            , icon = checkboxIcon
            , onChange = UpdateForm << WhatsAppFlag
            }
    , formField "LinkedIN:" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "https://"
            , text = model.linkedInLink
            , onChange = UpdateForm << LinkedInLink
            }
    , formField "Freelance URL:" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Freelance / job site profile"
            , text = model.freelanceUrl
            , onChange = UpdateForm << FreelancerLink
            }
    , formField "Country: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text ""
            , text = model.country
            , onChange = UpdateForm << Country
            }
    , formField "Town: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Or village or area..."
            , text = model.town
            , onChange = UpdateForm << Town
            }
    ]


formField : String -> Element Msg -> Element Msg
formField labelText field =
    row [ width fill ]
        [ paragraph
            [ width (fillPortion 1)
            , Font.color <| rgb255 66 55 91
            , Font.size 16
            ]
            [ text labelText ]
        , field
        ]
