Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72C6777F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjAWJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjAWJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:57:58 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1055A8;
        Mon, 23 Jan 2023 01:57:56 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30N9vp5i067149;
        Mon, 23 Jan 2023 03:57:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674467871;
        bh=5zQ1E9Uu9eIeFZvejrJVHWinCZyOyq2yFbblK+Ex1w8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FLRDv3SgCFnVtxvRzB5KcNM1Z27bwPp8giJnPqJRDuPkOgGMC5CsKM47GBN850/eB
         HFlofkam7pppAGl+juiH5Ty0DXDfPstYHblcZGVAnuVk1IuZwi+DGbeIDzV4saeRRz
         l/uvCe/XmcYSNutUXWYOfOSYs9Th0/HpUnHoszzM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30N9vpsS121119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 03:57:51 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 03:57:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 03:57:51 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30N9vXfT034627;
        Mon, 23 Jan 2023 03:57:48 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/8] arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
Date:   Mon, 23 Jan 2023 15:27:29 +0530
Message-ID: <20230123095733.31657-5-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230123095733.31657-1-r-gunasekaran@ti.com>
References: <20230123095733.31657-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
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

From: Aswath Govindraju <a-govindraju@ti.com>

Configure first lane to PCIe, the second lane to USB and the last two lanes
to eDP. Also, add sub-nodes to SERDES0 DT node to represent SERDES0 is
connected to PCIe.

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Link: https://lore.kernel.org/r/20221122101616.770050-5-mranostay@ti.com
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index a7aa6cf08acd..c3a397484c70 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -9,6 +9,9 @@
 
 #include "k3-j721s2-som-p0.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/mux/ti-serdes.h>
 
 / {
 	compatible = "ti,j721s2-evm", "ti,j721s2";
@@ -296,6 +299,25 @@
 	phy-handle = <&phy0>;
 };
 
+&serdes_ln_ctrl {
+	idle-states = <J721S2_SERDES0_LANE0_PCIE1_LANE0>, <J721S2_SERDES0_LANE1_USB>,
+		      <J721S2_SERDES0_LANE2_EDP_LANE2>, <J721S2_SERDES0_LANE3_EDP_LANE3>;
+};
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+&serdes0 {
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
 &mcu_mcan0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.17.1

