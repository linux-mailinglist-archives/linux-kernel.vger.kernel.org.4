Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91E6C0A16
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCTFaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:30:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB012BE1;
        Sun, 19 Mar 2023 22:30:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K5UWRu126950;
        Mon, 20 Mar 2023 00:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679290232;
        bh=I+xgBTbwuqV6/4gZEpUBUamg94OAlgaTwsjjfkMmoBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DFkME6JDT4/PEtkUYw/96Na0arf5zliX1PHB5Vn1SqtCHCnapxF9Reebsk9Gn0Y8i
         3Xq/YeEs5jTVSTMAxPC54osOLJqkqAa+xOpMNWDfDyyi8pL8SWeQFkWmDps2WsA2XM
         /zj7Fpv9frbWasvHniRy9q2HoBziOf8I4fKAQTXs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K5UWjZ008219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 00:30:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 00:30:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 00:30:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K5UUVG059519;
        Mon, 20 Mar 2023 00:30:31 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 4/8] arm64: dts: ti: k3-j7200-mcu-wakeup: Add MCSPI nodes
Date:   Mon, 20 Mar 2023 11:00:18 +0530
Message-ID: <20230320053022.11093-5-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320053022.11093-1-vaishnav.a@ti.com>
References: <20230320053022.11093-1-vaishnav.a@ti.com>
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

J7200 has 3 MCSPI instances in the MCU domain. Add the
DT nodes for all the 3 instances and keep them disabled.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index de56a0165bd0..331b4e482e41 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -305,6 +305,39 @@
 		status = "disabled";
 	};
 
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 274 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 275 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 276 0>;
+		status = "disabled";
+	};
+
 	fss: syscon@47000000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x00 0x47000000 0x00 0x100>;
-- 
2.17.1

