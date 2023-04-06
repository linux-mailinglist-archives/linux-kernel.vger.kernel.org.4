Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B06D9CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjDFQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDFQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:02:29 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A55693E5;
        Thu,  6 Apr 2023 09:02:27 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 5F27F720405;
        Thu,  6 Apr 2023 18:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680796911;
        bh=98KSqM4R0a7uMv27JG/LdXX/N1wsmIAvMZ7Zjt+UdzU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fsYi/f80lSBewmOsuvZJZNpNqvgC92S2SAEZuFvNKnf7Ux5W37+9DTuD7yK648P8l
         +hgUyW8bhoGAcvUwB+wxnlKIw0cpRBKhk8zqnN0naJIafX+X+aR6HXDUOcpecW0Da2
         S/sJjC1hViX9tyXRk7abaLnLzJUy4xab3VFPy4ZlRhBfZ9353iwobBu9+OZPSzbsll
         XqgLEDJadvPrsNr/kVKE8w3wLHGTRhXsttiegKjMAaitY+Aa4Onpwv9Lb4PeFeRKBN
         a9/Rs17RRqAqV9wmdquVG98W4wwsMZ9pw4H5TXzO98oWU29bfXZnm6w3r0slRLky8y
         HSlhClwzjQxcg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Apr 2023 17:46:39 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 6 Apr 2023 17:46:38 +0200
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
Subject: [PATCH 2/3] dt-bindings: arm: fsl: Add Marantec maveo box as a DHCOR i.MX6ULL SoM based board
Date:   Thu, 6 Apr 2023 17:45:28 +0200
Message-ID: <20230406154529.6349-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
References: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
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
V2: - Correct the vendor prefix
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b175f2b1bd30..fc1bf43ab54d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -717,6 +717,12 @@ properties:
           - const: dh,imx6ull-dhcor-som
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL DHCOR SoM based Boards
+        items:
+          - const: marantec,imx6ull-dhcor-maveo-box
+          - const: dh,imx6ull-dhcor-som
+          - const: fsl,imx6ull
+
       - description: i.MX6ULL PHYTEC phyBOARD-Segin
         items:
           - enum:
-- 
2.11.0

