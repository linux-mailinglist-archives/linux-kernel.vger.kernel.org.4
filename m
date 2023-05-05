Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BE6F83DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjEENWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjEENW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:22:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D36D203CD;
        Fri,  5 May 2023 06:22:24 -0700 (PDT)
Received: from localhost ([31.220.113.235]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtwMc-1qDqF92dTw-00uKlU; Fri, 05 May 2023 15:22:07 +0200
Date:   Fri, 5 May 2023 15:22:07 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] iio: pressure: Honeywell mprls0025pa pressure sensor
Message-ID: <ZFUC/3zBFQRBsYUk@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUCf059+PSR+3Wb@arbad>
X-Provags-ID: V03:K1:TXF1wn6GdQyQuQtroKapmJvSjo1Y2KrNSIybYDGPBWH23/SY+7O
 7I/hoXYCSsWeFtHU718u+5Q+Uisio65076inABOOzcOERvvtRqg8pgg/7IXsYFEOKaKPm13
 bGzhgMksU4I8hdTQQ5X2MuwIAzNR4LatPvIojvUADIzQci9sDSiStx15B4R2Z4R6MaQqu2S
 qCZclBmqTmWH4IlCAMorg==
UI-OutboundReport: notjunk:1;M01:P0:nnYvGU+vsSU=;dOJueTstjAswJdXaERtozNJbnI3
 wuUFH1FtXZ9gYPPmUwACAZblCAlFCvACROwRN0/tvg6upIX1+jiWH+ihV3YuZzdv4SS11BWgO
 mbMhaTfWxWCVRzBEuq2ol2UFqqlFjdNTvtAtqxTCYdG57+8ZLqDUiSOBj0HCggAmGqa5Qphu5
 KW22rPgauErkrInqJcBQ3luoLUiHjh8z+F7NkoQlNEFBn6wC/jAeboFu2reQZGLIP97cD4/QK
 fC3YX45sOp4I2B0dverb/kjTF90s03U1unS4LM/D0sX7KoJfKUMwlAqSB8vj7Y+iZLeaJeoUk
 DRgGDH0gDRxWmwqH4X9Nlx4YWdxQgAq/cGUWxw5IVCVbw2ZCf0Q9uxNx8j2A/hi/LTNpGWtvO
 hMIgJafLA/CC6kO1qUOaR/FGWZgbtqMEOea/qyR++JFQLv/qdXP8vWoOfEXE1Eprw7FSgzVnr
 IAUFJI/a+WEmKwskaIiuNosSDwHxtIMvCL5TaF1tdNBYmRlIzJLyxJLJ8u2SuavJVDkit/p2O
 TxtiX9+XxMdNb8NIRYPO2p6UyKj2EERYtsUWeR+YDG7b7qRR2pZ/8sng+YscxMaRyKqtWIo4e
 sQFHN+R/Ohl/YGU/2W559Gsva4FTLuaqoOrSbSSMtxGzcGGwYRN6maGOdxN1QrDn1iqmfB1Wk
 YWxzBTtok+yBS/OfoTAEmf48ts3r9o3KTSuSCm58Iw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honeywell mprls0025pa is a series of pressure sensors.

Add initial I2C support.

Note:
- IIO buffered mode is supported
- SPI mode is not supported

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/Kconfig       |  13 +
 drivers/iio/pressure/Makefile      |   1 +
 drivers/iio/pressure/mprls0025pa.c | 441 +++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 drivers/iio/pressure/mprls0025pa.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index c9453389e4f7..43aef35ce778 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -148,6 +148,19 @@ config MPL3115
 	  To compile this driver as a module, choose M here: the module
 	  will be called mpl3115.
 
+config MPRLS0025PA
+	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build support for the Honeywell MicroPressure pressure
+	  sensor series. There are many different types with different pressure
+	  range. These ranges can be set up in the device tree.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called mprls0025pa.
+
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 083ae87ff48f..c90f77210e94 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MPL115) += mpl115.o
 obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
 obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
 obj-$(CONFIG_MPL3115) += mpl3115.o
+obj-$(CONFIG_MPRLS0025PA) += mprls0025pa.o
 obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
