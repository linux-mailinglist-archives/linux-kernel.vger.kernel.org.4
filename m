Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E16EE9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjDYVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjDYVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:43:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB14B23B;
        Tue, 25 Apr 2023 14:43:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PLhF4T016097;
        Tue, 25 Apr 2023 16:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682458996;
        bh=hcVxdL4FLx0hwez58KXLcmrDbTt3daM5J0GsmRhVUBA=;
        h=From:To:CC:Subject:Date;
        b=M/hSWS/cqNnJ/o1OdF7AcgFKtk7hf4VrkISg9ngtj97mNxN8OVXiN39Qz4dgurDQl
         II3Sq+VR8JdBgU43rzI6zUMrx6Az47YpHvmYbjTbXSsc++7tSYEgDXKuX425irUTug
         ZGhJm8fQt8e5PscJ0Rwu363Mo07Nxcfnyu9tkccs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PLhFNJ051766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 16:43:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 16:43:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 16:43:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PLhEYn035712;
        Tue, 25 Apr 2023 16:43:14 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62a7-sk: Describe main_uart1 and wkup_uart
Date:   Tue, 25 Apr 2023 16:43:11 -0500
Message-ID: <20230425214311.546191-1-bb@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715; i=bb@ti.com; h=from:subject; bh=cGB/F/c+1FRJZb3sIYvgjqiJFwIX3JQVRIqE0qqvbfY=; b=owNCWmg5MUFZJlNZ/BeK8wAAYP///r9f72/5353mfd81vTej32pjUvV/Sv/d2vjv3/p8/06wA Rsa2QBoMjQDEZAAGmEyYTTIaDQyAA0YBGCA0aMEyMgAaaAyGmI0GQBkeUMiaANBoaNNAABo0DQD QaAA00aaGjQ0MgDEyaaPU2iD1NMgDRo0ZMENqDTEehEPUMgZD0QDJo00Mah6QaNAyDIGgNNAADI MhiGQAAMIDRpiZAwgZGQ9T1NBgxHE2lLDJQhsaPBeGiw3yhwR0EVsm4CdX1RXPokw3YGWW+ZFin NHNxb3+gL1FCE0l6LqVnygPQTL1wu0BmKOeGV+Op7L/T0oYkTYoCwjFobQmgh4g8/wLjA4+HAVo 0yXrBA8mFiXTAL+E03UtdYXMVTKsy3bCuq9uVSkPR7KrMP3c7psgixJT9xe9YDuM21ndjaRr9ry uubUbJR27jH5HROl1zyT8wjFuYOy7iLnHCdaLeMJ906UAyN9Re8F/W4RUJCzxERGg7NA51TU3F7 /nTow+8DCmZ0AB33vGJx5BgB0ztUeZLSOqUzgbWKDHAmYEGSaKMZyWOP3zoMfHwGAn4mcoxgSR6 nQjRBj60OLHrreQdIYphBAKgEcmcsX0umsH4dDB5vgIzlZv9ayVSJAVYe0KIEKT9wq5iAOQxP6j BABVf4u5IpwoSH4LxXm
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

From: Nishanth Menon <nm@ti.com>

wkup_uart and main_uart1 on this platform is used by tifs and DM
firmwares. Describe them for completeness including the pinmux.

Signed-off-by: Nishanth Menon <nm@ti.com>
[bb@ti.com: updated pinmux and commit subject]
Signed-off-by: Bryan Brattlof <bb@ti.com>
---

Changes from v1: [0]
- Updated $subject to align with previous commits

[0] https://lore.kernel.org/linux-devicetree/20230424183355.68360-1-bb@ti.com/


 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 40 +++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f6a67f072dca6..65caa5611d6d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -17,7 +17,9 @@ / {
 	model = "Texas Instruments AM62A7 SK";
 
 	aliases {
+		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart1;
 		mmc1 = &sdhci1;
 	};
 
@@ -114,11 +116,38 @@ led-0 {
 	};
 };
 
+&mcu_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x0024, PIN_INPUT, 0) /* (C9) WKUP_UART0_RXD */
+			AM62AX_MCU_IOPAD(0x0028, PIN_OUTPUT, 0) /* (E9) WKUP_UART0_TXD */
+			AM62AX_MCU_IOPAD(0x002c, PIN_INPUT, 0) /* (C10) WKUP_UART0_CTSn */
+			AM62AX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
+		>;
+	};
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	status = "reserved";
+};
+
 &main_pmx0 {
 	main_uart0_pins_default: main-uart0-pins-default {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
-			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
+			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
+		>;
+	};
+
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x01e8, PIN_INPUT, 1) /* (C17) I2C1_SCL.UART1_RXD */
+			AM62AX_IOPAD(0x01ec, PIN_OUTPUT, 1) /* (E17) I2C1_SDA.UART1_TXD */
+			AM62AX_IOPAD(0x0194, PIN_INPUT, 2) /* (C19) MCASP0_AXR3.UART1_CTSn */
+			AM62AX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (B19) MCASP0_AXR2.UART1_RTSn */
 		>;
 	};
 
@@ -254,6 +283,13 @@ &main_uart0 {
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
 
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+	status = "reserved";
+};
+
 &usbss1 {
 	status = "okay";
 };

base-commit: 891db0c48efb48c3af334006f9d7ea6a0aa49cb9
-- 
2.40.0

