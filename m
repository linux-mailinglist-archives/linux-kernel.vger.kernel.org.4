Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837269DE11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjBUKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjBUKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:42:05 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DB23C51;
        Tue, 21 Feb 2023 02:41:51 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L8fZrx018026;
        Tue, 21 Feb 2023 05:41:30 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3nvdcm4mvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 05:41:29 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LAd0Cc028350;
        Tue, 21 Feb 2023 05:41:29 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3nvdcm4mv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 05:41:29 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 31LAfRia023096
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 05:41:27 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Feb 2023 05:41:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Feb 2023 05:41:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Feb 2023 05:41:26 -0500
Received: from okan.localdomain (IST-LT-43126.ad.analog.com [10.25.36.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 31LAdbGx012847;
        Tue, 21 Feb 2023 05:41:14 -0500
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH v5 3/5] iio: adc: max77541: Add ADI MAX77541 ADC Support
Date:   Tue, 21 Feb 2023 13:39:11 +0300
Message-ID: <20230221103926.49597-4-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230221103926.49597-1-okan.sahin@analog.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 66YZjPVRV2ob86y0Soi81mhF-j_BFprZ
X-Proofpoint-ORIG-GUID: MRk0J4PSP1w_3uTxfXAhZpFC8Yi-Jq4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210092
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
with four multiplexers for supporting the telemetry feature.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig        |  11 ++
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/max77541-adc.c | 195 +++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/iio/adc/max77541-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 791612ca6012..9716225b50da 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -696,6 +696,17 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX77541_ADC
+	tristate "Analog Devices MAX77541 ADC driver"
+	depends on MFD_MAX77541
+	help
+	  This driver controls a Analog Devices MAX77541 ADC
+	  via I2C bus. This device has one adc. Say yes here to build
+	  support for Analog Devices MAX77541 ADC interface.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called max77541-adc.
+
 config MAX9611
 	tristate "Maxim max9611/max9612 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 46caba7a010c..03774cccbb4b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_MAX1118) += max1118.o
 obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max77541-adc.c b/drivers/iio/adc/max77541-adc.c
new file mode 100644
index 000000000000..d7805793f5e3
--- /dev/null
+++ b/drivers/iio/adc/max77541-adc.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Analog Devices, Inc.
+ * ADI MAX77541 ADC Driver with IIO interface
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/mfd/max77541.h>
+
+enum max77541_adc_range {
+	LOW_RANGE,
+	MID_RANGE,
+	HIGH_RANGE,
+};
+
+enum max77541_adc_channel {
+	MAX77541_ADC_VSYS_V,
+	MAX77541_ADC_VOUT1_V,
+	MAX77541_ADC_VOUT2_V,
+	MAX77541_ADC_TEMP,
+};
+
+static int max77541_adc_offset(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2)
+{
+	switch (chan->channel) {
+	case MAX77541_ADC_TEMP:
+		*val = DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS, 1725);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max77541_adc_scale(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2)
+{
+	struct regmap **regmap = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	switch (chan->channel) {
+	case MAX77541_ADC_VSYS_V:
+		*val = 25;
+		return IIO_VAL_INT;
+	case MAX77541_ADC_VOUT1_V:
+	case MAX77541_ADC_VOUT2_V:
+		ret = regmap_read(*regmap, MAX77541_REG_M2_CFG1, &reg_val);
+		if (ret)
+			return ret;
+
+		reg_val = FIELD_GET(MAX77541_BITS_MX_CFG1_RNG, reg_val);
+		switch (reg_val) {
+		case LOW_RANGE:
+			*val = 6;
+			*val2 = 250000;
+			break;
+		case MID_RANGE:
+			*val = 12;
+			*val2 = 500000;
+			break;
+		case HIGH_RANGE:
+			*val = 25;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	case MAX77541_ADC_TEMP:
+		*val = 1725;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max77541_adc_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val)
+{
+	struct regmap **regmap = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_read(*regmap, chan->address, val);
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+#define MAX77541_ADC_CHANNEL_V(_channel, _name, _type, _reg) \
+	{							\
+		.type = _type,					\
+		.indexed = 1,					\
+		.channel = _channel,				\
+		.address = _reg,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+				      BIT(IIO_CHAN_INFO_SCALE), \
+		.datasheet_name = _name,			\
+	}
+
+#define MAX77541_ADC_CHANNEL_TEMP(_channel, _name, _type, _reg) \
+	{							\
+		.type = _type,					\
+		.indexed = 1,					\
+		.channel = _channel,				\
+		.address = _reg,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+				      BIT(IIO_CHAN_INFO_SCALE) |\
+				      BIT(IIO_CHAN_INFO_OFFSET),\
+		.datasheet_name = _name,			\
+	}
+
+static const struct iio_chan_spec max77541_adc_channels[] = {
+	MAX77541_ADC_CHANNEL_V(MAX77541_ADC_VSYS_V, "vsys_v", IIO_VOLTAGE,
+			       MAX77541_REG_ADC_DATA_CH1),
+	MAX77541_ADC_CHANNEL_V(MAX77541_ADC_VOUT1_V, "vout1_v", IIO_VOLTAGE,
+			       MAX77541_REG_ADC_DATA_CH2),
+	MAX77541_ADC_CHANNEL_V(MAX77541_ADC_VOUT2_V, "vout2_v", IIO_VOLTAGE,
+			       MAX77541_REG_ADC_DATA_CH3),
+	MAX77541_ADC_CHANNEL_TEMP(MAX77541_ADC_TEMP, "temp", IIO_TEMP,
+				  MAX77541_REG_ADC_DATA_CH6),
+};
+
+static int max77541_adc_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		return max77541_adc_offset(indio_dev, chan, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return max77541_adc_scale(indio_dev, chan, val, val2);
+	case IIO_CHAN_INFO_RAW:
+		return max77541_adc_raw(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max77541_adc_info = {
+	.read_raw = max77541_adc_read_raw,
+};
+
+static int max77541_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct regmap **regmap;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*regmap));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = iio_priv(indio_dev);
+
+	*regmap = dev_get_regmap(dev->parent, NULL);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->name = "max77541";
+	indio_dev->info = &max77541_adc_info;
+	indio_dev->channels = max77541_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max77541_adc_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id max77541_adc_platform_id[] = {
+	{ "max77541-adc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, max77541_adc_platform_id);
+
+static struct platform_driver max77541_adc_driver = {
+	.driver = {
+		.name = "max77541-adc",
+	},
+	.probe = max77541_adc_probe,
+	.id_table = max77541_adc_platform_id,
+};
+module_platform_driver(max77541_adc_driver);
+
+MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
+MODULE_DESCRIPTION("MAX77541 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.30.2

