SMODS.Joker {
    key = 'eternalReward',
    config = { extra = { xMult = 1, gMult = 0.1 } },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_bonus") and not context.blueprint then
            card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.gMult
        end
        if context.joker_main then
            return {
                xmult =  card.ability.extra.xMult
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
        text = {
                {
                    border_nodes = {
                        { text = "X", colour = G.C.WHITE },
                        { ref_table = "card.ability.extra", ref_value = "xMult", colour = G.C.WHITE, retrigger_type = "exp" }
                    }
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.CHIPS, retrigger_type = "mult" },
                { text = ")" },
            },
            calc_function = function(card)
                card.joker_display_values.mult = card.ability.extra.xMult
                card.joker_display_values.localized_text = localize{ type = 'name_text', key = "m_bonus", set = "Enhanced" }
            end
        }
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return { vars = { card.ability.extra.xMult, card.ability.extra.gMult } }
    end,
    discovered = true,
    rarity = 2, cost = 4,
    blueprint_compat = true
}