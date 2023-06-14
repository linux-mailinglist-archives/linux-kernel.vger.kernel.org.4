Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224572E46D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbjFMNod convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjFMNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:44:17 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791641BC7;
        Tue, 13 Jun 2023 06:44:05 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ED47524E21E;
        Tue, 13 Jun 2023 21:43:56 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Jun
 2023 20:58:56 +0800
Received: from localhost.localdomain (113.72.145.34) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Jun
 2023 20:58:55 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "William Qiu" <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v5 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL clock inputs
Date:   Tue, 13 Jun 2023 20:58:48 +0800
Message-ID: <20230613125852.211636-4-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.34]
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

Add optional PLL clock inputs from PLL clock generator.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clock/starfive,jh7110-syscrg.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
index 84373ae31644..5536e5f9e20b 100644
--- a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
@@ -39,6 +39,33 @@ properties:
           - description: External TDM clock
           - description: External audio master clock
 
+      - items:
+          - description: Main Oscillator (24 MHz)
+          - description: GMAC1 RMII reference or GMAC1 RGMII RX
+          - description: External I2S TX bit clock
+          - description: External I2S TX left/right channel clock
+          - description: External I2S RX bit clock
+          - description: External I2S RX left/right channel clock
+          - description: External TDM clock
+          - description: External audio master clock
+          - description: PLL0
+          - description: PLL1
+          - description: PLL2
+
+      - items:
+          - description: Main Oscillator (24 MHz)
+          - description: GMAC1 RMII reference
+          - description: GMAC1 RGMII RX
+          - description: External I2S TX bit clock
+          - description: External I2S TX left/right channel clock
+          - description: External I2S RX bit clock
+          - description: External I2S RX left/right channel clock
+          - description: External TDM clock
+          - description: External audio master clock
+          - description: PLL0
+          - description: PLL1
+          - description: PLL2
+
   clock-names:
     oneOf:
       - items:
@@ -64,6 +91,35 @@ properties:
           - const: tdm_ext
           - const: mclk_ext
 
+      - items:
+          - const: osc
+          - enum:
+              - gmac1_rmii_refin
+              - gmac1_rgmii_rxin
+          - const: i2stx_bclk_ext
+          - const: i2stx_lrck_ext
+          - const: i2srx_bclk_ext
+          - const: i2srx_lrck_ext
+          - const: tdm_ext
+          - const: mclk_ext
+          - const: pll0_out
+          - const: pll1_out
+          - const: pll2_out
+
+      - items:
+          - const: osc
+          - const: gmac1_rmii_refin
+          - const: gmac1_rgmii_rxin
+          - const: i2stx_bclk_ext
+          - const: i2stx_lrck_ext
+          - const: i2srx_bclk_ext
+          - const: i2srx_lrck_ext
+          - const: tdm_ext
+          - const: mclk_ext
+          - const: pll0_out
+          - const: pll1_out
+          - const: pll2_out
+
   '#clock-cells':
     const: 1
     description:
-- 
2.25.1

