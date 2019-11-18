module Components.Board where

import Prelude

import Components.Square (Pierce(..))
import Components.Square as Square
import Data.Array (foldl, mapWithIndex)
import Data.Array as Array
import Data.Lens.Getter ((^.))
import Data.Lens.Index (ix)
import Data.Maybe (Maybe(..), isJust, maybe)
import Effect (Effect)
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
  initialState :: { squares :: Array (Maybe Pierce), xIsNext :: Boolean }
  initialState =
    { squares: (\_ -> Nothing) <$> Array.range 0 9, xIsNext: true }

  render self =
    R.div
    { className: "game-board"
    , children:
      [ R.div
        { className: "status"
        , children:
          [ R.text $ "Next player: " <> if self.state.xIsNext then "X" else "O" ]
        }
      , R.div
        { className: "board-row"
        , children: (\i ->
            Square.square
              { value: maybe Nothing (\v -> v) $ Array.index self.state.squares i
              , onClick: handleClick i
              })
              <$> Array.range 0 2
        }
      , R.div
        { className: "board-row"
        , children: (\i ->
            Square.square
              { value: maybe Nothing (\v -> v) $ Array.index self.state.squares i
              , onClick: handleClick i
              })
              <$> Array.range 3 5
        }
      , R.div
        { className: "board-row"
       , children: (\i ->
            Square.square
              { value: maybe Nothing (\v -> v) $ Array.index self.state.squares i
              , onClick: handleClick i
              })
              <$> Array.range 6 8
        }
      ]
    }
    where
      handleClick :: Int -> Effect Unit
      handleClick i =
        let pierce = if self.state.xIsNext then Cross else Circle
        in case Array.updateAt i (Just pierce) self.state.squares of
          Just updated -> self.setState _ { squares = updated, xIsNext = not self.state.xIsNext }
          Nothing -> mempty
      -- calculateWinner :: Array (Maybe Pierce)
      -- calculateWinner =
      --   let
      --     lines = [ [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6] ]
      --   in 
      --     (\line ->
      --       case Array.index line 0, Array.index line 1, Array.index line 2 of
      --         Just a, Just b, Just c ->
      --           let
      --             av = self.state.squares ^. ix a
      --             bv = self.state.squares ^. ix b
      --             cv = self.state.squares ^. ix c
      --           in
      --             if (isJust av && av == bv && av == cv) then Just av else Nothing
      --         _, _, _ ->
      --           Nothing
      --     )
      --     <$> lines
      --     -- # foldl (\acc result ->
      --     --     if isJust acc then
      --     --       acc
      --     --     else
      --     --       if isJust result then
      --     --         result
      --     --       else
      --     --         Nothing
      --     --   ) Nothing