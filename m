Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C30677F77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjAWPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjAWPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:19:29 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92A1EFFB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:18:51 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P0tyH3WC8zMqgKx;
        Mon, 23 Jan 2023 16:17:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4P0tyG56g0zMqXNq;
        Mon, 23 Jan 2023 16:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674487063;
        bh=uNjw/B6ayZ2190S1amZp3GSssjFXfR4skx5TJ2fm0R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdZn3MwZ/z8Tc+DCd3ktvjOgVq8iHVSyM3cXtlj3NdzUoER0fwjmc+yeY74GjTK6g
         FXGhO7oVxlRTzHqqsnM1fVjO6covQSP733JUryettWQNk/zvvythHEyCbuvcx7SoWJ
         xIPh2kLBrMLA5NFxqf5RMzJFgw3uIqG8J4lwBaa0=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
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
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: Add verdin yavia carrier-board
Date:   Mon, 23 Jan 2023 16:17:32 +0100
Message-Id: <20230123151734.44184-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123151734.44184-1-dev@pschenker.ch>
References: <20230123151734.44184-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the Verdin Yavia Carrier-Board that exists for both Verdin iMX8M
Plus and Verdin iMX8M Mini.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
- Added Krzysztof's Acked-by

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

