Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F74633BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiKVLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiKVLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:53:03 -0500
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 03:52:57 PST
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CDC9167C0;
        Tue, 22 Nov 2022 03:52:53 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 582B67204BB;
        Tue, 22 Nov 2022 12:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669117365;
        bh=2ZV0bTDb7qgkQDDGXEMdO4IEDitBFvE2cMMeUtDgqK8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=TnjAuy6HNThxX8BxOJ6PJ1rLq6P8Bd+IagVBhxojTdee3uzR3yFS4KhAJ0+ruQAa4
         JzUVWuC39Hw0too9T3fj4oNMzH16h5QBSYUWIQ1GrwazrOfezI/rTDnZVITm4p7IUx
         TSjKEWfcZRpXnyMgf0P0bLtwxsjHBk5gAF27w77IQDJkgttT4guOXnIeiqKjnc68BD
         uOBrhdZzUFk2Z0cwvcmVFHh5dZW+nysU/BUu9CxXqWBxGFtDbQQFP0ibn6TVeYCUET
         PdlEp16wDstM5RfDt8dh58ZaHly3av8uTB6MN4Ot9nuLVCLYg69s6WUf8Z2qQkqIjk
         c6fRRTdUPKhEg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 22 Nov 2022 12:12:35 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Tue, 22 Nov 2022 12:12:35 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less confusing
Date:   Tue, 22 Nov 2022 12:11:24 +0100
Message-ID: <20221122111124.6828-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
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

The current comment on wakeup-source is a bit confusing, because it isn't
clear at first sight which property is actually deprecated.
Change the comment to one that is less confusing.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 802e3ca8be4d..a921442c6c1d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -293,7 +293,7 @@ properties:
     description:
       SDIO only. Preserves card power during a suspend/resume cycle.
 
-  # Deprecated: enable-sdio-wakeup
+  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.11.0

