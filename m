Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA871972E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjFAJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjFAJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:38:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F008819F;
        Thu,  1 Jun 2023 02:38:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3519ci8d102239;
        Thu, 1 Jun 2023 04:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685612324;
        bh=mUPXXCSkpwsEOqke/okB5aqGoM+uGctd5B5F0mRWei8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZVJ0Tpe7DBsJ/0spJXODVOIuhYpjKy/XP0qFsE5q4iVShgvQpStyxGGCKfSo8mSWQ
         69OWs6GruXdD3eIifXQHSiB52s7i1YefyuLhe6cEtOKotHmupxibJkQ2ua3uO56rF3
         nTiKMHdWot0wCvZmc5f76z9iwr6tU/BztbXkS//s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3519civG012203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 04:38:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 04:38:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 04:38:44 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3519cNqX072495;
        Thu, 1 Jun 2023 04:38:41 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 5/5] arm64: dts: ti: k3-j7200-common-proc-board: Add uart pin mux in wkup_pmx0
Date:   Thu, 1 Jun 2023 15:07:44 +0530
Message-ID: <20230601093744.1565802-6-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601093744.1565802-1-u-kumar1@ti.com>
References: <20230601093744.1565802-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add uart pin mux of wkup domain into common board file.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index e12d93f56c51..809d1c910015 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -79,6 +79,24 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
 	};
 };
 
+&wkup_pmx0 {
+	mcu_uart0_pins_default: mcu_uart0_pins_default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
+			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
+		>;
+	};
+
+	wkup_uart0_pins_default: wkup_uart0_pins_default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
+		>;
+	};
+};
+
 &wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
@@ -157,7 +175,9 @@ &wkup_uart0 {
 
 &mcu_uart0 {
 	status = "okay";
-	/* Default pinmux */
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
+	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
-- 
2.34.1

