Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC3621A40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiKHRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiKHRPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:15:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC61A80F;
        Tue,  8 Nov 2022 09:15:11 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-156-208.ewe-ip-backbone.de [95.33.156.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F40CC66029A5;
        Tue,  8 Nov 2022 17:15:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667927710;
        bh=bjkHIC8gfk2bE/lvWEQPJd3CwZp3t4CM7K07FKbR+sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9Tk4PJ5ADg0+sjwssYbrRvsKMJI8UInSOfIR4xO/RIonl//L02hO0L+Cshn9rlmO
         HXEftX9rcN9c0GdyuDyfP0FJSv3zkbb5LM6xKG6J+5+kIMVR2Y4Ezh5/NaeEgsf2hA
         KU9nBfQ3mbwteR+4D05B200YH3fiX7wINtO73grODNhN/juDYyn0xrDAoH0TCzEJ9H
         m9UDNGwTKQwdzcuCDcpjWUALh6Cl3ODhrWIOTtrDmtS0pwpbuRqM2OQNxVhHbxWnE+
         9CdQvV3uAmEXh+aTe5sK1ud0tAjLsKYyKwCj3XwI8sQw08moIXP+2h9CYM5kcU8d4z
         Y2PhXZzuYoZsg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1A8CC480088; Tue,  8 Nov 2022 18:15:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 5/5] arm64: dts: rockchip: Add rock-5a board
Date:   Tue,  8 Nov 2022 18:15:00 +0100
Message-Id: <20221108171500.99599-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108171500.99599-1-sebastian.reichel@collabora.com>
References: <20221108171500.99599-1-sebastian.reichel@collabora.com>
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

Add board file for the RK3588s Rock 5A board. While the hardware
offers plenty of peripherals and connectivity this basic implementation
just handles things required to access eMMC, UART and Ethernet (i.e.
enough to successfully boot Linux).

Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/arm/rockchip.yaml     |  5 ++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 63 +++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4230881371fa..6bff4c42d815 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -744,6 +744,11 @@ properties:
           - const: rockchip,rk3588-evb1-v10
           - const: rockchip,rk3588
 
+      - description: Radxa Rock 5A
+        items:
+          - const: radxa,rock-5a
+          - const: rockchip,rk3588s
+
 additionalProperties: true
 
 ...
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 12ed53de11eb..31fa55750a0f 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -73,3 +73,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
new file mode 100644
index 000000000000..25387a000341
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "rk3588s.dtsi"
+
+/ {
+	model = "Radxa Rock 5A Board";
+	compatible = "radxa,rock-5a", "rockchip,rk3588s";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&gmac1 {
+	phy-mode = "rgmii-rxid";
+	clock_in_out = "output";
+
+	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1_miim
+		     &gmac1_tx_bus2
+		     &gmac1_rx_bus2
+		     &gmac1_rgmii_clk
+		     &gmac1_rgmii_bus>;
+
+	tx_delay = <0x3a>;
+	rx_delay = <0x3e>;
+
+	phy-handle = <&rgmii_phy1>;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		#phy-cells = <0>;
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
-- 
2.35.1

