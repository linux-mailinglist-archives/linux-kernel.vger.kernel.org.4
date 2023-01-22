Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668E677089
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAVQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:28:32 -0500
X-Greylist: delayed 372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 08:28:29 PST
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5505815CBF;
        Sun, 22 Jan 2023 08:28:29 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 96A91720292;
        Sun, 22 Jan 2023 17:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1674404494;
        bh=AiSRMdnpGQK3gHQmPsfSVOidTAJCssbAD7yVjWDjXko=;
        h=From:To:CC:Subject:Date:From;
        b=HXSHViVgAvS5PknXHoaeCYESzQpRm+g41jyFb9Wz/EAHicuPSbdUlBpPNUfOJNPd+
         RCMAElf8vPDwRmuVPaUtDLCBFcI0QmJ9UwFyIFLPcLeVs8xeux82vlvcrS/ga2oncC
         rYQo/8IRg/92QIUoCiVtSZETfRZgCqURy7IdAYrr2tiV15Jt3r/0kWAQJKrwnp4oh2
         EGdiwE9yf2tClXdLNBPfOwMJFMABSLdLrsW6x9OBf6C34ZYOxiPk8Z72UFvjZnxq+r
         oDjTiVFfedHude06amFOzMKuhJBeKB2VX85QhWCkArlfeTIrkhO+NEGdZ3q3yIf9i7
         lm6TgoqhXVnsA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Sun, 22 Jan 2023 17:21:28 +0100
Received: from localhost.localdomain (172.16.51.22) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21 via Frontend Transport; Sun, 22 Jan 2023 17:21:27 +0100
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
Subject: [PATCH V5 1/4] dt-bindings: arm: fsl: Add PDK2, PicoITX and DRC02 boards for the DHCOM i.MX6ULL SoM
Date:   Sun, 22 Jan 2023 17:20:10 +0100
Message-ID: <20230122162013.4872-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DH electronics DHCOM PDK2, PicoITX and DRC02 boards
for the DHCOM i.MX6ULL SoM.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>
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
V5: - Add Reviewed-by tag
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

