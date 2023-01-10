Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D40663CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbjAJJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjAJJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:24:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D626CD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:24:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso9312375wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dh0bQBvL1MAQ79eqgTbgReBtIQtpA+XQbsleX01n6Q=;
        b=OYRLNBuMGyBJ1A3K7H9KUEr8xAGnzk1e4IUwZTWWAvxYhrvkniINIi83jyqFxY+yfj
         wdCs/lCSWTL1kTtYDlCgy3CcugbQuztkSPMVN5a56RPhvwOOuRGO+5bG4noqypRQDfd7
         k8X64xyiMmipBva84Xm/qZxbPIa8qbcqTQb4mexEbdpXYDneJv7ivfUh037XcK1XYVQT
         L4w2W2bywLJoiTCEzdJODxL56dtMncw9bV7AXmlS5pPZH49Ty16Y00cUIGk2Ckcd9pPM
         aYu7qdz0YKMb0NnHD0Ecetw2DDQU0ic0QjN0t4kBhcZQAYJU7SaPk8qpJnA4CYC4yzPW
         fgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dh0bQBvL1MAQ79eqgTbgReBtIQtpA+XQbsleX01n6Q=;
        b=GijJt+XEZQfN1pKW6RzMGDoKSh7/jwbHxhwuCLGKeWsS9K9vLJ7HtQFmAKulth0YY7
         Cyrm92L4pvVICISe76/pSQnY+Kx715MZhR846GfCwIez2LxkxUy/xEzjWHz0NlLLxaF9
         KIYIOm55t82/L3faI1AS9sSYb29gbZzEdcg9enLjsYf504RuRqYtiZrnj8q7HQuPn5Nr
         hZL/vNHtD1zQgZYveeRSblQ7/jTXyPfIBx1mzpVvIPkXMO7/3Zc3qra3ZQN+jjUpAUwv
         xj97IVfqOkUpMZz3g9QHVkyzTBTNOyuBpYLS/1kuPOh/1A9to0VqwF5A280RCQu6Oyw4
         o0iQ==
X-Gm-Message-State: AFqh2kp5o26LXRWenr2P3+YfW8WTdkzyy4H2ZIZo6D1Qb23BFhE6fNQh
        7R7Unz0SnjsZLc6VbanXywhP1g==
X-Google-Smtp-Source: AMrXdXvVoqwbfGrAsP31naQgCw5Qa0w/8stg6QtFGNNAJFN2gwLKUBpHMpY7azUp5IPwZq4Hs2byjA==
X-Received: by 2002:a05:600c:4da0:b0:3d3:5027:4cce with SMTP id v32-20020a05600c4da000b003d350274ccemr50798040wmp.10.1673342692099;
        Tue, 10 Jan 2023 01:24:52 -0800 (PST)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id q22-20020a05600c331600b003d9dd62deedsm13149433wmp.30.2023.01.10.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:24:51 -0800 (PST)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org,
        Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] leds: lp55xx: configure internal charge pump
Date:   Tue, 10 Jan 2023 10:23:40 +0100
Message-Id: <20230110092342.24132-3-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230110092342.24132-1-maarten.zanders@mind.be>
References: <20230110092342.24132-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LP55xx range of devices have an internal charge pump which
can (automatically) increase the output voltage towards the
LED's, boosting the output voltage to 4.5V.

Implement this option from the devicetree. When the setting
is not present it will operate in automatic mode as before.

Tested on LP55231. Datasheet analysis shows that LP5521, LP5523
and LP8501 are identical in topology and are modified in the
same way.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 drivers/leds/leds-lp5521.c                | 12 ++++++------
 drivers/leds/leds-lp5523.c                | 18 +++++++++++++-----
 drivers/leds/leds-lp55xx-common.c         | 22 ++++++++++++++++++++++
 drivers/leds/leds-lp8501.c                |  8 ++++++--
 include/linux/platform_data/leds-lp55xx.h |  9 +++++++++
 5 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 19478d9c19a7..ee1c72cffdab 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -58,14 +58,11 @@
 /* CONFIG register */
 #define LP5521_PWM_HF			0x40	/* PWM: 0 = 256Hz, 1 = 558Hz */
 #define LP5521_PWRSAVE_EN		0x20	/* 1 = Power save mode */
