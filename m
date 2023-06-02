Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA7720B35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjFBVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFBVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:49:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA51A5;
        Fri,  2 Jun 2023 14:49:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352Lnd4X103181;
        Fri, 2 Jun 2023 16:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685742579;
        bh=aSiMVBD0Dsirj+zKjn9Yb324EJecW4++8p9tcPc/uIk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f//Flz2UAYRzfAbUYN8KHU7xqik5B9P5AlH9EDRlYHocIWlqBD5IVDb1LnMwdtL7u
         sJV5XGAfvPTDVA3a60Ki4JJtjSH1xrZ1YN7yt10pAKS8WWtvlsnhyHOhbjvwxpEuib
         /kgl3lQSezdUFd1hBPMdILThI6X2wSTEnBoZeIPA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352Lndmw112438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 16:49:39 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 16:49:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 16:49:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352LncXg080643;
        Fri, 2 Jun 2023 16:49:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 5/8] arm64: dts: ti: k3-am69-sk: Enable mcu network port
Date:   Fri, 2 Jun 2023 16:49:34 -0500
Message-ID: <20230602214937.2349545-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602214937.2349545-1-nm@ti.com>
References: <20230602214937.2349545-1-nm@ti.com>
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

Enable networking for NFS and basic networking functionality.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Depends on https://lore.kernel.org/linux-arm-kernel/20230503083143.32369-1-t-konduru@ti.com/

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index f364b7803115..ae41ff6249a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -24,6 +24,7 @@ aliases {
 		serial2 = &main_uart8;
 		mmc1 = &main_sdhci1;
 		i2c3 = &main_i2c0;
+		ethernet0 = &mcu_cpsw_port1;
 	};
 
 	memory@80000000 {
@@ -139,6 +140,32 @@ J784S4_IOPAD(0x0C4, PIN_INPUT, 7) /* (AD36) ECAP0_IN_APWM_OUT.GPIO0_49 */
 	};
 };
 
+&wkup_pmx2 {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
+			J784S4_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
+			J784S4_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
+			J784S4_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
+			J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
+		>;
+	};
+};
+
 &main_uart8 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -178,3 +205,24 @@ &main_sdhci1 {
 &main_gpio0 {
 	status = "okay";
 };
+
+&mcu_cpsw {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
+};
+
+&davinci_mdio {
+	mcu_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&mcu_cpsw_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&mcu_phy0>;
+};
-- 
2.40.0

