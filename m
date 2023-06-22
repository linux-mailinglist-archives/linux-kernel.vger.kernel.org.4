Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5521273A89B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFVSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFVSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:51:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2D619AF;
        Thu, 22 Jun 2023 11:51:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35MIp3R3098594;
        Thu, 22 Jun 2023 13:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687459863;
        bh=UkJIUEvpcmY3eTc6Zb56DOVcjSEVJCb4axi5H8lFzaM=;
        h=From:To:CC:Subject:Date;
        b=RviaVqOjmNqohXY9MCf222pka/f5488yrZdyIpl2AtYBJiQX950NDEvHPa2YmeRBQ
         KKYmRwPxLxMko6oMGMdftsVR7MGxToCLJDBD+8rQnljoCiVjmOnnAYF/6Qy8TUE6fe
         jkS6huDy2frODCb9yoNbUKevzE/Lymk+NMD5JUqA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35MIp2G7009730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Jun 2023 13:51:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Jun 2023 13:51:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Jun 2023 13:51:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35MIp1Dx023454;
        Thu, 22 Jun 2023 13:51:01 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <b-kapoor@ti.com>
Subject: [PATCH v4] arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain
Date:   Fri, 23 Jun 2023 00:21:00 +0530
Message-ID: <20230622185100.12197-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Changelog v3->v4 :
- Modified mux controller names

Link to v3 : https://lore.kernel.org/all/20230526165505.45172-1-b-kapoor@ti.com/

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 46 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 12 +++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index b4b9edfe2d12..07016c87f4da 100644
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
@@ -353,3 +385,17 @@ adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
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
index 6930efff8a5a..84e50e891ee2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -31,6 +31,18 @@ secure_ddr: optee@9e800000 {
 		};
 	};
 
+	mux0: mux-controller@0 {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	mux1: mux-controller@1 {
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

