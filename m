Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43116AA8CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCDInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCDInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:43:46 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A59144B0;
        Sat,  4 Mar 2023 00:43:44 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a32so4635998ljr.9;
        Sat, 04 Mar 2023 00:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677919423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0pwwdOYyW2II5cV+i3ghWhBGeIC4SqgjPw8ThgafFQ=;
        b=f0+bifXyf8DnfrgXI5mQ4YBx4w+iyzWMl59D7kNZ0PnyZgMbm4d2VzRBzaDqYzuA9s
         SVgKXfxLoAOSkFaKu2kHuERzItVkY+eg973dZkQlT8mwM8M75acWZuVFnaLjNnyy3aUr
         pLH+F8/s8f+O8Jj6ybE6dmnPXtWgMgypKwOF44NMESlPx71TqUpElTcTxrP52+mXm9Qr
         JzRb4BddbeUpJ85eKE/0MqLYdist2sZQ5iqN9FyKlT0ivgjkXJzI79YdK8XJmIga/CBB
         8/HUqKo70KCgc32YOXadOxdn1are8O68dNAwogamilHJuGYm5LNA0889EGUtqmFFISU3
         ZCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677919423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0pwwdOYyW2II5cV+i3ghWhBGeIC4SqgjPw8ThgafFQ=;
        b=LePrMmmEa31bLnhJbDqKFd9eyhN5j17Z4upZNraaD3jOyiGyZOlPIUIXHk5Y3Rr+XP
         P4XIyJCtGh4Q+H7Eo519ecybcDdFPxlECBiLQZG9yl3DiWx0Ail3s+m/m12wx+4zzTqz
         nIIUSHAWhZIkxFXArVzXBzAagA4OW6d0sgfR8cBrECwW4KiQmQt+vE4TS3pgdJXv1GqX
         FTQ0OLAE4M8UNBQpeCfSWIbSP17ptgV3lIzNnismE8S/MOrITbS9tYl0PSLOmv8hfCtF
         2RfBmr9KJNeFl/AVrSynyeLK7GZUFZg4On/r0gkX2wEoL0zU2nRnVjUMSJUhsgODmH2r
         kO2w==
X-Gm-Message-State: AO0yUKWSR9IkjtoMeRc9a5X5lrz1LfYvaZlMu+vYNxeVHwSmOjr/Sisf
        Cna2dSKOw6HCjZROad5K9Es=
X-Google-Smtp-Source: AK7set/qE8K/H5L0FzA7W/vivB9ol1unkgKMy1sDFOKLyU8JiCgGHliKA4qHLmS/qLkcArCSKwxfYQ==
X-Received: by 2002:a05:651c:11c9:b0:295:c491:3b34 with SMTP id z9-20020a05651c11c900b00295c4913b34mr1334940ljo.38.1677919422786;
        Sat, 04 Mar 2023 00:43:42 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a2ea165000000b00293cc5f83b4sm693575ljl.27.2023.03.04.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 00:43:42 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ARM: tegra: Add labels to tegra114.dtsi
Date:   Sat,  4 Mar 2023 10:43:16 +0200
Message-Id: <20230304084319.18424-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304084319.18424-1-clamor95@gmail.com>
References: <20230304084319.18424-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

Add more labels in order to use label reference in device-specific
dts files. Labels make device-trees more readable and prevent typos
that are difficult to notice.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 09996acad639..76c52d0b518a 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -106,7 +106,7 @@ rgb {
 			};
 		};
 
