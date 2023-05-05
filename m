Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9576F849A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjEEOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjEEOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:14:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2511623;
        Fri,  5 May 2023 07:14:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EEGYj126099;
        Fri, 5 May 2023 09:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683296056;
        bh=Hr+PHNhH9rhdb55UYrnWCj1dBhKcIPEet3Eek/wL7+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s7ExkWIqcl0Qm69wny51wI8cQ1u392Hkssy8UuM7sIOB3E3EQ285Y5VPd+t6GrYeI
         BmlthhQYRgw12YL6JVWEhOUKzqpMB1ujGY6UXhqOGuKwL/MLOxh0Z53r7naKdvXDDx
         6Y4Uj5JZDNGH+KxE/Mj8APohdAEoBluSlh3+Uo/s=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EEGj0011681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:14:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:14:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:14:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EEFdL068377;
        Fri, 5 May 2023 09:14:15 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash select pinmux
Date:   Fri, 5 May 2023 19:44:07 +0530
Message-ID: <20230505141407.15134-5-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505141407.15134-1-vaishnav.a@ti.com>
References: <20230505141407.15134-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721E common processor board has an onboard mux for selecting whether
the OSPI signals are externally routed to OSPI flash or Hyperflash. The
mux state signal input is tied to WKUP_GPIO0_6 and is used by bootloader
for enabling the corresponding node accordingly. Add pinmux for the same.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 7db0603125aa..b7a2f23b2c67 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -363,6 +363,12 @@
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
@@ -420,6 +426,11 @@
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

