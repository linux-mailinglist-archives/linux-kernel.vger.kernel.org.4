Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8A6A8DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCCAaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCCAaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7359E71;
        Thu,  2 Mar 2023 16:30:03 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h9so776471ljq.2;
        Thu, 02 Mar 2023 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDJeWiKsHoEvat6KQzjaepU8kGEjsYs/weaALQ++4bc=;
        b=HlkyTHYBIHQtCzV1WFgPs40r1GDZLqm5VJdS6mvLp2QTu2FQLI00kiK+Vx/NWoQE8y
         y5uktdRPkeC7NXiRisrKByH7PWh2JAhrMEhKZhbKplGrEbUUbBuoEbFFyWqaqukG2jGg
         sfj0wfEy6wsSfInP1Ff7w+lUezQD0MHU2U+z+MqCHJqMwyxp3XLAWOmRbQ65ejPiNTgF
         x4A7wBoiiE3bD/mB3JNKf25gNWR2qUiH8Yz3wE+KOMFvZfuxEYxsBFbRftWX1P4r5Wn7
         HmjGCdUxlHwJa2KAAdSjNbiu6ySQ0wu39qiFZz0isxAnuvMQSWVem81yjZRUwOqeUhSe
         /JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDJeWiKsHoEvat6KQzjaepU8kGEjsYs/weaALQ++4bc=;
        b=Lu8ka976sKzEoufU7T2mLutvEt3hRTH3oJrrhsETfnRsg9a9c+Ws88/0vh/bvWHZIg
         ByiYH1SerVoEGUfvWds1tUwhcad0kEuObSUGjhZAB1FWGyOwGuSiSfjYv9mcNhBRkFr3
         p/eHNPq5CzGPZLBH0lWzwyTOyJVjd7bK4Y4+9PBgoI3W7yeuyxKtotGU+13NGpIwXajw
         hwJT8Jnyb/rFKvfy+9q7aWO2f6AVJV+l3R3Rc2wRsNx5WK0FzseZwArHp5cXYmx6zToN
         gweYSGpA8csg15cRp7Oiy4rXWTS4AXZlsFj4Tmkfm2K+ogiaor66eUTur4TletajHy9Y
         WDMw==
X-Gm-Message-State: AO0yUKVwYvZA0g2u/n18krvThJwJFfULQIOjugtCcryasJhSumt/kmnB
        Curdvgv4ph1zqxUVeci7vYM=
X-Google-Smtp-Source: AK7set+Go7ZElIa15sp9a5lXGAoLj0SsYIS2qzTwWK0JmNGkA8iie53tcOjLgJSYXhU0zB+z4J/yCg==
X-Received: by 2002:a2e:9d06:0:b0:295:a295:6e00 with SMTP id t6-20020a2e9d06000000b00295a2956e00mr3570564lji.40.1677803400893;
        Thu, 02 Mar 2023 16:30:00 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:00 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 04/20] pinctrl: ralink: mt7620: split out to mt76x8
Date:   Fri,  3 Mar 2023 03:28:33 +0300
Message-Id: <20230303002850.51858-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Split the driver out to pinctrl-mt76x8.c. Remove including the unnecessary
headers since is_mt76x8() is not being used anymore.

Introduce a new compatible string to be able to document the pin muxing
information properly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/Kconfig          |   5 +
 drivers/pinctrl/ralink/Makefile         |   1 +
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 257 +--------------------
 drivers/pinctrl/ralink/pinctrl-mt76x8.c | 283 ++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 256 deletions(-)
 create mode 100644 drivers/pinctrl/ralink/pinctrl-mt76x8.c

diff --git a/drivers/pinctrl/ralink/Kconfig b/drivers/pinctrl/ralink/Kconfig
index 1e4c5e43d69b..c5fe4c31aaea 100644
--- a/drivers/pinctrl/ralink/Kconfig
+++ b/drivers/pinctrl/ralink/Kconfig
@@ -17,6 +17,11 @@ config PINCTRL_MT7621
         depends on RALINK && SOC_MT7621
         select PINCTRL_RALINK
 
+config PINCTRL_MT76X8
+        bool "MT76X8 pinctrl subdriver"
+        depends on RALINK && SOC_MT7620
+        select PINCTRL_RALINK
+
 config PINCTRL_RT2880
         bool "RT2880 pinctrl subdriver"
         depends on RALINK && SOC_RT288X
