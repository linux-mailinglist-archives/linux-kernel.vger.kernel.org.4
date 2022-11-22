Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C563399F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiKVKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiKVKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:17:07 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FD554D6;
        Tue, 22 Nov 2022 02:17:03 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMAGx7d096045;
        Tue, 22 Nov 2022 04:16:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669112219;
        bh=cN2rqEsmXZ3LoONcfjQ9oRQd9dmNmx7VWNhQa5s4nMQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qMoBQ3A5gutUxye5sZgifXP12FkJVMXlFleeEMFHbiMvvpsaBecI2Y6W30TRdc5ET
         vFB1NIv9clqbs9bcbNlbcnwp24WNaygv6y5itflvBfBYRYXo+x2RftVMVSppCE33CY
         V260ZHSgNcWpCi4NH05Q9sgZZpffmHS8rFV2bfDE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMAGx0C079817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 04:16:59 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 04:16:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 04:16:58 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMAGuUm089004;
        Tue, 22 Nov 2022 04:16:57 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 8/8] arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe
Date:   Tue, 22 Nov 2022 02:16:16 -0800
Message-ID: <20221122101616.770050-9-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221122101616.770050-1-mranostay@ti.com>
References: <20221122101616.770050-1-mranostay@ti.com>
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

x1 lane PCIe slot in the common processor board is enabled and connected to
J721S2 SOM. Add PCIe DT node in common processor board to reflect the
same.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 0503e690cfaf..561d70cdee9b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -374,6 +374,13 @@ flash@0{
 	};
 };
 
+&pcie1_rc {
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+};
+
 &mcu_mcan0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.38.GIT

