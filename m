Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD85E5EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiIVJtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiIVJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:49:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D0D4AAA;
        Thu, 22 Sep 2022 02:49:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4E05660221F;
        Thu, 22 Sep 2022 10:49:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663840156;
        bh=aRbfk1mhUI8dAkF85RnEwt7brGuOKIQtd68vjz91JhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azxjEguhsDUEOz0xDuinewwHFTLJS0stz6G3zouz9QjS7aepKc6POfoeaCHVWlbNr
         7qKEzBztUrEJ2YLcjUdofbfC+roVyqCAXB3CP824gBTJTWHFYzmEDpJ9s7wrXDzOFk
         buChQveFUXxD4+DZPAnRrYUJ8HRh4rrqt0upBIv0VXS6Iot6pwETLY7/gJd7pkiPgb
         jLF5BrczFb453x3QNvKDd+4SblxZn6H7HM4cuS7kMqRhpBRcGx9qRGTMTNzWUMuh6/
         bHaNT1m48J5rODZxMNcaRF2armeRRiAAxF4QNlNOUfnbl98Z8AgBtvmtA++rVEFzl6
         lpqd30rbEsYwQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/4] arm64: dts: mediatek: cherry: Add external codecs and speaker amplifier
Date:   Thu, 22 Sep 2022 11:49:07 +0200
Message-Id: <20220922094908.41623-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
References: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire Cherry family has two digital microphones, for which
we use the generic dmic-codec, linked to the MT6359 PMIC.
Moreover, it uses a Realtek RT1019p amplifier for the speakers
and has either a Realtek RT5682i or RT5682s audio codec on I2C2:
specifically, RT5682i is found on Tomato's rev 1 and rev 2 boards,
while RT5682s is found in rev3 and rev4 boards.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  5 +++
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  5 +++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  5 +++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 37 +++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 3348ba69ff6c..3767b49ea896 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -10,6 +10,11 @@ / {
 	compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
 };
 
+&audio_codec {
+	compatible = "realtek,rt5682i";
+	realtek,btndet-delay = <16>;
+};
+
 &ts_10 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 4669e9d917f8..0ed83a79d680 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -10,6 +10,11 @@ / {
 	compatible = "google,tomato-rev2", "google,tomato", "mediatek,mt8195";
 };
 
+&audio_codec {
+	compatible = "realtek,rt5682i";
+	realtek,btndet-delay = <16>;
+};
+
 &pio_default {
 	pins-low-power-hdmi-disable {
 		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index 5021edd02f7c..c47b341e98fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -11,6 +11,11 @@ / {
 		     "google,tomato", "mediatek,mt8195";
 };
 
+&audio_codec {
+	compatible = "realtek,rt5682s";
+	realtek,amic-delay-ms = <250>;
+};
+
 &pio_default {
 	pins-low-power-hdmi-disable {
 		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 3bc624e6f499..95e93b791432 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -26,6 +26,12 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <50>;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
@@ -136,6 +142,14 @@ adsp_device_mem: memory@60e80000 {
 			no-map;
 		};
 	};
+
+	spk_amplifier: rt1019p {
+		compatible = "realtek,rt1019p";
+		label = "rt1019p";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rt1019p_pins_default>;
+		sdb-gpios = <&pio 100 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &adsp {
@@ -185,6 +199,17 @@ &i2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
+
+	audio_codec: codec@1a {
+		/* Realtek RT5682i or RT5682s, sharing the same configuration */
+		reg = <0x1a>;
+		interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
+		realtek,jd-src = <1>;
+
+		AVDD-supply = <&mt6359_vio18_ldo_reg>;
+		MICVDD-supply = <&pp3300_z2>;
+		VBAT-supply = <&pp3300_z5>;
+	};
 };
 
 &i2c3 {
@@ -289,6 +314,11 @@ &mmc1 {
 	vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
 };
 
+&mt6359codec {
+	mediatek,dmic-mode = <1>;  /* one-wire */
+	mediatek,mic-type-0 = <2>; /* DMIC */
+};
+
 /* for CPU-L */
 &mt6359_vcore_buck_reg {
 	regulator-always-on;
@@ -723,6 +753,13 @@ pins-low-power-pupd {
 		};
 	};
 
+	rt1019p_pins_default: rt1019p-default-pins {
+		pins-amp-sdb {
+			pinmux = <PINMUX_GPIO100__FUNC_GPIO100>;
+			output-low;
+		};
+	};
+
 	scp_pins: scp-default-pins {
 		pins-vreq {
 			pinmux = <PINMUX_GPIO76__FUNC_SCP_VREQ_VAO>;
-- 
2.37.2

