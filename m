Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0D6A6986
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCAJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCAJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:12:01 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0030B3E;
        Wed,  1 Mar 2023 01:11:59 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3219BrL1057503;
        Wed, 1 Mar 2023 03:11:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677661913;
        bh=YeJVxM+LaylS88l6dqrFkjDmJJ/W7SPSRkt6kUKaulE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y6WK9OHyiGFezbieol2jzwr+mHgHX87v+XLzuemkRX1JVgq9n39VyM4juGcOhtfsR
         SKFPoqxTFOf15zRgyZ/b4M+6uGGEJkqvfdlwq5Qhm646sARufR0oY7XYFP0kUaRucS
         z9ULFelXtz0VdOn++TRXdEH9gh5EAjKrsuhG4k2c=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3219Br3n061272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Mar 2023 03:11:53 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 1
 Mar 2023 03:11:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 1 Mar 2023 03:11:53 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3219BbbC088843;
        Wed, 1 Mar 2023 03:11:49 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 3/8] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
Date:   Wed, 1 Mar 2023 14:41:31 +0530
Message-ID: <20230301091136.17862-4-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301091136.17862-1-r-gunasekaran@ti.com>
References: <20230301091136.17862-1-r-gunasekaran@ti.com>
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

From: Aswath Govindraju <a-govindraju@ti.com>

Add support for two instance of OSPI in J721S2 SoC.

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes from v11:
* Cleaned up comments

Changes from v10:
* Documented the reason for disabling the nodes by default.
* Removed Link tag from commmit message

Changes from v9:
* Disabled fss, ospi nodes by default in common DT file

Changes from v8:
* Updated "ranges" property to fix dtbs warnings

Changes from v7:
* Removed "reg" property from syscon node
* Renamed the "syscon" node to "bus" to after change in
  compatible property

Changes from v6:
* Fixed the syscon node's compatible property

Changes from v5:
* Updated the syscon node's compatible property
* Removed Cc tags from commit message

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* No change

Changes from v1:
* No change

 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa9816..ab3ce8be7216 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -306,4 +306,50 @@
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	fss: bus@47000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+
+		status = "disabled";
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 109 5>;
+			assigned-clocks = <&k3_clks 109 5>;
+			assigned-clock-parents = <&k3_clks 109 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled"; /* Needs pinmux */
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x07 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 110 5>;
+			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled"; /* Needs pinmux */
+		};
+	};
 };
-- 
2.17.1

