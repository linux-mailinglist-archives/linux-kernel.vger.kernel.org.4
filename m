Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B536B8FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCNK0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCNKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:12 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E403113FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:45 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4x1xQmzMqQGL;
        Tue, 14 Mar 2023 11:24:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4w4Z9Kz2N3k;
        Tue, 14 Mar 2023 11:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789473;
        bh=X4/Hp0n5u3CXahOF9AJ2CShTezdyjc/3NlBOWzdXARQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ta5cCO9dciY3PFgXzMaRnyUfmW1Pnv6qMCFUhOEYFTa8bQRF0oJQbn4Sjv6FIXZ8T
         GmJVX3CW+n5tcRtx07J7PIckqMH9Hk0nce5mvIJjpqAlLUJ8LgJiggyn5Ej55aaxy6
         qvPcgLqhXyO/nGIX4s0fTA/y3YxF1l+3eECFdw18=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/23] dt-bindings: arm: fsl: Add colibri-imx8x carrier boards
Date:   Tue, 14 Mar 2023 11:24:06 +0100
Message-Id: <20230314102410.424773-21-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Prepare the dt-bindings for the new colibri-imx8x carrier-boards Aster
and Iris.

The Toradex SoM standard is called Colibri, fix the typo.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
- Added Krzysztof's Acked-by, thanks!

 Documentation/devicetree/bindings/arm/fsl.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2c90455722f0..750b8b949219 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1154,10 +1154,13 @@ properties:
               - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
           - const: fsl,imx8dxl
 
-      - description: i.MX8QXP Boards with Toradex Coilbri iMX8X Modules
+      - description: i.MX8QXP Boards with Toradex Colibri iMX8X Modules
         items:
           - enum:
+              - toradex,colibri-imx8x-aster   # Colibri iMX8X Module on Aster Board
               - toradex,colibri-imx8x-eval-v3 # Colibri iMX8X Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx8x-iris    # Colibri iMX8X Module on Iris Board
+              - toradex,colibri-imx8x-iris-v2 # Colibri iMX8X Module on Iris Board V2
           - const: toradex,colibri-imx8x
           - const: fsl,imx8qxp
 
-- 
2.39.2

