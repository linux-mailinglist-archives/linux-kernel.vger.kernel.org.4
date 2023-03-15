Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295DB6BA772
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCOF6d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCOF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:58:26 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3829E3D;
        Tue, 14 Mar 2023 22:58:17 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E536324E18D;
        Wed, 15 Mar 2023 13:58:15 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 13:58:15 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 15 Mar 2023 13:58:14 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [RESEND v6 2/2] riscv: dts: starfive: Add syscon node
Date:   Wed, 15 Mar 2023 13:58:13 +0800
Message-ID: <20230315055813.94740-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315055813.94740-1-william.qiu@starfivetech.com>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
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

Add stg_syscon/sys_syscon/aon_syscon node for JH7110 Soc.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index d484ecdf93f7..49dd62276b0d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -362,6 +362,11 @@ i2c2: i2c@10050000 {
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
@@ -466,6 +471,11 @@ syscrg: clock-controller@13020000 {
 			#reset-cells = <1>;
 		};

+		sys_syscon: syscon@13030000 {
+			compatible = "starfive,jh7110-sys-syscon", "syscon";
+			reg = <0x0 0x13030000 0x0 0x1000>;
+		};
+
 		sysgpio: pinctrl@13040000 {
 			compatible = "starfive,jh7110-sys-pinctrl";
 			reg = <0x0 0x13040000 0x0 0x10000>;
@@ -495,6 +505,11 @@ aoncrg: clock-controller@17000000 {
 			#reset-cells = <1>;
 		};

+		aon_syscon: syscon@17010000 {
+			compatible = "starfive,jh7110-aon-syscon", "syscon";
+			reg = <0x0 0x17010000 0x0 0x1000>;
+		};
+
 		aongpio: pinctrl@17020000 {
 			compatible = "starfive,jh7110-aon-pinctrl";
 			reg = <0x0 0x17020000 0x0 0x10000>;
--
2.34.1

