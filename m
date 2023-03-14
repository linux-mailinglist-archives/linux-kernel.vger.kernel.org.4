Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD96B98F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjCNP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjCNP02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:26:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E72A90AF;
        Tue, 14 Mar 2023 08:26:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EFQFvp034003;
        Tue, 14 Mar 2023 10:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678807575;
        bh=bUlS1XDh1SiyLkHKtty1uerUX/cPuFQFnrDu+X2hbBU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=v1ROpvPoYgZhvmN0kmxNO7/Ua/Gt/K9VQ+BEewFnfIIu6Txs5LJC4wn06hKOTzRBO
         CBPSjPbJvi4V5AVl8Ia7eJ6d6MlZ10AiG9JqjaE49nngPVPaY+yiFJUF9sFf+1BmNG
         8vjWe/zJeFimZ8qv/GM8l1GNX5an2wmxqY6aBKwY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EFQFQa007520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 10:26:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 10:26:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 10:26:15 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EFQEAv017680;
        Tue, 14 Mar 2023 10:26:15 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-nandan@ti.com>,
        <hnagalla@ti.com>, <vaishnav.a@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator
Date:   Tue, 14 Mar 2023 20:56:11 +0530
Message-ID: <20230314152611.140969-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314152611.140969-1-j-choudhary@ti.com>
References: <20230314152611.140969-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node for SA2UL to support hardware crypto algorithms,
including SHA-1/256/512, AES, 3DES and AEAD suites.
Add rng node for hardware random number generator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 80a1b08c51a8..8c1474a7bd0f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -72,6 +72,25 @@ main_pmx0: pinctrl@11c000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_crypto: crypto@4e00000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x4e00000 0x00 0x1200>;
+		power-domains = <&k3_pds 369 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
+
+		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
+				<&main_udmap 0x4a41>;
+		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@4e10000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x4e10000 0x00 0x7d>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x200>;
-- 
2.25.1

