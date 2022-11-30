Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB22263D2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiK3KQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiK3KQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:16:13 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 146582650;
        Wed, 30 Nov 2022 02:16:09 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 000035EC41;
        Wed, 30 Nov 2022 11:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669803346;
        bh=8/lYw5t8KVGdCGz3sBccwQdnUa9KfbHtq+gHAmljXRw=;
        h=From:To:CC:Subject:Date:From;
        b=G6WuvGsfW8GzEmDlZSkXQv+NKZpm1+LyOxKLrPbTnFBBx8iIoatjNpg0zb3dbgqSv
         aeAvLAYfeADBAo7Irj/se2d44AvWNUd3a74weHTTcQs+X4fo6OccEhG6fqOsCkicx1
         wQJ96r7kvKpblRv7rEyHKog7dAF3PdVnoFj7SYm7tY56I7+Lon4Eb00FK1d2OujGOx
         ukVlbhzjcQK3aOWuG6Fta+pQDYwEaki6qkAk76ao26dETrXJe3085GrgmenZ1MOsFE
         Cg4Qxkog6UYufRqXp3meHLibtM1jy/buAOrFPAoOwZB1AvePVqWBLisXJnMCSGcUys
         IW/N3XwekDANg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 11:15:36 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Wed, 30 Nov 2022 11:15:36 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Date:   Wed, 30 Nov 2022 11:14:26 +0100
Message-ID: <20221130101426.5318-1-cniedermaier@dh-electronics.com>
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

