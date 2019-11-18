module Components.Square where

import Prelude
import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import React.Basic.Events (handler_)

data Piece
  = Circle
  | Cross

derive instance eqPiece :: Eq Piece

pieceToString :: Piece -> String
pieceToString p = case p of
  Circle -> "O"
  Cross -> "X"

type Props
  = { value :: Maybe Piece
    , onClick :: Effect Unit
    }

type State
  = { value :: Maybe String }

component :: Component Props
component = createComponent "Square"

square :: Props -> JSX
square =
  make component
    { initialState
    , render
    }
  where
  initialState :: State
  initialState = { value: Nothing }

  render self =
    R.button
      { className: "square"
      , children:
        [ R.text $ maybe "" pieceToString self.props.value
        ]
      , onClick: handler_ $ self.props.onClick
      }
