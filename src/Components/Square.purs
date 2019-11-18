module Components.Square where

import Prelude

import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import React.Basic.Events (handler_)

data Pierce
  = Circle
  | Cross

type Props =
  { value :: Maybe Pierce
  , onClick :: Effect Unit
  }
type State = { value :: Maybe String }

component :: Component Props
component = createComponent "Square"

square :: Props -> JSX
square = make component
  { initialState
  , render
  }
  where
  initialState :: State
  initialState =
    { value: Nothing }

  render self =
    R.button
    { className: "square"
    , children:
      [ R.text $ maybe ""
          (\v -> case v of
            Circle -> "O"
            Cross -> "X"
          ) self.props.value
      ]
    , onClick: handler_ $ self.props.onClick
    }
