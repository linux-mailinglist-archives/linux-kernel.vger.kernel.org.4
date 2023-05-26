Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B398A712B28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEZQz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjEZQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:55:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCB1135;
        Fri, 26 May 2023 09:55:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34QGt8Em062756;
        Fri, 26 May 2023 11:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685120108;
        bh=1Rp/YGPWQR5raUvf1gwaPCzH4H0z7g5XN7OjXo/G8W4=;
        h=From:To:CC:Subject:Date;
        b=IDp9399ehTmiUkuTEDPRKRTS2MYH742D9SyvZO35CdYx0Au7rXB95MQJk0w3VA6qq
         n9gGwxW/xOTRZ+T6GzXHHXUvJ4IbRpqWsIjsS2vmzKOPrRKYT4TE6CRn62tD75Cvla
         i9ug38lDcyVlq4321R46wCIke38sAvHY+xW4JSHo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34QGt8Nm120452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 May 2023 11:55:08 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 May 2023 11:55:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 May 2023 11:55:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34QGt6h0021277;
        Fri, 26 May 2023 11:55:07 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <jm@ti.com>, <b-kapoor@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain
Date:   Fri, 26 May 2023 22:25:05 +0530
Message-ID: <20230526165505.45172-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.39.2
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

CAN instances 3 and 5 in the main domain are brought on the common
processor board through header J27 and J28. The CAN High and Low lines
from the SoC are routed through a mux on the SoM. The select lines need
to be set for the CAN signals to get connected to the transceivers on
the common processor board. Threfore, add respective mux, transceiver
dt nodes to add support for these CAN instances.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Changelog v2->v3: Removed tiL6.1 subject prefix

Link to v2 : https://lore.kernel.org/all/20230523085021.22524-1-b-kapoor@ti.com/

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 46 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 12 +++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index a7aa6cf08acd..f07663bbea16 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -27,6 +27,8 @@ aliases {
 		can0 = &main_mcan16;
 		can1 = &mcu_mcan0;
 		can2 = &mcu_mcan1;
+		can3 = &main_mcan3;
+		can4 = &main_mcan5;
 	};
 
 	evm_12v0: fixedregulator-evm12v0 {
@@ -107,6 +109,22 @@ transceiver2: can-phy2 {
 		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
 	};
 
+	transceiver3: can-phy3 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp2 7 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux0 1>;
+	};
+
+	transceiver4: can-phy4 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux1 1>;
+	};
 };
 
 &main_pmx0 {
@@ -144,6 +162,20 @@ vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
 			J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
 		>;
 	};
+
+	main_mcan3_pins_default: main-mcan3-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x080, PIN_INPUT, 0) /* (U26) MCASP0_AXR4.MCAN3_RX */
+			J721S2_IOPAD(0x07c, PIN_OUTPUT, 0) /* (T27) MCASP0_AXR3.MCAN3_TX */
+		>;
+	};
+
+	main_mcan5_pins_default: main-mcan5-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x03c, PIN_INPUT, 0) /* (U27) MCASP0_AFSX.MCAN5_RX */
+			J721S2_IOPAD(0x038, PIN_OUTPUT, 0) /* (AB28) MCASP0_ACLKX.MCAN5_TX */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -309,3 +341,17 @@ &mcu_mcan1 {
 	pinctrl-0 = <&mcu_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&main_mcan3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan3_pins_default>;
+	phys = <&transceiver3>;
+};
+
+&main_mcan5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan5_pins_default>;
+	phys = <&transceiver4>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 6930efff8a5a..e74bc5141903 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -31,6 +31,18 @@ secure_ddr: optee@9e800000 {
 		};
 	};
 
+	mux0: mux-controller0 {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	mux1: mux-controller1 {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
+	};
+
 	transceiver0: can-phy0 {
 		/* standby pin has been grounded by default */
 		compatible = "ti,tcan1042";
-- 
2.39.2

