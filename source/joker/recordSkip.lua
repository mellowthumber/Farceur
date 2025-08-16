SMODS.Joker {
    key = 'recordSkip',
    config = { extra = { sChips = 0, gChips = 12 }, },
    calculate = function(self, card, context)
        if context.post_trigger then
            sendDebugMessage("post_trigger #1: sChips = "..card.ability.extra.sChips)
            card.ability.extra.sChips = card.ability.extra.sChips + card.ability.extra.gChips
            sendDebugMessage("post_trigger #2: sChips = "..card.ability.extra.sChips)
        end
        if context.joker_main then
            sendDebugMessage("joker_main: sChips = "..card.ability.extra.sChips)
            return {
                chips = card.ability.extra.sChips
            }
        end
        if context.post_joker then
            sendDebugMessage("post_joker #1: sChips = "..card.ability.extra.sChips)
            card.ability.extra.sChips = 0
            sendDebugMessage("post_joker #2: sChips = "..card.ability.extra.sChips)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gChips } }
    end,
    atlas = 'joker',
    discovered = true,
    rarity = 2, cost = 5
}