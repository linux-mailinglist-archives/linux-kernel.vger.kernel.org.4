Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84075FAB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJKEHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJKEHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:07:07 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C083053;
        Mon, 10 Oct 2022 21:06:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 129so11840998pgc.5;
        Mon, 10 Oct 2022 21:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLaAYL/mjW7UgVemWsTT8SDVDlMhRGR19MuPNuFlVWE=;
        b=kM8ZrVBIJXunrIE7TeYmQ3yf3pS9O3UAm0BHPoPb9+UmW/Cn2p7S7ueNa4Mzim5XuN
         s0kmw3VFpCtVHka1mTlSu3x4erFi0J37pISjNQ93zmwkAkMhvbEUBKdn4JPagj/h3Wqo
         F3MS/IE8R+qsusxpJ/Ww1Qw/gqjb9pUlYYREEZIz2vcQliHvvKdL4MipQjVHMeLf/sXb
         QJgbhBk0iXwqOzTVtoLZ/d2RQ/ekn0IwEEXNzKvbq+51utwIDA8ZwnpONWvjARWUpMur
         S67Krl6247n1x9CmpAELaJafEvyQn3G5e1rYnJFEr+12ciAVJEr1ImjC2edfjR+HCQDC
         KHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLaAYL/mjW7UgVemWsTT8SDVDlMhRGR19MuPNuFlVWE=;
        b=lzAu0GTydavK/g43xUSrVehYEws0rtjlRdS6WeR6XRgJnTP9q6JzVXXFMmG/RIt0zE
         IAVDW6tFxRYTM9Slq7dO5jAeBNPIvCMFyBHbNBziZ+RpfdvJgIpwqG+Jx0HJdSATTSYn
         C48Dext3wocliQ64Hf34ab5BhM6gd00LGuWm3vK/SKQ6ipJ0kC4q4C5QRWfaXO3pa5Os
         IeSnZDbeR4Q+CQvFEwexNfJTWCWipmKcD0uIrtWBwzYGYXqKgkGoMLcyWRFaMSmoEHUd
         cdwUTelaF8daMlpuluH3e5Tawa9DDyVOl0psHMwEh8v3x9b9xv0yDOLEdpTEg9aYnZss
         P+dQ==
X-Gm-Message-State: ACrzQf35PEUQa3A7nwAXM8WkrgXGWnwHr9qWZE+Oen/KXBQ3BNTy9Dhk
        x8tSB9dHOJG7/0RurLz2w5A=
X-Google-Smtp-Source: AMsMyM5cjKbCKovmmTk/ojpKYwLbpJrNR8rYRubmr87n4gok6LLA/I9D7C+VECQ++maTTBoMNFY8bg==
X-Received: by 2002:a05:6a00:330a:b0:563:176d:af81 with SMTP id cq10-20020a056a00330a00b00563176daf81mr13611041pfb.13.1665461213927;
        Mon, 10 Oct 2022 21:06:53 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-131-130.emome-ip.hinet.net. [114.137.131.130])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a7ac800b00205d70ccfeesm9755968pjl.33.2022.10.10.21.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 21:06:53 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, matthias.bgg@gmail.com, jic23@kernel.org,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com
Subject: [PATCH v14 3/3] leds: flash: mt6370: Add MediaTek MT6370 flashlight support
Date:   Tue, 11 Oct 2022 12:05:48 +0800
Message-Id: <657f73ae257925ebc68dc825998384ad79d31e1f.1665488982.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665488982.git.chiaen_wu@richtek.com>
References: <cover.1665488982.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
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

From: Alice Chen <alice_chen@richtek.com>

The MediaTek MT6370 is a highly-integrated smart power management IC,
which includes a single cell Li-Ion/Li-Polymer switching battery
charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
LED current sources, a RGB LED driver, a backlight WLED driver,
a display bias driver and a general LDO for portable devices.

