library(tidyverse)

airquality

airquality %>%
  mutate(wind_km = Wind * 1.609344) %>%
  group_by(Month) %>%
  summarize(avg_wind_km = mean(wind_km, na.rm = T)) %>%
  arrange(desc(avg_wind_km)) %>%
  slice(1)


library(gapminder)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent))

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color = "red")

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = gdpPercap), color = "red")

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = 5)

ggplot(gapminder, aes(gdpPercap, lifeExp)) +
  geom_point(aes(color = continent)) +
  geom_smooth() +
  scale_x_log10()

ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent)) +
  geom_point() +
  geom_smooth() +
  scale_x_log10()

ggplot(data = gapminder,
       aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent)) +
  geom_smooth() +
  scale_x_log10() +
  scale_color_manual(values = c("red", "orange", "yellow", "green", "blue"))

ggplot(data = gapminder,
       aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent)) +
  geom_smooth() +
  scale_x_log10() +
  scale_color_brewer(palette = "Dark2")