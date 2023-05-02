Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611D6F4D7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEBXPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEBXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:15:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6082118;
        Tue,  2 May 2023 16:15:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 342NFSdi002924;
        Tue, 2 May 2023 18:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683069328;
        bh=V0jW4GPdmlrkl30z4+9eBntBTwa/dGMA67qZtFyhIok=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZJrY+KQHbd3ys8JnV+NJ8gDoiC6wZ+hiwPQozARV3J9jvxEjUJH0IqVWtTjE52oBE
         xsmVop6FrnT2To0gdjQgzOMH+8nJj1vTlTs7dAQbQ7+bMtgFUtSFkJ7fQaJ9FrATQm
         35dN8t5534iie6xfSvhvX7vNgR/2MGiMXWY8onOc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 342NFS9J126716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 May 2023 18:15:28 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 May 2023 18:15:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 May 2023 18:15:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 342NFRqA049494;
        Tue, 2 May 2023 18:15:27 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
Date:   Tue, 2 May 2023 18:15:25 -0500
Message-ID: <20230502231527.25879-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230502231527.25879-1-hnagalla@ti.com>
References: <20230502231527.25879-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Add the DT nodes for the R5F cluster/subsystems, the two R5F cores are
each added as child nodes to the corresponding cluster node. The clusters
are configured to run in LockStep mode by default, with the ATCMs enabled
to allow the R5 cores to execute code from DDR with boot-strapping code
from ATCM. The inter-processor communication between the main A72 cores
and these processors is achieved through shared memory and Mailboxes.

The following firmware names are used by default for these cores, and
can be overridden in a board dts file if needed:
    MAIN R5FSS0 Core0: j784s4-main-r5f0_0-fw (both in LockStep and Split modes)
    MAIN R5FSS0 Core1: j784s4-main-r5f0_1-fw (needed only in Split mode)
    MAIN R5FSS1 Core0: j784s4-main-r5f1_0-fw (both in LockStep and Split modes)
    MAIN R5FSS1 Core1: j784s4-main-r5f1_1-fw (needed only in Split mode)
    MAIN R5FSS2 Core0: j784s4-main-r5f2_0-fw (both in LockStep and Split modes)
    MAIN R5FSS2 Core1: j784s4-main-r5f2_1-fw (needed only in Split mode)
    MCU R5FSS0 Core0: j784s4-mcu-r5f0_0-fw (needed only in Split mode)
    MCU R5FSS0 Core1: j784s4-mcu-r5f0_1-fw (needed only in Split mode)

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 120 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  40 ++++++
 2 files changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e9169eb358c1..3c785cef4f20 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1112,4 +1112,124 @@ main_spi7: spi@2170000 {
 		clocks = <&k3_clks 383 1>;
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
+		};
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
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f04fcb614cbe..e517043d3eb2 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -342,4 +342,44 @@ cpts@3d000 {
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
+		};
+	};
 };
-- 
2.34.1

