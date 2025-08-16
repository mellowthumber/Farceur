SMODS.current_mod.optional_features = {
    post_trigger = true
}
SMODS.current_mod.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
end
local loaded_files = {}
local function scan_directories(base_path, relative_path)
    local full_path = base_path .. relative_path
    local success, items = pcall(NFS.getDirectoryItems, full_path)
    if not success then return end
    for _, item in ipairs(items) do
        local item_path = full_path .. "/" .. item
        local item_relative = relative_path == "" and item or (relative_path .. "/" .. item)
        local dir_success, dir_items = pcall(NFS.getDirectoryItems, item_path)
        if dir_success then
            for _, filename in ipairs(dir_items) do
                if filename:match("%.lua$") then
                    local file_path = item_relative .. "/" .. filename
                    if not loaded_files[file_path] then
                        local load_success, error_msg = pcall(function()
                            assert(SMODS.load_file(file_path))()
                        end)
                        if load_success then loaded_files[file_path] = true
                        else sendErrorMessage("Failed to load " .. file_path .. ": " .. tostring(error_msg), "Galore") end
                    else sendDebugMessage("Skipped file: " .. file_path, "Galore") end
                end
            end
            scan_directories(base_path, item_relative)
        end
    end
end
local _, items = pcall(NFS.getDirectoryItems, SMODS.current_mod.path)
for _, item in ipairs(items) do
    local item_path = SMODS.current_mod.path .. item
    local dir_success, dir_items = pcall(NFS.getDirectoryItems, item_path)
    if dir_success then
        scan_directories(SMODS.current_mod.path, item)
    end
end