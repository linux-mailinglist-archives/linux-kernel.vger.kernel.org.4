Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0F71999A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjFAKVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFAKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:19:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4144E199F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:16:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKZ-0004WF-5i; Thu, 01 Jun 2023 12:14:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKY-004KWL-5Z; Thu, 01 Jun 2023 12:14:54 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKW-001V49-LN; Thu, 01 Jun 2023 12:14:52 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v1 4/7] dt-bindings: crypto: fsl-dcp: Add i.MX6SL, i.MX6SLL, and i.MX6ULL support
Date:   Thu,  1 Jun 2023 12:14:48 +0200
Message-Id: <20230601101451.357662-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601101451.357662-1-o.rempel@pengutronix.de>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for i.MX6SL, i.MX6SLL, and i.MX6ULL to the 'fsl-dcp' binding
to address the following dtbs_check warning:
  imx6ull-jozacp.dtb: crypto@2280000: compatible:0: 'fsl,imx6ull-dcp' is
    not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
  From schema: Documentation/devicetree/bindings/crypto/fsl-dcp.yaml

  imx6ull-jozacp.dtb: crypto@2280000: compatible: ['fsl,imx6ull-dcp',
    'fsl,imx28-dcp'] is too long
  From schema: Documentation/devicetree/bindings/crypto/fsl-dcp.yaml

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/crypto/fsl-dcp.yaml   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
index 99be01539fcd..8af393b9f3ca 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
@@ -11,9 +11,22 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-dcp
-      - fsl,imx28-dcp
+    oneOf:
+      - const: fsl,imx23-dcp
+      - const: fsl,imx28-dcp
+      - const: fsl,imx6sl-dcp
+      - const: fsl,imx6sll-dcp
+      - const: fsl,imx6ull-dcp
+      - items:
+          - enum:
+              - fsl,imx6sl-dcp
+              - fsl,imx6sll-dcp
+              - fsl,imx6ull-dcp
+          - const: fsl,imx28-dcp
+      - items:
+          - enum:
+              - fsl,imx28-dcp
+          - const: fsl,imx23-dcp
 
   reg:
     maxItems: 1
-- 
2.39.2