diff --git a/drivers/pinctrl/ralink/Makefile b/drivers/pinctrl/ralink/Makefile
index 0ebbe552526d..be9acf2e27fd 100644
--- a/drivers/pinctrl/ralink/Makefile
+++ b/drivers/pinctrl/ralink/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PINCTRL_RALINK)   += pinctrl-ralink.o
 
 obj-$(CONFIG_PINCTRL_MT7620)   += pinctrl-mt7620.o
 obj-$(CONFIG_PINCTRL_MT7621)   += pinctrl-mt7621.o
+obj-$(CONFIG_PINCTRL_MT76X8)   += pinctrl-mt76x8.o
 obj-$(CONFIG_PINCTRL_RT2880)   += pinctrl-rt2880.o
 obj-$(CONFIG_PINCTRL_RT305X)   += pinctrl-rt305x.o
 obj-$(CONFIG_PINCTRL_RT3883)   += pinctrl-rt3883.o
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index 88b0c6a4ee18..b2245fd65c72 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <asm/mach-ralink/ralink_regs.h>
-#include <asm/mach-ralink/mt7620.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -112,262 +110,9 @@ static struct ralink_pmx_group mt7620a_pinmux_data[] = {
 	{ 0 }
 };
 
-static struct ralink_pmx_func pwm1_grp_mt76x8[] = {
-	FUNC("sdxc d6", 3, 19, 1),
-	FUNC("utif", 2, 19, 1),
-	FUNC("gpio", 1, 19, 1),
-	FUNC("pwm1", 0, 19, 1),
-};
-
-static struct ralink_pmx_func pwm0_grp_mt76x8[] = {
-	FUNC("sdxc d7", 3, 18, 1),
-	FUNC("utif", 2, 18, 1),
-	FUNC("gpio", 1, 18, 1),
-	FUNC("pwm0", 0, 18, 1),
-};
-
-static struct ralink_pmx_func uart2_grp_mt76x8[] = {
-	FUNC("sdxc d5 d4", 3, 20, 2),
-	FUNC("pwm", 2, 20, 2),
-	FUNC("gpio", 1, 20, 2),
-	FUNC("uart2", 0, 20, 2),
-};
-
-static struct ralink_pmx_func uart1_grp_mt76x8[] = {
-	FUNC("sw_r", 3, 45, 2),
-	FUNC("pwm", 2, 45, 2),
-	FUNC("gpio", 1, 45, 2),
-	FUNC("uart1", 0, 45, 2),
-};
-
-static struct ralink_pmx_func i2c_grp_mt76x8[] = {
-	FUNC("-", 3, 4, 2),
-	FUNC("debug", 2, 4, 2),
-	FUNC("gpio", 1, 4, 2),
-	FUNC("i2c", 0, 4, 2),
-};
-
-static struct ralink_pmx_func refclk_grp_mt76x8[] = { FUNC("refclk", 0, 37, 1) };
-static struct ralink_pmx_func perst_grp_mt76x8[] = { FUNC("perst", 0, 36, 1) };
-static struct ralink_pmx_func wdt_grp_mt76x8[] = { FUNC("wdt", 0, 38, 1) };
-static struct ralink_pmx_func spi_grp_mt76x8[] = { FUNC("spi", 0, 7, 4) };
-
-static struct ralink_pmx_func sd_mode_grp_mt76x8[] = {
-	FUNC("jtag", 3, 22, 8),
-	FUNC("utif", 2, 22, 8),
-	FUNC("gpio", 1, 22, 8),
-	FUNC("sdxc", 0, 22, 8),
-};
-
-static struct ralink_pmx_func uart0_grp_mt76x8[] = {
-	FUNC("-", 3, 12, 2),
-	FUNC("-", 2, 12, 2),
-	FUNC("gpio", 1, 12, 2),
-	FUNC("uart0", 0, 12, 2),
-};
-
-static struct ralink_pmx_func i2s_grp_mt76x8[] = {
-	FUNC("antenna", 3, 0, 4),
-	FUNC("pcm", 2, 0, 4),
-	FUNC("gpio", 1, 0, 4),
-	FUNC("i2s", 0, 0, 4),
-};
-
-static struct ralink_pmx_func spi_cs1_grp_mt76x8[] = {
-	FUNC("-", 3, 6, 1),
-	FUNC("refclk", 2, 6, 1),
-	FUNC("gpio", 1, 6, 1),
-	FUNC("spi cs1", 0, 6, 1),
-};
-
-static struct ralink_pmx_func spis_grp_mt76x8[] = {
-	FUNC("pwm_uart2", 3, 14, 4),
-	FUNC("utif", 2, 14, 4),
-	FUNC("gpio", 1, 14, 4),
-	FUNC("spis", 0, 14, 4),
-};
-
-static struct ralink_pmx_func gpio_grp_mt76x8[] = {
-	FUNC("pcie", 3, 11, 1),
-	FUNC("refclk", 2, 11, 1),
-	FUNC("gpio", 1, 11, 1),
-	FUNC("gpio", 0, 11, 1),
-};
-
-static struct ralink_pmx_func p4led_kn_grp_mt76x8[] = {
-	FUNC("jtag", 3, 30, 1),
-	FUNC("utif", 2, 30, 1),
-	FUNC("gpio", 1, 30, 1),
-	FUNC("p4led_kn", 0, 30, 1),
-};
-
-static struct ralink_pmx_func p3led_kn_grp_mt76x8[] = {
-	FUNC("jtag", 3, 31, 1),
-	FUNC("utif", 2, 31, 1),
-	FUNC("gpio", 1, 31, 1),
-	FUNC("p3led_kn", 0, 31, 1),
-};
-
-static struct ralink_pmx_func p2led_kn_grp_mt76x8[] = {
-	FUNC("jtag", 3, 32, 1),
-	FUNC("utif", 2, 32, 1),
-	FUNC("gpio", 1, 32, 1),
-	FUNC("p2led_kn", 0, 32, 1),
-};
-
-static struct ralink_pmx_func p1led_kn_grp_mt76x8[] = {
-	FUNC("jtag", 3, 33, 1),
-	FUNC("utif", 2, 33, 1),
-	FUNC("gpio", 1, 33, 1),
-	FUNC("p1led_kn", 0, 33, 1),
-};
-
-static struct ralink_pmx_func p0led_kn_grp_mt76x8[] = {
-	FUNC("jtag", 3, 34, 1),
-	FUNC("rsvd", 2, 34, 1),
-	FUNC("gpio", 1, 34, 1),
-	FUNC("p0led_kn", 0, 34, 1),
-};
-
-static struct ralink_pmx_func wled_kn_grp_mt76x8[] = {
-	FUNC("rsvd", 3, 35, 1),
-	FUNC("rsvd", 2, 35, 1),
-	FUNC("gpio", 1, 35, 1),
-	FUNC("wled_kn", 0, 35, 1),
-};
-
-static struct ralink_pmx_func p4led_an_grp_mt76x8[] = {
-	FUNC("jtag", 3, 39, 1),
-	FUNC("utif", 2, 39, 1),
-	FUNC("gpio", 1, 39, 1),
-	FUNC("p4led_an", 0, 39, 1),
-};
-
-static struct ralink_pmx_func p3led_an_grp_mt76x8[] = {
-	FUNC("jtag", 3, 40, 1),
-	FUNC("utif", 2, 40, 1),
-	FUNC("gpio", 1, 40, 1),
-	FUNC("p3led_an", 0, 40, 1),
-};
-
-static struct ralink_pmx_func p2led_an_grp_mt76x8[] = {
-	FUNC("jtag", 3, 41, 1),
-	FUNC("utif", 2, 41, 1),
-	FUNC("gpio", 1, 41, 1),
-	FUNC("p2led_an", 0, 41, 1),
-};
-
-static struct ralink_pmx_func p1led_an_grp_mt76x8[] = {
-	FUNC("jtag", 3, 42, 1),
-	FUNC("utif", 2, 42, 1),
-	FUNC("gpio", 1, 42, 1),
-	FUNC("p1led_an", 0, 42, 1),
-};
-
-static struct ralink_pmx_func p0led_an_grp_mt76x8[] = {
-	FUNC("jtag", 3, 43, 1),
-	FUNC("rsvd", 2, 43, 1),
-	FUNC("gpio", 1, 43, 1),
-	FUNC("p0led_an", 0, 43, 1),
-};
-
-static struct ralink_pmx_func wled_an_grp_mt76x8[] = {
-	FUNC("rsvd", 3, 44, 1),
-	FUNC("rsvd", 2, 44, 1),
-	FUNC("gpio", 1, 44, 1),
-	FUNC("wled_an", 0, 44, 1),
-};
-
-#define MT76X8_GPIO_MODE_MASK		0x3
-
-#define MT76X8_GPIO_MODE_P4LED_KN	58
-#define MT76X8_GPIO_MODE_P3LED_KN	56
-#define MT76X8_GPIO_MODE_P2LED_KN	54
-#define MT76X8_GPIO_MODE_P1LED_KN	52
-#define MT76X8_GPIO_MODE_P0LED_KN	50
-#define MT76X8_GPIO_MODE_WLED_KN	48
-#define MT76X8_GPIO_MODE_P4LED_AN	42
-#define MT76X8_GPIO_MODE_P3LED_AN	40
-#define MT76X8_GPIO_MODE_P2LED_AN	38
-#define MT76X8_GPIO_MODE_P1LED_AN	36
-#define MT76X8_GPIO_MODE_P0LED_AN	34
-#define MT76X8_GPIO_MODE_WLED_AN	32
-#define MT76X8_GPIO_MODE_PWM1		30
-#define MT76X8_GPIO_MODE_PWM0		28
-#define MT76X8_GPIO_MODE_UART2		26
-#define MT76X8_GPIO_MODE_UART1		24
-#define MT76X8_GPIO_MODE_I2C		20
-#define MT76X8_GPIO_MODE_REFCLK		18
-#define MT76X8_GPIO_MODE_PERST		16
-#define MT76X8_GPIO_MODE_WDT		14
-#define MT76X8_GPIO_MODE_SPI		12
-#define MT76X8_GPIO_MODE_SDMODE		10
-#define MT76X8_GPIO_MODE_UART0		8
-#define MT76X8_GPIO_MODE_I2S		6
-#define MT76X8_GPIO_MODE_CS1		4
-#define MT76X8_GPIO_MODE_SPIS		2
-#define MT76X8_GPIO_MODE_GPIO		0
-
-static struct ralink_pmx_group mt76x8_pinmux_data[] = {
-	GRP_G("pwm1", pwm1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_PWM1),
-	GRP_G("pwm0", pwm0_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_PWM0),
-	GRP_G("uart2", uart2_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_UART2),
-	GRP_G("uart1", uart1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_UART1),
-	GRP_G("i2c", i2c_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_I2C),
-	GRP("refclk", refclk_grp_mt76x8, 1, MT76X8_GPIO_MODE_REFCLK),
-	GRP("perst", perst_grp_mt76x8, 1, MT76X8_GPIO_MODE_PERST),
-	GRP("wdt", wdt_grp_mt76x8, 1, MT76X8_GPIO_MODE_WDT),
-	GRP("spi", spi_grp_mt76x8, 1, MT76X8_GPIO_MODE_SPI),
-	GRP_G("sdmode", sd_mode_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_SDMODE),
-	GRP_G("uart0", uart0_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_UART0),
-	GRP_G("i2s", i2s_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_I2S),
-	GRP_G("spi cs1", spi_cs1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_CS1),
-	GRP_G("spis", spis_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_SPIS),
-	GRP_G("gpio", gpio_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_GPIO),
-	GRP_G("wled_an", wled_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_WLED_AN),
-	GRP_G("p0led_an", p0led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P0LED_AN),
-	GRP_G("p1led_an", p1led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P1LED_AN),
-	GRP_G("p2led_an", p2led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P2LED_AN),
-	GRP_G("p3led_an", p3led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P3LED_AN),
-	GRP_G("p4led_an", p4led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P4LED_AN),
-	GRP_G("wled_kn", wled_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_WLED_KN),
-	GRP_G("p0led_kn", p0led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P0LED_KN),
-	GRP_G("p1led_kn", p1led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P1LED_KN),
-	GRP_G("p2led_kn", p2led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P2LED_KN),
-	GRP_G("p3led_kn", p3led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P3LED_KN),
-	GRP_G("p4led_kn", p4led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
-				1, MT76X8_GPIO_MODE_P4LED_KN),
-	{ 0 }
-};
-
 static int mt7620_pinctrl_probe(struct platform_device *pdev)
 {
-	if (is_mt76x8())
-		return ralink_pinctrl_init(pdev, mt76x8_pinmux_data);
-	else
-		return ralink_pinctrl_init(pdev, mt7620a_pinmux_data);
+	return ralink_pinctrl_init(pdev, mt7620a_pinmux_data);
 }
 
 static const struct of_device_id mt7620_pinctrl_match[] = {
diff --git a/drivers/pinctrl/ralink/pinctrl-mt76x8.c b/drivers/pinctrl/ralink/pinctrl-mt76x8.c
new file mode 100644
index 000000000000..5a6a82a58180
--- /dev/null
+++ b/drivers/pinctrl/ralink/pinctrl-mt76x8.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include "pinctrl-ralink.h"
+
+#define MT76X8_GPIO_MODE_MASK		0x3
+
+#define MT76X8_GPIO_MODE_P4LED_KN	58
+#define MT76X8_GPIO_MODE_P3LED_KN	56
+#define MT76X8_GPIO_MODE_P2LED_KN	54
+#define MT76X8_GPIO_MODE_P1LED_KN	52
+#define MT76X8_GPIO_MODE_P0LED_KN	50
+#define MT76X8_GPIO_MODE_WLED_KN	48
+#define MT76X8_GPIO_MODE_P4LED_AN	42
+#define MT76X8_GPIO_MODE_P3LED_AN	40
+#define MT76X8_GPIO_MODE_P2LED_AN	38
+#define MT76X8_GPIO_MODE_P1LED_AN	36
+#define MT76X8_GPIO_MODE_P0LED_AN	34
+#define MT76X8_GPIO_MODE_WLED_AN	32
+#define MT76X8_GPIO_MODE_PWM1		30
+#define MT76X8_GPIO_MODE_PWM0		28
+#define MT76X8_GPIO_MODE_UART2		26
+#define MT76X8_GPIO_MODE_UART1		24
+#define MT76X8_GPIO_MODE_I2C		20
+#define MT76X8_GPIO_MODE_REFCLK		18
+#define MT76X8_GPIO_MODE_PERST		16
+#define MT76X8_GPIO_MODE_WDT		14
+#define MT76X8_GPIO_MODE_SPI		12
+#define MT76X8_GPIO_MODE_SDMODE		10
+#define MT76X8_GPIO_MODE_UART0		8
+#define MT76X8_GPIO_MODE_I2S		6
+#define MT76X8_GPIO_MODE_CS1		4
+#define MT76X8_GPIO_MODE_SPIS		2
+#define MT76X8_GPIO_MODE_GPIO		0
+
+static struct ralink_pmx_func pwm1_grp[] = {
+	FUNC("sdxc d6", 3, 19, 1),
+	FUNC("utif", 2, 19, 1),
+	FUNC("gpio", 1, 19, 1),
+	FUNC("pwm1", 0, 19, 1),
+};
+
+static struct ralink_pmx_func pwm0_grp[] = {
+	FUNC("sdxc d7", 3, 18, 1),
+	FUNC("utif", 2, 18, 1),
+	FUNC("gpio", 1, 18, 1),
+	FUNC("pwm0", 0, 18, 1),
+};
+
+static struct ralink_pmx_func uart2_grp[] = {
+	FUNC("sdxc d5 d4", 3, 20, 2),
+	FUNC("pwm", 2, 20, 2),
+	FUNC("gpio", 1, 20, 2),
+	FUNC("uart2", 0, 20, 2),
+};
+
+static struct ralink_pmx_func uart1_grp[] = {
+	FUNC("sw_r", 3, 45, 2),
+	FUNC("pwm", 2, 45, 2),
+	FUNC("gpio", 1, 45, 2),
+	FUNC("uart1", 0, 45, 2),
+};
+
+static struct ralink_pmx_func i2c_grp[] = {
+	FUNC("-", 3, 4, 2),
+	FUNC("debug", 2, 4, 2),
+	FUNC("gpio", 1, 4, 2),
+	FUNC("i2c", 0, 4, 2),
+};
+
+static struct ralink_pmx_func refclk_grp[] = { FUNC("refclk", 0, 37, 1) };
+static struct ralink_pmx_func perst_grp[] = { FUNC("perst", 0, 36, 1) };
+static struct ralink_pmx_func wdt_grp[] = { FUNC("wdt", 0, 38, 1) };
+static struct ralink_pmx_func spi_grp[] = { FUNC("spi", 0, 7, 4) };
+
+static struct ralink_pmx_func sd_mode_grp[] = {
+	FUNC("jtag", 3, 22, 8),
+	FUNC("utif", 2, 22, 8),
+	FUNC("gpio", 1, 22, 8),
+	FUNC("sdxc", 0, 22, 8),
+};
+
+static struct ralink_pmx_func uart0_grp[] = {
+	FUNC("-", 3, 12, 2),
+	FUNC("-", 2, 12, 2),
+	FUNC("gpio", 1, 12, 2),
+	FUNC("uart0", 0, 12, 2),
+};
+
+static struct ralink_pmx_func i2s_grp[] = {
+	FUNC("antenna", 3, 0, 4),
+	FUNC("pcm", 2, 0, 4),
+	FUNC("gpio", 1, 0, 4),
+	FUNC("i2s", 0, 0, 4),
+};
+
+static struct ralink_pmx_func spi_cs1_grp[] = {
+	FUNC("-", 3, 6, 1),
+	FUNC("refclk", 2, 6, 1),
+	FUNC("gpio", 1, 6, 1),
+	FUNC("spi cs1", 0, 6, 1),
+};
+
+static struct ralink_pmx_func spis_grp[] = {
+	FUNC("pwm_uart2", 3, 14, 4),
+	FUNC("utif", 2, 14, 4),
+	FUNC("gpio", 1, 14, 4),
+	FUNC("spis", 0, 14, 4),
+};
+
+static struct ralink_pmx_func gpio_grp[] = {
+	FUNC("pcie", 3, 11, 1),
+	FUNC("refclk", 2, 11, 1),
+	FUNC("gpio", 1, 11, 1),
+	FUNC("gpio", 0, 11, 1),
+};
+
+static struct ralink_pmx_func p4led_kn_grp[] = {
+	FUNC("jtag", 3, 30, 1),
+	FUNC("utif", 2, 30, 1),
+	FUNC("gpio", 1, 30, 1),
+	FUNC("p4led_kn", 0, 30, 1),
+};
+
+static struct ralink_pmx_func p3led_kn_grp[] = {
+	FUNC("jtag", 3, 31, 1),
+	FUNC("utif", 2, 31, 1),
+	FUNC("gpio", 1, 31, 1),
+	FUNC("p3led_kn", 0, 31, 1),
+};
+
+static struct ralink_pmx_func p2led_kn_grp[] = {
+	FUNC("jtag", 3, 32, 1),
+	FUNC("utif", 2, 32, 1),
+	FUNC("gpio", 1, 32, 1),
+	FUNC("p2led_kn", 0, 32, 1),
+};
+
+static struct ralink_pmx_func p1led_kn_grp[] = {
+	FUNC("jtag", 3, 33, 1),
+	FUNC("utif", 2, 33, 1),
+	FUNC("gpio", 1, 33, 1),
+	FUNC("p1led_kn", 0, 33, 1),
+};
+
+static struct ralink_pmx_func p0led_kn_grp[] = {
+	FUNC("jtag", 3, 34, 1),
+	FUNC("rsvd", 2, 34, 1),
+	FUNC("gpio", 1, 34, 1),
+	FUNC("p0led_kn", 0, 34, 1),
+};
+
+static struct ralink_pmx_func wled_kn_grp[] = {
+	FUNC("rsvd", 3, 35, 1),
+	FUNC("rsvd", 2, 35, 1),
+	FUNC("gpio", 1, 35, 1),
+	FUNC("wled_kn", 0, 35, 1),
+};
+
+static struct ralink_pmx_func p4led_an_grp[] = {
+	FUNC("jtag", 3, 39, 1),
+	FUNC("utif", 2, 39, 1),
+	FUNC("gpio", 1, 39, 1),
+	FUNC("p4led_an", 0, 39, 1),
+};
+
+static struct ralink_pmx_func p3led_an_grp[] = {
+	FUNC("jtag", 3, 40, 1),
+	FUNC("utif", 2, 40, 1),
+	FUNC("gpio", 1, 40, 1),
+	FUNC("p3led_an", 0, 40, 1),
+};
+
+static struct ralink_pmx_func p2led_an_grp[] = {
+	FUNC("jtag", 3, 41, 1),
+	FUNC("utif", 2, 41, 1),
+	FUNC("gpio", 1, 41, 1),
+	FUNC("p2led_an", 0, 41, 1),
+};
+
+static struct ralink_pmx_func p1led_an_grp[] = {
+	FUNC("jtag", 3, 42, 1),
+	FUNC("utif", 2, 42, 1),
+	FUNC("gpio", 1, 42, 1),
+	FUNC("p1led_an", 0, 42, 1),
+};
+
+static struct ralink_pmx_func p0led_an_grp[] = {
+	FUNC("jtag", 3, 43, 1),
+	FUNC("rsvd", 2, 43, 1),
+	FUNC("gpio", 1, 43, 1),
+	FUNC("p0led_an", 0, 43, 1),
+};
+
+static struct ralink_pmx_func wled_an_grp[] = {
+	FUNC("rsvd", 3, 44, 1),
+	FUNC("rsvd", 2, 44, 1),
+	FUNC("gpio", 1, 44, 1),
+	FUNC("wled_an", 0, 44, 1),
+};
+
+static struct ralink_pmx_group mt76x8_pinmux_data[] = {
+	GRP_G("pwm1", pwm1_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_PWM1),
+	GRP_G("pwm0", pwm0_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_PWM0),
+	GRP_G("uart2", uart2_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_UART2),
+	GRP_G("uart1", uart1_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_UART1),
+	GRP_G("i2c", i2c_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_I2C),
+	GRP("refclk", refclk_grp, 1, MT76X8_GPIO_MODE_REFCLK),
+	GRP("perst", perst_grp, 1, MT76X8_GPIO_MODE_PERST),
+	GRP("wdt", wdt_grp, 1, MT76X8_GPIO_MODE_WDT),
+	GRP("spi", spi_grp, 1, MT76X8_GPIO_MODE_SPI),
+	GRP_G("sdmode", sd_mode_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_SDMODE),
+	GRP_G("uart0", uart0_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_UART0),
+	GRP_G("i2s", i2s_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_I2S),
+	GRP_G("spi cs1", spi_cs1_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_CS1),
+	GRP_G("spis", spis_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_SPIS),
+	GRP_G("gpio", gpio_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_GPIO),
+	GRP_G("wled_an", wled_an_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_WLED_AN),
+	GRP_G("p0led_an", p0led_an_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P0LED_AN),
+	GRP_G("p1led_an", p1led_an_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P1LED_AN),
+	GRP_G("p2led_an", p2led_an_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P2LED_AN),
+	GRP_G("p3led_an", p3led_an_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P3LED_AN),
+	GRP_G("p4led_an", p4led_an_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P4LED_AN),
+	GRP_G("wled_kn", wled_kn_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_WLED_KN),
+	GRP_G("p0led_kn", p0led_kn_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P0LED_KN),
+	GRP_G("p1led_kn", p1led_kn_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P1LED_KN),
+	GRP_G("p2led_kn", p2led_kn_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P2LED_KN),
+	GRP_G("p3led_kn", p3led_kn_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P3LED_KN),
+	GRP_G("p4led_kn", p4led_kn_grp, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P4LED_KN),
+	{ 0 }
+};
+
+static int mt76x8_pinctrl_probe(struct platform_device *pdev)
+{
+	return ralink_pinctrl_init(pdev, mt76x8_pinmux_data);
+}
+
+static const struct of_device_id mt76x8_pinctrl_match[] = {
+	{ .compatible = "mediatek,mt76x8-pinctrl" },
+	{ .compatible = "ralink,mt7620-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt76x8_pinctrl_match);
+
+static struct platform_driver mt76x8_pinctrl_driver = {
+	.probe = mt76x8_pinctrl_probe,
+	.driver = {
+		.name = "mt76x8-pinctrl",
+		.of_match_table = mt76x8_pinctrl_match,
+	},
+};
+
+static int __init mt76x8_pinctrl_init(void)
+{
+	return platform_driver_register(&mt76x8_pinctrl_driver);
+}
+core_initcall_sync(mt76x8_pinctrl_init);
-- 
2.37.2

