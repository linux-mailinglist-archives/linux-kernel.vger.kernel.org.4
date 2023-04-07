Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEC6DABD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbjDGKx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbjDGKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:52:54 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B05BDFC;
        Fri,  7 Apr 2023 03:51:32 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id D3D175EA2F;
        Fri,  7 Apr 2023 12:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680864658;
        bh=Rvz40k7BZBpBCZ9rXqlLOC2BEOHhCakVmqYcx+WOEaw=;
        h=From:To:CC:Subject:Date:From;
        b=Rnw4HV09dC6KPAY9UYIRfDHHbHvrdjPC8BOmnWmKcqjAv5JX9Dq3ftEFx8uidiIPU
         W0BUn3YqEqpLWyk11sr7aiMIgXEupyisYwmil9rhpFI8ifr2FLhdmJe+nZY8NDfwgR
         PF4uS5Yd1lhhDwRwMKkJe/+KfbN4Wk/FTh4hwqFoCoF7Qd/Xyo0pUxTBS3c20p1Iaq
         2VVBJf5E6ZYEgKyVFvDi3LGnJK/dHB+E58n+BbbgNzUEDbDJSegwtzbAOF+QVoa34/
         CArKnShtAsLgpUFbqk4pThHdP5qV85USdYPxwhVff9eEd6cREQarbFGUoBqknYsWnj
         AkRp3Nx+vjPXA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Apr 2023 12:50:49 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 7 Apr 2023 12:50:49 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        "Fabio Estevam" <festevam@denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/4] dt-bindings: Add Marantec vendor prefix
Date:   Fri, 7 Apr 2023 12:49:40 +0200
Message-ID: <20230407104943.5794-1-cniedermaier@dh-electronics.com>
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

Add vendor prefix for Marantec electronics GmbH.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Add this patch to the series
V3: - Add Acked-by tag
V4: - No changes
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 055704dce3d1..f58e5ef2bedd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -789,6 +789,8 @@ patternProperties:
     description: Mantix Display Technology Co.,Ltd.
   "^mapleboard,.*":
     description: Mapleboard.org
+  "^marantec,.*":
+    description: Marantec electronics GmbH
   "^marvell,.*":
     description: Marvell Technology Group Ltd.
   "^maxbotix,.*":
-- 
2.11.0

