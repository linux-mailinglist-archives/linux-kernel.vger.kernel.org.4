Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D343E6B9DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCNSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCNSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:06:41 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060BAF69A;
        Tue, 14 Mar 2023 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678817198;
        bh=W06yoyKD/hYiM8C/5//liENYSRAYF5TmVXu7klRmnm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQiAktvxtWYK2Hp5zWNAk2jWJVKQcUx/vX8SLzBzUcSPnOa420N+8lg1O1/yi/zkb
         lskkLyEcbVN/rqcDIMRYDHJ5V67GucXcHAHQLtVs+DnUm5r5qwutPVy5Dtm+Ie2Jr+
         qh1SeKk6YDVmP4/eKALzyMsK14ZdOVG51eDA00fs=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.30.161])
        by uho.ysoft.cz (Postfix) with ESMTP id 28F3CA05BD;
        Tue, 14 Mar 2023 19:06:38 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/5] =?UTF-8?q?dt-bindings:=20arm:=20fsl:=20Add=20Y=20S?= =?UTF-8?q?oft=20IOTA=C2=A0Phoenix,=20Lynx,=20Pegasus=20and=20Pegasus+?=
Date:   Tue, 14 Mar 2023 19:06:07 +0100
Message-Id: <20230314180608.44482-5-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314180608.44482-1-michal.vokac@ysoft.com>
References: <20230314180608.44482-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These i.MX6 boards are based on a facelifted PCB from the previous designs.
Routing for some unused parts was completely removed (uSD card, PCIe, audio
codec) and some new parts were added (supercap backed RTC, secure element,
PWM audio, GPIO button).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
- collected Acked-by tag

 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..bb25812baf2b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -300,6 +300,7 @@ properties:
               - variscite,dt6customboard
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
               - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
+              - ysoft,imx6q-yapp4-pegasus # i.MX6 Quad Y Soft IOTA Pegasus board
               - zealz,imx6q-gk802         # Zealz GK802
               - zii,imx6q-zii-rdu2        # ZII RDU2 Board
           - const: fsl,imx6q
@@ -410,6 +411,7 @@ properties:
               - prt,prtwd3                # Protonic WD3 board
               - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
               - ysoft,imx6qp-yapp4-crux-plus  # i.MX6 Quad Plus Y Soft IOTA Crux+ board
+              - ysoft,imx6qp-yapp4-pegasus-plus # i.MX6 Quad Plus Y Soft IOTA Pegasus+ board
               - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
           - const: fsl,imx6qp
 
@@ -476,7 +478,9 @@ properties:
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
+              - ysoft,imx6dl-yapp4-lynx   # i.MX6 DualLite Y Soft IOTA Lynx board
               - ysoft,imx6dl-yapp4-orion  # i.MX6 DualLite Y Soft IOTA Orion board
+              - ysoft,imx6dl-yapp4-phoenix  # i.MX6 DualLite Y Soft IOTA Phoenix board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
-- 
2.25.1

