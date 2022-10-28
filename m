Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0C61147E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiJ1OZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJ1OYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03010B1;
        Fri, 28 Oct 2022 07:24:36 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOQ1q008177;
        Fri, 28 Oct 2022 09:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967066;
        bh=1sNW9NejH8BybzwsPnUBsHJrG4Y80shP3LjdJoV0xME=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ykEX2V7tPwJ31D4VDkp+XiNC+uQ5i3Z1TccnEXqhcAP9suyeEStN9XYHhjezOMht4
         Qbs+nRvhKw4JC+37kbCDHR1OOLDRpOgx2V3158yWKD1+t25X19qlq9dXDxiio7O+NP
         8dUQ8KXpfUqSoiGcyJZoyiePovPjVQADvSh82HQQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOQTO030672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:26 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:25 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfa039275;
        Fri, 28 Oct 2022 09:24:25 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 11/11] arm64: dts: ti: k3-am65: Enable McASP nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:17 -0500
Message-ID: <20221028142417.10642-12-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

McASP nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the McASP nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 12 ------------
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  3 +++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 12 ------------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index c6c79dde79c52..3cced26b520a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -674,15 +674,3 @@ &mcu_r5fss0_core1 {
 			<&mcu_r5fss0_core1_memory_region>;
 	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
 };
-
-&mcasp0 {
-	status = "disabled";
-};
-
-&mcasp1 {
-	status = "disabled";
-};
-
-&mcasp2 {
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 3dc624a379c5f..1930da25d2821 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -799,6 +799,7 @@ mcasp0: mcasp@2b00000 {
 		clocks = <&k3_clks 104 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp1: mcasp@2b10000 {
@@ -816,6 +817,7 @@ mcasp1: mcasp@2b10000 {
 		clocks = <&k3_clks 105 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp2: mcasp@2b20000 {
@@ -833,6 +835,7 @@ mcasp2: mcasp@2b20000 {
 		clocks = <&k3_clks 106 0>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	cal: cal@6f03000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index d1c8047d96726..592ab2b54cb3d 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -487,18 +487,6 @@ &cpsw_port1 {
 	phy-handle = <&phy0>;
 };
 
-&mcasp0 {
-	status = "disabled";
-};
-
-&mcasp1 {
-	status = "disabled";
-};
-
-&mcasp2 {
-	status = "disabled";
-};
-
 &dss {
 	status = "disabled";
 };
-- 
2.37.3

