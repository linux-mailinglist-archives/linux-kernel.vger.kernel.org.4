Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B17016AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjEMMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbjEMMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 08:33:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270ED46A0;
        Sat, 13 May 2023 05:33:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DCXMHd088672;
        Sat, 13 May 2023 07:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683981202;
        bh=9fLJ2CryUPsRkwT9y39VHYcsWb2CUgPdts/JajHZp5U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W4DAkSuhHj/PwsKfdf31tiVlANizg/9ZhWP3Sb3xfTdbFv46TfxV3HNsQJkpzzPdB
         HiguO8TH3BOJ4+pruH6GFEj0QeU2lnT2qMtV8Q7quOQPA0aq0ZokErYN2CRo3e3AtA
         MahNmH/icRk0P10ZxkezYOAUw1+yrW9uy8mcn+hM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DCXMSq113159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 07:33:22 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 07:33:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 07:33:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DCXLcW068629;
        Sat, 13 May 2023 07:33:21 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash select pinmux
Date:   Sat, 13 May 2023 18:03:13 +0530
Message-ID: <20230513123313.11462-5-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230513123313.11462-1-vaishnav.a@ti.com>
References: <20230513123313.11462-1-vaishnav.a@ti.com>
MIME-Version: 1.0
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

J721E common processor board has an onboard mux for selecting whether
the OSPI signals are externally routed to OSPI flash or Hyperflash. The
mux state signal input is tied to WKUP_GPIO0_8 and is used by bootloader
for enabling the corresponding node accordingly. Add pinmux for the same.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index c11c092c1ce0..185de41cb2f1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -362,6 +362,12 @@
 			J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* (F28) WKUP_GPIO0_2 */
 		>;
 	};
+
+	wkup_gpio_pins_default: wkup-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_8 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -419,6 +425,11 @@
 	status = "disabled";
 };
 
+&wkup_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_gpio_pins_default>;
+};
+
 &wkup_gpio1 {
 	status = "disabled";
 };
-- 
2.17.1

