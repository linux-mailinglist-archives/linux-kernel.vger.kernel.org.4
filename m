Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF576EE2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjDYNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjDYNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:16:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988BDD313;
        Tue, 25 Apr 2023 06:16:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PDGATs041597;
        Tue, 25 Apr 2023 08:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682428570;
        bh=cfTsryCJSzvdJgQbxmkYonliSoRolSSNGlJZ9bAMWzw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Uc/IEpcOFUWi7pmvJoBbU6snetZxfYqN1dJYv70gL9UxG/R8PBZ+Mmrc3gpbIYN3e
         mx2kG04d7mzwlT2HFginFoP160XH4YxRCDv+SGINpUzrbtLxFdxNk9/Clffj8n3nFt
         B3r0oG5HHIebxuCPlbJAzP5+qh1NZf+E8ucCGlzE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PDGArJ002162
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 08:16:10 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 08:16:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 08:16:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PDG9fA070976;
        Tue, 25 Apr 2023 08:16:09 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <afd@ti.com>, <s-vadapalli@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v4 1/5] arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane mux
Date:   Tue, 25 Apr 2023 18:46:03 +0530
Message-ID: <20230425131607.290707-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425131607.290707-1-j-choudhary@ti.com>
References: <20230425131607.290707-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddharth Vadapalli <s-vadapalli@ti.com>

The system controller node manages the CTRL_MMR0 region.
Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[j-choudhary@ti.com: Add reg property to fix dtc warning]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e9169eb358c1..29be6d28ee31 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -5,6 +5,9 @@
  * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/mux/mux.h>
+#include <dt-bindings/mux/ti-serdes.h>
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -26,6 +29,26 @@ l3cache-sram@200000 {
 		};
 	};
 
+	scm_conf: syscon@100000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x00 0x00100000 0x00 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00100000 0x1c000>;
+
+		serdes_ln_ctrl: mux-controller@4080 {
+			compatible = "mmio-mux";
+			reg = <0x00004080 0x30>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
+					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
+					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
+					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
+					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
-- 
2.25.1

