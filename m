Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F147601792
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJQT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJQT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388218B30;
        Mon, 17 Oct 2022 12:26:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPctN017214;
        Mon, 17 Oct 2022 14:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034738;
        bh=gJnlZ3gu7fn/Vfuey53wcldGkX1GM1+DM6mfFO9jJeo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cOtXbLOtibVGV6o6Sdkh/v00yuNc1JqSKwAaWwP1LCBDMqmyBa/L4PdCJRuqZVG4s
         hKklBcRyNNT/yzAR0kud8iu8DGkj9UwkW3m92kNJwCUxscMsXlxrwYqMCuKYY8POi9
         1mtXPxO3BVGo1528M5ek75ZmWbaBxg2mumeLkliA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPcpf026089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:38 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:38 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXR026106;
        Mon, 17 Oct 2022 14:25:37 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 10/10] arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:32 -0500
Message-ID: <20221017192532.23825-11-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPMC node defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless it is extended with pinmux information.

As the pinmux is only known at the board integration level, this node
should only be enabled when provided with this information.

Disable the GPMC node in the dtsi file. Since the ELM is made to work
with the GPMC, disable it too.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 8 --------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 8 --------
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d6218038055a..c96df4b9b3d7 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1381,6 +1381,7 @@ gpmc0: memory-controller@3b000000 {
 		#interrupt-cells = <2>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		status = "disabled";
 	};
 
 	elm0: ecc@25010000 {
@@ -1390,5 +1391,6 @@ elm0: ecc@25010000 {
 		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 54 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 666f5d3a2d95..39feea78a084 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -589,11 +589,3 @@ &main_mcan1 {
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
-
-&gpmc0 {
-	status = "disabled";
-};
-
-&elm0 {
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 3e6df16fcb59..2e2d40da360a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -566,11 +566,3 @@ &ecap0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
-
-&gpmc0 {
-	status = "disabled";
-};
-
-&elm0 {
-	status = "disabled";
-};
-- 
2.37.3

