Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB66715B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjARH6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjARHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:32 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A293339CCF;
        Tue, 17 Jan 2023 23:28:34 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MUYKb-1p8WJh3qF9-00RJPW; Wed, 18 Jan 2023 08:27:51 +0100
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
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v4 09/17] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Wed, 18 Jan 2023 08:26:47 +0100
Message-Id: <20230118072656.18845-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v1kRmt3/byTvMIBAcIlfKPpnVIVjtGoR2NmWPcsF23wumK5snfP
 mUhnTT8U+lZBCkXYjQuhv89UaEO6fp3ZM+4v3Wg5as3M24aHo5df/SyQEceGS4V9Eo2E7Li
 vIVIRCkVQZJHRYSFLHZufHDeFwiEN1eHS+v4DUghcdqjLOtZsRB3xBzfvRuyTYOoGtjbVgy
 VwtkkmpCCk58MdTIsNbkw==
UI-OutboundReport: notjunk:1;M01:P0:Lzo+2VnfgVk=;eDT5/gj21rtYYWFilmFy2ZfgETn
 +FpmlwTTf44E+i1qRtHbhKPhDAnTFxECBDewnwMxfKd5DLe4S/IXHhNTsbJfaRh06XTqWxA3H
 AM/NDg8+jhegtf1sfgKgT6NWqZoHGgYd6bg7ruDEfrHZo/3eFtxUZ6JVeaApUiPBbpViXKu9H
 NyeQZkFYsz3kT+dP7UqCntiSu3/Rj6w0/2o1CqGsh5iJPXlhQC4sfCEtF986Si+ePiAq/qTms
 Jv6Zj3tsi6N+1XWaTm++x/nHbL25M0R/GwU01yxgya3A41827gkLjH6z6Wx1GWCRWImg3wH1H
 RNJ9kQFWu7INotryD8TPmqDvIGxPF02qVixGVW9ljMHqA9ChgSgk/UVz2BYq44NmFCJiXAGvK
 5IblDr4YW22VPpJc/WFS/BLAkG3TXRvC1FohcMaQZVQkZfqACvRZjymJO+sMNRHu+pgSPbm6t
 +Jkga+FX7ACe5jZOOP0H6fscIKBbDvcSWVfmNg1OMi9V68y0ZomeFGNS/pveFFfBZuHlqcB9F
 NMw88jBjE8uBmBqVIUyjR/VkhUqBJw8cDye3RDNFFoQJ35VpBESMIoSFIM3BBNUEBRTx7WHp5
 gT668igrp7SiVX/99dzt0hmmHPA6RtAh9PkHR85E4Id3IGavkxD6mVr760I7OMb95W3oVBHxR
 iEOTgsHko8QfrqiWjhXoTHbISB6by4GRWpOeBuplNw==
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
2.35.1

