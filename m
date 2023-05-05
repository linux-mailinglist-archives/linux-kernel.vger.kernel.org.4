Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0F6F849C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjEEOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjEEOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:14:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C1215691;
        Fri,  5 May 2023 07:14:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EEE6i039499;
        Fri, 5 May 2023 09:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683296054;
        bh=gSYZYifaWkVjTuAYaiTversyXzWIB/rrjeZtE7PYkRM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wsFuV5zQBVuuNA7u/Z+WNp/GX7v2IhtKbN4ykkoDKNfDaACw99jF+2p/gsQk2BCgd
         C0cTkgfzq8HUAkfzaxYncjYYu1ms5cuQhoB0xiT2YT78FJUXK5x1uyc7aeG0jM1n/y
         oWEYJbc5Oi0h99shNx+RuRM/mkNh1pyEkfcEvf5g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EEEMS000596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:14:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:14:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:14:14 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EEDhg090883;
        Fri, 5 May 2023 09:14:14 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-j7200-common-proc-board: Add OSPI/Hyperflash select pinmux
Date:   Fri, 5 May 2023 19:44:06 +0530
Message-ID: <20230505141407.15134-4-vaishnav.a@ti.com>
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

J7200 common processor board has an onboard mux for selecting whether
the OSPI signals are externally routed to OSPI flash or Hyperflash. The
mux state signal input is tied to WKUP_GPIO0_6 and is used by bootloader
for enabling the corresponding node accordingly. Add pinmux for the same.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 63633e4f6c59..f5cbb4b7a9fb 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -98,6 +98,12 @@
 		>;
 	};
 
+	wkup_gpio_pins_default: wkup-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x70, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_6 */
+		>;
+	};
+
 	mcu_mdio_pins_default: mcu-mdio1-pins-default {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
@@ -187,6 +193,11 @@
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