new file mode 100644
index 000000000000..7a8736de6e87
--- /dev/null
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MPRLS0025PA - Honeywell MicroPressure pressure sensor series driver
+ *
+ * Copyright (c) Andreas Klinger <ak@it-klinger.de>
+ *
+ * Data sheet:
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
+ *    products/sensors/pressure-sensors/board-mount-pressure-sensors/
+ *    micropressure-mpr-series/documents/
+ *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ *
+ * 7-bit I2C default slave address: 0x18
+ */
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+/* bits in i2c status byte */
+#define MPR_I2C_POWER	BIT(6)	/* device is powered */
+#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
+#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
+#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
+
+#define MPR_NANO_PART	1000000000LL
+
+/*
+ * _INPUT interface:
+ * Calculation formular from the datasheet:
+ * pressure = (press_cnt - outputmin) * scale + pmin
+ * with:
+ * * pressure	- measured pressure in Pascal
+ * * press_cnt	- raw value read from sensor
+ * * pmin	- minimum pressure range value of sensor (data->pmin)
+ * * pmax	- maximum pressure range value of sensor (data->pmax)
+ * * outputmin	- minimum numerical range raw value delivered by sensor
+ *							(MPR_OUT_MIN)
+ * * outputmax	- maximum numerical range raw value delivered by sensor
+ *							(MPR_OUT_MAX)
+ * * scale	- (pmax - pmin) / (outputmax - outputmin)
+ *
+ * _RAW interface:
+ * pressure = (raw + offset) * scale
+ * --> need to adjust offset for fitting into _RAW interface
+ * Values for _RAW interface:
+ * * raw	- press_cnt
+ * * scale	- (pmax - pmin) / (outputmax - outputmin)
+ * * offset	- (-1 * outputmin) - pmin / scale
+ *                note: With all sensors from the datasheet pmin = 0
+ *                which reduces the offset to (-1 * outputmin)
+ */
+
+/*
+ * transfer function A: 10%   to 90%   of 2^24
+ * transfer function B:  2.5% to 22.5% of 2^24
+ * transfer function C: 20%   to 80%   of 2^24
+ */
+enum mpr_func_id {
+	MPR_FUNCTION_A,
+	MPR_FUNCTION_B,
+	MPR_FUNCTION_C,
+};
+
+struct mpr_func_spec {
+	u32			output_min;
+	u32			output_max;
+};
+
+static const struct mpr_func_spec mpr_func_spec[] = {
+	[MPR_FUNCTION_A] = {.output_min = 1677722, .output_max = 15099494},
+	[MPR_FUNCTION_B] = {.output_min =  419430, .output_max =  3774874},
+	[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
+};
+
+struct mpr_chan {
+	s32			pres;		/* pressure value */
+	s64			ts;		/* timestamp */
+};
+
+struct mpr_data {
+	struct i2c_client	*client;
+	struct mutex		lock;		/* i2c transactions */
+	u32			pmin;		/* minimal pressure in pascal */
+	u32			pmax;		/* maximal pressure in pascal */
+	u32			function;	/* transfer function */
+	u32			outmin;		/*
+						 * minimal numerical range raw
+						 * value from sensor
+						 */
+	u32			outmax;		/*
+						 * maximal numerical range raw
+						 * value from sensor
+						 */
+	int                     scale;          /* int part of scale */
+	int                     scale2;         /* nano part of scale */
+	int                     offset;         /* int part of offset */
+	int                     offset2;        /* nano part of offset */
+	struct gpio_desc	*gpiod_reset;	/* reset */
+	int			irq;		/* end of conversion irq */
+	struct completion	completion;	/* handshake from irq to read */
+	struct mpr_chan		chan;		/*
+						 * channel values for buffered
+						 * mode
+						 */
+};
+
+static const struct iio_chan_spec mpr_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
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
+/**
+ * mpr_read_pressure() - Read pressure value from sensor via I2C
+ * @data: Pointer to private data struct.
+ * @press: Output value read from sensor.
+ *
+ * Reading from the sensor by sending and receiving I2C telegrams.
+ *
+ * If there is an end of conversion (EOC) interrupt registered the function
+ * waits for a maximum of one second for the interrupt.
+ *
+ * Context: The function can sleep and data->lock should be held when calling it
+ * Return:
+ * * 0		- OK, the pressure value could be read
+ * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is
+ *		  still set after nloops attempts of reading
+ */
+static int mpr_read_pressure(struct mpr_data *data, s32 *press)
+{
+	struct device *dev = &data->client->dev;
+	int ret, i;
+	u8 wdata[] = {0xAA, 0x00, 0x00};
+	s32 status;
+	int nloops = 10;
+	u8 buf[5];
+
+	reinit_completion(&data->completion);
+
+	ret = i2c_master_send(data->client, wdata, sizeof(wdata));
+	if (ret < 0) {
+		dev_err(dev, "error while writing ret: %d\n", ret);
+		return ret;
+	}
+	if (ret != sizeof(wdata)) {
+		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
+								sizeof(wdata));
+		return -EIO;
+	}
+
+	if (data->irq > 0) {
+		ret = wait_for_completion_timeout(&data->completion, HZ);
+		if (!ret) {
+			dev_err(dev, "timeout while waiting for eoc irq\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		/* wait until status indicates data is ready */
+		for (i = 0; i < nloops; i++) {
+			/*
+			 * datasheet only says to wait at least 5 ms for the
+			 * data but leave the maximum response time open
+			 * --> let's try it nloops (10) times which seems to be
+			 *     quite long
+			 */
+			usleep_range(5000, 10000);
+			status = i2c_smbus_read_byte(data->client);
+			if (status < 0) {
+				dev_err(dev,
+					"error while reading, status: %d\n",
+					status);
+				return status;
+			}
+			if (!(status & MPR_I2C_BUSY))
+				break;
+		}
+		if (i == nloops) {
+			dev_err(dev, "timeout while reading\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	ret = i2c_master_recv(data->client, buf, sizeof(buf));
+	if (ret < 0) {
+		dev_err(dev, "error in i2c_master_recv ret: %d\n", ret);
+		return ret;
+	}
+	if (ret != sizeof(buf)) {
+		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
+								sizeof(buf));
+		return -EIO;
+	}
+
+	if (buf[0] & MPR_I2C_BUSY) {
+		/*
+		 * it should never be the case that status still indicates
+		 * business
+		 */
+		dev_err(dev, "data still not ready: %08x\n", buf[0]);
+		return -ETIMEDOUT;
+	}
+
+	*press = get_unaligned_be24(&buf[1]);
+
+	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, buf, *press);
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
+	ret = mpr_read_pressure(data, &data->chan.pres);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		goto err;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->chan,
+						iio_get_time_ns(indio_dev));
+	mutex_unlock(&data->lock);
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int mpr_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	int ret;
+	s32 pressure;
+	struct mpr_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PRESSURE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = mpr_read_pressure(data, &pressure);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+		*val = pressure;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = data->scale;
+		*val2 = data->scale2;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = data->offset;
+		*val2 = data->offset2;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mpr_info = {
+	.read_raw = &mpr_read_raw,
+};
+
+static int mpr_probe(struct i2c_client *client)
+{
+	int ret;
+	struct mpr_data *data;
+	struct iio_dev *indio_dev;
+	struct device *dev = &client->dev;
+	s64 scale, offset;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+					"I2C functionality not supported\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "couldn't get iio_dev\n");
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->irq = client->irq;
+
+	mutex_init(&data->lock);
+	init_completion(&data->completion);
+
+	indio_dev->name = "mprls0025pa";
+	indio_dev->info = &mpr_info;
+	indio_dev->channels = mpr_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mpr_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"can't get and enable vdd supply\n");
+
+	if (dev_fwnode(dev)) {
+		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+								&data->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,pmin-pascal could not be read\n");
+		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+								&data->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,pmax-pascal could not be read\n");
+		ret = device_property_read_u32(dev,
+				"honeywell,transfer-function", &data->function);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,transfer-function could not be read\n");
+		if (data->function > MPR_FUNCTION_C)
+			return dev_err_probe(dev, -EINVAL,
+				"honeywell,transfer-function %d invalid\n",
+								data->function);
+	} else {
+		/* when loaded as i2c device we need to use default values */
+		dev_notice(dev, "firmware node not found; using defaults\n");
+		data->pmin = 0;
+		data->pmax = 172369; /* 25 psi */
+		data->function = MPR_FUNCTION_A;
+	}
+
+	data->outmin = mpr_func_spec[data->function].output_min;
+	data->outmax = mpr_func_spec[data->function].output_max;
+
+	scale = div_s64(((s64)(data->pmax - data->pmin)) * MPR_NANO_PART,
+						data->outmax - data->outmin);
+	data->scale = div_s64(scale, MPR_NANO_PART);
+	data->scale2 = scale - data->scale * MPR_NANO_PART;
+
+	offset = ((-1LL) * (s64)data->outmin) * MPR_NANO_PART -
+		div_s64(div_s64((s64)data->pmin * MPR_NANO_PART, scale),
+		MPR_NANO_PART);
+	data->offset = div_s64(offset, MPR_NANO_PART);
+	data->offset2 = offset - data->offset * MPR_NANO_PART;
+
+	if (data->irq > 0) {
+		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
+				IRQF_TRIGGER_RISING, client->name, data);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"request irq %d failed\n", data->irq);
+	}
+
+	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(data->gpiod_reset))
+		return dev_err_probe(dev, PTR_ERR(data->gpiod_reset),
+						"request reset-gpio failed\n");
+
+	mpr_reset(data);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+						mpr_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+					"iio triggered buffer setup failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+					"unable to register iio device\n");
+
+	return 0;
+}
+
+static const struct of_device_id mpr_matches[] = {
+	{ .compatible = "honeywell,mprls0025pa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mpr_matches);
+
+static const struct i2c_device_id mpr_id[] = {
+	{ "mprls0025pa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mpr_id);
+
+static struct i2c_driver mpr_driver = {
+	.probe_new	= mpr_probe,
+	.id_table	= mpr_id,
+	.driver		= {
+		.name		= "mprls0025pa",
+		.of_match_table = mpr_matches,
+	},
+};
+module_i2c_driver(mpr_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("Honeywell MPRLS0025PA I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2
