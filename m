Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70464CF55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiLNSXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiLNSW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:22:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5429352;
        Wed, 14 Dec 2022 10:22:55 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-169-234.ewe-ip-backbone.de [95.33.169.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE1596602C67;
        Wed, 14 Dec 2022 18:22:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671042174;
        bh=++tknHUSAH1WlAB7rUlhaGwZLeMI3KHDV+YrO/4Al3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZDD1uH8tmQBfJbytVFrgK6CHc+UeKzVAY3sWnMWqOuN3mMPyoDV0RwO8axPjRNhH
         0xLAvJ3ShVG/cM4+dVaYmmFelHLrfUzxBQhjdaoq4+Fp3MCNMe8lk2zeyhibHR2sg+
         HdePN+ETGAaMyjNztAe5vf9DoP6NMTKwLdV26sWX9YJ5IfZ4Fgo8mEl7yen784qeoS
         /Mr3Qsq/WryZ6H4i0i7XkYKR2/JYiHWfB7L7FCotu7deKMrTryCYdzynPAmnKvRUaq
         KxzwoXFl9+Jr2XF7NFwLZpfLlOjH5mKWxIj2oteNmmao4Eot5sXz7VrcodaguBIePv
         I5dJJVYXOS+8Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C7BE648011D; Wed, 14 Dec 2022 19:22:48 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCHv6 6/7] arm64: dts: rockchip: Add rock-5a board
Date:   Wed, 14 Dec 2022 19:22:46 +0100
Message-Id: <20221214182247.79824-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214182247.79824-1-sebastian.reichel@collabora.com>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
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

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 73 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts

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
index 000000000000..70db09230ec6
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3588s.dtsi"
+
+/ {
+	model = "Radxa Rock 5A Board";
+	compatible = "radxa,rock-5a", "rockchip,rk3588s";
+
+	aliases {
+		mmc1 = &sdhci;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-rxid";
+	pinctrl-0 = <&gmac1_miim
+		     &gmac1_tx_bus2
+		     &gmac1_rx_bus2
+		     &gmac1_rgmii_clk
+		     &gmac1_rgmii_bus>;
+	pinctrl-names = "default";
+	tx_delay = <0x3a>;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@1 {
+		/* RTL8211F */
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8211f_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	rtl8211f {
+		rtl8211f_rst: rtl8211f-rst {
+			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
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
2.39.0

