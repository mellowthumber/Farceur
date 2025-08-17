SMODS.Joker {
    key = 'luckySeven',
    config = { extra = { repetitions = 1 } },
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local seven = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 7 then
                    seven = seven + 1
                    scored_card:set_ability('m_lucky', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if seven > 0 then
                return {
                    message = localize('k_active_ex')
                }
            end
        end
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    end,
    discovered = true,
    rarity = 2, cost = 5
}