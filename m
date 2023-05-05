Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2945E6F8498
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjEEOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjEEOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:14:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAB13C08;
        Fri,  5 May 2023 07:14:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EEDZB077915;
        Fri, 5 May 2023 09:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683296053;
        bh=tf7N8yRo/cJzE3pogIoE41wNiI4g2yE68m3Zl2rTtZ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ltem0Ueo6h2bsFmMAr9HwBS96+Zu57dOuDf2kIk0uuC/kWgBImLwowKudCDI+UUl/
         RRDuQRl7NZd0MXeJggXOyrJGF17Ug8cMvhasPjJdRijpZG2gc1uftimItU1S7eiALp
         CoiORM0jCchSniZq9wVtNnyrucUgfFnMjKM5MORw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EEDST000583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:14:13 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:14:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:14:12 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EEB8K022278;
        Fri, 5 May 2023 09:14:12 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j721e-som-p0: Add HyperFlash node
Date:   Fri, 5 May 2023 19:44:05 +0530
Message-ID: <20230505141407.15134-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505141407.15134-1-vaishnav.a@ti.com>
References: <20230505141407.15134-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721E SoM has a HyperFlash and Hyperram connected to HyperBus memory
controller. HyperBus is muxed with OSPI and only one controller can be
active at a time, therefore keep HyperBus node disabled. Bootloader will
detect the external mux state through a wkup gpio and enable the node as
required.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e289d5b44356..d7cc40486e42 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -165,6 +165,25 @@
 			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
 		>;
 	};
+
+	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1)  /* MCU_HYPERBUS0_CK */
+			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1)  /* MCU_HYPERBUS0_CKn */
+			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* MCU_HYPERBUS0_CSn0 */
+			J721E_WKUP_IOPAD(0x54, PIN_OUTPUT, 3) /* MCU_HYPERBUS0_CSn1 */
+			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* MCU_HYPERBUS0_RESETn */
+			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1)   /* MCU_HYPERBUS0_RWDS */
+			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1)   /* MCU_HYPERBUS0_DQ0 */
+			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ1 */
+			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ2 */
+			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ3 */
+			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ4 */
+			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ5 */
+			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ6 */
+			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ7 */
+		>;
+	};
 };
 
 &ospi0 {
@@ -185,6 +204,22 @@
 	};
 };
 
+&hbmc {
+	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
+	 * appropriate node based on board detection
+	 */
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
+	ranges = <0x00 0x00 0x05 0x00000000 0x4000000>, /* 64MB Flash on CS0 */
+		 <0x01 0x00 0x05 0x04000000 0x800000>; /* 8MB RAM on CS1 */
+
+	flash@0,0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0x00 0x00 0x4000000>;
+	};
+};
+
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
-- 
2.17.1

