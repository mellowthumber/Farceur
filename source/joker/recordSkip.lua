SMODS.Joker {
    key = 'recordSkip',
    config = { extra = { sChips = 0, gChips = 12 }, },
    calculate = function(self, card, context)
        if context.post_trigger then
            card.ability.extra.sChips = card.ability.extra.sChips + card.ability.extra.gChips
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.sChips
            }
        end
        if context.post_joker then
            card.ability.extra.sChips = 0
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gChips } }
    end,
    atlas = 'joker',
    pos = { x = 0, y = 0 },
    discovered = true,
    rarity = 2, cost = 5
}