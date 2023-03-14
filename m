Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991446B95A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjCNNLV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCNNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:10:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127432A153;
        Tue, 14 Mar 2023 06:07:37 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1DE5324E3CA;
        Tue, 14 Mar 2023 20:44:14 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 20:44:14 +0800
Received: from localhost.localdomain (113.72.145.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 20:44:12 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 10/11] riscv: dts: starfive: jh7110: Add DVP and HDMI TX pixel external clocks
Date:   Tue, 14 Mar 2023 20:44:03 +0800
Message-ID: <20230314124404.117592-11-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
References: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DVP and HDMI TX pixel external fixed clocks and the rates are
74.25MHz and 297MHz.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../dts/starfive/jh7110-starfive-visionfive-2.dtsi   |  8 ++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi             | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 2a6d81609284..1155b97b593d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -38,6 +38,10 @@ gpio-restart {
 	};
 };
 
+&dvp_clk {
+	clock-frequency = <74250000>;
+};
+
 &gmac0_rgmii_rxin {
 	clock-frequency = <125000000>;
 };
@@ -54,6 +58,10 @@ &gmac1_rmii_refin {
 	clock-frequency = <50000000>;
 };
 
+&hdmitx0_pixelclk {
+	clock-frequency = <297000000>;
+};
+
 &i2srx_bclk_ext {
 	clock-frequency = <12288000>;
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 417f7f51c219..d2757f4afab3 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -173,6 +173,12 @@ core4 {
 		};
 	};
 
+	dvp_clk: dvp-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "dvp_clk";
+		#clock-cells = <0>;
+	};
+
 	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "gmac0_rgmii_rxin";
@@ -197,6 +203,12 @@ gmac1_rmii_refin: gmac1-rmii-refin-clock {
 		#clock-cells = <0>;
 	};
 
+	hdmitx0_pixelclk: hdmitx0-pixel-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "hdmitx0_pixelclk";
+		#clock-cells = <0>;
+	};
+
 	i2srx_bclk_ext: i2srx-bclk-ext-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "i2srx_bclk_ext";
-- 
2.25.1

