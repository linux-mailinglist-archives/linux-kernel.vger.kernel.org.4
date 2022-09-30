Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77625F05F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiI3HqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiI3HqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:46:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED88D01D5;
        Fri, 30 Sep 2022 00:45:58 -0700 (PDT)
X-QQ-mid: bizesmtp79t1664523824trh8ip6z
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 15:43:42 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: csThFcnIC6ySdc9b92sRxhozzP6SG1KO5SXa6lHdCjSLjdHRJj1NYW6S+CxXj
        nO9LRrOX485oFIuN/GuDNzth46hcmRCaB89L3U6heiQHiKeJvfhShpy228R6uyWrHkQoFJ/
        deBA2afGGItrnqNUH2vCm2V22mXnbjyoxpjQE3LZBoU+0Hvae3TLn5013RjHlURVNKR9dlL
        jslj8t+RW6RqQuBwJjB5UnIjlnKDKMKDbuKpgy8J1ZdUfYatQGW7e+BfKC+hAzL8QAXqHPB
        74p701p2GeN/Rr9Iuw7R7akk7m9iEAVot9LIGvvqVpJLhtysquoFvc2EqDS50fOCno8sS5w
        h21FiNOnAJtDZijtXLMn4Vty32IzQ2o2TrsCUB4SiQEzNS6C5prPMyQXEz62gKmDzqP1qXJ
        DyylXsdt8TI=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 26/30] pinctrl: starfive: Add StarFive JH7110 driver
Date:   Fri, 30 Sep 2022 15:43:41 +0800
Message-Id: <20220930074341.6386-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlong Huang <jianlong.huang@starfivetech.com>

Add pinctrl driver for StarFive JH7110 SoC.

Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 MAINTAINERS                                   |   9 +-
 drivers/pinctrl/starfive/Kconfig              |  20 +
 drivers/pinctrl/starfive/Makefile             |   5 +
 drivers/pinctrl/starfive/pinctrl-jh7110-aon.c | 718 ++++++++++++++
 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c | 925 ++++++++++++++++++
 drivers/pinctrl/starfive/pinctrl-starfive.c   | 539 ++++++++++
 drivers/pinctrl/starfive/pinctrl-starfive.h   | 131 +++
 7 files changed, 2343 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-jh7110-aon.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 70d64d2afb0c..6847dee99603 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19404,13 +19404,14 @@ F:	Documentation/devicetree/bindings/clock/starfive*
 F:	drivers/clk/starfive/
 F:	include/dt-bindings/clock/starfive*
 
-STARFIVE JH7100 PINCTRL DRIVER
+STARFIVE PINCTRL DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
+M:	Jianlong Huang <jianlong.huang@starfivetech.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
-F:	drivers/pinctrl/pinctrl-starfive.c
-F:	include/dt-bindings/pinctrl/pinctrl-starfive.h
+F:	Documentation/devicetree/bindings/pinctrl/starfive*
+F:	drivers/pinctrl/starfive/
+F:	include/dt-bindings/pinctrl/pinctrl-starfive*
 
 STARFIVE RESET CONTROLLER DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index 5cedb546f93d..fde39f4a7922 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -17,3 +17,23 @@ config PINCTRL_STARFIVE_JH7100
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
 
