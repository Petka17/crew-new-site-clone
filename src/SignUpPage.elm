module SignUpPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Common exposing (checkboxIcon, fieldPlaceholder)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Option exposing (Option)
import Page
import SelectWithFilter


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
        , countrySelect : SelectWithFilter.State
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
    | GotMessageFromCountrySelect SelectWithFilter.Msg
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
        , countrySelect = SelectWithFilter.init Nothing "Select Country"
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

        GotMessageFromCountrySelect subMsg ->
            let
                newSelect =
                    SelectWithFilter.update subMsg model.countrySelect
            in
            ( Model { model | countrySelect = newSelect }, Cmd.none )

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
                    { src = "/assets/images/signup.svg", description = "" }
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
    , SelectWithFilter.view [ Font.size 14 ] countryOptions model.countrySelect
        |> Element.map GotMessageFromCountrySelect
        |> formField "Country: *"
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


countryOptions : List Option
countryOptions =
    [ { id = "Afghanistan", value = "Afghanistan" }
    , { id = "Albania", value = "Albania" }
    , { id = "Antarctica", value = "Antarctica" }
    , { id = "Algeria", value = "Algeria" }
    , { id = "American Samoa", value = "American Samoa" }
    , { id = "Andorra", value = "Andorra" }
    , { id = "Angola", value = "Angola" }
    , { id = "Antigua and Barbuda", value = "Antigua and Barbuda" }
    , { id = "Azerbaijan", value = "Azerbaijan" }
    , { id = "Argentina", value = "Argentina" }
    , { id = "Australia", value = "Australia" }
    , { id = "Austria", value = "Austria" }
    , { id = "Bahamas", value = "Bahamas" }
    , { id = "Bahrain", value = "Bahrain" }
    , { id = "Bangladesh", value = "Bangladesh" }
    , { id = "Armenia", value = "Armenia" }
    , { id = "Barbados", value = "Barbados" }
    , { id = "Belgium", value = "Belgium" }
    , { id = "Bermuda", value = "Bermuda" }
    , { id = "Bhutan", value = "Bhutan" }
    , { id = "Bolivia, Plurinational State of", value = "Bolivia, Plurinational State of" }
    , { id = "Bosnia and Herzegovina", value = "Bosnia and Herzegovina" }
    , { id = "Botswana", value = "Botswana" }
    , { id = "Bouvet Island", value = "Bouvet Island" }
    , { id = "Brazil", value = "Brazil" }
    , { id = "Belize", value = "Belize" }
    , { id = "British Indian Ocean Territory", value = "British Indian Ocean Territory" }
    , { id = "Solomon Islands", value = "Solomon Islands" }
    , { id = "Virgin Islands, British", value = "Virgin Islands, British" }
    , { id = "Brunei Darussalam", value = "Brunei Darussalam" }
    , { id = "Bulgaria", value = "Bulgaria" }
    , { id = "Myanmar", value = "Myanmar" }
    , { id = "Burundi", value = "Burundi" }
    , { id = "Belarus", value = "Belarus" }
    , { id = "Cambodia", value = "Cambodia" }
    , { id = "Cameroon", value = "Cameroon" }
    , { id = "Canada", value = "Canada" }
    , { id = "Cape Verde", value = "Cape Verde" }
    , { id = "Cayman Islands", value = "Cayman Islands" }
    , { id = "Central African Republic", value = "Central African Republic" }
    , { id = "Sri Lanka", value = "Sri Lanka" }
    , { id = "Chad", value = "Chad" }
    , { id = "Chile", value = "Chile" }
    , { id = "China", value = "China" }
    , { id = "Taiwan, Province of China", value = "Taiwan, Province of China" }
    , { id = "Christmas Island", value = "Christmas Island" }
    , { id = "Cocos (Keeling) Islands", value = "Cocos (Keeling) Islands" }
    , { id = "Colombia", value = "Colombia" }
    , { id = "Comoros", value = "Comoros" }
    , { id = "Mayotte", value = "Mayotte" }
    , { id = "Congo", value = "Congo" }
    , { id = "Congo, the Democratic Republic of the", value = "Congo, the Democratic Republic of the" }
    , { id = "Cook Islands", value = "Cook Islands" }
    , { id = "Costa Rica", value = "Costa Rica" }
    , { id = "Croatia", value = "Croatia" }
    , { id = "Cuba", value = "Cuba" }
    , { id = "Cyprus", value = "Cyprus" }
    , { id = "Czech Republic", value = "Czech Republic" }
    , { id = "Benin", value = "Benin" }
    , { id = "Denmark", value = "Denmark" }
    , { id = "Dominica", value = "Dominica" }
    , { id = "Dominican Republic", value = "Dominican Republic" }
    , { id = "Ecuador", value = "Ecuador" }
    , { id = "El Salvador", value = "El Salvador" }
    , { id = "Equatorial Guinea", value = "Equatorial Guinea" }
    , { id = "Ethiopia", value = "Ethiopia" }
    , { id = "Eritrea", value = "Eritrea" }
    , { id = "Estonia", value = "Estonia" }
    , { id = "Faroe Islands", value = "Faroe Islands" }
    , { id = "Falkland Islands (Malvinas)", value = "Falkland Islands (Malvinas)" }
    , { id = "South Georgia and the South Sandwich Islands", value = "South Georgia and the South Sandwich Islands" }
    , { id = "Fiji", value = "Fiji" }
    , { id = "Finland", value = "Finland" }
    , { id = "Åland Islands", value = "Åland Islands" }
    , { id = "France", value = "France" }
    , { id = "French Guiana", value = "French Guiana" }
    , { id = "French Polynesia", value = "French Polynesia" }
    , { id = "French Southern Territories", value = "French Southern Territories" }
    , { id = "Djibouti", value = "Djibouti" }
    , { id = "Gabon", value = "Gabon" }
    , { id = "Georgia", value = "Georgia" }
    , { id = "Gambia", value = "Gambia" }
    , { id = "Palestinian Territory, Occupied", value = "Palestinian Territory, Occupied" }
    , { id = "Germany", value = "Germany" }
    , { id = "Ghana", value = "Ghana" }
    , { id = "Gibraltar", value = "Gibraltar" }
    , { id = "Kiribati", value = "Kiribati" }
    , { id = "Greece", value = "Greece" }
    , { id = "Greenland", value = "Greenland" }
    , { id = "Grenada", value = "Grenada" }
    , { id = "Guadeloupe", value = "Guadeloupe" }
    , { id = "Guam", value = "Guam" }
    , { id = "Guatemala", value = "Guatemala" }
    , { id = "Guinea", value = "Guinea" }
    , { id = "Guyana", value = "Guyana" }
    , { id = "Haiti", value = "Haiti" }
    , { id = "Heard Island and McDonald Islands", value = "Heard Island and McDonald Islands" }
    , { id = "Holy See (Vatican City State)", value = "Holy See (Vatican City State)" }
    , { id = "Honduras", value = "Honduras" }
    , { id = "Hong Kong", value = "Hong Kong" }
    , { id = "Hungary", value = "Hungary" }
    , { id = "Iceland", value = "Iceland" }
    , { id = "India", value = "India" }
    , { id = "Indonesia", value = "Indonesia" }
    , { id = "Iran, Islamic Republic of", value = "Iran, Islamic Republic of" }
    , { id = "Iraq", value = "Iraq" }
    , { id = "Ireland", value = "Ireland" }
    , { id = "Israel", value = "Israel" }
    , { id = "Italy", value = "Italy" }
    , { id = "Côte d'Ivoire", value = "Côte d'Ivoire" }
    , { id = "Jamaica", value = "Jamaica" }
    , { id = "Japan", value = "Japan" }
    , { id = "Kazakhstan", value = "Kazakhstan" }
    , { id = "Jordan", value = "Jordan" }
    , { id = "Kenya", value = "Kenya" }
    , { id = "Korea, Democratic People's Republic of", value = "Korea, Democratic People's Republic of" }
    , { id = "Korea, Republic of", value = "Korea, Republic of" }
    , { id = "Kuwait", value = "Kuwait" }
    , { id = "Kyrgyzstan", value = "Kyrgyzstan" }
    , { id = "Lao People's Democratic Republic", value = "Lao People's Democratic Republic" }
    , { id = "Lebanon", value = "Lebanon" }
    , { id = "Lesotho", value = "Lesotho" }
    , { id = "Latvia", value = "Latvia" }
    , { id = "Liberia", value = "Liberia" }
    , { id = "Libya", value = "Libya" }
    , { id = "Liechtenstein", value = "Liechtenstein" }
    , { id = "Lithuania", value = "Lithuania" }
    , { id = "Luxembourg", value = "Luxembourg" }
    , { id = "Macao", value = "Macao" }
    , { id = "Madagascar", value = "Madagascar" }
    , { id = "Malawi", value = "Malawi" }
    , { id = "Malaysia", value = "Malaysia" }
    , { id = "Maldives", value = "Maldives" }
    , { id = "Mali", value = "Mali" }
    , { id = "Malta", value = "Malta" }
    , { id = "Martinique", value = "Martinique" }
    , { id = "Mauritania", value = "Mauritania" }
    , { id = "Mauritius", value = "Mauritius" }
    , { id = "Mexico", value = "Mexico" }
    , { id = "Monaco", value = "Monaco" }
    , { id = "Mongolia", value = "Mongolia" }
    , { id = "Moldova, Republic of", value = "Moldova, Republic of" }
    , { id = "Montenegro", value = "Montenegro" }
    , { id = "Montserrat", value = "Montserrat" }
    , { id = "Morocco", value = "Morocco" }
    , { id = "Mozambique", value = "Mozambique" }
    , { id = "Oman", value = "Oman" }
    , { id = "Namibia", value = "Namibia" }
    , { id = "Nauru", value = "Nauru" }
    , { id = "Nepal", value = "Nepal" }
    , { id = "Netherlands", value = "Netherlands" }
    , { id = "Curaçao", value = "Curaçao" }
    , { id = "Aruba", value = "Aruba" }
    , { id = "Sint Maarten (Dutch part)", value = "Sint Maarten (Dutch part)" }
    , { id = "Bonaire, Sint Eustatius and Saba", value = "Bonaire, Sint Eustatius and Saba" }
    , { id = "New Caledonia", value = "New Caledonia" }
    , { id = "Vanuatu", value = "Vanuatu" }
    , { id = "New Zealand", value = "New Zealand" }
    , { id = "Nicaragua", value = "Nicaragua" }
    , { id = "Niger", value = "Niger" }
    , { id = "Nigeria", value = "Nigeria" }
    , { id = "Niue", value = "Niue" }
    , { id = "Norfolk Island", value = "Norfolk Island" }
    , { id = "Norway", value = "Norway" }
    , { id = "Northern Mariana Islands", value = "Northern Mariana Islands" }
    , { id = "United States Minor Outlying Islands", value = "United States Minor Outlying Islands" }
    , { id = "Micronesia, Federated States of", value = "Micronesia, Federated States of" }
    , { id = "Marshall Islands", value = "Marshall Islands" }
    , { id = "Palau", value = "Palau" }
    , { id = "Pakistan", value = "Pakistan" }
    , { id = "Panama", value = "Panama" }
    , { id = "Papua New Guinea", value = "Papua New Guinea" }
    , { id = "Paraguay", value = "Paraguay" }
    , { id = "Peru", value = "Peru" }
    , { id = "Philippines", value = "Philippines" }
    , { id = "Pitcairn", value = "Pitcairn" }
    , { id = "Poland", value = "Poland" }
    , { id = "Portugal", value = "Portugal" }
    , { id = "Guinea-Bissau", value = "Guinea-Bissau" }
    , { id = "Timor-Leste", value = "Timor-Leste" }
    , { id = "Puerto Rico", value = "Puerto Rico" }
    , { id = "Qatar", value = "Qatar" }
    , { id = "Réunion", value = "Réunion" }
    , { id = "Romania", value = "Romania" }
    , { id = "Russian Federation", value = "Russian Federation" }
    , { id = "Rwanda", value = "Rwanda" }
    , { id = "Saint Barthélemy", value = "Saint Barthélemy" }
    , { id = "Saint Helena, Ascension and Tristan da Cunha", value = "Saint Helena, Ascension and Tristan da Cunha" }
    , { id = "Saint Kitts and Nevis", value = "Saint Kitts and Nevis" }
    , { id = "Anguilla", value = "Anguilla" }
    , { id = "Saint Lucia", value = "Saint Lucia" }
    , { id = "Saint Martin (French part)", value = "Saint Martin (French part)" }
    , { id = "Saint Pierre and Miquelon", value = "Saint Pierre and Miquelon" }
    , { id = "Saint Vincent and the Grenadines", value = "Saint Vincent and the Grenadines" }
    , { id = "San Marino", value = "San Marino" }
    , { id = "Sao Tome and Principe", value = "Sao Tome and Principe" }
    , { id = "Saudi Arabia", value = "Saudi Arabia" }
    , { id = "Senegal", value = "Senegal" }
    , { id = "Serbia", value = "Serbia" }
    , { id = "Seychelles", value = "Seychelles" }
    , { id = "Sierra Leone", value = "Sierra Leone" }
    , { id = "Singapore", value = "Singapore" }
    , { id = "Slovakia", value = "Slovakia" }
    , { id = "Viet Nam", value = "Viet Nam" }
    , { id = "Slovenia", value = "Slovenia" }
    , { id = "Somalia", value = "Somalia" }
    , { id = "South Africa", value = "South Africa" }
    , { id = "Zimbabwe", value = "Zimbabwe" }
    , { id = "Spain", value = "Spain" }
    , { id = "South Sudan", value = "South Sudan" }
    , { id = "Sudan", value = "Sudan" }
    , { id = "Western Sahara", value = "Western Sahara" }
    , { id = "Suriname", value = "Suriname" }
    , { id = "Svalbard and Jan Mayen", value = "Svalbard and Jan Mayen" }
    , { id = "Swaziland", value = "Swaziland" }
    , { id = "Sweden", value = "Sweden" }
    , { id = "Switzerland", value = "Switzerland" }
    , { id = "Syrian Arab Republic", value = "Syrian Arab Republic" }
    , { id = "Tajikistan", value = "Tajikistan" }
    , { id = "Thailand", value = "Thailand" }
    , { id = "Togo", value = "Togo" }
    , { id = "Tokelau", value = "Tokelau" }
    , { id = "Tonga", value = "Tonga" }
    , { id = "Trinidad and Tobago", value = "Trinidad and Tobago" }
    , { id = "United Arab Emirates", value = "United Arab Emirates" }
    , { id = "Tunisia", value = "Tunisia" }
    , { id = "Turkey", value = "Turkey" }
    , { id = "Turkmenistan", value = "Turkmenistan" }
    , { id = "Turks and Caicos Islands", value = "Turks and Caicos Islands" }
    , { id = "Tuvalu", value = "Tuvalu" }
    , { id = "Uganda", value = "Uganda" }
    , { id = "Ukraine", value = "Ukraine" }
    , { id = "Macedonia", value = "Macedonia" }
    , { id = "Egypt", value = "Egypt" }
    , { id = "United Kingdom", value = "United Kingdom" }
    , { id = "Guernsey", value = "Guernsey" }
    , { id = "Jersey", value = "Jersey" }
    , { id = "Isle of Man", value = "Isle of Man" }
    , { id = "Tanzania, United Republic of", value = "Tanzania, United Republic of" }
    , { id = "United States", value = "United States" }
    , { id = "Virgin Islands, U.S.", value = "Virgin Islands, U.S." }
    , { id = "Burkina Faso", value = "Burkina Faso" }
    , { id = "Uruguay", value = "Uruguay" }
    , { id = "Uzbekistan", value = "Uzbekistan" }
    , { id = "Venezuela", value = "Venezuela" }
    , { id = "Wallis and Futuna", value = "Wallis and Futuna" }
    , { id = "Samoa", value = "Samoa" }
    , { id = "Yemen", value = "Yemen" }
    , { id = "Zambia", value = "Zambia" }
    , { id = "Oregon", value = "Oregon" }
    , { id = "Kosovo", value = "Kosovo" }
    ]
