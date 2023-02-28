Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF36A5308
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjB1Gca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjB1GcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:32:20 -0500
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8137C206A0;
        Mon, 27 Feb 2023 22:32:18 -0800 (PST)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <mike.looijmans@topic.nl>)
        id 1pWtX3-0006hK-Vd; Tue, 28 Feb 2023 07:32:16 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Tue, 28 Feb 2023 07:32:10 +0100 (CET)
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Date:   Tue, 28 Feb 2023 07:31:51 +0100
Message-Id: <20230228063151.17598-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230228063151.17598-1-mike.looijmans@topic.nl>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (0.000366237774469)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/+Qbjh7U2b8d2TYVAias4dPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzeemUa7CfwmLuWRw6Ruql9Wrt/oF2ofKYeezPZTW+uL/H
 seNZtCKdSRRS0Op9pfwEIJgF/Accv4lLtE4TWYNIjgZ0d6t6F7vRFkkblm+Z5NM7uAX91bCdERq+
 A7shw5HBQ2daKZyt52e93s8gLaWLOD0k0yEeil+YFQCKRVPBg3VHKL9hvGS2mqsPMKya0/ejQxXz
 IRCxU4zvVw/zK9ZrhDCTqV1WVopmRM14iUwHCYSLeUQrvOsxMVhiidR8nBk+R54Dzy39xxXBDVj+
 w40qD+tmOqLXWKwbkhDLVpmPyEpTtJ1Gicmo0ICJSZRGG8ZiK/Pufg+FEfYzB3vZNRC/MzyPAQic
 eiT3qi1WRRbMtHs/ZDw0ICQBCi4MkavZr+vdLKbqaxkIZ/IoDntXWGjGtxB4JzGERc7IIRNCyb5B
 6YRxmUrjg0VurGjbcZ+qM12s0jLA62zuQ0p9vWMNk8RQhOMAjvfr/FcowH3inf/wyv+Bu4/uGdQr
 w1B0vCxVYoi1DXHSjWS59UydDDVvf8OzIOE8xrw2y5OvK1bfFc4cnEN4PFSAoOTb2oJsdjqqcu0r
 0XmOPEDASD12MXhLEZMTz+HcJL/WCLPCvtHXE5vkSdL0MYqVRCIbgP5wlJ/3RlpfjKqeDxugWqGo
 bpUDNSEgBis5N/Mb7VKF7vApw75kdlX8QONNpNIWCQgbIih6o3WqFghyXFWLno8/IbNCcUbQAbnt
 l9Q3ZYtCuyQ7/XI/ws1IPwYBoYXfzgTCDFl2sunh8oBMeLVLbSDuV03m2JR3A9w00Uxphb0oecXq
 9ECkdqyFtrWh9ptS9p5v+9khTJHICjtSWlckpyucRl3ZvRsd3WHA6paPC74rnDlfLah2d29R4BJZ
 58JiPXkJGM8RdwuVhmtVCqQvr7F4+SqvrRW05YE5enyccp7RH4WQio3uGR3IVyyY45hYQ53sekyN
 ml6NKEqK8EtxFSDTRzT4w/6GTbSMmemAFVau2BE2tN2dJN1qbO+5byg1xa5b4pvlwySICJ8Oz3QZ
 bZo1Mwo55EapaK2ArLgvpIN/GYHSD3CRm+gSQrfrteadX1D5XPq1Q9jUWdr7yeeChZhecWpjdpxg
 B5hQ6nsDvccjqgmDvD9Wh85E84b+miNp/mfbnZfCkln/oVHmYKE2NEwqiQ6ujzl0lwKm4uYvOzq7
 p0gFhYOwkSRseOkfcllAVrX+xgByR9zY5D4EUGMfbBlPM9GaJdr/tWFtYdvXhamRpn73HslLxayW
 s9bYQYRBnNTIuPZHwrjVii7biXG/73E5JI68fYwVZuM7jUXIESohoO51xWmU8aVW4NQHG/HCuRbo
 rdpaefcI9P4j9C3XRsAbBbHfyYCv8Aca8wjA37gwTIS1VDWpR5gCZX+JmB/hR5Jyap+zYXPeNHk1
 5VolAGHS5rCXQKDys+zV37+29PHf6citJcUoR5sicilDq6onO2DrAAUGU6f/eXLXHwWBIg9ewzd6
 roBovbbJOk8Ii0jxr6twdx43Hg==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADS1100 is a 16-bit ADC (at 8 samples per second).
