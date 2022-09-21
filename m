Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3285BF8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiIUITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiIUISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:18:41 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E1C7;
        Wed, 21 Sep 2022 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663748320;
  x=1695284320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGA4GqW7YQiOiFab+QJ8IuR8a0LUSCorsjEVc9ac2Vo=;
  b=EARkU5VKU8dIaElJHylMHlQiq4mEH9iXAhX2Tw9AKSa13+8LsO/PdAiM
   egunNOadD8ewEzzZ895O58g+BkHcPAo/OGXwpbJFmdvATFKd8FQlpCpxz
   s/6j4hVHi2UvVr6N44e5iI9brlpBwwv4wwUt/NomrwHTFdGkCEe0L9Bkb
   kTyyk7HizPuTrW8NquitdURV4BON6341lmjpa4T6p7vP2yFjW7FQHeT56
   48bt33sB8Y1HY7D3cS56Tq6AWluyVL94EBYUCX5vivZMH8jpW0wOM5uIl
   HwR+dE2n+w/AmX/2NDi20/jORLONsCDwLX6iOYmM7emGtltNwYRZy42eS
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: sound: ti,ts3a227e: add control of debounce
Date:   Wed, 21 Sep 2022 10:18:33 +0200
Message-ID: <20220921081834.22009-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921081834.22009-1-astrid.rost@axis.com>
References: <20220921081834.22009-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree parameters to control the insertion, release and press
debounce times.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 .../bindings/sound/ti,ts3a227e.yaml           | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
index 327d204cf957..785930658029 100644
--- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
@@ -41,6 +41,35 @@ properties:
       - 7 # 2.8 V
     default: 1
 
+  ti,debounce-release-ms:
+    description: key release debounce time in ms (datasheet section 9.6.7).
+    enum:
+      - 0
+      - 20
+    default: 20
+
+  ti,debounce-press-ms:
+    description: key press debounce time in ms (datasheet section 9.6.7).
+    enum:
+      - 2
+      - 40
+      - 80
+      - 120
+    default: 80
+
+  ti,debounce-insertion-ms:
+    description: headset insertion debounce time in ms (datasheet section 9.6.5).
+    enum:
+      - 2
+      - 30
+      - 60
+      - 90
+      - 120
+      - 150
+      - 1000
+      - 2000
+    default: 90
+
 required:
   - compatible
   - reg
-- 
2.20.1

