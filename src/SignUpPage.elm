module SignUpPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Common exposing (checkboxIcon, fieldPlaceholder)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page


type Model
    = Model
        { navKey : Nav.Key
        , email : String
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


type Msg
    = UpdatedEmail String
    | UpdatedPassword String
    | UpdatedPasswordConfirmation String
    | UpdatedFullName String
    | UpdatedMobilePhone String
    | UpdatedWhatsAppFlag Bool
    | UpdatedLinkedInLink String
    | UpdatedFreelancerLink String
    | UpdatedCountry String
    | UpdatedTown String
    | ButtonClicked


init : Nav.Key -> Model
init navKey =
    Model
        { navKey = navKey
        , email = ""
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        UpdatedEmail email ->
            ( Model { model | email = email }, Cmd.none )

        UpdatedPassword password ->
            ( Model { model | password = password }, Cmd.none )

        UpdatedPasswordConfirmation password ->
            ( Model { model | confirmationPassword = password }, Cmd.none )

        UpdatedFullName fullName ->
            ( Model { model | fullName = fullName }, Cmd.none )

        UpdatedMobilePhone mobileNumber ->
            ( Model { model | mobileNumber = mobileNumber }, Cmd.none )

        UpdatedWhatsAppFlag flag ->
            ( Model { model | whatsAppFlag = flag }, Cmd.none )

        UpdatedLinkedInLink url ->
            ( Model { model | linkedInLink = url }, Cmd.none )

        UpdatedFreelancerLink url ->
            ( Model { model | freelanceUrl = url }, Cmd.none )

        UpdatedCountry country ->
            ( Model { model | country = country }, Cmd.none )

        UpdatedTown town ->
            ( Model { model | town = town }, Cmd.none )

        ButtonClicked ->
            ( Model model, Nav.pushUrl model.navKey (Page.toString Page.Skills) )


view : Model -> List (Element Msg)
view model =
    [ paragraph
        [ Font.color purple
        , Font.size 28
        , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
        ]
        [ text "Apply to join the coolest freelancers' & PM's startup!" ]
    , form model
    ]


form : Model -> Element Msg
form model =
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
formFields (Model model) =
    [ formField "Email: *" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = fieldPlaceholder "@"
            , text = model.email
            , onChange = UpdatedEmail
            }
    , formField "Password x2: *" <|
        column [ width fill, spacing 10 ]
            [ Input.newPassword [ Font.size 14 ]
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , show = False
                , text = model.password
                , onChange = UpdatedPassword
                }
            , Input.newPassword [ Font.size 14 ]
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , show = False
                , text = model.confirmationPassword
                , onChange = UpdatedPasswordConfirmation
                }
            ]
    , formField "Name: *" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = fieldPlaceholder "Full name"
            , text = model.fullName
            , onChange = UpdatedFullName
            }
    , formField "Mobile: *" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = fieldPlaceholder "+ country code"
            , text = model.mobileNumber
            , onChange = UpdatedMobilePhone
            }
    , formField "" <|
        Input.checkbox []
            { label = Input.labelRight [ Font.size 14, centerY ] <| text "WhatsApp"
            , checked = model.whatsAppFlag
            , icon = checkboxIcon
            , onChange = UpdatedWhatsAppFlag
            }
    , formField "LinkedIN:" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = fieldPlaceholder "https://"
            , text = model.linkedInLink
            , onChange = UpdatedLinkedInLink
            }
    , formField "Freelance URL:" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = fieldPlaceholder "Freelance / job site profile"
            , text = model.freelanceUrl
            , onChange = UpdatedFreelancerLink
            }
    , formField "Country: *" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Select Country"
            , text = model.country
            , onChange = UpdatedCountry
            }
    , formField "Town: *" <|
        Input.text [ Font.size 14 ]
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Or village or area..."
            , text = model.town
            , onChange = UpdatedTown
            }
    , formField "" <|
        Input.button
            [ paddingXY 32 15
            , Font.size 13
            , Background.color lightGrey
            , Border.width 1
            , Border.color grey
            ]
            { label = text "Let's fly!"
            , onPress = Just ButtonClicked
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
