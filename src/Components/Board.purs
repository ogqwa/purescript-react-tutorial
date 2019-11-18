module Components.Board where

import Prelude
import Components.Square (Piece(..))
import Components.Square as Square
import Data.Array (foldl)
import Data.Array as Array
import Data.Maybe (Maybe(..), isJust, maybe)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "Board"

board :: JSX
board =
  make component
    { initialState
    , render
    }
    unit
  where
  initialState :: { squares :: Array (Maybe Piece), xIsNext :: Boolean }
  initialState = { squares: (\_ -> Nothing) <$> Array.range 0 9, xIsNext: true }

  render self =
    R.div
      { className: "game-board"
      , children:
        [ R.div
            { className: "status"
            , children:
              [ R.text
                  $ case calculateWinner of
                      Just winner -> "Winner: " <> Square.pieceToString winner
                      Nothing -> "Next player: " <> if self.state.xIsNext then "X" else "O"
              ]
            }
        , R.div
            { className: "board-row"
            , children:
              ( \i ->
                  Square.square
                    { value: maybe Nothing (\v -> v) $ Array.index self.state.squares i
                    , onClick: if isJust calculateWinner then mempty else handleClick i
                    }
              )
                <$> Array.range 0 2
            }
        , R.div
            { className: "board-row"
            , children:
              ( \i ->
                  Square.square
                    { value: maybe Nothing (\v -> v) $ Array.index self.state.squares i
                    , onClick: if isJust calculateWinner then mempty else handleClick i
                    }
              )
                <$> Array.range 3 5
            }
        , R.div
            { className: "board-row"
            , children:
              ( \i ->
                  Square.square
                    { value: maybe Nothing (\v -> v) $ Array.index self.state.squares i
                    , onClick: if isJust calculateWinner then mempty else handleClick i
                    }
              )
                <$> Array.range 6 8
            }
        ]
      }
    where
    handleClick :: Int -> Effect Unit
    handleClick i =
      let
        piece = if self.state.xIsNext then Cross else Circle

        currentValue = join $ Array.index self.state.squares i
      in
        case Array.updateAt i (Just piece) self.state.squares, currentValue of
          Just updated, Nothing -> self.setState _ { squares = updated, xIsNext = not self.state.xIsNext }
          _, _ -> mempty

    calculateWinner :: Maybe Piece
    calculateWinner =
      let
        lines = [ [ 0, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ], [ 0, 3, 6 ], [ 1, 4, 7 ], [ 2, 5, 8 ], [ 0, 4, 8 ], [ 2, 4, 6 ] ]
      in
        ( \line -> case Array.index line 0, Array.index line 1, Array.index line 2 of
            Just a, Just b, Just c ->
              let
                av = join $ Array.index self.state.squares a

                bv = join $ Array.index self.state.squares b

                cv = join $ Array.index self.state.squares c
              in
                if (isJust av && av == bv && av == cv) then av else Nothing
            _, _, _ -> Nothing
        )
          <$> lines
          # foldl
              ( \acc result ->
                  if isJust acc then
                    acc
                  else
                    if isJust result then
                      result
                    else
                      Nothing
              )
              Nothing
