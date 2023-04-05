Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE06D8342
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjDEQMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjDEQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:12:39 -0400
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 09:12:12 PDT
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39B7819AE;
        Wed,  5 Apr 2023 09:12:12 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 7F3287204BD;
        Wed,  5 Apr 2023 18:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680710670;
        bh=OYWr1DklCzVbE6Tsje92dgpDzZftRAocYHIWHGDCC6w=;
        h=From:To:CC:Subject:Date:From;
        b=gUOx/py3TC33SPXBipTFRzc3Ga7Q4S7A24Eq2q3Bi9b9GDeMejPX51XvA/3RL1BJR
         4jSmnwWlPKoShiEbGRuNaWVAENS7FIesFxj77mH/YX280d3Nh0RVSV8O4bTXiwInKs
         x4e+5eMHFpEhBkXsnCLXn94dynt1xgbt+1jir3KvGpcQBJCdXVuRmTwx+1YiCuj2DV
         6wEOug78pl9ymPhXqXcqo5wJpai9WpQXkaSsif0f/Bl1EObw8uvmbDiLGvktCmj/6n
         +l83ji2hXYStEZZKaBLt1HhdkzI/WP8v456RpuWmtEs+5+hwIYuKKlZNxx8fd5D7Iu
         xL8bfXhwydJOw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Apr 2023 18:04:21 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Wed, 5 Apr 2023 18:04:20 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add Marantec maveo box as a DHCOR i.MX6ULL SoM based board
Date:   Wed, 5 Apr 2023 18:02:57 +0200
Message-ID: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Marantec maveo box. The system is used to get a smart conntection
to a door drive. The core of this system is a soldered i.MX6ULL DHCOR
SoM from DH electronics.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
CC: Li Yang <leoyang.li@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b175f2b1bd30..c95254c57571 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -717,6 +717,12 @@ properties:
           - const: dh,imx6ull-dhcor-som
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL DHCOR SoM based Boards
+        items:
+          - const: dh,imx6ull-dhcor-maveo-box
+          - const: dh,imx6ull-dhcor-som
+          - const: fsl,imx6ull
+
       - description: i.MX6ULL PHYTEC phyBOARD-Segin
         items:
           - enum:
-- 
2.11.0

