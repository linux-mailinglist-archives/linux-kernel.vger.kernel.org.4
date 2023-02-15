Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5F6981F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBOR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBOR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:26:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801493BDB8;
        Wed, 15 Feb 2023 09:26:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so28428596lfb.13;
        Wed, 15 Feb 2023 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:signed-off-by:mime-version:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQlRafljLF9Q9uLLS136Iq6uLJFEx7qxm5tkam05qzg=;
        b=iLjS4lOZX/KVrpzmaicVmZgBMykWk8cTgH7vya1XHVB513g39ACTnCbs4UJDhgYYhZ
         sjetls07+lNA4iIIopCSuPGrZpMRsQvY6ab5DncyQA0R+5rgEc7DXmCXdwJLM5eH8oIo
         a094kHNoH9Wc8G7wDYTsZC9bR/QPcP4ngrh1x9L6QfJIzCnJaeqc5OEHKhvt3oDdg2Mt
         8le9UgRKGi3VmZkMaNkMKzxR22pUwghtWJsfIHPqKzHxJkh79kpUd7SlNgx6dXR/RvTG
         NHgeUCDYrYQvIagOsgFUgkuNvruoX5HaiFYRVtxLAQj0Y7vdbEaMGbnM7WAoRNAg1g6m
         By9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:signed-off-by:mime-version:message-id
         :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQlRafljLF9Q9uLLS136Iq6uLJFEx7qxm5tkam05qzg=;
        b=12xJGqNvwGvWZfrtl6xkKyDYkMQpKlU5MO5cNdW6KzcPinJ+pTNw3saRyt9PP1Goo6
         M28NQVUxca5BzpsXTnUSUKowUfjn9wKmY+fnpd2E6y27KRIzRgFY7noYdlPOF1MS/MMS
         jWVBiVKwO8LYbS3fmejeoOLcax16vkRPav0UpgD+uPk+KmDkIfHs4Lx387n/Ae75iqus
         owJdRuSMz6FwWOJQGlYnIIFwJGeSDeJ2Jv7/oW5+MrD6jh8Bnrs6J3sLQ6dHmsLdNN5x
         P+ScdpIoidj196jH49YbX+DbBmHMdYRCNXWij3CRm6QxgGd0ivVhY8kd3Sc5L43tuFya
         Qc5g==
X-Gm-Message-State: AO0yUKWKdxO6dEMOEf4XWSFishicv60IGoeugDKmpD/HoxTEu+CYNPQf
        58sk/MRxvf9z0f97CdCEnZCGnPLO3LjncySG
X-Google-Smtp-Source: AK7set9gPL7L42GyeyJ+gu/w3H+9HxMa96M1/VcVKMAMU0zHrfuw8VGW7Fvr+NUNOfa09LxIukLcYQ==
X-Received: by 2002:ac2:5a45:0:b0:4a4:68b8:c2ad with SMTP id r5-20020ac25a45000000b004a468b8c2admr661689lfn.4.1676481990772;
        Wed, 15 Feb 2023 09:26:30 -0800 (PST)
Received: from pc.. ([46.8.32.101])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b004d988f59633sm1280502lfe.161.2023.02.15.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:26:30 -0800 (PST)
From:   andybeg <andybeg@gmail.com>
To:     jdelvare@suse.com
Cc:     andybeg <andybeg@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: max34409 driver added
Date:   Wed, 15 Feb 2023 20:26:12 +0300
Message-Id: <20230215172613.359079-1-andybeg@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Signed-off-by: andybeg <andybeg@gmail.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/hwmon/max34409.rst b/Documentation/hwmon/max34409.rst
new file mode 100644
index 000000000000..91779c6a9163
--- /dev/null
+++ b/Documentation/hwmon/max34409.rst
@@ -0,0 +1,23 @@
+Kernel driver max34409
+=====================
+
+Supported chips:
+  * Analog Devices MAX34409
+    Prefix: 'max34409'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+
+Author: Andrey Kononov <a.kononov@gagarin.me>
+
+
+Description
+-----------
+
+This driver for SMBus Dual/Quad Current Monitor MaximIntegrated MAX34409
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst
+for details.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 3176c33af6c6..de412f7dcad8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1088,6 +1088,13 @@ config SENSORS_MAX31760
 	  This driver can also be built as a module. If so, the module
 	  will be called max31760.
 
