Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9756E1D43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDNHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5DC4EF2;
        Fri, 14 Apr 2023 00:33:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XZfY007127;
        Fri, 14 Apr 2023 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457615;
        bh=083jXrNc6AQHR7AIeRIPMIsQE5piNaPdDjfouAaAhJE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QGRNJDMSUFYGiqoNHufaXP3pMUnDG51c5CydeYRodVLqsBBSrgS8L1gRFH457Mud8
         ktIVNdfXnkqfx+GaKO5yTgNltw4hXeaezP9J/Xnrgs9iknOU+Plwqi5lU7zxO1UuED
         8sD3CuWczl9OCcqlcEO0+zlSLmAEgj/04twInZO0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XZsp031623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XY2H003022;
        Fri, 14 Apr 2023 02:33:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] arm64: dts: ti: k3-am642-evm: Rename regulator node name
Date:   Fri, 14 Apr 2023 02:33:26 -0500
Message-ID: <20230414073328.381336-9-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
References: <20230414073328.381336-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rename the regulator node names to the standard regulator-0.. numbers.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index a1ed102a69f1..9cf181d0199f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -94,7 +94,7 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 		};
 	};
 
-	evm_12v0: fixedregulator-evm12v0 {
+	evm_12v0: regulator-0 {
 		/* main DC jack */
 		compatible = "regulator-fixed";
 		regulator-name = "evm_12v0";
@@ -104,7 +104,7 @@ evm_12v0: fixedregulator-evm12v0 {
 		regulator-boot-on;
 	};
 
-	vsys_5v0: fixedregulator-vsys5v0 {
+	vsys_5v0: regulator-1 {
 		/* output of LM5140 */
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_5v0";
@@ -115,7 +115,7 @@ vsys_5v0: fixedregulator-vsys5v0 {
 		regulator-boot-on;
 	};
 
-	vsys_3v3: fixedregulator-vsys3v3 {
+	vsys_3v3: regulator-2 {
 		/* output of LM5140 */
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
@@ -126,7 +126,7 @@ vsys_3v3: fixedregulator-vsys3v3 {
 		regulator-boot-on;
 	};
 
-	vdd_mmc1: fixed-regulator-sd {
+	vdd_mmc1: regulator-3 {
 		/* TPS2051BD */
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
@@ -138,7 +138,7 @@ vdd_mmc1: fixed-regulator-sd {
 		gpio = <&exp1 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	vddb: fixedregulator-vddb {
+	vddb: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "vddb_3v3_display";
 		regulator-min-microvolt = <3300000>;
-- 
2.40.0

