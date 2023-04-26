Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAEA6EEE07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbjDZGHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbjDZGHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:07:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459612718;
        Tue, 25 Apr 2023 23:07:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33Q66Q7j080649;
        Wed, 26 Apr 2023 01:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682489186;
        bh=TxVq+Vq2+FxY2NTgtQslEaG70KbJjS8E/AQ7b5gYUGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mzJIChlC10AtIf8tnmmVvRmbZKNuhLiNGaxwHOHARmmpROywzDARv/O4LBVuzhh63
         HbEl+/ZeeZ5+vEQGmpz2rtvSGEQWDUQMh+aRHczgb6rUrcAH68wIexUi+IA+stlHYz
         T3CDGUTAQaTnxf+TdSzlYVtWrqJuXIooydsoozEg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33Q66QeO078544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 01:06:26 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 01:06:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 01:06:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33Q66O1K073547;
        Wed, 26 Apr 2023 01:06:25 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 1/2] arm64: dts/ti: am65x: Add Rocktech OLDI panel DT overlay
Date:   Wed, 26 Apr 2023 11:36:11 +0530
Message-ID: <20230426060612.19271-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230426060612.19271-1-a-bhatia1@ti.com>
References: <20230426060612.19271-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jyri Sarha <jsarha@ti.com>

The OLDI-LCD1EVM add on board has Rocktech RK101II01D-CT panel[1] with
integrated touch screen. The integrated touch screen is Goodix GT928.
Add DT nodes for these and connect the endpoint nodes with DSS.

[1]: Product datasheet
https://www.digimax.it/media_import/DISPLAY/ROCKTECH/TFT%20LCD/RK101II01D-CT/RK101II01D-CT_DS_001.pdf

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
[abhatia1@ti.com: Make cosmetic and 6.1 DTSO syntax changes]
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 ...am654-base-board-rocktech-rk101-panel.dtso | 69 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 6acd12409d59..3e6c4aa24f85 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -20,12 +20,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 
 # Boards with AM65x SoC
+k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 
 # Boards with J7200 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
new file mode 100644
index 000000000000..aed6dcf3bd7d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&{/} {
+	display0 {
+		compatible = "rocktech,rk101ii01d-ct";
+		backlight = <&lcd_bl>;
+		enable-gpios = <&pca9555 8 GPIO_ACTIVE_HIGH>;
+		port {
+			lcd_in0: endpoint {
+				remote-endpoint = <&oldi_out0>;
+			};
+		};
+	};
+
+	lcd_bl: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels =
+			<0 32 64 96 128 160 192 224 255>;
+		default-brightness-level = <8>;
+	};
+};
+
+&dss {
+	status = "okay";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+
+		oldi_out0: endpoint {
+			remote-endpoint = <&lcd_in0>;
+		};
+	};
+};
+
+&main_i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt928";
+		reg = <0x14>;
+
+		interrupt-parent = <&pca9554>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <1280>;
+		touchscreen-size-y = <800>;
+
+		reset-gpios = <&pca9555 9 GPIO_ACTIVE_HIGH>;
+		irq-gpios = <&pca9554 3 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.39.1

