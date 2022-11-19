Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFAF630EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiKSMcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKSMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:32:08 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CED8B103
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:32:08 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id E9AC6378664
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oTq_foI5nZAB for <linux-kernel@vger.kernel.org>;
        Sat, 19 Nov 2022 13:37:04 +0100 (CET)
Received: from werkpc.localnet (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id 3D73A36029F;
        Sat, 19 Nov 2022 13:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1668861417; bh=rnG8sjo/N3gTRU0atyYSvZpaMO5aKRCHC8hx6dCfNsE=;
        h=From:To:Cc:Subject:Date;
        b=fpxK4KgjWViOlXnlBjEEy2YEb2hZuAUnNLl3toymLyva58BxU+zYL3SuWWrQUshOt
         JSPeVNrgtK3BoV/gLVvgzXB7Cu3sPtYprICV25y1GU/xMxZYZoA5+xXkQ9LT/k/u3E
         TiUxjDRC0lBXDSPPikIl7rBNnI0/JEX9dlie14/4=
From:   Renze Nicolai <renze@rnplus.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>, krzysztof.kozlowski@linaro.org
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: add binding for SOPINE on Pine64 Clusterboard
Date:   Sat, 19 Nov 2022 13:31:57 +0100
Message-ID: <3007229.e9J7NaK4W3@werkpc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 SOPINE Clusterboard is a mini-ITX sized board capable
of hosting up-to 7 SOPINE modules. It is largely compatible
with the SOPINE baseboard but it omits most of the in- and
output interfaces. Also The Clusterboard needs a tx delay
of 500ps for ethernet to work.

Add a binding for SOPINE on the Pine64 Clusterboard.

Reviewed-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/
devicetree/bindings/arm/sunxi.yaml
index 3ad1cd50e3fe..00bb4cdfa77f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -736,6 +736,12 @@ properties:
           - const: pine64,sopine
           - const: allwinner,sun50i-a64
 
+      - description: Pine64 SOPINE Clusterboard
+        items:
+          - const: pine64,sopine-clusterboard
+          - const: pine64,sopine
+          - const: allwinner,sun50i-a64
+
       - description: PineRiver Mini X-Plus
         items:
           - const: pineriver,mini-xplus
-- 
2.38.1



