Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751A4618C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKCXIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKCXHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:07:11 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 914B51F603;
        Thu,  3 Nov 2022 16:07:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.96,135,1665414000"; 
   d="scan'208";a="141406971"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2022 08:07:09 +0900
Received: from mulinux.home (unknown [10.226.92.174])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AD999400B9CF;
        Fri,  4 Nov 2022 08:07:05 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 2/3] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
Date:   Thu,  3 Nov 2022 23:06:47 +0000
Message-Id: <20221103230648.53748-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
References: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.

renesas,i2c-r9a09g011 is not actually used by the driver, therefore
changing this doesn't cause any harm.

Fixes: ba7a4d15e2c4 ("dt-bindings: i2c: Document RZ/V2M I2C controller")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
index c46378efc123..92e899905ef8 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
@@ -16,7 +16,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,i2c-r9a09g011  # RZ/V2M
+          - renesas,r9a09g011-i2c  # RZ/V2M
       - const: renesas,rzv2m-i2c
 
   reg:
@@ -66,7 +66,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     i2c0: i2c@a4030000 {
-        compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+        compatible = "renesas,r9a09g011-i2c", "renesas,rzv2m-i2c";
         reg = <0xa4030000 0x80>;
         interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>,
                      <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1

