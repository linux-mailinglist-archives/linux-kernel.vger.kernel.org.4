Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E47616D66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKBTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiKBTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:06:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7262BF7;
        Wed,  2 Nov 2022 12:06:23 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EA0E66028E3;
        Wed,  2 Nov 2022 19:06:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667415982;
        bh=1MQda8HO+asp2YDdSHvFW0nRegZrXBKBPzRi8BdE+0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULLNX7HM3PDSD3hhfnbIiHHV2zPfHshyTCPqPxXyOt6pqWgZ3PJ9rTVFFhFvpjIxw
         hitG0xcMiS+YZRXmZy0Qc8poyU9aeDKCewOGuauDkz5/i5r14QO20KsB0C1SxhT5dk
         iZE/Jz8RNlsmuRCBUeVopXIs+Fqwy3Dna2MU8owWFLgbDg1ZNHRCOIPSPHl9ap2wvV
         A7GdCLm7g1WdzBdpGuLBO6ZzZQOAIjnBJLpAAtT176GQCSJHgLuhVkwv7Vz7dszL2e
         ol2xj4deoIBTbuBTrnZVVU1GG4Y6IYxZvqw6WbUU97J9J76crg5O34qipE1qihMs9A
         kUxjF61ePCaiA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/5] arm64: dts: mediatek: asurada: Add display regulators
Date:   Wed,  2 Nov 2022 15:06:07 -0400
Message-Id: <20221102190611.283546-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102190611.283546-1-nfraprado@collabora.com>
References: <20221102190611.283546-1-nfraprado@collabora.com>
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

Add the regulators present on the Asurada platform that are used to
power the internal and external displays.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v2)

Changes in v2:
- Added missing vin-supply to regulators
- Removed min/max-microvolt from regulators that are simple switches

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 4b314435f8fd..fafca7428539 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -23,6 +23,43 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
+	pp1000_dpbrdg: regulator-1v0-dpbrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1000_dpbrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1000_dpbrdg_en_pins>;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 19 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6359_vs2_buck_reg>;
+	};
+
+	pp1000_mipibrdg: regulator-1v0-mipibrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1000_mipibrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1000_mipibrdg_en_pins>;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 129 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6359_vs2_buck_reg>;
+	};
+
+	pp1800_dpbrdg: regulator-1v8-dpbrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_dpbrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1800_dpbrdg_en_pins>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 126 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6359_vio18_ldo_reg>;
+	};
+
 	/* system wide LDO 1.8V power rail */
 	pp1800_ldo_g: regulator-1v8-g {
 		compatible = "regulator-fixed";
@@ -34,6 +71,28 @@ pp1800_ldo_g: regulator-1v8-g {
 		vin-supply = <&pp3300_g>;
 	};
 
+	pp1800_mipibrdg: regulator-1v8-mipibrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_mipibrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp1800_mipibrdg_en_pins>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 128 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6359_vio18_ldo_reg>;
+	};
+
+	pp3300_dpbrdg: regulator-3v3-dpbrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_dpbrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_dpbrdg_en_pins>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 26 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_g>;
+	};
+
 	/* system wide switching 3.3V power rail */
 	pp3300_g: regulator-3v3-g {
 		compatible = "regulator-fixed";
@@ -56,6 +115,17 @@ pp3300_ldo_z: regulator-3v3-z {
 		vin-supply = <&ppvar_sys>;
 	};
 
+	pp3300_mipibrdg: regulator-3v3-mipibrdg {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_mipibrdg";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_mipibrdg_en_pins>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_g>;
+	};
+
 	/* separately switched 3.3V power rail */
 	pp3300_u: regulator-3v3-u {
 		compatible = "regulator-fixed";
@@ -719,6 +789,48 @@ pins-wifi-kill {
 		};
 	};
 
+	pp1000_dpbrdg_en_pins: pp1000-dpbrdg-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO19__FUNC_GPIO19>;
+			output-low;
+		};
+	};
+
+	pp1000_mipibrdg_en_pins: pp1000-mipibrdg-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO129__FUNC_GPIO129>;
+			output-low;
+		};
+	};
+
+	pp1800_dpbrdg_en_pins: pp1800-dpbrdg-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO126__FUNC_GPIO126>;
+			output-low;
+		};
+	};
+
+	pp1800_mipibrdg_en_pins: pp1800-mipibrd-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO128__FUNC_GPIO128>;
+			output-low;
+		};
+	};
+
+	pp3300_dpbrdg_en_pins: pp3300-dpbrdg-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO26__FUNC_GPIO26>;
+			output-low;
+		};
+	};
+
+	pp3300_mipibrdg_en_pins: pp3300-mipibrdg-en-pins {
+		pins-en {
+			pinmux = <PINMUX_GPIO127__FUNC_GPIO127>;
+			output-low;
+		};
+	};
+
 	pp3300_wlan_pins: pp3300-wlan-pins {
 		pins-pcie-en-pp3300-wlan {
 			pinmux = <PINMUX_GPIO143__FUNC_GPIO143>;
-- 
2.38.1

