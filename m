Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36165BA00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjACEV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjACEVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:21:34 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7224DA2;
        Mon,  2 Jan 2023 20:21:33 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3034LS1G099127;
        Mon, 2 Jan 2023 22:21:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672719688;
        bh=9T1J7VzAQb/WLWfvMIK0Tn6jjrCvnME0N04koFWEwfk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D5zVxo2401dlMSPz6EeuTlQNaN60LyRIFnpYCYepnBENT2SbJfH0m4kay+2TgqJmu
         9Oex1MLh4ubuvQjsJYx5TjDLhvZGCYrhC/R3uQPGg0ftSqnklY5o9SaWcTgXJhHxNB
         38/7lKTW1O63R+dww8wtJTJM/f6jyvk4d78ZTG6o=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3034LSDv053108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 22:21:28 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 22:21:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 22:21:27 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3034LDwv084970;
        Mon, 2 Jan 2023 22:21:25 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bb@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am62a7-sk: Enable USB1 node
Date:   Tue, 3 Jan 2023 09:51:10 +0530
Message-ID: <20230103042110.1092122-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103042110.1092122-1-vigneshr@ti.com>
References: <20230103042110.1092122-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB1 host port on AM62A7 SK.

Co-developed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index bdc363fcbb4b..5c9012141ee2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -160,6 +160,12 @@ AM62AX_IOPAD(0x244, PIN_OUTPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
 		>;
 	};
 
+	main_usb1_pins_default: main-usb1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
+		>;
+	};
+
 	main_mdio1_pins_default: main-mdio1-pins-default {
 		pinctrl-single,pins = <
 			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
@@ -247,6 +253,16 @@ &main_uart0 {
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
 
+&usbss1 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
+
 &cpsw3g {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.39.0

