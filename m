Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBD633B97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiKVLla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:41:07 -0500
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 03:37:44 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F78625C;
        Tue, 22 Nov 2022 03:37:42 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 531D15DD10;
        Tue, 22 Nov 2022 12:27:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669116464;
        bh=8/lYw5t8KVGdCGz3sBccwQdnUa9KfbHtq+gHAmljXRw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=syHbcX26vg5ddaQCyAlo0kJwWPcA+kHdJB3QnUUTevDz4R0D9z2tcDStSN6+grwS7
         TUNH6xInqy20ys2ssn+4jhnnSDO7BFO5Pn2DZfJ3ruYxMK4CEPeup21KYiSDRznDx0
         fR8o8QU7MFRUNT2V1SdWTgKKhyaQ9Ltd+4d9VCsf21NT7Ci62YHldEylniu3fH7ozw
         n37nc+F/tuu4D/h9MosdlKhoM93iW2kfD4j3U4tbg0neIE8NLiLiKpGSYUrNg1NyuJ
         zLgs4E5FGO1VV0iN/Dc/lhTCIq+zs4QxnQGIpjQkQpatmK2PqGdT1/ZFWAt7deZzKq
         DVhHtTo0u96nQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 22 Nov 2022 12:12:34 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Tue, 22 Nov 2022 12:12:34 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Date:   Tue, 22 Nov 2022 12:11:23 +0100
Message-ID: <20221122111124.6828-2-cniedermaier@dh-electronics.com>
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

Replace the watchdog file name with the name currently in use.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index bab0d0e66cb3..e96629eb9f48 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -85,7 +85,7 @@ Sub-nodes:
 
 - onkey : See ../input/da9062-onkey.txt
 
-- watchdog: See ../watchdog/da9062-watchdog.txt
+- watchdog: See ../watchdog/da9062-wdt.txt
 
 - thermal : See ../thermal/da9062-thermal.txt
 
-- 
2.11.0

