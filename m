Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3C6FDDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjEJMcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjEJMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:32:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA84EEC;
        Wed, 10 May 2023 05:32:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34ACWKEk128721;
        Wed, 10 May 2023 07:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683721940;
        bh=rX7CwCJ3JaQEuvEyr4k6yMTGKInKaIpmr1tHPZFrajE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C3Cv7jkZewNtmpfvZkwUISnCFM5ARQhFqtHkDwnx43HSGDUgu8gb9oIcwP+au3osy
         OaWPG9YnSPTiuu0TR4cxT1yMfZZtg84KRNvPsf9S0HQEe9dBMu/9tUigIkJr+Dh4zg
         q6cGEkTxPWSzq5KLsDWlksistiJv5rH1xghacty0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34ACWKt6024397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 May 2023 07:32:20 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 May 2023 07:32:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 May 2023 07:32:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34ACWIMM118325;
        Wed, 10 May 2023 07:32:19 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62x-sk-common: Add main_uart1 and wkup_uart nodes
Date:   Wed, 10 May 2023 18:02:15 +0530
Message-ID: <20230510123216.3440019-2-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510123216.3440019-1-n-yadav@ti.com>
References: <20230510123216.3440019-1-n-yadav@ti.com>
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
index 976f8303c84f..e29ea8ae2177 100644
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
@@ -127,6 +129,15 @@ AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
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
@@ -221,8 +232,21 @@ AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
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
 
@@ -234,6 +258,8 @@ &main_uart0 {
 
 &main_uart1 {
 	/* Main UART1 is used by TIFS firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 	status = "reserved";
 };
 
-- 
2.25.1

