Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890EF696917
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjBNQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjBNQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:17:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED51F5F0;
        Tue, 14 Feb 2023 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676391423; x=1707927423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VchhvhX3Fzn+lpKQ+32W3d8wPFXXJZL6OWRPzobNePE=;
  b=w3oY8zjLcaVewfoDJh8j1G8GJnr+/yAl6FxxzIdfJwT9PPgueyDfY0k0
   lI32DDfttIUjN792+RmQBnMZFaS64b2isPgs4HBdI35tj1SmL3WziPSp4
   rh3zDIA1y1ZVldYvqDa0foqZS9gimXLp6ciDuKG8GdJ6y+cSBJBH21ops
   SRiBjaA4cSTFG+C237mUt9Tt1OWfzAb3dJzYiu6ui2Gh8FRh1hN0RuCGp
   /Q9vDLMWaMPRBkUEn7zpKgeLC30q/nil8noEPLCdvL4f8rRz2CBEvZtWm
   pVeHnkZbpLGLl8vMgn9h94B9pVWESl26+AFbhax1MNGg41pNali6Ut11f
   g==;
X-IronPort-AV: E=Sophos;i="5.97,297,1669100400"; 
   d="scan'208";a="137145391"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 09:17:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 09:17:03 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 09:16:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add microchip,startup-delay-us binding
Date:   Tue, 14 Feb 2023 18:14:34 +0200
Message-ID: <20230214161435.1088246-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add microchip,startup-delay-us binding to let PDMC users to specify
startup delay.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
index c4cf1e5ab84b..9b40268537cb 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
@@ -67,6 +67,12 @@ properties:
     maxItems: 4
     uniqueItems: true
 
+  microchip,startup-delay-us:
+    description: |
+      Specifies the delay in microseconds that needs to be applied after
+      enabling the PDMC microphones to avoid unwanted noise due to microphones
+      not being ready.
+
 required:
   - compatible
   - reg
-- 
2.34.1

