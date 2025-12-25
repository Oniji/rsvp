Inputs = T{}

Inputs.Enum = T{
    ASCII_DEC_START = 48,
    ASCII_DEC_END   = 57,
    ASCII_TAB       = 9,
    NAME   = "Name",
    YEAR   = "Year",
    MONTH  = "Month",
    DAY    = "Day",
    HOUR   = "Hour",
    MINUTE = "Minute",
    SECOND = "Second",
    MIN_YEAR = 2003,
    MAX_YEAR = 3000,
}

Inputs.Buffers = T{
    Name         = T{},
    Date         = T{[1] = tostring(os.date("%m/%d/%y", os.time()))},
    Time         = T{[1] = "00:00:00 AM"},
    Custom_Gap   = T{},
    Custom_Count = T{},
    Minutes = T{},  -- ???
    Year    = T{[1] = tostring(os.date("*t", os.time()).year)},
    Month   = T{[1] = tostring(os.date("*t", os.time()).month)},
    Day     = T{[1] = tostring(os.date("*t", os.time()).day)},
    Hour    = T{[1] = tostring(0)},
    Minute  = T{[1] = tostring(0)},
    Second  = T{[1] = tostring(0)},
    Multiple = T{},
}

Inputs.HNM_ALIASES = T{
    ["behemoth"] = "Behemoth",
    ["king behemoth"] = "Behemoth",
    ["behemoth/king behemoth"] = "Behemoth",
    ["adamantoise"] = "Adamantoise",
    ["aspidochelone"] = "Adamantoise",
    ["adamantoise/aspidochelone"] = "Adamantoise",
    ["fafnir"] = "Fafnir",
    ["nidhogg"] = "Nidhogg",
    ["tiamat"] = "Tiamat",
    ["vrtra"] = "Vrtra",
    ["jormungand"] = "Jormungand",
    ["simurgh"] = "Simurgh",
    ["king arthro"] = "King Arthro",
    ["king vinegarroon"] = "King Vinegarroon",
    ["bloodsucker"] = "Bloodsucker",
    ["shikigami weapon"] = "Shikigami Weapon",
}

Inputs.Widths = T{}
Inputs.Widths.Primary = 150
Inputs.Widths.Minute = 50
Inputs.Widths.Custom = 100
Inputs.Widths.Multiple = 400

Inputs.Meridiem = T{}
Inputs.Meridiem.AM = "AM"
Inputs.Meridiem.PM = "PM"