+config SENSORS_MAX3440X
+	tristate "Maxim max3440x SMBus Dual/Quad Current Monitor"
+	depends on I2C
+	help
+	  Say yes here to build support for Maxim family of SMBus Dual/Quad Current Monitors.
+	  This driver is mutually exclusive with the HWMON version.
+
 config SENSORS_MAX6620
 	tristate "Maxim MAX6620 fan controller"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e2e4e87b282f..a4e24d2b03c1 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
 obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
 obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
 obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
+obj-$(CONFIG_SENSORS_MAX3440X)  += max3440x.o
 obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
 obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
diff --git a/drivers/hwmon/max3440x.c b/drivers/hwmon/max3440x.c
new file mode 100644
index 000000000000..b62c34f9425c
--- /dev/null
+++ b/drivers/hwmon/max3440x.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+*
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+/*
+ * Registers description.
+ */
+#define MAX3440X_STATUS             0x00
+#define MAX3440X_CONTROL            0x01
+#define MAX3440X_OCDELAY            0x02
+#define MAX3440X_SDDELAY            0x03
+#define MAX3440X_ADC1               0x04	/* readonly */
+#define MAX3440X_ADC2               0x05	/* readonly */
+#define MAX3440X_ADC3               0x06	/* readonly */
+#define MAX3440X_ADC4               0x07	/* readonly */
+#define MAX3440X_OCT1               0x08
+#define MAX3440X_OCT2               0x09
+#define MAX3440X_OCT3               0x0A
+#define MAX3440X_OCT4               0x0B
+#define MAX3440X_DID                0x0C	/* readonly */
+#define MAX3440X_DCYY               0x0D	/* readonly */
+#define MAX3440X_DCWW               0x0E    /* readonly */
+
+//maximal current in mA throw RSENSE, that can be measured. see datasheet table 18
+static unsigned short imax[4];
+module_param_array(imax, short, NULL, 0);
+MODULE_PARM_DESC(imax,
+		 "maximal current in mA throw RSENSE, that can be measured. see datasheet table 18");
+struct max3440x_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+	const char *name;
+
+   struct mutex update_lock;
+   bool valid;
+
+	u16 adc[4];
+	u8 oct[4];
+};
+
+static const char * const input_names[] = {
+	[MAX3440X_ADC1]	=	"curr1",
+	[MAX3440X_ADC2]	=	"curr2",
+	[MAX3440X_ADC3]	=	"curr3",
+	[MAX3440X_ADC4]	=	"curr4",
+};
+
+static void max3440x_init_client(struct max3440x_data *data,
+				struct i2c_client *client)
+{
+	u8 status;
+   u16 val = 0;
+	/*
+	 * Start the conversions.
+	 */
+	status = i2c_smbus_read_byte_data(client, MAX3440X_STATUS);
+
+val = (u16)i2c_smbus_read_byte_data(client, MAX3440X_ADC1);
+	data->adc[0] = DIV_ROUND_CLOSEST((imax[0] * val), 256);
+	val = i2c_smbus_read_byte_data(client, MAX3440X_ADC2);
+	data->adc[1] = DIV_ROUND_CLOSEST((imax[1] * val), 256);
+	val = i2c_smbus_read_byte_data(client, MAX3440X_ADC3);
+	data->adc[2] = DIV_ROUND_CLOSEST((imax[2] * val), 256);
+	val = i2c_smbus_read_byte_data(client, MAX3440X_ADC4);
+	data->adc[3] = DIV_ROUND_CLOSEST((imax[3] * val), 256);
+}
+
+static struct max3440x_data *max3440x_update_device(struct device *dev)
+{
+	struct max3440x_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	u16 val;
+
+	mutex_lock(&data->update_lock);
+
+	dev_dbg(dev, "Updating max3440 data.\n");
+	val = (u16)i2c_smbus_read_byte_data(client,
+				MAX3440X_ADC1);
+	data->adc[0] = DIV_ROUND_CLOSEST((imax[0] * val), 256);
+	val =  (u16)i2c_smbus_read_byte_data(client,
+				MAX3440X_ADC2);
+	data->adc[1] = DIV_ROUND_CLOSEST((imax[1] * val), 256);
+	val = (u16)i2c_smbus_read_byte_data(client,
+				MAX3440X_ADC3);
+	data->adc[2] = DIV_ROUND_CLOSEST((imax[2] * val), 256);
+	val = (u16)i2c_smbus_read_byte_data(client,
+				MAX3440X_ADC4);
+	data->adc[3] = DIV_ROUND_CLOSEST((imax[3] * val), 256);
+
+	data->valid = 1;
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+static ssize_t adc1_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
+	struct max3440x_data *data = max3440x_update_device(dev);
+
+	return sprintf(buf, "%d\n", data->adc[0]);
+}
+static ssize_t adc2_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
+	struct max3440x_data *data = max3440x_update_device(dev);
+
+	return sprintf(buf, "%d\n", data->adc[1]);
+}
+static ssize_t adc3_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
+	struct max3440x_data *data = max3440x_update_device(dev);
+
+	return sprintf(buf, "%d\n", data->adc[2]);
+}
+static ssize_t adc4_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *attr2 = to_sensor_dev_attr(attr);
+	struct max3440x_data *data = max3440x_update_device(dev);
+
+	return sprintf(buf, "%d\n", data->adc[3]);
+}
+
+static ssize_t label_show(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
+{
+	return sprintf(buf, "%s\n",
+		       input_names[to_sensor_dev_attr(devattr)->index]);
+}
+
+static SENSOR_DEVICE_ATTR_RO(curr1_input, adc1, 0);
+static SENSOR_DEVICE_ATTR_RO(curr1_label, label, MAX3440X_ADC1);
+static SENSOR_DEVICE_ATTR_RO(curr2_input, adc2, 0);
+static SENSOR_DEVICE_ATTR_RO(curr2_label, label, MAX3440X_ADC2);
+static SENSOR_DEVICE_ATTR_RO(curr3_input, adc3, 0);
+static SENSOR_DEVICE_ATTR_RO(curr3_label, label, MAX3440X_ADC3);
+static SENSOR_DEVICE_ATTR_RO(curr4_input, adc4, 0);
+static SENSOR_DEVICE_ATTR_RO(curr4_label, label, MAX3440X_ADC4);
+
+static struct attribute *max3440x_attrs[] = {
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_label.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_label.dev_attr.attr,
+	&sensor_dev_attr_curr3_input.dev_attr.attr,
+	&sensor_dev_attr_curr3_label.dev_attr.attr,
+	&sensor_dev_attr_curr4_input.dev_attr.attr,
+	&sensor_dev_attr_curr4_label.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(max3440x);
+
+static int max3440x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct max3440x_data *data;
+	struct device *hwmon_dev;
+
+	data = devm_kzalloc(dev, sizeof(struct max3440x_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	/* Initialize the MAX3440x chip */
+	max3440x_init_client(data, client);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   max3440x_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+
+static const struct i2c_device_id max3440x_id[] = {
+	{ "max34409", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, max3440x_id);
+
+static const struct i2c_driver max3440x_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "max3440x",
+	},
+	.probe = max3440x_probe,
+	.id_table	= max3440x_id,
+};
+
+module_i2c_driver(max3440x_driver);
+
+MODULE_AUTHOR("Andrey Kononov");
+MODULE_DESCRIPTION("I2C adc driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1