Add support for the MT6370 Flash LED driver. Flash LED in MT6370
has 2 channels and support torch/strobe mode.

Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v14
- Remove unused 'depend on OF' in Kconfig
---
 drivers/leds/flash/Kconfig             |  14 +
 drivers/leds/flash/Makefile            |   1 +
 drivers/leds/flash/leds-mt6370-flash.c | 631 +++++++++++++++++++++++++++++++++
 3 files changed, 646 insertions(+)
 create mode 100644 drivers/leds/flash/leds-mt6370-flash.c

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index d3eb689..0dd955c 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -61,6 +61,20 @@ config LEDS_MT6360
 	  Independent current sources supply for each flash LED support torch
 	  and strobe mode.
 
+config LEDS_MT6370_FLASH
+	tristate "Flash LED Support for MediaTek MT6370 PMIC"
+	depends on LEDS_CLASS
+	depends on LEDS_CLASS_FLASH || !LEDS_CLASS_FLASH
+	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
+	depends on MFD_MT6370
+	help
+	  Support 2 channels and torch/strobe mode.
+	  Say Y here to enable support for
+	  MT6370_FLASH_LED device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "leds-mt6370-flash".
+
 config LEDS_RT4505
 	tristate "LED support for RT4505 flashlight controller"
 	depends on I2C && OF
diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
index 0acbddc..0c1f3c5 100644
--- a/drivers/leds/flash/Makefile
+++ b/drivers/leds/flash/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
 obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
 obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
 obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
