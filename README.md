# Perlcat version 1.0

Simple and compact netcat clone written in Perl for easy transportability. As a use case, compress and copy/paste Perlcat over a remote terminal connection to a minimal Docker container:

```console
$ cat perlcat.pl | gzip | base64 -w 0     
H4sIAAAAAAAAA6VWWW/iSBB+tn9FYdBgFIxB2pclAinKRCOkLCBg5mEZJjJ2E6yYbm+3nWMzmd++1YcPsiSKNJGSuKuq6/jq6mbDzwX3tzH1U8ITOxcERMbjMDtX3w8BpzG9Ffo0mQ2HSxbeEeTaTRD5lrM8iykRNn5DwG8J526r82wD/qQ8phksV5+vFgtw8M9sMQSn17pZ9zc95zt1zpVYLoJb4nbO7RelxBxPqfgqWUNo9WE9m68ms+lyA+vPV8vVZHohjzCZb2A+W6xK3cf3Z2kWMyqGb7ABvASKn1lKKAQ0giQWGX6uLueQMp69fTeFtbS9gQ/I3pd2vhG+ZYKUouQxzmAgwUCAD0FM7cMTtIIo4ufqS+od/dnvD/RRezfq69O9ViaPeDsNOOYMk5IfCM1Er9eTROWKAhniHVBWCdjxzm01LxZfvsFoBN7A5MBk1ZnWRBtOx7goSMDDPewYhz1J0lLERorb7/W0QqNKGpDHdetmA6NfcPA9T97y4edPeM3Z+x14tq2yPKSCF230lmTAdDJV3JwEkQLG4CDP5JGE8vwxP35468D798L7e3Pmw6dPlUoJRR+vWVIv2hQwqjw9ty1D+wXC/9HzfaSgQRKEe1ekSZy57XZX3+tIJYXxGyD/gJM4kmYVScSUWjpI9Y8kohJNjWgZ6XvC90a4KIea7IuBsXanHqnMuXUEp3WEVUNh9T06a/lFOEV5yNoH8USz4BGQwLiqETRotbT2OmxlLsuSOxuMi4KTSAszZYpzyCglocw46lRU7A4WEWA7rATCA8kqc2t6tkjdUZUGFMfE/R9A88OWcCQlCXsgEWyfIFBdazj1yJWH3qCoFYy/V/tt6YqpidYEK6BUE1cwFDpNbl6BpNUo/JQjjYjscM5GWgs2RgH7ZK6m1En0X15dlSY+fFXHr3xuvBG1bFrl9jtl8Z4RHV0TQiy4DPeOyjngfCJ8F4QEK8eQRkDJQ237DIeT6dXK1ZbmnGUMRmNoZ2Ha7hoiIfxC4T3WkNXoc4X0WPtu6Asi9xsSB4awig8Ed5si9aWrthXFBJxLlicRjs3s2GvcSg2c4ZDThAhR1S/GUJWuTG+9sMs2JKCq1JQtCkrPdAJMD3eeXy2RayWLq7kQx81qstFzcNTLhQK/BS8YfK9ZGCSnMDsJ/LVpvQrJGrS/g2MTgjAkKconMe4XqGDVs9mQS4i9sZaXq+N9KC+rBO04OyggtTZvnGK97JlALaCfLArTVznVwvWcmgmF8+YOHniMiCuKjjyg7azOkjGXEZtmdWVIip3GEdqQ4m5HhqI1q+UC2Z4ojhl84JZXOrqiQpY+KSmTacyXyLAfAx4BVneaZxq8bb7bEXxhWA/7OCFuLT5vLLeBayS6g3KNiSehjLkI4+zrqltJ6KnfhOXky+pq8Zc0ajCw7uIkcR1JdbpVfJ3T7aCcL92NKXordVXhnPQd/VIeo1uTabdgd6Hy/Cg6HYOR0q5rXwzQYcLEid6RTMVyTbl1as+3vnwbyTj+94CqT0OTafOU+g9j3wa8iQsAAA==
```

