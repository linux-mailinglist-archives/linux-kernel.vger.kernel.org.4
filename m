Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449846EF21B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbjDZKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbjDZKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:33:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148C42D4D;
        Wed, 26 Apr 2023 03:32:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QAWbjP009845;
        Wed, 26 Apr 2023 05:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682505157;
        bh=8eLpTtHETVJBRANnjz+W5hBx7WGRc172Y90EHGq9aTk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CaUQQ4s45UhtEWnjIAlBn8FI7d9bClhNSPh5Ks2UgOg74G3U+eh3eTk1iw0pNR+yI
         eLZvNKT3RIZREEhJj9eWywxAQ3ra6NVmfJGhqZtYkxs7OxEFVLqEQYFwOm5Eg5Mx4U
         BR0xX8DbYDFEegvlfQl6hGHj+ApQuHwX7kOYo6C8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QAWbDb021690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 05:32:37 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 05:32:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 05:32:37 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QAWLRV036567;
        Wed, 26 Apr 2023 05:32:34 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 3/5] arm64: dts: ti: k3-j7200: main_pmx0 clean up
Date:   Wed, 26 Apr 2023 16:02:17 +0530
Message-ID: <20230426103219.1565266-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426103219.1565266-1-u-kumar1@ti.com>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
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

This patch removes duplicated define of main_i2c0
and adds main_uart0 pin mux.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 63633e4f6c59..37eb24d69924 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -107,10 +107,12 @@ J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 };
 
 &main_pmx0 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_uart0_pins_default: main_uart0_pins_default {
 		pinctrl-single,pins = <
-			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
-			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
+			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
+			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
+			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
+			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
 		>;
 	};
 
@@ -163,6 +165,8 @@ &main_uart0 {
 	status = "okay";
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
 };
 
 &main_uart1 {
-- 
2.34.1

