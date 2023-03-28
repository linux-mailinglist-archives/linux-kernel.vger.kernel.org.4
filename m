Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C1A6CC0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjC1NaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjC1N3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A788BDE6;
        Tue, 28 Mar 2023 06:29:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTYaS039874;
        Tue, 28 Mar 2023 08:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010174;
        bh=rWvpNNJ+up2PcEOCe8VmeF+rx0Zow6iaE7KoOS+Bk1g=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=o40KxPQoZMJ7l8BhPysSbHna5TNykYuH0QlvU5ktgqPyJo2pW/UPwkFOMUW3vLpty
         8ITH+2q16W35gij7HzDH6P/CoG0euqolwNIGbODIsgMFraW3d3Co0G4y8cf3f3vyGU
         4U7pCGKJFH+0JqOqlUVpKM346fQqa7aP/Z2Yh9+4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDTYa6007668
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:29:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:29:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:29:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTX49031399;
        Tue, 28 Mar 2023 08:29:33 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Mar 2023 18:59:20 +0530
Subject: [PATCH v8 2/6] arm64: dts: ti: k3-am62-main: Add McASP nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v8-2-4408134eb2f3@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=3YQ8iDFX2K1gkT2KWC73dpEyDkmFbkpNff4cJhstfZY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkIuu2sUumGGllyRYCduia9i8fP+YZoVTAWWfSo
 fudc40jPxyJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCLrtgAKCRBD3pH5JJpx
 RSDSEACZZ+5iIekhm5klw6NeU4H5AHv1T8TVpmZMrRuFZIV6JT0AxDUemL5i3y+EJ0taEutJEf0
 kBoGX4HprkU00yx9pbNt4SN1ftH8j8NzYcjjS/GfELf4K80FySBRbo3NzgAJ6OXJgYyE0Dhr/TT
 CVnXLJ3UWl41p7c0Bdd5RLBTdgLsE4nX2UcpANI83nQT64HN+5axfcbaCYOCBncHpTyJX5Y9mfW
 rAfCi+lYqjEPB/C3HTiizTDV0w5N2g7s5ecKnEH5bHgTDDIih2h35+rDN1j52xD/HZGUOMPM/yR
 LPxPwec0hYo2kms0kCejJa3t67UN2fraujj8eRFg5Ph2p5f7heGA9h/XboQ6NDpIuPp/bxfH4k7
 Kn+0KyCdWdFzvYmlG/5/8z8mal22uOcJ3qvXQjEw7ugvVcnEZYs++A1rot1NdM208By2QfeQlm5
 kJHlfbmOIM6kKvjWzhC0Yjs4V6eKJj5EGOM7VWeZbS0HRc4LF3964Ls+6rCKWYrDQYwjhMs0yjn
 ep3KrdmO/wRjs6NReNEx3l/exriKwQgFjPM5J3zpeqOul44csY01elH4mhF1S/zZUm2MZUA3SWw
 N8UBLFrL3dVByeMucpftU53juRPMB38jr+WLIN4QgDwtCGfyrC9ZCJPO70EWaW5d7C/aKk4+BvQ
 VVVEgjqtaReHpag==
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

From: Jayesh Choudhary <j-choudhary@ti.com>

Add the nodes for McASP 0-2.

Use the audio-friendly 96MHz main_1_hsdivout6_clk as clock parent
instead of the default 100Mhz main_2_hsdivout8_clk source.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 16e14863d7df..b3e4857bbbe4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -832,4 +832,64 @@ epwm2: pwm@23020000 {
 		clock-names = "tbclk", "fck";
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

