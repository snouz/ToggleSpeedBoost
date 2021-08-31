data:extend({
    {
        type = "bool-setting",
        name = "tsp_speedboostbutton",
        setting_type = "runtime-per-user",
        default_value = true,
        order = "a"
    },
    {
        type = "int-setting",
        name = "tsp_speedboostmuliplier",
        setting_type = "runtime-per-user",
        minimum_value = 2,
        maximum_value = 100,
        default_value = 5,
        order = "b"
    },
})
