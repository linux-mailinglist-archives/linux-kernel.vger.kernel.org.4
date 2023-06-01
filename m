Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD571A2B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjFAP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFAP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:26:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795DB12C;
        Thu,  1 Jun 2023 08:26:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351FQeJP050906;
        Thu, 1 Jun 2023 10:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685633200;
        bh=Jh2mG7/+m1gFRGxcDQmDNx35pR+kxt0/NUaAUT4ZnZ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u8nY4/W5Eo8g9LX07kpY1SAbzCXHp1fh7b5k+7I3sHAiBJDThGZT2wH0xCqR6ueGr
         oywXvWBjzQb0O1xafhtPn+2aOJNL14h+TqDP31MloLbUPofPY9ZYl9ax5VaiJ8/230
         lnE4h1vy+R4XLcpv2kZAgtLv6LVhyUyfFvpXrc0Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351FQdcX038116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 10:26:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 10:26:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 10:26:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351FQd8M017631;
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
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 03/12] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandles array
Date:   Thu, 1 Jun 2023 10:26:27 -0500
Message-ID: <20230601152636.858553-4-nm@ti.com>
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

Cc: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 37c24b077b6a..c13246a9ed8f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -593,7 +593,7 @@ &main_i2c0 {
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default &csi1_gpio_pins_default>;
+	pinctrl-0 = <&main_i2c1_pins_default>, <&csi1_gpio_pins_default>;
 	clock-frequency = <400000>;
 };
 
@@ -623,7 +623,7 @@ &main_i2c4 {
 &main_i2c5 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c5_pins_default &csi0_gpio_pins_default>;
+	pinctrl-0 = <&main_i2c5_pins_default>, <&csi0_gpio_pins_default>;
 	clock-frequency = <400000>;
 };
 
@@ -639,7 +639,7 @@ &main_i2c6 {
 &wkup_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
+	pinctrl-0 = <&wkup_i2c0_pins_default>, <&eeprom_wp_pins_default>;
 	clock-frequency = <400000>;
 
 	eeprom@50 {
@@ -680,7 +680,8 @@ &main_gpio7 {
 
 &wkup_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_adc0_pins_default &mcu_adc1_pins_default &mikro_bus_pins_default>;
+	pinctrl-0 = <&mcu_adc0_pins_default>, <&mcu_adc1_pins_default>,
+		    <&mikro_bus_pins_default>;
 };
 
 &wkup_gpio1 {
@@ -759,7 +760,7 @@ serdes2_usb_link: phy@1 {
 
 &usbss1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_usbss1_pins_default &mcu_usbss1_pins_default>;
+	pinctrl-0 = <&main_usbss1_pins_default>, <&mcu_usbss1_pins_default>;
 	ti,vbus-divider;
 };
 
@@ -1001,55 +1002,55 @@ mbox_c71_0: mbox-c71-0 {
 };
 
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
 
 &c66_0 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
 };
 
 &c71_0 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
-- 
2.40.0

