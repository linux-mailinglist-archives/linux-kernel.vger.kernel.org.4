Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9A716A53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjE3RAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjE3Q71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:59:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056591BF;
        Tue, 30 May 2023 09:59:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1Y4061539;
        Tue, 30 May 2023 11:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685465941;
        bh=3ID8BZ1o8ZKNFJycwj1WNtac6miK8bvNXEVgI5AXbQo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i4ftOB6NKtxn+NXooe8UVe08RuiE+CYkYFG0mflWOImjThzu4ssZN6JTCjmqqE1us
         wS6RQJyHvvbf1ZnJvNaU6AVTyKf3XnZiUyfsFtsofl+kCkxDNGUfg6AxFIf0M2ld8z
         /cTEyT0zb2Z/Ak6/L2/XveiGx+Q+buVxbwxqOjwM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UGx1K1087482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 11:59:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 11:59:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 11:59:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1bY038969;
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
Subject: [PATCH 2/7] arm64: dts: ti: k3-am62a-main: Add sa3_secproxy
Date:   Tue, 30 May 2023 11:58:55 -0500
Message-ID: <20230530165900.47502-3-nm@ti.com>
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
operations. This is in addition to the one in the main domain DMSS
subsystem that is used for general purpose communication.

Describe the node for use with bootloaders and firmware that require
this communication path which uses interrupts to corresponding micro
controller interrupt controller. Mark the node as disabled since this
instance does not have interrupts routed to the main processor by
default for a complete description of the node.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 393a1a40b68b..e2b429d123b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -169,6 +169,21 @@ k3_reset: reset-controller {
 		};
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
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2ac>;
-- 
2.40.0

