Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0089A6D2F35
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDAJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDAJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:10:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BC1F7B3;
        Sat,  1 Apr 2023 02:10:28 -0700 (PDT)
Received: from localhost ([31.220.113.145]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MJV9M-1q2H1g1im0-00JtSz; Sat, 01 Apr 2023 11:10:12 +0200
Date:   Sat, 1 Apr 2023 11:10:11 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Message-ID: <ZCf085W4XL2PtQf6@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:DvT7hgd4S4Ap1f5nPGi8Kf82bj92YUKA9q0Wh3siyh1OtKLba6K
 Vzo6tKIcpbpG79TPT7BtaFBWY5lQj+IT5F5poOgHbgV6wnuneqdIKB+RdxWZW6byX4W5Jfb
 ednq2eWmDP8TmZD5nr2mpmwtBAvSCWu7jq+igFg4/3esfND5PJ3UPZf8UGD5YXcnNfF5QYw
 /fGkSvlP0Hzgt19FYBnDg==
UI-OutboundReport: notjunk:1;M01:P0:yaiFY1aPZzM=;nZPREhWNEbJ97bgDs6scvvuHxW+
 dDLDTL4cWGZILCLemc7xAOj/dVdJj7Uv/Wc7zhvm3MdbEo9oBnXyXhUwL/N/HTtS+epTQd+CH
 xQpbWK07Sauhw0Ct316Jlirxqu3HOvj+iTU6xCCJbm/0M95nlV0QmnU3Lz8HpWZWYekhRpipS
 FhifgTo4k2lV5Dy5UuxIAZcWJy0O84pRNIfNtNz8zukuGX4kP2seBepuC+lXQF4gLQSYDiYiL
 sRF8KrZlApkWoycYCGcwFtTdg4p26QUVnrbbT49ngZ/FehiCpYi3f1qhrHOcLTKSBh78iHiuN
 mTh22oreew1utV9OeWPtgfoUsQsyVrZvgz0cjwsjKHQ5ipgUtiH9EaWB8SngeIZYXphTQUeHC
 a5jv2ywx65Lp7qYb8nivZa0wVVvJIMX5UDzACDbNf2OLsWruHF5GLMcoNVO49Dowjw0fxccjW
 aX7hieAH1k/QlRv4MyvFCzWYpr2lnqJDERFbn5/0qQOnUE0ifqc1pEO+Vir5OZNoxh2kVL957
 P8A49EktH7uPCC+WbxBQaLW1/a0r0gCYmSC3wLhvYOtvHSRTd6DsUGOn1OBf37jiPR+IOZeRN
 dR99RKoDnqtG0oEkRu9RiZo8eGUSE2uHeLY5ayH+eFDl3c+q02y8ZXHCrssiMxMeQ4F160Mwg
 JGg/p8f6VegU9MENEldKfLty1xGQm6z95UhCJSyRWw==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honeywell mpr is a familiy of pressure sensors.

Add initial I2C support.

Note:
- Buffered mode is supported
- SPI mode is not supported

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/Kconfig  |  12 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/mpr.c    | 307 ++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/iio/pressure/mpr.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index c9453389e4f7..e3ec94036e3c 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -148,6 +148,18 @@ config MPL3115
 	  To compile this driver as a module, choose M here: the module
 	  will be called mpl3115.
 
+config MPR
+	tristate "Honeywell MPR (MicroPressure sensors)"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build support for the Honeywell MicroPressure pressure sensors MPR.
+	  There are many different types with different pressure range. These ranges can be set up
+	  in the device tree.
+
+	  To compile this driver as a module, choose M here: the module will be called mpr.
+
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 083ae87ff48f..b701d9c7187d 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MPL115) += mpl115.o
 obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
 obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
 obj-$(CONFIG_MPL3115) += mpl3115.o
+obj-$(CONFIG_MPR) += mpr.o
 obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
