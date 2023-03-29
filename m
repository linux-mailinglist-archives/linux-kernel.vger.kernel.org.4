Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8856CD69B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjC2Jgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC2Jgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:36:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4453AA6;
        Wed, 29 Mar 2023 02:36:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aSe4013752;
        Wed, 29 Mar 2023 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680082588;
        bh=gaXhbP8PWv3p6aQGobbaF+9E0Wt+yFUAQBInm5hKamQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RxRiTs8sEI/3INBGP4g3e12UUhKcdTH9T9gvjvcuJiKk+27QFAC118Zs+8JTqSRqk
         17VF9vW2MGkt18D2J6DR7Yetzb2hLzOX/EZ0vH+f+HSXQum5msi5eoslN+FFZxhhmN
         ql1jFPkjrD24go63RyUl9gVx+hT6Un8dCCtCRX70=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T9aS4S050807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 04:36:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 04:36:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 04:36:28 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aS2h006491;
        Wed, 29 Mar 2023 04:36:28 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j784s4-mcu: Add MCU domain R5F cluster node
Date:   Wed, 29 Mar 2023 04:36:26 -0500
Message-ID: <20230329093627.30719-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230329093627.30719-1-hnagalla@ti.com>
References: <20230329093627.30719-1-hnagalla@ti.com>
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

The J784S4 SoCs have 4 dual-core Arm Cortex-R5F processor (R5FSS)
subsystems/clusters. One R5F cluster (MCU_R5FSS0) is present within
the MCU domain (MCU_R5FSS0), and the remaining three clusters are
present in the MAIN domain (MAIN_R5FSS0, MAIN_R5FSS1 & MAIN_R5FSS2).
The functionality of the R5FSS is same as the R5FSS functionality on
earlier K3 platform devices J721S2. Each of the R5FSS can be configured
at boot time to be either run in a LockStep mode or in an Asymmetric
Multi Processing (AMP) fashion in Split-mode.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 64bd3dee14aa..e290e0925bc9 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -309,4 +309,46 @@
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	mcu_r5fss0: r5fss@41000000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x41000000 0x00 0x41000000 0x20000>,
+			 <0x41400000 0x00 0x41400000 0x20000>;
+		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
+
+		mcu_r5fss0_core0: r5f@41000000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41000000 0x00010000>,
+			      <0x41010000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <346>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			resets = <&k3_reset 346 1>;
+			firmware-name = "j784s4-mcu-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+
+		mcu_r5fss0_core1: r5f@41400000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41400000 0x00010000>,
+			      <0x41410000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <347>;
+			ti,sci-proc-ids = <0x02 0xff>;
+			resets = <&k3_reset 347 1>;
+			firmware-name = "j784s4-mcu-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.17.1