The ADS1000 is similar, but has a fixed data rate.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v3:
Add #include linux/bitfield.h and linux/bits.h

Changes in v2:
Remove "driver for" from title
Use proper PM_RUNTIME macros
Fix indents
Use dev_err_probe()
Unsigned index and post-increment
Use GENMASK and FIELD_GET
remove ads1100_set_conv_mode
remove Kconfig BUFFER dependencies
remove unused #include
Set SCALE instead of HARDWAREGAIN
Use devm_add_action_or_reset

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1100.c | 434 +++++++++++++++++++++++++++++++++++
 3 files changed, 445 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1100.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 63f80d747cbd..257efb25a92e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1207,6 +1207,16 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS1100
+	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS1100 and
+	  ADS1000 ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1100.
+
 config TI_ADS7950
 	tristate "Texas Instruments ADS7950 ADC driver"
 	depends on SPI && GPIOLIB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 4ef41a7dfac6..61ef600fab99 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
+obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
new file mode 100644
index 000000000000..1898bee9b784
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADS1100 - Texas Instruments Analog-to-Digital Converter
+ *
+ * Copyright (c) 2023, Topic Embedded Products
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/ads1100
+ * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+/* The ADS1100 has a single byte config register */
+
+/* Conversion in progress bit */
+#define ADS1100_CFG_ST_BSY	BIT(7)
+/* Single conversion bit */
+#define ADS1100_CFG_SC		BIT(4)
+/* Data rate */
+#define ADS1100_DR_MASK		GENMASK(3, 2)
+/* Gain */
+#define ADS1100_PGA_MASK	GENMASK(1, 0)
+
+#define ADS1100_CONTINUOUS	0
+#define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
+
+#define ADS1100_SLEEP_DELAY_MS	2000
+
+static const int ads1100_data_rate[] = {128, 32, 16, 8};
+static const int ads1100_data_rate_bits[] = {12, 14, 15, 16};
+
+struct ads1100_data {
+	struct i2c_client *client;
+	struct regulator *reg_vdd;
+	struct mutex lock;
+	int scale_avail[2 * 4]; /* 4 gain settings */
+	u8 config;
+	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+};
+
+static const struct iio_chan_spec ads1100_channel = {
+	.type = IIO_VOLTAGE,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_all =
+				BIT(IIO_CHAN_INFO_SCALE) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_shared_by_all_available =
+				BIT(IIO_CHAN_INFO_SCALE) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	.datasheet_name = "AIN",
+};
+
+static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
+{
+	int ret;
+	u8 config = (data->config & ~mask) | (value & mask);
+
+	if (data->config == config)
+		return 0; /* Already done */
+
+	ret = i2c_master_send(data->client, &config, 1);
+	if (ret < 0)
+		return ret;
+
+	data->config = config;
+	return 0;
+};
+
+static int ads1100_data_bits(struct ads1100_data *data)
+{
+	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
+}
+
+static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
+{
+	int ret;
+	__be16 buffer;
+	s16 value;
+
+	if (chan != 0)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	/* Value is always 16-bit 2's complement */
+	value = be16_to_cpu(buffer);
+	/* Shift result to compensate for bit resolution vs. sample rate */
+	value <<= 16 - ads1100_data_bits(data);
+	*val = sign_extend32(value, 15);
+
+	return 0;
+}
+
+static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
+{
+	int microvolts;
+	int gain;
+	int i;
+
+	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
+	if (val)
+		return -EINVAL;
+
+	microvolts = regulator_get_voltage(data->reg_vdd);
+	/* Calculate: gain = ((microvolts / 1000) / (val2 / 1000000)) >> 15 */
+	gain = ((microvolts + BIT(14)) >> 15) * 1000 / val2;
+
+	for (i = 0; i < 4; i++) {
+		if (BIT(i) == gain) {
+			ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
+{
+	unsigned int i;
+	unsigned int size;
+
+	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	for (i = 0; i < size; ++i) {
+		if (ads1100_data_rate[i] == rate) {
+			return ads1100_set_config_bits(
+					data, ADS1100_DR_MASK,
+					FIELD_PREP(ADS1100_DR_MASK, i));
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void ads1100_calc_scale_avail(struct ads1100_data *data)
+{
+	int millivolts = regulator_get_voltage(data->reg_vdd) / 1000;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
+		data->scale_avail[i * 2] = millivolts;
+		data->scale_avail[i * 2 + 1] = 15 + i;
+	}
+}
+
+static int ads1100_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1100_data_rate;
+		if (data->supports_data_rate)
+			*length = ARRAY_SIZE(ads1100_data_rate);
+		else
+			*length = 1;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*vals = data->scale_avail;
+		*length = ARRAY_SIZE(data->scale_avail);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1100_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret;
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			break;
+
+		ret = ads1100_get_adc_result(data, chan->address, val);
+		if (ret >= 0)
+			ret = IIO_VAL_INT;
+		iio_device_release_direct_mode(indio_dev);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		/* full-scale is the supply voltage in millivolts */
+		*val = regulator_get_voltage(data->reg_vdd) / 1000;
+		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ads1100_data_rate[
+				FIELD_GET(ADS1100_DR_MASK, data->config)];
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads1100_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1100_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = ads1100_set_scale(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads1100_set_data_rate(data, chan->address, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static const struct iio_info ads1100_info = {
+	.read_avail	= ads1100_read_avail,
+	.read_raw	= ads1100_read_raw,
+	.write_raw	= ads1100_write_raw,
+};
+
+static int ads1100_setup(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	/* Setup continuous sampling mode at 8sps */
+	buffer[0] = ADS1100_DR_MASK | ADS1100_CONTINUOUS;
+	ret = i2c_master_send(data->client, buffer, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
+	if (ret < 0)
+		return ret;
+
+	/* Config register returned in third byte, strip away the busy status */
+	data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
+
+	/* Detect the sample rate capability by checking the DR bits */
+	data->supports_data_rate = FIELD_GET(ADS1100_DR_MASK, buffer[2]) != 0;
+
+	return 0;
+}
+
+static void ads1100_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static void ads1100_disable_continuous(void *data)
+{
+	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
+}
+
+static int ads1100_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads1100_data *data;
+	struct device *dev = &client->dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->name = "ads1100";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &ads1100_channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ads1100_info;
+
+	data->reg_vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->reg_vdd))
+		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
+				     "Failed to get vdd regulator\n");
+
+	ret = regulator_enable(data->reg_vdd);
+	if (ret < 0)
+		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
+				     "Failed to enable vdd regulator\n");
+
+	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
+	if (ret)
+		return ret;
+
+	ret = ads1100_setup(data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to communicate with device\n");
+
+	ret = devm_add_action_or_reset(dev, ads1100_disable_continuous, data);
+	if (ret)
+		return ret;
+
+	ads1100_calc_scale_avail(data);
+
+	pm_runtime_set_autosuspend_delay(dev, ADS1100_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to register IIO device\n");
+
+	return 0;
+}
+
+static int ads1100_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads1100_data *data = iio_priv(indio_dev);
+
+	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
+	regulator_disable(data->reg_vdd);
+
+	return 0;
+}
+
+static int ads1100_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads1100_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(data->reg_vdd);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to enable Vdd\n");
+		return ret;
+	}
+
+	/*
+	 * We'll always change the mode bit in the config register, so there is
+	 * no need here to "force" a write to the config register. If the device
+	 * has been power-cycled, we'll re-write its config register now.
+	 */
+	return ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_CONTINUOUS);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
+				 ads1100_runtime_suspend,
+				 ads1100_runtime_resume,
+				 NULL);
+
+static const struct i2c_device_id ads1100_id[] = {
+	{ "ads1100", },
+	{ "ads1000", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ads1100_id);
+
+static const struct of_device_id ads1100_of_match[] = {
+	{ .compatible = "ti,ads1100", },
+	{ .compatible = "ti,ads1000", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ads1100_of_match);
+
+static struct i2c_driver ads1100_driver = {
+	.driver = {
+		.name = "ads1100",
+		.of_match_table = ads1100_of_match,
+		.pm = pm_ptr(&ads1100_pm_ops),
+	},
+	.probe_new	= ads1100_probe,
+	.id_table	= ads1100_id,
+};
+
+module_i2c_driver(ads1100_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Texas Instruments ADS1100 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

