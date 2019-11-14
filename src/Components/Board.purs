module Components.Board where

import Prelude

import Components.Square as Square
import Data.Array as Array
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "Board"

board :: JSX
board = make component
  { initialState
  , render
  } unit
  where
  initialState =
    { hoge: 1 }

  render self =
    R.div
    { className: "game-board"
    , children:
      [ R.div
        { className: "status"
        , children:
          [ R.text "status" ]
        }
      , R.div
        { className: "board-row"
        , children: (\i -> Square.square { value: show i }) <$> Array.range 0 2
        }
      , R.div
        { className: "board-row"
        , children: (\i -> Square.square { value: show i }) <$> Array.range 3 5
        }
      , R.div
        { className: "board-row"
        , children: (\i -> Square.square { value: show i }) <$> Array.range 6 8
        }
      ]
    }
