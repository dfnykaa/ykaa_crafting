Config = {}

Config.Locations = {
    {
        coords = vec3(154.0679, -3110.1008, 5.8963), -- Location where is standing crafting
        heading = 270.0,
        model = `gr_prop_gr_bench_01a`
    }
}

Config.Items = {
    {
        label = "Pistol",
        item = "weapon_pistol", -- item name
        duration = 20000, -- in seconds
        ingredients = {
            { item = "scrap", count = 10 } -- The item you need to make
        }
    },
}