Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4776E8599
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjDSXAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjDSXA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:00:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759919772;
        Wed, 19 Apr 2023 16:00:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JMxEfU082936;
        Wed, 19 Apr 2023 17:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681945154;
        bh=LnwMiSiX2Vog2Or4BkxBItpB+7NfB1JPDSMlGdeXhaE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c7v+EByduxlagwnTFOHECYPkkMVDpAyxm3LLWh1ZeMENVI8+QPoesjOKSmcA2Xt3I
         UmcH16QX+HBExuUEfo64Fv+IvrvKItDyvM1glb/0LOj8G2nG38Gw6L+SW+DJB3Gpm4
         e2w+PbvMLgs7Z7RUjcRxys/wjBoUHF8FMDkgQFUk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JMxExc012973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 17:59:14 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 17:59:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 17:59:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JMxEX2040426;
        Wed, 19 Apr 2023 17:59:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/7] arm64: dts: ti: k3-am654-base-board: Add VTT GPIO regulator for DDR
Date:   Wed, 19 Apr 2023 17:59:09 -0500
Message-ID: <20230419225913.663448-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419225913.663448-1-nm@ti.com>
References: <20230419225913.663448-1-nm@ti.com>
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

Hold the DDR vtt regulator active for functionality.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index d3dd6899ef03..83467adc017d 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -117,6 +117,20 @@ vdd_mmc1_sd: regulator-2 {
 		vin-supply = <&vcc3v3_io>;
 		gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
 	};
+
+	vtt_supply: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ddr_vtt_pins_default>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc3v3_io>;
+		gpio = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &wkup_pmx0 {
@@ -129,6 +143,12 @@ AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 1)	/* (AC1) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 		>;
 	};
 
+	ddr_vtt_pins_default: ddr-vtt-pins-default {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
+		>;
+	};
+
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
-- 
2.40.0

