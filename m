Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74091629D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiKOP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiKOP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:26:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE4E1E3D5;
        Tue, 15 Nov 2022 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668525979; x=1700061979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=97PFrgnk+DB1D9eGelLXCgNw+jakJpsENZbaBuQwyoc=;
  b=x+IhVH94ygnSx2c8NebmbbdI4AqTAK2Qaz1t0SILuDEWWAOaHO+mmZGJ
   d3pIWLIUmFnZ7HFp4VftEDBZt8k+lFQlwUKYE0T1VI1/elSdjTcVUPxH8
   XaVbW1bxln29yIyTbpE+AWVk78YfpxFuDugLYS0Dc7feJs46ps8z4QV5d
   Qox8X92aBY0Rhnlx1lAhPpwsFCsJcoIVRxF+zE5dFLKndIQZaY3Eb+KPm
   eLUNkkDqZlLs2LQ567xnasOHeuuOXaiNa4ABHccYMCDl3ZrwjokspIuXY
   KP8fux/S5ys2vzX94blcTd/eWLQsbUOKcZe0ISN+WXtrJz1eSPbddDBW1
   g==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="187073176"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 08:26:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 08:26:10 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 08:26:09 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] riscv: dts: microchip: remove pcie node from the sev kit
Date:   Tue, 15 Nov 2022 15:25:46 +0000
Message-ID: <20221115152546.1425309-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEV kit reference design does not hook up the PCIe root port to the
core complex including it is misleading.
The entry is a re-use mistake - I was not aware of this when I moved
the PCIe node out of mpfs.dtsi so that individual bistreams could
connect it to different fics etc.

Fixes: 978a17d1a688 ("riscv: dts: microchip: add sevkit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../dts/microchip/mpfs-sev-kit-fabric.dtsi    | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
index 8545baf4d129..39a77df489ab 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
@@ -13,33 +13,4 @@ fabric_clk1: fabric-clk1 {
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
-
-	pcie: pcie@2000000000 {
-		compatible = "microchip,pcie-host-1.0";
-		#address-cells = <0x3>;
-		#interrupt-cells = <0x1>;
-		#size-cells = <0x2>;
-		device_type = "pci";
-		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
-		reg-names = "cfg", "apb";
-		bus-range = <0x0 0x7f>;
-		interrupt-parent = <&plic>;
-		interrupts = <119>;
-		interrupt-map = <0 0 0 1 &pcie_intc 0>,
-				<0 0 0 2 &pcie_intc 1>,
-				<0 0 0 3 &pcie_intc 2>,
-				<0 0 0 4 &pcie_intc 3>;
-		interrupt-map-mask = <0 0 0 7>;
-		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
-		clock-names = "fic0", "fic1", "fic3";
-		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
-		msi-parent = <&pcie>;
-		msi-controller;
-		status = "disabled";
-		pcie_intc: interrupt-controller {
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-		};
-	};
 };
-- 
2.38.0

