Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F665BA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 06:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjACFtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 00:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACFtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 00:49:10 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91954323;
        Mon,  2 Jan 2023 21:49:08 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3035mwMn116766;
        Mon, 2 Jan 2023 23:48:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672724938;
        bh=ccqY5zh7HK8GJgr9iyhlX7yltN8v9Ai4Ct8S7tl0JJA=;
        h=From:To:CC:Subject:Date;
        b=aGJpho6MJAV9h8M2oc28KGfVBVQ2Dy5h/xG8va9nZKzC0PB14olrsJMPCKjAdgYsD
         Fix6yf9bLPHIEISQAIhmA+FVDAySO11K8N97zVm3hQxH7K8wGIWyu/zq+YiheAq6cB
         otY/RPN0c4oxPHTUhQNWMDjFCYXI5dOWPlBiJQ+4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3035mw5b013248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 23:48:58 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 23:48:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 23:48:57 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3035mu8n023675;
        Mon, 2 Jan 2023 23:48:57 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Dhruva Gole <d-gole@ti.com>, <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
Date:   Tue, 3 Jan 2023 11:18:40 +0530
Message-ID: <20230103054840.1133711-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the clock Device ID's in the DT according to the tisci docs clock
identifiers for AM62x

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

For reference, TISCI Docs: clock id's for AM62
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62x/clocks.html

v3: Rebase on top of linux-next master

v2:
https://lore.kernel.org/linux-devicetree/20230102125549.1106984-1-d-gole@ti.com/

v1:
https://lore.kernel.org/linux-devicetree/20221227051208.158894-1-d-gole@ti.com/

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 072903649d6e..ae1ec58117c3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -413,7 +413,7 @@ main_spi0: spi@20100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 172 0>;
+		clocks = <&k3_clks 141 0>;
 		status = "disabled";
 	};
 
@@ -424,7 +424,7 @@ main_spi1: spi@20110000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 173 0>;
+		clocks = <&k3_clks 142 0>;
 		status = "disabled";
 	};
 
@@ -435,7 +435,7 @@ main_spi2: spi@20120000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 174 0>;
+		clocks = <&k3_clks 143 0>;
 		status = "disabled";
 	};
 
-- 
2.25.1

