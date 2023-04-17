Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21F56E3E55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDQDrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDQDrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:47:33 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95A9B;
        Sun, 16 Apr 2023 20:47:31 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 82D3224E1B2;
        Mon, 17 Apr 2023 11:47:30 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 11:47:30 +0800
Received: from SD-Server.starfivetech.com (183.27.97.249) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Mon, 17 Apr 2023 11:47:29 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Hal Feng" <hal.feng@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>
Subject: [PATCH v1] riscv: dts: starfive: Add PMU controller node
Date:   Mon, 17 Apr 2023 11:47:28 +0800
Message-ID: <20230417034728.2670-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pmu controller node for the StarFive JH7110 SoC. The PMU needs
to be used by other modules, e.g. VPU,ISP,etc.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
This patch is based on:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=riscv-dt-for-v6.4&id=60bf0a39842eb042bbdc4539285c7e524011fc2d
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4c5fdb905da8..30e1f34d5cf8 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -496,5 +496,12 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		pwrc: power-controller@17030000 {
+			compatible = "starfive,jh7110-pmu";
+			reg = <0x0 0x17030000 0x0 0x10000>;
+			interrupts = <111>;
+			#power-domain-cells = <1>;
+		};
 	};
 };
-- 
2.17.1

