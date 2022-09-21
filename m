Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA25BF42C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiIUDPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiIUDOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:14:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889137AC36;
        Tue, 20 Sep 2022 20:14:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28L3Dxst040846;
        Tue, 20 Sep 2022 22:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663730039;
        bh=KTfIkBAgkkJeo7UshvmEefNsEe/R1AD4BsxUGVSwyHA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jtqZENrvpQVxxINaFpA2xiLSVCkccurIsErj8mbY6EgcMQ7d85qB4dUn39im7Kd9X
         dWSaMS8LYYWh1Vt8G4NyxrETQfcYbGF4wDAsP3aQKmCm/WoQUBVwZ7T6jIHGbnhlvH
         k3DPM9FiQrBuMvikXzHFcuo/CeCtgEY8R18CIRF4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28L3DxO6118012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 22:13:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 20
 Sep 2022 22:13:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 20 Sep 2022 22:13:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28L3DuoO063192;
        Tue, 20 Sep 2022 22:13:57 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 8/9] arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
Date:   Tue, 20 Sep 2022 20:13:26 -0700
Message-ID: <20220921031327.4135-9-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
In-Reply-To: <20220921031327.4135-1-mranostay@ti.com>
References: <20220921031327.4135-1-mranostay@ti.com>
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

From: Aswath Govindraju <a-govindraju@ti.com>

Add PCIe device tree node (both RC and EP) for the single PCIe
instance present in j721s2.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index a4260ffb75c7..fc4cf8b4a28b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -781,6 +781,67 @@ serdes0: serdes@5060000 {
 		};
 	};
 
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
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
+		pcie1_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 276 41>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.37.2

