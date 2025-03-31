# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции. \
***Ответ:*** Выполнено!

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.8.4

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider. \
***Ответ:*** В полях variable "cloud_id", variable "folder_id", variable "vms_ssh_public_root_key" пришлось для первой части домашки за хардкодить default значения, которые судя по всему, нужно будет переносить и делать правильно, судя по заданиям дальше, но variables.tf добавил в .gitignore
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net). \
***Ответ:*** Сделал, что видно на скриншотах ![1.2.1.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/1.2.1.png?raw=true), ![1.2.2.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/1.2.2.png?raw=true), ![1.2.3.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/1.2.3.png?raw=true).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**. \
***Ответ:*** Сделал
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть. \
***Ответ:*** Все ошибки были связаны с указание процессора, platform_id = "standard-v3" (так правильно, это Intel Ice Lake), а было platform_id = "standard-v4", 4 версии вообще нет. Так же нужно правильно указать остальные параметры было, cores = 2, core_fraction = 20, так соответствует документации. Как указано сейчас, видно на скриншоте ![1.5.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/1.5.png?raw=true)
6. Подключитесь к консоли ВМ через ssh и выполните команду ```curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.; \
***Ответ:*** IP адрес соответствует, можно увидеть на скриншоте ![1.6.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/1.6.png?raw=true)
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ. \
***Ответ:*** Параметр ```preemptible = true```, ставит виртуалку в состояние, чтобы по истечению 24 часов она выключится, такая виртуалка к тому же ещё и в 3 раза дешевле, в общем очень экономит средства в облаке. Параметр ```core_fraction=5```, говорит о том что Yandex гарантирует только 5% от мощности процессора, оставшие получим только в случае если они окажутся свободными, но такого как правило почти не происходит, тоже экономит затраты на виртуалку.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
![Console-ComputeCloud.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/Console-ComputeCloud.png?raw=true)
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
![1.6.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/1.6.png?raw=true)
- ответы на вопросы.


### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**. \
![2.1.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/2.1.png?raw=true)
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf.  \
![2.2.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/2.2.png?raw=true)
3. Проверьте terraform plan. Изменений быть не должно. \
![2.3.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/2.3.png?raw=true)


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ. \
***Ответ:*** Сделано, можно увидеть по [ссылке](https://github.com/Liberaty/ter_hw_2/blob/main/vms_platform.tf)
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b" \
***Ответ:*** Подтверждение по [ссылке](https://github.com/Liberaty/ter_hw_2/blob/main/another-code/task-2-terraform-apply.txt)
3. Примените изменения.
![3.1.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/3.1.png?raw=true)

### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения. \
***Ответ:*** Готово, вот [ссылка](https://github.com/Liberaty/ter_hw_2/blob/main/outputs.tf) на файл

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```. \
![4.1.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/4.1.png?raw=true)

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения. \
![5.1.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/5.1.png?raw=true)


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
***Ответ:*** Сделал не map, а сделал сразу список объектов, и на его основе уже сделал и 5 и 6 задание. Посчитал так правильнее, думал ещё for each использовать в main.tf, но не сходилось с вашим заданием сделать local переменную для имени VM. Очень надеюсь за считаете :)
![6.1.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/6.1.png?raw=true) \

3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  

***Ответ:*** Не совсем понял задачу из за куска кода, как я понял это пример того, как не надо... \
Я сделал как на скриншоте ниже, надеюсь верно, требованиям в задаче соответствует. \
![6.2.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/6.2.png?raw=true) \
5. Найдите и закоментируйте все, более не используемые переменные проекта.
***Ответ:*** Результат можно посмотреть по [ссылке](https://github.com/Liberaty/ter_hw_2/blob/main/vms_platform.tf) \
6. Проверьте terraform plan. Изменений быть не должно.
![6.3.png](https://github.com/Liberaty/ter_hw_2/blob/main/img/6.3.png?raw=true)
