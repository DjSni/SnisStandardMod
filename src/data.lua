require("config")
-- Loader Hinzufügen
require("data-update")

-- Größeren Inventar
data.raw["player"]["player"].inventory_size = 120
-- Nachtsicht nicht Grün
-- data.raw["night-vision-equipment"]["night-vision-equipment"].tint = {r = 0, g = 0, b = 0, a = 0}
-- Größeren Werkzeuggürtel
data:extend(
{
  {
    type = "technology",
    name = "toolbelt-2",
    icon = "__base__/graphics/technology/toolbelt.png",
    effects =
    {
      {
        type = "num-quick-bars",
        modifier = 1
      }
    },
    prerequisites = {"toolbelt"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1}
      },
      time = 30
    },
    order = "c-k-n"
  },
  {
    type = "technology",
    name = "toolbelt-3",
    icon = "__base__/graphics/technology/toolbelt.png",
    effects =
    {
      {
        type = "num-quick-bars",
        modifier = 1
      }
    },
    prerequisites = {"toolbelt-2"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1}
      },
      time = 40
    },
    order = "c-k-o"
  }
})
-- 

