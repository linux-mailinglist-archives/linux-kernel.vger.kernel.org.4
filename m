Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9B6FFEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbjELCWf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 22:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjELCWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:22:23 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D159C5;
        Thu, 11 May 2023 19:22:22 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B900324E291;
        Fri, 12 May 2023 10:22:15 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 10:22:15 +0800
Received: from localhost.localdomain (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 10:22:14 +0800
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
Subject: [PATCH v4 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL clock inputs
Date:   Fri, 12 May 2023 10:20:32 +0800
Message-ID: <20230512022036.97987-4-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PLL clock inputs from PLL clock generator.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-syscrg.yaml         | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
index 84373ae31644..fcb363353050 100644
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
+                 <&pllclk 0>,
+                 <&pllclk 1>,
+                 <&pllclk 2>;
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

