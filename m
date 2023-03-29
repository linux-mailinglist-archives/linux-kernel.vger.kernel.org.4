Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76586CD69C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjC2Jgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjC2Jgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:36:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3F35B5;
        Wed, 29 Mar 2023 02:36:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aS2D042831;
        Wed, 29 Mar 2023 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680082588;
        bh=1ICfBUAalm9Mo+irDxYjkYeWdW7D7m17ObdJnes+KYs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A0i0kX3y9fAN7Emh0zyTXI5FDFCIdGXGdluLwNC1zKu7BetWIo3mhyJIFtLPXtmdt
         ftdnFtnfTPNhMBMkM38eXqntDgw3qT0EwdM+zgCkn+kvq//HbFPaEuJ8IEffCbsda2
         hGEqVJmEm0amSGsB1FxwnZJDcplrBtOcFFqS+hDs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T9aSBK019912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 04:36:28 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 04:36:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 04:36:27 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aReU015858;
        Wed, 29 Mar 2023 04:36:27 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add MAIN domain R5F cluster nodes
Date:   Wed, 29 Mar 2023 04:36:25 -0500
Message-ID: <20230329093627.30719-2-hnagalla@ti.com>
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
the MCU domain, and the remaining three clusters are present in the
MAIN domain (MAIN_R5FSS0, MAIN_R5FSS1 & MAIN_R5FSS2). The functionality
of the R5FSS is same as the R5FSS functionality on earlier K3 platform
device J721S2. Each of the R5FSS can be configured at boot time to be
either run in a LockStep mode or in an Asymmetric Multi Processing (AMP)
fashion in Split-mode. These subsystems have 64 KB each Tightly-Coupled
Memory (TCM) internal memories for each core split between two banks -
ATCM and BTCM (further interleaved into two banks). There are some IP
integration differences from standard Arm R5 clusters such as the absence
of an ACP port, presence of an additional TI-specific Region Address
Translater (RAT) module for translating 32-bit CPU addresses into
larger system bus addresses etc.

Add the DT nodes for these three MAIN domain R5F cluster/subsystems,
the two R5F cores are each added as child nodes to the corresponding
main cluster node. The clusters are configured to run in LockStep
mode by default, with the ATCMs enabled to allow the R5 cores to execute
code from DDR with boot-strapping code from ATCM. The inter-processor
communication between the main A72 cores and these processors is
achieved through shared memory and Mailboxes.

The following firmware names are used by default for these cores, and
can be overridden in a board dts file if needed:
    MAIN R5FSS0 Core0: j784s4-main-r5f0_0-fw (both in LockStep and Split modes)
    MAIN R5FSS0 Core1: j784s4-main-r5f0_1-fw (needed only in Split mode)
    MAIN R5FSS1 Core0: j784s4-main-r5f1_0-fw (both in LockStep and Split modes)
    MAIN R5FSS1 Core1: j784s4-main-r5f1_1-fw (needed only in Split mode)
    MAIN R5FSS2 Core0: j784s4-main-r5f2_0-fw (both in LockStep and Split modes)
    MAIN R5FSS2 Core1: j784s4-main-r5f2_1-fw (needed only in Split mode)

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 8c1474a7bd0f..53d337ea35fb 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1024,4 +1024,132 @@
 		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
 		status = "disabled";
 	};
+
+	main_r5fss0: r5fss@5c00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
+			 <0x5d00000 0x00 0x5d00000 0x20000>;
+		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss0_core0: r5f@5c00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5c00000 0x00010000>,
+			      <0x5c10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <339>;
+			ti,sci-proc-ids = <0x06 0xff>;
+			resets = <&k3_reset 339 1>;
+			firmware-name = "j784s4-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+
+		main_r5fss0_core1: r5f@5d00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5d00000 0x00010000>,
+			      <0x5d10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <340>;
+			ti,sci-proc-ids = <0x07 0xff>;
+			resets = <&k3_reset 340 1>;
+			firmware-name = "j784s4-main-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+
+	};
+
+	main_r5fss1: r5fss@5e00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
+			 <0x5f00000 0x00 0x5f00000 0x20000>;
+		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss1_core0: r5f@5e00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5e00000 0x00010000>,
+			      <0x5e10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <341>;
+			ti,sci-proc-ids = <0x08 0xff>;
+			resets = <&k3_reset 341 1>;
+			firmware-name = "j784s4-main-r5f1_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+
+		main_r5fss1_core1: r5f@5f00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5f00000 0x00010000>,
+			      <0x5f10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <342>;
+			ti,sci-proc-ids = <0x09 0xff>;
+			resets = <&k3_reset 342 1>;
+			firmware-name = "j784s4-main-r5f1_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+	};
+
+	main_r5fss2: r5fss@5900000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5900000 0x00 0x5900000 0x20000>,
+			 <0x5a00000 0x00 0x5a00000 0x20000>;
+		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss2_core0: r5f@5900000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5900000 0x00010000>,
+			      <0x5910000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <343>;
+			ti,sci-proc-ids = <0x0a 0xff>;
+			resets = <&k3_reset 343 1>;
+			firmware-name = "j784s4-main-r5f2_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+		};
+
+		main_r5fss2_core1: r5f@5a00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5a00000 0x00010000>,
+			      <0x5a10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <344>;
+			ti,sci-proc-ids = <0x0b 0xff>;
+			resets = <&k3_reset 344 1>;
+			firmware-name = "j784s4-main-r5f2_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			status = "disabled";
+
+		};
+	};
 };
-- 
2.17.1

