Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506B6659C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbjAKLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbjAKLGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:06:46 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1425F6452;
        Wed, 11 Jan 2023 03:06:37 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MV5f0-1pMp0U2nmI-00S6Jd;
 Wed, 11 Jan 2023 12:06:21 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 4/6] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Wed, 11 Jan 2023 12:05:55 +0100
Message-Id: <20230111110558.349460-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111110558.349460-1-marcel@ziswiler.com>
References: <20230111110558.349460-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gpsF1BunbBa6MNBetJhVjYZ9+rJlxpb1sSKZGicz7eufm/cwo8J
 rH2zoIjf5OMFF90H1rNE1R9yjxRQ9iQxtxCxzyK4OrD7xgKlOHkdh14DyHk86XlXfa9WT4p
 9WL47aULKFhOkbm4g+21I7lNx7ZeIESwI/qAWkW9pYi4PxWObLEaAFKESzMgkRcA6KPCz4f
 GSFxmT+oCwq9T3f9b+0rw==
UI-OutboundReport: notjunk:1;M01:P0:LMKQqT6SjQg=;wfSW9aQlD3bHYJdNk9WkWLmaOHX
 9cvtNQ3dLMkMF4ddz9lB5k8MpcOlFdfVNQ75OI5Xpm0aIeID6KLmjqXX/f/ocypW3vRDAknNQ
 RIVV23ee3LWZh/dj9OewUbQjkP6Tu1oNcnKRWd5EUQ+lswmyxIB4xyvGO2IGZKYJte4iRU3Hv
 gNA6UxDbSdjZoG6xguANgSNU5EaiPPxLMWbE5kc72qBPRe9p/1bY/cAMzGfSypvlRadtCbjbQ
 FRZPdjmUvrnSeXA3A6da2VxWn50KwxHbMQSWE9s5JaqLlf/dt9q8BaCmmhgzbtA4N4CXNoNjq
 EeofkTUoRfBFQja/9ivPS87VoRImtUltiwDkwoI6T45ajQvNowmSS6RLNrKCqrmsLrMFtzL/F
 D4FQMfk22lrWnKHr4suW2c2BZ4uTrjOQjGbKQtI4Hb6lFFJPpFcvlkFcvQQ9FA2HYF6A0sihk
 lxbemS2d2u+i8RxhzgJMQxzg+1LisQFIn7JUsqXzUNZSNwK/mUgJgbOurR7dytvbn0FfcqUM3
 jKS8JFR9mQLhcl51Ogmt6uSe4nlLIap6JIC9crGMvr18gISVLC5HYRUKeK8WLVagk/A5V4fyc
 P+NbbMxzlSyIGOjate9vD+IaFiATygqFa7cnrsxaL1I/Jwd2RkLU5G2zcjBKGrfdri4Ithz7F
 oXW+PG06q+ZS76nxlO65H1fSj9lMZ4zTETb99yvsaQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,apalis-imx8 for the Apalis iMX8 aka QuadMax modules and the
carrier boards (Apalis Evaluation board as well as Ixora V1.1 and V1.2)
they may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v3:
- Properly accommodate for -v1.1 modules curtsey Francesco.

Changes in v2:
- Fixed missing space in the comment V1.1Module curtsey Max.
- Added Rob's ack.

 .../devicetree/bindings/arm/fsl.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05b5276a0e14..eaebef5a71c0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1035,6 +1035,25 @@ properties:
         items:
           - enum:
               - fsl,imx8qm-mek           # i.MX8QM MEK Board
+              - toradex,apalis-imx8      # Apalis iMX8 Modules
+              - toradex,apalis-imx8-v1.1 # Apalis iMX8 V1.1 Modules
+          - const: fsl,imx8qm
+
+      - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
+        items:
+          - enum:
+              - toradex,apalis-imx8-eval            # Apalis iMX8 Module on Apalis Evaluation Board
+              - toradex,apalis-imx8-ixora-v1.1      # Apalis iMX8 Module on Ixora V1.1 Carrier Board
+          - const: toradex,apalis-imx8
+          - const: fsl,imx8qm
+
+      - description: i.MX8QM Boards with Toradex Apalis iMX8 V1.1 Modules
+        items:
+          - enum:
+              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1 Module on Apalis Eval. Board
+              - toradex,apalis-imx8-v1.1-ixora-v1.1 # Apalis iMX8 V1.1 Module on Ixora V1.1 C. Board
+              - toradex,apalis-imx8-v1.1-ixora-v1.2 # Apalis iMX8 V1.1 Module on Ixora V1.2 C. Board
+          - const: toradex,apalis-imx8-v1.1
           - const: fsl,imx8qm
 
       - description: i.MX8QXP based Boards
-- 
2.35.1

