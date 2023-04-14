Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190246E1D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDNHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044794C22;
        Fri, 14 Apr 2023 00:33:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XZlS112600;
        Fri, 14 Apr 2023 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457615;
        bh=sTUbTlFTXOqwhpfaXx9tn5PeuqA2wdP24f3uhSq1EVA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O26B/A7bDsGkIsBNmu+5tlE0s1OEk8ezlsrvkm35h/daMnxYCIn2yVZbnkVr1rBr/
         9PCo/aQT4ezvJB7l82naA33f8sRYGt7C4s65MbsnZ785p6TRlyG0g98BorUFM3eSgt
         cL+FoB2lelPAvN1KseWiMIFye28jgor3EXjEzZ4U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XYYt053544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:34 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XY88021418;
        Fri, 14 Apr 2023 02:33:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] arm64: dts: ti: k3-am642-sk: Enable main_i2c0 and eeprom
Date:   Fri, 14 Apr 2023 02:33:21 -0500
Message-ID: <20230414073328.381336-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
References: <20230414073328.381336-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable AT24C512C on the base board.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 9a65f9b1c9ab..3e16942c0add 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -251,6 +251,13 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-pins-default {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
@@ -350,6 +357,18 @@ &main_uart1 {
 	status = "reserved";
 };
 
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+	};
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.40.0

