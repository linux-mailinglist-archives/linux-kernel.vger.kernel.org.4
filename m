Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44743724B41
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbjFFSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbjFFSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F345C171D;
        Tue,  6 Jun 2023 11:22:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356IMN9j019429;
        Tue, 6 Jun 2023 13:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686075743;
        bh=8k2Hbccg5gLiZyCtwC1B2A23afcA/wrylH4a9mhv3Wg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mTNUym9h2qpnJIGlGoeThe1dviM7SIp4EDwUyA5Y6v62Sy15j6V4jCc1DAzaDHUeB
         oLfzkO+PR+7Q/QGq1fgbGgiL8XxmNXLB2mkMdYaVZnfs+HRCiIKyCCODcRO2VzLt9l
         hHLSQQYdd1y6OeONiuQaiHM9fxcwmiWfTLLsZPIw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356IMNpa089026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 13:22:23 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 13:22:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 13:22:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNh7040855;
        Tue, 6 Jun 2023 13:22:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 11/14] arm64: dts: ti: k3-am64-sk: Fixup reference to phandles array
Date:   Tue, 6 Jun 2023 13:22:17 -0500
Message-ID: <20230606182220.3661956-12-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606182220.3661956-1-nm@ti.com>
References: <20230606182220.3661956-1-nm@ti.com>
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

When referring to array of phandles, using <> to separate the array
entries is better notation as it makes potential errors with phandle and
cell arguments easier to catch. Fix the outliers to be consistent with
the rest of the usage.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
* formatting change
V1: https://lore.kernel.org/r/20230601152636.858553-10-nm@ti.com
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 2e2d40da360a..9cbe1e1a7be1 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -439,8 +439,7 @@ &usb0 {
 
 &cpsw3g {
 	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii1_pins_default
-		     &rgmii2_pins_default>;
+	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
 };
 
 &cpsw_port1 {
@@ -537,25 +536,25 @@ &mailbox0_cluster7 {
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
-- 
2.40.0

