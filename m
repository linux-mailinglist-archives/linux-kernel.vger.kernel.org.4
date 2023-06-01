Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9971A2BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjFAP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjFAP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:26:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136A12C;
        Thu,  1 Jun 2023 08:26:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351FQeL6050934;
        Thu, 1 Jun 2023 10:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685633200;
        bh=kWAt6UEc4eDHBB7NXbu9x1JNwkfHB0bdpYKVQ8kZIY0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q7uElnoA8X9Ltuy4EXzWG6zNu6dWyjxsuC3PTz7fRQK1N3VRIfPKmqg1ZFR+uEyHF
         /fgf0Wnf5Ve3YG1EcDOzJq6WP1hEAQo+gCuuAgivO/GAyteVAPuxMIPj2H+hNYgxGC
         VCVM6MPO85YxIY4i6C2tIdOdMVWeb5TvyJgjhj8Q=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351FQehj038129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 10:26:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 10:26:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 10:26:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351FQdtX022506;
        Thu, 1 Jun 2023 10:26:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 10/12] arm64: dts: ti: k3-am65-iot*: Fixup reference to phandles array
Date:   Thu, 1 Jun 2023 10:26:34 -0500
Message-ID: <20230601152636.858553-11-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230601152636.858553-1-nm@ti.com>
References: <20230601152636.858553-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When referring to array of phandles, using <> to separate the array
entries is better notation as it makes potential errors with phandle and
cell arguments easier to catch. Fix the outliers to be consistent with
the rest of the usage.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi    | 17 ++++++++---------
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts   | 18 ++++++++----------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 6b052a0ecfa1..bbbb5c169ccc 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -384,13 +384,12 @@ &main_gpio0 {
 
 &wkup_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&arduino_io_d2_to_d3_pins_default
-		&arduino_i2c_aio_switch_pins_default
-		&arduino_io_oe_pins_default
-		&push_button_pins_default
-		&db9_com_mode_pins_default
-	>;
+	pinctrl-0 =
+		<&arduino_io_d2_to_d3_pins_default>,
+		<&arduino_i2c_aio_switch_pins_default>,
+		<&arduino_io_oe_pins_default>,
+		<&push_button_pins_default>,
+		<&db9_com_mode_pins_default>;
 	gpio-line-names =
 		/* 0..9 */
 		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
@@ -711,11 +710,11 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 &mcu_r5fss0_core0 {
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 };
 
 &mcu_r5fss0_core1 {
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index d5e41bdc89c3..1fc93e0b3c9b 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -66,20 +66,18 @@ AM65X_IOPAD(0x001c, PIN_INPUT_PULLUP, 7)  /* (C23) GPIO1_89 */
 
 &main_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&main_m2_pcie_mux_control
-		&arduino_io_d4_to_d9_pins_default
-	>;
+	pinctrl-0 =
+		<&main_m2_pcie_mux_control>,
+		<&arduino_io_d4_to_d9_pins_default>;
 };
 
 &main_gpio1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&main_m2_enable_pins_default
-		&main_pmx0_m2_config_pins_default
-		&main_pmx1_m2_config_pins_default
-		&cp2102n_reset_pin_default
-	>;
+	pinctrl-0 =
+		<&main_m2_enable_pins_default>,
+		<&main_pmx0_m2_config_pins_default>,
+		<&main_pmx1_m2_config_pins_default>,
+		<&cp2102n_reset_pin_default>;
 };
 
 /*
-- 
2.40.0

