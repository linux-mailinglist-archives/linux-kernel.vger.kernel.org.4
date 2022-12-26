Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49424656069
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiLZGaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiLZG3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:29:41 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5685F8E;
        Sun, 25 Dec 2022 22:29:16 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.224.88]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LnyM2-1oco4W2UPY-00g0XW;
 Mon, 26 Dec 2022 07:28:57 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Mon, 26 Dec 2022 07:28:22 +0100
Message-Id: <20221226062824.53113-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221226062824.53113-1-marcel@ziswiler.com>
References: <20221226062824.53113-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YfcOHUI4zLCZ01BIL0cERKXjNgxgTBxsAdXKvB01ZAyXo7JoUcP
 y7pOnSnWC22LqhA6VYNi2Das17uFYp4/xmTchA+KO48EsC1BzVrHNItQyYDuPDmU8OaVc1e
 yGI/NpPXYxUKsoYO+Oxq9OV/BZKlv3xtDM3gMzTcBSNyf12LChyoWkV6vfANe4dk4uWltgA
 6wNd52g8rMY3+rQ3n6Ngw==
UI-OutboundReport: notjunk:1;M01:P0:/XG4OYaBPrA=;GcAxdGVu4blLOR5OBnSYMaydRxL
 rvXAbHLzzs6sqJ4ya9Cskio5DdjAGPs/6Ns4PDc/Eeqk8ONbfxZyRH8cNRJOgFSY8Dqf5Lksj
 mLWmSl2Yx1D/BItLdlpBByNcoGCndggnB0HhHtSY5UUuJruCUIy052GDhygvl+DIeqXY16MLS
 2DFGAzg7R8BjhmoqPfd+xmgPtLAON74vKKmXVUpuSg5cc2Ko8nZlC8qQRQEHaQ/PZIi1nJdEI
 qBnfrVrq3UiX1sLzVOtI6QCe02A6AcVeK26FDXHyseDS5ApXxsygXGFGDRh7EBemRcWalB2AQ
 neUwWT+ZxR/O1G8hK0MDt1RW8gfia7xOtHWS2iZkwoIIqiiYEcR1GkRvea1K4yt5nIn6sJux8
 4E3izshfRhNuVbO8PWbrX6FoEn4lgu6spyAPLEkkIqI8GyGodv1et4/5uw2N4VA7z/RNcvKmz
 Wd0BWMEKar8p9ekK4HozTcLtCIrvGOKZd4TaTYNAIkKozJLKzGdc1El7pREqvXCekaReZhkOg
 ViNyA+H/6GKrcH16d8zQH6QjVuq/nM2L5/gg70SoSq+pCZr9b3yz1bofdNbGqZcZeeRtqnMi6
 i1kMTIN+EgnxA8wwVYCVE386yM3PIO6WRYVB0wJeMQTlhLbGUggAkoF4GEPBeAKWwB0U210ks
 2JOrXh1TwSL2b57/Uvj3OP3CHD6wMqPF/018hgZNtQ==
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
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05b5276a0e14..48cccb5e362f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1035,6 +1035,18 @@ properties:
         items:
           - enum:
               - fsl,imx8qm-mek           # i.MX8QM MEK Board
+              - toradex,apalis-imx8      # Apalis iMX8 Modules
+          - const: fsl,imx8qm
+
+      - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
+        items:
+          - enum:
+              - toradex,apalis-imx8-eval            # Apalis iMX8 Module on Apalis Evaluation Board
+              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1Module on Apalis Eval. Board
+              - toradex,apalis-imx8-ixora-v1.1      # Apalis iMX8 Module on Ixora V1.1 Carrier Board
+              - toradex,apalis-imx8-v1.1-ixora-v1.1 # Apalis iMX8 V1.1 Module on Ixora V1.1 C. Board
+              - toradex,apalis-imx8-v1.1-ixora-v1.2 # Apalis iMX8 V1.1 Module on Ixora V1.2 C. Board
+          - const: toradex,apalis-imx8
           - const: fsl,imx8qm
 
       - description: i.MX8QXP based Boards
-- 
2.35.1

