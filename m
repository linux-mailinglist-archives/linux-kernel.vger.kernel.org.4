Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7536B716A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjE3Q7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjE3Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:59:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EB1BD;
        Tue, 30 May 2023 09:59:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx19P078904;
        Tue, 30 May 2023 11:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685465941;
        bh=t0Em9EaCYQjYsxC+cWcjR0XK+W/RjuPjZeE/KBWkhCA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mYh2AUobVsXvW6UK9RQj9U/456RYLxmArFkg8jb87eHhzJnXA2yH3fSkErbndKKcm
         QQdYOx3j4Zd+CTiWkxACRpzhcZ5ILApD8Mje1JGJIMTnnJzDMNMHTrd9wG13t8fqrb
         mJ/FNh7lUMhdu8xgqD6TqypKeQq7r0r6w1W3a+WE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UGx1Ph029844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 11:59:01 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 11:59:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 11:59:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1wO036774;
        Tue, 30 May 2023 11:59:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH 7/7] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add sa3_secproxy and mcu_sec_proxy
Date:   Tue, 30 May 2023 11:59:00 -0500
Message-ID: <20230530165900.47502-8-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230530165900.47502-1-nm@ti.com>
References: <20230530165900.47502-1-nm@ti.com>
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

Security Management Subsystem(SMS) has it's own unique secure
proxy as part of Security Accelerator (SA3) module. This is used
for communicating with ROM and for special usecases such as HSM
operations. In addition MCU island has it's own secure proxy for
usecases involving the MCU micro controllers. These are in addition
to the one in the main domain DMSS subsystem that is used for general
purpose communication.

Describe the nodes for use with bootloaders and firmware that require
these communication paths which uses interrupts to corresponding micro
controller interrupt controller. Mark the node as disabled since these
instances do not have interrupts routed to the main processor by
default for a complete description of the node.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch

 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f04fcb614cbe..0dc957e989fb 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -39,6 +39,21 @@ chipid@43000014 {
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
 
+	secure_proxy_sa3: mailbox@43600000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x43600000 0x00 0x10000>,
+		      <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
 	mcu_ram: sram@41c00000 {
 		compatible = "mmio-sram";
 		reg = <0x00 0x41c00000 0x00 0x100000>;
@@ -280,6 +295,21 @@ mcu_udmap: dma-controller@285c0000 {
 		};
 	};
 
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x00 0x2a480000 0x00 0x80000>,
+		      <0x00 0x2a380000 0x00 0x80000>,
+		      <0x00 0x2a400000 0x00 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
 	mcu_cpsw: ethernet@46000000 {
 		compatible = "ti,j721e-cpsw-nuss";
 		#address-cells = <2>;
-- 
2.40.0

