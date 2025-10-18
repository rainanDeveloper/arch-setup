#/bin/sh
available=$(yay -Qu | wc -l)

# choose color based on number of updates
if [ "$available" -eq 0 ]; then
  class="green" # green = up-to-date
elif [ "$available" -le 10 ]; then
  class="yellow" # yellow = small number of updates
else
  class="red" # red = many updates
fi

echo "{\"text\": \"  $available \", \"tooltip\": \"$available updates available\", \"class\": \"$class\"}"
