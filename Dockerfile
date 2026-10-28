FROM python:3.10-slim

# ضبط متغيرات البيئة لمنع التخزين المؤقت وحجم السجلات
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# تثبيت أدوات النظام المطلوبة لمكتبة uvloop وباقي التحسينات
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# تثبيت المكتبات من requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# نسخ باقي ملفات المشروع
COPY . .

# أمر تشغيل البوت
CMD ["python", "bot.py"]
