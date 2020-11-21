module Footer exposing (footer)

import Colors exposing (..)
import Common exposing (logo)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


footer : Element msg
footer =
    row
        [ width fill
        , alignBottom
        , Font.color white
        , Font.size 16
        , Background.color purple
        , Border.roundEach { topLeft = 60, topRight = 0, bottomRight = 0, bottomLeft = 0 }
        , paddingEach { top = 60, right = 50, bottom = 20, left = 60 }
        , spacing 30
        ]
        [ column [ alignTop, spacing 30 ]
            [ logo, socialLinks ]
        , row [ alignRight, alignTop, spacing 40 ]
            [ aboutSection
            , messageUsSection
            , contactUsSection
            ]
        ]


socialLinks : Element msg
socialLinks =
    row [ spacing 15 ]
        [ socialLink "/assets/icons/twitter.svg" "https://twitter.com/crewnew_com"
        , socialLink "/assets/icons/linkedin.svg" "https://www.linkedin.com/company/crewnew"
        , socialLink "/assets/icons/facebook.svg" "https://www.facebook.com/crewnewcom"
        , socialLink "/assets/icons/medium.svg" "https://medium.com/crewnew-com"
        ]


socialLink : String -> String -> Element msg
socialLink iconUrl url =
    link [] { url = url, label = image [] { src = iconUrl, description = "social" } }


aboutSection : Element msg
aboutSection =
    column [ alignRight, alignTop, spacing 15 ]
        [ footerSectionHeader "ABOUT"
        , link [] { label = text "Top 1% talent", url = "https://crewnew.com/about#1%-talent" }
        , link [] { label = text "All skills rated and tested", url = "https://crewnew.com/about#rated-&-tested" }
        , link [] { label = text "Agency culture & tools", url = "https://crewnew.com/about#culture-&-tools" }
        , link [] { label = text "Buyer protection", url = "https://crewnew.com/about#protection" }
        , link [] { label = text "Pricing and offers", url = "https://crewnew.com/about#pricing" }
        , link [] { label = text "Always project managed", url = "https://crewnew.com/about#project-managed" }
        ]


messageUsSection : Element msg
messageUsSection =
    column [ alignRight, alignTop, spacing 15 ]
        [ footerSectionHeader "MESSAGE US"
        , messageUsItem "Skype" "/assets/icons/skype.png" "https://join.skype.com/invite/hn6ZHvTHDfax"
        , messageUsItem "WhatsApp" "/assets/icons/whatsapp.svg" "https://wa.me/447588699948"
        , messageUsItem "Telegram" "/assets/icons/telegram.svg" "https://t.me/crewnew"
        , messageUsItem "Facebook Messenger" "/assets/icons/facebook-messenger.svg" "https://www.messenger.com/login.php?next=https%3A%2F%2Fwww.messenger.com%2Ft%2F1776148165943905%2F%3Fmessaging_source%3Dsource%253Apages%253Amessage_shortlink"
        ]


messageUsItem : String -> String -> String -> Element msg
messageUsItem itemText iconUrl url =
    link []
        { url = url
        , label =
            row [ spacing 10 ]
                [ image [] { src = iconUrl, description = itemText }
                , text itemText
                ]
        }


contactUsSection : Element msg
contactUsSection =
    column [ alignRight, alignTop, spacing 15 ]
        [ footerSectionHeader "CONTACT US"
        , contactUsItem [ text "11 Marchalsea Road", text "London SE11EN" ]
        , contactUsItem
            [ link [] { url = "tel:+442039849495", label = text "+44 203 98 4949 5" }
            , link [] { url = "tel:+447588699948", label = text "+44 75 886 999 48" }
            ]
        , contactUsItem
            [ link [] { url = "https://www.facebook.com/crewnewcom", label = text "Facebook chat" }
            , link [] { url = "#", label = text "Contact form" }
            ]
        ]


contactUsItem : List (Element msg) -> Element msg
contactUsItem listOfElements =
    row [ spacing 15 ]
        [ image [ alignTop ] { src = "/assets/icons/green-arrow.svg", description = "arrow" }
        , column [ alignTop, spacing 5 ] listOfElements
        ]


footerSectionHeader : String -> Element msg
footerSectionHeader headerText =
    paragraph
        [ paddingEach { top = 0, right = 0, bottom = 20, left = 0 }
        , Font.size 15
        , Font.bold
        ]
        [ text headerText ]
