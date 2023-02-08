Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168FD68E8A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjBHG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjBHG67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:58:59 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F445BFF;
        Tue,  7 Feb 2023 22:58:06 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LtZ1G-1oRFic0jsS-010w2v; Wed, 08 Feb 2023 07:57:26 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v7 08/10] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Wed,  8 Feb 2023 07:56:39 +0100
Message-Id: <20230208065641.23544-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jerpapwjRVL4oZhkJ2B9XPpdsaWNOZLMVl2g/t+sRRy7Gsqr0Ih
 xh45fIjz+X3OQosS9ARqp96OyOubhuAkLZmecc4kQK+LyUaYgYX1jDCLYqySrSHkARjOHL5
 2h5xvUNfBzQxFsYdJGlVrBR3o2rygF0lqGxByd1lPWRQqvvFQmLxC5G8jISRT9oXh8Los4U
 MhyIDyI7e9AnmAJX0fQlw==
UI-OutboundReport: notjunk:1;M01:P0:3do7MAnsnAc=;hMV7jFmEWyKFXJQFFmxtB7QYvL+
 DlInxT49QEJMlNDEL1SBap9ZavdLVEN6+m8sMpvCG9WFiedmdSXU70eiDHwEOjppfidxTwxuL
 ZtIGFdr5V93oTNEl6xvpLvL+J/KUGEL9D5fMrtBqASkZ/3QFRcXkG9uuLGIHszCL4GoizMijB
 Y/nhul2M58ERzgt3UmSUr7Z0XC+h07csOBwNGtWT8f0XYQuO/VAblIwDQa2ltMuZAgbOD4dT9
 uRVANG2PVnvHulT/2bi44MVqkQUlDDdvSonbTuRWBT5nx/ktyVFwcXDHgYJ/ZaI4HyXhu77Gp
 VibY1iG3oJp9e3A+HrCtgQjH7vdQQAdq6dYY3lzv+SzsTo65ttCJhwt8dSwXdU9d1l5WxAL2t
 ISVELRhBOhrJJwN5own5/uycFDmiSZDvu1NnTCaCOBku7LVENyjZK5WSz6Kz0YvmP2dUMEndV
 dScBwkykKGUcs9KB0qGUSReXrhRx+JeOMJatllMk9k77c4FTC9oaiwD2RUrFxh1+a7CVodDq7
 J4tVcEnLt6cVMTeerPe5TqoiqSIqusv3X0Mieu/LNyFUS3CXc3qACxKeUtCTHo4PwZQ3+pHtG
 ED+Syumk+ChYojGLQx1wBJ8t/rRPjlc8xrQt4fhtQ6j/sQl5+5IflGws8zJBRYP7nZjWU5Smc
 1yEQ5o0OlGPme6mTq0ey3rYWLbiJ+NPh/J7ocKsv1Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

(no changes since v3)

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
2.36.1