diff --git a/drivers/iio/pressure/mpr.c b/drivers/iio/pressure/mpr.c
new file mode 100644
index 000000000000..1728b42bee7e
--- /dev/null
+++ b/drivers/iio/pressure/mpr.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MPR - MicroPressure pressure sensor driver
+ *
+ * Copyright (c) Andreas Klinger <ak@it-klinger.de>
+ *
+ * Data sheet:
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
+ *    pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
+ *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ *
+ * 7-bit I2C default slave address: 0x18
+ *
+ */
+
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+/* bits in i2c status byte */
+#define MPR_I2C_POWER	BIT(6)	/* device is powered */
+#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
+#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
+#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
+
+struct mpr_data {
+	struct device		*dev;
+	void			*client;
+	struct mutex		lock;
+	s32			pmin;
+	s32			pmax;
+	struct gpio_desc	*gpiod_reset;
+	int			irq;
+	struct completion	completion;
+	s64			channel[2] __aligned(8);
+};
+
+static int mpr_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan, int *val,
+									int *val2, long mask);
+
+static const struct iio_chan_spec mpr_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 64,
+			.storagebits = 64,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_info mpr_info = {
+	.read_raw = &mpr_read_raw,
+};
+
+static void mpr_reset(struct mpr_data *data)
+{
+	if (data->gpiod_reset) {
+		gpiod_set_value(data->gpiod_reset, 0);
+		udelay(10);
+		gpiod_set_value(data->gpiod_reset, 1);
+	}
+}
+
+static int mpr_read_pressure(struct mpr_data *data, s64 *press)
+{
+	int ret, i;
+	u8 wdata[] = {0xAA, 0x00, 0x00};
+	s32 status;
+	int nloops = 10;
+	char buf[5];
+	s64 press_cnt;
+	s64 outputmin = 1677722;
+	s64 outputmax = 15099494;
+
+	reinit_completion(&data->completion);
+
+	ret = i2c_master_send(data->client, wdata, sizeof(wdata));
+	if (ret < 0) {
+		dev_err(data->dev, "error while writing ret: %d\n", ret);
+		return ret;
+	}
+
+	if (data->irq > 0) {
+		ret = wait_for_completion_timeout(&data->completion, HZ);
+		if (!ret) {
+			dev_err(data->dev, "timeout while waiting for eoc interrupt\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		/* wait until status indicates data is ready */
+		for (i = 0; i < nloops; i++) {
+			usleep_range(5000, 10000);
+			status = i2c_smbus_read_byte(data->client);
+			if (status < 0) {
+				dev_err(data->dev, "error while reading, status: %d\n", status);
+				return status;
+			}
+			if (!(status & MPR_I2C_BUSY))
+				break;
+		}
+		if (i == nloops) {
+			dev_err(data->dev, "timeout while reading\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	ret = i2c_master_recv(data->client, buf, sizeof(buf));
+	if (ret < 0) {
+		dev_err(data->dev, "error in i2c_master_recv ret: %d\n", ret);
+		return ret;
+	}
+
+	if (buf[0] & MPR_I2C_BUSY) {
+		/* it should never be the case that status still indicates business */
+		dev_err(data->dev, "data still not ready: %08x\n", buf[0]);
+		return -ETIMEDOUT;
+	}
+
+	press_cnt = buf[3] + buf[2] * 256 + buf[1] * 65536;
+
+	*press = ((press_cnt - outputmin) * (s64)(data->pmax - data->pmin))
+					/ (outputmax - outputmin) + (s64)data->pmin;
+
+	dev_dbg(data->dev, "received: %*ph cnt: %lld press: %lld\n", ret, buf, press_cnt, *press);
+
+	return 0;
+}
+
+static irqreturn_t mpr_eoc_handler(int irq, void *p)
+{
+	struct mpr_data *data = (struct mpr_data *)p;
+
+	complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mpr_trigger_handler(int irq, void *p)
+{
+	int ret;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mpr_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	ret = mpr_read_pressure(data, &data->channel[0]);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		goto err;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->channel, iio_get_time_ns(indio_dev));
+	mutex_unlock(&data->lock);
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int mpr_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan, int *val,
+									int *val2, long mask)
+{
+	int ret;
+	s64 pressure;
+	struct mpr_data *data = iio_priv(indio_dev);
+
+	if (mask == IIO_CHAN_INFO_PROCESSED) {
+		mutex_lock(&data->lock);
+		ret = mpr_read_pressure(data, &pressure);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+		if (chan->type == IIO_PRESSURE) {
+			*val = (s32)clamp(pressure, 0LL, 2147483648LL);
+			return IIO_VAL_INT;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int mpr_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	int ret;
+	struct mpr_data *data;
+	struct iio_dev *indio_dev;
+	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->dev = &client->dev;
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->irq = client->irq;
+
+	mutex_init(&data->lock);
+	init_completion(&data->completion);
+
+	indio_dev->name = client->name;
+	indio_dev->info = &mpr_info;
+	indio_dev->channels = mpr_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mpr_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (np) {
+		if (of_property_read_s32(np, "honeywell,pmin", &data->pmin)) {
+			dev_err(dev, "honeywell,pmin missing in DT\n");
+			return -EINVAL;
+		}
+		if (of_property_read_s32(np, "honeywell,pmax", &data->pmax)) {
+			dev_err(dev, "honeywell,pmax missing in DT\n");
+			return -EINVAL;
+		}
+
+		data->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(data->gpiod_reset)) {
+			dev_err(dev, "failed to get reset-gpios: err=%pe\n",
+								data->gpiod_reset);
+			data->gpiod_reset = NULL;
+		}
+
+		if (data->irq > 0) {
+			ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
+							IRQF_TRIGGER_RISING, client->name, data);
+			if (ret) {
+				dev_err(dev, "request irq %d failed\n", data->irq);
+				return ret;
+			}
+		}
+	} else {
+		/* when loaded as i2c device we need to use default values */
+		dev_warn(dev, "no dt node found; using defaults\n");
+		data->pmin = 0;
+		data->pmax = 172369; /* 25 psi */
+		data->gpiod_reset = NULL;
+	}
+
+	mpr_reset(data);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, mpr_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "unable to register iio device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mpr_matches[] = {
+	{ .compatible = "honeywell,mpr", .data = 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mpr_matches);
+
+static const struct i2c_device_id mpr_id[] = {
+	{ "honeywell,mpr", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mpr_id);
+
+static struct i2c_driver mpr_driver = {
+	.probe = mpr_probe,
+	.id_table = mpr_id,
+	.driver = {
+		.name = "mpr",
+		.of_match_table = mpr_matches,
+	},
+};
+module_i2c_driver(mpr_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("MPR I2C driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_MPR);
-- 
2.30.2
