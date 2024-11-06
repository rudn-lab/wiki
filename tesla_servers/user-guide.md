# Как использовать Тесла-сервер

> Актуальная информация находится по ссылке: https://github.com/rudn-lab/wiki/tree/main/tesla_servers

1. Сгенерировать себе SSH-ключ и передать публичный ключ одному из админов сервера. Если вы пользуетесь SSH в GitHub, то ваш публичный ключ можно скачать с вашего профиля по ссылке `https://github.com/<ваш логин>.keys`: например, [https://github.com/gmatiukhin.keys](https://github.com/gmatiukhin.keys). После этого админ добавит ваш ключ к ключам вашего пользователя и скажет вам имя этого пользователя
2. Оказаться в вузовской сети. Это можно сделать, физически присутствуя в корпусе на Орджоникидзе, или с помощью одного из VPN.
3. Подключиться к серверу по SSH. Актуальный адрес -- `tesla.uni.rudn-lab.ru`. На момент написания текста он имел IP-адрес `10.131.0.57`.
4. Будет автоматически активировано окружение [Conda](https://docs.conda.io/en/latest/) -- пакетного менеджера для Python. С помощью него мы устанавливаем библиотеки, которые работают с Теслой: текущие версии библиотек не работают с нашей Теслой.
5. Создать новое окружение для вашего проекта, затем установить нужные библиотеки. Мы также предоставили файлы `sample-pytorch-env.yaml` и `sample-tensorflow-env.yaml`: вы можете использовать их как основу описания окружения для вашего проекта.

Пример для PyTorch:

```bash
conda env create -n pytorch-hello-world --file ~/sample-pytorch-env.yaml
conda activate pytorch-hello-world
```

```python
import torch
import time
print("CUDA?", torch.cuda.is_available())
for device_id in range(torch.cuda.device_count()):
    print("Device", device_id, ":", torch.cuda.get_device_name(device_id))

random_vector = torch.rand((10000, 10000), dtype=torch.float32)

print("Vector is on ", random_vector.device)


start = time.perf_counter()
res_cpu = random_vector ** 2
print("Time to multiply:", time.perf_counter() - start)

print("Moving to GPU")
start = time.perf_counter()
random_vector = random_vector.to(torch.device('cuda'))
print("Time to move:", time.perf_counter() - start)

print("Vector is now on ", random_vector.device)

start = time.perf_counter()
res_gpu = random_vector ** 2
print("Time to multiply:", time.perf_counter() - start)

print("Moving result back to CPU")
start = time.perf_counter()
res_gpu_moved = res_gpu.to(torch.device('cpu'))
print("Time to move:", time.perf_counter() - start)

print("Results are equal?", torch.equal(res_cpu, res_gpu_moved))
```

Пример для TensorFlow:

```bash
conda env create -n tensorflow-hello-world --file ~/sample-tensorflow-env.yaml
conda activate tensorflow-hello-world
```

```python
import os
# задать уровень логов от Tensorflow: https://stackoverflow.com/a/40871012
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # or any {'0', '1', '2'}


import tensorflow as tf
import time
print("CUDA?", tf.config.list_physical_devices('GPU'))

random_vector = tf.random.uniform([10000, 10000], dtype=tf.float32)

print("Vector is on ", random_vector.device)

start = time.perf_counter()
res_cpu = random_vector ** 2
print("Time to multiply:", time.perf_counter() - start)

print("Moving to GPU")
start = time.perf_counter()
random_vector = random_vector.gpu()
print("Time to move:", time.perf_counter() - start)

print("Vector is now on ", random_vector.device)

start = time.perf_counter()
res_gpu = random_vector ** 2
print("Time to multiply:", time.perf_counter() - start)

print("Moving result back to CPU")
start = time.perf_counter()
res_gpu_moved = res_gpu.cpu()
print("Time to move:", time.perf_counter() - start)

print("Results are equal?", tf.reduce_all(tf.equal(res_cpu, res_gpu_moved)))
```