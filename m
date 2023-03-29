Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736166CD698
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjC2Jgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2Jgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:36:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F6335A7;
        Wed, 29 Mar 2023 02:36:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aSO5042835;
        Wed, 29 Mar 2023 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680082588;
        bh=/dcZ283u7X+liMMXtZQycAUY0vYz5Gk7ukRDULWMk/0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hzT6t7YoteFynG5VOtMjYSdk9ZV3znVqah0ddS/RHkvF34Og70dEWTg52aTpd5OZX
         GvotwoVScRBC/VUPhs5T29UwRQsiomkqoXwDUFo8eeW6cs4mVoRFjZ5bu6RNQjnPKu
         mJQ3Y3xLdvykJp5jfAw3FpkOaxdRFrcZpFJo1lw4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T9aSIG019916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 04:36:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 04:36:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 04:36:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aSJZ101467;
        Wed, 29 Mar 2023 04:36:28 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
Date:   Wed, 29 Mar 2023 04:36:27 -0500
Message-ID: <20230329093627.30719-4-hnagalla@ti.com>
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

The J784S4 SoCs have four TMS320C71x DSP subsystems in the MAIN voltage
domain. The functionality of these DSP subsystems is similar to the C71x
DSP subsystems on earlier k3 device J721S2. Each subsystem has a 48 KB of
L1D configurable SRAM/Cache and 512 KB of L2 SRAM/Cache. This subsystem
has a CMMU but is not currently used. The inter-processor communication
between the main A72 cores and the C71x DSPs is achieved through shared
memory and mailboxes. Add the DT nodes for these DSP processor sub-systems.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 53d337ea35fb..9af0bab5382a 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1152,4 +1152,56 @@
 
 		};
 	};
+
+	c71_0: dsp@64800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x64800000 0x00 0x00080000>,
+		      <0x00 0x64e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <30>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 30 1>;
+		firmware-name = "j784s4-c71_0-fw";
+		status = "disabled";
+	};
+
+	c71_1: dsp@65800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x65800000 0x00 0x00080000>,
+		      <0x00 0x65e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <33>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 33 1>;
+		firmware-name = "j784s4-c71_1-fw";
+		status = "disabled";
+	};
+
+	c71_2: dsp@66800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x66800000 0x00 0x00080000>,
+		      <0x00 0x66e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <37>;
+		ti,sci-proc-ids = <0x32 0xff>;
+		resets = <&k3_reset 37 1>;
+		firmware-name = "j784s4-c71_2-fw";
+		status = "disabled";
+	};
+
+	c71_3: dsp@67800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x67800000 0x00 0x00080000>,
+		      <0x00 0x67e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <40>;
+		ti,sci-proc-ids = <0x33 0xff>;
+		resets = <&k3_reset 40 1>;
+		firmware-name = "j784s4-c71_3-fw";
+		status = "disabled";
+	};
 };
-- 
2.17.1