+config PINCTRL_STARFIVE
+	bool
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_PINCONF
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select OF_GPIO
+
+config PINCTRL_STARFIVE_JH7110
+	bool "Pinctrl and GPIO driver for the StarFive JH7110 SoC"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE
+	default SOC_STARFIVE
+	help
+	  Say yes here to support pin control on the StarFive JH7110 SoC.
+	  This also provides an interface to the GPIO pins not used by other
+	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
+	  and interrupts on input changes.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index 0293f26a0a99..17cdd1b0e650 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -1,3 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Core
+obj-$(CONFIG_PINCTRL_STARFIVE) += pinctrl-starfive.o
+
+# SoC Drivers
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7100)	+= pinctrl-starfive-jh7100.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH7110)	+= pinctrl-jh7110-sys.o pinctrl-jh7110-aon.o
diff --git a/drivers/pinctrl/starfive/pinctrl-jh7110-aon.c b/drivers/pinctrl/starfive/pinctrl-jh7110-aon.c
new file mode 100644
index 000000000000..058acd3ff305
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-jh7110-aon.c
@@ -0,0 +1,718 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl / GPIO driver for StarFive JH7110 SoC aon controller
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+#include "pinctrl-starfive.h"
+
+/* aon_iomux */
+#define AON_GPO_DOEN_CFG		0x0
+#define AON_GPO_DOEN_MASK		GENMASK(2, 0)
+#define AON_GPO_DOUT_CFG		0x4
+#define AON_GPO_DOUT_MASK		GENMASK(3, 0)
+#define AON_GPI_DIN_CFG			0x8
+#define AON_GPI_DIN_MASK		GENMASK(3, 0)
+#define AON_GPIO_DIN_REG		0x2c
+
+/* aon_iomux GPIO CTRL */
+#define AON_GPIO_EN_REG			0xc
+#define AON_GPIO_IS_REG			0x10
+#define AON_GPIO_IC_REG			0x14
+#define AON_GPIO_IBE_REG		0x18
+#define AON_GPIO_IEV_REG		0x1c
+#define AON_GPIO_IE_REG			0x20
+#define AON_GPIO_MIS_REG		0x28
+
+/* aon_iomux PIN ioconfig reg */
+#define AON_GPO_PDA_0_5_CFG		0x30
+#define PADCFG_PAD_GMAC_SYSCON_SHIFT	0x0
+#define PADCFG_PAD_GMAC_SYSCON_MASK	GENMASK(1, 0)
+#define A0N_GPO_PDA_CFG_OFFSET		0x4
+#define AON_GPIO_INPUT_ENABLE_REG	0x34
+
+#define AON_GPIO_NUM			4
+
+enum starfive_jh7110_aon_pads {
+	PAD_TESTEN	= 0,
+	PAD_RGPIO0	= 1,
+	PAD_RGPIO1	= 2,
+	PAD_RGPIO2	= 3,
+	PAD_RGPIO3	= 4,
+	PAD_RSTN	= 5,
+	PAD_GMAC0_MDC	= 6,
+	PAD_GMAC0_MDIO	= 7,
+	PAD_GMAC0_RXD0	= 8,
+	PAD_GMAC0_RXD1	= 9,
+	PAD_GMAC0_RXD2	= 10,
+	PAD_GMAC0_RXD3	= 11,
+	PAD_GMAC0_RXDV	= 12,
+	PAD_GMAC0_RXC	= 13,
+	PAD_GMAC0_TXD0	= 14,
+	PAD_GMAC0_TXD1	= 15,
+	PAD_GMAC0_TXD2	= 16,
+	PAD_GMAC0_TXD3	= 17,
+	PAD_GMAC0_TXEN	= 18,
+	PAD_GMAC0_TXC	= 19,
+};
+
+static const struct pinctrl_pin_desc starfive_jh7110_aon_pinctrl_pads[] = {
+	STARFIVE_PINCTRL_PIN(PAD_TESTEN),
+	STARFIVE_PINCTRL_PIN(PAD_RGPIO0),
+	STARFIVE_PINCTRL_PIN(PAD_RGPIO1),
+	STARFIVE_PINCTRL_PIN(PAD_RGPIO2),
+	STARFIVE_PINCTRL_PIN(PAD_RGPIO3),
+	STARFIVE_PINCTRL_PIN(PAD_RSTN),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_MDC),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_MDIO),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_RXD0),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_RXD1),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_RXD2),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_RXD3),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_RXDV),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_RXC),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_TXD0),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_TXD1),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_TXD2),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_TXD3),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_TXEN),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC0_TXC),
+};
+
+static int jh7110_aon_pmx_set_one_pin_mux(struct starfive_pinctrl *pctl,
+					  struct starfive_pin *pin)
+{
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	struct starfive_pin_config *pin_config = &pin->pin_config;
+	const struct starfive_pin_reg *pin_reg;
+	unsigned int gpio, pin_id;
+	int i;
+	unsigned long flags;
+	int n, shift;
+
+	gpio = pin->pin_config.gpio_num;
+	pin_id = pin->pin;
+	pin_reg = &pctl->pin_regs[pin_id];
+
+	raw_spin_lock_irqsave(&pctl->lock, flags);
+	if (pin_reg->func_sel_reg != -1) {
+		pinctrl_set_reg(pctl->padctl_base + pin_reg->func_sel_reg,
+				pin_config->pinmux_func,
+				pin_reg->func_sel_shift,
+				pin_reg->func_sel_mask);
+	}
+
+	shift = GET_GPO_CFG_SHIFT(gpio);
+	if (pin_reg->gpo_dout_reg != -1) {
+		pinctrl_write_reg(pctl->padctl_base + pin_reg->gpo_dout_reg,
+				  AON_GPO_DOUT_MASK << shift,
+				  pin_config->gpio_dout << shift);
+	}
+
+	if (pin_reg->gpo_doen_reg != -1) {
+		pinctrl_write_reg(pctl->padctl_base + pin_reg->gpo_doen_reg,
+				  AON_GPO_DOEN_MASK << shift,
+				  pin_config->gpio_doen << shift);
+	}
+
+	for (i = 0; i < pin_config->gpio_din_num; i++) {
+		n = pin_config->gpio_din_reg[i] >> 2;
+		shift = (pin_config->gpio_din_reg[i] & 3) << 3;
+		pinctrl_write_reg(pctl->padctl_base + info->din_reg_base + n * 4,
+				  AON_GPI_DIN_MASK << shift,
+				  (gpio + 2) << shift);
+	}
+
+	if (pin_reg->syscon_reg != -1) {
+		pinctrl_set_reg(pctl->padctl_base + pin_reg->syscon_reg,
+				pin_config->syscon,
+				PADCFG_PAD_GMAC_SYSCON_SHIFT,
+				PADCFG_PAD_GMAC_SYSCON_MASK);
+	}
+
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static void jh7110_aon_parse_pin_config(struct starfive_pinctrl *pctl,
+					unsigned int *pins_id,
+					struct starfive_pin *pin_data,
+					const __be32 *list_p,
+					struct device_node *np)
+{
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	struct starfive_pin_reg *pin_reg;
+	const __be32 *list = list_p;
+	const __be32 *list_din;
+	int size;
+	int size_din;
+	int pin_size;
+	u32 value;
+	int i;
+
+	pin_size = sizeof(u32);
+	*pins_id = be32_to_cpu(*list);
+	pin_reg = &pctl->pin_regs[*pins_id];
+	pin_data->pin = *pins_id;
+
+	if (pin_data->pin > PAD_GMAC0_TXC) {
+		dev_err(pctl->dev, "err pin num = %d\n", pin_data->pin);
+		return;
+	}
+
+	if (pin_data->pin < PAD_GMAC0_MDC) {
+		pin_reg->io_conf_reg = (pin_data->pin * A0N_GPO_PDA_CFG_OFFSET) +
+					AON_GPO_PDA_0_5_CFG;
+	}
+
+	if (!of_property_read_u32(np, "starfive,pin-ioconfig", &value))
+		pin_data->pin_config.io_config = value;
+
+	list = of_get_property(np, "starfive,pinmux", &size);
+	if (list) {
+		pin_reg->func_sel_reg = be32_to_cpu(*list++);
+		pin_reg->func_sel_shift = be32_to_cpu(*list++);
+		pin_reg->func_sel_mask = be32_to_cpu(*list++);
+		pin_data->pin_config.pinmux_func = be32_to_cpu(*list++);
+	}
+
+	list = of_get_property(np, "starfive,pin-syscon", &size);
+	if (list) {
+		pin_reg->syscon_reg = be32_to_cpu(*list++);
+		pin_data->pin_config.syscon = be32_to_cpu(*list++);
+	}
+
+	if (pin_data->pin >= PAD_RGPIO0 && pin_data->pin <= PAD_RGPIO3) {
+		pin_data->pin_config.gpio_num = pin_data->pin - 1;
+		pin_reg->gpo_dout_reg = info->dout_reg_base;
+		pin_reg->gpo_doen_reg = info->doen_reg_base;
+
+		if (!of_property_read_u32(np, "starfive,pin-gpio-dout", &value))
+			pin_data->pin_config.gpio_dout = value;
+
+		if (!of_property_read_u32(np, "starfive,pin-gpio-doen", &value))
+			pin_data->pin_config.gpio_doen = value;
+
+		list_din = of_get_property(np, "starfive,pin-gpio-din", &size_din);
+		if (list_din) {
+			if (!size_din || size_din % pin_size) {
+				dev_err(pctl->dev,
+					"Invalid starfive,pin-gpio-din property in node\n");
+				return;
+			}
+			pin_data->pin_config.gpio_din_num = size_din / pin_size;
+			pin_data->pin_config.gpio_din_reg =
+				devm_kcalloc(pctl->dev,
+					     pin_data->pin_config.gpio_din_num,
+					     sizeof(s32),
+					     GFP_KERNEL);
+			for (i = 0; i < pin_data->pin_config.gpio_din_num; i++) {
+				value = be32_to_cpu(*list_din++);
+				pin_data->pin_config.gpio_din_reg[i] = value;
+			}
+		}
+	}
+}
+
+static int jh7110_aon_direction_input(struct gpio_chip *gc,
+				      unsigned int gpio)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int shift;
+	void __iomem *reg_doen;
+	u32 mask;
+
+	if (gpio < 0 || gpio >= gc->ngpio)
+		return -EINVAL;
+
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask = AON_GPO_DOEN_MASK << shift;
+	reg_doen = chip->padctl_base + AON_GPO_DOEN_CFG;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	pinctrl_set_reg(reg_doen, 1, shift, mask);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int jh7110_aon_direction_output(struct gpio_chip *gc,
+				       unsigned int gpio,
+				       int value)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int shift;
+	void __iomem *reg_doen, *reg_dout;
+	u32 mask_doen, mask_dout;
+
+	if (gpio < 0 || gpio >= gc->ngpio)
+		return -EINVAL;
+
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask_doen = AON_GPO_DOEN_MASK << shift;
+	mask_dout = AON_GPO_DOUT_MASK << shift;
+	reg_doen = chip->padctl_base + AON_GPO_DOEN_CFG;
+	reg_dout = chip->padctl_base + AON_GPO_DOUT_CFG;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	pinctrl_set_reg(reg_doen, 0, shift, mask_doen);
+
+	pinctrl_set_reg(reg_dout, value, shift, mask_dout);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int jh7110_aon_get_direction(struct gpio_chip *gc,
+				    unsigned int gpio)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int doen;
+	unsigned int shift;
+	void __iomem *reg_doen;
+	u32 mask;
+
+	if (gpio < 0 || gpio >= gc->ngpio)
+		return -EINVAL;
+
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask = AON_GPO_DOEN_MASK << shift;
+	reg_doen = chip->padctl_base + AON_GPO_DOEN_CFG;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	doen = readl_relaxed(reg_doen);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return !!(doen & mask);
+}
+
+static int jh7110_aon_get_value(struct gpio_chip *gc,
+				unsigned int gpio)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	int value;
+
+	if (gpio < 0 || gpio >= gc->ngpio)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	value = readl_relaxed(chip->padctl_base + AON_GPIO_DIN_REG);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return (value >> gpio) & 0x1;
+}
+
+static void jh7110_aon_set_value(struct gpio_chip *gc,
+				 unsigned int gpio, int value)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int shift;
+	void __iomem *reg_dout;
+	u32 mask;
+
+	if (gpio < 0 || gpio >= gc->ngpio)
+		return;
+
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask = AON_GPO_DOUT_MASK << shift;
+	reg_dout = chip->padctl_base + AON_GPO_DOUT_CFG;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	pinctrl_set_reg(reg_dout, value, shift, mask);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+}
+
+static void jh7110_aon_irq_handler(struct irq_desc *desc)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_desc(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long mis;
+	unsigned int pin;
+
+	chained_irq_enter(chip, desc);
+
+	mis = readl_relaxed(sfp->padctl_base + AON_GPIO_MIS_REG);
+	for_each_set_bit(pin, &mis, AON_GPIO_NUM)
+		generic_handle_domain_irq(sfp->gc.irq.domain, pin);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int jh7110_aon_init_hw(struct gpio_chip *gc)
+{
+	struct starfive_pinctrl *sfp = container_of(gc,
+			struct starfive_pinctrl, gc);
+
+	/* mask all GPIO interrupts */
+	writel_relaxed(0, sfp->padctl_base + AON_GPIO_IE_REG);
+	/* clear edge interrupt flags */
+	writel_relaxed(0, sfp->padctl_base + AON_GPIO_IC_REG);
+	writel_relaxed(0x0f, sfp->padctl_base + AON_GPIO_IC_REG);
+	/* enable GPIO interrupts */
+	writel_relaxed(1, sfp->padctl_base + AON_GPIO_EN_REG);
+	return 0;
+}
+
+static int jh7110_aon_irq_set_type(struct irq_data *d,
+				   unsigned int trigger)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *base = sfp->padctl_base;
+	u32 mask = BIT(gpio);
+	u32 irq_type, edge_both, polarity;
+	unsigned long flags;
+
+	switch (trigger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type  = 0;    /* 0: level triggered */
+		edge_both = 0;    /* 0: ignored */
+		polarity  = 0;    /* 0: high level */
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type  = 0;    /* 0: level triggered */
+		edge_both = 0;    /* 0: ignored */
+		polarity  = 1;    /* 1: low level */
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = mask; /* 1: both edges */
+		polarity  = 0;    /* 0: ignored */
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = 0;    /* 0: single edge */
+		polarity  = mask; /* 1: rising edge */
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = 0;    /* 0: single edge */
+		polarity  = 0;    /* 0: falling edge */
+		break;
+	}
+	if (trigger & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	irq_type |= readl_relaxed(base + AON_GPIO_IS_REG) & ~mask;
+	writel_relaxed(irq_type, base + AON_GPIO_IS_REG);
+
+	edge_both |= readl_relaxed(base + AON_GPIO_IBE_REG) & ~mask;
+	writel_relaxed(edge_both, base + AON_GPIO_IBE_REG);
+
+	polarity |= readl_relaxed(base + AON_GPIO_IEV_REG) & ~mask;
+	writel_relaxed(polarity, base + AON_GPIO_IEV_REG);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+
+	sfp->trigger[gpio] = trigger;
+	return 0;
+}
+
+static void jh7110_aon_irq_mask(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->padctl_base + AON_GPIO_IE_REG;
+	u32 mask = BIT(gpio);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh7110_aon_irq_unmask(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->padctl_base + AON_GPIO_IE_REG;
+	u32 mask = BIT(gpio);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) | mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh7110_aon_irq_ack(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ic = sfp->padctl_base + AON_GPIO_IC_REG;
+	u32 mask = BIT(gpio);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh7110_aon_irq_mask_ack(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->padctl_base + AON_GPIO_IE_REG;
+	void __iomem *ic = sfp->padctl_base + AON_GPIO_IC_REG;
+	u32 mask = BIT(gpio);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+
+	value = readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static struct irq_chip jh7110_aon_irqchip = {
+	.name		= "starfive-jh7110-aon-gpio",
+	.irq_ack	= jh7110_aon_irq_ack,
+	.irq_mask_ack	= jh7110_aon_irq_mask_ack,
+	.irq_set_type	= jh7110_aon_irq_set_type,
+	.irq_mask	= jh7110_aon_irq_mask,
+	.irq_unmask	= jh7110_aon_irq_unmask,
+	.flags = IRQCHIP_IMMUTABLE | IRQCHIP_SET_TYPE_MASKED,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int jh7110_aon_add_pin_ranges(struct gpio_chip *gc)
+{
+	struct starfive_pinctrl *sfp = container_of(gc,
+			struct starfive_pinctrl, gc);
+
+	sfp->gpios.name = sfp->gc.label;
+	sfp->gpios.base = sfp->gc.base;
+	/*
+	 * sfp->gpios.pin_base depends on the chosen signal group
+	 * and is set in starfive_probe()
+	 */
+	sfp->gpios.npins = AON_GPIO_NUM;
+	sfp->gpios.gc = &sfp->gc;
+	pinctrl_add_gpio_range(sfp->pctl_dev, &sfp->gpios);
+	return 0;
+}
+
+static int jh7110_aon_gpio_register(struct platform_device *pdev,
+				    struct starfive_pinctrl *pctl)
+{
+	struct device *dev = &pdev->dev;
+	int ret, ngpio;
+	int loop;
+
+	ngpio = AON_GPIO_NUM;
+
+	pctl->gc.direction_input = jh7110_aon_direction_input;
+	pctl->gc.direction_output = jh7110_aon_direction_output;
+	pctl->gc.get_direction = jh7110_aon_get_direction;
+	pctl->gc.get = jh7110_aon_get_value;
+	pctl->gc.set = jh7110_aon_set_value;
+	pctl->gc.add_pin_ranges = jh7110_aon_add_pin_ranges;
+	pctl->gc.base = MAX_GPIO;
+	pctl->gc.ngpio = ngpio;
+	pctl->gc.label = dev_name(dev);
+	pctl->gc.parent = dev;
+	pctl->gc.owner = THIS_MODULE;
+
+	pctl->enabled = 0;
+
+	platform_set_drvdata(pdev, pctl);
+
+	jh7110_aon_irqchip.name = pctl->gc.label;
+
+	pctl->gc.irq.chip = &jh7110_aon_irqchip;
+	pctl->gc.irq.parent_handler = jh7110_aon_irq_handler;
+	pctl->gc.irq.num_parents = 1;
+	pctl->gc.irq.parents =
+		devm_kcalloc(dev, pctl->gc.irq.num_parents,
+			     sizeof(*pctl->gc.irq.parents), GFP_KERNEL);
+	if (!pctl->gc.irq.parents)
+		return -ENOMEM;
+	pctl->gc.irq.default_type = IRQ_TYPE_NONE;
+	pctl->gc.irq.handler = handle_bad_irq;
+	pctl->gc.irq.init_hw = jh7110_aon_init_hw;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	pctl->gc.irq.parents[0] = ret;
+
+	ret = devm_gpiochip_add_data(dev, &pctl->gc, pctl);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not register gpiochip\n");
+
+	for (loop = 0; loop < ngpio; loop++) {
+		unsigned int v;
+		void __iomem *ie_reg = pctl->padctl_base +
+				AON_GPIO_INPUT_ENABLE_REG + (loop << 2);
+
+		v = readl_relaxed(ie_reg);
+		v |= 0x1;
+		writel_relaxed(v, ie_reg);
+	}
+
+	dev_info(dev, "StarFive AON GPIO chip registered %d GPIOs\n", ngpio);
+
+	return 0;
+}
+
+static int jh7110_aon_pinconf_get(struct pinctrl_dev *pctldev,
+				  unsigned int pin_id,
+				  unsigned long *config)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	const struct starfive_pin_reg *pin_reg = &pctl->pin_regs[pin_id];
+	unsigned long flags;
+	u32 value;
+
+	if (pin_reg->io_conf_reg == -1) {
+		dev_err(pctl->dev,
+			"Pin(%s) does not support config function\n",
+			info->pins[pin_id].name);
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&pctl->lock, flags);
+	value = readl_relaxed(pctl->padctl_base + pin_reg->io_conf_reg);
+	*config = value & 0xff;
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static int jh7110_aon_pinconf_set(struct pinctrl_dev *pctldev,
+				  unsigned int pin_id,
+				  unsigned long *configs,
+				  unsigned int num_configs)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	const struct starfive_pin_reg *pin_reg = &pctl->pin_regs[pin_id];
+	int i;
+	u32 value;
+	unsigned long flags;
+
+	if (pin_reg->io_conf_reg == -1) {
+		dev_err(pctl->dev,
+			"Pin(%s) does not support config function\n",
+			info->pins[pin_id].name);
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&pctl->lock, flags);
+	for (i = 0; i < num_configs; i++) {
+		value = readl_relaxed(pctl->padctl_base +
+				      pin_reg->io_conf_reg);
+		value = value | (configs[i] & 0xFF);
+		writel_relaxed(value, pctl->padctl_base +
+				pin_reg->io_conf_reg);
+	}
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static const struct starfive_pinctrl_soc_info jh7110_aon_pinctrl_info = {
+	.pins = starfive_jh7110_aon_pinctrl_pads,
+	.npins = ARRAY_SIZE(starfive_jh7110_aon_pinctrl_pads),
+	.flags = 1,
+	.dout_reg_base = AON_GPO_DOUT_CFG,
+	.doen_reg_base = AON_GPO_DOEN_CFG,
+	.din_reg_base = AON_GPI_DIN_CFG,
+	.starfive_pinconf_get = jh7110_aon_pinconf_get,
+	.starfive_pinconf_set = jh7110_aon_pinconf_set,
+	.starfive_pmx_set_one_pin_mux = jh7110_aon_pmx_set_one_pin_mux,
+	.starfive_gpio_register = jh7110_aon_gpio_register,
+	.starfive_pinctrl_parse_pin = jh7110_aon_parse_pin_config,
+};
+
+static const struct of_device_id jh7110_aon_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh7110-aon-pinctrl",
+		.data = &jh7110_aon_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+
+static int jh7110_aon_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct starfive_pinctrl_soc_info *pinctrl_info;
+
+	pinctrl_info = of_device_get_match_data(&pdev->dev);
+	if (!pinctrl_info)
+		return -ENODEV;
+
+	return starfive_pinctrl_probe(pdev, pinctrl_info);
+}
+
+static struct platform_driver jh7110_aon_pinctrl_driver = {
+	.driver = {
+		.name = "starfive-jh7110-aon-pinctrl",
+		.of_match_table = of_match_ptr(jh7110_aon_pinctrl_of_match),
+	},
+	.probe = jh7110_aon_pinctrl_probe,
+};
+
+static int __init jh7110_aon_pinctrl_init(void)
+{
+	return platform_driver_register(&jh7110_aon_pinctrl_driver);
+}
+arch_initcall(jh7110_aon_pinctrl_init);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH7110 SoC aon controller");
+MODULE_AUTHOR("Jenny Zhang <jenny.zhang@starfivetech.com>");
+MODULE_AUTHOR("Jianlong Huang <jianlong.huang@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
new file mode 100644
index 000000000000..882d45c63497
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
@@ -0,0 +1,925 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl / GPIO driver for StarFive JH7110 SoC sys controller
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+#include "pinctrl-starfive.h"
+
+#define SYS_GPO_DOEN_CFG		0x0
+#define SYS_GPO_DOEN_MASK		GENMASK(5, 0)
+#define SYS_GPO_DOUT_CFG		0x40
+#define SYS_GPO_DOUT_MASK		GENMASK(6, 0)
+#define SYS_GPI_DIN_CFG			0x80
+#define SYS_GPI_DIN_MASK		GENMASK(6, 0)
+#define SYS_GPIO_INPUT_ENABLE_REG	0x120
+
+/* sys_iomux PIN 0-74 ioconfig reg */
+#define SYS_GPO_PDA_0_74_CFG		0x120
+/* sys_iomux PIN 89-94 ioconfig reg */
+#define SYS_GPO_PDA_89_94_CFG		0x284
+#define SYS_GPO_PDA_CFG_OFFSET		0x4
+
+/* sys_iomux GPIO CTRL */
+#define GPIO_EN				0xdc
+#define GPIO_IS_LOW			0xe0
+#define GPIO_IS_HIGH			0xe4
+#define GPIO_IC_LOW			0xe8
+#define GPIO_IC_HIGH			0xec
+#define GPIO_IBE_LOW			0xf0
+#define GPIO_IBE_HIGH			0xf4
+#define GPIO_IEV_LOW			0xf8
+#define GPIO_IEV_HIGH			0xfc
+#define GPIO_IE_LOW			0x100
+#define GPIO_IE_HIGH			0x104
+
+/* read only */
+#define GPIO_MIS_LOW			0x110
+#define GPIO_MIS_HIGH			0x114
+#define GPIO_DIN_LOW			0x118
+#define GPIO_DIN_HIGH			0x11c
+
+#define PADCFG_PAD_GMAC_SYSCON_SHIFT	0x0
+#define PADCFG_PAD_GMAC_SYSCON_MASK	GENMASK(1, 0)
+
+/* one dword include 4 gpios */
+#define GPIO_NUM_SHIFT			2
+#define GPIO_NUM_PER_REG		32
+#define OFFSET_PER_REG			4
+#define SYS_GPIO_NUM			64
+
+enum starfive_jh7110_sys_pads {
+	PAD_GPIO0	= 0,
+	PAD_GPIO1	= 1,
+	PAD_GPIO2	= 2,
+	PAD_GPIO3	= 3,
+	PAD_GPIO4	= 4,
+	PAD_GPIO5	= 5,
+	PAD_GPIO6	= 6,
+	PAD_GPIO7	= 7,
+	PAD_GPIO8	= 8,
+	PAD_GPIO9	= 9,
+	PAD_GPIO10	= 10,
+	PAD_GPIO11	= 11,
+	PAD_GPIO12	= 12,
+	PAD_GPIO13	= 13,
+	PAD_GPIO14	= 14,
+	PAD_GPIO15	= 15,
+	PAD_GPIO16	= 16,
+	PAD_GPIO17	= 17,
+	PAD_GPIO18	= 18,
+	PAD_GPIO19	= 19,
+	PAD_GPIO20	= 20,
+	PAD_GPIO21	= 21,
+	PAD_GPIO22	= 22,
+	PAD_GPIO23	= 23,
+	PAD_GPIO24	= 24,
+	PAD_GPIO25	= 25,
+	PAD_GPIO26	= 26,
+	PAD_GPIO27	= 27,
+	PAD_GPIO28	= 28,
+	PAD_GPIO29	= 29,
+	PAD_GPIO30	= 30,
+	PAD_GPIO31	= 31,
+	PAD_GPIO32	= 32,
+	PAD_GPIO33	= 33,
+	PAD_GPIO34	= 34,
+	PAD_GPIO35	= 35,
+	PAD_GPIO36	= 36,
+	PAD_GPIO37	= 37,
+	PAD_GPIO38	= 38,
+	PAD_GPIO39	= 39,
+	PAD_GPIO40	= 40,
+	PAD_GPIO41	= 41,
+	PAD_GPIO42	= 42,
+	PAD_GPIO43	= 43,
+	PAD_GPIO44	= 44,
+	PAD_GPIO45	= 45,
+	PAD_GPIO46	= 46,
+	PAD_GPIO47	= 47,
+	PAD_GPIO48	= 48,
+	PAD_GPIO49	= 49,
+	PAD_GPIO50	= 50,
+	PAD_GPIO51	= 51,
+	PAD_GPIO52	= 52,
+	PAD_GPIO53	= 53,
+	PAD_GPIO54	= 54,
+	PAD_GPIO55	= 55,
+	PAD_GPIO56	= 56,
+	PAD_GPIO57	= 57,
+	PAD_GPIO58	= 58,
+	PAD_GPIO59	= 59,
+	PAD_GPIO60	= 60,
+	PAD_GPIO61	= 61,
+	PAD_GPIO62	= 62,
+	PAD_GPIO63	= 63,
+	PAD_SD0_CLK	= 64,
+	PAD_SD0_CMD	= 65,
+	PAD_SD0_DATA0	= 66,
+	PAD_SD0_DATA1	= 67,
+	PAD_SD0_DATA2	= 68,
+	PAD_SD0_DATA3	= 69,
+	PAD_SD0_DATA4	= 70,
+	PAD_SD0_DATA5	= 71,
+	PAD_SD0_DATA6	= 72,
+	PAD_SD0_DATA7	= 73,
+	PAD_SD0_STRB	= 74,
+	PAD_GMAC1_MDC	= 75,
+	PAD_GMAC1_MDIO	= 76,
+	PAD_GMAC1_RXD0	= 77,
+	PAD_GMAC1_RXD1	= 78,
+	PAD_GMAC1_RXD2	= 79,
+	PAD_GMAC1_RXD3	= 80,
+	PAD_GMAC1_RXDV	= 81,
+	PAD_GMAC1_RXC	= 82,
+	PAD_GMAC1_TXD0	= 83,
+	PAD_GMAC1_TXD1	= 84,
+	PAD_GMAC1_TXD2	= 85,
+	PAD_GMAC1_TXD3	= 86,
+	PAD_GMAC1_TXEN	= 87,
+	PAD_GMAC1_TXC	= 88,
+	PAD_QSPI_SCLK	= 89,
+	PAD_QSPI_CSn0	= 90,
+	PAD_QSPI_DATA0	= 91,
+	PAD_QSPI_DATA1	= 92,
+	PAD_QSPI_DATA2	= 93,
+	PAD_QSPI_DATA3	= 94,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc starfive_jh7110_sys_pinctrl_pads[] = {
+	STARFIVE_PINCTRL_PIN(PAD_GPIO0),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO1),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO2),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO3),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO4),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO5),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO6),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO7),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO8),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO9),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO10),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO11),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO12),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO13),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO14),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO15),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO16),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO17),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO18),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO19),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO20),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO21),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO22),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO23),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO24),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO25),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO26),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO27),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO28),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO29),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO30),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO31),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO32),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO33),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO34),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO35),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO36),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO37),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO38),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO39),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO40),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO41),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO42),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO43),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO44),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO45),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO46),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO47),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO48),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO49),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO50),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO51),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO52),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO53),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO54),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO55),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO56),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO57),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO58),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO59),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO60),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO61),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO62),
+	STARFIVE_PINCTRL_PIN(PAD_GPIO63),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_CLK),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_CMD),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA0),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA1),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA2),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA3),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA4),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA5),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA6),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_DATA7),
+	STARFIVE_PINCTRL_PIN(PAD_SD0_STRB),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_MDC),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_MDIO),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_RXD0),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_RXD1),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_RXD2),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_RXD3),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_RXDV),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_RXC),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_TXD0),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_TXD1),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_TXD2),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_TXD3),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_TXEN),
+	STARFIVE_PINCTRL_PIN(PAD_GMAC1_TXC),
+	STARFIVE_PINCTRL_PIN(PAD_QSPI_SCLK),
+	STARFIVE_PINCTRL_PIN(PAD_QSPI_CSn0),
+	STARFIVE_PINCTRL_PIN(PAD_QSPI_DATA0),
+	STARFIVE_PINCTRL_PIN(PAD_QSPI_DATA1),
+	STARFIVE_PINCTRL_PIN(PAD_QSPI_DATA2),
+	STARFIVE_PINCTRL_PIN(PAD_QSPI_DATA3),
+};
+
+static int jh7110_sys_direction_input(struct gpio_chip *gc,
+				      unsigned int gpio)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int offset, shift;
+	void __iomem *reg_doen;
+	u32 mask;
+
+	if (gpio >= gc->ngpio)
+		return -EINVAL;
+
+	offset = GET_GPO_REG_OFFSET(gpio);
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask = SYS_GPO_DOEN_MASK << shift;
+	reg_doen = chip->padctl_base + SYS_GPO_DOEN_CFG + offset;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	pinctrl_set_reg(reg_doen, 1, shift, mask);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int jh7110_sys_direction_output(struct gpio_chip *gc,
+				       unsigned int gpio,
+				       int value)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int offset, shift;
+	void __iomem *reg_doen, *reg_dout;
+	u32 mask_doen, mask_dout;
+
+	if (gpio >= gc->ngpio)
+		return -EINVAL;
+
+	offset = GET_GPO_REG_OFFSET(gpio);
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask_doen = SYS_GPO_DOEN_MASK << shift;
+	mask_dout = SYS_GPO_DOUT_MASK << shift;
+	reg_doen = chip->padctl_base + SYS_GPO_DOEN_CFG + offset;
+	reg_dout = chip->padctl_base + SYS_GPO_DOUT_CFG + offset;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	pinctrl_set_reg(reg_doen, 0, shift, mask_doen);
+
+	pinctrl_set_reg(reg_dout, value, shift, mask_dout);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int jh7110_sys_get_direction(struct gpio_chip *gc,
+				    unsigned int gpio)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int doen;
+	unsigned int offset, shift;
+	void __iomem *reg_doen;
+	u32 mask;
+
+	if (gpio >= gc->ngpio)
+		return -EINVAL;
+
+	offset = GET_GPO_REG_OFFSET(gpio);
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask = SYS_GPO_DOEN_MASK << shift;
+	reg_doen = chip->padctl_base + SYS_GPO_DOEN_CFG + offset;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	doen = readl_relaxed(reg_doen);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+
+	return !!(doen & mask);
+}
+
+static int jh7110_sys_get_value(struct gpio_chip *gc,
+				unsigned int gpio)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	int value;
+	int tmp;
+
+	if (gpio >= gc->ngpio)
+		return -EINVAL;
+
+	if (gpio < GPIO_NUM_PER_REG) {
+		value = readl_relaxed(chip->padctl_base + GPIO_DIN_LOW);
+		tmp = 0;
+	} else {
+		value = readl_relaxed(chip->padctl_base + GPIO_DIN_HIGH);
+		tmp = GPIO_NUM_PER_REG;
+	}
+	return (value >> (gpio - tmp)) & 0x1;
+}
+
+static void jh7110_sys_set_value(struct gpio_chip *gc,
+				 unsigned int gpio,
+				 int value)
+{
+	struct starfive_pinctrl *chip = gpiochip_get_data(gc);
+	unsigned long flags;
+	unsigned int offset, shift;
+	void __iomem *reg_dout;
+	u32 mask;
+
+	if (gpio >= gc->ngpio)
+		return;
+
+	offset = GET_GPO_REG_OFFSET(gpio);
+	shift  = GET_GPO_CFG_SHIFT(gpio);
+	mask = SYS_GPO_DOUT_MASK << shift;
+	reg_dout = chip->padctl_base + SYS_GPO_DOUT_CFG + offset;
+
+	raw_spin_lock_irqsave(&chip->lock, flags);
+	pinctrl_set_reg(reg_dout, value, shift, mask);
+	raw_spin_unlock_irqrestore(&chip->lock, flags);
+}
+
+static int jh7110_sys_irq_set_type(struct irq_data *d,
+				   unsigned int trigger)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *base = sfp->padctl_base +
+			OFFSET_PER_REG * (gpio / GPIO_NUM_PER_REG);
+	u32 mask = BIT(gpio % GPIO_NUM_PER_REG);
+	u32 irq_type, edge_both, polarity;
+	unsigned long flags;
+
+	switch (trigger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type  = 0;    /* 0: level triggered */
+		edge_both = 0;    /* 0: ignored */
+		polarity  = 0;    /* 0: high level */
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type  = 0;    /* 0: level triggered */
+		edge_both = 0;    /* 0: ignored */
+		polarity  = 1;    /* 1: low level */
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = mask; /* 1: both edges */
+		polarity  = 0;    /* 0: ignored */
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = 0;    /* 0: single edge */
+		polarity  = mask; /* 1: rising edge */
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_type  = mask; /* 1: edge triggered */
+		edge_both = 0;    /* 0: single edge */
+		polarity  = 0;    /* 0: falling edge */
+		break;
+	}
+	if (trigger & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	irq_type |= readl_relaxed(base + GPIO_IS_LOW) & ~mask;
+	writel_relaxed(irq_type, base + GPIO_IS_LOW);
+
+	edge_both |= readl_relaxed(base + GPIO_IBE_LOW) & ~mask;
+	writel_relaxed(edge_both, base + GPIO_IBE_LOW);
+
+	polarity |= readl_relaxed(base + GPIO_IEV_LOW) & ~mask;
+	writel_relaxed(polarity, base + GPIO_IEV_LOW);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+
+	sfp->trigger[gpio] = trigger;
+	return 0;
+}
+
+/* chained_irq_{enter,exit} already mask the parent */
+static void jh7110_sys_irq_mask(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->padctl_base + GPIO_IE_LOW +
+			OFFSET_PER_REG * (gpio / GPIO_NUM_PER_REG);
+	u32 mask = BIT(gpio % GPIO_NUM_PER_REG);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh7110_sys_irq_unmask(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->padctl_base + GPIO_IE_LOW +
+			OFFSET_PER_REG * (gpio / GPIO_NUM_PER_REG);
+	u32 mask = BIT(gpio % GPIO_NUM_PER_REG);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) | mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh7110_sys_irq_ack(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ic = sfp->padctl_base + GPIO_IC_LOW +
+			OFFSET_PER_REG * (gpio / GPIO_NUM_PER_REG);
+	u32 mask = BIT(gpio % GPIO_NUM_PER_REG);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh7110_sys_irq_mask_ack(struct irq_data *d)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	void __iomem *ie = sfp->padctl_base + GPIO_IE_LOW +
+			OFFSET_PER_REG * (gpio / GPIO_NUM_PER_REG);
+	void __iomem *ic = sfp->padctl_base + GPIO_IC_LOW +
+			OFFSET_PER_REG * (gpio / GPIO_NUM_PER_REG);
+	u32 mask = BIT(gpio % GPIO_NUM_PER_REG);
+	unsigned long flags;
+	u32 value;
+
+	if (gpio < 0 || gpio >= sfp->gc.ngpio)
+		return;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value = readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+
+	value = readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static struct irq_chip jh7110_sys_irqchip = {
+	.name		= "starfive-jh7110-sys-gpio",
+	.irq_ack	= jh7110_sys_irq_ack,
+	.irq_mask_ack	= jh7110_sys_irq_mask_ack,
+	.irq_set_type	= jh7110_sys_irq_set_type,
+	.irq_mask	= jh7110_sys_irq_mask,
+	.irq_unmask	= jh7110_sys_irq_unmask,
+	.flags = IRQCHIP_IMMUTABLE | IRQCHIP_SET_TYPE_MASKED,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static void jh7110_sys_irq_handler(struct irq_desc *desc)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_desc(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long mis;
+	unsigned int pin;
+
+	chained_irq_enter(chip, desc);
+
+	mis = readl_relaxed(sfp->padctl_base + GPIO_MIS_LOW);
+	for_each_set_bit(pin, &mis, GPIO_NUM_PER_REG)
+		generic_handle_domain_irq(sfp->gc.irq.domain, pin);
+
+	mis = readl_relaxed(sfp->padctl_base + GPIO_MIS_HIGH);
+	for_each_set_bit(pin, &mis, GPIO_NUM_PER_REG)
+		generic_handle_domain_irq(sfp->gc.irq.domain,
+					  pin + GPIO_NUM_PER_REG);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int jh7110_sys_init_hw(struct gpio_chip *gc)
+{
+	struct starfive_pinctrl *sfp = container_of(gc,
+			struct starfive_pinctrl, gc);
+
+	/* mask all GPIO interrupts */
+	writel_relaxed(0, sfp->padctl_base + GPIO_IE_LOW);
+	writel_relaxed(0, sfp->padctl_base + GPIO_IE_HIGH);
+	/* clear edge interrupt flags */
+	writel_relaxed(0, sfp->padctl_base + GPIO_IC_LOW);
+	writel_relaxed(0, sfp->padctl_base + GPIO_IC_HIGH);
+	writel_relaxed(~0U, sfp->padctl_base + GPIO_IC_LOW);
+	writel_relaxed(~0U, sfp->padctl_base + GPIO_IC_HIGH);
+	/* enable GPIO interrupts */
+	writel_relaxed(1, sfp->padctl_base + GPIO_EN);
+	return 0;
+}
+
+static int jh7110_sys_add_pin_ranges(struct gpio_chip *gc)
+{
+	struct starfive_pinctrl *sfp = container_of(gc,
+			struct starfive_pinctrl, gc);
+
+	sfp->gpios.name = sfp->gc.label;
+	sfp->gpios.base = sfp->gc.base;
+	/*
+	 * sfp->gpios.pin_base depends on the chosen signal group
+	 * and is set in starfive_probe()
+	 */
+	sfp->gpios.npins = SYS_GPIO_NUM;
+	sfp->gpios.gc = &sfp->gc;
+	pinctrl_add_gpio_range(sfp->pctl_dev, &sfp->gpios);
+	return 0;
+}
+
+static int jh7110_sys_gpio_register(struct platform_device *pdev,
+				    struct starfive_pinctrl *pctl)
+{
+	struct device *dev = &pdev->dev;
+	int ret, ngpio;
+	int loop;
+
+	ngpio = SYS_GPIO_NUM;
+
+	pctl->gc.direction_input = jh7110_sys_direction_input;
+	pctl->gc.direction_output = jh7110_sys_direction_output;
+	pctl->gc.get_direction = jh7110_sys_get_direction;
+	pctl->gc.get = jh7110_sys_get_value;
+	pctl->gc.set = jh7110_sys_set_value;
+	pctl->gc.add_pin_ranges = jh7110_sys_add_pin_ranges;
+	pctl->gc.base = 0;
+	pctl->gc.ngpio = ngpio;
+	pctl->gc.label = dev_name(dev);
+	pctl->gc.parent = dev;
+	pctl->gc.owner = THIS_MODULE;
+	pctl->enabled = 0;
+
+	platform_set_drvdata(pdev, pctl);
+
+	jh7110_sys_irqchip.name = pctl->gc.label;
+
+	pctl->gc.irq.chip = &jh7110_sys_irqchip;
+	pctl->gc.irq.parent_handler = jh7110_sys_irq_handler;
+	pctl->gc.irq.num_parents = 1;
+	pctl->gc.irq.parents = devm_kcalloc(dev, pctl->gc.irq.num_parents,
+					    sizeof(*pctl->gc.irq.parents),
+					    GFP_KERNEL);
+	if (!pctl->gc.irq.parents)
+		return -ENOMEM;
+	pctl->gc.irq.default_type = IRQ_TYPE_NONE;
+	pctl->gc.irq.handler = handle_bad_irq;
+	pctl->gc.irq.init_hw = jh7110_sys_init_hw;
+
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_enable(dev);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	pctl->gc.irq.parents[0] = ret;
+
+	ret = devm_gpiochip_add_data(dev, &pctl->gc, pctl);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"could not register gpiochip\n");
+
+	for (loop = 0; loop < SYS_GPIO_NUM; loop++) {
+		unsigned int v;
+		void __iomem *reg_ie = pctl->padctl_base +
+			SYS_GPIO_INPUT_ENABLE_REG + (loop << 2);
+
+		v = readl_relaxed(reg_ie);
+		v |= 0x1;
+		writel_relaxed(v, reg_ie);
+	}
+
+	dev_info(dev, "StarFive SYS GPIO chip registered %d GPIOs\n", ngpio);
+
+	return 0;
+}
+
+static int jh7110_pinconf_get(struct pinctrl_dev *pctldev,
+			      unsigned int pin_id,
+			      unsigned long *config)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	const struct starfive_pin_reg *pin_reg = &pctl->pin_regs[pin_id];
+	u32 value;
+
+	if (pin_reg->io_conf_reg == -1) {
+		dev_err(pctl->dev,
+			"Pin(%s) does not support config function\n",
+			info->pins[pin_id].name);
+		return -EINVAL;
+	}
+
+	value = readl_relaxed(pctl->padctl_base + pin_reg->io_conf_reg);
+	*config = value & 0xff;
+	return 0;
+}
+
+static int jh7110_pinconf_set(struct pinctrl_dev *pctldev,
+			      unsigned int pin_id,
+			      unsigned long *configs,
+			      unsigned int num_configs)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	const struct starfive_pin_reg *pin_reg = &pctl->pin_regs[pin_id];
+	int i;
+	u32 value;
+	unsigned long flags;
+
+	if (pin_reg->io_conf_reg == -1) {
+		dev_err(pctl->dev,
+			"Pin(%s) does not support config function\n",
+			info->pins[pin_id].name);
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&pctl->lock, flags);
+	for (i = 0; i < num_configs; i++) {
+		value = readl_relaxed(pctl->padctl_base +
+				pin_reg->io_conf_reg);
+		value = value | (configs[i] & 0xFF);
+		writel_relaxed(value, pctl->padctl_base +
+				pin_reg->io_conf_reg);
+	}
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static int jh7110_sys_pmx_set_one_pin_mux(struct starfive_pinctrl *pctl,
+					  struct starfive_pin *pin)
+{
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	struct starfive_pin_config *pin_config = &pin->pin_config;
+	const struct starfive_pin_reg *pin_reg;
+	unsigned int gpio, pin_id;
+	int i;
+	unsigned long flags;
+	int n, shift;
+
+	gpio = pin->pin_config.gpio_num;
+	pin_id = pin->pin;
+	pin_reg = &pctl->pin_regs[pin_id];
+
+	raw_spin_lock_irqsave(&pctl->lock, flags);
+	if (pin_reg->func_sel_reg != -1) {
+		pinctrl_set_reg(pctl->padctl_base + pin_reg->func_sel_reg,
+				pin_config->pinmux_func,
+				pin_reg->func_sel_shift,
+				pin_reg->func_sel_mask);
+	}
+
+	shift = GET_GPO_CFG_SHIFT(gpio);
+	if (pin_reg->gpo_dout_reg != -1) {
+		pinctrl_write_reg(pctl->padctl_base + pin_reg->gpo_dout_reg,
+				  SYS_GPO_DOUT_MASK << shift, pin_config->gpio_dout << shift);
+	}
+
+	if (pin_reg->gpo_doen_reg != -1) {
+		pinctrl_write_reg(pctl->padctl_base + pin_reg->gpo_doen_reg,
+				  SYS_GPO_DOEN_MASK << shift, pin_config->gpio_doen << shift);
+	}
+
+	for (i = 0; i < pin_config->gpio_din_num; i++) {
+		n = pin_config->gpio_din_reg[i] >> 2;
+		shift = (pin_config->gpio_din_reg[i] & 3) << 3;
+		pinctrl_write_reg(pctl->padctl_base + info->din_reg_base + n * 4,
+				  SYS_GPI_DIN_MASK << shift, (gpio + 2) << shift);
+	}
+
+	if (pin_reg->syscon_reg != -1) {
+		pinctrl_set_reg(pctl->padctl_base + pin_reg->syscon_reg,
+				pin_config->syscon, PADCFG_PAD_GMAC_SYSCON_SHIFT,
+				PADCFG_PAD_GMAC_SYSCON_MASK);
+	}
+
+	if (pin_reg->pad_sel_reg != -1) {
+		pinctrl_set_reg(pctl->padctl_base + pin_reg->pad_sel_reg,
+				pin_config->padmux_func,
+				pin_reg->pad_sel_shift,
+				pin_reg->pad_sel_mask);
+	}
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static void jh7110_sys_parse_pin_config(struct starfive_pinctrl *pctl,
+					unsigned int *pins_id,
+					struct starfive_pin *pin_data,
+					const __be32 *list_p,
+					struct device_node *np)
+{
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	struct starfive_pin_reg *pin_reg;
+	const __be32 *list = list_p;
+	const __be32 *list_din;
+	int size;
+	int size_din;
+	int pin_size;
+	u32 value;
+	int i;
+	int n;
+
+	pin_size = sizeof(u32);
+	*pins_id = be32_to_cpu(*list);
+	pin_reg = &pctl->pin_regs[*pins_id];
+	pin_data->pin = *pins_id;
+
+	if (pin_data->pin > PAD_QSPI_DATA3) {
+		dev_err(pctl->dev, "err pin num = %d\n", pin_data->pin);
+		return;
+	}
+
+	if (pin_data->pin < PAD_GMAC1_MDC) {
+		pin_reg->io_conf_reg = (pin_data->pin * SYS_GPO_PDA_CFG_OFFSET)
+			+ SYS_GPO_PDA_0_74_CFG;
+	} else if (pin_data->pin > PAD_GMAC1_TXC) {
+		pin_reg->io_conf_reg = (pin_data->pin * SYS_GPO_PDA_CFG_OFFSET)
+			+ SYS_GPO_PDA_89_94_CFG;
+	}
+
+	if (!of_property_read_u32(np, "starfive,pin-ioconfig", &value))
+		pin_data->pin_config.io_config = value;
+
+	list = of_get_property(np, "starfive,pinmux", &size);
+	if (list) {
+		pin_reg->func_sel_reg = be32_to_cpu(*list++);
+		pin_reg->func_sel_shift = be32_to_cpu(*list++);
+		pin_reg->func_sel_mask = be32_to_cpu(*list++);
+		pin_data->pin_config.pinmux_func = be32_to_cpu(*list++);
+	}
+
+	list = of_get_property(np, "starfive,padmux", &size);
+	if (list) {
+		pin_reg->pad_sel_reg = be32_to_cpu(*list++);
+		pin_reg->pad_sel_shift = be32_to_cpu(*list++);
+		pin_reg->pad_sel_mask = be32_to_cpu(*list++);
+		pin_data->pin_config.padmux_func = be32_to_cpu(*list++);
+	}
+
+	list = of_get_property(np, "starfive,pin-syscon", &size);
+	if (list) {
+		pin_reg->syscon_reg = be32_to_cpu(*list++);
+		pin_data->pin_config.syscon = be32_to_cpu(*list++);
+	}
+
+	if (pin_data->pin < PAD_SD0_CLK) {
+		pin_data->pin_config.gpio_num = pin_data->pin;
+		n = pin_data->pin_config.gpio_num >> GPIO_NUM_SHIFT;
+
+		if (!of_property_read_u32(np, "starfive,pin-gpio-dout", &value)) {
+			pin_data->pin_config.gpio_dout = value;
+			pin_reg->gpo_dout_reg = info->dout_reg_base + n * 4;
+		}
+
+		if (!of_property_read_u32(np, "starfive,pin-gpio-doen", &value)) {
+			pin_data->pin_config.gpio_doen = value;
+			pin_reg->gpo_doen_reg = info->doen_reg_base + n * 4;
+		}
+
+		list_din = of_get_property(np, "starfive,pin-gpio-din", &size_din);
+		if (list_din) {
+			if (!size_din || size_din % pin_size) {
+				dev_err(pctl->dev,
+					"Invalid starfive,pin-gpio-din property in node\n");
+				return;
+			}
+
+			pin_data->pin_config.gpio_din_num = size_din / pin_size;
+			pin_data->pin_config.gpio_din_reg =
+				devm_kcalloc(pctl->dev,
+					     pin_data->pin_config.gpio_din_num,
+					     sizeof(s32),
+					     GFP_KERNEL);
+
+			for (i = 0; i < pin_data->pin_config.gpio_din_num; i++) {
+				value = be32_to_cpu(*list_din++);
+				pin_data->pin_config.gpio_din_reg[i] = value;
+			}
+		}
+	}
+}
+
+static const struct starfive_pinctrl_soc_info jh7110_sys_pinctrl_info = {
+	.pins = starfive_jh7110_sys_pinctrl_pads,
+	.npins = ARRAY_SIZE(starfive_jh7110_sys_pinctrl_pads),
+	.flags = 1,
+	.dout_reg_base = SYS_GPO_DOUT_CFG,
+	.doen_reg_base = SYS_GPO_DOEN_CFG,
+	.din_reg_base = SYS_GPI_DIN_CFG,
+	.starfive_pinconf_get = jh7110_pinconf_get,
+	.starfive_pinconf_set = jh7110_pinconf_set,
+	.starfive_pmx_set_one_pin_mux = jh7110_sys_pmx_set_one_pin_mux,
+	.starfive_gpio_register = jh7110_sys_gpio_register,
+	.starfive_pinctrl_parse_pin = jh7110_sys_parse_pin_config,
+};
+
+static const struct of_device_id jh7110_sys_pinctrl_of_match[] = {
+	{
+		.compatible = "starfive,jh7110-sys-pinctrl",
+		.data = &jh7110_sys_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+
+static int jh7110_sys_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct starfive_pinctrl_soc_info *pinctrl_info;
+
+	pinctrl_info = of_device_get_match_data(&pdev->dev);
+	if (!pinctrl_info)
+		return -ENODEV;
+
+	return starfive_pinctrl_probe(pdev, pinctrl_info);
+}
+
+static struct platform_driver jh7110_sys_pinctrl_driver = {
+	.driver = {
+		.name = "starfive-jh7110-sys-pinctrl",
+		.of_match_table = of_match_ptr(jh7110_sys_pinctrl_of_match),
+	},
+	.probe = jh7110_sys_pinctrl_probe,
+};
+
+static int __init jh7110_sys_pinctrl_init(void)
+{
+	return platform_driver_register(&jh7110_sys_pinctrl_driver);
+}
+arch_initcall(jh7110_sys_pinctrl_init);
+
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH7110 SoC sys controller");
+MODULE_AUTHOR("Jenny Zhang <jenny.zhang@starfivetech.com>");
+MODULE_AUTHOR("Jianlong Huang <jianlong.huang@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.c b/drivers/pinctrl/starfive/pinctrl-starfive.c
new file mode 100644
index 000000000000..80cf74ebc0e2
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl / GPIO driver for StarFive JH7110 SoC
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#include "../core.h"
+#include "../pinctrl-utils.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+#include "pinctrl-starfive.h"
+
+static inline const struct group_desc *
+starfive_pinctrl_find_group_by_name(struct pinctrl_dev *pctldev,
+				    const char *name)
+{
+	const struct group_desc *grp = NULL;
+	int i;
+
+	for (i = 0; i < pctldev->num_groups; i++) {
+		grp = pinctrl_generic_get_group(pctldev, i);
+		if (grp && !strcmp(grp->name, name))
+			break;
+	}
+
+	return grp;
+}
+
+static void starfive_pin_dbg_show(struct pinctrl_dev *pctldev,
+				  struct seq_file *s,
+				  unsigned int offset)
+{
+	seq_printf(s, "%s", dev_name(pctldev->dev));
+}
+
+static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
+				   struct device_node *np,
+				   struct pinctrl_map **maps,
+				   unsigned int *num_maps)
+{
+	struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
+	struct device *dev = sfp->gc.parent;
+	const struct starfive_pinctrl_soc_info *info = sfp->info;
+	struct starfive_pin *pin_data;
+	struct device_node *child;
+	struct pinctrl_map *map;
+	struct group_desc *grp;
+	const char **pgnames;
+	const char *grpname;
+	int ngroups;
+	int nmaps;
+	int ret;
+	int *pins_id;
+	int psize, pin_size;
+	int size = 0;
+	int offset = 0;
+	const __be32 *list;
+	int i, child_num_pins;
+
+	nmaps = 0;
+	ngroups = 0;
+	pin_size = STARFIVE_PINS_SIZE;
+
+	for_each_child_of_node(np, child) {
+		list = of_get_property(child, "starfive,pins", &psize);
+		if (!list) {
+			dev_err(sfp->dev,
+				"no starfive,pins and pins property in node %pOF\n", np);
+			return -EINVAL;
+		}
+		size += psize;
+	}
+
+	if (!size || size % pin_size) {
+		dev_err(sfp->dev,
+			"Invalid starfive,pins or pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	nmaps = size / pin_size * 2;
+	ngroups = size / pin_size;
+
+	pgnames = devm_kcalloc(dev, ngroups, sizeof(*pgnames), GFP_KERNEL);
+	if (!pgnames)
+		return -ENOMEM;
+
+	map = kcalloc(nmaps, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	grp = devm_kzalloc(sfp->dev, sizeof(struct group_desc), GFP_KERNEL);
+	if (!grp) {
+		of_node_put(child);
+		return -ENOMEM;
+	}
+
+	grp->data = devm_kcalloc(sfp->dev,
+				 ngroups, sizeof(struct starfive_pin),
+				 GFP_KERNEL);
+	grp->pins = devm_kcalloc(sfp->dev,
+				 ngroups, sizeof(int),
+				 GFP_KERNEL);
+	if (!grp->pins || !grp->data)
+		return -ENOMEM;
+
+	nmaps = 0;
+	ngroups = 0;
+	mutex_lock(&sfp->mutex);
+
+	for_each_child_of_node(np, child) {
+		grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
+		if (!grpname) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
+
+		pgnames[ngroups++] = grpname;
+		map[nmaps].type = PIN_MAP_TYPE_MUX_GROUP;
+		map[nmaps].data.mux.function = np->name;
+		map[nmaps].data.mux.group = grpname;
+		nmaps += 1;
+
+		list = of_get_property(child, "starfive,pins", &psize);
+		if (!list) {
+			dev_err(sfp->dev,
+				"no starfive,pins and pins property in node %pOF\n", np);
+			goto put_child;
+		}
+		child_num_pins = psize / pin_size;
+		grp->name = grpname;
+		grp->num_pins = child_num_pins;
+		for (i = 0; i < child_num_pins; i++) {
+			pin_data = &((struct starfive_pin *)(grp->data))[i + offset];
+			pins_id =  &grp->pins[i + offset];
+
+			if (!info->starfive_pinctrl_parse_pin) {
+				dev_err(sfp->dev,
+					"pinmux ops lacks necessary functions\n");
+				goto put_child;
+			}
+
+			info->starfive_pinctrl_parse_pin(sfp,
+					pins_id, pin_data, list, child);
+			map[nmaps].type = PIN_MAP_TYPE_CONFIGS_PIN;
+			map[nmaps].data.configs.group_or_pin =
+						pin_get_name(pctldev, pin_data->pin);
+			map[nmaps].data.configs.configs =
+						&pin_data->pin_config.io_config;
+			map[nmaps].data.configs.num_configs = 1;
+			nmaps += 1;
+
+			list++;
+		}
+		offset += i;
+
+		ret = pinctrl_generic_add_group(pctldev, grpname, pins_id,
+						child_num_pins, pin_data);
+		if (ret < 0) {
+			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
+			goto put_child;
+		}
+	}
+
+	ret = pinmux_generic_add_function(pctldev, np->name, pgnames, ngroups, NULL);
+	if (ret < 0) {
+		dev_err(dev, "error adding function %s: %d\n", np->name, ret);
+		goto free_map;
+	}
+
+	*maps = map;
+	*num_maps = nmaps;
+	mutex_unlock(&sfp->mutex);
+	return 0;
+
+put_child:
+	of_node_put(child);
+free_map:
+	pinctrl_utils_free_map(pctldev, map, nmaps);
+	mutex_unlock(&sfp->mutex);
+	return ret;
+}
+
+static void starfive_dt_free_map(struct pinctrl_dev *pctldev,
+				 struct pinctrl_map *map,
+				 unsigned int num_maps)
+{
+	kfree(map);
+}
+
+static const struct pinctrl_ops starfive_pctrl_ops = {
+	.get_groups_count = pinctrl_generic_get_group_count,
+	.get_group_name = pinctrl_generic_get_group_name,
+	.get_group_pins = pinctrl_generic_get_group_pins,
+	.pin_dbg_show = starfive_pin_dbg_show,
+	.dt_node_to_map = starfive_dt_node_to_map,
+	.dt_free_map = starfive_dt_free_map,
+};
+
+static int starfive_pmx_set(struct pinctrl_dev *pctldev,
+			    unsigned int selector, unsigned int group)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+	struct function_desc *func;
+	struct group_desc *grp;
+	struct starfive_pin *pin;
+	unsigned int npins;
+	int i, err;
+
+	grp = pinctrl_generic_get_group(pctldev, group);
+	if (!grp)
+		return -EINVAL;
+
+	func = pinmux_generic_get_function(pctldev, selector);
+	if (!func)
+		return -EINVAL;
+
+	npins = grp->num_pins;
+
+	dev_dbg(pctl->dev, "enable function %s group %s\n",
+		func->name, grp->name);
+
+	for (i = 0; i < npins; i++) {
+		pin = &((struct starfive_pin *)(grp->data))[i];
+		if (info->starfive_pmx_set_one_pin_mux) {
+			err = info->starfive_pmx_set_one_pin_mux(pctl, pin);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+const struct pinmux_ops starfive_pmx_ops = {
+	.get_functions_count = pinmux_generic_get_function_count,
+	.get_function_name = pinmux_generic_get_function_name,
+	.get_function_groups = pinmux_generic_get_function_groups,
+	.set_mux = starfive_pmx_set,
+};
+
+static int starfive_pinconf_get(struct pinctrl_dev *pctldev,
+				unsigned int pin_id, unsigned long *config)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+
+	if (info->starfive_pinconf_get)
+		return info->starfive_pinconf_get(pctldev, pin_id, config);
+
+	return 0;
+}
+
+static int starfive_pinconf_set(struct pinctrl_dev *pctldev,
+				unsigned int pin_id, unsigned long *configs,
+				unsigned int num_configs)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pinctrl_soc_info *info = pctl->info;
+
+	if (info->starfive_pinconf_set)
+		return info->starfive_pinconf_set(pctldev, pin_id,
+				configs, num_configs);
+	return 0;
+}
+
+static void starfive_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				      struct seq_file *s, unsigned int pin_id)
+{
+	struct starfive_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct starfive_pin_reg *pin_reg;
+	unsigned long config;
+	int ret;
+
+	pin_reg = &pctl->pin_regs[pin_id];
+	if (pin_reg->io_conf_reg == -1) {
+		seq_puts(s, "N/A");
+		return;
+	}
+
+	ret = starfive_pinconf_get(pctldev, pin_id, &config);
+	if (ret)
+		return;
+	seq_printf(s, "0x%lx", config);
+}
+
+static void starfive_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
+					    struct seq_file *s, unsigned int group)
+{
+	struct group_desc *grp;
+	unsigned long config;
+	const char *name;
+	int i, ret;
+
+	if (group >= pctldev->num_groups)
+		return;
+
+	seq_puts(s, "\n");
+	grp = pinctrl_generic_get_group(pctldev, group);
+	if (!grp)
+		return;
+
+	for (i = 0; i < grp->num_pins; i++) {
+		struct starfive_pin *pin = &((struct starfive_pin *)(grp->data))[i];
+
+		name = pin_get_name(pctldev, pin->pin);
+		ret = starfive_pinconf_get(pctldev, pin->pin, &config);
+		if (ret)
+			return;
+		seq_printf(s, "  %s: 0x%lx\n", name, config);
+	}
+}
+
+static const struct pinconf_ops starfive_pinconf_ops = {
+	.pin_config_get = starfive_pinconf_get,
+	.pin_config_set = starfive_pinconf_set,
+	.pin_config_dbg_show = starfive_pinconf_dbg_show,
+	.pin_config_group_dbg_show = starfive_pinconf_group_dbg_show,
+};
+
+static void starfive_disable_clock(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+void pinctrl_write_reg(void __iomem *addr, u32 mask, u32 val)
+{
+	u32 value;
+
+	value = readl_relaxed(addr);
+	value &= ~mask;
+	value |= (val & mask);
+	writel_relaxed(value, addr);
+}
+
+uint32_t pinctrl_get_reg(void __iomem *addr, u32 shift, u32 mask)
+{
+	u32 tmp;
+
+	tmp = readl_relaxed(addr);
+	tmp = (tmp & mask) >> shift;
+	return tmp;
+}
+
+void pinctrl_set_reg(void __iomem *addr, u32 data, u32 shift, u32 mask)
+{
+	u32 tmp;
+
+	tmp = readl_relaxed(addr);
+	tmp &= ~mask;
+	tmp |= (data << shift) & mask;
+	writel_relaxed(tmp, addr);
+}
+
+struct starfive_pinctrl *starfive_from_irq_desc(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+
+	return container_of(gc, struct starfive_pinctrl, gc);
+}
+
+struct starfive_pinctrl *starfive_from_irq_data(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	return container_of(gc, struct starfive_pinctrl, gc);
+}
+
+int starfive_pinctrl_probe(struct platform_device *pdev,
+			   const struct starfive_pinctrl_soc_info *info)
+{
+	struct device *dev = &pdev->dev;
+	struct pinctrl_desc *starfive_pinctrl_desc;
+	struct starfive_pinctrl *pctl;
+	struct resource *res;
+	struct reset_control *rst;
+	struct clk *clk;
+	int ret, i;
+	u32 value;
+
+	if (!info || !info->pins || !info->npins) {
+		dev_err(&pdev->dev, "wrong pinctrl info\n");
+		return -EINVAL;
+	}
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	pctl->pin_regs = devm_kmalloc_array(&pdev->dev, info->npins,
+					    sizeof(*pctl->pin_regs),
+					    GFP_KERNEL);
+	if (!pctl->pin_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < info->npins; i++) {
+		pctl->pin_regs[i].io_conf_reg = -1;
+		pctl->pin_regs[i].gpo_dout_reg = -1;
+		pctl->pin_regs[i].gpo_doen_reg = -1;
+		pctl->pin_regs[i].func_sel_reg = -1;
+		pctl->pin_regs[i].syscon_reg = -1;
+		pctl->pin_regs[i].pad_sel_reg = -1;
+	}
+
+	pctl->padctl_base = devm_platform_ioremap_resource_byname(pdev, "control");
+	if (IS_ERR(pctl->padctl_base))
+		return PTR_ERR(pctl->padctl_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio");
+	if (res) {
+		pctl->gpio_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pctl->gpio_base))
+			return PTR_ERR(pctl->gpio_base);
+	}
+
+	clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "could not get clock\n");
+
+	rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "could not get reset\n");
+
+	if (clk) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return dev_err_probe(dev, ret, "could not enable clock\n");
+
+		ret = devm_add_action_or_reset(dev, starfive_disable_clock, clk);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * We don't want to assert reset and risk undoing pin muxing for the
+	 * early boot serial console, but let's make sure the reset line is
+	 * deasserted in case someone runs a really minimal bootloader.
+	 */
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not deassert reset\n");
+
+	if (info->starfive_iopad_sel_func) {
+		ret = info->starfive_iopad_sel_func(pdev, pctl, value);
+		if (ret)
+			return ret;
+	}
+
+	starfive_pinctrl_desc = devm_kzalloc(&pdev->dev,
+					     sizeof(*starfive_pinctrl_desc),
+					     GFP_KERNEL);
+	if (!starfive_pinctrl_desc)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&pctl->lock);
+
+	starfive_pinctrl_desc->name = dev_name(&pdev->dev);
+	starfive_pinctrl_desc->pins = info->pins;
+	starfive_pinctrl_desc->npins = info->npins;
+	starfive_pinctrl_desc->pctlops = &starfive_pctrl_ops;
+	starfive_pinctrl_desc->pmxops = &starfive_pmx_ops;
+	starfive_pinctrl_desc->confops = &starfive_pinconf_ops;
+	starfive_pinctrl_desc->owner = THIS_MODULE;
+
+	mutex_init(&pctl->mutex);
+
+	pctl->info = info;
+	pctl->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pctl);
+	pctl->gc.parent = dev;
+	ret = devm_pinctrl_register_and_init(&pdev->dev,
+					     starfive_pinctrl_desc, pctl,
+					     &pctl->pctl_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"could not register starfive pinctrl driver\n");
+		return ret;
+	}
+
+	ret = pinctrl_enable(pctl->pctl_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"pin controller failed to start\n");
+		return ret;
+	}
+
+	if (info->starfive_gpio_register) {
+		ret = info->starfive_gpio_register(pdev, pctl);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"starfive_gpio_register failed to register\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(starfive_pinctrl_probe);
+
+static int __maybe_unused starfive_pinctrl_suspend(struct device *dev)
+{
+	struct starfive_pinctrl *pctl = dev_get_drvdata(dev);
+
+	return pinctrl_force_sleep(pctl->pctl_dev);
+}
+
+static int __maybe_unused starfive_pinctrl_resume(struct device *dev)
+{
+	struct starfive_pinctrl *pctl = dev_get_drvdata(dev);
+
+	return pinctrl_force_default(pctl->pctl_dev);
+}
+
+const struct dev_pm_ops starfive_pinctrl_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(starfive_pinctrl_suspend,
+				     starfive_pinctrl_resume)
+};
+EXPORT_SYMBOL_GPL(starfive_pinctrl_pm_ops);
+MODULE_DESCRIPTION("Pinctrl driver for StarFive JH7110 SoC");
+MODULE_AUTHOR("Jenny Zhang <jenny.zhang@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.h b/drivers/pinctrl/starfive/pinctrl-starfive.h
new file mode 100644
index 000000000000..8b956d07baae
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Pinctrl / GPIO driver for StarFive JH7110 SoC
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __DRIVERS_PINCTRL_STARFIVE_H__
+#define __DRIVERS_PINCTRL_STARFIVE_H__
+
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define MAX_GPIO				64
+#define STARFIVE_PINS_SIZE		4
+
+/* 8 bits for each gpio */
+#define GPIO_BYTE_SHIFT			3
+#define GET_GPO_CFG_SHIFT(gpio)		(((gpio) & 0x3) << GPIO_BYTE_SHIFT)
+#define GET_GPO_REG_OFFSET(gpio)	((gpio) & ~0x3)
+
+struct platform_device;
+
+extern const struct pinmux_ops starfive_pmx_ops;
+extern const struct dev_pm_ops starfive_pinctrl_pm_ops;
+
+struct starfive_pin_config {
+	unsigned long io_config;
+	u32 pinmux_func;
+	u32 gpio_num;
+	u32 gpio_dout;
+	u32 gpio_doen;
+	u32 gpio_din_num;
+	s32 *gpio_din_reg;
+	s32 syscon;
+	s32 padmux_func;
+};
+
+struct starfive_pin {
+	unsigned int pin;
+	struct starfive_pin_config pin_config;
+};
+
+struct starfive_pin_reg {
+	s32 io_conf_reg;
+	s32 gpo_dout_reg;
+	s32 gpo_doen_reg;
+	s32 func_sel_reg;
+	s32 func_sel_shift;
+	s32 func_sel_mask;
+	s32 syscon_reg;
+	s32 pad_sel_reg;
+	s32 pad_sel_shift;
+	s32 pad_sel_mask;
+};
+
+struct starfive_iopad_sel_func_inf {
+	unsigned int padctl_gpio_base;
+	unsigned int padctl_gpio0;
+};
+
+struct starfive_pinctrl {
+	struct device *dev;
+	struct pinctrl_dev *pctl_dev;
+	void __iomem *padctl_base;
+	void __iomem *gpio_base;
+	unsigned int padctl_gpio_base;
+	unsigned int padctl_gpio0;
+	const struct starfive_pinctrl_soc_info *info;
+	struct starfive_pin_reg *pin_regs;
+	unsigned int group_index;
+
+	struct mutex mutex;
+	raw_spinlock_t lock;
+
+	struct gpio_chip gc;
+	struct pinctrl_gpio_range gpios;
+	unsigned long enabled;
+	unsigned int trigger[MAX_GPIO];
+};
+
+struct starfive_pinctrl_soc_info {
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	unsigned int flags;
+
+	/*gpio dout/doen/din register*/
+	unsigned int dout_reg_base;
+	unsigned int dout_reg_offset;
+	unsigned int doen_reg_base;
+	unsigned int doen_reg_offset;
+	unsigned int din_reg_base;
+	unsigned int din_reg_offset;
+
+	/* sel-function */
+	int (*starfive_iopad_sel_func)(struct platform_device *pdev,
+				       struct starfive_pinctrl *ipctl,
+				       unsigned int func_id);
+	/* generic pinconf */
+	int (*starfive_pinconf_get)(struct pinctrl_dev *pctldev,
+				    unsigned int pin_id,
+				    unsigned long *config);
+	int (*starfive_pinconf_set)(struct pinctrl_dev *pctldev,
+				    unsigned int pin_id,
+				    unsigned long *configs,
+				    unsigned int num_configs);
+
+	/* generic pinmux */
+	int (*starfive_pmx_set_one_pin_mux)(struct starfive_pinctrl *ipctl,
+					    struct starfive_pin *pin);
+	/* gpio chip */
+	int (*starfive_gpio_register)(struct platform_device *pdev,
+				      struct starfive_pinctrl *ipctl);
+	void (*starfive_pinctrl_parse_pin)(struct starfive_pinctrl *ipctl,
+					   unsigned int *pins_id,
+					   struct starfive_pin *pin_data,
+					   const __be32 *list_p,
+					   struct device_node *np);
+};
+
+#define	STARFIVE_PINCTRL_PIN(pin) PINCTRL_PIN(pin, #pin)
+
+int starfive_pinctrl_probe(struct platform_device *pdev,
+			   const struct starfive_pinctrl_soc_info *info);
+void pinctrl_write_reg(void __iomem *addr, u32 mask, u32 val);
+uint32_t pinctrl_get_reg(void __iomem *addr, u32 shift, u32 mask);
+void pinctrl_set_reg(void __iomem *addr, u32 data, u32 shift, u32 mask);
+struct starfive_pinctrl *starfive_from_irq_desc(struct irq_desc *desc);
+struct starfive_pinctrl *starfive_from_irq_data(struct irq_data *d);
+
+#endif /* __DRIVERS_PINCTRL_STARFIVE_H__ */
-- 
2.17.1