Inputs.Text_Flags = bit.bor(ImGuiInputTextFlags_CallbackCharFilter, ImGuiInputTextFlags_AutoSelectAll)
Inputs.Date_Time_Flags = bit.bor(ImGuiInputTextFlags_AutoSelectAll)

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the name buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Name = function()
    return Inputs.Buffers.Name[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the time buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Time = function()
    return Inputs.Buffers.Time[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the date buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Date = function()
    return Inputs.Buffers.Date[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the date buffer as a date table.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Date_Table = function()
    local s = Inputs.Buffers.Date[1]

    -- Must be a string
    if type(s) ~= "string" then
        return nil
    end

    -- Trim whitespace just in case
    s = s:match("^%s*(.-)%s*$")
    if s == "" then
        return nil
    end

    -- Parse MM/DD/YY
    local mm, dd, yy = s:match("^(%d%d?)/(%d%d?)/(%d%d)$")
    if not mm then
        return nil
    end

    mm = tonumber(mm)
    dd = tonumber(dd)
    yy = tonumber(yy)

    if not mm or not dd or not yy then
        return nil
    end

    -- Basic sanity checks
    if mm < 1 or mm > 12 then return nil end
    if dd < 1 or dd > 31 then return nil end

    -- IMPORTANT:
    -- year is intentionally 2-digit to conform to Timers.Make_Time_Table
    return {
        year  = yy,  -- e.g. 25
        month = mm,  -- e.g. 12
        day   = dd,  -- e.g. 25
    }
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the custom gap buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Custom_Gap = function()
    return Inputs.Buffers.Custom_Gap[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the custom count buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Custom_Count = function()
    return Inputs.Buffers.Custom_Count[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves data from the minutes buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Minutes = function()
    return Inputs.Buffers.Minutes[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Retrieves string blob from the multiple buffer.
-- ------------------------------------------------------------------------------------------------------
Inputs.Get_Multiple = function()
    return Inputs.Buffers.Multiple[1]
end

-- ------------------------------------------------------------------------------------------------------
-- Creates the entry field for name.
-- ------------------------------------------------------------------------------------------------------
Inputs.Name_Field = function()
    UI.SetNextItemWidth(Inputs.Widths.Primary) UI.InputText("Name", Inputs.Buffers.Name, 100, ImGuiInputTextFlags_AutoSelectAll)
end

-- ------------------------------------------------------------------------------------------------------
-- Creates the entry field for time.
-- ------------------------------------------------------------------------------------------------------
Inputs.Time_Field = function()
    UI.SetNextItemWidth(Inputs.Widths.Primary) UI.InputText("Time", Inputs.Buffers.Time, 12, Inputs.Date_Time_Flags)
end

-- ------------------------------------------------------------------------------------------------------
-- Creates the entry field for date.
-- ------------------------------------------------------------------------------------------------------
Inputs.Date_Field = function()
    UI.SetNextItemWidth(Inputs.Widths.Primary) UI.InputText("Date", Inputs.Buffers.Date, 9, Inputs.Date_Time_Flags)
end

-- ------------------------------------------------------------------------------------------------------
-- Creates the entry field for custom gap.
-- ------------------------------------------------------------------------------------------------------
Inputs.Custom_Gap_Field = function()
    UI.SetNextItemWidth(Inputs.Widths.Custom) UI.InputInt("Minutes", Inputs.Buffers.Custom_Gap, 1, 5, ImGuiInputTextFlags_AutoSelectAll)
end

-- ------------------------------------------------------------------------------------------------------
-- Creates the entry field for custom count.
-- ------------------------------------------------------------------------------------------------------
Inputs.Custom_Count_Field = function()
    UI.SetNextItemWidth(Inputs.Widths.Custom) UI.InputInt("# Windows", Inputs.Buffers.Custom_Count, 1, 5, ImGuiInputTextFlags_AutoSelectAll)
end

-- ------------------------------------------------------------------------------------------------------
-- Creates the entry field for minutes.
-- ------------------------------------------------------------------------------------------------------
Inputs.Minutes_Field = function()
    UI.SetNextItemWidth(Inputs.Widths.Minute) UI.InputText("Minutes", Inputs.Buffers.Minutes, 4, ImGuiInputTextFlags_AutoSelectAll)
end

-- ------------------------------------------------------------------------------------------------------
-- Creates a multi-line text field for multi-input.
-- ------------------------------------------------------------------------------------------------------
Inputs.Multiple_Field = function()
    UI.InputTextMultiline("Create Multiple", Inputs.Buffers.Multiple, 4096, {Inputs.Widths.Multiple, UI.GetTextLineHeight() * 15 },  ImGuiInputTextFlags_AutoSelectAll)
end

-- ------------------------------------------------------------------------------------------------------
-- Validates name input.
-- ------------------------------------------------------------------------------------------------------
---@param not_required? boolean
---@return boolean
---@return string
---@return string
-- ------------------------------------------------------------------------------------------------------
Inputs.Validate_Name = function(not_required)
    local default_name = "Default Name"
    local name = Inputs.Get_Name()

    if not name then
        return false, Timers.Errors.ERROR, default_name
    elseif not not_required and string.len(name) == 0 then
        return false, Timers.Errors.NO_NAME, default_name
    elseif Timers.Timers[name] or Timers.Groups.Exists(name) then
        return false, Timers.Errors.EXISTS, default_name
    end

    return true, Timers.Errors.NO_ERROR, name
end

-- ------------------------------------------------------------------------------------------------------
-- Validates a time input.
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return string
---@return table
-- ------------------------------------------------------------------------------------------------------
Inputs.Validate_Time = function()
    local err = ""
    local default_time = {hour = 0, minute = 0, second = 0, meridiem = "AM"}

    local time = Inputs.Get_Time()
    if not time or time == "" then
        err = "{HH:MM:SS}"
        return false, err, default_time
    end

    local hours, minutes, seconds, meridiem = string.match(time, "(%d?%d):(%d?%d):(%d?%d)%s*(%a?%a?)")

    -- If a meridian was entered then need to make sure it is valid.
    if meridiem and meridiem ~= "" then
        if string.lower(meridiem) == "am" then
            meridiem = Inputs.Meridiem.AM
        elseif string.lower(meridiem) == "pm" then
            meridiem = Inputs.Meridiem.PM
        else
            err = "{HH:MM:SS}"
            return false, err, default_time
        end
    end

    -- Validate and adjust hours for AM/PM.
    if hours and minutes and seconds then
        hours   = tonumber(hours)
        minutes = tonumber(minutes)
        seconds = tonumber(seconds)

        local hour_check   = hours   >= 0 and hours   <= 24
        local minute_check = minutes >= 0 and minutes <= 59
        local second_check = seconds >= 0 and seconds <= 59
        if not (hour_check and minute_check and second_check) then
            err = "{HH:MM:SS}"
            return false, err, default_time
        end

        -- Hours will supercede meridiem. Meridiem only matters for values less than 13.
        -- If AM/PM is not entered for values less than 13 then we assume miliatry time.
        if hours == 12 then
            if meridiem == "" then meridiem = "AM" end
            if meridiem == "AM" then hours = hours - 12 end
        elseif hours <= 11 then
            if meridiem == Inputs.Meridiem.PM then
                hours = hours + 12
            else
                meridiem = "AM"
            end
        else
            meridiem = "PM"
        end
    else
        err = "{HH:MM:SS}"
        return false, err, default_time
    end

    return true, err, {hour = hours, minute = minutes, second = seconds, meridiem = string.upper(meridiem)}
end

-- ------------------------------------------------------------------------------------------------------
-- Validates date input.
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return string
---@return table
-- ------------------------------------------------------------------------------------------------------
Inputs.Validate_Date = function()
    local err = ""
    local now = os.time()
    local default_date = {month = os.date("%m", now), day = os.date("%d", now), year = os.date("%y", now)}

    local date = Inputs.Get_Date()
    if not date then
        err = "Date Required"
        return false, err, default_date
    end

    local month, day, year = string.match(date, "^(%d?%d)[/%-](%d?%d)[/%-](%d%d)$")

    if month and day and year then
        month = tonumber(month)
        day   = tonumber(day)
        year  = tonumber(year)

        local month_check = month >= 1 and month <= 12
        local day_check   = day   >= 1 and day <= 31
        if not (month_check and day_check) then
            err = "Date Required"
            return false, err, default_date
        end
    else
        err = "Date Required"
        return false, err, default_date
    end

    return true, err, {month = month, day = day, year = year}
end

-- ------------------------------------------------------------------------------------------------------
-- Validates gap input.
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return string
---@return integer
-- ------------------------------------------------------------------------------------------------------
Inputs.Validate_Gap = function()
    local err = ""
    local gap = tonumber(Inputs.Get_Custom_Gap())
    if not gap then
        err = "Gap Required"
        return false, err, 0
    end

    if gap <= 0 then
        err = "Positive Gap Required"
        return false, err, 0
    elseif gap > 720 then
        err = "Gap Too High"
        return false, err, 720
    end

    return true, err, gap
end

-- ------------------------------------------------------------------------------------------------------
-- Validates gap input.
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return string
---@return integer
-- ------------------------------------------------------------------------------------------------------
Inputs.Validate_Count = function()
    local err = ""
    local count = tonumber(Inputs.Get_Custom_Count())
    if not count then
        err = "Count Required"
        return false, err, 0
    end

    if count <= 0 then
        err = "Positive Count Required"
        return false, err, 0
    elseif count > 25 then
        err = "Gap Too High"
        return false, err, 25
    end

    return true, err, count
end

-- ------------------------------------------------------------------------------------------------------
-- Validates minute input.
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return string
---@return integer
-- ------------------------------------------------------------------------------------------------------
Inputs.Validate_Minutes = function()
    local err = ""
    local minutes = tonumber(Inputs.Get_Minutes())
    if not minutes then
        err = "Minutes Required"
        return false, err, 0
    end

    if minutes <= 0 then
        err = "Positive Minutes Required"
        return false, err, 0
    elseif minutes > 1440 then
        err = "Gap Too High"
        return false, err, 1440
    end

    return true, err, minutes
end

-- ------------------------------------------------------------------------------------------------------
-- Compute Relative Spawn Time
-- ------------------------------------------------------------------------------------------------------
---@return integer
-- ------------------------------------------------------------------------------------------------------
Inputs.Spawn_From_Clock_Gated = function(base_date, h, m, s, rel_sec, now_ts)
    now_ts = now_ts or os.time()

    local function ts_for_day_offset(offset_days)
        local d = { year = base_date.year, month = base_date.month, day = base_date.day + offset_days }
        local t = { hour = h, minute = m, second = s }
        return Timers.Make_Time_Table(d, t)
    end

    local ts0  = ts_for_day_offset(0)

    -- If no relative phrase, do NOT auto-roll. Just return base.
    if rel_sec == nil then
        return ts0
    end

    -- Future phrase: allow rolling forward if base time would be "too early"
    if rel_sec > 0 then
        -- choose whichever day (0 or +1) best matches rel_sec
        local ts1 = ts_for_day_offset(1)

        local d0 = ts0 - now_ts
        local d1 = ts1 - now_ts

        -- If base day is already future and close enough, keep it.
        -- Otherwise pick the closer one.
        if d0 >= 0 then
            if math.abs(d0 - rel_sec) <= math.abs(d1 - rel_sec) then return ts0 else return ts1 end
        else
            -- base is in the past but phrase says future -> roll forward
            return ts1
        end
    end

    -- Past phrase: do NOT roll forward. (Optionally roll backward to match)
    if rel_sec < 0 then
        local ts_1 = ts_for_day_offset(-1)

        local d0  = ts0  - now_ts
        local d_1 = ts_1 - now_ts

        -- We want a past timestamp that best matches rel_sec (negative).
        -- If base is already past, keep it unless yesterday matches better.
        if d0 <= 0 then
            if math.abs(d0 - rel_sec) <= math.abs(d_1 - rel_sec) then return ts0 else return ts_1 end
        else
            -- base is in the future but phrase says past -> roll backward
            return ts_1
        end
    end

    return ts0
end

-- ------------------------------------------------------------------------------------------------------
-- Parse Multi-Line String
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return string
-- ------------------------------------------------------------------------------------------------------
Inputs.Parse_Input = function(mode)
    local now = os.time()
    local base_date = Inputs.Get_Date_Table()
    local input = Inputs.Get_Multiple()
    if not input or input == "" then
        return false, "No Input"
    end

    for line in (input .. "\n"):gmatch("(.-)\n") do
        local valid, name, timestamp, rel_sec = Inputs.Parse_Line(line)
        if valid and name and timestamp then
            print("Valid: " .. tostring(valid) .. " | Name: " .. name .. " | Timestamp: " .. tostring(timestamp[1]) .. ":" .. tostring(timestamp[2]) .. ":" .. tostring(timestamp[3]))
        end
        if valid and name then
            -- Check if name is a known HNM
            local hnm_name, is_hnm, hnm_type = Utils.Canonicalize_HNM(name)
            print("Name: " .. hnm_name .. " | is_hnm: " .. tostring(is_hnm) .. " | HNM Type: " .. tostring(hnm_type))
            if is_hnm then
                print("Name: " .. hnm_name .. " | is_hnm: " .. tostring(is_hnm) .. " | HNM Type: " .. tostring(hnm_type))
                local rel_sec = Utils.Get_Relative_Seconds(line)
                --local spawn_ts = Inputs.Compute_Spawn_Time(line)
                local spawn_ts = Inputs.Spawn_From_Clock_Gated(base_date, timestamp[1], timestamp[2], timestamp[3], rel_sec, now)
                if spawn_ts then
                    local is_rel = Utils.Is_Relevant(now, spawn_ts, hnm_type)
                    print("Is Relevant?: " .. tostring(is_rel) .. " | Now: " .. tostring(now) .. " | Spawn Ts: " .. tostring(spawn_ts))
                    if is_rel and mode == "creation" then
                        -- CreateMultiple.Schedule = function(type, name, date, time, custom_info)
                        local date, time = Utils.Timestamp_To_DateTime(spawn_ts)
                        print("Date: " .. tostring(date) .. " | Time: " .. tostring(time))
                        CreateMultiple.Schedule(hnm_type, hnm_name, date, time, nil)
                    end
                end
            else
                if mode == "creation" then
                    print("Name: " .. name .. " | is_hnm: " .. tostring(is_hnm))
                    local spawn_ts = Input.Compute_Spawn_Time(line) 
                    if spawn_ts then
                        local date, time = Utils.Timestamp_To_DateTime(spawn_ts)
                        print("Date: " .. tostring(date) .. " | Time: " .. tostring(time))
                        CreateMultiple.Schedule(CreateMultiple.Type.Normal, name, date, time, nil)
                    end
                end
            end
        end
    end
    return true, "Completed successfully"
end

-- ------------------------------------------------------------------------------------------------------
-- Parse Single Line String
-- ------------------------------------------------------------------------------------------------------
---@return boolean
---@return name
---@return table{int}
---@return integer
-- ------------------------------------------------------------------------------------------------------
Inputs.Parse_Line = function(line)
    -- Check if line exists
    if not line or line == "" then
        return false, nil, nil
    end

    -- Attempt to pattern match for a timestamp
    local h, m, sec = Utils.Extract_Time(line)
    if not h or not m or not sec then
        return false, nil, nil
    end

    -- Validate timestamp
    if tonumber(m) > 59 or tonumber(sec) > 59 then
        return false, nil, nil
    end

    -- Get relative phrase
    local rel = Utils.Get_Relative_Seconds(line)
    if rel == nil then
        rel = 0 -- no relative phrase, assume no relativity 
    end

    -- Split string before timestamp
    local name = line:match("^([A-Za-z /]+)")

    -- Strip junk text
    if name then
        name = name:gsub("%s+", " ") -- whitespace
        name = Utils.Trim(name)
    end
    -- Check if left with valid name 
    if name == "" then
        return false, nil, nil
    end

    return true, name, {h, m, sec}, rel
end