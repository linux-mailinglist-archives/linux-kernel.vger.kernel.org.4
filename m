Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00EE6E1D38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNHd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDNHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE194683;
        Fri, 14 Apr 2023 00:33:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XZ5C007129;
        Fri, 14 Apr 2023 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457615;
        bh=bBA9MF9F5PI1M/+vLYYR6OvKJtgwAEZj6Jd75cVBw2o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=es3YzTzP66joKwagjX+0vv5mxqELrGX7tzPwZtjLioK+8Wwi+Vr5nRFxSVNMhRxjh
         DAZ4DVZvzreELxQxkNQ6XSyr+qsNa5TCgz3L1xMxNdBuFLAyHE8HswjuGjf93H2knZ
         7gAgxS/hKAtIBgcTcH6ahEOC9pNh0muJk9eICXnE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XZue053547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:35 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYcV055397;
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
Subject: [PATCH 06/10] arm64: dts: ti: k3-am642-evm: Enable main_i2c0 and eeprom
Date:   Fri, 14 Apr 2023 02:33:24 -0500
Message-ID: <20230414073328.381336-7-nm@ti.com>
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

Enable AT24CM01 on the base board using the corresponding compatible.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Note:
checkpatch does a simple pattern search and fails to find a match
#47: FILE: arch/arm64/boot/dts/ti/k3-am642-evm.dts:353:
		compatible = "atmel,24c1024";

But, Documentation/devicetree/bindings/eeprom/at24.yaml
              - items:
                  pattern: cs1024$
Cleanly covers the same and dtbs_check looks clean.

 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 39feea78a084..6456cc6d739b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -233,6 +233,13 @@ AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
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
@@ -335,6 +342,19 @@ &main_uart1 {
 	status = "reserved";
 };
 
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* AT24CM01 */
+		compatible = "atmel,24c1024";
+		reg = <0x50>;
+	};
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.40.0

