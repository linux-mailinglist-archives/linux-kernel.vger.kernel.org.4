Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E10464B414
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiLMLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:23:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37401183B;
        Tue, 13 Dec 2022 03:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670930616; x=1702466616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O6Yhf97L/pahv9g9FCa7RxbB9udp6xC8MQ4GIoD13oM=;
  b=dXhJkT6MAKRBo1qXGxX6QU+QcVe2H9rAdR6GBSWpw3WXbK3VaC4CHqxN
   4qszrpVazdNrZb1BOTPYV9Ks/bMlvGhcemacaNtu2JNQuDBo6b2Qdqrvl
   4YThPAP3H2HT3jCG6HD6/Z+hHg5I9ob85xixUb9Hly6qRDPiQ9dwOOlBR
   RTZKQ045oc3nzh20+CztJgVZsMim4T11UWAhmcUWhbej2lvrbOMHzm9po
   wRC4YRtu0EAmycbBKpOftVTdx0Aleaua9Ac9wPfhJu4klaPUM3IxNqwWd
   IuYRfN+YnCtVBc98tdgCyOosZ7FLTw2c7rRenBZ238DrQtXicEOvlxpbO
   A==;
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="192862226"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2022 04:23:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 04:23:35 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 04:23:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/4] ASoC: dt-bindings: microchip: use proper naming syntax
Date:   Tue, 13 Dec 2022 13:28:48 +0200
Message-ID: <20221213112851.89212-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221213112851.89212-1-claudiu.beznea@microchip.com>
References: <20221213112851.89212-1-claudiu.beznea@microchip.com>
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

Use the following syntax for Microchip ASoC YAML files:
vendor,device.yaml

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2smcc.yaml}  | 2 +-
 .../sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml}  | 2 +-
 .../sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} | 2 +-
 .../sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2smcc.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (95%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (95%)

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
index 0481315cb5f2..68423f43ac3a 100644
--- a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/mchp,i2s-mcc.yaml#
+$id: http://devicetree.org/schemas/sound/microchip,sama7g5-i2smcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip I2S Multi-Channel Controller
diff --git a/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
index 04414eb4ada9..7cc80dac980c 100644
--- a/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/microchip,pdmc.yaml#
+$id: http://devicetree.org/schemas/sound/microchip,sama7g5-pdmc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip Pulse Density Microphone Controller
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
index 970311143253..5121ea1600ae 100644
--- a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/mchp,spdifrx.yaml#
+$id: http://devicetree.org/schemas/sound/microchip,sama7g5-spdifrx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip S/PDIF Rx Controller Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
index d5c022e49526..d13e76269250 100644
--- a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/mchp,spdiftx.yaml#
+$id: http://devicetree.org/schemas/sound/microchip,sama7g5-spdiftx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip S/PDIF Tx Controller Device Tree Bindings
-- 
2.34.1

