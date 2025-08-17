SMODS.Joker {
    key = 'memoryCard',
    config = { extra = { sHands = 0, sDiscards = 0, lHands = 0, lDiscards = 0 } },
    calculate = function(self, card, context)
        card.ability.extra.lHands = G.GAME.round_resets.hands
        card.ability.extra.lDiscards = G.GAME.round_resets.discards
        if context.setting_blind and context.main_eval and not context.blueprint then
            if card.ability.extra.sHands > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.sHands)
                        card.ability.extra.sHands = 0
                        return true
                    end
                }))
            end
            if card.ability.extra.sDiscards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_discard(card.ability.extra.sDiscards)
                        card.ability.extra.sDiscards = 0
                        return true
                    end
                }))
            end
            return nil, true
        end
        if context.end_of_round and context.main_eval then
            if G.GAME.current_round.hands_left > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.sHands = card.ability.extra.sHands + G.GAME.current_round.hands_left
                        if card.ability.extra.sHands > card.ability.extra.lHands then
                            card.ability.extra.sHands = card.ability.extra.lHands
                        end
                        return true
                    end
                }))
            end
            if G.GAME.current_round.discards_left > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.sDiscards = card.ability.extra.sDiscards + G.GAME.current_round.discards_left
                        if card.ability.extra.sDiscards > card.ability.extra.lDiscards then
                            card.ability.extra.sDiscards = card.ability.extra.lDiscards
                        end
                        return true
                    end
                }))
            end
            return nil, true
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.sHands, card.ability.extra.sDiscards, card.ability.extra.lHands, card.ability.extra.lDiscards } }
    end,
    discovered = true,
    rarity = 2, cost = 6
}