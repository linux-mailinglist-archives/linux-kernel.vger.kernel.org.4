Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA15FF14B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJNP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJNP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:26:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C87317DE;
        Fri, 14 Oct 2022 08:26:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29EFQj8J070497;
        Fri, 14 Oct 2022 10:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665761205;
        bh=dh/QVo7y7r93QkTVs9L/ZAW0mWGX3bYcl90GcYwdH2c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FLgrZWyaeOTOQ0vvt05iz/zqERwow88lKVjGZzkCUyIDIy1AVl4sODNpUyD7tOKFp
         3lCxgHQArUNCgRSyW5vhBVcMBmI6WyIAZ3UPVWH2xX5g0js5Dssr/GPDSyvQHLg92I
         aTckNBIdEdmTTX6gMvrIPuFwBsliUwFKFBZE7yJ0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29EFQjRl043683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Oct 2022 10:26:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 14
 Oct 2022 10:26:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 14 Oct 2022 10:26:45 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29EFQhPB102295;
        Fri, 14 Oct 2022 10:26:44 -0500
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] ARM: dts: ti: Add AM57xx GP EVM board support
Date:   Fri, 14 Oct 2022 10:26:42 -0500
Message-ID: <20221014152643.28745-2-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014152643.28745-1-afd@ti.com>
References: <20221014152643.28745-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 6aa7dc4db2fc..767220502021 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -984,10 +984,12 @@ dtb-$(CONFIG_SOC_OMAP5) += \
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
index 000000000000..6678aaef66ee
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
+	pixcir_ts@5c {
+		compatible = "pixcir,pixcir_tangoc";
+		attb-gpio = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <4 0>;
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
2.37.3

