Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD646D1B28
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjCaJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjCaJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:01:17 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3E1E72F;
        Fri, 31 Mar 2023 02:01:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32V912lX005871;
        Fri, 31 Mar 2023 04:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680253262;
        bh=OlWO5jrT2jfnnwKSAjPVq9NARge1RAycM4qFZ708ejk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TAICsLjFqeNgsse2dRk3gPTddpSZBZV/T8WSuE4PJUUu4Yj7gwmrPhuc/TBOPanjD
         mhzjANuP2JzCeZFtKJmO1f9JorzoCZpGY9QrZcBPeCWw/adCJatXUx7o1ppc5YoRkc
         8zjUHWBxs0Zb8VN4W+ngc3Fg7VNH49pi7gJdeIPg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32V912CS030081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 04:01:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 04:01:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 04:01:02 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32V90Sug125579;
        Fri, 31 Mar 2023 04:00:59 -0500
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 8/8] arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe
Date:   Fri, 31 Mar 2023 14:30:28 +0530
Message-ID: <20230331090028.8373-9-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230331090028.8373-1-r-gunasekaran@ti.com>
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes from v13:
* No changes. Only rebased on top of linux-next

Changes from v12:
* No change

Changes from v11:
* No change

Changes from v10:
* Removed Link tag from commit message

Changes from v9:
* No change

Changes from v8:
* No change

Changes from v7:
* No change

Changes from v6:
* Removed pcie_ep node update

Changes from v5:
* No change

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* Patch newly added to the series

 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index e6d99f19a55f..90f90b7b37e1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -401,6 +401,14 @@
 	};
 };
 
+&pcie1_rc {
+	status = "okay";
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
2.17.1