-		hdmi@54280000 {
+		hdmi: hdmi@54280000 {
 			compatible = "nvidia,tegra114-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -370,7 +370,7 @@ pwm: pwm@7000a000 {
 		status = "disabled";
 	};
 
-	i2c@7000c000 {
+	i2c1: i2c@7000c000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -385,7 +385,7 @@ i2c@7000c000 {
 		status = "disabled";
 	};
 
-	i2c@7000c400 {
+	i2c2: i2c@7000c400 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -400,7 +400,7 @@ i2c@7000c400 {
 		status = "disabled";
 	};
 
-	i2c@7000c500 {
+	i2c3: i2c@7000c500 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
@@ -415,7 +415,7 @@ i2c@7000c500 {
 		status = "disabled";
 	};
 
-	i2c@7000c700 {
+	i2c4: i2c@7000c700 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -430,7 +430,7 @@ i2c@7000c700 {
 		status = "disabled";
 	};
 
-	i2c@7000d000 {
+	i2c5: i2c@7000d000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -445,7 +445,7 @@ i2c@7000d000 {
 		status = "disabled";
 	};
 
-	spi@7000d400 {
+	spi1: spi@7000d400 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
@@ -460,7 +460,7 @@ spi@7000d400 {
 		status = "disabled";
 	};
 
-	spi@7000d600 {
+	spi2: spi@7000d600 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -475,7 +475,7 @@ spi@7000d600 {
 		status = "disabled";
 	};
 
-	spi@7000d800 {
+	spi3: spi@7000d800 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -490,7 +490,7 @@ spi@7000d800 {
 		status = "disabled";
 	};
 
-	spi@7000da00 {
+	spi4: spi@7000da00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -505,7 +505,7 @@ spi@7000da00 {
 		status = "disabled";
 	};
 
-	spi@7000dc00 {
+	spi5: spi@7000dc00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
@@ -520,7 +520,7 @@ spi@7000dc00 {
 		status = "disabled";
 	};
 
-	spi@7000de00 {
+	spi6: spi@7000de00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -535,14 +535,14 @@ spi@7000de00 {
 		status = "disabled";
 	};
 
-	rtc@7000e000 {
+	tegra_rtc: rtc@7000e000 {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_RTC>;
 	};
 
-	kbc@7000e200 {
+	tegra_kbc: kbc@7000e200 {
 		compatible = "nvidia,tegra114-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -682,7 +682,7 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -693,7 +693,7 @@ mmc@78000000 {
 		status = "disabled";
 	};
 
-	mmc@78000200 {
+	sdmmc2: mmc@78000200 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +704,7 @@ mmc@78000200 {
 		status = "disabled";
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -715,7 +715,7 @@ mmc@78000400 {
 		status = "disabled";
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
@@ -726,7 +726,7 @@ mmc@78000600 {
 		status = "disabled";
 	};
 
-	usb@7d000000 {
+	usb1: usb@7d000000 {
 		compatible = "nvidia,tegra114-ehci", "nvidia,tegra30-ehci";
 		reg = <0x7d000000 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -734,11 +734,11 @@ usb@7d000000 {
 		clocks = <&tegra_car TEGRA114_CLK_USBD>;
 		resets = <&tegra_car 22>;
 		reset-names = "usb";
-		nvidia,phy = <&phy1>;
+		nvidia,phy = <&usb1_phy>;
 		status = "disabled";
 	};
 
-	phy1: usb-phy@7d000000 {
+	usb1_phy: usb-phy@7d000000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d000000 0x4000>,
 		      <0x7d000000 0x4000>;
@@ -766,7 +766,7 @@ phy1: usb-phy@7d000000 {
 		status = "disabled";
 	};
 
-	usb@7d008000 {
+	usb3: usb@7d008000 {
 		compatible = "nvidia,tegra114-ehci", "nvidia,tegra30-ehci";
 		reg = <0x7d008000 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
@@ -774,11 +774,11 @@ usb@7d008000 {
 		clocks = <&tegra_car TEGRA114_CLK_USB3>;
 		resets = <&tegra_car 59>;
 		reset-names = "usb";
-		nvidia,phy = <&phy3>;
+		nvidia,phy = <&usb3_phy>;
 		status = "disabled";
 	};
 
-	phy3: usb-phy@7d008000 {
+	usb3_phy: usb-phy@7d008000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
-- 
2.37.2

