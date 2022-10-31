Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64A0613EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJaUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:06:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189C13EB8;
        Mon, 31 Oct 2022 13:06:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VK6aAg054756;
        Mon, 31 Oct 2022 15:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667246796;
        bh=e8QC9EQqOqeUI8BDYW1Gjrl96J62w1MR4bj6r4Ykpcs=;
        h=From:To:CC:Subject:Date;
        b=Yg/YRB4qey3u+029Ya8rHITuNVdsVIQIIlXVuyMLjfCtmunIgBwLyzCg3kWPg0Sru
         /n+6hS0yCmL/Irp4wyTSInr7dYhnZ6rFAd9+85aN8HhFdzE9xx6bdOha8uX3qx8zHN
         tZLp4cFg0u/+JwrW5msB3AmYowtDBZNEjyXOmMng=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VK6asO028332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 15:06:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 15:06:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 15:06:35 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VK6Y5r086877;
        Mon, 31 Oct 2022 15:06:35 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-j721s2-main: Enable crypto accelerator
Date:   Tue, 1 Nov 2022 01:36:33 +0530
Message-ID: <20221031200633.26997-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node for SA2UL for supporting hardware crypto algorithms,
including SHA1, SHA256, SHA512, AES, 3DES and AEAD suites.
Add rng node for hardware random number generator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Acked-by: Matt Ranostay <mranostay@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
---

Changes have been tested on local j721s2-evm board. Tcrypt tests
and crypto self-tests were passing.

Changelog v2 -> v3:
- remove the clock property from rng node
  (<https://lore.kernel.org/all/20220901171041.32056-1-afd@ti.com/>)

Changelog v1 -> v2:
- change the TI_SCI flag from shared to exclusive as OP-TEE uses MCU
  domain SA2UL instance and not the main domain instance
- remove the 'dma-coherent' property (Binding changes are merged)
- add the rng node which can be used as well for hwrng along with
  optee-rng

v2 patch: https://lore.kernel.org/all/20221031135416.350010-1-j-choudhary@ti.com/  

Testing log: https://gist.github.com/Jayesh2000/26acf0e63f7edcd4b267122e4c73b9a8

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index d1ec26110376..2e0ba2262e77 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -72,6 +72,25 @@ main_pmx0: pinctrl@11c000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_crypto: crypto@4e00000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x4e00000 0x00 0x1200>;
+		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x04e00000 0x00 0x04e00000 0x00 0x30000>;
+
+		dmas = <&main_udmap 0xca40>, <&main_udmap 0x4a40>,
+				<&main_udmap 0x4a41>;
+		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@4e10000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x0 0x4e10000 0x0 0x7d>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x200>;
-- 
2.25.1

