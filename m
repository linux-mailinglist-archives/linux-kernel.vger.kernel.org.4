Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219F67C97B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjAZLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbjAZLJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:57 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9E6FD01;
        Thu, 26 Jan 2023 03:09:37 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MMko5-1pJaoS3cND-008Z8L;
 Thu, 26 Jan 2023 12:09:20 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v5 08/10] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Thu, 26 Jan 2023 12:08:31 +0100
Message-Id: <20230126110833.264439-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z72gvH5gjQVTTz4A+P/SpuVzSRj0DEPuUinQ/GBCGsZGjVQ+leI
 JkF7njqP5Dz7QBmD8HZdJnsYagzl1EsZFLS8ggJ8+a0vKaetSdRYWFqpHMHCWNSy8pLCa0P
 eq18iFqztjbrb8u/42IVMFRTsin6nMLcAVAi2KIRJjnGVL+TEHxSHoqe6+WyLvIFzHsX0Ls
 Gssx+te5pXdxxBAw8m+sQ==
UI-OutboundReport: notjunk:1;M01:P0:RIteeyZepIE=;qpTQQfr0GLZFudE2DgpWiuRswC0
 OkyY43hng0StIY3VB2t9Pt+Qn7CsHEKtLBbSPAYYn6OPujdE729qj13ptVreAcKB+z/ccF/PH
 U0RTESW9ItCR7nsbxY9STCDZslKDdKpePmhv4VpwqbaVCjXKT746EbDQj5dPrHqwfEGJDy8LK
 Avh1KGC4EjLBQEQvT5mPoA3hsdrIpsP7SYqu0i7g/i2V6aulSs2ace4/k+U7PxTw758Zz+FWX
 bJv34MtiJOrGPEtCKFZL6OLVUF6m3aFxDfaAPmfG/f+THgka2DsJ4Oe0H+ZTR9Oq7bJU4dL7V
 oFXXEO20iZRo/pDFg/cEdWVOPwelBSzAgQWHhx+u4GKxc3Y34l0AB7Y3+gRppjgp2hVOAzugp
 r76ssFn2eNbl8j7VBggnheWjMa2o2OH/7UN+jC1SXHaceEI3Ehvwf1SwavOvuPBPQVBX8oVpg
 Z9qQPBvngYsRYuG9mgkHCA3HkIO54yb0rjqMQi4FrH+H5x7dDxWDtwSQZNLHjkbp2BFe06Ld2
 tnfRSV+qQus6fDHPO7BfssTHg8X2Pv1F+/oLjZQi2jqrPmDiEe4JOBal+5kAa+HKIKzdZy2mz
 tAhMG5ieGoV1G1ViUwX5JZiJY+VbAcgB+eWZ5bx3fC+PYn68DhUv8Wha4X6aHzSdQsbXXSjik
 GoaUrzYqSV4waLZkoCnK0aUOGY51505QucYCKiAC8g==
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
2.36.1

