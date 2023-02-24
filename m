Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA36A1A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBXK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBXK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:27:09 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7549897;
        Fri, 24 Feb 2023 02:26:27 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31OAP6eW036117;
        Fri, 24 Feb 2023 04:25:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677234306;
        bh=uIPX1sM7e6sm/qb/7qqD9JSMKXe70hYesfvGorK2kgE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mRGFvaJG/w/2Xi6jkh4At+zy6aLWFy6+0Q8702v+/QMfYSg7AimhtLxD0sT6oLXvh
         VP+/A/j4CfP2K7F3d5/8o5fhNjf7aHroSMqFKqMQdsp60QbUCw2wGoNkOD6YUsChzB
         fgcLwP4kzSP5S+B96/4Ge6GQJO7PoGwXcogvpwIk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31OAP61G124357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Feb 2023 04:25:06 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Feb 2023 04:25:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Feb 2023 04:25:05 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31OAOcXg016652;
        Fri, 24 Feb 2023 04:25:02 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 6/8] arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes
Date:   Fri, 24 Feb 2023 15:54:36 +0530
Message-ID: <20230224102438.6541-7-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230224102438.6541-1-r-gunasekaran@ti.com>
References: <20230224102438.6541-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

J721S2 has an OSPI NOR flash on its SOM connected the OSPI0 instance and a
QSPI NOR flash on the common processor board connected to the OSPI1
instance. Add support for the same

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes from v10:
* Removed Link tag from commit message

Changes from v9:
* Enabled fss and ospi nodes

Changes from v8:
* No change

Changes from v7:
* No change

Changes from v6:
* No change

Changes from v5:
* Removed Cc tags from commit message

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* No change

Changes from v1:
* No change

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 39 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 43 +++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index fa38940fe6cd..76b420379645 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -206,6 +206,20 @@
 			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
 		>;
 	};
+
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
+			J721S2_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
+			J721S2_WKUP_IOPAD(0x060, PIN_OUTPUT, 0) /* (C21) MCU_OSPI1_CSn1 */
+			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
+			J721S2_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
+			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
+			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
+			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
+			J721S2_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
+		>;
+	};
 };
 
 &main_gpio2 {
@@ -347,6 +361,31 @@
 	maximum-speed = "high-speed";
 };
 
+&fss {
+	status = "okay";
+};
+
+&ospi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <40000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
 &mcu_mcan0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 6930efff8a5a..9fe255f0576e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -39,6 +39,28 @@
 	};
 };
 
+&wkup_pmx0 {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
+			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
+			J721S2_WKUP_IOPAD(0x030, PIN_OUTPUT, 0) /* (G17) MCU_OSPI0_CSn1 */
+			J721S2_WKUP_IOPAD(0x038, PIN_OUTPUT, 0) /* (F14) MCU_OSPI0_CSn2 */
+			J721S2_WKUP_IOPAD(0x03c, PIN_OUTPUT, 0) /* (F17) MCU_OSPI0_CSn3 */
+			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
+			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
+			J721S2_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (F18) MCU_OSPI0_D3 */
+			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (E19) MCU_OSPI0_D4 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (G19) MCU_OSPI0_D5 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (F19) MCU_OSPI0_D6 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
+			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
+			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
@@ -79,3 +101,24 @@
 	pinctrl-names = "default";
 	phys = <&transceiver0>;
 };
+
+&ospi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
-- 
2.17.1

