local text_original = LocalizationManager.text
local data = nil
local destination_path = SavePath .. "/string_id_dumper_output/"

local DumpHashlist = true
local DrumpStringID_and_String = false

function ReadJsonFile(file_path, open_mode)
    local file = io.open(file_path, open_mode)
    if file then
        local JsonSaveData = json.decode(file:read("*all"))
        file:close()
        if (JsonSaveData) then
            return JsonSaveData
        else
            return {}
        end
    else
        return {}
    end
end

data = ReadJsonFile(destination_path .. "/raw/" .. "data_string_ID.json", "r")

function LocalizationManager:text(string_id, ...)
    if (not (string.is_nil_or_empty(string_id))) then
        local str = text_original(self, string_id, ...)
        if not str:match("ERROR") then
            -- Dump String id and string
            if (DrumpStringID_and_String) then
                if not (data[string_id]) then
                    if (data) and (not (string.is_nil_or_empty(str))) then
                        data[string_id] = str
                        if data[string_id] then
                            local file = io.open(destination_path .. "/raw/" .. "data_string_ID.json", "w")
                            if file then
                                file:write(json.encode(data))
                                file:close()
                            end
                        end
                    end
                end
            end
            -- Dump Hashlist
            if (DumpHashlist) then
                local file = io.open(destination_path .. "/raw/" .. "hashlist", "r+")
                if file then
                    local contents = file:read("*all")
                    if not (contents:find(string_id)) then
                        file:write(string_id .. "\n")
                        file:close()
                    end
                end
            end
        end
    end
    return text_original(self, string_id, ...)
end
