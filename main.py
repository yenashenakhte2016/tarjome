import telebot
from telebot import types
import requests
import simplejson as json

TOKEN = '249172911:AAEyC8i6KxP80JJXTSOmD5m0WWdahMFEaSQ'
API_PATH = 'http://api.vajehyab.com/v2/public'

bot = telebot.TeleBot(TOKEN)


@bot.message_handler(commands=['start'])
def start_command_handler(msg):
    start_msg = '''
سلام
به ربات ترجمه زبان خوش آمدید.
برای دریافت راهنمایی لطفا /help را بفرستید
'''
    if msg.chat.type == 'private':
        bot.send_message(msg.chat.id, start_msg)
    elif msg.chat.type in ['group', 'supergroup']:
        bot.reply_to(msg.id, start_msg)


@bot.message_handler(commands=['help'])
def help_command_handler(msg):
    help_msg = '''
استفاده از این ربات بسیار ساده است.
کافی است کلمه مورد نظر خود را در پیام خصوصی برای ربات ارسال نمایید تا معنای آن را دریافت کنید.
همچنین، برای استفاده اینلاین از ربات، کافی است پس از ارسال دستور /start در پیام شخصی ربات، برای گیرنده مورد نظر خود پیام زیر را نوشته و معنای آن را انتخاب نمایید تا ارسال شود.
@TranslateLang_Bot کلمه
را تایپ کنید و به جای کلمه متن خود را بگذارید
'''
    if msg.chat.type == 'private':
        bot.send_message(msg.chat.id, help_msg)
    elif msg.chat.type in ['group', 'supergroup']:
        bot.reply_to(msg.id, help_msg)


@bot.message_handler(func=lambda m: m.chat.type == 'private' and m.text != '')
def private_handler(msg):
    response = requests.get(API_PATH, {'q': msg.text, 'improve': 1})
    data = json.loads(response.text).get('data')
    if not data.get('title'):
        text = 'نتیجه‌ای یافت نشد.'
    else:
        text = '_{}_:\n{}\nبرگرفته از _{}_'.format(data.get('title'), data.get('text'), data.get('source'))
    bot.send_message(msg.chat.id, text, parse_mode='Markdown')


@bot.message_handler(func=lambda m: m.chat.type in ['group', 'supergroup'] and m.text != '')
def private_handler(msg):
    response = requests.get(API_PATH, {'q': msg.text, 'improve': 1})
    data = json.loads(response.text).get('data')
    if not data.get('title'):
        text = 'نتیجه‌ای یافت نشد.'
    else:
        text = '_{}_:\n{}\nبرگرفته از _{}_'.format(data.get('title'), data.get('text'), data.get('Core Telegram Translate'))
    bot.reply_to(msg.id, text, parse_mode='Markdown')


@bot.inline_handler(lambda q: True)
def send_inline(q):
    if q.query == '':
        q.query = 'ایران'
    response = requests.get(API_PATH, {'q': q.query, 'improve': 1})
    data = json.loads(response.text).get('data')
    text = '_{}_:\n{}\nبرگرفته از _{}_'.format(data.get('title'), data.get('text'), data.get('Core Telegram Translate'))
    r = types.InlineQueryResultArticle('1', data.get('title'), text, 'Markdown', description=data.get('text'))
    bot.answer_inline_query(q.id, [r])


bot.polling(none_stop=True)
