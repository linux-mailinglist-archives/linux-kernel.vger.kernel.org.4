Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD06E6E65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjDRViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjDRVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:37:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D909E;
        Tue, 18 Apr 2023 14:37:56 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33ILbjiV036046;
        Tue, 18 Apr 2023 16:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681853865;
        bh=WmKL8P5aPN5GIi8oRcJUtk9WrZwThAOkNiFBb+fivNs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a5lHLV/EtW3KSckaU6CO070MsG6aV4de6kueIs5fXTJuv1WcXBeOKo1yBfuOMcKPT
         z3vYexAkff3b+RN/AgsbTC6UQfhK04+1tFfoiRBriERIK8vZBEeSz9TNjTRhcudary
         F0ywH2BhLIqTyUmHUwDPlAgKQrGEHH9S6bXV1cQ4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33ILbjft083339
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 16:37:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 16:37:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 16:37:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33ILbju9009648;
        Tue, 18 Apr 2023 16:37:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am62x-sk-common: Describe main_uart1 and wkup_uart
Date:   Tue, 18 Apr 2023 16:37:38 -0500
Message-ID: <20230418213740.153519-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418213740.153519-1-nm@ti.com>
References: <20230418213740.153519-1-nm@ti.com>
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

wkup_uart and main_uart1 on this platform is used by tifs and DM
firmwares. Describe them for completeness including the pinmux.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 9036af82894b..dc76529f7aa1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -126,6 +126,15 @@ AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
 		>;
 	};
 
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19/B18) MCASP0_AXR3.UART1_CTSn */
+			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19/B17) MCASP0_AXR2.UART1_RTSn */
+			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19/D15) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20/D16) MCASP0_ACLKR.UART1_TXD */
+		>;
+	};
+
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16/E12) I2C0_SCL */
@@ -220,9 +229,22 @@ AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
 	};
 };
 
+&mcu_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0) /* (C6/A7) WKUP_UART0_CTSn */
+			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0) /* (A4/B4) WKUP_UART0_RTSn */
+			AM62X_MCU_IOPAD(0x024, PIN_INPUT, 0) /* (B4/B5) WKUP_UART0_RXD */
+			AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
+		>;
+	};
+};
+
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
 &main_uart0 {
@@ -234,6 +256,8 @@ &main_uart0 {
 &main_uart1 {
 	/* Main UART1 is used by TIFS firmware */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_i2c0 {
-- 
2.40.0

