Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D36882B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjBBPfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjBBPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:23 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6E29E3D;
        Thu,  2 Feb 2023 07:34:52 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Ln8sF-1oiTrz1qBh-00hMGY;
 Thu, 02 Feb 2023 16:33:15 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v6 08/10] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Thu,  2 Feb 2023 16:32:18 +0100
Message-Id: <20230202153221.197308-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:R0yNAtwi8g/9MEmeIsL5RLa/MauW8bWIGpdYEs7zqCHCSj27Fhc
 PbM/I2G+3SqCJ5uhuFP+t1PiWdXxWArTjvs3hrPRczvaZ7fDtKX3lMT5hADszCCar83AiSw
 yF228dZOTz5xUAo+v68CdjelTtMNroluTDIIThv7eAO10Yfs9egCHw6hKz42Se+C5JdDvM3
 3wUeNj//h1piBB/pEZgZw==
UI-OutboundReport: notjunk:1;M01:P0:hyzO8hxjVm4=;aOuo3K+pjsO3u/22bc2jQqj3XPI
 lwi7jt0HHLTaECiH3Rk3MBrO/rUdbejAHJgM6eQz/1WvuWvPP+VqsPTBSVKFIY9kl3aWULKT4
 IqjMcfPdSzw1BTMPAtDrsErfmJKmzLlh2D6XyoCUuF6SQBgUIkvixfN+Uorq5coQ+ydWqVoeI
 r850k7qHSApoSMgH6Y90oW1lCT77tf4l3B6+66wlThtHmCHSXlVKoraUksTOQly7kuo6qu9ug
 Q+sEzTSUYPHXhAuKfTjRRrwqw5aKPzlMdzLQvgl90SNcFGf7kEHtroLMkKlYOdYS4XaAo6yrb
 HZ0SWymmfRWD2pMOU5ueSdtBTtLa0pXcc71B5yd0iu/Z1ZSSfLzMiCaSF49P1p5fLq1UQVrT2
 enzSPaCfnAEVD+lBzUyAcgA9ggIx4OgZruT0NvnrXy1hCUQ5Fm4SaNuUcIb+g+vLvbgQE8pvm
 Qsq1QkzwEPVeDpBVIcXMZc0NeNOPaPtXVHskKC75rJFFE55lIA/FJO1NTzSyyQsBM4bBCEC6k
 QTrlI12Z0feYquKuiVVCKovqfXUodjdTJTxELC8TQhQ9vLV0qm1uwx0wNQrntMl3BZFMJaCbf
 DBVyNyZ+EF1tTWDH0a1krSinKWkcIjSYWyegQqupONCDKk1nhgtYhzK1XYCUp1lTS0I9MuQtV
 ZWszcgk0MCLTgp2pcRuIT/d7kqvxs0X3d044k4/R4w==
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