```console
$ echo -n H4sIAAAAAAAAA6VWWW/iSBB+tn9FYdBgFIxB2pclAinKRCOkLCBg5mEZJjJ2E6yYbm+3nWMzmd++1YcPsiSKNJGSuKuq6/jq6mbDzwX3tzH1U8ITOxcERMbjMDtX3w8BpzG9Ffo0mQ2HSxbeEeTaTRD5lrM8iykRNn5DwG8J526r82wD/qQ8phksV5+vFgtw8M9sMQSn17pZ9zc95zt1zpVYLoJb4nbO7RelxBxPqfgqWUNo9WE9m68ms+lyA+vPV8vVZHohjzCZb2A+W6xK3cf3Z2kWMyqGb7ABvASKn1lKKAQ0giQWGX6uLueQMp69fTeFtbS9gQ/I3pd2vhG+ZYKUouQxzmAgwUCAD0FM7cMTtIIo4ufqS+od/dnvD/RRezfq69O9ViaPeDsNOOYMk5IfCM1Er9eTROWKAhniHVBWCdjxzm01LxZfvsFoBN7A5MBk1ZnWRBtOx7goSMDDPewYhz1J0lLERorb7/W0QqNKGpDHdetmA6NfcPA9T97y4edPeM3Z+x14tq2yPKSCF230lmTAdDJV3JwEkQLG4CDP5JGE8vwxP35468D798L7e3Pmw6dPlUoJRR+vWVIv2hQwqjw9ty1D+wXC/9HzfaSgQRKEe1ekSZy57XZX3+tIJYXxGyD/gJM4kmYVScSUWjpI9Y8kohJNjWgZ6XvC90a4KIea7IuBsXanHqnMuXUEp3WEVUNh9T06a/lFOEV5yNoH8USz4BGQwLiqETRotbT2OmxlLsuSOxuMi4KTSAszZYpzyCglocw46lRU7A4WEWA7rATCA8kqc2t6tkjdUZUGFMfE/R9A88OWcCQlCXsgEWyfIFBdazj1yJWH3qCoFYy/V/tt6YqpidYEK6BUE1cwFDpNbl6BpNUo/JQjjYjscM5GWgs2RgH7ZK6m1En0X15dlSY+fFXHr3xuvBG1bFrl9jtl8Z4RHV0TQiy4DPeOyjngfCJ8F4QEK8eQRkDJQ237DIeT6dXK1ZbmnGUMRmNoZ2Ha7hoiIfxC4T3WkNXoc4X0WPtu6Asi9xsSB4awig8Ed5si9aWrthXFBJxLlicRjs3s2GvcSg2c4ZDThAhR1S/GUJWuTG+9sMs2JKCq1JQtCkrPdAJMD3eeXy2RayWLq7kQx81qstFzcNTLhQK/BS8YfK9ZGCSnMDsJ/LVpvQrJGrS/g2MTgjAkKconMe4XqGDVs9mQS4i9sZaXq+N9KC+rBO04OyggtTZvnGK97JlALaCfLArTVznVwvWcmgmF8+YOHniMiCuKjjyg7azOkjGXEZtmdWVIip3GEdqQ4m5HhqI1q+UC2Z4ojhl84JZXOrqiQpY+KSmTacyXyLAfAx4BVneaZxq8bb7bEXxhWA/7OCFuLT5vLLeBayS6g3KNiSehjLkI4+zrqltJ6KnfhOXky+pq8Zc0ajCw7uIkcR1JdbpVfJ3T7aCcL92NKXordVXhnPQd/VIeo1uTabdgd6Hy/Cg6HYOR0q5rXwzQYcLEid6RTMVyTbl1as+3vnwbyTj+94CqT0OTafOU+g9j3wa8iQsAAA== | base64 -d | gunzip >perlcat.pl
```

