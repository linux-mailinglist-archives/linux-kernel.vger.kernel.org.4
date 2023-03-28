Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949276CC0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjC1NaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjC1N3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:50 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDAA5FA;
        Tue, 28 Mar 2023 06:29:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTbHY005664;
        Tue, 28 Mar 2023 08:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010177;
        bh=kVU3fxPuN+E3YCIbaYl85jZLwsmV6nxyeKf/SyfMpTk=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=h/4GOfCEMADPPKJnVzfdMB7xZWesZot0qUsFban3pJ13gPVFPOt/MKmnk0jppCVc+
         DN7DM9CDSeAm92IOZ5I4f4OGmkS2ANNuWzON5YglGrnCfhStIn8izZj5c3/W6F5yNH
         oGENRHHyI0DdZtx0e9t/s8nYxVA0IJuOE6EhMQFw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDTbYA113910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:29:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:29:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:29:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTZxD122345;
        Tue, 28 Mar 2023 08:29:36 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Mar 2023 18:59:22 +0530
Subject: [PATCH v8 4/6] arm64: dts: ti: k3-am62a-main: Add nodes for McASP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v8-4-4408134eb2f3@ti.com>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=R63VlF5mAlSgoaVYF/ip213cmqYqKxSlEFrCk2GElqQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkIuu4FZwNzu/Xl8V1VV6/puk7SB4hinnK7NtQv
 +UY4nGm0uaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCLruAAKCRBD3pH5JJpx
 RUcuD/9PPXlYjU4x3rfNseJ+1KSdk6Wz7acnKxj5M4hbM8CuuJDprWcCBbuS1L78uvjrIQT22BJ
 cee1io2ZK9CYn22+P1fG9cStQ9oqdR6prwzvlWFMSKZttXfE5c3PqH+mDVg7KRYXIqOzDB7w3CD
 rbsIt0dKMMLQAQ5fh3+DQOkMzLg5k2kHg2d/wYJJeSWp0DYpBFArzFiw4mYZEPzNcyt1xJ0z706
 RuI7FCZhlvmMS3i2e3dWhE0WDJKjnnHGPox9oSyTBQWCeAOPs6kJAz0VqO7DzDx3NmD56/Xnt1N
 TNYBFpflVdtZvSYSkaSOfqB6I91FUX0LosYR0zZAOTdbzbxl3eTP/1i7aUy1Xd4632IUQ3Ld8+y
 b8H2Yf5ZqfgPIrSUcbMmwIb94rKuju0RRCzvUN4syR2BG2I8knB95sGoRThhJLb4m14iR5MCzhA
 Q6NyOgAzBHSCS1mAu31He93G94e3gNJlLXfnBTE7pgBb7+EioFtVqlDExz7NRY4KfKVVffL+EoD
 LIXDkWEKf6RWjnalhXbOl3qZ329tE7IeZhBWCTelMytAt1h1rvgYifSwPOffaWXUXihF/ERooJ5
 J6vNcDDpGgNtfzmnz+nGJyUd+aQIgHTgBEaxnUudVMQ8zcIJt+3KgqJbPD/0zLr6c+hpyt6iWVi
 u79LtkNkAUg35rQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as AM62, AM62A has three instances of McASP which can be used for
transmitting or receiving digital audio in various formats.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 393a1a40b68b..50e4fcb1d678 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -660,4 +660,64 @@ ecap2: pwm@23120000 {
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	mcasp0: audio-controller@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 190 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 190 0>;
+		assigned-clock-parents = <&k3_clks 190 2>;
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp1: audio-controller@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 191 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 191 0>;
+		assigned-clock-parents = <&k3_clks 191 2>;
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp2: audio-controller@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 192 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 192 0>;
+		assigned-clock-parents = <&k3_clks 192 2>;
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };

-- 
2.40.0

