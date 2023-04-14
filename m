Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4926E1D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDNHeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDNHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431044B2;
        Fri, 14 Apr 2023 00:33:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYaj010927;
        Fri, 14 Apr 2023 02:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457614;
        bh=kDhO+nOHvLnV5ZolmRJSgxvi1K1YUzRbNh1hI9VIcMs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kbyReunCCfkeX6X9JRk29cOqlIJGyVrlkPR43uZV7fkRvbkaQnXmdrAsmLZTCncQx
         MocZochx6Q2cgn00Q5etb6zXSvBYJj4HYYhGbilFAzhnge3BLa0mz5nJy55ENEOjpp
         G+vHUQRx1Slf0edIS9vFjLLke/0NdvFP8PbqNAEw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XYYb023507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XY3l055393;
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
Subject: [PATCH 02/10] arm64: dts: ti: k3-am642-sk: Fix mmc1 pinmux
Date:   Fri, 14 Apr 2023 02:33:20 -0500
Message-ID: <20230414073328.381336-3-nm@ti.com>
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

Fix the pinmux for pulldirection to get stable sdcard behavior.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 2e2d40da360a..9a65f9b1c9ab 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -224,14 +224,15 @@ led-7 {
 &main_pmx0 {
 	main_mmc1_pins_default: main-mmc1-pins-default {
 		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0294, PIN_INPUT, 0) /* (J19) MMC1_CMD */
+			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0) /* (C20) MMC1_SDWP */
+			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0) /* (D19) MMC1_SDCD */
+			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0) /* (J19) MMC1_CMD */
 			AM64X_IOPAD(0x0290, PIN_INPUT, 0) /* (#N/A) MMC1_CLKLB */
-			AM64X_IOPAD(0x028c, PIN_INPUT, 0) /* (L20) MMC1_CLK */
-			AM64X_IOPAD(0x0288, PIN_INPUT, 0) /* (K21) MMC1_DAT0 */
-			AM64X_IOPAD(0x0284, PIN_INPUT, 0) /* (L21) MMC1_DAT1 */
-			AM64X_IOPAD(0x0280, PIN_INPUT, 0) /* (K19) MMC1_DAT2 */
-			AM64X_IOPAD(0x027c, PIN_INPUT, 0) /* (K18) MMC1_DAT3 */
-			AM64X_IOPAD(0x0298, PIN_INPUT, 0) /* (D19) MMC1_SDCD */
+			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0) /* (L20) MMC1_CLK */
+			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0) /* (K21) MMC1_DAT0 */
+			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0) /* (L21) MMC1_DAT1 */
+			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0) /* (K19) MMC1_DAT2 */
+			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0) /* (K18) MMC1_DAT3 */
 		>;
 	};
 
-- 
2.40.0