-#define LP5521_CP_MODE_OFF		0	/* Charge pump (CP) off */
-#define LP5521_CP_MODE_BYPASS		8	/* CP forced to bypass mode */
-#define LP5521_CP_MODE_1X5		0x10	/* CP forced to 1.5x mode */
-#define LP5521_CP_MODE_AUTO		0x18	/* Automatic mode selection */
+#define LP5521_CP_MODE_MASK		0x18	/* Charge pump mode */
+#define LP5521_CP_MODE_SHIFT		3
 #define LP5521_R_TO_BATT		0x04	/* R out: 0 = CP, 1 = Vbat */
 #define LP5521_CLK_INT			0x01	/* Internal clock */
-#define LP5521_DEFAULT_CFG		\
-	(LP5521_PWM_HF | LP5521_PWRSAVE_EN | LP5521_CP_MODE_AUTO)
+#define LP5521_DEFAULT_CFG		(LP5521_PWM_HF | LP5521_PWRSAVE_EN)
 
 /* Status */
 #define LP5521_EXT_CLK_USED		0x08
@@ -310,6 +307,9 @@ static int lp5521_post_init_device(struct lp55xx_chip *chip)
 	if (!lp55xx_is_extclk_used(chip))
 		val |= LP5521_CLK_INT;
 
+	val |= (chip->pdata->charge_pump_mode << LP5521_CP_MODE_SHIFT) &
+	       LP5521_CP_MODE_MASK;
+
 	ret = lp55xx_write(chip, LP5521_REG_CONFIG, val);
 	if (ret)
 		return ret;
diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index e08e3de1428d..b5d10d4252e6 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -57,8 +57,12 @@
 #define LP5523_AUTO_INC			0x40
 #define LP5523_PWR_SAVE			0x20
 #define LP5523_PWM_PWR_SAVE		0x04
-#define LP5523_CP_AUTO			0x18
+#define LP5523_CP_MODE_MASK		0x18
+#define LP5523_CP_MODE_SHIFT		3
 #define LP5523_AUTO_CLK			0x02
+#define LP5523_DEFAULT_CONFIG	\
+	(LP5523_AUTO_INC | LP5523_PWR_SAVE |\
+	 LP5523_AUTO_CLK | LP5523_PWM_PWR_SAVE)
 
 #define LP5523_EN_LEDTEST		0x80
 #define LP5523_LEDTEST_DONE		0x80
@@ -125,6 +129,7 @@ static void lp5523_set_led_current(struct lp55xx_led *led, u8 led_current)
 static int lp5523_post_init_device(struct lp55xx_chip *chip)
 {
 	int ret;
+	int val;
 
 	ret = lp55xx_write(chip, LP5523_REG_ENABLE, LP5523_ENABLE);
 	if (ret)
@@ -133,10 +138,13 @@ static int lp5523_post_init_device(struct lp55xx_chip *chip)
 	/* Chip startup time is 500 us, 1 - 2 ms gives some margin */
 	usleep_range(1000, 2000);
 
-	ret = lp55xx_write(chip, LP5523_REG_CONFIG,
-			    LP5523_AUTO_INC | LP5523_PWR_SAVE |
-			    LP5523_CP_AUTO | LP5523_AUTO_CLK |
-			    LP5523_PWM_PWR_SAVE);
+	val = LP5523_DEFAULT_CONFIG;
+
+	val |= (chip->pdata->charge_pump_mode << LP5523_CP_MODE_SHIFT) &
+	       LP5523_CP_MODE_MASK;
+
+	ret = lp55xx_write(chip, LP5523_REG_CONFIG, val);
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index c1940964067a..a690a484fd7b 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -653,6 +653,13 @@ static int lp55xx_parse_logical_led(struct device_node *np,
 	return ret;
 }
 
+static const char * const charge_pump_modes[] = {
+	[LP55XX_CP_OFF] = "off",
+	[LP55XX_CP_BYPASS] = "bypass",
+	[LP55XX_CP_BOOST] = "boost",
+	[LP55XX_CP_AUTO] = "auto",
+};
+
 struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
 						      struct device_node *np,
 						      struct lp55xx_chip *chip)
