Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7646B828A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCMUSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCMUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:18:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904988894;
        Mon, 13 Mar 2023 13:17:19 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1B2F6603097;
        Mon, 13 Mar 2023 20:17:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678738630;
        bh=oms+VXSvNOlOKrtypQptMQEU/VwkxQDe4EDj53ZzVeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuZvSr7juNCA1/AytIc++jnFjvhgqEcUZDWVitOhafsWlAyjuW7lCMTurlhdB+vcd
         LwVeYpBlmr7Fkyo/XY2EHpwzwgVHSAxt230Zcbb2znpUZdgXezPm/NI9BDInoKQrU/
         dNzSakupOxUwyoqVJqyaiZTq7TsJ7f44CYbD7VeoyTfSyek7HHW3YGYkoA8QSDQoyp
         8xzFjyzCFsa8tTYGMhII+IOg3zt0x86lkj136kwLrF4efNViUF7Rh+hmqDmYA9I8/O
         D6pJRqJZKhjXZdXazzR0gF0XpBpvnmz245s2m8LB44q2DrcXGns8GoxUPsdyLfWHh4
         beNPKuJC6dIgw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/5] arm64: dts: mediatek: Remove asurada-audio dtsi files
Date:   Mon, 13 Mar 2023 16:14:41 -0400
Message-Id: <20230313201443.2275101-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313201443.2275101-1-nfraprado@collabora.com>
References: <20230313201443.2275101-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't enough users of the common asurada-audio dtsi files to
justify having them. It is simpler to just have the audio nodes directly
on the board files.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 .../mt8192-asurada-audio-rt1015p-rt5682.dtsi  | 19 -------------
 .../mt8192-asurada-audio-rt1015p.dtsi         | 26 -----------------
 .../mediatek/mt8192-asurada-audio-rt5682.dtsi | 21 --------------
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 19 ++++++++++++-
 .../mediatek/mt8192-asurada-spherion-r0.dts   | 19 ++++++++++++-
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 28 +++++++++++++++++++
 6 files changed, 64 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
deleted file mode 100644
index f521f50d448f..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2020 Google LLC
- */
-
-#include "mt8192-asurada-audio-rt5682.dtsi"
-#include "mt8192-asurada-audio-rt1015p.dtsi"
-
-&sound {
-	compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682";
-
-	speaker-codecs {
-		sound-dai = <&rt1015p>;
-	};
-
-	headset-codec {
-		sound-dai = <&rt5682 0>;
-	};
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
deleted file mode 100644
index e5743789934e..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2022 MediaTek Inc.
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/mt8192-pinfunc.h>
-
-/ {
-	rt1015p: audio-codec {
-		compatible = "realtek,rt1015p";
-		pinctrl-names = "default";
-		pinctrl-0 = <&rt1015p_pins>;
-		sdb-gpios = <&pio 147 GPIO_ACTIVE_HIGH>;
-		#sound-dai-cells = <0>;
-	};
-};
-
-&pio {
-	rt1015p_pins: rt1015p-default-pins {
-		pins {
-			pinmux = <PINMUX_GPIO147__FUNC_GPIO147>;
-			output-low;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi
deleted file mode 100644
index 05e48b870a92..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2022 MediaTek Inc.
- */
-
-&i2c1 {
-	rt5682: audio-codec@1a {
-		compatible = "realtek,rt5682i";
-		reg = <0x1a>;
-		interrupts-extended = <&pio 18 IRQ_TYPE_LEVEL_LOW>;
-		realtek,jd-src = <1>;
-		realtek,btndet-delay = <16>;
-		#sound-dai-cells = <1>;
-
-		AVDD-supply = <&mt6359_vio18_ldo_reg>;
-		DBVDD-supply = <&mt6359_vio18_ldo_reg>;
-		LDO1-IN-supply = <&mt6359_vio18_ldo_reg>;
-		MICVDD-supply = <&pp3300_g>;
-		VBAT-supply = <&pp3300_ldo_z>;
-	};
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index 43a823990a92..bad063a7d76b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -4,7 +4,6 @@
  */
 /dts-v1/;
 #include "mt8192-asurada.dtsi"
-#include "mt8192-asurada-audio-rt1015p-rt5682.dtsi"
 
 / {
 	model = "Google Hayato rev1";
@@ -40,6 +39,24 @@ CROS_STD_MAIN_KEYMAP
 	>;
 };
 
+&rt5682 {
+	compatible = "realtek,rt5682i";
+	realtek,btndet-delay = <16>;
+	VBAT-supply = <&pp3300_ldo_z>;
+};
+
+&sound {
+	compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682";
+
+	speaker-codecs {
+		sound-dai = <&rt1015p>;
+	};
+
+	headset-codec {
+		sound-dai = <&rt5682 0>;
+	};
+};
+
 &touchscreen {
 	compatible = "hid-over-i2c";
 	post-power-on-delay-ms = <10>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index c6ad10cec95e..bc88866ab2f5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -4,7 +4,6 @@
  */
 /dts-v1/;
 #include "mt8192-asurada.dtsi"
-#include "mt8192-asurada-audio-rt1015p-rt5682.dtsi"
 #include <dt-bindings/leds/common.h>
 
 / {
@@ -58,6 +57,24 @@ CROS_STD_MAIN_KEYMAP
 	>;
 };
 
+&rt5682 {
+	compatible = "realtek,rt5682i";
+	realtek,btndet-delay = <16>;
+	VBAT-supply = <&pp3300_ldo_z>;
+};
+
+&sound {
+	compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682";
+
+	speaker-codecs {
+		sound-dai = <&rt1015p>;
+	};
+
+	headset-codec {
+		sound-dai = <&rt5682 0>;
+	};
+};
+
 &touchscreen {
 	compatible = "elan,ekth3500";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 1b1669309291..b526b3b7a627 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -210,6 +210,14 @@ wifi_restricted_dma_region: wifi@c0000000 {
 		};
 	};
 
+	rt1015p: audio-codec {
+		compatible = "realtek,rt1015p";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rt1015p_pins>;
+		sdb-gpios = <&pio 147 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+
 	sound: sound {
 		mediatek,platform = <&afe>;
 		mediatek,hdmi-codec = <&anx_bridge_dp>;
@@ -316,6 +324,19 @@ &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
+
+	rt5682: audio-codec@1a {
+		/* Realtek RT5682i or RT5682s, sharing the same configuration */
+		reg = <0x1a>;
+		interrupts-extended = <&pio 18 IRQ_TYPE_LEVEL_LOW>;
+		realtek,jd-src = <1>;
+		#sound-dai-cells = <1>;
+
+		AVDD-supply = <&mt6359_vio18_ldo_reg>;
+		DBVDD-supply = <&mt6359_vio18_ldo_reg>;
+		LDO1-IN-supply = <&mt6359_vio18_ldo_reg>;
+		MICVDD-supply = <&pp3300_g>;
+	};
 };
 
 &i2c2 {
@@ -1313,6 +1334,13 @@ pins-inhibit {
 		};
 	};
 
+	rt1015p_pins: rt1015p-default-pins {
+		pins {
+			pinmux = <PINMUX_GPIO147__FUNC_GPIO147>;
+			output-low;
+		};
+	};
+
 	scp_pins: scp-pins {
 		pins-vreq-vao {
 			pinmux = <PINMUX_GPIO195__FUNC_SCP_VREQ_VAO>;
-- 
2.39.2

