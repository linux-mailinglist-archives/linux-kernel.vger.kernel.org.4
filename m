Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB66B1E34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCIIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCIIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:31:57 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7CF65BA;
        Thu,  9 Mar 2023 00:30:16 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3298UCuc114230;
        Thu, 9 Mar 2023 02:30:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678350612;
        bh=eBqulOpZr68B0R2+7woPRyRYwQQsjU/wqg9tKsap5DA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A1Sn/yHTEMCwG1mqOsQzv/FE49vzGQO/AgC4jLCqQxWxys1e6bBaVLYAsz7MYmbyV
         HCGhHRAd1emiCHuwKWqFmTL64CeVkhx16epxag8aYOBnKRTOuby437gVYhMVWQSmDV
         gNsOZ4Dc0oR2jypurUGzA1Fx+vK35YEZAO2XQtEk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3298UCQG015988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 02:30:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 02:30:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 02:30:11 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3298Tf5G063317;
        Thu, 9 Mar 2023 02:30:08 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 7/8] arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
Date:   Thu, 9 Mar 2023 13:59:39 +0530
Message-ID: <20230309082940.31535-8-r-gunasekaran@ti.com>
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

Add PCIe1 RC device tree node for the single PCIe instance present on
the J721S2.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes from v12:
* No change

Changes from v11:
* Cleaned up comments

Changes from v10:
* Removed Link tag from commit message

Changes from v9:
* No change

Changes from v8:
* No change

Changes from v7:
* No change

Changes from v6:
* Remove the pcie_ep node as device cannot act as RC and EP
  at the same time

Changes from v5:
* No change

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* Patch newly added to the series

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index c248cb5a986a..9306f6bfef63 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -847,6 +847,49 @@
 		};
 	};
 
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x800000>,
+		      <0x00 0x18000000 0x00 0x1000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 276 41>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb013>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>, /* INT A */
+				<0 0 0 2 &pcie1_intc 0>, /* INT B */
+				<0 0 0 3 &pcie1_intc 0>, /* INT C */
+				<0 0 0 4 &pcie1_intc 0>; /* INT D */
+
+		status = "disabled"; /* Needs gpio and serdes info */
+
+		pcie1_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.17.1

