local text_original = LocalizationManager.text
local data = {}

local destination_path = SavePath .. "/string_id_dumper_output/raw/"

function _update_string_data()
    local file = io.open(destination_path .. "data_string_ID.json", "r")
    if file then
        data = json.decode(file:read("*all"))
        file:close()
    end
end
_update_string_data()

function LocalizationManager:text(string_id, ...)
    if (string_id) then
        if not (data[string_id]) then
            local str = text_original(self, string_id, ...)
            if not str:match("ERROR") then
                data[string_id] = str
                local file = io.open(destination_path .. "data_string_ID.json", "w")
                if file then
                    file:write(json.encode(data))
                    file:close()
                end
            end
        end
    end
    return true and text_original(self, string_id, ...)
end

function LocalizationManager:ids(file)
    log(Localizer:ids(Idstring(file)))
    return Localizer:ids(Idstring(file))
end
