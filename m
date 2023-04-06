Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881B6DA509
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjDFVzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDFVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:55:04 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D23C9EF3;
        Thu,  6 Apr 2023 14:55:00 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 420D75DCC3;
        Thu,  6 Apr 2023 23:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680818073;
        bh=BA4DXr4j+vfbz3sRSTJOe2l521vHySmc4UI+yA4PvGw=;
        h=From:To:CC:Subject:Date:From;
        b=OGN5CO05d0rM+yz4W0kV2KZElCK9/JMDDoKk0tzeQM3ajMNvuv16l6TomP6A3evFu
         MVjca1Xs998auUKCKXVowCN3+AOL0Vx1Fik8Mms+a9iXaEGk4ixFG6jhDnxaCHzVlW
         mHH5YU+iFZ4/L9kYfeKMvwGe+mt1FLlEYO8vphTYBCB0smtg/AD1Ehp3WeYlwbU2CD
         dD8uG3rb8ngK5qDmbyV2+9JMQU9vnnWQpUnThBKEo2CeXeZIWYwVygLHcqKnGg6UvR
         +jnpftzW0sA81Dvrlhp84j/N/xFRhvKAZAW6jm89GG4ZY1a7RvcmfqKM3hXy8VVqRr
         MQdfa1rBBAOxQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Apr 2023 23:54:25 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 6 Apr 2023 23:54:24 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        "Fabio Estevam" <festevam@denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 1/4] dt-bindings: Add Marantec vendor prefix
Date:   Thu, 6 Apr 2023 23:53:12 +0200
Message-ID: <20230406215315.13280-1-cniedermaier@dh-electronics.com>
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

