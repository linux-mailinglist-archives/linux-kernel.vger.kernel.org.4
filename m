Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17546B07D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCHNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCHNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:01:16 -0500
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FEC5618
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:16 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgN1RCfzMrV3y;
        Wed,  8 Mar 2023 13:53:20 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgM3xh0zMsl1F;
        Wed,  8 Mar 2023 13:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678280000;
        bh=HEmQDKDhNqtEuwFVObT7pXJ0pYVsgepFXgdiW53G8sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjLIvm1rlMjDln9zH9rxWBgE1wjLi728LPP2G8hpA0z1FTd5p7V5F/GAnfO4u0i0u
         BC9WLTesJtJbfaGKcwi5wcHUPtTN9rSInqVl/UZFuODKV3sH9J7LHpwDmRcjKp/9ou
         eNKA85pXLqrXzLXpc2+oqfTfcsdngPoWuVELraRM=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
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
Subject: [PATCH v1 22/25] dt-bindings: arm: fsl: Add colibri-imx8x carrier boards
Date:   Wed,  8 Mar 2023 13:52:56 +0100
Message-Id: <20230308125300.58244-23-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..6cb78c4ac614 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1135,10 +1135,13 @@ properties:
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

