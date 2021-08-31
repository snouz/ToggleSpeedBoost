local ICONPATH = "__ToggleSpeedBoost__/graphics/"

data:extend({
    {
        type = "sprite",
        name = "togglespeedboost_off_button",
        filename = ICONPATH .. "togglespeedboost_off_button.png",
        flags = { "gui-icon" },
        width = 64,
        height = 64,
        scale = 0.5,
        priority = "extra-high-no-scale",
    },
    {
        type = "sprite",
        name = "togglespeedboost_on_button",
        filename = ICONPATH .. "togglespeedboost_on_button.png",
        flags = { "gui-icon" },
        width = 64,
        height = 64,
        scale = 0.5,
        priority = "extra-high-no-scale",
    }
})
