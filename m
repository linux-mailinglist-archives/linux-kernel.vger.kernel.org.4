Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847EE63D36B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiK3Kaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiK3KaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:30:21 -0500
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 02:30:18 PST
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 547BB3FBAF;
        Wed, 30 Nov 2022 02:30:18 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 8739F5EC41;
        Wed, 30 Nov 2022 11:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669803611;
        bh=Bjb3a95JxH8fwSaNK37AgYquFmTd2pxLk+nae0XMhx4=;
        h=From:To:CC:Subject:Date:From;
        b=IjuNkgOGqhr2Oy8IWhRSWYsh1ndVcZsY+USFVjQhx5H4n0VVw/AOs9MTwjN6mvHnO
         CqLqN8VOZlafm3mV8b4Q78AABGYvdD6nfN+2MVjHfpyVnH9KHGgAkxCzWoP0kvsNVe
         14WNLtmCBQP6TnxRpfPEBJdigNOPmTwNiPHed+xei/CD50dbmAaYJ04kt/uL0A0mhd
         aI6zXG6sxauNK9a5Z0SLiS45YSjVuqBy5nn3NSg/xvAoGStoaDlBO8hKz0Azz00yl+
         MvCii2P5r0EZKs9Fmw1RoMZ9ur74xKNC4f3d75rOuuWvRshUEmA3whhTARCOMQ6+UO
         u0ki+CyWasG6Q==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 11:20:02 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Wed, 30 Nov 2022 11:20:01 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V2] dt-bindings: mmc: Remove comment on wakeup-source property
Date:   Wed, 30 Nov 2022 11:18:52 +0100
Message-ID: <20221130101852.5408-1-cniedermaier@dh-electronics.com>
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

The current comment on wakeup-source is a little confusing because
the word deprecated can be interpreted at first glance to mean that
wakeup-source is deprecated. Also mentioning the obsolete property
confuses more than it helps. Therefore, the comment should be removed
completely because the enable-sdio-wakeup property is not used in
any current DTs.

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
V2: - Instead of changing the comment, remove it
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 802e3ca8be4d..e82c00368088 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -293,7 +293,6 @@ properties:
     description:
       SDIO only. Preserves card power during a suspend/resume cycle.
 
-  # Deprecated: enable-sdio-wakeup
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.11.0

