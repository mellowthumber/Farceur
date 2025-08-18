SMODS.Joker {
    key = 'bonusJoker',
    config = { extra = { mult = 4 } },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_bonus") then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
            },
            text_config = { colour = G.C.MULT },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.CHIPS, retrigger_type = "mult" },
                { text = ")" },
            },
            calc_function = function(card)
                local mult = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if SMODS.has_enhancement(scoring_card, "m_bonus") then
                            mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.mult = mult
                card.joker_display_values.localized_text = localize{type = 'name_text', key = "m_bonus", set = "Enhanced"}
            end
        }
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return { vars = { card.ability.extra.mult } }
    end,
    atlas = 'joker',
    pos = { x = 2, y = 0 },
    discovered = true,
    rarity = 1, cost = 4,
    blueprint_compat = true
}