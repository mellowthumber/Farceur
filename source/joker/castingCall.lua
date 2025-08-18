SMODS.Joker {
    key = 'castingCall',
    config = { extra = { sChips = 0, gChips = 15 }},
    calculate = function(self, card, context)
        card.ability.extra.sChips = card.ability.extra.gChips * G.GAME.farceur_joker_added_counter
        if context.joker_main then
            return {
                chips = card.ability.extra.sChips
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "sChips", retrigger_type = "mult" }
            },
            text_config = { colour = G.C.CHIPS },
        }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.sChips, card.ability.extra.gChips }}
    end,
    atlas = 'joker',
    pos = { x = 4, y = 0 },
    discovered = true,
    rarity = 1, cost = 6,
    blueprint_compat = true
}

local card_add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local ret = card_add_to_deck_ref(self, from_debuff)
    if not from_debuff and self.ability.set == "Joker" then
        G.GAME.farceur_joker_added_counter = (G.GAME.farceur_joker_added_counter or 0) + 1
    end
    return ret
end