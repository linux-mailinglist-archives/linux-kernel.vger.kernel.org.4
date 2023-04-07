Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F56DAC0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjDGLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjDGLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:07:18 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F14C6AF17;
        Fri,  7 Apr 2023 04:06:44 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id D7CF75DD10;
        Fri,  7 Apr 2023 13:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680865561;
        bh=BOxlLxmkaUzPvOoLi+6wHQCXqdK/sB3mdLzsQH9X6bE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Yt95KH8olmIDYEES13QZP5QpNXvFrvqw2L+YxbFOuFScsw4+CnwC08sheh4C3+cua
         GiMO04VMj1brV1U54p/dnmvZMaYQsypc6qi4kUDj/B/vt+drbbO0qB//VQYyWO/TV1
         HntsUy2kGWijJpRKaN1L/hoOyRPdQrDd9uBRsqafuVT+nm0dAgEjcLmdh13+83A7LU
         Ih4ZE001cX31MSMatB4GsT8hjcq8EC85nSitrApJP7CtlCS+nI85C9E8nzMLXqnxlS
         AWhjRg8tDlI8/DMeiXKOQBHXiGzDH7tLo6Ezb6yn7gKxpEXzniZglTNDw523FyBp4G
         jc4x4ZzSEG9rA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Apr 2023 12:50:50 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 7 Apr 2023 12:50:49 +0200
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
Subject: [PATCH V4 2/4] dt-bindings: arm: fsl: Add Marantec maveo box as a DHCOR i.MX6ULL SoM based board
Date:   Fri, 7 Apr 2023 12:49:41 +0200
Message-ID: <20230407104943.5794-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230407104943.5794-1-cniedermaier@dh-electronics.com>
References: <20230407104943.5794-1-cniedermaier@dh-electronics.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
V3: - Add Acked-by tag
V4: - No changes
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

