a=10

if [ $a -eq 10 ]
then
  echo a is 10
fi

---
a=12

if [ $a -eq 10 ]
then
  echo a is 10
else
  echo a is not 10
fi
---