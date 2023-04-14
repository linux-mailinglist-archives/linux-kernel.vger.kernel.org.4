Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90196E1D42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNHeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDNHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283594683;
        Fri, 14 Apr 2023 00:33:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XZ0Q109389;
        Fri, 14 Apr 2023 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457615;
        bh=aEqy8yKlPc/X2ABpn2Lcb/WSr6sK5nvuuVLoMdbyzo0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ATVJG1Hu0JEovjVECOEB2LYP0+uFbwPw/BdzylRTt9JmDdU58+lZGpdV++gvpxo3H
         WOJuUN7Wh9k1Q6sL9G3NOoaasapdpbUAdjKZ229o54HewzUowDoP7zNVCX6m8NCNXV
         ShkplPJjZH/0MUy7VPHu5fHXuX9yoBM+sz+X3SYI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XZit053550
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:35 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYjS020521;
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
Subject: [PATCH 07/10] arm64: dts: ti: k3-am642-evm: Describe main_uart1 pins
Date:   Fri, 14 Apr 2023 02:33:25 -0500
Message-ID: <20230414073328.381336-8-nm@ti.com>
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

Describe the main_uart1 pins even though it is a reserved node for
hardware complete description. This is used by other users of device
tree to help configure the SoC per board requirements.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6456cc6d739b..a1ed102a69f1 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -215,6 +215,15 @@ AM64X_IOPAD(0x0290, PIN_INPUT, 0) /* MMC1_CLKLB */
 		>;
 	};
 
+	main_uart1_pins_default: main-uart1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0248, PIN_INPUT, 0)		/* (D16) UART1_CTSn */
+			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0)		/* (E16) UART1_RTSn */
+			AM64X_IOPAD(0x0240, PIN_INPUT, 0)		/* (E15) UART1_RXD */
+			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)		/* (E14) UART1_TXD */
+		>;
+	};
+
 	main_uart0_pins_default: main-uart0-pins-default {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
@@ -340,6 +349,8 @@ &main_uart0 {
 /* main_uart1 is reserved for firmware usage */
 &main_uart1 {
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_i2c0 {
-- 
2.40.0

