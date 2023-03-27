Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B664F6CA50E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjC0NCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjC0NCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:02:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36230FF;
        Mon, 27 Mar 2023 06:01:59 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RBGpi1023528;
        Mon, 27 Mar 2023 09:01:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3phtt81vkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:01:51 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 32RD1bDn039639
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 09:01:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Mar
 2023 09:01:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Mar 2023 09:01:36 -0400
Received: from okan.localdomain ([10.158.19.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32RD0LcO021092;
        Mon, 27 Mar 2023 09:01:27 -0400
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Date:   Mon, 27 Mar 2023 16:00:07 +0300
Message-ID: <20230327130010.8342-3-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230327130010.8342-1-okan.sahin@analog.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rCmOEJjPCtaHxGol4j0hAJkH509Ug9Yw
X-Proofpoint-ORIG-GUID: rCmOEJjPCtaHxGol4j0hAJkH509Ug9Yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270102
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gpio I/O expander.

Signed-off-by: Okan Sahin <okan.sahin@analog.com>
---
 drivers/gpio/Kconfig       |  10 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-ds4520.c | 198 +++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/gpio/gpio-ds4520.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 13be729710f2..20aa28e208d5 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1000,6 +1000,16 @@ config GPIO_ADNP
 	  enough to represent all pins, but the driver will assume a
 	  register layout for 64 pins (8 registers).
 
+config GPIO_DS4520
+	tristate "DS4520 I2C GPIO expander"
+	select REGMAP_I2C
+	help
+	  GPIO driver for Maxim MAX7300 I2C-based GPIO expander.
+	  Say yes here to enable the GPIO driver for the ADI DS4520 chip.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-ds4520.
+
 config GPIO_GW_PLD
 	tristate "Gateworks PLD GPIO Expander"
 	depends on OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c048ba003367..6f8656d5d617 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_GPIO_DA9052)		+= gpio-da9052.o
 obj-$(CONFIG_GPIO_DA9055)		+= gpio-da9055.o
 obj-$(CONFIG_GPIO_DAVINCI)		+= gpio-davinci.o
 obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
+obj-$(CONFIG_GPIO_DS4520)		+= gpio-ds4520.o
 obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
 obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
diff --git a/drivers/gpio/gpio-ds4520.c b/drivers/gpio/gpio-ds4520.c
new file mode 100644
index 000000000000..8f878e7824b8
--- /dev/null
+++ b/drivers/gpio/gpio-ds4520.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Analog Devices, Inc.
+ * Driver for the DS4520 I/O Expander
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#define NUMBER_OF_GPIO	9
+
+#define PULLUP0		0xF0
+#define IO_CONTROL0	0xF2
+#define IO_STATUS0	0xF8
+
+#define REG_SIZE	8
+
+struct ds4520_gpio_priv {
+	struct regmap *regmap;
+	struct gpio_chip gpio_chip;
+};
+
+static int ds4520_gpio_get_direction(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	struct ds4520_gpio_priv *priv = gpiochip_get_data(chip);
+	u32 val_io_control = 0, val_pullup = 0;
+	u8 reg_offset = (offset / REG_SIZE);
+	int ret;
+
+	ret = regmap_set_bits(priv->regmap, 0xF4, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, IO_CONTROL0 + reg_offset,
+			  &val_io_control);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, PULLUP0 + reg_offset, &val_pullup);
+	if (ret)
+		return ret;
+
+	if ((val_io_control & (1 << (offset % 8)))
+	    == (val_pullup & (1 << (offset % 8))))
+		return GPIO_LINE_DIRECTION_OUT;
+	else
+		return GPIO_LINE_DIRECTION_IN;
+}
+
+static int ds4520_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct ds4520_gpio_priv *priv = gpiochip_get_data(chip);
+	u8 reg_offset = (offset / REG_SIZE);
+	u8 mask = BIT(offset % 8);
+	int ret;
+
+	ret = regmap_clear_bits(priv->regmap, IO_CONTROL0 + reg_offset, mask);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(priv->regmap, PULLUP0 + reg_offset, mask);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ds4520_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ds4520_gpio_priv *priv = gpiochip_get_data(chip);
+	u8 reg_offset = (offset / REG_SIZE);
+	u8 mask = BIT(offset % 8);
+	u32 val = 0;
+	int ret;
+
+	ret = regmap_read(priv->regmap, IO_STATUS0 + reg_offset, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & mask);
+}
+
+static void ds4520_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
+{
+	struct ds4520_gpio_priv *priv = gpiochip_get_data(chip);
+	u8 reg_offset = (offset / REG_SIZE);
+	u8 mask = BIT(offset % 8);
+
+	regmap_update_bits(priv->regmap, PULLUP0 + reg_offset, mask,
+			   value ? mask : 0);
+	regmap_update_bits(priv->regmap, IO_CONTROL0 + reg_offset, mask,
+			   value ? mask : 0);
+}
+
+static int ds4520_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	struct ds4520_gpio_priv *priv = gpiochip_get_data(chip);
+	u8 reg_offset = (offset / REG_SIZE);
+	u8 mask = BIT(offset % 8);
+	int ret;
+
+	ret = regmap_clear_bits(priv->regmap, IO_CONTROL0 + reg_offset, mask);
+	if (ret)
+		return ret;
+
+	ds4520_gpio_set(chip, offset, value);
+
+	return 0;
+}
+
+static const struct regmap_config ds4520_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct gpio_chip ds4520_chip = {
+	.label			= "ds4520-gpio",
+	.owner			= THIS_MODULE,
+	.get_direction		= ds4520_gpio_get_direction,
+	.direction_input	= ds4520_gpio_direction_input,
+	.direction_output	= ds4520_gpio_direction_output,
+	.get			= ds4520_gpio_get,
+	.set			= ds4520_gpio_set,
+	.base			= -1,
+	.can_sleep		= true,
+};
+
+static int ds4520_gpio_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct ds4520_gpio_priv *priv;
+	u32 ngpio;
+	int ret;
+
+	ngpio = NUMBER_OF_GPIO;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->gpio_chip = ds4520_chip;
+	priv->gpio_chip.label = "ds4520-gpio";
+	priv->gpio_chip.ngpio = ngpio;
+	priv->gpio_chip.parent = dev;
+
+	priv->regmap = devm_regmap_init_i2c(client, &ds4520_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err_probe(dev, ret,
+			      "Failed to allocate register map\n");
+		return ret;
+	}
+
+	ret = devm_gpiochip_add_data(dev, &priv->gpio_chip, priv);
+	if (ret) {
+		dev_err_probe(dev, ret, "Unable to register gpiochip\n");
+		return ret;
+	}
+
+	i2c_set_clientdata(client, priv);
+
+	return 0;
+}
+
+static const struct of_device_id ds4520_gpio_of_match_table[] = {
+	{
+		.compatible = "adi,ds4520-gpio"
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ds4520_gpio_of_match_table);
+
+static const struct i2c_device_id ds4520_gpio_id_table[] = {
+	{ "ds4520-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, ds4520_gpio_id_table);
+
+static struct i2c_driver ds4520_gpio_driver = {
+	.driver = {
+		.name = "ds4520-gpio",
+		.of_match_table = ds4520_gpio_of_match_table,
+	},
+	.probe_new = ds4520_gpio_probe,
+	.id_table = ds4520_gpio_id_table,
+};
+module_i2c_driver(ds4520_gpio_driver);
+
+MODULE_DESCRIPTION("DS4520 I/O Expander");
+MODULE_AUTHOR("Okan Sahin <okan.sahin@analog.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.2

