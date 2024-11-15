sudo apt-get install git
git config --global color.ui true
git config --global user.name "levii"
git config --global user.email "levi46595@gmail.com"
ssh-keygen
ls -a ~/.ssh

ssh-add -l
cat ~/.ssh/id_rsa.pub
Select and copy the key output in the clipboard.
Paste the copied public key into the SSH Key field.
ssh -T git@github.com




#!/bin/bash

# Проверяем, установлен ли Git
if ! command -v git &> /dev/null
then
    echo "Git не установлен. Скачайте и установите Git с https://git-scm.com/downloads"
    exit 1
fi

# Настройка имени пользователя и email
echo "Введите ваше имя для Git:"
read user_name
git config --global user.name "$user_name"

echo "Введите ваш email для Git:"
read user_email
git config --global user.email "$user_email"

# Проверка настроек
echo "Ваши настройки Git:"
git config --global --list

# Проверка существования папки .ssh
if [ ! -d "$HOME/.ssh" ]; then
    echo "Папка .ssh не найдена. Создаём её..."
    mkdir -p "$HOME/.ssh"
fi

# Генерация SSH-ключа
echo "Генерация SSH-ключа..."
ssh-keygen -t rsa -b 4096 -C "levi46595@gmail.com" -f "$HOME/.ssh/id_rsa" -N ""

# Запуск ssh-agent
echo "Запуск ssh-agent..."
eval $(ssh-agent -s)

# Добавление SSH-ключа в агент
echo "Добавление SSH-ключа в агент..."
ssh-add "$HOME/.ssh/id_rsa"

# Копирование публичного ключа в буфер обмена
echo "Ваш публичный ключ SSH:"
cat "$HOME/.ssh/id_rsa.pub"

echo "Скопируйте публичный ключ и добавьте его в ваш профиль GitHub или другой сервис (Settings -> SSH and GPG keys -> New SSH key)."

# Вывод инструкции по проверке соединения
echo "Для проверки соединения с GitHub выполните команду:"
echo "  ssh -T git@github.com"
