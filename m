Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0CB61161F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJ1Pg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJ1PgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:36:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294682619;
        Fri, 28 Oct 2022 08:35:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q9so13900061ejd.0;
        Fri, 28 Oct 2022 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxF5Y1nc7IPD7SzrHGIFBmA/pcqS9sVGZ0A9mc4cWes=;
        b=bidYpd2JEn/hPcgnyfsmp45gsMOWQQnBhe9tDisRHb1GBBeSQTewDf4k0nj8zZtJYS
         zKAHOUaSaWQ57qNdrBLDdENPDH6Jx9VTDi0JnvZsJmVsEzXNenGbkSCNUrS/c2l3vRxI
         650YdKdDUnX19M7GdoTMsWi+VhkwqhqtUJZ3A1dgVmHEVPYqeBK74tCm+L75Z7VDHTfn
         4hekftr3kI1JNueDGHnvbtXbYIqYuAwKOWiToqV+O2jmbgA8z/5AaFN8ARGJHpetr/rL
         UEoMMX56mwmoSigl5UCPup2iqCRmaFMeLOBka0iat8g5ipueygatG1mXBUnloHKMYnT3
         F8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxF5Y1nc7IPD7SzrHGIFBmA/pcqS9sVGZ0A9mc4cWes=;
        b=FoOUS6hucuKfek34LcIt8DBZ6Hbj7aDyeT3K5j561JHk96lS8im7BWwKRo6tF6SONm
         3CT5HJKT/PWfdQDFKZigWTr0RXhifO4b9DvOTe5eFaWbSL1SK96FjwnJonf+qHY8uMBg
         x2M9kEAFNmoOxFHNb/MwuJthE/69V245pUPXKPHgjlaYl4Pd0lEIHzN4BXyWIjfszaM3
         VO0d1NQuK7CzenjTbkgTR9yaYHIsF8501s+zr3vv844R7gJbZfnaIeinCO1D3fWIKmxY
         FaVlmATLrQpKWxcS6xpGxpEVDHjP5ZbawN+r/igM1PyrDILnEV6c39Ub2ztrC+MlJq+J
         ZSiA==
X-Gm-Message-State: ACrzQf2jNkHnLfB0aYYo6Hp8wfmfxyZ+UdTmhQpcGDbdYEbt80dz9Xi0
        Ofy2eYP1ZhGAR1bYDO+0LsIubGmq9uSkIQ==
X-Google-Smtp-Source: AMsMyM435X5llBu2ryxz7MYaF9NX9FJCTDT7AuffJgoO8ifcY0MstsIEhPoaFHj7y2izfd0ObFcp4A==
X-Received: by 2002:a17:907:7fa4:b0:791:9307:9d6a with SMTP id qk36-20020a1709077fa400b0079193079d6amr47766124ejc.464.1666971347546;
        Fri, 28 Oct 2022 08:35:47 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:47 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/13] pinctrl: mediatek: Add MT6735 pinctrl driver
Date:   Fri, 28 Oct 2022 18:35:05 +0300
Message-Id: <20221028153505.23741-14-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a driver for the MediaTek MT6735 SoC pin controller. This driver
also supports the pin controller on MT6735M, which lacks 6 physical
pins (198-203) used for MSDC2 on MT6735.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 MAINTAINERS                                   |    2 +
 drivers/pinctrl/mediatek/Kconfig              |    6 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
 5 files changed, 4586 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ba5ac4422f00..f471fb2c88dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16319,6 +16319,8 @@ M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+F:	drivers/pinctrl/mediatek/pinctrl-mt6735.c
+F:	drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h
 
 PIN CONTROLLER - MICROCHIP AT91
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index fed02c6fea06..63cf89f60986 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -87,6 +87,12 @@ config PINCTRL_MT2712
 	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK
 
+config PINCTRL_MT6735
+	bool "MediaTek MT6735(M) pin control"
+	depends on OF
+	default ARM64 && ARCH_MEDIATEK
+	select PINCTRL_MTK_PARIS
+
 config PINCTRL_MT6765
 	tristate "Mediatek MT6765 pin control"
 	depends on OF
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index 53265404a39d..104468fac431 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PINCTRL_MT2701)	+= pinctrl-mt2701.o
 obj-$(CONFIG_PINCTRL_MT2712)	+= pinctrl-mt2712.o
 obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
 obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
+obj-$(CONFIG_PINCTRL_MT6735)	+= pinctrl-mt6735.o
 obj-$(CONFIG_PINCTRL_MT6765)	+= pinctrl-mt6765.o
 obj-$(CONFIG_PINCTRL_MT6779)	+= pinctrl-mt6779.o
 obj-$(CONFIG_PINCTRL_MT6795)	+= pinctrl-mt6795.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6735.c b/drivers/pinctrl/mediatek/pinctrl-mt6735.c
