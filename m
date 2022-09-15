Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62915B99CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIOLkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIOLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:05 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C73AE6A;
        Thu, 15 Sep 2022 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663242003;
  x=1694778003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wnFQ1tb35qKbaGfqR/2XMvWyIaJYai8tjzpmbu59XnM=;
  b=OUjhnCQPb9nOjAtciJPwYITINgID3hs2P/zTFV7oqGaSzRLKkOYPDWjN
   oNwsbTOv7crwpkDfSe6MC9cAhjmxSm8SkKD8gCPFPo7zsGQ7bbq8SPTLk
   Vk14zUBSwt62PCDDVcjpQ71XKU7SMg7QAnI1f2lrgxLlxNljv/A3hvdYv
   zWaLsNFqvWXT8/kTWJ2krTHc9ry9h2aWSdIlF2WEbvgmH2iTDY7CAeY9Z
   pXK0f02qRptYlezwXGvfz/TrBqldLFKu4I51vRlo+isKbl41Bz1/srVct
   EWUNSWEJLamPV4QS61gbG4HiKoPIBkrEM/AaBZ4hzqHGdxehte4RZ8bpm
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <kernel@axis.c>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: sound: ts3a227e: add control of debounce times
Date:   Thu, 15 Sep 2022 13:39:54 +0200
Message-ID: <20220915113955.22521-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220915113955.22521-1-astrid.rost@axis.com>
References: <20220915113955.22521-1-astrid.rost@axis.com>
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
 .../devicetree/bindings/sound/ts3a227e.yaml   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ts3a227e.yaml
index 3512b1f1e32b..8c27f298733a 100644
--- a/Documentation/devicetree/bindings/sound/ts3a227e.yaml
+++ b/Documentation/devicetree/bindings/sound/ts3a227e.yaml
@@ -44,6 +44,35 @@ properties:
       - 7 # 2.8 V
     default: 2
 
+  ti,debounce-release-ms:
+    description: key release debounce time in ms (datasheet section 9.6.7).
+    enum:
+      - 0  #  0 ms (0)
+      - 20 # 20 ms (1)
+    default: 20
+
+  ti,debounce-press-ms:
+    description: key press debounce time in ms (datasheet section 9.6.7).
+    enum:
+      - 2   #   2 ms (0)
+      - 40  #  40 ms (1)
+      - 80  #  80 ms (2)
+      - 120 # 120 ms (3)
+    default: 80
+
+  ti,debounce-insertion-ms:
+    description: headset insertion debounce time in ms (datasheet section 9.6.5).
+    enum:
+      - 2    #   2 ms (0)
+      - 30   #  30 ms (1)
+      - 60   #  60 ms (2)
+      - 90   #  90 ms (3)
+      - 120  # 120 ms (4)
+      - 150  # 150 ms (5)
+      - 1000 # 1 s    (6)
+      - 2000 # 2 s    (7)
+    default: 90
+
 required:
   - compatible
   - reg
-- 
2.20.1

