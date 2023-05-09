Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865526FC3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjEIKYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjEIKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:24:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF4ED878;
        Tue,  9 May 2023 03:24:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349ANvjD084607;
        Tue, 9 May 2023 05:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683627837;
        bh=LcRwRQMLV6SPoCOcWxkwzKtbCgDl7O50RHHZl0vJYgE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NOweRjefvcdbgz69fP8LtfTzd2vzT5uLZ8A2ZOhDNxJn2gtev2pw/CJWdKKr+7AWQ
         Yqc0qy8itDClOryUb1v6uj/GRDgDlPJ2WLKFG5hXmh2okgMh4/jP8yOlsoxQk9HUzl
         M6Y8a0j6tQWB6rtRhDWwjy0P8qR7LKnhX0tiJb50=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349ANvKa021919
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 05:23:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 05:23:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 05:23:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ANuGp032137;
        Tue, 9 May 2023 05:23:56 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v4 1/2] arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay
Date:   Tue, 9 May 2023 15:53:53 +0530
Message-ID: <20230509102354.10116-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509102354.10116-1-a-bhatia1@ti.com>
References: <20230509102354.10116-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
This panel connects with AM65 GP-EVM[2].

Add DT nodes for these and connect the endpoint nodes with DSS.

[1]: Panel link
https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT

[2]: AM654 LCD EVM:
https://www.ti.com/tool/TMDSLCD1EVM

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
[abhatia1@ti.com: Make cosmetic and 6.4 kernel DTSO syntax changes]
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 ...am654-base-board-rocktech-rk101-panel.dtso | 71 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c83c9d772b81..47b0d257b508 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -22,12 +22,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
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
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
new file mode 100644
index 000000000000..b507e2bd444e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
+ * Panel Link: https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT
+ * AM654 LCD EVM: https://www.ti.com/tool/TMDSLCD1EVM
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
2.40.1

