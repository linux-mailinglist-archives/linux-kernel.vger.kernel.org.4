Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D823672017
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAROs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjAROse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:48:34 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C54E51A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:41:07 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NxpNF5WmyzMq5Gp;
        Wed, 18 Jan 2023 15:41:01 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NxpNF1gblzFYL;
        Wed, 18 Jan 2023 15:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674052861;
        bh=NtgFhwHMC5nWJPX4q7eUMkoyQLWlAcwk3deiwOSANDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpPJfPAx3YzYhdGsrxA2PProXmqIRhnOjKzjBpfXvVQUe7S8b8NC8b71JUWed3Ev4
         fp+7RDAQv2nMnkb8HjFOSlriieC5oZYiw2vPIY1LYk/e8NigLlZxYatM3nRsnCNdXw
         0ncMYoT+SFmWbtLoyQxouFjm/dkGSBu1mOeNfB3k=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: arm: fsl: Add verdin yavia carrier-board
Date:   Wed, 18 Jan 2023 15:40:40 +0100
Message-Id: <20230118144042.7705-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118144042.7705-1-dev@pschenker.ch>
References: <20230118144042.7705-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the Verdin Yavia Carrier-Board that exists for both Verdin iMX8M
Plus and Verdin iMX8M Mini.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 3ba354578e8f..4f6f551a5573 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -863,6 +863,7 @@ properties:
               - menlo,mx8menlo                       # Verdin iMX8M Mini Module on i.MX8MM Menlo board
               - toradex,verdin-imx8mm-nonwifi-dahlia # Verdin iMX8M Mini Module on Dahlia
               - toradex,verdin-imx8mm-nonwifi-dev    # Verdin iMX8M Mini Module on Verdin Development Board
+              - toradex,verdin-imx8mm-nonwifi-yavia  # Verdin iMX8M Mini Module on Yavia
           - const: toradex,verdin-imx8mm-nonwifi     # Verdin iMX8M Mini Module without Wi-Fi / BT
           - const: toradex,verdin-imx8mm             # Verdin iMX8M Mini Module
           - const: fsl,imx8mm
@@ -872,6 +873,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mm-wifi-dahlia # Verdin iMX8M Mini Wi-Fi / BT Module on Dahlia
               - toradex,verdin-imx8mm-wifi-dev    # Verdin iMX8M Mini Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-imx8mm-wifi-yavia  # Verdin iMX8M Mini Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-imx8mm-wifi     # Verdin iMX8M Mini Wi-Fi / BT Module
           - const: toradex,verdin-imx8mm          # Verdin iMX8M Mini Module
           - const: fsl,imx8mm
@@ -972,6 +974,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mp-nonwifi-dahlia # Verdin iMX8M Plus Module on Dahlia
               - toradex,verdin-imx8mp-nonwifi-dev    # Verdin iMX8M Plus Module on Verdin Development Board
+              - toradex,verdin-imx8mp-nonwifi-yavia  # Verdin iMX8M Plus Module on Yavia
           - const: toradex,verdin-imx8mp-nonwifi     # Verdin iMX8M Plus Module without Wi-Fi / BT
           - const: toradex,verdin-imx8mp             # Verdin iMX8M Plus Module
           - const: fsl,imx8mp
@@ -981,6 +984,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mp-wifi-dahlia # Verdin iMX8M Plus Wi-Fi / BT Module on Dahlia
               - toradex,verdin-imx8mp-wifi-dev    # Verdin iMX8M Plus Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-imx8mp-wifi-yavia  # Verdin iMX8M Plus Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-imx8mp-wifi     # Verdin iMX8M Plus Wi-Fi / BT Module
           - const: toradex,verdin-imx8mp          # Verdin iMX8M Plus Module
           - const: fsl,imx8mp
-- 
2.39.0