@@ -661,6 +668,8 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
 	struct lp55xx_platform_data *pdata;
 	struct lp55xx_led_config *cfg;
 	int num_channels;
+	enum lp55xx_charge_pump_mode cp_mode;
+	const char *pm;
 	int i = 0;
 	int ret;
 
@@ -691,6 +700,19 @@ struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
 		i++;
 	}
 
+	pdata->charge_pump_mode = LP55XX_CP_AUTO;
+	ret = of_property_read_string(np, "ti,charge-pump-mode", &pm);
+	if (!ret) {
+		for (cp_mode = LP55XX_CP_OFF;
+		     cp_mode < ARRAY_SIZE(charge_pump_modes);
+		     cp_mode++) {
+			if (!strcasecmp(pm, charge_pump_modes[cp_mode])) {
+				pdata->charge_pump_mode = cp_mode;
+				break;
+			}
+		}
+	}
+
 	of_property_read_string(np, "label", &pdata->label);
 	of_property_read_u8(np, "clock-mode", &pdata->clock_mode);
 
diff --git a/drivers/leds/leds-lp8501.c b/drivers/leds/leds-lp8501.c
index ae11a02c0ab2..f0e70e116919 100644
--- a/drivers/leds/leds-lp8501.c
+++ b/drivers/leds/leds-lp8501.c
@@ -53,10 +53,11 @@
 #define LP8501_PWM_PSAVE		BIT(7)
 #define LP8501_AUTO_INC			BIT(6)
 #define LP8501_PWR_SAVE			BIT(5)
-#define LP8501_CP_AUTO			0x18
+#define LP8501_CP_MODE_MASK		0x18
+#define LP8501_CP_MODE_SHIFT		3
 #define LP8501_INT_CLK			BIT(0)
 #define LP8501_DEFAULT_CFG	\
-	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE | LP8501_CP_AUTO)
+	(LP8501_PWM_PSAVE | LP8501_AUTO_INC | LP8501_PWR_SAVE)
 
 #define LP8501_REG_RESET		0x3D
 #define LP8501_RESET			0xFF
@@ -102,6 +103,9 @@ static int lp8501_post_init_device(struct lp55xx_chip *chip)
 	if (chip->pdata->clock_mode != LP55XX_CLOCK_EXT)
 		val |= LP8501_INT_CLK;
 
+	val |= (chip->pdata->charge_pump_mode << LP8501_CP_MODE_SHIFT) &
+	       LP8501_CP_MODE_MASK;
+
 	ret = lp55xx_write(chip, LP8501_REG_CONFIG, val);
 	if (ret)
 		return ret;
diff --git a/include/linux/platform_data/leds-lp55xx.h b/include/linux/platform_data/leds-lp55xx.h
index 3441064713a3..6ea1a74f94e4 100644
--- a/include/linux/platform_data/leds-lp55xx.h
+++ b/include/linux/platform_data/leds-lp55xx.h
@@ -50,6 +50,13 @@ enum lp8501_pwr_sel {
 	LP8501_ALL_VOUT,	/* D1~9 are connected to VOUT */
 };
 
+enum lp55xx_charge_pump_mode {
+	LP55XX_CP_OFF = 0,
+	LP55XX_CP_BYPASS = 1,
+	LP55XX_CP_BOOST = 2,
+	LP55XX_CP_AUTO = 3,
+};
+
 /*
  * struct lp55xx_platform_data
  * @led_config        : Configurable led class device
@@ -73,6 +80,8 @@ struct lp55xx_platform_data {
 	/* Clock configuration */
 	u8 clock_mode;
 
+	enum lp55xx_charge_pump_mode charge_pump_mode;
+
 	/* optional enable GPIO */
 	struct gpio_desc *enable_gpiod;
 
-- 
2.37.3

