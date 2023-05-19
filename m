Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F270969E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjESLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjESLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:34:48 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355B191;
        Fri, 19 May 2023 04:34:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34JBYcc4041190;
        Fri, 19 May 2023 06:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684496079;
        bh=PKUZFzscfQft5W8dZa/hM7qURxlGluVJBlUtBEMqRuA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MU54t+1Q/bZQQ2464j2bgDfvdciEdfWiwkMGHnOcFG9fOYqDAj/qNH2UGWL92+APh
         RRoYT0+vrSvpTgisMduZN+dwyaXJPlCBJ+x7DSceQvt/DyCtHaCy/GC/E7Ab7Dn4I2
         XRIYw8F6lytagNE7wALFqETOf+r2lcXjmQKev26E=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34JBYc83018454
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 May 2023 06:34:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 May 2023 06:34:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 May 2023 06:34:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34JBYb0L032892;
        Fri, 19 May 2023 06:34:38 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62x-sk-common: Add main_uart1 and wkup_uart nodes
Date:   Fri, 19 May 2023 17:04:33 +0530
Message-ID: <20230519113434.1024206-2-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519113434.1024206-1-n-yadav@ti.com>
References: <20230519113434.1024206-1-n-yadav@ti.com>
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

wkup_uart and main_uart1 on this platform is used by TIFS and DM
firmwares. Describe pinmux and add aliases for completeness.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index a61e8648f189..56a5e2eec457 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -12,7 +12,9 @@
 
 / {
 	aliases {
+		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 		mmc2 = &sdhci2;
@@ -126,6 +128,15 @@ AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
 		>;
 	};
 
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
+			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
+			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCAS/mP0_ACLKR.UART1_TXD */
+		>;
+	};
+
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16/E12) I2C0_SCL */
@@ -220,8 +231,21 @@ AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
 	};
 };
 
+&mcu_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0) /* (C6) WKUP_UART0_CTSn */
+			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0) /* (A4) WKUP_UART0_RTSn */
+			AM62X_MCU_IOPAD(0x024, PIN_INPUT, 0) /* (B4) WKUP_UART0_RXD */
+			AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5) WKUP_UART0_TXD */
+		>;
+	};
+};
+
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 	status = "reserved";
 };
 
@@ -233,6 +257,8 @@ &main_uart0 {
 
 &main_uart1 {
 	/* Main UART1 is used by TIFS firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 	status = "reserved";
 };
 
-- 
2.25.1

