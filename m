Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B56B1E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCIIcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCIIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:31:55 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B26976A;
        Thu,  9 Mar 2023 00:30:08 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3298U1Vn114091;
        Thu, 9 Mar 2023 02:30:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678350601;
        bh=tKqxyIWE3JyjGb9I6XMgh7lULIO10kqIPkGmSEpACKo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FND9ytyMz9Tjm1qt4O3zg6T7Gye5ZFPAxRQav3Hm6U6ClCfxI+hdXmHriw+mBOnZc
         zkI4MyYFHraciFZsKUFOClPTXv4pfKU6vChMaATxc0nLqjIS67ERRpzNifrYW5eOel
         7PZlTzrvpaxi2luhfd0lvcv95VYHFVSgCKE0HUGA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3298U0Am044730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 02:30:01 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 02:30:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 02:30:00 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3298Tf5D063317;
        Thu, 9 Mar 2023 02:29:57 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 4/8] arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
Date:   Thu, 9 Mar 2023 13:59:36 +0530
Message-ID: <20230309082940.31535-5-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230309082940.31535-1-r-gunasekaran@ti.com>
References: <20230309082940.31535-1-r-gunasekaran@ti.com>
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

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
I had reviewed this patch in the v5 series [0].
Since I'm taking over upstreaming this series, I removed the self
Reviewed-by tag.

[0] - https://lore.kernel.org/all/71ce4ecd-2a50-c69d-28be-f1a8d769970e@ti.com/

Changes from v12:
* Removed enabling of "serdes_wiz" node that is already enabled in [2/8]
  in this version

Changes from v11:
* No change

Changes from v10:
* Removed Link tag from commit message

Changes from v9:
* Enabled serdes related nodes

Changes from v8:
* No change

Changes from v7:
* No change

Changes from v6:
* No change

Changes from v5:
* Removed Cc tags from commit message

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* No change

Changes from v1:
* No change

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index a7aa6cf08acd..e6f20d6797d1 100644
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
@@ -296,6 +299,26 @@
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
+	status = "okay";
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