new file mode 100644
index 000000000000..5a2d535a35c9
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6735.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "pinctrl-mtk-mt6735.h"
+#include "pinctrl-paris.h"
+
+/* Common registers */
+#define GPIO_DIR	0x000
+#define GPIO_DOUT	0x100
+#define GPIO_DIN	0x200
+#define GPIO_MODE1	0x300
+#define GPIO_MODE2	0x310
+#define GPIO_MODE3	0x320
+#define GPIO_MODE4	0x330
+#define GPIO_MODE5	0x340
+#define GPIO_MODE6	0x350
+#define GPIO_MODE7	0x360
+#define GPIO_MODE8	0x370
+#define GPIO_MODE9	0x380
+#define GPIO_MODE10	0x390
+#define GPIO_MODE11	0x3a0
+#define GPIO_MODE12	0x3b0
+#define GPIO_MODE13	0x3c0
+#define GPIO_MODE14	0x3d0
+#define GPIO_MODE15	0x3e0
+#define GPIO_MODE16	0x3f0
+#define GPIO_MODE17	0x400
+#define GPIO_MODE18	0x410
+#define GPIO_MODE19	0x420
+#define GPIO_MODE20	0x430
+#define GPIO_MODE21	0x440
+
+/* Pin group registers */
+#define GPIO_IES	0x000
+#define GPIO_SMT	0x010
+#define GPIO_TDSEL0	0x020
+#define GPIO_TDSEL1	0x024
+#define GPIO_RDSEL0	0x028
+#define GPIO_RDSEL1	0x02c
+#define GPIO_PULLEN0	0x030
+#define GPIO_PULLEN1	0x040
+#define GPIO_PULLSEL0	0x050
+#define GPIO_PULLSEL1	0x060
+#define GPIO_DRV0	0x070
+#define GPIO_DRV1	0x074
+#define GPIO_PUPD0	0x080
+#define GPIO_PUPD1	0x090
+
+#define PIN_FIELD_BASE(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
+		       _x_bits, 32, 0)
+
+#define PINS_FIELD_BASE(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
+		      _x_bits, 32, 1)
+
+static const struct mtk_pin_field_calc mt6735_pin_dir_range[] = {
+	PIN_FIELD(0, 203, GPIO_DIR, 0x10, 0, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_di_range[] = {
+	PIN_FIELD(0, 203, GPIO_DIN, 0x10, 0, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_do_range[] = {
+	PIN_FIELD(0, 203, GPIO_DOUT, 0x10, 0, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_mode_range[] = {
+	PIN_FIELD(0, 4, GPIO_MODE1, 0x10, 0, 3),
+	PIN_FIELD(5, 9, GPIO_MODE1, 0x10, 16, 3),
+	PIN_FIELD(10, 14, GPIO_MODE2, 0x10, 0, 3),
+	PIN_FIELD(15, 19, GPIO_MODE2, 0x10, 16, 3),
+	PIN_FIELD(20, 24, GPIO_MODE3, 0x10, 0, 3),
+	PIN_FIELD(25, 29, GPIO_MODE3, 0x10, 16, 3),
+	PIN_FIELD(30, 34, GPIO_MODE4, 0x10, 0, 3),
+	PIN_FIELD(35, 39, GPIO_MODE4, 0x10, 16, 3),
+	PIN_FIELD(40, 44, GPIO_MODE5, 0x10, 0, 3),
+	PIN_FIELD(45, 49, GPIO_MODE5, 0x10, 16, 3),
+	PIN_FIELD(50, 54, GPIO_MODE6, 0x10, 0, 3),
+	PIN_FIELD(55, 59, GPIO_MODE6, 0x10, 16, 3),
+	PIN_FIELD(60, 64, GPIO_MODE7, 0x10, 0, 3),
+	PIN_FIELD(65, 69, GPIO_MODE7, 0x10, 16, 3),
+	PIN_FIELD(70, 74, GPIO_MODE8, 0x10, 0, 3),
+	PIN_FIELD(75, 79, GPIO_MODE8, 0x10, 16, 3),
+	PIN_FIELD(80, 84, GPIO_MODE9, 0x10, 0, 3),
+	PIN_FIELD(85, 89, GPIO_MODE9, 0x10, 16, 3),
+	PIN_FIELD(90, 94, GPIO_MODE10, 0x10, 0, 3),
+	PIN_FIELD(95, 99, GPIO_MODE10, 0x10, 16, 3),
+	PIN_FIELD(100, 104, GPIO_MODE11, 0x10, 0, 3),
+	PIN_FIELD(105, 109, GPIO_MODE11, 0x10, 16, 3),
+	PIN_FIELD(110, 114, GPIO_MODE12, 0x10, 0, 3),
+	PIN_FIELD(115, 119, GPIO_MODE12, 0x10, 16, 3),
+	PIN_FIELD(120, 124, GPIO_MODE13, 0x10, 0, 3),
+	PIN_FIELD(125, 129, GPIO_MODE13, 0x10, 16, 3),
+	PIN_FIELD(130, 134, GPIO_MODE14, 0x10, 0, 3),
+	PIN_FIELD(135, 139, GPIO_MODE14, 0x10, 16, 3),
+	PIN_FIELD(140, 144, GPIO_MODE15, 0x10, 0, 3),
+	PIN_FIELD(145, 149, GPIO_MODE15, 0x10, 16, 3),
+	PIN_FIELD(150, 154, GPIO_MODE16, 0x10, 0, 3),
+	PIN_FIELD(155, 159, GPIO_MODE16, 0x10, 16, 3),
+	PIN_FIELD(160, 164, GPIO_MODE17, 0x10, 0, 3),
+	PIN_FIELD(165, 169, GPIO_MODE17, 0x10, 16, 3),
+	PIN_FIELD(170, 174, GPIO_MODE18, 0x10, 0, 3),
+	PIN_FIELD(175, 179, GPIO_MODE18, 0x10, 16, 3),
+	PIN_FIELD(180, 184, GPIO_MODE19, 0x10, 0, 3),
+	PIN_FIELD(185, 189, GPIO_MODE19, 0x10, 16, 3),
+	PIN_FIELD(190, 194, GPIO_MODE20, 0x10, 0, 3),
+	PIN_FIELD(195, 199, GPIO_MODE20, 0x10, 16, 3),
+	PIN_FIELD(200, 203, GPIO_MODE21, 0x10, 0, 3),
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_smt_range[] = {
+	PINS_FIELD_BASE(0, 4, 2, GPIO_SMT, 0x10, 10, 1),	/* EINT0~4 */
+	PINS_FIELD_BASE(5, 8, 3, GPIO_SMT, 0x10, 3, 1),		/* EINT5~8 */
+	PINS_FIELD_BASE(9, 12, 3, GPIO_SMT, 0x10, 6, 1),	/* EINT9~12 */
+	PINS_FIELD_BASE(13, 18, 1, GPIO_SMT, 0x10, 0, 1),	/* WB_CTRL */
+	PINS_FIELD_BASE(19, 21, 1, GPIO_SMT, 0x10, 1, 1),	/* ANTSEL */
+	PINS_FIELD_BASE(42, 44, 2, GPIO_SMT, 0x10, 0, 1),	/* CMPDAT */
+	PINS_FIELD_BASE(45, 46, 2, GPIO_SMT, 0x10, 1, 1),	/* CMMCLK */
+	PINS_FIELD_BASE(47, 48, 2, GPIO_SMT, 0x10, 2, 1),	/* I2C0 */
+	PINS_FIELD_BASE(49, 50, 2, GPIO_SMT, 0x10, 3, 1),	/* I2C1 */
+	PINS_FIELD_BASE(51, 52, 2, GPIO_SMT, 0x10, 4, 1),	/* I2C2 */
+	PINS_FIELD_BASE(53, 54, 2, GPIO_SMT, 0x10, 5, 1),	/* I2C3 */
+	PIN_FIELD_BASE(55, 55, 2, GPIO_SMT, 0x10, 6, 1),	/* SRCLKENAI */
+	PIN_FIELD_BASE(56, 56, 2, GPIO_SMT, 0x10, 7, 1),	/* SRCLKENA1 */
+	PINS_FIELD_BASE(57, 60, 2, GPIO_SMT, 0x10, 8, 1),	/* UART2/3 */
+	PINS_FIELD_BASE(61, 64, 2, GPIO_SMT, 0x10, 9, 1),	/* PCM */
+	PINS_FIELD_BASE(65, 68, 3, GPIO_SMT, 0x10, 0, 1),	/* SPI */
+	PIN_FIELD_BASE(69, 69, 3, GPIO_SMT, 0x10, 1, 1),	/* DISP_PWM */
+	PINS_FIELD_BASE(70, 73, 3, GPIO_SMT, 0x10, 2, 1),	/* JTAG */
+	PINS_FIELD_BASE(74, 77, 3, GPIO_SMT, 0x10, 4, 1),	/* UART0/1 */
+	PINS_FIELD_BASE(78, 80, 3, GPIO_SMT, 0x10, 5, 1),	/* I2S */
+	PINS_FIELD_BASE(81, 86, 3, GPIO_SMT, 0x10, 7, 1),	/* KEYPAD */
+	PINS_FIELD_BASE(87, 103, 3, GPIO_SMT, 0x10, 8, 1),	/* BPI5~20, C2K_TKBPI */
+	PINS_FIELD_BASE(104, 114, 3, GPIO_SMT, 0x10, 9, 1),	/* RFIC0/1 */
+	PINS_FIELD_BASE(118, 136, 4, GPIO_SMT, 0x10, 0, 1),	/* LTE_TXBPI, BPI0~4, BPI21~27, PAVM */
+	PIN_FIELD_BASE(137, 137, 4, GPIO_SMT, 0x10, 1, 1),	/* RTC32K */
+	PINS_FIELD_BASE(138, 142, 4, GPIO_SMT, 0x10, 2, 1),	/* PWRAP */
+	PINS_FIELD_BASE(143, 145, 4, GPIO_SMT, 0x10, 3, 1),	/* AUD */
+	PINS_FIELD_BASE(146, 147, 4, GPIO_SMT, 0x10, 4, 1),	/* LCM_RST, DSI_TE */
+	PIN_FIELD_BASE(148, 148, 4, GPIO_SMT, 0x10, 5, 1),	/* SRCLKENA0 */
+	PIN_FIELD_BASE(149, 149, 4, GPIO_SMT, 0x10, 1, 1),	/* WATCHDOG */
+	PINS_FIELD_BASE(160, 162, 5, GPIO_SMT, 0x10, 0, 1),	/* SIM2 */
+	PINS_FIELD_BASE(163, 165, 4, GPIO_SMT, 0x10, 1, 1),	/* SIM1 */
+	PIN_FIELD_BASE(166, 166, 5, GPIO_SMT, 0x10, 2, 1),	/* MSDC1_CMD */
+	PIN_FIELD_BASE(167, 167, 5, GPIO_SMT, 0x10, 3, 1),	/* MSDC1_CLK */
+	PINS_FIELD_BASE(168, 171, 5, GPIO_SMT, 0x10, 4, 1),	/* MSDC1_DAT */
+	PIN_FIELD_BASE(172, 172, 6, GPIO_SMT, 0x10, 0, 1),	/* MSDC0_CMD */
+	PIN_FIELD_BASE(173, 173, 6, GPIO_SMT, 0x10, 1, 1),	/* MSDC0_DSL */
+	PIN_FIELD_BASE(174, 174, 6, GPIO_SMT, 0x10, 2, 1),	/* MSDC0_CLK */
+	PINS_FIELD_BASE(175, 182, 6, GPIO_SMT, 0x10, 3, 1),	/* MSDC0_DAT */
+	PIN_FIELD_BASE(183, 183, 6, GPIO_SMT, 0x10, 4, 1),	/* MSDC0_RSTB */
+	PINS_FIELD_BASE(184, 185, 6, GPIO_SMT, 0x10, 5, 1),	/* FM */
+	PINS_FIELD_BASE(186, 189, 6, GPIO_SMT, 0x10, 6, 1),	/* WB SPI */
+	PIN_FIELD_BASE(198, 198, 1, GPIO_SMT, 0x10, 2, 1),	/* MSDC2_CMD */
+	PIN_FIELD_BASE(199, 199, 1, GPIO_SMT, 0x10, 3, 1),	/* MSDC2_CLK */
+	PINS_FIELD_BASE(200, 203, 1, GPIO_SMT, 0x10, 4, 1)	/* MSDC2_DAT */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_ies_range[] = {
+	PINS_FIELD_BASE(0, 4, 2, GPIO_IES, 0x10, 10, 1),	/* EINT0~4 */
+	PINS_FIELD_BASE(5, 8, 3, GPIO_IES, 0x10, 3, 1),		/* EINT5~8 */
+	PINS_FIELD_BASE(9, 12, 3, GPIO_IES, 0x10, 6, 1),	/* EINT9~12 */
+	PINS_FIELD_BASE(13, 18, 1, GPIO_IES, 0x10, 0, 1),	/* WB_CTRL */
+	PINS_FIELD_BASE(19, 21, 1, GPIO_IES, 0x10, 1, 1),	/* ANTSEL */
+	PINS_FIELD_BASE(42, 44, 2, GPIO_IES, 0x10, 0, 1),	/* CMPDAT */
+	PINS_FIELD_BASE(45, 46, 2, GPIO_IES, 0x10, 1, 1),	/* CMMCLK */
+	PINS_FIELD_BASE(47, 48, 2, GPIO_IES, 0x10, 2, 1),	/* I2C0 */
+	PINS_FIELD_BASE(49, 50, 2, GPIO_IES, 0x10, 3, 1),	/* I2C1 */
+	PINS_FIELD_BASE(51, 52, 2, GPIO_IES, 0x10, 4, 1),	/* I2C2 */
+	PINS_FIELD_BASE(53, 54, 2, GPIO_IES, 0x10, 5, 1),	/* I2C3 */
+	PIN_FIELD_BASE(55, 55, 2, GPIO_IES, 0x10, 6, 1),	/* SRCLKENAI */
+	PIN_FIELD_BASE(56, 56, 2, GPIO_IES, 0x10, 7, 1),	/* SRCLKENA1 */
+	PINS_FIELD_BASE(57, 60, 2, GPIO_IES, 0x10, 8, 1),	/* UART2/3 */
+	PINS_FIELD_BASE(61, 64, 2, GPIO_IES, 0x10, 9, 1),	/* PCM */
+	PINS_FIELD_BASE(65, 68, 3, GPIO_IES, 0x10, 0, 1),	/* SPI */
+	PIN_FIELD_BASE(69, 69, 3, GPIO_IES, 0x10, 1, 1),	/* DISP_PWM */
+	PINS_FIELD_BASE(70, 73, 3, GPIO_IES, 0x10, 2, 1),	/* JTAG */
+	PINS_FIELD_BASE(74, 77, 3, GPIO_IES, 0x10, 4, 1),	/* UART0/1 */
+	PINS_FIELD_BASE(78, 80, 3, GPIO_IES, 0x10, 5, 1),	/* I2S */
+	PINS_FIELD_BASE(81, 86, 3, GPIO_IES, 0x10, 7, 1),	/* KEYPAD */
+	PINS_FIELD_BASE(87, 103, 3, GPIO_IES, 0x10, 8, 1),	/* BPI5~20, C2K_TKBPI */
+	PINS_FIELD_BASE(104, 114, 3, GPIO_IES, 0x10, 9, 1),	/* RFIC0/1 */
+	PINS_FIELD_BASE(118, 136, 4, GPIO_IES, 0x10, 0, 1),	/* LTE_TXBPI, BPI0~4, BPI21~27, PAVM */
+	PIN_FIELD_BASE(137, 137, 4, GPIO_IES, 0x10, 1, 1),	/* RTC32K */
+	PINS_FIELD_BASE(138, 142, 4, GPIO_IES, 0x10, 2, 1),	/* PWRAP */
+	PINS_FIELD_BASE(143, 145, 4, GPIO_IES, 0x10, 3, 1),	/* AUD */
+	PINS_FIELD_BASE(146, 147, 4, GPIO_IES, 0x10, 4, 1),	/* LCM_RST, DSI_TE */
+	PIN_FIELD_BASE(148, 148, 4, GPIO_IES, 0x10, 5, 1),	/* SRCLKENA0 */
+	PIN_FIELD_BASE(149, 149, 4, GPIO_IES, 0x10, 1, 1),	/* WATCHDOG */
+	PINS_FIELD_BASE(160, 162, 5, GPIO_IES, 0x10, 0, 1),	/* SIM2 */
+	PINS_FIELD_BASE(163, 165, 5, GPIO_IES, 0x10, 1, 1),	/* SIM1 */
+	PIN_FIELD_BASE(166, 166, 5, GPIO_IES, 0x10, 2, 1),	/* MSDC1_CMD */
+	PIN_FIELD_BASE(167, 167, 5, GPIO_IES, 0x10, 3, 1),	/* MSDC1_CLK */
+	PINS_FIELD_BASE(168, 171, 5, GPIO_IES, 0x10, 4, 1),	/* MSDC1_DAT */
+	PIN_FIELD_BASE(172, 172, 6, GPIO_IES, 0x10, 0, 1),	/* MSDC0_CMD */
+	PIN_FIELD_BASE(173, 173, 6, GPIO_IES, 0x10, 1, 1),	/* MSDC0_DSL */
+	PIN_FIELD_BASE(174, 174, 6, GPIO_IES, 0x10, 2, 1),	/* MSDC0_CLK */
+	PINS_FIELD_BASE(175, 182, 6, GPIO_IES, 0x10, 3, 1),	/* MSDC0_DAT */
+	PIN_FIELD_BASE(183, 183, 6, GPIO_IES, 0x10, 4, 1),	/* MSDC0_RSTB */
+	PINS_FIELD_BASE(184, 185, 6, GPIO_IES, 0x10, 5, 1),	/* FM */
+	PINS_FIELD_BASE(186, 189, 6, GPIO_IES, 0x10, 6, 1),	/* WB SPI */
+	PIN_FIELD_BASE(198, 198, 1, GPIO_IES, 0x10, 2, 1),	/* MSDC2_CMD */
+	PIN_FIELD_BASE(199, 199, 1, GPIO_IES, 0x10, 3, 1),	/* MSDC2_CLK */
+	PINS_FIELD_BASE(200, 203, 1, GPIO_IES, 0x10, 4, 1)	/* MSDC2_DAT */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_tdsel_range[] = {
+	PINS_FIELD_BASE(0, 4, 2, GPIO_TDSEL1, 0x04, 8, 4),	/* EINT0~4 */
+	PINS_FIELD_BASE(5, 8, 3, GPIO_TDSEL0, 0x04, 12, 4),	/* EINT5~8 */
+	PINS_FIELD_BASE(9, 12, 3, GPIO_TDSEL0, 0x04, 24, 4),	/* EINT9~12 */
+	PINS_FIELD_BASE(13, 18, 1, GPIO_TDSEL0, 0x04, 0, 4),	/* WB_CTRL */
+	PINS_FIELD_BASE(19, 21, 1, GPIO_TDSEL0, 0x04, 4, 4),	/* ANTSEL */
+	PINS_FIELD_BASE(42, 44, 2, GPIO_TDSEL0, 0x04, 0, 4),	/* CMPDAT */
+	PINS_FIELD_BASE(45, 46, 2, GPIO_TDSEL0, 0x04, 4, 4),	/* CMMCLK */
+	PINS_FIELD_BASE(47, 48, 2, GPIO_TDSEL0, 0x04, 8, 4),	/* I2C0 */
+	PINS_FIELD_BASE(49, 50, 2, GPIO_TDSEL0, 0x04, 12, 4),	/* I2C1 */
+	PINS_FIELD_BASE(51, 52, 2, GPIO_TDSEL0, 0x04, 16, 4),	/* I2C2 */
+	PINS_FIELD_BASE(53, 54, 2, GPIO_TDSEL0, 0x04, 20, 4),	/* I2C3 */
+	PIN_FIELD_BASE(55, 55, 2, GPIO_TDSEL0, 0x04, 24, 4),	/* SRCLKENAI */
+	PIN_FIELD_BASE(56, 56, 2, GPIO_TDSEL0, 0x04, 28, 4),	/* SRCLKENA1 */
+	PINS_FIELD_BASE(57, 60, 2, GPIO_TDSEL1, 0x04, 0, 4),	/* UART2/3 */
+	PINS_FIELD_BASE(61, 64, 2, GPIO_TDSEL1, 0x04, 4, 4),	/* PCM */
+	PINS_FIELD_BASE(65, 68, 3, GPIO_TDSEL0, 0x04, 0, 4),	/* SPI */
+	PIN_FIELD_BASE(69, 69, 3, GPIO_TDSEL0, 0x04, 4, 4),	/* DISP_PWM */
+	PINS_FIELD_BASE(70, 73, 3, GPIO_TDSEL0, 0x04, 8, 4),	/* JTAG */
+	PINS_FIELD_BASE(74, 77, 3, GPIO_TDSEL0, 0x04, 16, 4),	/* UART0/1 */
+	PINS_FIELD_BASE(78, 80, 3, GPIO_TDSEL0, 0x04, 20, 4),	/* I2S */
+	PINS_FIELD_BASE(81, 86, 3, GPIO_TDSEL0, 0x04, 28, 4),	/* KEYPAD */
+	PINS_FIELD_BASE(87, 103, 3, GPIO_TDSEL1, 0x04, 0, 4),	/* BPI5~20, C2K_TKBPI */
+	PINS_FIELD_BASE(104, 114, 3, GPIO_TDSEL1, 0x04, 4, 4),	/* RFIC0/1 */
+	PINS_FIELD_BASE(118, 136, 4, GPIO_TDSEL0, 0x04, 0, 4),	/* LTE_TXBPI, BPI0~4, BPI21~27, PAVM */
+	PIN_FIELD_BASE(137, 137, 4, GPIO_TDSEL0, 0x04, 4, 4),	/* RTC32K */
+	PINS_FIELD_BASE(138, 142, 4, GPIO_TDSEL0, 0x04, 8, 4),	/* PWRAP */
+	PINS_FIELD_BASE(143, 145, 4, GPIO_TDSEL0, 0x04, 12, 4),	/* AUD */
+	PINS_FIELD_BASE(146, 147, 4, GPIO_TDSEL0, 0x04, 16, 4),	/* LCM_RST, DSI_TE */
+	PIN_FIELD_BASE(148, 148, 4, GPIO_TDSEL0, 0x04, 20, 4),	/* SRCLKENA0 */
+	PIN_FIELD_BASE(149, 149, 4, GPIO_TDSEL0, 0x04, 4, 4),	/* WATCHDOG */
+	PINS_FIELD_BASE(160, 162, 5, GPIO_TDSEL0, 0x04, 0, 4),	/* SIM2 */
+	PINS_FIELD_BASE(163, 165, 5, GPIO_TDSEL0, 0x04, 4, 4),	/* SIM1 */
+	PIN_FIELD_BASE(166, 166, 5, GPIO_TDSEL0, 0x04, 8, 4),	/* MSDC1_CMD */
+	PIN_FIELD_BASE(167, 167, 5, GPIO_TDSEL0, 0x04, 12, 4),	/* MSDC1_CLK */
+	PINS_FIELD_BASE(168, 171, 5, GPIO_TDSEL0, 0x04, 16, 4),	/* MSDC1_DAT */
+	PIN_FIELD_BASE(172, 172, 6, GPIO_TDSEL0, 0x04, 0, 4),	/* MSDC0_CMD */
+	PIN_FIELD_BASE(173, 173, 6, GPIO_TDSEL0, 0x04, 4, 4),	/* MSDC0_DSL */
+	PIN_FIELD_BASE(174, 174, 6, GPIO_TDSEL0, 0x04, 8, 4),	/* MSDC0_CLK */
+	PINS_FIELD_BASE(175, 182, 6, GPIO_TDSEL0, 0x04, 12, 4),	/* MSDC0_DAT */
+	PIN_FIELD_BASE(183, 183, 6, GPIO_TDSEL0, 0x04, 16, 4),	/* MSDC0_RSTB */
+	PINS_FIELD_BASE(184, 185, 6, GPIO_TDSEL0, 0x04, 20, 4),	/* FM */
+	PINS_FIELD_BASE(186, 189, 6, GPIO_TDSEL0, 0x04, 24, 4),	/* WB SPI */
+	PIN_FIELD_BASE(198, 198, 1, GPIO_TDSEL0, 0x04, 8, 4),	/* MSDC2_CMD */
+	PIN_FIELD_BASE(199, 199, 1, GPIO_TDSEL0, 0x04, 12, 4),	/* MSDC2_CLK */
+	PINS_FIELD_BASE(200, 203, 1, GPIO_TDSEL0, 0x04, 16, 4)	/* MSDC2_DAT */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_rdsel_range[] = {
+	PINS_FIELD_BASE(0, 4, 2, GPIO_RDSEL1, 0x04, 8, 4),	/* EINT0~4 */
+	PINS_FIELD_BASE(5, 8, 3, GPIO_RDSEL0, 0x04, 12, 4),	/* EINT5~8 */
+	PINS_FIELD_BASE(9, 12, 3, GPIO_RDSEL0, 0x04, 24, 4),	/* EINT9~12 */
+	PINS_FIELD_BASE(13, 18, 1, GPIO_RDSEL0, 0x04, 0, 4),	/* WB_CTRL */
+	PINS_FIELD_BASE(19, 21, 1, GPIO_RDSEL0, 0x04, 4, 4),	/* ANTSEL */
+	PINS_FIELD_BASE(42, 44, 2, GPIO_RDSEL0, 0x04, 0, 4),	/* CMPDAT */
+	PINS_FIELD_BASE(45, 46, 2, GPIO_RDSEL0, 0x04, 4, 4),	/* CMMCLK */
+	PINS_FIELD_BASE(47, 48, 2, GPIO_RDSEL0, 0x04, 8, 4),	/* I2C0 */
+	PINS_FIELD_BASE(49, 50, 2, GPIO_RDSEL0, 0x04, 12, 4),	/* I2C1 */
+	PINS_FIELD_BASE(51, 52, 2, GPIO_RDSEL0, 0x04, 16, 4),	/* I2C2 */
+	PINS_FIELD_BASE(53, 54, 2, GPIO_RDSEL0, 0x04, 20, 4),	/* I2C3 */
+	PIN_FIELD_BASE(55, 55, 2, GPIO_RDSEL0, 0x04, 24, 4),	/* SRCLKENAI */
+	PIN_FIELD_BASE(56, 56, 2, GPIO_RDSEL0, 0x04, 28, 4),	/* SRCLKENA1 */
+	PINS_FIELD_BASE(57, 60, 2, GPIO_RDSEL1, 0x04, 0, 4),	/* UART2/3 */
+	PINS_FIELD_BASE(61, 64, 2, GPIO_RDSEL1, 0x04, 4, 4),	/* PCM */
+	PINS_FIELD_BASE(65, 68, 3, GPIO_RDSEL0, 0x04, 0, 4),	/* SPI */
+	PIN_FIELD_BASE(69, 69, 3, GPIO_RDSEL0, 0x04, 4, 4),	/* DISP_PWM */
+	PINS_FIELD_BASE(70, 73, 3, GPIO_RDSEL0, 0x04, 8, 4),	/* JTAG */
+	PINS_FIELD_BASE(74, 77, 3, GPIO_RDSEL0, 0x04, 16, 4),	/* UART0/1 */
+	PINS_FIELD_BASE(78, 80, 3, GPIO_RDSEL0, 0x04, 20, 4),	/* I2S */
+	PINS_FIELD_BASE(81, 86, 3, GPIO_RDSEL0, 0x04, 28, 4),	/* KEYPAD */
+	PINS_FIELD_BASE(87, 103, 3, GPIO_RDSEL1, 0x04, 0, 4),	/* BPI5~20, C2K_TKBPI */
+	PINS_FIELD_BASE(104, 114, 3, GPIO_RDSEL1, 0x04, 4, 4),	/* RFIC0/1 */
+	PINS_FIELD_BASE(118, 136, 4, GPIO_RDSEL0, 0x04, 0, 4),	/* LTE_TXBPI, BPI0~4, BPI21~27, PAVM */
+	PIN_FIELD_BASE(137, 137, 4, GPIO_RDSEL0, 0x04, 4, 4),	/* RTC32K */
+	PINS_FIELD_BASE(138, 142, 4, GPIO_RDSEL0, 0x04, 8, 4),	/* PWRAP */
+	PINS_FIELD_BASE(143, 145, 4, GPIO_RDSEL0, 0x04, 12, 4),	/* AUD */
+	PINS_FIELD_BASE(146, 147, 4, GPIO_RDSEL0, 0x04, 16, 4),	/* LCM_RST, DSI_TE */
+	PIN_FIELD_BASE(148, 148, 4, GPIO_RDSEL0, 0x04, 20, 4),	/* SRCLKENA0 */
+	PIN_FIELD_BASE(149, 149, 4, GPIO_RDSEL0, 0x04, 4, 4),	/* WATCHDOG */
+	PINS_FIELD_BASE(160, 162, 5, GPIO_RDSEL0, 0x04, 0, 4),	/* SIM2 */
+	PINS_FIELD_BASE(163, 165, 5, GPIO_RDSEL0, 0x04, 4, 4),	/* SIM1 */
+	PIN_FIELD_BASE(166, 166, 5, GPIO_RDSEL0, 0x04, 8, 4),	/* MSDC1_CMD */
+	PIN_FIELD_BASE(167, 167, 5, GPIO_RDSEL0, 0x04, 12, 4),	/* MSDC1_CLK */
+	PINS_FIELD_BASE(168, 171, 5, GPIO_RDSEL0, 0x04, 16, 4),	/* MSDC1_DAT */
+	PIN_FIELD_BASE(172, 172, 6, GPIO_RDSEL0, 0x04, 0, 4),	/* MSDC0_CMD */
+	PIN_FIELD_BASE(173, 173, 6, GPIO_RDSEL0, 0x04, 4, 4),	/* MSDC0_DSL */
+	PIN_FIELD_BASE(174, 174, 6, GPIO_RDSEL0, 0x04, 8, 4),	/* MSDC0_CLK */
+	PINS_FIELD_BASE(175, 182, 6, GPIO_RDSEL0, 0x04, 12, 4),	/* MSDC0_DAT */
+	PIN_FIELD_BASE(183, 183, 6, GPIO_RDSEL0, 0x04, 16, 4),	/* MSDC0_RSTB */
+	PINS_FIELD_BASE(184, 185, 6, GPIO_RDSEL0, 0x04, 20, 4),	/* FM */
+	PINS_FIELD_BASE(186, 189, 6, GPIO_RDSEL0, 0x04, 24, 4),	/* WB SPI */
+	PIN_FIELD_BASE(198, 198, 1, GPIO_RDSEL0, 0x04, 8, 4),	/* MSDC2_CMD */
+	PIN_FIELD_BASE(199, 199, 1, GPIO_RDSEL0, 0x04, 12, 4),	/* MSDC2_CLK */
+	PINS_FIELD_BASE(200, 203, 1, GPIO_RDSEL0, 0x04, 16, 4)	/* MSDC2_DAT */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_drv_range[] = {
+	PINS_FIELD_BASE(0, 4, 2, GPIO_DRV1, 0x04, 8, 2),	/* EINT0~4 */
+	PINS_FIELD_BASE(5, 8, 3, GPIO_DRV0, 0x04, 12, 2),	/* EINT5~8 */
+	PINS_FIELD_BASE(9, 12, 3, GPIO_DRV0, 0x04, 24, 2),	/* EINT9~12 */
+	PINS_FIELD_BASE(13, 18, 1, GPIO_DRV0, 0x04, 0, 2),	/* WB_CTRL */
+	PINS_FIELD_BASE(19, 21, 1, GPIO_DRV0, 0x04, 4, 2),	/* ANTSEL */
+	PINS_FIELD_BASE(42, 44, 2, GPIO_DRV0, 0x04, 0, 2),	/* CMPDAT */
+	PINS_FIELD_BASE(45, 46, 2, GPIO_DRV0, 0x04, 4, 3),	/* CMMCLK */
+	PINS_FIELD_BASE(47, 48, 2, GPIO_DRV0, 0x04, 8, 1),	/* I2C0 */
+	PINS_FIELD_BASE(49, 50, 2, GPIO_DRV0, 0x04, 12, 1),	/* I2C1 */
+	PINS_FIELD_BASE(51, 52, 2, GPIO_DRV0, 0x04, 16, 1),	/* I2C2 */
+	PINS_FIELD_BASE(53, 54, 2, GPIO_DRV0, 0x04, 20, 1),	/* I2C3 */
+	PIN_FIELD_BASE(55, 55, 2, GPIO_DRV0, 0x04, 24, 2),	/* SRCLKENAI */
+	PIN_FIELD_BASE(56, 56, 2, GPIO_DRV0, 0x04, 28, 2),	/* SRCLKENA1 */
+	PINS_FIELD_BASE(57, 60, 2, GPIO_DRV1, 0x04, 0, 2),	/* UART2/3 */
+	PINS_FIELD_BASE(61, 64, 2, GPIO_DRV1, 0x04, 4, 2),	/* PCM */
+	PINS_FIELD_BASE(65, 68, 3, GPIO_DRV0, 0x04, 0, 2),	/* SPI */
+	PIN_FIELD_BASE(69, 69, 3, GPIO_DRV0, 0x04, 4, 2),	/* DISP_PWM */
+	PINS_FIELD_BASE(70, 73, 3, GPIO_DRV0, 0x04, 8, 2),	/* JTAG */
+	PINS_FIELD_BASE(74, 77, 3, GPIO_DRV0, 0x04, 16, 2),	/* UART0/1 */
+	PINS_FIELD_BASE(78, 80, 3, GPIO_DRV0, 0x04, 20, 2),	/* I2S */
+	PINS_FIELD_BASE(81, 86, 3, GPIO_DRV0, 0x04, 28, 2),	/* KEYPAD */
+	PINS_FIELD_BASE(87, 103, 3, GPIO_DRV1, 0x04, 0, 2),	/* BPI5~20, C2K_TKBPI */
+	PINS_FIELD_BASE(104, 114, 3, GPIO_DRV1, 0x04, 4, 2),	/* RFIC0/1 */
+	PINS_FIELD_BASE(118, 136, 4, GPIO_DRV0, 0x04, 0, 2),	/* LTE_TXBPI, BPI0~4, BPI21~27, PAVM */
+	PIN_FIELD_BASE(137, 137, 4, GPIO_DRV0, 0x04, 4, 2),	/* RTC32K */
+	PINS_FIELD_BASE(138, 142, 4, GPIO_DRV0, 0x04, 8, 2),	/* PWRAP */
+	PINS_FIELD_BASE(143, 145, 4, GPIO_DRV0, 0x04, 12, 2),	/* AUD */
+	PINS_FIELD_BASE(146, 147, 4, GPIO_DRV0, 0x04, 16, 2),	/* LCM_RST, DSI_TE */
+	PIN_FIELD_BASE(148, 148, 4, GPIO_DRV0, 0x04, 20, 2),	/* SRCLKENA0 */
+	PIN_FIELD_BASE(149, 149, 4, GPIO_DRV0, 0x04, 4, 2),	/* WATCHDOG */
+	PINS_FIELD_BASE(160, 162, 5, GPIO_DRV0, 0x04, 0, 2),	/* SIM2 */
+	PINS_FIELD_BASE(163, 165, 5, GPIO_DRV0, 0x04, 4, 2),	/* SIM1 */
+	PIN_FIELD_BASE(166, 166, 5, GPIO_DRV0, 0x04, 8, 3),	/* MSDC1_CMD */
+	PIN_FIELD_BASE(167, 167, 5, GPIO_DRV0, 0x04, 12, 3),	/* MSDC1_CLK */
+	PINS_FIELD_BASE(168, 171, 5, GPIO_DRV0, 0x04, 16, 3),	/* MSDC1_DAT */
+	PIN_FIELD_BASE(172, 172, 6, GPIO_DRV0, 0x04, 0, 3),	/* MSDC0_CMD */
+	PIN_FIELD_BASE(173, 173, 6, GPIO_DRV0, 0x04, 4, 3),	/* MSDC0_DSL */
+	PIN_FIELD_BASE(174, 174, 6, GPIO_DRV0, 0x04, 8, 3),	/* MSDC0_CLK */
+	PINS_FIELD_BASE(175, 182, 6, GPIO_DRV0, 0x04, 12, 3),	/* MSDC0_DAT */
+	PIN_FIELD_BASE(183, 183, 6, GPIO_DRV0, 0x04, 16, 3),	/* MSDC0_RSTB */
+	PINS_FIELD_BASE(184, 185, 6, GPIO_DRV0, 0x04, 20, 2),	/* FM */
+	PINS_FIELD_BASE(186, 189, 6, GPIO_DRV0, 0x04, 24, 2),	/* WB SPI */
+	PIN_FIELD_BASE(198, 198, 1, GPIO_DRV0, 0x04, 8, 3),	/* MSDC2_CMD */
+	PIN_FIELD_BASE(199, 199, 1, GPIO_DRV0, 0x04, 12, 3),	/* MSDC2_CLK */
+	PINS_FIELD_BASE(200, 203, 1, GPIO_DRV0, 0x04, 16, 3)	/* MSDC2_DAT */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_r0_range[] = {
+	PIN_FIELD_BASE(45, 46, 2, GPIO_PUPD0, 0x10, 0, 4),	/* CMMCLK */
+	PIN_FIELD_BASE(81, 86, 3, GPIO_PUPD0, 0x10, 0, 4),	/* KEYPAD */
+	PIN_FIELD_BASE(160, 162, 5, GPIO_PUPD1, 0x10, 0, 4),	/* SIM2 */
+	PIN_FIELD_BASE(163, 165, 5, GPIO_PUPD1, 0x10, 16, 4),	/* SIM1 */
+	PIN_FIELD_BASE(166, 171, 5, GPIO_PUPD0, 0x10, 0, 4),	/* MSDC1 */
+	PIN_FIELD_BASE(172, 183, 6, GPIO_PUPD0, 0x10, 0, 4),	/* MSDC0 */
+	PIN_FIELD_BASE(198, 203, 1, GPIO_PUPD0, 0x10, 0, 4)	/* MSDC2 */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_r1_range[] = {
+	PIN_FIELD_BASE(45, 46, 2, GPIO_PUPD0, 0x10, 1, 4),	/* CMMCLK */
+	PIN_FIELD_BASE(81, 86, 3,  GPIO_PUPD0, 0x10, 1, 4),	/* KEYPAD */
+	PIN_FIELD_BASE(160, 162, 5, GPIO_PUPD1, 0x10, 1, 4),	/* SIM2 */
+	PIN_FIELD_BASE(163, 165, 5, GPIO_PUPD1, 0x10, 17, 4),	/* SIM1 */
+	PIN_FIELD_BASE(166, 171, 5, GPIO_PUPD0, 0x10, 1, 4),	/* MSDC1 */
+	PIN_FIELD_BASE(172, 183, 6, GPIO_PUPD0, 0x10, 1, 4),	/* MSDC0 */
+	PIN_FIELD_BASE(198, 203, 1, GPIO_PUPD0, 0x10, 1, 4)	/* MSDC2 */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_pupd_range[] = {
+	PIN_FIELD_BASE(45, 46, 2, GPIO_PUPD0, 0x10, 2, 4),	/* CMMCLK */
+	PIN_FIELD_BASE(81, 86, 3, GPIO_PUPD0, 0x10, 2, 4),	/* KEYPAD */
+	PIN_FIELD_BASE(160, 162, 5, GPIO_PUPD1, 0x10, 2, 4),	/* SIM2 */
+	PIN_FIELD_BASE(163, 165, 5, GPIO_PUPD1, 0x10, 18, 4),	/* SIM1 */
+	PIN_FIELD_BASE(166, 171, 5, GPIO_PUPD0, 0x10, 2, 4),	/* MSDC1 */
+	PIN_FIELD_BASE(172, 183, 6, GPIO_PUPD0, 0x10, 2, 4),	/* MSDC0 */
+	PIN_FIELD_BASE(198, 203, 1, GPIO_PUPD0, 0x10, 2, 4)	/* MSDC2 */
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_pullen_range[] = {
+	PIN_FIELD_BASE(0, 4, 2, GPIO_PULLEN0, 0x10, 23, 1),
+	PIN_FIELD_BASE(5, 8, 3, GPIO_PULLEN0, 0x10, 9, 1),
+	PIN_FIELD_BASE(9, 12, 3, GPIO_PULLEN0, 0x10, 20, 1),
+	PIN_FIELD_BASE(13, 21, 1, GPIO_PULLEN0, 0x10, 0, 1),
+	PIN_FIELD_BASE(42, 44, 2, GPIO_PULLEN0, 0x10, 0, 1),
+	PIN_FIELD_BASE(47, 64, 2, GPIO_PULLEN0, 0x10, 5, 1),
+	PIN_FIELD_BASE(65, 73, 3, GPIO_PULLEN0, 0x10, 0, 1),
+	PIN_FIELD_BASE(74, 80, 3, GPIO_PULLEN0, 0x10, 13, 1),
+	PIN_FIELD_BASE(87, 114, 3, GPIO_PULLEN0, 0x10, 30, 1),
+	PIN_FIELD_BASE(118, 149, 4, GPIO_PULLEN0, 0x10, 0, 1),
+	PIN_FIELD_BASE(184, 189, 6, GPIO_PULLEN0, 0x10, 12, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735_pin_pullsel_range[] = {
+	PIN_FIELD_BASE(0, 4, 2, GPIO_PULLSEL0, 0x10, 23, 1),
+	PIN_FIELD_BASE(5, 8, 3, GPIO_PULLSEL0, 0x10, 9, 1),
+	PIN_FIELD_BASE(9, 12, 3, GPIO_PULLSEL0, 0x10, 20, 1),
+	PIN_FIELD_BASE(13, 21, 1, GPIO_PULLSEL0, 0x10, 0, 1),
+	PIN_FIELD_BASE(42, 44, 2, GPIO_PULLSEL0, 0x10, 0, 1),
+	PIN_FIELD_BASE(47, 64, 2, GPIO_PULLSEL0, 0x10, 5, 1),
+	PIN_FIELD_BASE(65, 73, 3, GPIO_PULLSEL0, 0x10, 0, 1),
+	PIN_FIELD_BASE(74, 80, 3, GPIO_PULLSEL0, 0x10, 13, 1),
+	PIN_FIELD_BASE(87, 114, 3, GPIO_PULLSEL0, 0x10, 30, 1),
+	PIN_FIELD_BASE(118, 149, 4, GPIO_PULLSEL0, 0x10, 0, 1),
+	PIN_FIELD_BASE(184, 189, 6, GPIO_PULLSEL0, 0x10, 12, 1)
+};
+
+static const struct mtk_pin_reg_calc mt6735_reg_cals[] = {
+	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt6735_pin_dir_range),
+	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt6735_pin_di_range),
+	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt6735_pin_do_range),
+	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt6735_pin_mode_range),
+	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt6735_pin_smt_range),
+	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt6735_pin_ies_range),
+	[PINCTRL_PIN_REG_TDSEL] = MTK_RANGE(mt6735_pin_tdsel_range),
+	[PINCTRL_PIN_REG_RDSEL] = MTK_RANGE(mt6735_pin_rdsel_range),
+	[PINCTRL_PIN_REG_DRV] = MTK_RANGE(mt6735_pin_drv_range),
+	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt6735_pin_r0_range),
+	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt6735_pin_r1_range),
+	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt6735_pin_pupd_range),
+	[PINCTRL_PIN_REG_PULLEN] = MTK_RANGE(mt6735_pin_pullen_range),
+	[PINCTRL_PIN_REG_PULLSEL] = MTK_RANGE(mt6735_pin_pullsel_range),
+};
+
+static const struct mtk_pin_field_calc mt6735m_pin_dir_range[] = {
+	PIN_FIELD(0, 197, GPIO_DIR, 0x10, 0, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735m_pin_di_range[] = {
+	PIN_FIELD(0, 197, GPIO_DIN, 0x10, 0, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735m_pin_do_range[] = {
+	PIN_FIELD(0, 197, GPIO_DOUT, 0x10, 0, 1)
+};
+
+static const struct mtk_pin_field_calc mt6735m_pin_mode_range[] = {
+	PIN_FIELD(0, 4, GPIO_MODE1, 0x10, 0, 3),
+	PIN_FIELD(5, 9, GPIO_MODE1, 0x10, 16, 3),
+	PIN_FIELD(10, 14, GPIO_MODE2, 0x10, 0, 3),
+	PIN_FIELD(15, 19, GPIO_MODE2, 0x10, 16, 3),
+	PIN_FIELD(20, 24, GPIO_MODE3, 0x10, 0, 3),
+	PIN_FIELD(25, 29, GPIO_MODE3, 0x10, 16, 3),
+	PIN_FIELD(30, 34, GPIO_MODE4, 0x10, 0, 3),
+	PIN_FIELD(35, 39, GPIO_MODE4, 0x10, 16, 3),
+	PIN_FIELD(40, 44, GPIO_MODE5, 0x10, 0, 3),
+	PIN_FIELD(45, 49, GPIO_MODE5, 0x10, 16, 3),
+	PIN_FIELD(50, 54, GPIO_MODE6, 0x10, 0, 3),
+	PIN_FIELD(55, 59, GPIO_MODE6, 0x10, 16, 3),
+	PIN_FIELD(60, 64, GPIO_MODE7, 0x10, 0, 3),
+	PIN_FIELD(65, 69, GPIO_MODE7, 0x10, 16, 3),
+	PIN_FIELD(70, 74, GPIO_MODE8, 0x10, 0, 3),
+	PIN_FIELD(75, 79, GPIO_MODE8, 0x10, 16, 3),
+	PIN_FIELD(80, 84, GPIO_MODE9, 0x10, 0, 3),
+	PIN_FIELD(85, 89, GPIO_MODE9, 0x10, 16, 3),
+	PIN_FIELD(90, 94, GPIO_MODE10, 0x10, 0, 3),
+	PIN_FIELD(95, 99, GPIO_MODE10, 0x10, 16, 3),
+	PIN_FIELD(100, 104, GPIO_MODE11, 0x10, 0, 3),
+	PIN_FIELD(105, 109, GPIO_MODE11, 0x10, 16, 3),
+	PIN_FIELD(110, 114, GPIO_MODE12, 0x10, 0, 3),
+	PIN_FIELD(115, 119, GPIO_MODE12, 0x10, 16, 3),
+	PIN_FIELD(120, 124, GPIO_MODE13, 0x10, 0, 3),
+	PIN_FIELD(125, 129, GPIO_MODE13, 0x10, 16, 3),
+	PIN_FIELD(130, 134, GPIO_MODE14, 0x10, 0, 3),
+	PIN_FIELD(135, 139, GPIO_MODE14, 0x10, 16, 3),
+	PIN_FIELD(140, 144, GPIO_MODE15, 0x10, 0, 3),
+	PIN_FIELD(145, 149, GPIO_MODE15, 0x10, 16, 3),
+	PIN_FIELD(150, 154, GPIO_MODE16, 0x10, 0, 3),
+	PIN_FIELD(155, 159, GPIO_MODE16, 0x10, 16, 3),
+	PIN_FIELD(160, 164, GPIO_MODE17, 0x10, 0, 3),
+	PIN_FIELD(165, 169, GPIO_MODE17, 0x10, 16, 3),
+	PIN_FIELD(170, 174, GPIO_MODE18, 0x10, 0, 3),
+	PIN_FIELD(175, 179, GPIO_MODE18, 0x10, 16, 3),
+	PIN_FIELD(180, 184, GPIO_MODE19, 0x10, 0, 3),
+	PIN_FIELD(185, 189, GPIO_MODE19, 0x10, 16, 3),
+	PIN_FIELD(190, 194, GPIO_MODE20, 0x10, 0, 3),
+	PIN_FIELD(195, 197, GPIO_MODE20, 0x10, 16, 3),
+};
+
+/*
+ * Rather than redefining all tables for MT6735M just to remove the 6 MSDC2
+ * pins at the end, reuse the MT6735 tables and exclude the MSDC2 pin fields
+ * by subtracting their count from the array size when possible
+ */
+static const struct mtk_pin_reg_calc mt6735m_reg_cals[] = {
+	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt6735m_pin_dir_range),
+	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt6735m_pin_di_range),
+	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt6735m_pin_do_range),
+	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt6735m_pin_mode_range),
+	[PINCTRL_PIN_REG_SMT] = { mt6735_pin_smt_range,
+		ARRAY_SIZE(mt6735_pin_smt_range) - 3 },
+	[PINCTRL_PIN_REG_IES] = { mt6735_pin_ies_range,
+		ARRAY_SIZE(mt6735_pin_ies_range) - 3 },
+	[PINCTRL_PIN_REG_TDSEL] = { mt6735_pin_tdsel_range,
+		ARRAY_SIZE(mt6735_pin_tdsel_range) - 3 },
+	[PINCTRL_PIN_REG_RDSEL] = { mt6735_pin_rdsel_range,
+		ARRAY_SIZE(mt6735_pin_rdsel_range) - 3 },
+	[PINCTRL_PIN_REG_DRV] = { mt6735_pin_drv_range,
+		ARRAY_SIZE(mt6735_pin_drv_range) - 3 },
+	[PINCTRL_PIN_REG_R0] = { mt6735_pin_r0_range,
+		ARRAY_SIZE(mt6735_pin_r0_range) - 1 },
+	[PINCTRL_PIN_REG_R1] = { mt6735_pin_r1_range,
+		ARRAY_SIZE(mt6735_pin_r1_range) - 1 },
+	[PINCTRL_PIN_REG_PUPD] = { mt6735_pin_pupd_range,
+		ARRAY_SIZE(mt6735_pin_pupd_range) - 1 },
+	[PINCTRL_PIN_REG_PULLEN] = MTK_RANGE(mt6735_pin_pullen_range),
+	[PINCTRL_PIN_REG_PULLSEL] = MTK_RANGE(mt6735_pin_pullsel_range),
+};
+
+static const char * const mt6735_pinctrl_register_base_names[] = {
+	"gpio", "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4", "iocfg5"
+};
+
+static const struct mtk_eint_hw mt6735_eint_hw = {
+	.port_mask = 7,
+	.ports     = 6,
+	.ap_num    = 224,
+	.db_cnt    = 16,
+};
+
+static const struct mtk_pin_soc mt6735_data = {
+	.reg_cal = mt6735_reg_cals,
+	.pins = mtk_pins_mt6735,
+	.npins = ARRAY_SIZE(mtk_pins_mt6735),
+	.ngrps = ARRAY_SIZE(mtk_pins_mt6735),
+	.eint_hw = &mt6735_eint_hw,
+	.gpio_m = 0,
+	.ies_present = true,
+	.base_names = mt6735_pinctrl_register_base_names,
+	.nbase_names = ARRAY_SIZE(mt6735_pinctrl_register_base_names),
+	.bias_set_combo = mtk_pinconf_bias_set_combo,
+	.bias_get_combo = mtk_pinconf_bias_get_combo,
+	.drive_set = mtk_pinconf_drive_set_raw,
+	.drive_get = mtk_pinconf_drive_get_raw,
+	.adv_pull_get = mtk_pinconf_adv_pull_get,
+	.adv_pull_set = mtk_pinconf_adv_pull_set,
+};
+
+static const struct mtk_pin_soc mt6735m_data = {
+	.reg_cal = mt6735m_reg_cals,
+	.pins = mtk_pins_mt6735m,
+	.npins = ARRAY_SIZE(mtk_pins_mt6735m),
+	.ngrps = ARRAY_SIZE(mtk_pins_mt6735m),
+	.eint_hw = &mt6735_eint_hw,
+	.gpio_m = 0,
+	.ies_present = true,
+	.base_names = mt6735_pinctrl_register_base_names,
+	.nbase_names = ARRAY_SIZE(mt6735_pinctrl_register_base_names),
+	.bias_set_combo = mtk_pinconf_bias_set_combo,
+	.bias_get_combo = mtk_pinconf_bias_get_combo,
+	.drive_set = mtk_pinconf_drive_set_raw,
+	.drive_get = mtk_pinconf_drive_get_raw,
+	.adv_pull_get = mtk_pinconf_adv_pull_get,
+	.adv_pull_set = mtk_pinconf_adv_pull_set,
+};
+
+static const struct of_device_id mt6735_pinctrl_match[] = {
+	{ .compatible = "mediatek,mt6735-pinctrl", .data = &mt6735_data },
+	{ .compatible = "mediatek,mt6735m-pinctrl", .data = &mt6735m_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mt6735_pinctrl_match);
+
+static struct platform_driver mt6735_pinctrl_driver = {
+	.probe = mtk_paris_pinctrl_probe,
+	.driver = {
+		.name = "mt6735-pinctrl",
+		.of_match_table = mt6735_pinctrl_match,
+		.pm = &mtk_paris_pinctrl_pm_ops,
+	},
+};
+module_platform_driver(mt6735_pinctrl_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 pinctrl driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h
new file mode 100644
index 000000000000..b897153aea9e
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h
@@ -0,0 +1,3993 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#ifndef __PINCTRL_MTK_MT6735_H
+#define __PINCTRL_MTK_MT6735_H
+
+#include "pinctrl-paris.h"
+
+static const struct mtk_pin_desc mtk_pins_mt6735[] = {
+	MTK_PIN(
+		0, "GPIO0",
+		MTK_EINT_FUNCTION(0, 0),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "IDDIG"),
+		MTK_FUNCTION(2, "DPI_D4"),
+		MTK_FUNCTION(3, "CLKM4"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "KCOL2"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT0")
+	),
+	MTK_PIN(
+		1, "GPIO1",
+		MTK_EINT_FUNCTION(0, 1),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "PWM2"),
+		MTK_FUNCTION(2, "DPI_D5"),
+		MTK_FUNCTION(3, "MD_EINT0"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(5, "CONN_MCU_TDO"),
+		MTK_FUNCTION(6, "PTA_RXD"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT1")
+	),
+	MTK_PIN(
+		2, "GPIO2",
+		MTK_EINT_FUNCTION(0, 2),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "CLKM0"),
+		MTK_FUNCTION(2, "DPI_D6"),
+		MTK_FUNCTION(3, "MD_EINT0"),
+		MTK_FUNCTION(4, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "CONN_MCU_DBGACK_N"),
+		MTK_FUNCTION(6, "PTA_TXD"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT2")
+	),
+	MTK_PIN(
+		3, "GPIO3",
+		MTK_EINT_FUNCTION(0, 3),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "CLKM1"),
+		MTK_FUNCTION(2, "DPI_D7"),
+		MTK_FUNCTION(3, "SPI_MIB"),
+		MTK_FUNCTION(4, "MD_EINT0"),
+		MTK_FUNCTION(5, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(6, "CONN_MCU_AICE_TMSC"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT3")
+	),
+	MTK_PIN(
+		4, "GPIO4",
+		MTK_EINT_FUNCTION(0, 4),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "CLKM2"),
+		MTK_FUNCTION(2, "DPI_D8"),
+		MTK_FUNCTION(3, "SPI_MOB"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "CONN_MCU_TCK[0]"),
+		MTK_FUNCTION(6, "CONN_MCU_AICE_TCKC"),
+		MTK_FUNCTION(7, "C2K_DM_EINT0")
+	),
+	MTK_PIN(
+		5, "GPIO5",
+		MTK_EINT_FUNCTION(0, 5),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "UCTS2"),
+		MTK_FUNCTION(2, "DPI_D9"),
+		MTK_FUNCTION(3, "SPI_CSB"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(5, "CONN_MCU_TDI"),
+		MTK_FUNCTION(6, "I2S1_DO"),
+		MTK_FUNCTION(7, "MD_URXD")
+	),
+	MTK_PIN(
+		6, "GPIO6",
+		MTK_EINT_FUNCTION(0, 6),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "URTS2"),
+		MTK_FUNCTION(2, "DPI_D10"),
+		MTK_FUNCTION(3, "SPI_CKB"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "CONN_MCU_TRST_B"),
+		MTK_FUNCTION(6, "I2S1_LRCK"),
+		MTK_FUNCTION(7, "MD_UTXD")
+	),
+	MTK_PIN(
+		7, "GPIO7",
+		MTK_EINT_FUNCTION(0, 7),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "UCTS3"),
+		MTK_FUNCTION(2, "DPI_D11"),
+		MTK_FUNCTION(3, "SDA1"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "CONN_MCU_TMS"),
+		MTK_FUNCTION(6, "I2S1_BCK"),
+		MTK_FUNCTION(7, "TDD_TXD")
+	),
+	MTK_PIN(
+		8, "GPIO8",
+		MTK_EINT_FUNCTION(0, 8),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "URTS3"),
+		MTK_FUNCTION(2, "C2K_UIM0_HOT_PLUG_IN"),
+		MTK_FUNCTION(3, "SCL1"),
+		MTK_FUNCTION(4, "PCM1_DO1"),
+		MTK_FUNCTION(5, "MD_EINT1"),
+		MTK_FUNCTION(6, "KCOL4"),
+		MTK_FUNCTION(7, "UTXD0")
+	),
+	MTK_PIN(
+		9, "GPIO9",
+		MTK_EINT_FUNCTION(0, 9),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "C2K_UIM1_HOT_PLUG_IN"),
+		MTK_FUNCTION(2, "PCM1_DO0"),
+		MTK_FUNCTION(3, "I2S3_MCK"),
+		MTK_FUNCTION(4, "MD_EINT2"),
+		MTK_FUNCTION(5, "CLKM2"),
+		MTK_FUNCTION(6, "I2S1_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_A29")
+	),
+	MTK_PIN(
+		10, "GPIO10",
+		MTK_EINT_FUNCTION(0, 10),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(1, "PWM1"),
+		MTK_FUNCTION(2, "CLKM1"),
+		MTK_FUNCTION(3, "KROW2"),
+		MTK_FUNCTION(4, "MD_EINT0"),
+		MTK_FUNCTION(5, "I2S1_MCK"),
+		MTK_FUNCTION(6, "SDA3"),
+		MTK_FUNCTION(7, "DBG_MON_A30")
+	),
+	MTK_PIN(
+		11, "GPIO11",
+		MTK_EINT_FUNCTION(0, 11),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(1, "MD_EINT1"),
+		MTK_FUNCTION(2, "IRTX_OUT"),
+		MTK_FUNCTION(3, "C2K_UIM0_HOT_PLUG_IN"),
+		MTK_FUNCTION(4, "CLKM0"),
+		MTK_FUNCTION(5, "I2S2_MCK"),
+		MTK_FUNCTION(6, "SCL3"),
+		MTK_FUNCTION(7, "URXD0")
+	),
+	MTK_PIN(
+		12, "GPIO12",
+		MTK_EINT_FUNCTION(0, 12),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(1, "I2S0_MCK"),
+		MTK_FUNCTION(2, "C2K_UIM1_HOT_PLUG_IN"),
+		MTK_FUNCTION(3, "KCOL2"),
+		MTK_FUNCTION(4, "MD_EINT2"),
+		MTK_FUNCTION(5, "IRTX_OUT"),
+		MTK_FUNCTION(6, "SRCLKENAI2"),
+		MTK_FUNCTION(7, "PCM1_DO1")
+	),
+	MTK_PIN(
+		13, "GPIO13",
+		MTK_EINT_FUNCTION(0, 13),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(1, "WB_CTRL0"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT0"),
+		MTK_FUNCTION(7, "DBG_MON_A0")
+	),
+	MTK_PIN(
+		14, "GPIO14",
+		MTK_EINT_FUNCTION(0, 14),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(1, "WB_CTRL1"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT1"),
+		MTK_FUNCTION(7, "DBG_MON_A1")
+	),
+	MTK_PIN(
+		15, "GPIO15",
+		MTK_EINT_FUNCTION(0, 15),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(1, "WB_CTRL2"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT2"),
+		MTK_FUNCTION(7, "DBG_MON_A2")
+	),
+	MTK_PIN(
+		16, "GPIO16",
+		MTK_EINT_FUNCTION(0, 16),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "WB_CTRL3"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT3"),
+		MTK_FUNCTION(7, "DBG_MON_A3")
+	),
+	MTK_PIN(
+		17, "GPIO17",
+		MTK_EINT_FUNCTION(0, 17),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "WB_CTRL4"),
+		MTK_FUNCTION(3, "C2K_DM_EINT0"),
+		MTK_FUNCTION(4, "WATCHDOG"),
+		MTK_FUNCTION(7, "DBG_MON_A4")
+	),
+	MTK_PIN(
+		18, "GPIO18",
+		MTK_EINT_FUNCTION(0, 18),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "WB_CTRL5"),
+		MTK_FUNCTION(3, "C2K_DM_EINT1"),
+		MTK_FUNCTION(7, "DBG_MON_A5")
+	),
+	MTK_PIN(
+		19, "GPIO19",
+		MTK_EINT_FUNCTION(0, 19),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "ANT_SEL0"),
+		MTK_FUNCTION(2, "IRTX_OUT"),
+		MTK_FUNCTION(3, "IRDA_TX"),
+		MTK_FUNCTION(4, "C2K_UART0_TXD"),
+		MTK_FUNCTION(5, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(6, "LTE_UTXD"),
+		MTK_FUNCTION(7, "DBG_MON_A6")
+	),
+	MTK_PIN(
+		20, "GPIO20",
+		MTK_EINT_FUNCTION(0, 20),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "ANT_SEL1"),
+		MTK_FUNCTION(2, "C2K_UIM1_HOT_PLUG_IN"),
+		MTK_FUNCTION(3, "IRDA_RX"),
+		MTK_FUNCTION(4, "C2K_UART0_RXD"),
+		MTK_FUNCTION(5, "MD_EINT2"),
+		MTK_FUNCTION(6, "LTE_URXD"),
+		MTK_FUNCTION(7, "DBG_MON_A7")
+	),
+	MTK_PIN(
+		21, "GPIO21",
+		MTK_EINT_FUNCTION(0, 21),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "ANT_SEL2"),
+		MTK_FUNCTION(2, "PWM2"),
+		MTK_FUNCTION(3, "IRDA_PDN"),
+		MTK_FUNCTION(4, "CORESONIC_SWCK"),
+		MTK_FUNCTION(5, "MD_EINT1"),
+		MTK_FUNCTION(6, "C2K_UIM0_HOT_PLUG_IN"),
+		MTK_FUNCTION(7, "DBG_MON_A8")
+	),
+	MTK_PIN(
+		22, "GPIO22",
+		MTK_EINT_FUNCTION(0, 22),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "RDN0")
+	),
+	MTK_PIN(
+		23, "GPIO23",
+		MTK_EINT_FUNCTION(0, 23),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "RDP0")
+	),
+	MTK_PIN(
+		24, "GPIO24",
+		MTK_EINT_FUNCTION(0, 24),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "RDN1")
+	),
+	MTK_PIN(
+		25, "GPIO25",
+		MTK_EINT_FUNCTION(0, 25),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "RDP1")
+	),
+	MTK_PIN(
+		26, "GPIO26",
+		MTK_EINT_FUNCTION(0, 26),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "RCN")
+	),
+	MTK_PIN(
+		27, "GPIO27",
+		MTK_EINT_FUNCTION(0, 27),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "RCP")
+	),
+	MTK_PIN(
+		28, "GPIO28",
+		MTK_EINT_FUNCTION(0, 28),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "RDN2")
+	),
+	MTK_PIN(
+		29, "GPIO29",
+		MTK_EINT_FUNCTION(0, 29),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "RDP2")
+	),
+	MTK_PIN(
+		30, "GPIO30",
+		MTK_EINT_FUNCTION(0, 30),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "RDN3")
+	),
+	MTK_PIN(
+		31, "GPIO31",
+		MTK_EINT_FUNCTION(0, 31),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "RDP3")
+	),
+	MTK_PIN(
+		32, "GPIO32",
+		MTK_EINT_FUNCTION(0, 32),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "RDN0_A"),
+		MTK_FUNCTION(2, "CMHSYNC"),
+		MTK_FUNCTION(3, "CMCSD0")
+	),
+	MTK_PIN(
+		33, "GPIO33",
+		MTK_EINT_FUNCTION(0, 33),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, "RDP0_A"),
+		MTK_FUNCTION(2, "CMVSYNC"),
+		MTK_FUNCTION(3, "CMCSD1")
+	),
+	MTK_PIN(
+		34, "GPIO34",
+		MTK_EINT_FUNCTION(0, 34),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, "RDN1_A"),
+		MTK_FUNCTION(2, "CMDAT9"),
+		MTK_FUNCTION(3, "CMCSD2")
+	),
+	MTK_PIN(
+		35, "GPIO35",
+		MTK_EINT_FUNCTION(0, 35),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, "RDP1_A"),
+		MTK_FUNCTION(2, "CMDAT8"),
+		MTK_FUNCTION(3, "CMCSD3")
+	),
+	MTK_PIN(
+		36, "GPIO36",
+		MTK_EINT_FUNCTION(0, 36),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, "RCN_A"),
+		MTK_FUNCTION(2, "CMDAT7")
+	),
+	MTK_PIN(
+		37, "GPIO37",
+		MTK_EINT_FUNCTION(0, 37),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "RCP_A"),
+		MTK_FUNCTION(2, "CMDAT6")
+	),
+	MTK_PIN(
+		38, "GPIO38",
+		MTK_EINT_FUNCTION(0, 38),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(1, "RDN2_A"),
+		MTK_FUNCTION(2, "CMDAT5")
+	),
+	MTK_PIN(
+		39, "GPIO39",
+		MTK_EINT_FUNCTION(0, 39),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "RDP2_A"),
+		MTK_FUNCTION(2, "CMDAT4")
+	),
+	MTK_PIN(
+		40, "GPIO40",
+		MTK_EINT_FUNCTION(0, 40),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "RDN3_A"),
+		MTK_FUNCTION(2, "CMDAT3")
+	),
+	MTK_PIN(
+		41, "GPIO41",
+		MTK_EINT_FUNCTION(0, 41),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "RDP3_A"),
+		MTK_FUNCTION(2, "CMDAT2")
+	),
+	MTK_PIN(
+		42, "GPIO42",
+		MTK_EINT_FUNCTION(0, 42),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "CMDAT0"),
+		MTK_FUNCTION(2, "CMCSD0"),
+		MTK_FUNCTION(3, "CMMCLK1"),
+		MTK_FUNCTION(5, "ANT_SEL5"),
+		MTK_FUNCTION(6, "CLKM5"),
+		MTK_FUNCTION(7, "DBG_MON_A9")
+	),
+	MTK_PIN(
+		43, "GPIO43",
+		MTK_EINT_FUNCTION(0, 43),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "CMDAT1"),
+		MTK_FUNCTION(2, "CMCSD1"),
+		MTK_FUNCTION(3, "CMFLASH"),
+		MTK_FUNCTION(4, "MD_EINT0"),
+		MTK_FUNCTION(5, "CMMCLK1"),
+		MTK_FUNCTION(6, "CLKM4"),
+		MTK_FUNCTION(7, "DBG_MON_A10")
+	),
+	MTK_PIN(
+		44, "GPIO44",
+		MTK_EINT_FUNCTION(0, 44),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "CMPCLK"),
+		MTK_FUNCTION(2, "CMCSK"),
+		MTK_FUNCTION(3, "CMCSD2"),
+		MTK_FUNCTION(4, "KCOL3"),
+		MTK_FUNCTION(5, "SRCLKENAI2"),
+		MTK_FUNCTION(6, "PWM0"),
+		MTK_FUNCTION(7, "DBG_MON_A11")
+	),
+	MTK_PIN(
+		45, "GPIO45",
+		MTK_EINT_FUNCTION(0, 45),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "CMMCLK0"),
+		MTK_FUNCTION(7, "DBG_MON_A12")
+	),
+	MTK_PIN(
+		46, "GPIO46",
+		MTK_EINT_FUNCTION(0, 46),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "CMMCLK1"),
+		MTK_FUNCTION(2, "IDDIG"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "DM_JTINTP"),
+		MTK_FUNCTION(6, "KCOL6"),
+		MTK_FUNCTION(7, "DBG_MON_A13")
+	),
+	MTK_PIN(
+		47, "GPIO47",
+		MTK_EINT_FUNCTION(0, 47),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "SDA0")
+	),
+	MTK_PIN(
+		48, "GPIO48",
+		MTK_EINT_FUNCTION(0, 48),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "SCL0")
+	),
+	MTK_PIN(
+		49, "GPIO49",
+		MTK_EINT_FUNCTION(0, 49),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "SDA1")
+	),
+	MTK_PIN(
+		50, "GPIO50",
+		MTK_EINT_FUNCTION(0, 50),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "SCL1")
+	),
+	MTK_PIN(
+		51, "GPIO51",
+		MTK_EINT_FUNCTION(0, 51),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "SDA2")
+	),
+	MTK_PIN(
+		52, "GPIO52",
+		MTK_EINT_FUNCTION(0, 52),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "SCL2")
+	),
+	MTK_PIN(
+		53, "GPIO53",
+		MTK_EINT_FUNCTION(0, 53),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "SDA3"),
+		MTK_FUNCTION(3, "IDDIG"),
+		MTK_FUNCTION(5, "MD_EINT2"),
+		MTK_FUNCTION(6, "C2K_UIM1_HOT_PLUG_IN")
+	),
+	MTK_PIN(
+		54, "GPIO54",
+		MTK_EINT_FUNCTION(0, 54),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "SCL3"),
+		MTK_FUNCTION(3, "IDDIG"),
+		MTK_FUNCTION(5, "MD_EINT1"),
+		MTK_FUNCTION(6, "C2K_UIM0_HOT_PLUG_IN")
+	),
+	MTK_PIN(
+		55, "GPIO55",
+		MTK_EINT_FUNCTION(0, 55),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "SRCLKENAI0"),
+		MTK_FUNCTION(2, "PWM2"),
+		MTK_FUNCTION(3, "CLKM5"),
+		MTK_FUNCTION(4, "CORESONIC_SWD"),
+		MTK_FUNCTION(5, "ANT_SEL6"),
+		MTK_FUNCTION(6, "KROW5"),
+		MTK_FUNCTION(7, "DISP_PWM")
+	),
+	MTK_PIN(
+		56, "GPIO56",
+		MTK_EINT_FUNCTION(0, 56),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "SRCLKENA1")
+	),
+	MTK_PIN(
+		57, "GPIO57",
+		MTK_EINT_FUNCTION(0, 57),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "DPI_HSYNC0"),
+		MTK_FUNCTION(3, "UTXD2"),
+		MTK_FUNCTION(4, "MD_URXD"),
+		MTK_FUNCTION(5, "SRCLKENAI1"),
+		MTK_FUNCTION(6, "KROW4"),
+		MTK_FUNCTION(7, "DBG_MON_A14")
+	),
+	MTK_PIN(
+		58, "GPIO58",
+		MTK_EINT_FUNCTION(0, 58),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "DPI_VSYNC0"),
+		MTK_FUNCTION(3, "URXD2"),
+		MTK_FUNCTION(4, "MD_UTXD"),
+		MTK_FUNCTION(5, "TDD_TXD"),
+		MTK_FUNCTION(6, "KROW5"),
+		MTK_FUNCTION(7, "DBG_MON_A15")
+	),
+	MTK_PIN(
+		59, "GPIO59",
+		MTK_EINT_FUNCTION(0, 59),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "URXD3"),
+		MTK_FUNCTION(2, "DPI_CK0"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(4, "UCTS2"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "KROW6"),
+		MTK_FUNCTION(7, "DBG_MON_A16")
+	),
+	MTK_PIN(
+		60, "GPIO60",
+		MTK_EINT_FUNCTION(0, 60),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "UTXD3"),
+		MTK_FUNCTION(2, "DPI_DE0"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(4, "URTS2"),
+		MTK_FUNCTION(5, "PWM4"),
+		MTK_FUNCTION(6, "KROW7"),
+		MTK_FUNCTION(7, "DBG_MON_A17")
+	),
+	MTK_PIN(
+		61, "GPIO61",
+		MTK_EINT_FUNCTION(0, 61),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "DPI_D0"),
+		MTK_FUNCTION(3, "I2S0_BCK"),
+		MTK_FUNCTION(4, "KROW4"),
+		MTK_FUNCTION(5, "ANT_SEL3"),
+		MTK_FUNCTION(6, "IRTX_OUT"),
+		MTK_FUNCTION(7, "DBG_MON_A18")
+	),
+	MTK_PIN(
+		62, "GPIO62",
+		MTK_EINT_FUNCTION(0, 62),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "DPI_D1"),
+		MTK_FUNCTION(3, "I2S0_LRCK"),
+		MTK_FUNCTION(4, "KCOL7"),
+		MTK_FUNCTION(5, "CLKM3"),
+		MTK_FUNCTION(6, "CMFLASH"),
+		MTK_FUNCTION(7, "DBG_MON_A19")
+	),
+	MTK_PIN(
+		63, "GPIO63",
+		MTK_EINT_FUNCTION(0, 63),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "DPI_D2"),
+		MTK_FUNCTION(3, "I2S0_DI"),
+		MTK_FUNCTION(4, "PCM1_DO0"),
+		MTK_FUNCTION(5, "CLKM5"),
+		MTK_FUNCTION(6, "KROW3"),
+		MTK_FUNCTION(7, "DBG_MON_A20")
+	),
+	MTK_PIN(
+		64, "GPIO64",
+		MTK_EINT_FUNCTION(0, 64),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "PCM1_DO0"),
+		MTK_FUNCTION(2, "DPI_D3"),
+		MTK_FUNCTION(3, "I2S0_MCK"),
+		MTK_FUNCTION(4, "PCM1_DI"),
+		MTK_FUNCTION(5, "SRCLKENAI2"),
+		MTK_FUNCTION(6, "KCOL5"),
+		MTK_FUNCTION(7, "DBG_MON_A21")
+	),
+	MTK_PIN(
+		65, "GPIO65",
+		MTK_EINT_FUNCTION(0, 65),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "SPI_CSA"),
+		MTK_FUNCTION(2, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(3, "I2S3_MCK"),
+		MTK_FUNCTION(4, "KROW2"),
+		MTK_FUNCTION(5, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(6, "PTA_RXD"),
+		MTK_FUNCTION(7, "DBG_MON_A22")
+	),
+	MTK_PIN(
+		66, "GPIO66",
+		MTK_EINT_FUNCTION(0, 66),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "SPI_CKA"),
+		MTK_FUNCTION(2, "USB_DRVVBUS"),
+		MTK_FUNCTION(3, "I2S3_BCK"),
+		MTK_FUNCTION(4, "KCOL2"),
+		MTK_FUNCTION(6, "PTA_TXD"),
+		MTK_FUNCTION(7, "DBG_MON_A23")
+	),
+	MTK_PIN(
+		67, "GPIO67",
+		MTK_EINT_FUNCTION(0, 67),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(1, "SPI_MIA"),
+		MTK_FUNCTION(2, "SPI_MOA"),
+		MTK_FUNCTION(3, "I2S3_DO"),
+		MTK_FUNCTION(4, "PTA_RXD"),
+		MTK_FUNCTION(5, "IDDIG"),
+		MTK_FUNCTION(6, "UCTS1"),
+		MTK_FUNCTION(7, "DBG_MON_A24")
+	),
+	MTK_PIN(
+		68, "GPIO68",
+		MTK_EINT_FUNCTION(0, 68),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "SPI_MOA"),
+		MTK_FUNCTION(2, "SPI_MIA"),
+		MTK_FUNCTION(3, "I2S3_LRCK"),
+		MTK_FUNCTION(4, "PTA_TXD"),
+		MTK_FUNCTION(5, "ANT_SEL4"),
+		MTK_FUNCTION(6, "URTS1"),
+		MTK_FUNCTION(7, "DBG_MON_A25")
+	),
+	MTK_PIN(
+		69, "GPIO69",
+		MTK_EINT_FUNCTION(0, 69),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "DISP_PWM"),
+		MTK_FUNCTION(2, "PWM1"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "ANT_SEL7"),
+		MTK_FUNCTION(6, "DM_JTINTP")
+	),
+	MTK_PIN(
+		70, "GPIO70",
+		MTK_EINT_FUNCTION(0, 70),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO70"),
+		MTK_FUNCTION(1, "JTMS"),
+		MTK_FUNCTION(2, "CONN_MCU_TMS"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "CORESONIC_SWD"),
+		MTK_FUNCTION(6, "DM_OTMS"),
+		MTK_FUNCTION(7, "DFD_TMS")
+	),
+	MTK_PIN(
+		71, "GPIO71",
+		MTK_EINT_FUNCTION(0, 71),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "JTCK"),
+		MTK_FUNCTION(2, "CONN_MCU_TCK[1]"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "CORESONIC_SWCK"),
+		MTK_FUNCTION(6, "DM_OTCK"),
+		MTK_FUNCTION(7, "DFD_TCK_XI")
+	),
+	MTK_PIN(
+		72, "GPIO72",
+		MTK_EINT_FUNCTION(0, 72),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "JTDI"),
+		MTK_FUNCTION(2, "CONN_MCU_TDI"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(6, "DM_OTDI"),
+		MTK_FUNCTION(7, "DFD_TDI")
+	),
+	MTK_PIN(
+		73, "GPIO73",
+		MTK_EINT_FUNCTION(0, 73),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "JTDO"),
+		MTK_FUNCTION(2, "CONN_MCU_TDO"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(6, "DM_OTDO"),
+		MTK_FUNCTION(7, "DFD_TDO")
+	),
+	MTK_PIN(
+		74, "GPIO74",
+		MTK_EINT_FUNCTION(0, 74),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "URXD0"),
+		MTK_FUNCTION(2, "UTXD0"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "SDA3"),
+		MTK_FUNCTION(5, "C2K_UART0_RXD"),
+		MTK_FUNCTION(6, "LTE_URXD"),
+		MTK_FUNCTION(7, "AUXIF_ST")
+	),
+	MTK_PIN(
+		75, "GPIO75",
+		MTK_EINT_FUNCTION(0, 75),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "UTXD0"),
+		MTK_FUNCTION(2, "URXD0"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "TDD_TXD"),
+		MTK_FUNCTION(5, "C2K_UART0_TXD"),
+		MTK_FUNCTION(6, "LTE_UTXD")
+	),
+	MTK_PIN(
+		76, "GPIO76",
+		MTK_EINT_FUNCTION(0, 76),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "UTXD1"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "SCL3"),
+		MTK_FUNCTION(5, "LTE_URXD"),
+		MTK_FUNCTION(6, "C2K_UART0_RXD"),
+		MTK_FUNCTION(7, "AUXIF_CLK")
+	),
+	MTK_PIN(
+		77, "GPIO77",
+		MTK_EINT_FUNCTION(0, 77),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "URXD1"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "TDD_TXD"),
+		MTK_FUNCTION(5, "LTE_UTXD"),
+		MTK_FUNCTION(6, "C2K_UART0_TXD")
+	),
+	MTK_PIN(
+		78, "GPIO78",
+		MTK_EINT_FUNCTION(0, 78),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "I2S0_DI"),
+		MTK_FUNCTION(2, "PCM1_DI"),
+		MTK_FUNCTION(3, "I2S3_DO"),
+		MTK_FUNCTION(4, "I2S1_DO"),
+		MTK_FUNCTION(5, "PWM0"),
+		MTK_FUNCTION(6, "I2S2_DI"),
+		MTK_FUNCTION(7, "DBG_MON_A26")
+	),
+	MTK_PIN(
+		79, "GPIO79",
+		MTK_EINT_FUNCTION(0, 79),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "I2S0_LRCK"),
+		MTK_FUNCTION(2, "PCM1_SYNC"),
+		MTK_FUNCTION(3, "I2S3_LRCK"),
+		MTK_FUNCTION(4, "I2S1_LRCK"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "I2S2_LRCK"),
+		MTK_FUNCTION(7, "DBG_MON_A27")
+	),
+	MTK_PIN(
+		80, "GPIO80",
+		MTK_EINT_FUNCTION(0, 80),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "I2S0_BCK"),
+		MTK_FUNCTION(2, "PCM1_CLK[1]"),
+		MTK_FUNCTION(3, "I2S3_BCK"),
+		MTK_FUNCTION(4, "I2S1_BCK"),
+		MTK_FUNCTION(5, "PWM4"),
+		MTK_FUNCTION(6, "I2S2_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_A28")
+	),
+	MTK_PIN(
+		81, "GPIO81",
+		MTK_EINT_FUNCTION(0, 81),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "KROW0"),
+		MTK_FUNCTION(3, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(4, "CORESONIC_SWCK"),
+		MTK_FUNCTION(5, "C2K_TCK"),
+		MTK_FUNCTION(7, "C2K_DM_EINT1")
+	),
+	MTK_PIN(
+		82, "GPIO82",
+		MTK_EINT_FUNCTION(0, 82),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "KROW1"),
+		MTK_FUNCTION(3, "CONN_MCU_TRST_B"),
+		MTK_FUNCTION(4, "CORESONIC_SWD"),
+		MTK_FUNCTION(5, "C2K_NTRST"),
+		MTK_FUNCTION(6, "USB_DRVVBUS"),
+		MTK_FUNCTION(7, "C2K_DM_EINT2")
+	),
+	MTK_PIN(
+		83, "GPIO83",
+		MTK_EINT_FUNCTION(0, 83),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "KROW2"),
+		MTK_FUNCTION(2, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "C2K_TDI"),
+		MTK_FUNCTION(7, "C2K_DM_EINT3")
+	),
+	MTK_PIN(
+		84, "GPIO84",
+		MTK_EINT_FUNCTION(0, 84),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "KCOL0"),
+		MTK_FUNCTION(2, "URTS0"),
+		MTK_FUNCTION(3, "CONN_MCU_DBGACK_N"),
+		MTK_FUNCTION(4, "SCL2"),
+		MTK_FUNCTION(5, "C2K_TDO"),
+		MTK_FUNCTION(6, "AUXIF_CLK")
+	),
+	MTK_PIN(
+		85, "GPIO85",
+		MTK_EINT_FUNCTION(0, 85),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "KCOL1"),
+		MTK_FUNCTION(2, "UCTS0"),
+		MTK_FUNCTION(3, "UCTS1"),
+		MTK_FUNCTION(4, "SDA2"),
+		MTK_FUNCTION(5, "C2K_TMS"),
+		MTK_FUNCTION(6, "AUXIF_ST"),
+		MTK_FUNCTION(7, "DBG_MON_A31")
+	),
+	MTK_PIN(
+		86, "GPIO86",
+		MTK_EINT_FUNCTION(0, 86),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "KCOL2"),
+		MTK_FUNCTION(3, "URTS1"),
+		MTK_FUNCTION(5, "C2K_RTCK"),
+		MTK_FUNCTION(7, "DBG_MON_A32")
+	),
+	MTK_PIN(
+		87, "GPIO87",
+		MTK_EINT_FUNCTION(0, 87),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "BPI_BUS5"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS5"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS5"),
+		MTK_FUNCTION(7, "DBG_MON_B0")
+	),
+	MTK_PIN(
+		88, "GPIO88",
+		MTK_EINT_FUNCTION(0, 88),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "BPI_BUS6"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS6"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS6"),
+		MTK_FUNCTION(7, "DBG_MON_B1")
+	),
+	MTK_PIN(
+		89, "GPIO89",
+		MTK_EINT_FUNCTION(0, 89),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "BPI_BUS7"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS7"),
+		MTK_FUNCTION(3, "CLKM0"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS7"),
+		MTK_FUNCTION(7, "DBG_MON_B2")
+	),
+	MTK_PIN(
+		90, "GPIO90",
+		MTK_EINT_FUNCTION(0, 90),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "BPI_BUS8"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS8"),
+		MTK_FUNCTION(3, "CLKM1"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS8"),
+		MTK_FUNCTION(7, "DBG_MON_B3")
+	),
+	MTK_PIN(
+		91, "GPIO91",
+		MTK_EINT_FUNCTION(0, 91),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO91"),
+		MTK_FUNCTION(1, "BPI_BUS9"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS9"),
+		MTK_FUNCTION(3, "CLKM2"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS9"),
+		MTK_FUNCTION(7, "DBG_MON_B4")
+	),
+	MTK_PIN(
+		92, "GPIO92",
+		MTK_EINT_FUNCTION(0, 92),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO92"),
+		MTK_FUNCTION(1, "BPI_BUS10"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS10"),
+		MTK_FUNCTION(3, "CLKM3"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS10"),
+		MTK_FUNCTION(7, "DBG_MON_B5")
+	),
+	MTK_PIN(
+		93, "GPIO93",
+		MTK_EINT_FUNCTION(0, 93),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO93"),
+		MTK_FUNCTION(1, "BPI_BUS11"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS11"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS11"),
+		MTK_FUNCTION(7, "DBG_MON_B6")
+	),
+	MTK_PIN(
+		94, "GPIO94",
+		MTK_EINT_FUNCTION(0, 94),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO94"),
+		MTK_FUNCTION(1, "BPI_BUS12"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS12"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS12"),
+		MTK_FUNCTION(7, "DBG_MON_B7")
+	),
+	MTK_PIN(
+		95, "GPIO95",
+		MTK_EINT_FUNCTION(0, 95),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO95"),
+		MTK_FUNCTION(1, "BPI_BUS13"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS13"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS13"),
+		MTK_FUNCTION(7, "DBG_MON_B8")
+	),
+	MTK_PIN(
+		96, "GPIO96",
+		MTK_EINT_FUNCTION(0, 96),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO96"),
+		MTK_FUNCTION(1, "BPI_BUS14"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS14"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS14"),
+		MTK_FUNCTION(7, "DBG_MON_B9")
+	),
+	MTK_PIN(
+		97, "GPIO97",
+		MTK_EINT_FUNCTION(0, 97),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO97"),
+		MTK_FUNCTION(1, "BPI_BUS15"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS15"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS15"),
+		MTK_FUNCTION(7, "DBG_MON_B10")
+	),
+	MTK_PIN(
+		98, "GPIO98",
+		MTK_EINT_FUNCTION(0, 98),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO98"),
+		MTK_FUNCTION(1, "BPI_BUS16"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS16"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS16"),
+		MTK_FUNCTION(7, "DBG_MON_B11")
+	),
+	MTK_PIN(
+		99, "GPIO99",
+		MTK_EINT_FUNCTION(0, 99),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO99"),
+		MTK_FUNCTION(1, "BPI_BUS17"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS17"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS17"),
+		MTK_FUNCTION(7, "DBG_MON_B12")
+	),
+	MTK_PIN(
+		100, "GPIO100",
+		MTK_EINT_FUNCTION(0, 100),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO100"),
+		MTK_FUNCTION(1, "BPI_BUS18"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS18"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS18"),
+		MTK_FUNCTION(7, "DBG_MON_B13")
+	),
+	MTK_PIN(
+		101, "GPIO101",
+		MTK_EINT_FUNCTION(0, 101),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "BPI_BUS19"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS19"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS19"),
+		MTK_FUNCTION(7, "DBG_MON_B14")
+	),
+	MTK_PIN(
+		102, "GPIO102",
+		MTK_EINT_FUNCTION(0, 102),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "BPI_BUS20"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS20"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS20"),
+		MTK_FUNCTION(7, "DBG_MON_B15")
+	),
+	MTK_PIN(
+		103, "GPIO103",
+		MTK_EINT_FUNCTION(0, 103),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "C2K_TXBPI"),
+		MTK_FUNCTION(7, "DBG_MON_B16")
+	),
+	MTK_PIN(
+		104, "GPIO104",
+		MTK_EINT_FUNCTION(0, 104),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "RFIC1_BSI_EN"),
+		MTK_FUNCTION(5, "C2K_RX_BSI_EN"),
+		MTK_FUNCTION(7, "DBG_MON_B17")
+	),
+	MTK_PIN(
+		105, "GPIO105",
+		MTK_EINT_FUNCTION(0, 105),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "RFIC1_BSI_CK"),
+		MTK_FUNCTION(5, "C2K_RX_BSI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B18")
+	),
+	MTK_PIN(
+		106, "GPIO106",
+		MTK_EINT_FUNCTION(0, 106),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D0"),
+		MTK_FUNCTION(5, "C2K_RX_BSI_DATA"),
+		MTK_FUNCTION(7, "DBG_MON_B19")
+	),
+	MTK_PIN(
+		107, "GPIO107",
+		MTK_EINT_FUNCTION(0, 107),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D1"),
+		MTK_FUNCTION(5, "C2K_TX_BSI_EN"),
+		MTK_FUNCTION(7, "DBG_MON_B20")
+	),
+	MTK_PIN(
+		108, "GPIO108",
+		MTK_EINT_FUNCTION(0, 108),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D2"),
+		MTK_FUNCTION(5, "C2K_TX_BSI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B21")
+	),
+	MTK_PIN(
+		109, "GPIO109",
+		MTK_EINT_FUNCTION(0, 109),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(5, "C2K_TX_BSI_DATA"),
+		MTK_FUNCTION(7, "DBG_MON_B22")
+	),
+	MTK_PIN(
+		110, "GPIO110",
+		MTK_EINT_FUNCTION(0, 110),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "RFIC0_BSI_EN"),
+		MTK_FUNCTION(4, "SPM_BSI_EN"),
+		MTK_FUNCTION(7, "DBG_MON_B23")
+	),
+	MTK_PIN(
+		111, "GPIO111",
+		MTK_EINT_FUNCTION(0, 111),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "RFIC0_BSI_CK"),
+		MTK_FUNCTION(4, "SPM_BSI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B24")
+	),
+	MTK_PIN(
+		112, "GPIO112",
+		MTK_EINT_FUNCTION(0, 112),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D2"),
+		MTK_FUNCTION(4, "SPM_BSI_D2"),
+		MTK_FUNCTION(7, "DBG_MON_B25")
+	),
+	MTK_PIN(
+		113, "GPIO113",
+		MTK_EINT_FUNCTION(0, 113),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D1"),
+		MTK_FUNCTION(4, "SPM_BSI_D1"),
+		MTK_FUNCTION(7, "DBG_MON_B26")
+	),
+	MTK_PIN(
+		114, "GPIO114",
+		MTK_EINT_FUNCTION(0, 114),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D0"),
+		MTK_FUNCTION(4, "SPM_BSI_D0"),
+		MTK_FUNCTION(7, "DBG_MON_B27")
+	),
+	MTK_PIN(
+		115, "GPIO115",
+		MTK_EINT_FUNCTION(0, 115),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "AUXIN0")
+	),
+	MTK_PIN(
+		116, "GPIO116",
+		MTK_EINT_FUNCTION(0, 116),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "AUXIN1")
+	),
+	MTK_PIN(
+		117, "GPIO117",
+		MTK_EINT_FUNCTION(0, 117),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "AUXIN2")
+	),
+	MTK_PIN(
+		118, "GPIO118",
+		MTK_EINT_FUNCTION(0, 118),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "TXBPI")
+	),
+	MTK_PIN(
+		119, "GPIO119",
+		MTK_EINT_FUNCTION(0, 119),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "BPI_BUS0"),
+		MTK_FUNCTION(7, "DBG_MON_B28")
+	),
+	MTK_PIN(
+		120, "GPIO120",
+		MTK_EINT_FUNCTION(0, 120),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "BPI_BUS1"),
+		MTK_FUNCTION(7, "DBG_MON_B29")
+	),
+	MTK_PIN(
+		121, "GPIO121",
+		MTK_EINT_FUNCTION(0, 121),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "BPI_BUS2"),
+		MTK_FUNCTION(7, "DBG_MON_B30")
+	),
+	MTK_PIN(
+		122, "GPIO122",
+		MTK_EINT_FUNCTION(0, 122),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "BPI_BUS3"),
+		MTK_FUNCTION(7, "DBG_MON_B31")
+	),
+	MTK_PIN(
+		123, "GPIO123",
+		MTK_EINT_FUNCTION(0, 123),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "BPI_BUS4"),
+		MTK_FUNCTION(7, "DBG_MON_B32")
+	),
+	MTK_PIN(
+		124, "GPIO124",
+		MTK_EINT_FUNCTION(0, 124),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "BPI_BUS21"),
+		MTK_FUNCTION(5, "DPI_HSYNC1"),
+		MTK_FUNCTION(6, "KCOL2"),
+		MTK_FUNCTION(7, "TDD_TXD")
+	),
+	MTK_PIN(
+		125, "GPIO125",
+		MTK_EINT_FUNCTION(0, 125),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "BPI_BUS22"),
+		MTK_FUNCTION(5, "DPI_VSYNC1"),
+		MTK_FUNCTION(6, "KROW2"),
+		MTK_FUNCTION(7, "MD_URXD")
+	),
+	MTK_PIN(
+		126, "GPIO126",
+		MTK_EINT_FUNCTION(0, 126),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "BPI_BUS23"),
+		MTK_FUNCTION(5, "DPI_CK1"),
+		MTK_FUNCTION(6, "I2S2_MCK"),
+		MTK_FUNCTION(7, "MD_UTXD")
+	),
+	MTK_PIN(
+		127, "GPIO127",
+		MTK_EINT_FUNCTION(0, 127),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "BPI_BUS24"),
+		MTK_FUNCTION(3, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "DPI_DE1"),
+		MTK_FUNCTION(6, "SRCLKENAI1"),
+		MTK_FUNCTION(7, "URXD0")
+	),
+	MTK_PIN(
+		128, "GPIO128",
+		MTK_EINT_FUNCTION(0, 128),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "BPI_BUS25"),
+		MTK_FUNCTION(3, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(5, "I2S2_DI"),
+		MTK_FUNCTION(6, "PTA_RXD"),
+		MTK_FUNCTION(7, "UTXD0")
+	),
+	MTK_PIN(
+		129, "GPIO129",
+		MTK_EINT_FUNCTION(0, 129),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "BPI_BUS26"),
+		MTK_FUNCTION(2, "DISP_PWM"),
+		MTK_FUNCTION(5, "I2S2_LRCK"),
+		MTK_FUNCTION(6, "PTA_TXD"),
+		MTK_FUNCTION(7, "LTE_URXD")
+	),
+	MTK_PIN(
+		130, "GPIO130",
+		MTK_EINT_FUNCTION(0, 130),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "BPI_BUS27"),
+		MTK_FUNCTION(5, "I2S2_BCK"),
+		MTK_FUNCTION(6, "IRTX_OUT"),
+		MTK_FUNCTION(7, "LTE_UTXD")
+	),
+	MTK_PIN(
+		131, "GPIO131",
+		MTK_EINT_FUNCTION(0, 131),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "LTE_PAVM0")
+	),
+	MTK_PIN(
+		132, "GPIO132",
+		MTK_EINT_FUNCTION(0, 132),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "LTE_PAVM1")
+	),
+	MTK_PIN(
+		133, "GPIO133",
+		MTK_EINT_FUNCTION(0, 133),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "MIPI1_SCLK")
+	),
+	MTK_PIN(
+		134, "GPIO134",
+		MTK_EINT_FUNCTION(0, 134),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "MIPI1_SDATA")
+	),
+	MTK_PIN(
+		135, "GPIO135",
+		MTK_EINT_FUNCTION(0, 135),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO135"),
+		MTK_FUNCTION(1, "MIPI0_SCLK")
+	),
+	MTK_PIN(
+		136, "GPIO136",
+		MTK_EINT_FUNCTION(0, 136),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO136"),
+		MTK_FUNCTION(1, "MIPI0_SDATA")
+	),
+	MTK_PIN(
+		137, "GPIO137",
+		MTK_EINT_FUNCTION(0, 137),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO137"),
+		MTK_FUNCTION(1, "RTC32K_CK")
+	),
+	MTK_PIN(
+		138, "GPIO138",
+		MTK_EINT_FUNCTION(0, 138),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO138"),
+		MTK_FUNCTION(1, "PWRAP_SPIDO"),
+		MTK_FUNCTION(2, "PWRAP_SPIDI")
+	),
+	MTK_PIN(
+		139, "GPIO139",
+		MTK_EINT_FUNCTION(0, 139),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO139"),
+		MTK_FUNCTION(1, "PWRAP_SPIDI"),
+		MTK_FUNCTION(2, "PWRAP_SPIDO")
+	),
+	MTK_PIN(
+		140, "GPIO140",
+		MTK_EINT_FUNCTION(0, 140),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO140"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "DM_JTINTP")
+	),
+	MTK_PIN(
+		141, "GPIO141",
+		MTK_EINT_FUNCTION(0, 141),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO141"),
+		MTK_FUNCTION(1, "PWRAP_SPICK_I")
+	),
+	MTK_PIN(
+		142, "GPIO142",
+		MTK_EINT_FUNCTION(0, 142),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO142"),
+		MTK_FUNCTION(1, "PWRAP_SPICS_B_I")
+	),
+	MTK_PIN(
+		143, "GPIO143",
+		MTK_EINT_FUNCTION(0, 143),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO143"),
+		MTK_FUNCTION(1, "AUD_CLK_MOSI")
+	),
+	MTK_PIN(
+		144, "GPIO144",
+		MTK_EINT_FUNCTION(0, 144),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO144"),
+		MTK_FUNCTION(1, "AUD_DAT_MISO"),
+		MTK_FUNCTION(3, "AUD_DAT_MOSI")
+	),
+	MTK_PIN(
+		145, "GPIO145",
+		MTK_EINT_FUNCTION(0, 145),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO145"),
+		MTK_FUNCTION(1, "AUD_DAT_MOSI"),
+		MTK_FUNCTION(3, "AUD_DAT_MISO")
+	),
+	MTK_PIN(
+		146, "GPIO146",
+		MTK_EINT_FUNCTION(0, 146),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO146"),
+		MTK_FUNCTION(1, "LCM_RST")
+	),
+	MTK_PIN(
+		147, "GPIO147",
+		MTK_EINT_FUNCTION(0, 147),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO147"),
+		MTK_FUNCTION(1, "DSI_TE")
+	),
+	MTK_PIN(
+		148, "GPIO148",
+		MTK_EINT_FUNCTION(0, 148),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO148"),
+		MTK_FUNCTION(1, "SRCLKENA")
+	),
+	MTK_PIN(
+		149, "GPIO149",
+		MTK_EINT_FUNCTION(0, 149),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO149"),
+		MTK_FUNCTION(1, "WATCHDOG")
+	),
+	MTK_PIN(
+		150, "GPIO150",
+		MTK_EINT_FUNCTION(0, 150),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO150"),
+		MTK_FUNCTION(1, "TDP0")
+	),
+	MTK_PIN(
+		151, "GPIO151",
+		MTK_EINT_FUNCTION(0, 151),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO151"),
+		MTK_FUNCTION(1, "TDN0")
+	),
+	MTK_PIN(
+		152, "GPIO152",
+		MTK_EINT_FUNCTION(0, 152),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO152"),
+		MTK_FUNCTION(1, "TDP1")
+	),
+	MTK_PIN(
+		153, "GPIO153",
+		MTK_EINT_FUNCTION(0, 153),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO153"),
+		MTK_FUNCTION(1, "TDN1")
+	),
+	MTK_PIN(
+		154, "GPIO154",
+		MTK_EINT_FUNCTION(0, 154),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO154"),
+		MTK_FUNCTION(1, "TCP")
+	),
+	MTK_PIN(
+		155, "GPIO155",
+		MTK_EINT_FUNCTION(0, 155),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO155"),
+		MTK_FUNCTION(1, "TCN")
+	),
+	MTK_PIN(
+		156, "GPIO156",
+		MTK_EINT_FUNCTION(0, 156),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO156"),
+		MTK_FUNCTION(1, "TDP2")
+	),
+	MTK_PIN(
+		157, "GPIO157",
+		MTK_EINT_FUNCTION(0, 157),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO157"),
+		MTK_FUNCTION(1, "TDN2")
+	),
+	MTK_PIN(
+		158, "GPIO158",
+		MTK_EINT_FUNCTION(0, 158),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO158"),
+		MTK_FUNCTION(1, "TDP3")
+	),
+	MTK_PIN(
+		159, "GPIO159",
+		MTK_EINT_FUNCTION(0, 159),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO159"),
+		MTK_FUNCTION(1, "TDN3")
+	),
+	MTK_PIN(
+		160, "GPIO160",
+		MTK_EINT_FUNCTION(0, 160),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO160"),
+		MTK_FUNCTION(1, "MD_SIM2_SCLK"),
+		MTK_FUNCTION(2, "MD_SIM1_SCLK"),
+		MTK_FUNCTION(3, "UIM0_CLK"),
+		MTK_FUNCTION(4, "UIM1_CLK")
+	),
+	MTK_PIN(
+		161, "GPIO161",
+		MTK_EINT_FUNCTION(0, 161),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO161"),
+		MTK_FUNCTION(1, "MD_SIM2_SRST"),
+		MTK_FUNCTION(2, "MD_SIM1_SRST"),
+		MTK_FUNCTION(3, "UIM0_RST"),
+		MTK_FUNCTION(4, "UIM1_RST")
+	),
+	MTK_PIN(
+		162, "GPIO162",
+		MTK_EINT_FUNCTION(0, 162),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO162"),
+		MTK_FUNCTION(1, "MD_SIM2_SDAT"),
+		MTK_FUNCTION(2, "MD_SIM1_SDAT"),
+		MTK_FUNCTION(3, "UIM0_IO"),
+		MTK_FUNCTION(4, "UIM1_IO")
+	),
+	MTK_PIN(
+		163, "GPIO163",
+		MTK_EINT_FUNCTION(0, 163),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO163"),
+		MTK_FUNCTION(1, "MD_SIM1_SCLK"),
+		MTK_FUNCTION(2, "MD_SIM2_SCLK"),
+		MTK_FUNCTION(3, "UIM1_CLK"),
+		MTK_FUNCTION(4, "UIM0_CLK")
+	),
+	MTK_PIN(
+		164, "GPIO164",
+		MTK_EINT_FUNCTION(0, 164),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO164"),
+		MTK_FUNCTION(1, "MD_SIM1_SRST"),
+		MTK_FUNCTION(2, "MD_SIM2_SRST"),
+		MTK_FUNCTION(3, "UIM1_RST"),
+		MTK_FUNCTION(4, "UIM0_RST")
+	),
+	MTK_PIN(
+		165, "GPIO165",
+		MTK_EINT_FUNCTION(0, 165),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO165"),
+		MTK_FUNCTION(1, "MD_SIM1_SDAT"),
+		MTK_FUNCTION(2, "MD_SIM2_SDAT"),
+		MTK_FUNCTION(3, "UIM1_IO"),
+		MTK_FUNCTION(4, "UIM0_IO")
+	),
+	MTK_PIN(
+		166, "GPIO166",
+		MTK_EINT_FUNCTION(0, 166),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO166"),
+		MTK_FUNCTION(1, "MSDC1_CMD"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(3, "C2K_TMS"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "CONN_DSP_JMS"),
+		MTK_FUNCTION(6, "JTMS"),
+		MTK_FUNCTION(7, "CONN_MCU_AICE_TMSC")
+	),
+	MTK_PIN(
+		167, "GPIO167",
+		MTK_EINT_FUNCTION(0, 167),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO167"),
+		MTK_FUNCTION(1, "MSDC1_CLK"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(3, "C2K_TCK"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "CONN_DSP_JCK"),
+		MTK_FUNCTION(6, "JTCK"),
+		MTK_FUNCTION(7, "CONN_MCU_AICE_TCKC")
+	),
+	MTK_PIN(
+		168, "GPIO168",
+		MTK_EINT_FUNCTION(0, 168),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO168"),
+		MTK_FUNCTION(1, "MSDC1_DAT0"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(3, "C2K_TDI"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(5, "CONN_DSP_JDI"),
+		MTK_FUNCTION(6, "JTDI")
+	),
+	MTK_PIN(
+		169, "GPIO169",
+		MTK_EINT_FUNCTION(0, 169),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO169"),
+		MTK_FUNCTION(1, "MSDC1_DAT1"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(3, "C2K_TDO"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(5, "CONN_DSP_JDO"),
+		MTK_FUNCTION(6, "JTDO")
+	),
+	MTK_PIN(
+		170, "GPIO170",
+		MTK_EINT_FUNCTION(0, 170),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO170"),
+		MTK_FUNCTION(1, "MSDC1_DAT2"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(3, "C2K_NTRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "CONN_DSP_JINTP"),
+		MTK_FUNCTION(6, "DM_JTINTP")
+	),
+	MTK_PIN(
+		171, "GPIO171",
+		MTK_EINT_FUNCTION(0, 171),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO171"),
+		MTK_FUNCTION(1, "MSDC1_DAT3"),
+		MTK_FUNCTION(3, "C2K_RTCK")
+	),
+	MTK_PIN(
+		172, "GPIO172",
+		MTK_EINT_FUNCTION(0, 172),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO172"),
+		MTK_FUNCTION(1, "MSDC0_CMD")
+	),
+	MTK_PIN(
+		173, "GPIO173",
+		MTK_EINT_FUNCTION(0, 173),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO173"),
+		MTK_FUNCTION(1, "MSDC0_DSL")
+	),
+	MTK_PIN(
+		174, "GPIO174",
+		MTK_EINT_FUNCTION(0, 174),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO174"),
+		MTK_FUNCTION(1, "MSDC0_CLK")
+	),
+	MTK_PIN(
+		175, "GPIO175",
+		MTK_EINT_FUNCTION(0, 175),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO175"),
+		MTK_FUNCTION(1, "MSDC0_DAT0")
+	),
+	MTK_PIN(
+		176, "GPIO176",
+		MTK_EINT_FUNCTION(0, 176),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO176"),
+		MTK_FUNCTION(1, "MSDC0_DAT1")
+	),
+	MTK_PIN(
+		177, "GPIO177",
+		MTK_EINT_FUNCTION(0, 177),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO177"),
+		MTK_FUNCTION(1, "MSDC0_DAT2")
+	),
+	MTK_PIN(
+		178, "GPIO178",
+		MTK_EINT_FUNCTION(0, 178),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO178"),
+		MTK_FUNCTION(1, "MSDC0_DAT3")
+	),
+	MTK_PIN(
+		179, "GPIO179",
+		MTK_EINT_FUNCTION(0, 179),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO179"),
+		MTK_FUNCTION(1, "MSDC0_DAT4")
+	),
+	MTK_PIN(
+		180, "GPIO180",
+		MTK_EINT_FUNCTION(0, 180),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO180"),
+		MTK_FUNCTION(1, "MSDC0_DAT5")
+	),
+	MTK_PIN(
+		181, "GPIO181",
+		MTK_EINT_FUNCTION(0, 181),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO181"),
+		MTK_FUNCTION(1, "MSDC0_DAT6")
+	),
+	MTK_PIN(
+		182, "GPIO182",
+		MTK_EINT_FUNCTION(0, 182),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO182"),
+		MTK_FUNCTION(1, "MSDC0_DAT7")
+	),
+	MTK_PIN(
+		183, "GPIO183",
+		MTK_EINT_FUNCTION(0, 183),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO183"),
+		MTK_FUNCTION(1, "MSDC0_RSTB")
+	),
+	MTK_PIN(
+		184, "GPIO184",
+		MTK_EINT_FUNCTION(0, 184),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO184"),
+		MTK_FUNCTION(1, "F2W_DATA"),
+		MTK_FUNCTION(2, "MRG_CLK"),
+		MTK_FUNCTION(3, "C2K_DM_EINT2"),
+		MTK_FUNCTION(4, "PCM0_CLK")
+	),
+	MTK_PIN(
+		185, "GPIO185",
+		MTK_EINT_FUNCTION(0, 185),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO185"),
+		MTK_FUNCTION(1, "F2W_CK"),
+		MTK_FUNCTION(2, "MRG_DI"),
+		MTK_FUNCTION(3, "C2K_DM_EINT3"),
+		MTK_FUNCTION(4, "PCM0_DI")
+	),
+	MTK_PIN(
+		186, "GPIO186",
+		MTK_EINT_FUNCTION(0, 186),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO186"),
+		MTK_FUNCTION(1, "WB_RSTB"),
+		MTK_FUNCTION(4, "URXD3"),
+		MTK_FUNCTION(5, "UTXD3")
+	),
+	MTK_PIN(
+		187, "GPIO187",
+		MTK_EINT_FUNCTION(0, 187),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO187"),
+		MTK_FUNCTION(1, "WB_SCLK"),
+		MTK_FUNCTION(2, "MRG_DO"),
+		MTK_FUNCTION(4, "PCM0_DO")
+	),
+	MTK_PIN(
+		188, "GPIO188",
+		MTK_EINT_FUNCTION(0, 188),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO188"),
+		MTK_FUNCTION(1, "WB_SDATA"),
+		MTK_FUNCTION(2, "MRG_SYNC"),
+		MTK_FUNCTION(4, "PCM0_SYNC")
+	),
+	MTK_PIN(
+		189, "GPIO189",
+		MTK_EINT_FUNCTION(0, 189),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO189"),
+		MTK_FUNCTION(1, "WB_SEN"),
+		MTK_FUNCTION(4, "UTXD3"),
+		MTK_FUNCTION(5, "URXD3")
+	),
+	MTK_PIN(
+		190, "GPIO190",
+		MTK_EINT_FUNCTION(0, 190),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO190"),
+		MTK_FUNCTION(1, "GPS_RXQN")
+	),
+	MTK_PIN(
+		191, "GPIO191",
+		MTK_EINT_FUNCTION(0, 191),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO191"),
+		MTK_FUNCTION(1, "GPS_RXQP")
+	),
+	MTK_PIN(
+		192, "GPIO192",
+		MTK_EINT_FUNCTION(0, 192),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO192"),
+		MTK_FUNCTION(1, "GPS_RXIN")
+	),
+	MTK_PIN(
+		193, "GPIO193",
+		MTK_EINT_FUNCTION(0, 193),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO193"),
+		MTK_FUNCTION(1, "GPS_RXIP")
+	),
+	MTK_PIN(
+		194, "GPIO194",
+		MTK_EINT_FUNCTION(0, 194),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO194"),
+		MTK_FUNCTION(1, "WB_RXQN")
+	),
+	MTK_PIN(
+		195, "GPIO195",
+		MTK_EINT_FUNCTION(0, 195),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO195"),
+		MTK_FUNCTION(1, "WB_RXQP")
+	),
+	MTK_PIN(
+		196, "GPIO196",
+		MTK_EINT_FUNCTION(0, 196),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO196"),
+		MTK_FUNCTION(1, "WB_RXIN")
+	),
+	MTK_PIN(
+		197, "GPIO197",
+		MTK_EINT_FUNCTION(0, 197),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO197"),
+		MTK_FUNCTION(1, "WB_RXIP")
+	),
+	MTK_PIN(
+		198, "GPIO198",
+		MTK_EINT_FUNCTION(0, 198),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO198"),
+		MTK_FUNCTION(1, "MSDC2_CMD"),
+		MTK_FUNCTION(2, "SDA1"),
+		MTK_FUNCTION(3, "C2K_UART0_RXD"),
+		MTK_FUNCTION(4, "C2K_TMS"),
+		MTK_FUNCTION(5, "ANT_SEL6"),
+		MTK_FUNCTION(7, "DM_OTMS")
+	),
+	MTK_PIN(
+		199, "GPIO199",
+		MTK_EINT_FUNCTION(0, 199),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO199"),
+		MTK_FUNCTION(1, "MSDC2_CLK"),
+		MTK_FUNCTION(2, "SCL1"),
+		MTK_FUNCTION(3, "C2K_UART0_TXD"),
+		MTK_FUNCTION(4, "C2K_TCK"),
+		MTK_FUNCTION(5, "ANT_SEL7"),
+		MTK_FUNCTION(6, "TDD_TXD"),
+		MTK_FUNCTION(7, "DM_OTCK")
+	),
+	MTK_PIN(
+		200, "GPIO200",
+		MTK_EINT_FUNCTION(0, 200),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO200"),
+		MTK_FUNCTION(1, "MSDC2_DAT0"),
+		MTK_FUNCTION(2, "ANT_SEL6"),
+		MTK_FUNCTION(3, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(4, "C2K_TDI"),
+		MTK_FUNCTION(5, "UTXD0"),
+		MTK_FUNCTION(7, "DM_OTDI")
+	),
+	MTK_PIN(
+		201, "GPIO201",
+		MTK_EINT_FUNCTION(0, 201),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO201"),
+		MTK_FUNCTION(1, "MSDC2_DAT1"),
+		MTK_FUNCTION(2, "ANT_SEL3"),
+		MTK_FUNCTION(3, "PWM0"),
+		MTK_FUNCTION(4, "C2K_TDO"),
+		MTK_FUNCTION(5, "URXD0"),
+		MTK_FUNCTION(7, "DM_OTDO")
+	),
+	MTK_PIN(
+		202, "GPIO202",
+		MTK_EINT_FUNCTION(0, 202),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO202"),
+		MTK_FUNCTION(1, "MSDC2_DAT2"),
+		MTK_FUNCTION(2, "ANT_SEL4"),
+		MTK_FUNCTION(3, "SDA2"),
+		MTK_FUNCTION(4, "C2K_NTRST"),
+		MTK_FUNCTION(5, "UTXD1"),
+		MTK_FUNCTION(6, "KCOL3"),
+		MTK_FUNCTION(7, "DM_JTINTP")
+	),
+	MTK_PIN(
+		203, "GPIO203",
+		MTK_EINT_FUNCTION(0, 203),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO203"),
+		MTK_FUNCTION(1, "MSDC2_DAT3"),
+		MTK_FUNCTION(2, "ANT_SEL5"),
+		MTK_FUNCTION(3, "SCL2"),
+		MTK_FUNCTION(4, "C2K_RTCK"),
+		MTK_FUNCTION(5, "URXD1"),
+		MTK_FUNCTION(6, "KCOL6")
+	),
+	MTK_PIN(
+		204, "GPIO204",
+		MTK_EINT_FUNCTION(0, 204),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		205, "GPIO205",
+		MTK_EINT_FUNCTION(0, 205),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		206, "GPIO206",
+		MTK_EINT_FUNCTION(0, 206),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		207, "GPIO207",
+		MTK_EINT_FUNCTION(0, 207),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		208, "GPIO208",
+		MTK_EINT_FUNCTION(0, 208),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		209, "GPIO209",
+		MTK_EINT_FUNCTION(0, 209),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		210, "GPIO210",
+		MTK_EINT_FUNCTION(0, 210),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		211, "GPIO211",
+		MTK_EINT_FUNCTION(0, 211),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		212, "GPIO212",
+		MTK_EINT_FUNCTION(0, 212),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+};
+
+static const struct mtk_pin_desc mtk_pins_mt6735m[] = {
+	MTK_PIN(
+		0, "GPIO0",
+		MTK_EINT_FUNCTION(0, 0),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "IDDIG"),
+		MTK_FUNCTION(2, "DPI_D4"),
+		MTK_FUNCTION(3, "CLKM4"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "KCOL2"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT0")
+	),
+	MTK_PIN(
+		1, "GPIO1",
+		MTK_EINT_FUNCTION(0, 1),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "PWM2"),
+		MTK_FUNCTION(2, "DPI_D5"),
+		MTK_FUNCTION(3, "MD_EINT0"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(5, "CONN_MCU_TDO"),
+		MTK_FUNCTION(6, "PTA_RXD"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT1")
+	),
+	MTK_PIN(
+		2, "GPIO2",
+		MTK_EINT_FUNCTION(0, 2),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "CLKM0"),
+		MTK_FUNCTION(2, "DPI_D6"),
+		MTK_FUNCTION(3, "MD_EINT0"),
+		MTK_FUNCTION(4, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "CONN_MCU_DBGACK_N"),
+		MTK_FUNCTION(6, "PTA_TXD"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT2")
+	),
+	MTK_PIN(
+		3, "GPIO3",
+		MTK_EINT_FUNCTION(0, 3),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "CLKM1"),
+		MTK_FUNCTION(2, "DPI_D7"),
+		MTK_FUNCTION(3, "SPI_MIB"),
+		MTK_FUNCTION(4, "MD_EINT0"),
+		MTK_FUNCTION(5, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(6, "CONN_MCU_AICE_TMSC"),
+		MTK_FUNCTION(7, "C2K_ARM_EINT3")
+	),
+	MTK_PIN(
+		4, "GPIO4",
+		MTK_EINT_FUNCTION(0, 4),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "CLKM2"),
+		MTK_FUNCTION(2, "DPI_D8"),
+		MTK_FUNCTION(3, "SPI_MOB"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "CONN_MCU_TCK[0]"),
+		MTK_FUNCTION(6, "CONN_MCU_AICE_TCKC"),
+		MTK_FUNCTION(7, "C2K_DM_EINT0")
+	),
+	MTK_PIN(
+		5, "GPIO5",
+		MTK_EINT_FUNCTION(0, 5),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "UCTS2"),
+		MTK_FUNCTION(2, "DPI_D9"),
+		MTK_FUNCTION(3, "SPI_CSB"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(5, "CONN_MCU_TDI"),
+		MTK_FUNCTION(6, "I2S1_DO"),
+		MTK_FUNCTION(7, "MD_URXD")
+	),
+	MTK_PIN(
+		6, "GPIO6",
+		MTK_EINT_FUNCTION(0, 6),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "URTS2"),
+		MTK_FUNCTION(2, "DPI_D10"),
+		MTK_FUNCTION(3, "SPI_CKB"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "CONN_MCU_TRST_B"),
+		MTK_FUNCTION(6, "I2S1_LRCK"),
+		MTK_FUNCTION(7, "MD_UTXD")
+	),
+	MTK_PIN(
+		7, "GPIO7",
+		MTK_EINT_FUNCTION(0, 7),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "UCTS3"),
+		MTK_FUNCTION(2, "DPI_D11"),
+		MTK_FUNCTION(3, "SDA1"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "CONN_MCU_TMS"),
+		MTK_FUNCTION(6, "I2S1_BCK"),
+		MTK_FUNCTION(7, "TDD_TXD")
+	),
+	MTK_PIN(
+		8, "GPIO8",
+		MTK_EINT_FUNCTION(0, 8),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "URTS3"),
+		MTK_FUNCTION(2, "C2K_UIM0_HOT_PLUG_IN"),
+		MTK_FUNCTION(3, "SCL1"),
+		MTK_FUNCTION(4, "PCM1_DO1"),
+		MTK_FUNCTION(5, "MD_EINT1"),
+		MTK_FUNCTION(6, "KCOL4"),
+		MTK_FUNCTION(7, "UTXD0")
+	),
+	MTK_PIN(
+		9, "GPIO9",
+		MTK_EINT_FUNCTION(0, 9),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "C2K_UIM1_HOT_PLUG_IN"),
+		MTK_FUNCTION(2, "PCM1_DO0"),
+		MTK_FUNCTION(3, "I2S3_MCK"),
+		MTK_FUNCTION(4, "MD_EINT2"),
+		MTK_FUNCTION(5, "CLKM2"),
+		MTK_FUNCTION(6, "I2S1_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_A29")
+	),
+	MTK_PIN(
+		10, "GPIO10",
+		MTK_EINT_FUNCTION(0, 10),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(1, "PWM1"),
+		MTK_FUNCTION(2, "CLKM1"),
+		MTK_FUNCTION(3, "KROW2"),
+		MTK_FUNCTION(4, "MD_EINT0"),
+		MTK_FUNCTION(5, "I2S1_MCK"),
+		MTK_FUNCTION(6, "SDA3"),
+		MTK_FUNCTION(7, "DBG_MON_A30")
+	),
+	MTK_PIN(
+		11, "GPIO11",
+		MTK_EINT_FUNCTION(0, 11),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(1, "MD_EINT1"),
+		MTK_FUNCTION(2, "IRTX_OUT"),
+		MTK_FUNCTION(3, "C2K_UIM0_HOT_PLUG_IN"),
+		MTK_FUNCTION(4, "CLKM0"),
+		MTK_FUNCTION(5, "I2S2_MCK"),
+		MTK_FUNCTION(6, "SCL3"),
+		MTK_FUNCTION(7, "URXD0")
+	),
+	MTK_PIN(
+		12, "GPIO12",
+		MTK_EINT_FUNCTION(0, 12),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(1, "I2S0_MCK"),
+		MTK_FUNCTION(2, "C2K_UIM1_HOT_PLUG_IN"),
+		MTK_FUNCTION(3, "KCOL2"),
+		MTK_FUNCTION(4, "MD_EINT2"),
+		MTK_FUNCTION(5, "IRTX_OUT"),
+		MTK_FUNCTION(6, "SRCLKENAI2"),
+		MTK_FUNCTION(7, "PCM1_DO1")
+	),
+	MTK_PIN(
+		13, "GPIO13",
+		MTK_EINT_FUNCTION(0, 13),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(1, "WB_CTRL0"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT0"),
+		MTK_FUNCTION(7, "DBG_MON_A0")
+	),
+	MTK_PIN(
+		14, "GPIO14",
+		MTK_EINT_FUNCTION(0, 14),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(1, "WB_CTRL1"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT1"),
+		MTK_FUNCTION(7, "DBG_MON_A1")
+	),
+	MTK_PIN(
+		15, "GPIO15",
+		MTK_EINT_FUNCTION(0, 15),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(1, "WB_CTRL2"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT2"),
+		MTK_FUNCTION(7, "DBG_MON_A2")
+	),
+	MTK_PIN(
+		16, "GPIO16",
+		MTK_EINT_FUNCTION(0, 16),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "WB_CTRL3"),
+		MTK_FUNCTION(3, "C2K_ARM_EINT3"),
+		MTK_FUNCTION(7, "DBG_MON_A3")
+	),
+	MTK_PIN(
+		17, "GPIO17",
+		MTK_EINT_FUNCTION(0, 17),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "WB_CTRL4"),
+		MTK_FUNCTION(3, "C2K_DM_EINT0"),
+		MTK_FUNCTION(4, "WATCHDOG"),
+		MTK_FUNCTION(7, "DBG_MON_A4")
+	),
+	MTK_PIN(
+		18, "GPIO18",
+		MTK_EINT_FUNCTION(0, 18),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "WB_CTRL5"),
+		MTK_FUNCTION(3, "C2K_DM_EINT1"),
+		MTK_FUNCTION(7, "DBG_MON_A5")
+	),
+	MTK_PIN(
+		19, "GPIO19",
+		MTK_EINT_FUNCTION(0, 19),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "ANT_SEL0"),
+		MTK_FUNCTION(2, "IRTX_OUT"),
+		MTK_FUNCTION(3, "IRDA_TX"),
+		MTK_FUNCTION(4, "C2K_UART0_TXD"),
+		MTK_FUNCTION(5, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(6, "LTE_UTXD"),
+		MTK_FUNCTION(7, "DBG_MON_A6")
+	),
+	MTK_PIN(
+		20, "GPIO20",
+		MTK_EINT_FUNCTION(0, 20),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "ANT_SEL1"),
+		MTK_FUNCTION(2, "C2K_UIM1_HOT_PLUG_IN"),
+		MTK_FUNCTION(3, "IRDA_RX"),
+		MTK_FUNCTION(4, "C2K_UART0_RXD"),
+		MTK_FUNCTION(5, "MD_EINT2"),
+		MTK_FUNCTION(6, "LTE_URXD"),
+		MTK_FUNCTION(7, "DBG_MON_A7")
+	),
+	MTK_PIN(
+		21, "GPIO21",
+		MTK_EINT_FUNCTION(0, 21),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "ANT_SEL2"),
+		MTK_FUNCTION(2, "PWM2"),
+		MTK_FUNCTION(3, "IRDA_PDN"),
+		MTK_FUNCTION(4, "CORESONIC_SWCK"),
+		MTK_FUNCTION(5, "MD_EINT1"),
+		MTK_FUNCTION(6, "C2K_UIM0_HOT_PLUG_IN"),
+		MTK_FUNCTION(7, "DBG_MON_A8")
+	),
+	MTK_PIN(
+		22, "GPIO22",
+		MTK_EINT_FUNCTION(0, 22),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "RDN0")
+	),
+	MTK_PIN(
+		23, "GPIO23",
+		MTK_EINT_FUNCTION(0, 23),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "RDP0")
+	),
+	MTK_PIN(
+		24, "GPIO24",
+		MTK_EINT_FUNCTION(0, 24),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "RDN1")
+	),
+	MTK_PIN(
+		25, "GPIO25",
+		MTK_EINT_FUNCTION(0, 25),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "RDP1")
+	),
+	MTK_PIN(
+		26, "GPIO26",
+		MTK_EINT_FUNCTION(0, 26),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "RCN")
+	),
+	MTK_PIN(
+		27, "GPIO27",
+		MTK_EINT_FUNCTION(0, 27),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "RCP")
+	),
+	MTK_PIN(
+		28, "GPIO28",
+		MTK_EINT_FUNCTION(0, 28),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "RDN2")
+	),
+	MTK_PIN(
+		29, "GPIO29",
+		MTK_EINT_FUNCTION(0, 29),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "RDP2")
+	),
+	MTK_PIN(
+		30, "GPIO30",
+		MTK_EINT_FUNCTION(0, 30),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "RDN3")
+	),
+	MTK_PIN(
+		31, "GPIO31",
+		MTK_EINT_FUNCTION(0, 31),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "RDP3")
+	),
+	MTK_PIN(
+		32, "GPIO32",
+		MTK_EINT_FUNCTION(0, 32),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "RDN0_A"),
+		MTK_FUNCTION(2, "CMHSYNC"),
+		MTK_FUNCTION(3, "CMCSD0")
+	),
+	MTK_PIN(
+		33, "GPIO33",
+		MTK_EINT_FUNCTION(0, 33),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, "RDP0_A"),
+		MTK_FUNCTION(2, "CMVSYNC"),
+		MTK_FUNCTION(3, "CMCSD1")
+	),
+	MTK_PIN(
+		34, "GPIO34",
+		MTK_EINT_FUNCTION(0, 34),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, "RDN1_A"),
+		MTK_FUNCTION(2, "CMDAT9"),
+		MTK_FUNCTION(3, "CMCSD2")
+	),
+	MTK_PIN(
+		35, "GPIO35",
+		MTK_EINT_FUNCTION(0, 35),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, "RDP1_A"),
+		MTK_FUNCTION(2, "CMDAT8"),
+		MTK_FUNCTION(3, "CMCSD3")
+	),
+	MTK_PIN(
+		36, "GPIO36",
+		MTK_EINT_FUNCTION(0, 36),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, "RCN_A"),
+		MTK_FUNCTION(2, "CMDAT7")
+	),
+	MTK_PIN(
+		37, "GPIO37",
+		MTK_EINT_FUNCTION(0, 37),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "RCP_A"),
+		MTK_FUNCTION(2, "CMDAT6")
+	),
+	MTK_PIN(
+		38, "GPIO38",
+		MTK_EINT_FUNCTION(0, 38),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(1, "RDN2_A"),
+		MTK_FUNCTION(2, "CMDAT5")
+	),
+	MTK_PIN(
+		39, "GPIO39",
+		MTK_EINT_FUNCTION(0, 39),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "RDP2_A"),
+		MTK_FUNCTION(2, "CMDAT4")
+	),
+	MTK_PIN(
+		40, "GPIO40",
+		MTK_EINT_FUNCTION(0, 40),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "RDN3_A"),
+		MTK_FUNCTION(2, "CMDAT3")
+	),
+	MTK_PIN(
+		41, "GPIO41",
+		MTK_EINT_FUNCTION(0, 41),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "RDP3_A"),
+		MTK_FUNCTION(2, "CMDAT2")
+	),
+	MTK_PIN(
+		42, "GPIO42",
+		MTK_EINT_FUNCTION(0, 42),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "CMDAT0"),
+		MTK_FUNCTION(2, "CMCSD0"),
+		MTK_FUNCTION(3, "CMMCLK1"),
+		MTK_FUNCTION(5, "ANT_SEL5"),
+		MTK_FUNCTION(6, "CLKM5"),
+		MTK_FUNCTION(7, "DBG_MON_A9")
+	),
+	MTK_PIN(
+		43, "GPIO43",
+		MTK_EINT_FUNCTION(0, 43),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "CMDAT1"),
+		MTK_FUNCTION(2, "CMCSD1"),
+		MTK_FUNCTION(3, "CMFLASH"),
+		MTK_FUNCTION(4, "MD_EINT0"),
+		MTK_FUNCTION(5, "CMMCLK1"),
+		MTK_FUNCTION(6, "CLKM4"),
+		MTK_FUNCTION(7, "DBG_MON_A10")
+	),
+	MTK_PIN(
+		44, "GPIO44",
+		MTK_EINT_FUNCTION(0, 44),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "CMPCLK"),
+		MTK_FUNCTION(2, "CMCSK"),
+		MTK_FUNCTION(3, "CMCSD2"),
+		MTK_FUNCTION(4, "KCOL3"),
+		MTK_FUNCTION(5, "SRCLKENAI2"),
+		MTK_FUNCTION(6, "PWM0"),
+		MTK_FUNCTION(7, "DBG_MON_A11")
+	),
+	MTK_PIN(
+		45, "GPIO45",
+		MTK_EINT_FUNCTION(0, 45),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "CMMCLK0"),
+		MTK_FUNCTION(7, "DBG_MON_A12")
+	),
+	MTK_PIN(
+		46, "GPIO46",
+		MTK_EINT_FUNCTION(0, 46),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "CMMCLK1"),
+		MTK_FUNCTION(2, "IDDIG"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "DM_JTINTP"),
+		MTK_FUNCTION(6, "KCOL6"),
+		MTK_FUNCTION(7, "DBG_MON_A13")
+	),
+	MTK_PIN(
+		47, "GPIO47",
+		MTK_EINT_FUNCTION(0, 47),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "SDA0")
+	),
+	MTK_PIN(
+		48, "GPIO48",
+		MTK_EINT_FUNCTION(0, 48),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "SCL0")
+	),
+	MTK_PIN(
+		49, "GPIO49",
+		MTK_EINT_FUNCTION(0, 49),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "SDA1")
+	),
+	MTK_PIN(
+		50, "GPIO50",
+		MTK_EINT_FUNCTION(0, 50),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "SCL1")
+	),
+	MTK_PIN(
+		51, "GPIO51",
+		MTK_EINT_FUNCTION(0, 51),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "SDA2")
+	),
+	MTK_PIN(
+		52, "GPIO52",
+		MTK_EINT_FUNCTION(0, 52),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "SCL2")
+	),
+	MTK_PIN(
+		53, "GPIO53",
+		MTK_EINT_FUNCTION(0, 53),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "SDA3"),
+		MTK_FUNCTION(3, "IDDIG"),
+		MTK_FUNCTION(5, "MD_EINT2"),
+		MTK_FUNCTION(6, "C2K_UIM1_HOT_PLUG_IN")
+	),
+	MTK_PIN(
+		54, "GPIO54",
+		MTK_EINT_FUNCTION(0, 54),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "SCL3"),
+		MTK_FUNCTION(3, "IDDIG"),
+		MTK_FUNCTION(5, "MD_EINT1"),
+		MTK_FUNCTION(6, "C2K_UIM0_HOT_PLUG_IN")
+	),
+	MTK_PIN(
+		55, "GPIO55",
+		MTK_EINT_FUNCTION(0, 55),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "SRCLKENAI0"),
+		MTK_FUNCTION(2, "PWM2"),
+		MTK_FUNCTION(3, "CLKM5"),
+		MTK_FUNCTION(4, "CORESONIC_SWD"),
+		MTK_FUNCTION(5, "ANT_SEL6"),
+		MTK_FUNCTION(6, "KROW5"),
+		MTK_FUNCTION(7, "DISP_PWM")
+	),
+	MTK_PIN(
+		56, "GPIO56",
+		MTK_EINT_FUNCTION(0, 56),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "SRCLKENA1")
+	),
+	MTK_PIN(
+		57, "GPIO57",
+		MTK_EINT_FUNCTION(0, 57),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "DPI_HSYNC0"),
+		MTK_FUNCTION(3, "UTXD2"),
+		MTK_FUNCTION(4, "MD_URXD"),
+		MTK_FUNCTION(5, "SRCLKENAI1"),
+		MTK_FUNCTION(6, "KROW4"),
+		MTK_FUNCTION(7, "DBG_MON_A14")
+	),
+	MTK_PIN(
+		58, "GPIO58",
+		MTK_EINT_FUNCTION(0, 58),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "DPI_VSYNC0"),
+		MTK_FUNCTION(3, "URXD2"),
+		MTK_FUNCTION(4, "MD_UTXD"),
+		MTK_FUNCTION(5, "TDD_TXD"),
+		MTK_FUNCTION(6, "KROW5"),
+		MTK_FUNCTION(7, "DBG_MON_A15")
+	),
+	MTK_PIN(
+		59, "GPIO59",
+		MTK_EINT_FUNCTION(0, 59),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "URXD3"),
+		MTK_FUNCTION(2, "DPI_CK0"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(4, "UCTS2"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "KROW6"),
+		MTK_FUNCTION(7, "DBG_MON_A16")
+	),
+	MTK_PIN(
+		60, "GPIO60",
+		MTK_EINT_FUNCTION(0, 60),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "UTXD3"),
+		MTK_FUNCTION(2, "DPI_DE0"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(4, "URTS2"),
+		MTK_FUNCTION(5, "PWM4"),
+		MTK_FUNCTION(6, "KROW7"),
+		MTK_FUNCTION(7, "DBG_MON_A17")
+	),
+	MTK_PIN(
+		61, "GPIO61",
+		MTK_EINT_FUNCTION(0, 61),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "DPI_D0"),
+		MTK_FUNCTION(3, "I2S0_BCK"),
+		MTK_FUNCTION(4, "KROW4"),
+		MTK_FUNCTION(5, "ANT_SEL3"),
+		MTK_FUNCTION(6, "IRTX_OUT"),
+		MTK_FUNCTION(7, "DBG_MON_A18")
+	),
+	MTK_PIN(
+		62, "GPIO62",
+		MTK_EINT_FUNCTION(0, 62),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "DPI_D1"),
+		MTK_FUNCTION(3, "I2S0_LRCK"),
+		MTK_FUNCTION(4, "KCOL7"),
+		MTK_FUNCTION(5, "CLKM3"),
+		MTK_FUNCTION(6, "CMFLASH"),
+		MTK_FUNCTION(7, "DBG_MON_A19")
+	),
+	MTK_PIN(
+		63, "GPIO63",
+		MTK_EINT_FUNCTION(0, 63),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "DPI_D2"),
+		MTK_FUNCTION(3, "I2S0_DI"),
+		MTK_FUNCTION(4, "PCM1_DO0"),
+		MTK_FUNCTION(5, "CLKM5"),
+		MTK_FUNCTION(6, "KROW3"),
+		MTK_FUNCTION(7, "DBG_MON_A20")
+	),
+	MTK_PIN(
+		64, "GPIO64",
+		MTK_EINT_FUNCTION(0, 64),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "PCM1_DO0"),
+		MTK_FUNCTION(2, "DPI_D3"),
+		MTK_FUNCTION(3, "I2S0_MCK"),
+		MTK_FUNCTION(4, "PCM1_DI"),
+		MTK_FUNCTION(5, "SRCLKENAI2"),
+		MTK_FUNCTION(6, "KCOL5"),
+		MTK_FUNCTION(7, "DBG_MON_A21")
+	),
+	MTK_PIN(
+		65, "GPIO65",
+		MTK_EINT_FUNCTION(0, 65),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "SPI_CSA"),
+		MTK_FUNCTION(2, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(3, "I2S3_MCK"),
+		MTK_FUNCTION(4, "KROW2"),
+		MTK_FUNCTION(5, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(6, "PTA_RXD"),
+		MTK_FUNCTION(7, "DBG_MON_A22")
+	),
+	MTK_PIN(
+		66, "GPIO66",
+		MTK_EINT_FUNCTION(0, 66),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "SPI_CKA"),
+		MTK_FUNCTION(2, "USB_DRVVBUS"),
+		MTK_FUNCTION(3, "I2S3_BCK"),
+		MTK_FUNCTION(4, "KCOL2"),
+		MTK_FUNCTION(6, "PTA_TXD"),
+		MTK_FUNCTION(7, "DBG_MON_A23")
+	),
+	MTK_PIN(
+		67, "GPIO67",
+		MTK_EINT_FUNCTION(0, 67),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(1, "SPI_MIA"),
+		MTK_FUNCTION(2, "SPI_MOA"),
+		MTK_FUNCTION(3, "I2S3_DO"),
+		MTK_FUNCTION(4, "PTA_RXD"),
+		MTK_FUNCTION(5, "IDDIG"),
+		MTK_FUNCTION(6, "UCTS1"),
+		MTK_FUNCTION(7, "DBG_MON_A24")
+	),
+	MTK_PIN(
+		68, "GPIO68",
+		MTK_EINT_FUNCTION(0, 68),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "SPI_MOA"),
+		MTK_FUNCTION(2, "SPI_MIA"),
+		MTK_FUNCTION(3, "I2S3_LRCK"),
+		MTK_FUNCTION(4, "PTA_TXD"),
+		MTK_FUNCTION(5, "ANT_SEL4"),
+		MTK_FUNCTION(6, "URTS1"),
+		MTK_FUNCTION(7, "DBG_MON_A25")
+	),
+	MTK_PIN(
+		69, "GPIO69",
+		MTK_EINT_FUNCTION(0, 69),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "DISP_PWM"),
+		MTK_FUNCTION(2, "PWM1"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "ANT_SEL7"),
+		MTK_FUNCTION(6, "DM_JTINTP")
+	),
+	MTK_PIN(
+		70, "GPIO70",
+		MTK_EINT_FUNCTION(0, 70),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO70"),
+		MTK_FUNCTION(1, "JTMS"),
+		MTK_FUNCTION(2, "CONN_MCU_TMS"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "CORESONIC_SWD"),
+		MTK_FUNCTION(6, "DM_OTMS"),
+		MTK_FUNCTION(7, "DFD_TMS")
+	),
+	MTK_PIN(
+		71, "GPIO71",
+		MTK_EINT_FUNCTION(0, 71),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "JTCK"),
+		MTK_FUNCTION(2, "CONN_MCU_TCK[1]"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "CORESONIC_SWCK"),
+		MTK_FUNCTION(6, "DM_OTCK"),
+		MTK_FUNCTION(7, "DFD_TCK_XI")
+	),
+	MTK_PIN(
+		72, "GPIO72",
+		MTK_EINT_FUNCTION(0, 72),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "JTDI"),
+		MTK_FUNCTION(2, "CONN_MCU_TDI"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(6, "DM_OTDI"),
+		MTK_FUNCTION(7, "DFD_TDI")
+	),
+	MTK_PIN(
+		73, "GPIO73",
+		MTK_EINT_FUNCTION(0, 73),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "JTDO"),
+		MTK_FUNCTION(2, "CONN_MCU_TDO"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(6, "DM_OTDO"),
+		MTK_FUNCTION(7, "DFD_TDO")
+	),
+	MTK_PIN(
+		74, "GPIO74",
+		MTK_EINT_FUNCTION(0, 74),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "URXD0"),
+		MTK_FUNCTION(2, "UTXD0"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "SDA3"),
+		MTK_FUNCTION(5, "C2K_UART0_RXD"),
+		MTK_FUNCTION(6, "LTE_URXD"),
+		MTK_FUNCTION(7, "AUXIF_ST")
+	),
+	MTK_PIN(
+		75, "GPIO75",
+		MTK_EINT_FUNCTION(0, 75),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "UTXD0"),
+		MTK_FUNCTION(2, "URXD0"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "TDD_TXD"),
+		MTK_FUNCTION(5, "C2K_UART0_TXD"),
+		MTK_FUNCTION(6, "LTE_UTXD")
+	),
+	MTK_PIN(
+		76, "GPIO76",
+		MTK_EINT_FUNCTION(0, 76),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "UTXD1"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "SCL3"),
+		MTK_FUNCTION(5, "LTE_URXD"),
+		MTK_FUNCTION(6, "C2K_UART0_RXD"),
+		MTK_FUNCTION(7, "AUXIF_CLK")
+	),
+	MTK_PIN(
+		77, "GPIO77",
+		MTK_EINT_FUNCTION(0, 77),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "URXD1"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "TDD_TXD"),
+		MTK_FUNCTION(5, "LTE_UTXD"),
+		MTK_FUNCTION(6, "C2K_UART0_TXD")
+	),
+	MTK_PIN(
+		78, "GPIO78",
+		MTK_EINT_FUNCTION(0, 78),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "I2S0_DI"),
+		MTK_FUNCTION(2, "PCM1_DI"),
+		MTK_FUNCTION(3, "I2S3_DO"),
+		MTK_FUNCTION(4, "I2S1_DO"),
+		MTK_FUNCTION(5, "PWM0"),
+		MTK_FUNCTION(6, "I2S2_DI"),
+		MTK_FUNCTION(7, "DBG_MON_A26")
+	),
+	MTK_PIN(
+		79, "GPIO79",
+		MTK_EINT_FUNCTION(0, 79),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "I2S0_LRCK"),
+		MTK_FUNCTION(2, "PCM1_SYNC"),
+		MTK_FUNCTION(3, "I2S3_LRCK"),
+		MTK_FUNCTION(4, "I2S1_LRCK"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "I2S2_LRCK"),
+		MTK_FUNCTION(7, "DBG_MON_A27")
+	),
+	MTK_PIN(
+		80, "GPIO80",
+		MTK_EINT_FUNCTION(0, 80),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "I2S0_BCK"),
+		MTK_FUNCTION(2, "PCM1_CLK[1]"),
+		MTK_FUNCTION(3, "I2S3_BCK"),
+		MTK_FUNCTION(4, "I2S1_BCK"),
+		MTK_FUNCTION(5, "PWM4"),
+		MTK_FUNCTION(6, "I2S2_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_A28")
+	),
+	MTK_PIN(
+		81, "GPIO81",
+		MTK_EINT_FUNCTION(0, 81),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "KROW0"),
+		MTK_FUNCTION(3, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(4, "CORESONIC_SWCK"),
+		MTK_FUNCTION(5, "C2K_TCK"),
+		MTK_FUNCTION(7, "C2K_DM_EINT1")
+	),
+	MTK_PIN(
+		82, "GPIO82",
+		MTK_EINT_FUNCTION(0, 82),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "KROW1"),
+		MTK_FUNCTION(3, "CONN_MCU_TRST_B"),
+		MTK_FUNCTION(4, "CORESONIC_SWD"),
+		MTK_FUNCTION(5, "C2K_NTRST"),
+		MTK_FUNCTION(6, "USB_DRVVBUS"),
+		MTK_FUNCTION(7, "C2K_DM_EINT2")
+	),
+	MTK_PIN(
+		83, "GPIO83",
+		MTK_EINT_FUNCTION(0, 83),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "KROW2"),
+		MTK_FUNCTION(2, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "C2K_TDI"),
+		MTK_FUNCTION(7, "C2K_DM_EINT3")
+	),
+	MTK_PIN(
+		84, "GPIO84",
+		MTK_EINT_FUNCTION(0, 84),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "KCOL0"),
+		MTK_FUNCTION(2, "URTS0"),
+		MTK_FUNCTION(3, "CONN_MCU_DBGACK_N"),
+		MTK_FUNCTION(4, "SCL2"),
+		MTK_FUNCTION(5, "C2K_TDO"),
+		MTK_FUNCTION(6, "AUXIF_CLK")
+	),
+	MTK_PIN(
+		85, "GPIO85",
+		MTK_EINT_FUNCTION(0, 85),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "KCOL1"),
+		MTK_FUNCTION(2, "UCTS0"),
+		MTK_FUNCTION(3, "UCTS1"),
+		MTK_FUNCTION(4, "SDA2"),
+		MTK_FUNCTION(5, "C2K_TMS"),
+		MTK_FUNCTION(6, "AUXIF_ST"),
+		MTK_FUNCTION(7, "DBG_MON_A31")
+	),
+	MTK_PIN(
+		86, "GPIO86",
+		MTK_EINT_FUNCTION(0, 86),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "KCOL2"),
+		MTK_FUNCTION(3, "URTS1"),
+		MTK_FUNCTION(5, "C2K_RTCK"),
+		MTK_FUNCTION(7, "DBG_MON_A32")
+	),
+	MTK_PIN(
+		87, "GPIO87",
+		MTK_EINT_FUNCTION(0, 87),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "BPI_BUS5"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS5"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS5"),
+		MTK_FUNCTION(7, "DBG_MON_B0")
+	),
+	MTK_PIN(
+		88, "GPIO88",
+		MTK_EINT_FUNCTION(0, 88),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "BPI_BUS6"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS6"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS6"),
+		MTK_FUNCTION(7, "DBG_MON_B1")
+	),
+	MTK_PIN(
+		89, "GPIO89",
+		MTK_EINT_FUNCTION(0, 89),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "BPI_BUS7"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS7"),
+		MTK_FUNCTION(3, "CLKM0"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS7"),
+		MTK_FUNCTION(7, "DBG_MON_B2")
+	),
+	MTK_PIN(
+		90, "GPIO90",
+		MTK_EINT_FUNCTION(0, 90),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "BPI_BUS8"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS8"),
+		MTK_FUNCTION(3, "CLKM1"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS8"),
+		MTK_FUNCTION(7, "DBG_MON_B3")
+	),
+	MTK_PIN(
+		91, "GPIO91",
+		MTK_EINT_FUNCTION(0, 91),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO91"),
+		MTK_FUNCTION(1, "BPI_BUS9"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS9"),
+		MTK_FUNCTION(3, "CLKM2"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS9"),
+		MTK_FUNCTION(7, "DBG_MON_B4")
+	),
+	MTK_PIN(
+		92, "GPIO92",
+		MTK_EINT_FUNCTION(0, 92),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO92"),
+		MTK_FUNCTION(1, "BPI_BUS10"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS10"),
+		MTK_FUNCTION(3, "CLKM3"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS10"),
+		MTK_FUNCTION(7, "DBG_MON_B5")
+	),
+	MTK_PIN(
+		93, "GPIO93",
+		MTK_EINT_FUNCTION(0, 93),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO93"),
+		MTK_FUNCTION(1, "BPI_BUS11"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS11"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS11"),
+		MTK_FUNCTION(7, "DBG_MON_B6")
+	),
+	MTK_PIN(
+		94, "GPIO94",
+		MTK_EINT_FUNCTION(0, 94),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO94"),
+		MTK_FUNCTION(1, "BPI_BUS12"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS12"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS12"),
+		MTK_FUNCTION(7, "DBG_MON_B7")
+	),
+	MTK_PIN(
+		95, "GPIO95",
+		MTK_EINT_FUNCTION(0, 95),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO95"),
+		MTK_FUNCTION(1, "BPI_BUS13"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS13"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS13"),
+		MTK_FUNCTION(7, "DBG_MON_B8")
+	),
+	MTK_PIN(
+		96, "GPIO96",
+		MTK_EINT_FUNCTION(0, 96),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO96"),
+		MTK_FUNCTION(1, "BPI_BUS14"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS14"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS14"),
+		MTK_FUNCTION(7, "DBG_MON_B9")
+	),
+	MTK_PIN(
+		97, "GPIO97",
+		MTK_EINT_FUNCTION(0, 97),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO97"),
+		MTK_FUNCTION(1, "BPI_BUS15"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS15"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS15"),
+		MTK_FUNCTION(7, "DBG_MON_B10")
+	),
+	MTK_PIN(
+		98, "GPIO98",
+		MTK_EINT_FUNCTION(0, 98),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO98"),
+		MTK_FUNCTION(1, "BPI_BUS16"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS16"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS16"),
+		MTK_FUNCTION(7, "DBG_MON_B11")
+	),
+	MTK_PIN(
+		99, "GPIO99",
+		MTK_EINT_FUNCTION(0, 99),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO99"),
+		MTK_FUNCTION(1, "BPI_BUS17"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS17"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS17"),
+		MTK_FUNCTION(7, "DBG_MON_B12")
+	),
+	MTK_PIN(
+		100, "GPIO100",
+		MTK_EINT_FUNCTION(0, 100),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO100"),
+		MTK_FUNCTION(1, "BPI_BUS18"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS18"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS18"),
+		MTK_FUNCTION(7, "DBG_MON_B13")
+	),
+	MTK_PIN(
+		101, "GPIO101",
+		MTK_EINT_FUNCTION(0, 101),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "BPI_BUS19"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS19"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS19"),
+		MTK_FUNCTION(7, "DBG_MON_B14")
+	),
+	MTK_PIN(
+		102, "GPIO102",
+		MTK_EINT_FUNCTION(0, 102),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "BPI_BUS20"),
+		MTK_FUNCTION(2, "LTE_C2K_BPI_BUS20"),
+		MTK_FUNCTION(5, "C2K_BPI_BUS20"),
+		MTK_FUNCTION(7, "DBG_MON_B15")
+	),
+	MTK_PIN(
+		103, "GPIO103",
+		MTK_EINT_FUNCTION(0, 103),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "C2K_TXBPI"),
+		MTK_FUNCTION(7, "DBG_MON_B16")
+	),
+	MTK_PIN(
+		104, "GPIO104",
+		MTK_EINT_FUNCTION(0, 104),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "RFIC1_BSI_EN"),
+		MTK_FUNCTION(5, "C2K_RX_BSI_EN"),
+		MTK_FUNCTION(7, "DBG_MON_B17")
+	),
+	MTK_PIN(
+		105, "GPIO105",
+		MTK_EINT_FUNCTION(0, 105),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "RFIC1_BSI_CK"),
+		MTK_FUNCTION(5, "C2K_RX_BSI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B18")
+	),
+	MTK_PIN(
+		106, "GPIO106",
+		MTK_EINT_FUNCTION(0, 106),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D0"),
+		MTK_FUNCTION(5, "C2K_RX_BSI_DATA"),
+		MTK_FUNCTION(7, "DBG_MON_B19")
+	),
+	MTK_PIN(
+		107, "GPIO107",
+		MTK_EINT_FUNCTION(0, 107),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D1"),
+		MTK_FUNCTION(5, "C2K_TX_BSI_EN"),
+		MTK_FUNCTION(7, "DBG_MON_B20")
+	),
+	MTK_PIN(
+		108, "GPIO108",
+		MTK_EINT_FUNCTION(0, 108),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D2"),
+		MTK_FUNCTION(5, "C2K_TX_BSI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B21")
+	),
+	MTK_PIN(
+		109, "GPIO109",
+		MTK_EINT_FUNCTION(0, 109),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(5, "C2K_TX_BSI_DATA"),
+		MTK_FUNCTION(7, "DBG_MON_B22")
+	),
+	MTK_PIN(
+		110, "GPIO110",
+		MTK_EINT_FUNCTION(0, 110),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "RFIC0_BSI_EN"),
+		MTK_FUNCTION(4, "SPM_BSI_EN"),
+		MTK_FUNCTION(7, "DBG_MON_B23")
+	),
+	MTK_PIN(
+		111, "GPIO111",
+		MTK_EINT_FUNCTION(0, 111),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "RFIC0_BSI_CK"),
+		MTK_FUNCTION(4, "SPM_BSI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B24")
+	),
+	MTK_PIN(
+		112, "GPIO112",
+		MTK_EINT_FUNCTION(0, 112),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D2"),
+		MTK_FUNCTION(4, "SPM_BSI_D2"),
+		MTK_FUNCTION(7, "DBG_MON_B25")
+	),
+	MTK_PIN(
+		113, "GPIO113",
+		MTK_EINT_FUNCTION(0, 113),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D1"),
+		MTK_FUNCTION(4, "SPM_BSI_D1"),
+		MTK_FUNCTION(7, "DBG_MON_B26")
+	),
+	MTK_PIN(
+		114, "GPIO114",
+		MTK_EINT_FUNCTION(0, 114),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D0"),
+		MTK_FUNCTION(4, "SPM_BSI_D0"),
+		MTK_FUNCTION(7, "DBG_MON_B27")
+	),
+	MTK_PIN(
+		115, "GPIO115",
+		MTK_EINT_FUNCTION(0, 115),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "AUXIN0")
+	),
+	MTK_PIN(
+		116, "GPIO116",
+		MTK_EINT_FUNCTION(0, 116),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "AUXIN1")
+	),
+	MTK_PIN(
+		117, "GPIO117",
+		MTK_EINT_FUNCTION(0, 117),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "AUXIN2")
+	),
+	MTK_PIN(
+		118, "GPIO118",
+		MTK_EINT_FUNCTION(0, 118),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "TXBPI")
+	),
+	MTK_PIN(
+		119, "GPIO119",
+		MTK_EINT_FUNCTION(0, 119),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "BPI_BUS0"),
+		MTK_FUNCTION(7, "DBG_MON_B28")
+	),
+	MTK_PIN(
+		120, "GPIO120",
+		MTK_EINT_FUNCTION(0, 120),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "BPI_BUS1"),
+		MTK_FUNCTION(7, "DBG_MON_B29")
+	),
+	MTK_PIN(
+		121, "GPIO121",
+		MTK_EINT_FUNCTION(0, 121),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "BPI_BUS2"),
+		MTK_FUNCTION(7, "DBG_MON_B30")
+	),
+	MTK_PIN(
+		122, "GPIO122",
+		MTK_EINT_FUNCTION(0, 122),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "BPI_BUS3"),
+		MTK_FUNCTION(7, "DBG_MON_B31")
+	),
+	MTK_PIN(
+		123, "GPIO123",
+		MTK_EINT_FUNCTION(0, 123),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "BPI_BUS4"),
+		MTK_FUNCTION(7, "DBG_MON_B32")
+	),
+	MTK_PIN(
+		124, "GPIO124",
+		MTK_EINT_FUNCTION(0, 124),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "BPI_BUS21"),
+		MTK_FUNCTION(5, "DPI_HSYNC1"),
+		MTK_FUNCTION(6, "KCOL2"),
+		MTK_FUNCTION(7, "TDD_TXD")
+	),
+	MTK_PIN(
+		125, "GPIO125",
+		MTK_EINT_FUNCTION(0, 125),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "BPI_BUS22"),
+		MTK_FUNCTION(5, "DPI_VSYNC1"),
+		MTK_FUNCTION(6, "KROW2"),
+		MTK_FUNCTION(7, "MD_URXD")
+	),
+	MTK_PIN(
+		126, "GPIO126",
+		MTK_EINT_FUNCTION(0, 126),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "BPI_BUS23"),
+		MTK_FUNCTION(5, "DPI_CK1"),
+		MTK_FUNCTION(6, "I2S2_MCK"),
+		MTK_FUNCTION(7, "MD_UTXD")
+	),
+	MTK_PIN(
+		127, "GPIO127",
+		MTK_EINT_FUNCTION(0, 127),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "BPI_BUS24"),
+		MTK_FUNCTION(3, "CONN_MCU_DBGI_N"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "DPI_DE1"),
+		MTK_FUNCTION(6, "SRCLKENAI1"),
+		MTK_FUNCTION(7, "URXD0")
+	),
+	MTK_PIN(
+		128, "GPIO128",
+		MTK_EINT_FUNCTION(0, 128),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "BPI_BUS25"),
+		MTK_FUNCTION(3, "GPS_FRAME_SYNC"),
+		MTK_FUNCTION(5, "I2S2_DI"),
+		MTK_FUNCTION(6, "PTA_RXD"),
+		MTK_FUNCTION(7, "UTXD0")
+	),
+	MTK_PIN(
+		129, "GPIO129",
+		MTK_EINT_FUNCTION(0, 129),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "BPI_BUS26"),
+		MTK_FUNCTION(2, "DISP_PWM"),
+		MTK_FUNCTION(5, "I2S2_LRCK"),
+		MTK_FUNCTION(6, "PTA_TXD"),
+		MTK_FUNCTION(7, "LTE_URXD")
+	),
+	MTK_PIN(
+		130, "GPIO130",
+		MTK_EINT_FUNCTION(0, 130),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "BPI_BUS27"),
+		MTK_FUNCTION(5, "I2S2_BCK"),
+		MTK_FUNCTION(6, "IRTX_OUT"),
+		MTK_FUNCTION(7, "LTE_UTXD")
+	),
+	MTK_PIN(
+		131, "GPIO131",
+		MTK_EINT_FUNCTION(0, 131),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "LTE_PAVM0")
+	),
+	MTK_PIN(
+		132, "GPIO132",
+		MTK_EINT_FUNCTION(0, 132),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "LTE_PAVM1")
+	),
+	MTK_PIN(
+		133, "GPIO133",
+		MTK_EINT_FUNCTION(0, 133),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "MIPI1_SCLK")
+	),
+	MTK_PIN(
+		134, "GPIO134",
+		MTK_EINT_FUNCTION(0, 134),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "MIPI1_SDATA")
+	),
+	MTK_PIN(
+		135, "GPIO135",
+		MTK_EINT_FUNCTION(0, 135),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO135"),
+		MTK_FUNCTION(1, "MIPI0_SCLK")
+	),
+	MTK_PIN(
+		136, "GPIO136",
+		MTK_EINT_FUNCTION(0, 136),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO136"),
+		MTK_FUNCTION(1, "MIPI0_SDATA")
+	),
+	MTK_PIN(
+		137, "GPIO137",
+		MTK_EINT_FUNCTION(0, 137),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO137"),
+		MTK_FUNCTION(1, "RTC32K_CK")
+	),
+	MTK_PIN(
+		138, "GPIO138",
+		MTK_EINT_FUNCTION(0, 138),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO138"),
+		MTK_FUNCTION(1, "PWRAP_SPIDO"),
+		MTK_FUNCTION(2, "PWRAP_SPIDI")
+	),
+	MTK_PIN(
+		139, "GPIO139",
+		MTK_EINT_FUNCTION(0, 139),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO139"),
+		MTK_FUNCTION(1, "PWRAP_SPIDI"),
+		MTK_FUNCTION(2, "PWRAP_SPIDO")
+	),
+	MTK_PIN(
+		140, "GPIO140",
+		MTK_EINT_FUNCTION(0, 140),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO140"),
+		MTK_FUNCTION(3, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "DM_JTINTP")
+	),
+	MTK_PIN(
+		141, "GPIO141",
+		MTK_EINT_FUNCTION(0, 141),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO141"),
+		MTK_FUNCTION(1, "PWRAP_SPICK_I")
+	),
+	MTK_PIN(
+		142, "GPIO142",
+		MTK_EINT_FUNCTION(0, 142),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO142"),
+		MTK_FUNCTION(1, "PWRAP_SPICS_B_I")
+	),
+	MTK_PIN(
+		143, "GPIO143",
+		MTK_EINT_FUNCTION(0, 143),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO143"),
+		MTK_FUNCTION(1, "AUD_CLK_MOSI")
+	),
+	MTK_PIN(
+		144, "GPIO144",
+		MTK_EINT_FUNCTION(0, 144),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO144"),
+		MTK_FUNCTION(1, "AUD_DAT_MISO"),
+		MTK_FUNCTION(3, "AUD_DAT_MOSI")
+	),
+	MTK_PIN(
+		145, "GPIO145",
+		MTK_EINT_FUNCTION(0, 145),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO145"),
+		MTK_FUNCTION(1, "AUD_DAT_MOSI"),
+		MTK_FUNCTION(3, "AUD_DAT_MISO")
+	),
+	MTK_PIN(
+		146, "GPIO146",
+		MTK_EINT_FUNCTION(0, 146),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO146"),
+		MTK_FUNCTION(1, "LCM_RST")
+	),
+	MTK_PIN(
+		147, "GPIO147",
+		MTK_EINT_FUNCTION(0, 147),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO147"),
+		MTK_FUNCTION(1, "DSI_TE")
+	),
+	MTK_PIN(
+		148, "GPIO148",
+		MTK_EINT_FUNCTION(0, 148),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO148"),
+		MTK_FUNCTION(1, "SRCLKENA")
+	),
+	MTK_PIN(
+		149, "GPIO149",
+		MTK_EINT_FUNCTION(0, 149),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO149"),
+		MTK_FUNCTION(1, "WATCHDOG")
+	),
+	MTK_PIN(
+		150, "GPIO150",
+		MTK_EINT_FUNCTION(0, 150),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO150"),
+		MTK_FUNCTION(1, "TDP0")
+	),
+	MTK_PIN(
+		151, "GPIO151",
+		MTK_EINT_FUNCTION(0, 151),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO151"),
+		MTK_FUNCTION(1, "TDN0")
+	),
+	MTK_PIN(
+		152, "GPIO152",
+		MTK_EINT_FUNCTION(0, 152),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO152"),
+		MTK_FUNCTION(1, "TDP1")
+	),
+	MTK_PIN(
+		153, "GPIO153",
+		MTK_EINT_FUNCTION(0, 153),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO153"),
+		MTK_FUNCTION(1, "TDN1")
+	),
+	MTK_PIN(
+		154, "GPIO154",
+		MTK_EINT_FUNCTION(0, 154),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO154"),
+		MTK_FUNCTION(1, "TCP")
+	),
+	MTK_PIN(
+		155, "GPIO155",
+		MTK_EINT_FUNCTION(0, 155),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO155"),
+		MTK_FUNCTION(1, "TCN")
+	),
+	MTK_PIN(
+		156, "GPIO156",
+		MTK_EINT_FUNCTION(0, 156),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO156"),
+		MTK_FUNCTION(1, "TDP2")
+	),
+	MTK_PIN(
+		157, "GPIO157",
+		MTK_EINT_FUNCTION(0, 157),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO157"),
+		MTK_FUNCTION(1, "TDN2")
+	),
+	MTK_PIN(
+		158, "GPIO158",
+		MTK_EINT_FUNCTION(0, 158),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO158"),
+		MTK_FUNCTION(1, "TDP3")
+	),
+	MTK_PIN(
+		159, "GPIO159",
+		MTK_EINT_FUNCTION(0, 159),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO159"),
+		MTK_FUNCTION(1, "TDN3")
+	),
+	MTK_PIN(
+		160, "GPIO160",
+		MTK_EINT_FUNCTION(0, 160),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO160"),
+		MTK_FUNCTION(1, "MD_SIM2_SCLK"),
+		MTK_FUNCTION(2, "MD_SIM1_SCLK"),
+		MTK_FUNCTION(3, "UIM0_CLK"),
+		MTK_FUNCTION(4, "UIM1_CLK")
+	),
+	MTK_PIN(
+		161, "GPIO161",
+		MTK_EINT_FUNCTION(0, 161),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO161"),
+		MTK_FUNCTION(1, "MD_SIM2_SRST"),
+		MTK_FUNCTION(2, "MD_SIM1_SRST"),
+		MTK_FUNCTION(3, "UIM0_RST"),
+		MTK_FUNCTION(4, "UIM1_RST")
+	),
+	MTK_PIN(
+		162, "GPIO162",
+		MTK_EINT_FUNCTION(0, 162),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO162"),
+		MTK_FUNCTION(1, "MD_SIM2_SDAT"),
+		MTK_FUNCTION(2, "MD_SIM1_SDAT"),
+		MTK_FUNCTION(3, "UIM0_IO"),
+		MTK_FUNCTION(4, "UIM1_IO")
+	),
+	MTK_PIN(
+		163, "GPIO163",
+		MTK_EINT_FUNCTION(0, 163),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO163"),
+		MTK_FUNCTION(1, "MD_SIM1_SCLK"),
+		MTK_FUNCTION(2, "MD_SIM2_SCLK"),
+		MTK_FUNCTION(3, "UIM1_CLK"),
+		MTK_FUNCTION(4, "UIM0_CLK")
+	),
+	MTK_PIN(
+		164, "GPIO164",
+		MTK_EINT_FUNCTION(0, 164),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO164"),
+		MTK_FUNCTION(1, "MD_SIM1_SRST"),
+		MTK_FUNCTION(2, "MD_SIM2_SRST"),
+		MTK_FUNCTION(3, "UIM1_RST"),
+		MTK_FUNCTION(4, "UIM0_RST")
+	),
+	MTK_PIN(
+		165, "GPIO165",
+		MTK_EINT_FUNCTION(0, 165),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO165"),
+		MTK_FUNCTION(1, "MD_SIM1_SDAT"),
+		MTK_FUNCTION(2, "MD_SIM2_SDAT"),
+		MTK_FUNCTION(3, "UIM1_IO"),
+		MTK_FUNCTION(4, "UIM0_IO")
+	),
+	MTK_PIN(
+		166, "GPIO166",
+		MTK_EINT_FUNCTION(0, 166),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO166"),
+		MTK_FUNCTION(1, "MSDC1_CMD"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(3, "C2K_TMS"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "CONN_DSP_JMS"),
+		MTK_FUNCTION(6, "JTMS"),
+		MTK_FUNCTION(7, "CONN_MCU_AICE_TMSC")
+	),
+	MTK_PIN(
+		167, "GPIO167",
+		MTK_EINT_FUNCTION(0, 167),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO167"),
+		MTK_FUNCTION(1, "MSDC1_CLK"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(3, "C2K_TCK"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "CONN_DSP_JCK"),
+		MTK_FUNCTION(6, "JTCK"),
+		MTK_FUNCTION(7, "CONN_MCU_AICE_TCKC")
+	),
+	MTK_PIN(
+		168, "GPIO168",
+		MTK_EINT_FUNCTION(0, 168),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO168"),
+		MTK_FUNCTION(1, "MSDC1_DAT0"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(3, "C2K_TDI"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(5, "CONN_DSP_JDI"),
+		MTK_FUNCTION(6, "JTDI")
+	),
+	MTK_PIN(
+		169, "GPIO169",
+		MTK_EINT_FUNCTION(0, 169),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO169"),
+		MTK_FUNCTION(1, "MSDC1_DAT1"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(3, "C2K_TDO"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(5, "CONN_DSP_JDO"),
+		MTK_FUNCTION(6, "JTDO")
+	),
+	MTK_PIN(
+		170, "GPIO170",
+		MTK_EINT_FUNCTION(0, 170),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO170"),
+		MTK_FUNCTION(1, "MSDC1_DAT2"),
+		MTK_FUNCTION(2, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(3, "C2K_NTRST"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "CONN_DSP_JINTP"),
+		MTK_FUNCTION(6, "DM_JTINTP")
+	),
+	MTK_PIN(
+		171, "GPIO171",
+		MTK_EINT_FUNCTION(0, 171),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO171"),
+		MTK_FUNCTION(1, "MSDC1_DAT3"),
+		MTK_FUNCTION(3, "C2K_RTCK")
+	),
+	MTK_PIN(
+		172, "GPIO172",
+		MTK_EINT_FUNCTION(0, 172),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO172"),
+		MTK_FUNCTION(1, "MSDC0_CMD")
+	),
+	MTK_PIN(
+		173, "GPIO173",
+		MTK_EINT_FUNCTION(0, 173),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO173"),
+		MTK_FUNCTION(1, "MSDC0_DSL")
+	),
+	MTK_PIN(
+		174, "GPIO174",
+		MTK_EINT_FUNCTION(0, 174),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO174"),
+		MTK_FUNCTION(1, "MSDC0_CLK")
+	),
+	MTK_PIN(
+		175, "GPIO175",
+		MTK_EINT_FUNCTION(0, 175),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO175"),
+		MTK_FUNCTION(1, "MSDC0_DAT0")
+	),
+	MTK_PIN(
+		176, "GPIO176",
+		MTK_EINT_FUNCTION(0, 176),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO176"),
+		MTK_FUNCTION(1, "MSDC0_DAT1")
+	),
+	MTK_PIN(
+		177, "GPIO177",
+		MTK_EINT_FUNCTION(0, 177),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO177"),
+		MTK_FUNCTION(1, "MSDC0_DAT2")
+	),
+	MTK_PIN(
+		178, "GPIO178",
+		MTK_EINT_FUNCTION(0, 178),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO178"),
+		MTK_FUNCTION(1, "MSDC0_DAT3")
+	),
+	MTK_PIN(
+		179, "GPIO179",
+		MTK_EINT_FUNCTION(0, 179),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO179"),
+		MTK_FUNCTION(1, "MSDC0_DAT4")
+	),
+	MTK_PIN(
+		180, "GPIO180",
+		MTK_EINT_FUNCTION(0, 180),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO180"),
+		MTK_FUNCTION(1, "MSDC0_DAT5")
+	),
+	MTK_PIN(
+		181, "GPIO181",
+		MTK_EINT_FUNCTION(0, 181),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO181"),
+		MTK_FUNCTION(1, "MSDC0_DAT6")
+	),
+	MTK_PIN(
+		182, "GPIO182",
+		MTK_EINT_FUNCTION(0, 182),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO182"),
+		MTK_FUNCTION(1, "MSDC0_DAT7")
+	),
+	MTK_PIN(
+		183, "GPIO183",
+		MTK_EINT_FUNCTION(0, 183),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO183"),
+		MTK_FUNCTION(1, "MSDC0_RSTB")
+	),
+	MTK_PIN(
+		184, "GPIO184",
+		MTK_EINT_FUNCTION(0, 184),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO184"),
+		MTK_FUNCTION(1, "F2W_DATA"),
+		MTK_FUNCTION(2, "MRG_CLK"),
+		MTK_FUNCTION(3, "C2K_DM_EINT2"),
+		MTK_FUNCTION(4, "PCM0_CLK")
+	),
+	MTK_PIN(
+		185, "GPIO185",
+		MTK_EINT_FUNCTION(0, 185),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO185"),
+		MTK_FUNCTION(1, "F2W_CK"),
+		MTK_FUNCTION(2, "MRG_DI"),
+		MTK_FUNCTION(3, "C2K_DM_EINT3"),
+		MTK_FUNCTION(4, "PCM0_DI")
+	),
+	MTK_PIN(
+		186, "GPIO186",
+		MTK_EINT_FUNCTION(0, 186),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO186"),
+		MTK_FUNCTION(1, "WB_RSTB"),
+		MTK_FUNCTION(4, "URXD3"),
+		MTK_FUNCTION(5, "UTXD3")
+	),
+	MTK_PIN(
+		187, "GPIO187",
+		MTK_EINT_FUNCTION(0, 187),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO187"),
+		MTK_FUNCTION(1, "WB_SCLK"),
+		MTK_FUNCTION(2, "MRG_DO"),
+		MTK_FUNCTION(4, "PCM0_DO")
+	),
+	MTK_PIN(
+		188, "GPIO188",
+		MTK_EINT_FUNCTION(0, 188),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO188"),
+		MTK_FUNCTION(1, "WB_SDATA"),
+		MTK_FUNCTION(2, "MRG_SYNC"),
+		MTK_FUNCTION(4, "PCM0_SYNC")
+	),
+	MTK_PIN(
+		189, "GPIO189",
+		MTK_EINT_FUNCTION(0, 189),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO189"),
+		MTK_FUNCTION(1, "WB_SEN"),
+		MTK_FUNCTION(4, "UTXD3"),
+		MTK_FUNCTION(5, "URXD3")
+	),
+	MTK_PIN(
+		190, "GPIO190",
+		MTK_EINT_FUNCTION(0, 190),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO190"),
+		MTK_FUNCTION(1, "GPS_RXQN")
+	),
+	MTK_PIN(
+		191, "GPIO191",
+		MTK_EINT_FUNCTION(0, 191),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO191"),
+		MTK_FUNCTION(1, "GPS_RXQP")
+	),
+	MTK_PIN(
+		192, "GPIO192",
+		MTK_EINT_FUNCTION(0, 192),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO192"),
+		MTK_FUNCTION(1, "GPS_RXIN")
+	),
+	MTK_PIN(
+		193, "GPIO193",
+		MTK_EINT_FUNCTION(0, 193),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO193"),
+		MTK_FUNCTION(1, "GPS_RXIP")
+	),
+	MTK_PIN(
+		194, "GPIO194",
+		MTK_EINT_FUNCTION(0, 194),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO194"),
+		MTK_FUNCTION(1, "WB_RXQN")
+	),
+	MTK_PIN(
+		195, "GPIO195",
+		MTK_EINT_FUNCTION(0, 195),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO195"),
+		MTK_FUNCTION(1, "WB_RXQP")
+	),
+	MTK_PIN(
+		196, "GPIO196",
+		MTK_EINT_FUNCTION(0, 196),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO196"),
+		MTK_FUNCTION(1, "WB_RXIN")
+	),
+	MTK_PIN(
+		197, "GPIO197",
+		MTK_EINT_FUNCTION(0, 197),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO197"),
+		MTK_FUNCTION(1, "WB_RXIP")
+	),
+	MTK_PIN(
+		198, "GPIO198",
+		MTK_EINT_FUNCTION(0, 198),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		199, "GPIO199",
+		MTK_EINT_FUNCTION(0, 199),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		200, "GPIO200",
+		MTK_EINT_FUNCTION(0, 200),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		201, "GPIO201",
+		MTK_EINT_FUNCTION(0, 201),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		202, "GPIO202",
+		MTK_EINT_FUNCTION(0, 202),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		203, "GPIO203",
+		MTK_EINT_FUNCTION(0, 203),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		204, "GPIO204",
+		MTK_EINT_FUNCTION(0, 204),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		205, "GPIO205",
+		MTK_EINT_FUNCTION(0, 205),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		206, "GPIO206",
+		MTK_EINT_FUNCTION(0, 206),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		207, "GPIO207",
+		MTK_EINT_FUNCTION(0, 207),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		208, "GPIO208",
+		MTK_EINT_FUNCTION(0, 208),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		209, "GPIO209",
+		MTK_EINT_FUNCTION(0, 209),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		210, "GPIO210",
+		MTK_EINT_FUNCTION(0, 210),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		211, "GPIO211",
+		MTK_EINT_FUNCTION(0, 211),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+	MTK_PIN(
+		212, "GPIO212",
+		MTK_EINT_FUNCTION(0, 212),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+};
+
+#endif
-- 
2.38.1

