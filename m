Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEE5BAC65
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiIPL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiIPL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:27:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0260A5C4E;
        Fri, 16 Sep 2022 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663327652; x=1694863652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fKL2pKdfe49aKzGqeWYbXuxKM2r4HTWOwpLHntUQotA=;
  b=lRdEoGMLAPEwfJSe70Xeqv7yJHxphG5/6Jy//Cl474xyxTOMr9j7kkL7
   xNnobb3G2LRM0Lsjjf8F1uwk2LJ9z84tsWBHf9I+/QB/smc+LD/b57hpI
   GIw1cy7IO1WvhHVbnoyfGmR08hohLhI3U2K6HhYnsFr2K193l+B5zIF90
   EoZXy4LCegoRZBF8ne1+8DOn+VN5AhJeevPL7BN3zEu5pftKjmR6Dt2c/
   G9Q2//Mh1px9QQn0nSEmTujoZHOadaHsJMoiQAoTdyiRG7fLdsAT7BveY
   GoxRSxHoAIVaMXKpcigL9RYUwjtQJURQJLssoB4IWL3ZK8IkEjvYhoNqv
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="180674465"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 04:27:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 04:27:30 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 04:27:28 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/10] riscv: dts: microchip: icicle: update pci address properties
Date:   Fri, 16 Sep 2022 12:26:42 +0100
Message-ID: <20220916112645.567794-7-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220916112645.567794-1-conor.dooley@microchip.com>
References: <20220916112645.567794-1-conor.dooley@microchip.com>
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

For the v2022.09 reference design the PCI root port's data region has
been moved to FIC1 from FIC0. This is a shorter path, allowing for
higher clock rates and improved through-put. As a result, the address at
which the PCIe's data region appears to the core complex has changed.
The config region's address is unchanged.

As FIC0 is no longer used, its clock can be removed too.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi    | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index a21440c8ee03..32d51c4a5b0c 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
+
 	compatible = "microchip,mpfs-icicle-reference-rtlv2209", "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
 
@@ -38,13 +39,13 @@ fabric_clk1: fabric-clk1 {
 		clock-frequency = <125000000>;
 	};
 
-	pcie: pcie@2000000000 {
+	pcie: pcie@3000000000 {
 		compatible = "microchip,pcie-host-1.0";
 		#address-cells = <0x3>;
 		#interrupt-cells = <0x1>;
 		#size-cells = <0x2>;
 		device_type = "pci";
-		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
+		reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
 		reg-names = "cfg", "apb";
 		bus-range = <0x0 0x7f>;
 		interrupt-parent = <&plic>;
@@ -54,9 +55,9 @@ pcie: pcie@2000000000 {
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
 		interrupt-map-mask = <0 0 0 7>;
-		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
-		clock-names = "fic0", "fic1", "fic3";
-		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
+		clocks = <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic1", "fic3";
+		ranges = <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
 		dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
 		msi-parent = <&pcie>;
 		msi-controller;
-- 
2.36.1

