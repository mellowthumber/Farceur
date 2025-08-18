SMODS.Joker {
    key = 'reciprocalGift',
    config = { extra = { xChips = 1, gChips = 0.1 } },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_mult") and not context.blueprint then
            card.ability.extra.xChips = card.ability.extra.xChips + card.ability.extra.gChips
        end
        if context.joker_main then
            return {
                xchips =  card.ability.extra.xChips
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
                        { ref_table = "card.ability.extra", ref_value = "xChips", colour = G.C.WHITE, retrigger_type = "exp" }
                    },
                    border_colour = G.C.CHIPS
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.MULT, retrigger_type = "mult" },
                { text = ")" },
            },
            calc_function = function(card)
                card.joker_display_values.mult = card.ability.extra.xChips
                card.joker_display_values.localized_text = localize{ type = 'name_text', key = "m_mult", set = "Enhanced" }
            end
        }
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return { vars = { card.ability.extra.xChips, card.ability.extra.gChips } }
    end,
    atlas = 'joker',
    pos = { x = 5, y = 0 },
    discovered = true,
    rarity = 2, cost = 4,
    blueprint_compat = true
}