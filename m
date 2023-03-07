Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7F6AE628
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCGQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCGQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:17:44 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8733488894;
        Tue,  7 Mar 2023 08:17:39 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GHGIp085466;
        Tue, 7 Mar 2023 10:17:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678205836;
        bh=+iDJLKkp5fPd5QQ1ox0RwPSjTpQIRcrWt9oaITgZN14=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u2uhtIC9j9DrtDVn8ZFrqy1481CcDVTSn3inax8Fjr/keStpiZhQv+BchN9Mdn/Cs
         nPTUZQU8JqAOCjoZnWvbR90ebD4nieRqR+XIIfXNW+3eD8EEbBuwgZpalWvLPH2pGa
         jwiG0sYasByzLXBdWGGwdqULrsh/LybI1QkCGDrs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GHG9a008394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:17:16 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:17:15 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:17:15 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GHFEv003079;
        Tue, 7 Mar 2023 10:17:15 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 1/3] ARM: dts: ti: Add AM57xx GP EVM board support
Date:   Tue, 7 Mar 2023 10:17:13 -0600
Message-ID: <20230307161715.15209-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307161715.15209-1-afd@ti.com>
References: <20230307161715.15209-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM57xx GP EVM boards are built on top the AM57xx BeagleBoard-X15.
The EVM extends the BeagleBoard by adding a touchscreen, some buttons,
and a handful of peripheral extension slots.

Being a plugin extension of an existing standalone board; we define
the am57xx-evm as a composite-DTB of the base am57xx-beagle-x15
and a new am57xx-evm overlay.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/Makefile        |   2 +
 arch/arm/boot/dts/am57xx-evm.dtso | 127 ++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..7f850cf5f063 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -994,10 +994,12 @@ dtb-$(CONFIG_SOC_OMAP5) += \
 	omap5-igep0050.dtb \
 	omap5-sbc-t54.dtb \
 	omap5-uevm.dtb
+am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
 dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-beagle-x15.dtb \
 	am57xx-beagle-x15-revb1.dtb \
 	am57xx-beagle-x15-revc.dtb \
+	am57xx-evm.dtb \
 	am5729-beagleboneai.dtb \
 	am57xx-cl-som-am57x.dtb \
 	am57xx-sbc-am57x.dtb \
diff --git a/arch/arm/boot/dts/am57xx-evm.dtso b/arch/arm/boot/dts/am57xx-evm.dtso
new file mode 100644
index 000000000000..12385a31061e
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-evm.dtso
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DT overlay for AM57xx GP EVM boards
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+&{/} {
+	compatible = "ti,am5728-evm", "ti,am572x-beagle-x15", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
+	model = "TI AM5728 EVM";
+
+	aliases {
+		display0 = "/display";
+		display1 = "/connector"; // Fixme: &lcd0 and &hdmi0 could be
+					 // resolved here correcly based on
+					 // information in the base dtb symbol
+					 // table with a fix in dtc
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-user1 {
+			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+			label = "USER1";
+			linux,code = <BTN_1>;
+		};
+
+		button-user2 {
+			gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+			label = "USER2";
+			linux,code = <BTN_2>;
+		};
+
+		button-user3 {
+			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
+			label = "USER3";
+			linux,code = <BTN_3>;
+		};
+
+		button-user4 {
+			gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+			label = "USER4";
+			linux,code = <BTN_4>;
+		};
+
+		button-user5 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+			label = "USER5";
+			linux,code = <BTN_5>;
+		};
+	};
+
+	lcd0: display {
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
+		backlight = <&lcd_bl>;
+		enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+		label = "lcd";
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
+
+	lcd_bl: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 243 245 247 249 251 252 253 255>;
+		default-brightness-level = <8>;
+		pwms = <&ehrpwm1 0 50000 0>;
+	};
+};
+
+&ehrpwm1 {
+	status = "okay";
+};
+
+&epwmss1 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@5c {
+		compatible = "pixcir,pixcir_tangoc";
+		attb-gpio = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+		reg = <0x5c>;
+		reset-gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+	};
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&dss {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			dpi_out: endpoint {
+				data-lines = <24>;
+				remote-endpoint = <&lcd_in>;
+			};
+		};
+	};
+};
-- 
2.39.2

