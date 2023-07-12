Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7B474FF68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGLGdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjGLGdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:33:21 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86521BC1;
        Tue, 11 Jul 2023 23:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yizx/bWe4mJQHublra1LDakim5cyR3NpInTAKLCC6nQ=; b=vveAE67dVX8D/ObrLCto8MEsFK
        IE2eab8eyvxnHuQYuZA+ZUm9VqIZMkhMkR02PHTULUhOA1XFzqq/ehmgp7c5FNkmnyGZBqyTkfbpx
        2o7iD2c62IYAgF3StcCS4b730jJO0281usBkd5/XMnS3onyQu32DFw0EApXXMKBHPhC8I33bgipw0
        YKSRjK4oexzky9LVL4z/m9hiT5GdQfSK9wt2dlbHcMHnaiibKoG5mFr6d9+9caDJOnfz0MEwFlQe0
        10/l7nOfp+C0XpqbVKeVH/wJhxXNuepLSybJNRaobyWlm9ZalDBZW3WEamRoe/BDdJlZQ5FQpzQbU
        +oNCjp/Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJTN6-000ANs-AV; Wed, 12 Jul 2023 08:30:44 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJTN5-00020e-Jv; Wed, 12 Jul 2023 08:30:43 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     a.fatoum@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
Date:   Wed, 12 Jul 2023 08:29:53 +0200
Message-Id: <20230712062954.2194505-8-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712062954.2194505-1-sean@geanix.com>
References: <20230712062954.2194505-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Octavo OSD32MP1-RED development board.

General features:
 - STM32MP157C
 - 512MB DDR3
 - CAN-FD
 - HDMI
 - USB-C OTG
 - UART

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
Changes since v2:
 - Reordered phandles alfabetically
 - Added devicetree to Makefile

 arch/arm/boot/dts/Makefile                    |   3 +-
 .../arm/boot/dts/stm32mp157c-osd32mp1-red.dts | 225 ++++++++++++++++++
 2 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..a57e223eb0eb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1266,7 +1266,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157c-ev1.dtb \
 	stm32mp157c-ev1-scmi.dtb \
 	stm32mp157c-lxa-mc1.dtb \
-	stm32mp157c-odyssey.dtb
+	stm32mp157c-odyssey.dtb \
+	stm32mp157c-osd32mp1-red.dts
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts
new file mode 100644
index 000000000000..dc4ad28e69b1
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Geanix ApS 2023 - All Rights Reserved
+ * Author: Sean Nyekjaer <sean@geanix.com>
+ */
+
+/dts-v1/;
+
+#include "stm32mp157.dtsi"
+#include "stm32mp15xc.dtsi"
+#include "stm32mp15xx-osd32.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
+/ {
+	model = "Octavo OSD32MP1 RED board";
+	compatible = "oct,stm32mp157c-osd32-red", "oct,stm32mp15xx-osd32", "st,stm32mp157";
+
+	aliases {
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	led-controller-0 {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "heartbeat";
+			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&crc1 {
+	status = "okay";
+};
+
+&dts {
+	status = "okay";
+};
+
+&ethernet0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_a>;
+	phy-mode = "rgmii-id";
+	max-speed = <1000>;
+	phy-handle = <&phy0>;
+	st,eth-clk-sel;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@3 {
+			reg = <3>;
+		};
+	};
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	status = "okay";
+	i2c-scl-rising-time-ns = <100>;
+	i2c-scl-falling-time-ns = <7>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	hdmi-transmitter@39 {
+		compatible = "sil,sii9022";
+		reg = <0x39>;
+		reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpiog>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ltdc_pins_e>;
+		pinctrl-1 = <&ltdc_sleep_pins_e>;
+		status = "okay";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				sii9022_in: endpoint {
+					remote-endpoint = <&ltdc_ep0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				sii9022_tx_endpoint: endpoint {
+					remote-endpoint = <&i2s2_endpoint>;
+				};
+			};
+		};
+	};
+};
+
+&i2s2 {
+	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc CK_PER>, <&rcc PLL3_R>;
+	clock-names = "pclk", "i2sclk", "x8k", "x11k";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2s2_pins_b>;
+	pinctrl-1 = <&i2s2_sleep_pins_b>;
+	status = "okay";
+
+	i2s2_port: port {
+		i2s2_endpoint: endpoint {
+			remote-endpoint = <&sii9022_tx_endpoint>;
+			format = "i2s";
+			mclk-fs = <256>;
+		};
+	};
+};
+
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_ep0_out: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
+&m_can1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&m_can1_pins_d>;
+	pinctrl-1 = <&m_can1_sleep_pins_d>;
+	status = "okay";
+};
+
+&pwr_regulators {
+	vdd-supply = <&vdd>;
+	vdd_3v3_usbfs-supply = <&vdd_usb>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	cd-gpios = <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_d>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_d>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&v3v3>;
+	vqmmc-supply = <&vdd>;
+	mmc-ddr-3_3v;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-1 = <&uart4_sleep_pins_a>;
+	pinctrl-2 = <&uart4_idle_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};
+
+&usbh_ehci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
+&usbh_ohci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
+&usbotg_hs {
+	vbus-supply = <&vbus_otg>;
+};
+
+&usbphyc {
+	status = "okay";
+};
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+};
-- 
2.40.0

