Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B604B66D3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjAQBzv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Jan 2023 20:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjAQBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:55:36 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4F29E11;
        Mon, 16 Jan 2023 17:55:28 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A294F24DBCE;
        Tue, 17 Jan 2023 09:55:26 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 09:55:26 +0800
Received: from ubuntu.localdomain (202.190.108.220) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 09:55:22 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 3/3] riscv: dts: starfive: Add TRNG node for VisionFive 2
Date:   Tue, 17 Jan 2023 09:54:45 +0800
Message-ID: <20230117015445.32500-4-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
References: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.190.108.220]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding StarFive TRNG controller node to VisionFive 2 SoC.

Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4ac159d79d66..3c29e0bc6246 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -455,5 +455,15 @@ uart5: serial@12020000 {
 			reg-shift = <2>;
 			status = "disabled";
 		};
+
+		rng: rng@1600c000 {
+			compatible = "starfive,jh7110-trng";
+			reg = <0x0 0x1600C000 0x0 0x4000>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
+			clock-names = "hclk", "ahb";
+			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
+			interrupts = <30>;
+		};
 	};
 };
-- 
2.25.1

