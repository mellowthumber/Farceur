SMODS.Joker {
    key = 'bubbleGum',
    config = { extra = { chips = 0 } },
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            for _, playing_card in ipairs(context.scoring_hand) do
                card.ability.extra.chips = card.ability.extra.chips + playing_card.base.nominal
            end
            
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.discard then
            local lChips = card.ability.extra.chips
            card.ability.extra.chips = 0
            if lChips > 0 then
                return {
                    message = localize('k_reset')
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
            },
            text_config = { colour = G.C.CHIPS },
        }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips }}
    end,
    discovered = true,
    rarity = 1, cost = 5,
    blueprint_compat = true
}