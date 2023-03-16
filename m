Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0C6BC435
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCPDFt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 23:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCPDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:05:25 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B24ED2;
        Wed, 15 Mar 2023 20:05:21 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 35AD624E0D6;
        Thu, 16 Mar 2023 11:05:20 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Mar
 2023 11:05:20 +0800
Received: from localhost.localdomain (113.72.145.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Mar
 2023 11:05:18 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 4/6] dt-bindings: clock: jh7110-syscrg: Add PLL clock inputs
Date:   Thu, 16 Mar 2023 11:05:12 +0800
Message-ID: <20230316030514.137427-5-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
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

Add PLL clock inputs from PLL clock generator.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-syscrg.yaml         | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
index 84373ae31644..55d4e7f09cd5 100644
--- a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
@@ -27,6 +27,9 @@ properties:
           - description: External I2S RX left/right channel clock
           - description: External TDM clock
           - description: External audio master clock
+          - description: PLL0
+          - description: PLL1
+          - description: PLL2
 
       - items:
           - description: Main Oscillator (24 MHz)
@@ -38,6 +41,9 @@ properties:
           - description: External I2S RX left/right channel clock
           - description: External TDM clock
           - description: External audio master clock
+          - description: PLL0
+          - description: PLL1
+          - description: PLL2
 
   clock-names:
     oneOf:
@@ -52,6 +58,9 @@ properties:
           - const: i2srx_lrck_ext
           - const: tdm_ext
           - const: mclk_ext
+          - const: pll0_out
+          - const: pll1_out
+          - const: pll2_out
 
       - items:
           - const: osc
@@ -63,6 +72,9 @@ properties:
           - const: i2srx_lrck_ext
           - const: tdm_ext
           - const: mclk_ext
+          - const: pll0_out
+          - const: pll1_out
+          - const: pll2_out
 
   '#clock-cells':
     const: 1
@@ -93,12 +105,16 @@ examples:
                  <&gmac1_rgmii_rxin>,
                  <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
                  <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
-                 <&tdm_ext>, <&mclk_ext>;
+                 <&tdm_ext>, <&mclk_ext>,
+                 <&pllclk JH7110_CLK_PLL0_OUT>,
+                 <&pllclk JH7110_CLK_PLL1_OUT>,
+                 <&pllclk JH7110_CLK_PLL2_OUT>;
         clock-names = "osc", "gmac1_rmii_refin",
                       "gmac1_rgmii_rxin",
                       "i2stx_bclk_ext", "i2stx_lrck_ext",
                       "i2srx_bclk_ext", "i2srx_lrck_ext",
-                      "tdm_ext", "mclk_ext";
+                      "tdm_ext", "mclk_ext",
+                      "pll0_out", "pll1_out", "pll2_out";
         #clock-cells = <1>;
         #reset-cells = <1>;
     };
-- 
2.25.1

