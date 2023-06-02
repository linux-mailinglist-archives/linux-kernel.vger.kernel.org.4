Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE35772064F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjFBPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjFBPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:36:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38618D;
        Fri,  2 Jun 2023 08:36:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352FZwbh118409;
        Fri, 2 Jun 2023 10:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685720158;
        bh=huPiAoEvdS7zJUZQYpx9KJeHkoC09FKyEF2tnc0eb6o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EmMnPUFgCLhPZ1VD6byTwmcIPmPg8kc1wjM1FkVT6PrFqkbU+b+z2Eg3LcBSBoohE
         Veuqj6HSG0uF++wH7MOMIS3w0/QJbhO2oj3vLLnvUjggKfwnjxXLmRUfkNyOHVqWHx
         xn49gbm2PXzNtGXH37U0RPIRH5b6rPYAhi4GDcNY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352FZwki018088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 10:35:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 10:35:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 10:35:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352FZveY065991;
        Fri, 2 Jun 2023 10:35:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 6/6] arm64: dts: ti: k3-j721s2-som-p0: Enable wakeup_i2c0 and eeprom
Date:   Fri, 2 Jun 2023 10:35:54 -0500
Message-ID: <20230602153554.1571128-7-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230602153554.1571128-1-nm@ti.com>
References: <20230602153554.1571128-1-nm@ti.com>
MIME-Version: 1.0
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

Enable wakeup_i2c and use un-used pinmux. While at it, describe the
board detection eeprom present on the board.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch

 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 6930efff8a5a..ccd69640a5c0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -39,6 +39,15 @@ transceiver0: can-phy0 {
 	};
 };
 
+&wkup_pmx2 {
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
@@ -55,6 +64,19 @@ J721S2_IOPAD(0x024, PIN_OUTPUT, 0) /* (Y28) MCAN16_TX */
 	};
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* CAV24C256WE-GT3 */
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.40.0

