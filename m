Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774CB6E1D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDNHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDNHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B54C32;
        Fri, 14 Apr 2023 00:33:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XZIP010935;
        Fri, 14 Apr 2023 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457615;
        bh=P9XUGwXAcQKuMYRudFoPCs2NL4Uupy+cUaqAiVYJUac=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aYabL4E5+nIsKvk8CiL3dYYBWVdn47ng4UM+gBUva+QKKjGhF9JjeqvBA0VKwXQJ8
         mkMyv6aj5YJTqRQgciUEj1BLHgHLdIFfJGSQH692vLAt2AxVLBYLJisPCWdsqS/nVw
         tFfNVWPX6EJ6Yn3GMHFzHnkGTrmLFsrHxtNdQ/Cg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XZPS091070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYvI021430;
        Fri, 14 Apr 2023 02:33:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] arm64: dts: ti: k3-am642-sk|evm: Drop bootargs, add aliases
Date:   Fri, 14 Apr 2023 02:33:28 -0500
Message-ID: <20230414073328.381336-11-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
References: <20230414073328.381336-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Drop bootargs and add aliases based on base pinout of SK as per [1] and
evm per [2].

Indices chosen attempt to maintain some level of consistency with
existing aliases.

While at this, drop a extra EoL. While this patch could be split, it
seems trivial to add additional cleanup steps.

[1] https://www.ti.com/lit/df/sprr432/sprr432.pdf
[2] https://www.ti.com/lit/zip/swrr171

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64.dtsi     | 16 ----------------
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 15 +++++++++++++--
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 14 ++++++++++++--
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 60fe95b48312..d6262b5a0a10 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -19,22 +19,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &mcu_uart0;
-		serial1 = &mcu_uart1;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		serial5 = &main_uart3;
-		serial6 = &main_uart4;
-		serial7 = &main_uart5;
-		serial8 = &main_uart6;
-		ethernet0 = &cpsw_port1;
-		ethernet1 = &cpsw_port2;
-		mmc0 = &sdhci0;
-		mmc1 = &sdhci1;
-	};
-
 	chosen { };
 
 	firmware {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 3d0b473d5252..3db740f78cd2 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -18,14 +18,25 @@ / {
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	aliases {
+		serial0 = &mcu_uart0;
+		serial1 = &main_uart1;
+		serial2 = &main_uart0;
+		serial3 = &main_uart3;
+		i2c0 = &main_i2c0;
+		i2c1 = &main_i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
 	};
 
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
 	};
 
 	reserved-memory {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 5bd69a8e8063..003cff9a2799 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -18,14 +18,24 @@ / {
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	aliases {
+		serial0 = &mcu_uart0;
+		serial1 = &main_uart1;
+		serial2 = &main_uart0;
+		i2c0 = &main_i2c0;
+		i2c1 = &main_i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
 	};
 
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
 	};
 
 	reserved-memory {
-- 
2.40.0

