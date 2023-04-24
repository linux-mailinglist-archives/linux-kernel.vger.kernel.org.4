Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F46ED0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjDXOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjDXOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:50:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8840E3;
        Mon, 24 Apr 2023 07:50:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OEnqPZ127593;
        Mon, 24 Apr 2023 09:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682347792;
        bh=mJXkBQBZfdCCCHoz+H8ohjPTVkeWKNGYup4pfB2M8bk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iEtXdubo0QEZYCxdTrcG8tTiwQbr4L7Hm7G6nprlx3v/6Tbg8arHA6WFpdLhjuOD5
         qmyM2CUjFOqj5qKNo/3RuEYUYCZF+1hRdVMQ044+0A/Sf9Qw9T+0OduaeeAmEo7y56
         hghnCvjOhr+UkM1aVcGq1U+n3Lagpf4xfieSFhe0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OEnq6T128758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 09:49:52 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 09:49:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 09:49:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OEnqrS075143;
        Mon, 24 Apr 2023 09:49:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/7] arm64: dts: ti: k3-am65-main: Remove "syscon" nodes added for pcieX_ctrl
Date:   Mon, 24 Apr 2023 09:49:43 -0500
Message-ID: <20230424144949.244135-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424144949.244135-1-nm@ti.com>
References: <20230424144949.244135-1-nm@ti.com>
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

Remove "syscon" nodes added for pcieX_ctrl and have the PCIe node
point to the parent with an offset argument. This change is as
discussed in [1].

[1] http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 27 ++++++------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1adba2f2c153..bc63d10bad5a 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -481,21 +481,6 @@ scm_conf: scm-conf@100000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		pcie0_mode: pcie-mode@4060 {
-			compatible = "syscon";
-			reg = <0x00004060 0x4>;
-		};
-
-		pcie1_mode: pcie-mode@4070 {
-			compatible = "syscon";
-			reg = <0x00004070 0x4>;
-		};
-
-		pcie_devid: pcie-devid@210 {
-			compatible = "syscon";
-			reg = <0x00000210 0x4>;
-		};
-
 		serdes0_clk: clock@4080 {
 			compatible = "syscon";
 			reg = <0x00004080 0x4>;
@@ -883,8 +868,8 @@ pcie0_rc: pcie@5500000 {
 		#size-cells = <2>;
 		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
 			 <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
-		ti,syscon-pcie-id = <&pcie_devid>;
-		ti,syscon-pcie-mode = <&pcie0_mode>;
+		ti,syscon-pcie-id = <&scm_conf 0x210>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
 		bus-range = <0x0 0xff>;
 		num-viewport = <16>;
 		max-link-speed = <2>;
@@ -900,7 +885,7 @@ pcie0_ep: pcie-ep@5500000 {
 		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&pcie0_mode>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
 		num-ib-windows = <16>;
 		num-ob-windows = <16>;
 		max-link-speed = <2>;
@@ -918,8 +903,8 @@ pcie1_rc: pcie@5600000 {
 		#size-cells = <2>;
 		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000>,
 			 <0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
-		ti,syscon-pcie-id = <&pcie_devid>;
-		ti,syscon-pcie-mode = <&pcie1_mode>;
+		ti,syscon-pcie-id = <&scm_conf 0x210>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
 		bus-range = <0x0 0xff>;
 		num-viewport = <16>;
 		max-link-speed = <2>;
@@ -935,7 +920,7 @@ pcie1_ep: pcie-ep@5600000 {
 		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&pcie1_mode>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
 		num-ib-windows = <16>;
 		num-ob-windows = <16>;
 		max-link-speed = <2>;
-- 
2.40.0