+obj-$(CONFIG_LEDS_MT6370_FLASH)	+= leds-mt6370-flash.o
diff --git a/drivers/leds/flash/leds-mt6370-flash.c b/drivers/leds/flash/leds-mt6370-flash.c
new file mode 100644
index 0000000..bd4bfb9
--- /dev/null
+++ b/drivers/leds/flash/leds-mt6370-flash.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: Alice Chen <alice_chen@richtek.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/led-class-flash.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include <media/v4l2-flash-led-class.h>
+
+enum {
+	MT6370_LED_FLASH1,
+	MT6370_LED_FLASH2,
+	MT6370_MAX_LEDS
+};
+
+/* Virtual definition for multicolor */
+
+#define MT6370_REG_FLEDEN		0x17E
+#define MT6370_REG_STRBTO		0x173
+#define MT6370_REG_CHGSTAT2		0x1D1
+#define MT6370_REG_FLEDSTAT1		0x1D9
+#define MT6370_REG_FLEDISTRB(_id)	(0x174 + 4 * (_id))
+#define MT6370_REG_FLEDITOR(_id)	(0x175 + 4 * (_id))
+#define MT6370_ITORCH_MASK		GENMASK(4, 0)
+#define MT6370_ISTROBE_MASK		GENMASK(6, 0)
+#define MT6370_STRBTO_MASK		GENMASK(6, 0)
+#define MT6370_TORCHEN_MASK		BIT(3)
+#define MT6370_STROBEN_MASK		BIT(2)
+#define MT6370_FLCSEN_MASK(_id)		BIT(MT6370_LED_FLASH2 - (_id))
+#define MT6370_FLCSEN_MASK_ALL		GENMASK(1, 0)
+#define MT6370_FLEDCHGVINOVP_MASK	BIT(3)
+#define MT6370_FLED1STRBTO_MASK		BIT(11)
+#define MT6370_FLED2STRBTO_MASK		BIT(10)
+#define MT6370_FLED1STRB_MASK		BIT(9)
+#define MT6370_FLED2STRB_MASK		BIT(8)
+#define MT6370_FLED1SHORT_MASK		BIT(7)
+#define MT6370_FLED2SHORT_MASK		BIT(6)
+#define MT6370_FLEDLVF_MASK		BIT(3)
+
+#define MT6370_LED_JOINT		2
+#define MT6370_RANGE_FLED_REG		4
+#define MT6370_ITORCH_MIN_uA		25000
+#define MT6370_ITORCH_STEP_uA		12500
+#define MT6370_ITORCH_MAX_uA		400000
+#define MT6370_ITORCH_DOUBLE_MAX_uA	800000
+#define MT6370_ISTRB_MIN_uA		50000
+#define MT6370_ISTRB_STEP_uA		12500
+#define MT6370_ISTRB_MAX_uA		1500000
+#define MT6370_ISTRB_DOUBLE_MAX_uA	3000000
+#define MT6370_STRBTO_MIN_US		64000
+#define MT6370_STRBTO_STEP_US		32000
+#define MT6370_STRBTO_MAX_US		2432000
+
+#define STATE_OFF			0
+#define STATE_KEEP			1
+#define STATE_ON			2
+
+#define to_mt6370_led(ptr, member) container_of(ptr, struct mt6370_led, member)
+
+struct mt6370_led {
+	struct led_classdev_flash flash;
+	struct v4l2_flash *v4l2_flash;
+	struct mt6370_priv *priv;
+	enum led_default_state default_state;
+	u8 led_no;
+};
+
+struct mt6370_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex lock;
+	unsigned int fled_strobe_used;
+	unsigned int fled_torch_used;
+	unsigned int leds_active;
+	unsigned int leds_count;
+	struct mt6370_led leds[];
+};
+
+static int mt6370_torch_brightness_set(struct led_classdev *lcdev,
+				       enum led_brightness level)
+{
+	struct mt6370_led *led = to_mt6370_led(lcdev, flash.led_cdev);
+	struct mt6370_priv *priv = led->priv;
+	u32 led_enable_mask = (led->led_no == MT6370_LED_JOINT) ?
+			      MT6370_FLCSEN_MASK_ALL :
+			      MT6370_FLCSEN_MASK(led->led_no);
+	u32 enable_mask = MT6370_TORCHEN_MASK | led_enable_mask;
+	u32 val = level ? led_enable_mask : 0;
+	u32 curr;
+	int ret, i;
+
+	mutex_lock(&priv->lock);
+
+	/*
+	 * There is only one set of flash control logic, and this
+	 * flag is used to check if 'strobe' is currently being used.
+	 */
+	if (priv->fled_strobe_used) {
+		dev_warn(lcdev->dev, "Please disable strobe first [%d]\n",
+			 priv->fled_strobe_used);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (level)
+		curr = priv->fled_torch_used | BIT(led->led_no);
+	else
+		curr = priv->fled_torch_used & ~BIT(led->led_no);
+
+	if (curr)
+		val |= MT6370_TORCHEN_MASK;
+
+	if (level) {
+		level -= 1;
+		if (led->led_no == MT6370_LED_JOINT) {
+			u32 flevel[MT6370_MAX_LEDS];
+
+			flevel[0] = level / 2;
+			flevel[1] = level - flevel[0];
+			for (i = 0; i < MT6370_MAX_LEDS; i++) {
+				ret = regmap_update_bits(priv->regmap,
+						MT6370_REG_FLEDITOR(i),
+						MT6370_ITORCH_MASK, flevel[i]);
+				if (ret)
+					goto unlock;
+			}
+		} else {
+			ret = regmap_update_bits(priv->regmap,
+					MT6370_REG_FLEDITOR(led->led_no),
+					MT6370_ITORCH_MASK, level);
+			if (ret)
+				goto unlock;
+		}
+	}
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_FLEDEN,
+				 enable_mask, val);
+	if (ret)
+		goto unlock;
+
+	priv->fled_torch_used = curr;
+
+unlock:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int mt6370_flash_brightness_set(struct led_classdev_flash *fl_cdev,
+				       u32 brightness)
+{
+	/*
+	 * Because of the current spikes when turning on the flash,
+	 * the brightness should be kept by the LED framework. This
+	 * empty function is used to prevent checking failure when
+	 * led_classdev_flash registers ops.
+	 */
+	return 0;
+}
+
+static int _mt6370_flash_brightness_set(struct led_classdev_flash *fl_cdev,
+					u32 brightness)
+{
+	struct mt6370_led *led = to_mt6370_led(fl_cdev, flash);
+	struct mt6370_priv *priv = led->priv;
+	struct led_flash_setting *setting = &fl_cdev->brightness;
+	u32 val = (brightness - setting->min) / setting->step;
+	int ret, i;
+
+	if (led->led_no == MT6370_LED_JOINT) {
+		u32 flevel[MT6370_MAX_LEDS];
+
+		flevel[0] = val / 2;
+		flevel[1] = val - flevel[0];
+		for (i = 0; i < MT6370_MAX_LEDS; i++) {
+			ret = regmap_update_bits(priv->regmap,
+						 MT6370_REG_FLEDISTRB(i),
+						 MT6370_ISTROBE_MASK, flevel[i]);
+			if (ret)
+				break;
+		}
+
+		return ret;
+	} else {
+		return regmap_update_bits(priv->regmap,
+					  MT6370_REG_FLEDISTRB(led->led_no),
+					  MT6370_ISTROBE_MASK, val);
+	}
+}
+
+static int mt6370_strobe_set(struct led_classdev_flash *fl_cdev, bool state)
+{
+	struct mt6370_led *led = to_mt6370_led(fl_cdev, flash);
+	struct mt6370_priv *priv = led->priv;
+	struct led_classdev *lcdev = &fl_cdev->led_cdev;
+	struct led_flash_setting *setting = &fl_cdev->brightness;
+	u32 led_enable_mask = (led->led_no == MT6370_LED_JOINT) ?
+			      MT6370_FLCSEN_MASK_ALL :
+			      MT6370_FLCSEN_MASK(led->led_no);
+	u32 enable_mask = MT6370_STROBEN_MASK | led_enable_mask;
+	u32 val = state ? led_enable_mask : 0;
+	u32 curr;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	/*
+	 * There is only one set of flash control logic, and this
+	 * flag is used to check if 'torch' is currently being used.
+	 */
+	if (priv->fled_torch_used) {
+		dev_warn(lcdev->dev, "Please disable torch first [0x%x]\n",
+				      priv->fled_torch_used);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (state)
+		curr = priv->fled_strobe_used | BIT(led->led_no);
+	else
+		curr = priv->fled_strobe_used & ~BIT(led->led_no);
+
+	if (curr)
+		val |= MT6370_STROBEN_MASK;
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_FLEDEN, enable_mask,
+				 val);
+	if (ret) {
+		dev_err(lcdev->dev, "[%d] control current source %d fail\n",
+				     led->led_no, state);
+		goto unlock;
+	}
+
+	/*
+	 * If the flash needs to turn on, configure the flash current to
+	 * ramp up to the setting value. Otherwise, always revert to the
+	 * minimum one.
+	 */
+	ret = _mt6370_flash_brightness_set(fl_cdev, state ? setting->val : setting->min);
+	if (ret) {
+		dev_err(lcdev->dev, "[%d] Failed to set brightness\n", led->led_no);
+		goto out_revert_state;
+	}
+
+	/*
+	 * For the flash to turn on/off, we must wait for HW ramping
+	 * up/down time 5ms/500us to prevent the unexpected problem.
+	 */
+	if (!priv->fled_strobe_used && curr)
+		usleep_range(5000, 6000);
+	else if (priv->fled_strobe_used && !curr)
+		usleep_range(500, 600);
+
+	priv->fled_strobe_used = curr;
+
+out_revert_state:
+	if (state)
+		curr = priv->fled_strobe_used & ~BIT(led->led_no);
+	else
+		curr = priv->fled_strobe_used | BIT(led->led_no);
+
+	if (curr)
+		val |= MT6370_STROBEN_MASK;
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_FLEDEN, enable_mask,
+				 val);
+	if (ret)
+		dev_err(lcdev->dev, "[%d] revert current source fail\n", led->led_no);
+unlock:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int mt6370_strobe_get(struct led_classdev_flash *fl_cdev, bool *state)
+{
+	struct mt6370_led *led = to_mt6370_led(fl_cdev, flash);
+	struct mt6370_priv *priv = led->priv;
+
+	mutex_lock(&priv->lock);
+	*state = !!(priv->fled_strobe_used & BIT(led->led_no));
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int mt6370_timeout_set(struct led_classdev_flash *fl_cdev, u32 timeout)
+{
+	struct mt6370_led *led = to_mt6370_led(fl_cdev, flash);
+	struct mt6370_priv *priv = led->priv;
+	struct led_flash_setting *setting = &fl_cdev->timeout;
+	u32 val = (timeout - setting->min) / setting->step;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_STRBTO,
+				 MT6370_STRBTO_MASK, val);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int mt6370_fault_get(struct led_classdev_flash *fl_cdev, u32 *fault)
+{
+	struct mt6370_led *led = to_mt6370_led(fl_cdev, flash);
+	struct mt6370_priv *priv = led->priv;
+	u16 fled_stat;
+	unsigned int chg_stat, strobe_timeout_mask, fled_short_mask;
+	u32 rfault = 0;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = regmap_read(priv->regmap, MT6370_REG_CHGSTAT2, &chg_stat);
+	if (ret)
+		goto unlock;
+
+	ret = regmap_raw_read(priv->regmap, MT6370_REG_FLEDSTAT1, &fled_stat,
+			      sizeof(fled_stat));
+	if (ret)
+		goto unlock;
+
+	switch (led->led_no) {
+	case MT6370_LED_FLASH1:
+		strobe_timeout_mask = MT6370_FLED1STRBTO_MASK;
+		fled_short_mask = MT6370_FLED1SHORT_MASK;
+		break;
+
+	case MT6370_LED_FLASH2:
+		strobe_timeout_mask = MT6370_FLED2STRBTO_MASK;
+		fled_short_mask = MT6370_FLED2SHORT_MASK;
+		break;
+
+	case MT6370_LED_JOINT:
+		strobe_timeout_mask = MT6370_FLED1STRBTO_MASK |
+				      MT6370_FLED2STRBTO_MASK;
+		fled_short_mask = MT6370_FLED1SHORT_MASK |
+				  MT6370_FLED2SHORT_MASK;
+	}
+
+	if (chg_stat & MT6370_FLEDCHGVINOVP_MASK)
+		rfault |= LED_FAULT_INPUT_VOLTAGE;
+
+	if (fled_stat & strobe_timeout_mask)
+		rfault |= LED_FAULT_TIMEOUT;
+
+	if (fled_stat & fled_short_mask)
+		rfault |= LED_FAULT_SHORT_CIRCUIT;
+
+	if (fled_stat & MT6370_FLEDLVF_MASK)
+		rfault |= LED_FAULT_UNDER_VOLTAGE;
+
+	*fault = rfault;
+unlock:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static const struct led_flash_ops mt6370_flash_ops = {
+	.flash_brightness_set = mt6370_flash_brightness_set,
+	.strobe_set = mt6370_strobe_set,
+	.strobe_get = mt6370_strobe_get,
+	.timeout_set = mt6370_timeout_set,
+	.fault_get = mt6370_fault_get,
+};
+
+#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
+static int mt6370_flash_external_strobe_set(struct v4l2_flash *v4l2_flash,
+					    bool enable)
+{
+	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
+	struct mt6370_led *led = to_mt6370_led(flash, flash);
+	struct mt6370_priv *priv = led->priv;
+	u32 mask = (led->led_no == MT6370_LED_JOINT) ? MT6370_FLCSEN_MASK_ALL :
+		   MT6370_FLCSEN_MASK(led->led_no);
+	u32 val = enable ? mask : 0;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_FLEDEN, mask, val);
+	if (ret)
+		goto unlock;
+
+	if (enable)
+		priv->fled_strobe_used |= BIT(led->led_no);
+	else
+		priv->fled_strobe_used &= ~BIT(led->led_no);
+
+unlock:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static const struct v4l2_flash_ops v4l2_flash_ops = {
+	.external_strobe_set = mt6370_flash_external_strobe_set,
+};
+
+static void mt6370_init_v4l2_flash_config(struct mt6370_led *led,
+					  struct v4l2_flash_config *config)
+{
+	struct led_classdev *lcdev;
+	struct led_flash_setting *setting = &config->intensity;
+
+	lcdev = &led->flash.led_cdev;
+
+	setting->min = MT6370_ITORCH_MIN_uA;
+	setting->step = MT6370_ITORCH_STEP_uA;
+	setting->max = setting->min + (lcdev->max_brightness - 1) * setting->step;
+	setting->val = setting->max;
+
+	config->has_external_strobe = 1;
+	strscpy(config->dev_name, lcdev->dev->kobj.name,
+		sizeof(config->dev_name));
+
+	config->flash_faults = LED_FAULT_SHORT_CIRCUIT | LED_FAULT_TIMEOUT |
+			       LED_FAULT_INPUT_VOLTAGE |
+			       LED_FAULT_UNDER_VOLTAGE;
+}
+#else
+static const struct v4l2_flash_ops v4l2_flash_ops;
+static void mt6370_init_v4l2_flash_config(struct mt6370_led *led,
+					  struct v4l2_flash_config *config)
+{
+}
+#endif
+
+static void mt6370_v4l2_flash_release(void *v4l2_flash)
+{
+	v4l2_flash_release(v4l2_flash);
+}
+
+static int mt6370_led_register(struct device *parent, struct mt6370_led *led,
+				struct led_init_data *init_data)
+{
+	struct v4l2_flash_config v4l2_config = {};
+	int ret;
+
+	ret = devm_led_classdev_flash_register_ext(parent, &led->flash,
+						   init_data);
+	if (ret)
+		return dev_err_probe(parent, ret,
+				     "Couldn't register flash %d\n", led->led_no);
+
+	mt6370_init_v4l2_flash_config(led, &v4l2_config);
+	led->v4l2_flash = v4l2_flash_init(parent, init_data->fwnode,
+					  &led->flash, &v4l2_flash_ops,
+					  &v4l2_config);
+	if (IS_ERR(led->v4l2_flash))
+		return dev_err_probe(parent, PTR_ERR(led->v4l2_flash),
+				     "Failed to register %d v4l2 sd\n", led->led_no);
+
+	return devm_add_action_or_reset(parent, mt6370_v4l2_flash_release,
+					led->v4l2_flash);
+}
+
+static u32 mt6370_clamp(u32 val, u32 min, u32 max, u32 step)
+{
+	u32 retval;
+
+	retval = clamp_val(val, min, max);
+	if (step > 1)
+		retval = rounddown(retval - min, step) + min;
+
+	return retval;
+}
+
+static int mt6370_init_flash_properties(struct mt6370_led *led,
+					struct led_init_data *init_data)
+{
+	struct led_classdev_flash *flash = &led->flash;
+	struct led_classdev *lcdev = &flash->led_cdev;
+	struct mt6370_priv *priv = led->priv;
+	struct led_flash_setting *setting;
+	u32 sources[MT6370_MAX_LEDS];
+	u32 max_ua, val;
+	int i, ret, num;
+
+	num = fwnode_property_count_u32(init_data->fwnode, "led-sources");
+	if (num < 1 || num > MT6370_MAX_LEDS)
+		return dev_err_probe(priv->dev, -EINVAL,
+				     "Not specified or wrong number of led-sources\n");
+
+	ret = fwnode_property_read_u32_array(init_data->fwnode, "led-sources", sources, num);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num; i++) {
+		if (sources[i] >= MT6370_MAX_LEDS)
+			return -EINVAL;
+		if (priv->leds_active & BIT(sources[i]))
+			return -EINVAL;
+		priv->leds_active |= BIT(sources[i]);
+
+	}
+	led->led_no = (num == MT6370_MAX_LEDS) ? MT6370_LED_JOINT :
+		       sources[0];
+
+	max_ua = (num == 2) ? MT6370_ITORCH_DOUBLE_MAX_uA : MT6370_ITORCH_MAX_uA;
+	ret = fwnode_property_read_u32(init_data->fwnode, "led-max-microamp", &val);
+	if (ret) {
+		dev_info(priv->dev,
+			 "Not specified led-max-microamp, config to the minimum\n");
+		val = MT6370_ITORCH_MIN_uA;
+	} else {
+		val = mt6370_clamp(val, MT6370_ITORCH_MIN_uA, max_ua,
+				  MT6370_ITORCH_STEP_uA);
+	}
+
+	lcdev->max_brightness = (val - MT6370_ITORCH_MIN_uA) /
+				MT6370_ITORCH_STEP_uA + 1;
+	lcdev->brightness_set_blocking = mt6370_torch_brightness_set;
+	lcdev->flags |= LED_DEV_CAP_FLASH;
+
+	max_ua = (num == 2) ? MT6370_ISTRB_DOUBLE_MAX_uA : MT6370_ISTRB_MAX_uA;
+	ret = fwnode_property_read_u32(init_data->fwnode, "flash-max-microamp", &val);
+	if (ret) {
+		dev_info(priv->dev,
+		   "Not specified flash-max-microamp, config to the minimum\n");
+		val = MT6370_ISTRB_MIN_uA;
+	} else {
+		val = mt6370_clamp(val, MT6370_ISTRB_MIN_uA, max_ua,
+				  MT6370_ISTRB_STEP_uA);
+	}
+
+	setting = &flash->brightness;
+	setting->min = MT6370_ISTRB_MIN_uA;
+	setting->step = MT6370_ISTRB_STEP_uA;
+	setting->val = setting->max = val;
+
+	/*
+	 * Always configure to the minimum level when
+	 * off to prevent flash current spikes.
+	 */
+	ret = _mt6370_flash_brightness_set(flash, setting->min);
+	if (ret)
+		return ret;
+
+	ret = fwnode_property_read_u32(init_data->fwnode,
+				       "flash-max-timeout-us", &val);
+	if (ret) {
+		dev_info(priv->dev,
+			 "Not specified flash-max-timeout-us, config to the minimum\n");
+		val = MT6370_STRBTO_MIN_US;
+	} else {
+		val = mt6370_clamp(val, MT6370_STRBTO_MIN_US,
+				   MT6370_STRBTO_MAX_US, MT6370_STRBTO_STEP_US);
+	}
+
+	setting = &flash->timeout;
+	setting->min = MT6370_STRBTO_MIN_US;
+	setting->step = MT6370_STRBTO_STEP_US;
+	setting->val = setting->max = val;
+
+	flash->ops = &mt6370_flash_ops;
+
+	return 0;
+}
+
+static int mt6370_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mt6370_priv *priv;
+	struct fwnode_handle *child;
+	size_t count;
+	int i = 0, ret;
+
+	count = device_get_child_node_count(dev);
+	if (!count || count > MT6370_MAX_LEDS)
+		return dev_err_probe(dev, -EINVAL,
+		       "No child node or node count over max led number %zu\n", count);
+
+	priv = devm_kzalloc(dev, struct_size(priv, leds, count), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->leds_count = count;
+	priv->dev = dev;
+	mutex_init(&priv->lock);
+
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to get parent regmap\n");
+
+	device_for_each_child_node(dev, child) {
+		struct mt6370_led *led = priv->leds + i;
+		struct led_init_data init_data = { .fwnode = child, };
+
+		led->priv = priv;
+		led->default_state = led_init_default_state_get(init_data.fwnode);
+
+		ret = mt6370_init_flash_properties(led, &init_data);
+		if (ret)
+			return ret;
+
+		ret = mt6370_led_register(dev, led, &init_data);
+		if (ret)
+			return ret;
+
+		i++;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mt6370_led_of_id[] = {
+	{ .compatible = "mediatek,mt6370-flashlight" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6370_led_of_id);
+
+static struct platform_driver mt6370_led_driver = {
+	.driver = {
+		.name = "mt6370-flashlight",
+		.of_match_table = mt6370_led_of_id,
+	},
+	.probe = mt6370_led_probe,
+};
+module_platform_driver(mt6370_led_driver);
+
+MODULE_AUTHOR("Alice Chen <alice_chen@richtek.com>");
+MODULE_DESCRIPTION("MT6370 FLASH LED Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

