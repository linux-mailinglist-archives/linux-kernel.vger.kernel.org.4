Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA8675DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjATTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjATTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:07:04 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 11:06:57 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E66B926B2;
        Fri, 20 Jan 2023 11:06:57 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 38D8B5DDF7;
        Fri, 20 Jan 2023 19:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1674240529;
        bh=llc9AjXZ169FDyzLfJEfGDjHTkzpsEXOYw2a0aXOo6I=;
        h=From:To:CC:Subject:Date:From;
        b=bdJE7tceerD3lpCGCzjJk68aA6B8HRdXBFK8ci+jU/YqDpqxQifJMrEhzQakzIT3n
         03VpJv+ShEXfUdJMhJ1UnkRxo7aN7dmXr7a3p00BmjcmaWxnnTxQvvZ54TQuc3pYDN
         mo952aGwSzAJ9F8ntHcT/JSqfSM25xy/n3/4ET+72tmF+7Em9FxfMqUKtv7XWOHQSb
         GvfwcpemyztxRQvIxZ4g7OD5d3XNJWk9R03N/I5BrVBrJRhqRpY98SOdQFLk0Lw7b8
         MWgPMFsqSAd5CLFKTKcJcEkCUlBybslIUMVfPjHM0FK6fDSzEjxYJVbZW057J6WME+
         4YyMuFPykX8dg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Fri, 20 Jan 2023 19:48:44 +0100
Received: from localhost.localdomain (172.16.51.22) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21 via Frontend Transport; Fri, 20 Jan 2023 19:48:44 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/4] dt-bindings: arm: fsl: Add PDK2, PicoITX and DRC02 boards for the DHCOM i.MX6ULL SoM
Date:   Fri, 20 Jan 2023 19:47:28 +0100
Message-ID: <20230120184731.11215-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DH electronics DHCOM PDK2, PicoITX and DRC02 boards
for the DHCOM i.MX6ULL SoM.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Add Acked-by tag
V3: - No changes
V4: - Sort list of boards
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 3ba354578e8f..0d268f79f322 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -645,6 +645,16 @@ properties:
           - const: armadeus,imx6ull-opos6ul     # OPOS6UL (i.MX6ULL) SoM
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL DHCOM SoM based Boards
+        items:
+          - enum:
+              - dh,imx6ull-dhcom-drc02
+              - dh,imx6ull-dhcom-pdk2
+              - dh,imx6ull-dhcom-picoitx
+          - const: dh,imx6ull-dhcom-som # The DHCOR is soldered on the DHCOM
+          - const: dh,imx6ull-dhcor-som
+          - const: fsl,imx6ull
+
       - description: i.MX6ULL PHYTEC phyBOARD-Segin
         items:
           - enum:
-- 
2.11.0

