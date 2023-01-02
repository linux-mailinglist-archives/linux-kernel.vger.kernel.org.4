Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703F665B5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjABRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjABRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:11:08 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A86EBEF;
        Mon,  2 Jan 2023 09:11:00 -0800 (PST)
Received: from toolbox.int.toradex.com ([104.59.205.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MOgc4-1p8Wz92vcE-00682G;
 Mon, 02 Jan 2023 18:10:33 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH v2 4/5] dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
Date:   Mon,  2 Jan 2023 18:10:21 +0100
Message-Id: <20230102171023.33853-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102171023.33853-1-marcel@ziswiler.com>
References: <20230102171023.33853-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SOWcSrb0Ud3I2qBNZXS4sTZwPznjx53p99pNnHRAOKDko7U/Zru
 soqr9PjLAb2pXcw3jTINY/l1ClP1NpnGZVgL/iIYTBLbX4NmVlxlpPJumI8zCtLMXj7FmTz
 KlTBQSlArCS9MLH3Njzo9R+obbinWUh9hh5PqpDKoc2wa/jmDOhiIxEDsxfYUoGNSUhAB2J
 g7GNldJWoK7By4h4MZGlg==
UI-OutboundReport: notjunk:1;M01:P0:JWAvCcA/+Pc=;4zG8FX6A91eg1Z3tgPVBjKe2KdX
 7dpcXWXMIJN8+NtCyWJjd0MWze0p92nTxwg/eDoY/BBVoq2bYsnPioNKHX/Ibz+QfnBuRrHt2
 rERvj+eukHxyya/ogoMt33iHlJlv4aJICQ21EYxESLhpw8U5Ly7I/5kHpW18w+RgNDnM9bqpm
 0ZozuprhiNAd/wZ1mznqZ6ve4UjZavlSR7XSVcvCqImbwTn+SAfqXh/Xi6nfXi5CDsF6pAaXR
 gs5w7laOR6eixiO+9bUqIiVy6JspwzD2ucJZ4DljMMjho2FUW6hKuU066MBYIto7GjnqmhURX
 ZxLAmWDrwxa6NSSnYqOlMEwhUXup2+fEXr9iy95QvbkSwS5hfjuYgf3oojf2jeNq4rLPQVMq4
 93R2tos+Ka/ymjRMoJNfESV4V5fjDYtiDMQ1GBYnkwGrWnIpLTQuHkZDx1Y0vuQTbH2RdmCXi
 wD0siZVSMwn3g33a0Znwfj1sDSwRvzpzscjdmxorTlOgbe+LXU4ZqOR3JYTNyv8Guwlg2AStl
 +Yu8YJwoXNVeNThrv7E+diX4ehLVoo5hh2tX928nKOg99PHSfgSZIBgGn7TM8JLuNybyo5Cnm
 z0xnyeY49JFZao8ANmHg6qTbmwhw5LuJyi8Q645XKy2o5QtxW/SQa4atSl0JcP3juoiQu/k9r
 JhwdxdtFTZ0IieBjn08W69ET0/6FowOfhEfayGbPKA==
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

Changes in v2:
- Fixed missing space in the comment V1.1Module curtsey Max.
- Added Rob's ack.

 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05b5276a0e14..54c030324136 100644
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
+              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1 Module on Apalis Eval. Board
+              - toradex,apalis-imx8-ixora-v1.1      # Apalis iMX8 Module on Ixora V1.1 Carrier Board
+              - toradex,apalis-imx8-v1.1-ixora-v1.1 # Apalis iMX8 V1.1 Module on Ixora V1.1 C. Board
+              - toradex,apalis-imx8-v1.1-ixora-v1.2 # Apalis iMX8 V1.1 Module on Ixora V1.2 C. Board
+          - const: toradex,apalis-imx8
           - const: fsl,imx8qm
 
       - description: i.MX8QXP based Boards
-- 
2.35.1

