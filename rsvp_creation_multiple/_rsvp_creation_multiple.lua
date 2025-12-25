CreateMultiple = T{}

CreateMultiple.Defaults = T{
    X_Pos  = 100,
    Y_Pos  = 100,
    Visible = {true},
}

CreateMultiple.Table_Flags = bit.bor(ImGuiSelectableFlags_None)

CreateMultiple.ALIAS = "create"
CreateMultiple.Scaling_Set = true
CreateMultiple.Reset_Position = true

CreateMultiple.Type = T{
    Normal = 1,
    King   = 2,
    Wyrm   = 3,
    Custom = 4,
}

require("rsvp_creation_multiple.buttons")

-- ------------------------------------------------------------------------------------------------------
-- Show the reminder creation window.
-- ------------------------------------------------------------------------------------------------------
CreateMultiple.Display = function()
    if RSVP.CreateMultiple.Visible[1] then
        if CreateMultiple.Reset_Position then
            UI.SetNextWindowPos({RSVP.CreateMultiple.X_Pos, RSVP.CreateMultiple.Y_Pos}, ImGuiCond_Always)
            CreateMultiple.Reset_Position = false
        end
        UI.PushStyleColor(ImGuiCol_WindowBg, Window.Colors.DEFAULT)
        if UI.Begin("RSVP Multi-Creation", RSVP.CreateMultiple.Visible, Window.Window_Flags) then
            RSVP.CreateMultiple.X_Pos, RSVP.CreateMultiple.Y_Pos = UI.GetWindowPos()
            CreateMultiple.Set_Window_Scaling()
            Inputs.Date_Field()
            Inputs.Multiple_Field()
            if UI.Button("Add") then
                Inputs.Parse_Input("creation")
            end
        end
        UI.End()
        UI.PopStyleColor(1)
    end
end

-- ------------------------------------------------------------------------------------------------------
-- Returns whether the window scaling needs to be updated.
-- ------------------------------------------------------------------------------------------------------
CreateMultiple.Is_Scaling_Set = function()
    return Create.Scaling_Set
end

-- ------------------------------------------------------------------------------------------------------
-- Sets the window scaling update flag.
-- ------------------------------------------------------------------------------------------------------
CreateMultiple.Set_Scaling_Flag = function(scaling)
    Create.Scaling_Set = scaling
end

------------------------------------------------------------------------------------------------------
-- Sets the window scaling.
------------------------------------------------------------------------------------------------------
CreateMultiple.Set_Window_Scaling = function()
    if not Create.Is_Scaling_Set() then
        UI.SetWindowFontScale(Config.Get_Scale())
        Create.Set_Scaling_Flag(true)
    end
end

-- ------------------------------------------------------------------------------------------------------
-- Create a quick button to set a reminder {minutes} into the future.
-- ------------------------------------------------------------------------------------------------------
---@param type integer
---@param name string
---@param date table
---@param time table
---@param custom_info? table
-- ------------------------------------------------------------------------------------------------------
CreateMultiple.Schedule = function(type, name, date, time, custom_info)
    local timestamp  = Timers.Make_Time_Table(date, time)
    if type == CreateMultiple.Type.Normal then
        local future_minutes = (timestamp - os.time()) / 60
        Timers.Start(name, future_minutes)
    elseif type == CreateMultiple.Type.King then
        local future_minutes = (timestamp - os.time()) / 60
        for i = 0, 6, 1 do
            local timer_name = name .. " (" .. tostring(i + 1) .. "/7)"
            Timers.Start(timer_name, future_minutes + (10 * i), name)
        end
    elseif type == CreateMultiple.Type.Wyrm then
        local future_minutes = (timestamp - os.time()) / 60
        for i = 0, 24, 1 do
            local timer_name = name .. " (" .. tostring(i + 1) .. "/25)"
            Timers.Start(timer_name, future_minutes + (60 * i), name)
        end
    elseif type == CreateMultiple.Type.Custom then
        
        local future_minutes = (timestamp - os.time()) / 60
        for i = 0, custom_info.count, 1 do
            local timer_name = name .. " (" .. tostring(i + 1) .. "/" .. tostring(custom_info.count + 1) .. ")"
            Timers.Start(timer_name, future_minutes + (custom_info.gap * i), name)
        end
    end
end