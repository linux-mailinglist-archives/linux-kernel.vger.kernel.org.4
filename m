Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B843746A15
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGDGuF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGDGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:49:30 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3AE62;
        Mon,  3 Jul 2023 23:49:22 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D859D8175;
        Tue,  4 Jul 2023 14:49:20 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 14:49:20 +0800
Received: from localhost.localdomain (113.72.144.31) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 14:49:19 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "William Qiu" <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [RESEND PATCH v6 6/7] riscv: dts: starfive: jh7110: Add syscon nodes
Date:   Tue, 4 Jul 2023 14:46:09 +0800
Message-ID: <20230704064610.292603-7-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.31]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Qiu <william.qiu@starfivetech.com>

Add stg_syscon/sys_syscon/aon_syscon/PLL nodes for JH7110 SoC.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4c5fdb905da8..11dd4c9d64b0 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -353,6 +353,11 @@ i2c2: i2c@10050000 {
 			status = "disabled";
 		};
 
+		stg_syscon: syscon@10240000 {
+			compatible = "starfive,jh7110-stg-syscon", "syscon";
+			reg = <0x0 0x10240000 0x0 0x1000>;
+		};
+
 		uart3: serial@12000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x12000000 0x0 0x10000>;
@@ -457,6 +462,17 @@ syscrg: clock-controller@13020000 {
 			#reset-cells = <1>;
 		};
 
+		sys_syscon: syscon@13030000 {
+			compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
+			reg = <0x0 0x13030000 0x0 0x1000>;
+
+			pllclk: clock-controller {
+				compatible = "starfive,jh7110-pll";
+				clocks = <&osc>;
+				#clock-cells = <1>;
+			};
+		};
+
 		sysgpio: pinctrl@13040000 {
 			compatible = "starfive,jh7110-sys-pinctrl";
 			reg = <0x0 0x13040000 0x0 0x10000>;
@@ -486,6 +502,12 @@ aoncrg: clock-controller@17000000 {
 			#reset-cells = <1>;
 		};
 
+		aon_syscon: syscon@17010000 {
+			compatible = "starfive,jh7110-aon-syscon", "syscon";
+			reg = <0x0 0x17010000 0x0 0x1000>;
+			#power-domain-cells = <1>;
+		};
+
 		aongpio: pinctrl@17020000 {
 			compatible = "starfive,jh7110-aon-pinctrl";
 			reg = <0x0 0x17020000 0x0 0x10000>;
-- 
2.25.1

