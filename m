Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7667525B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjATK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjATK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:26:10 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877F9084D;
        Fri, 20 Jan 2023 02:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674210369;
  x=1705746369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zq0C28u4Y8exuvoqKW0nWKnZEuIJ+MuaDC7ZdjB7/+8=;
  b=WGNkUbVVwUovQWGDGvb+5cw/1bRPkJ9r9bjCe9ruOWR10PEyfBBIfSs/
   fEMGL6zBrLErFnbbQ3JO2/+bQX8F0uIv9aH7Hs6AAWWnaGoJK+crPBNOH
   UnHcrQAEJKddO69FJCTNiTqVOrNZ+zmhrG2NFxn898sIOlg/b7SJU1JoL
   eCCNzE9Yj5LG1KHvKFqPLZfZllQjJ+zuy5DL6+ibr1aD9yDpJP/AGLpAU
   nrkQNnd4xjWfI6h+ip43KucNy7Qse35YlwMw0rD2wLlSthiV2bNykhQ3l
   6hoXr1mdZHN6gF9gaVQqCtn6k6lWrnY7hiIVss/TMmAsvYnFlE0vPzZMs
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Date:   Fri, 20 Jan 2023 11:25:54 +0100
Message-ID: <20230120102555.1523394-5-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120102555.1523394-1-astrid.rost@axis.com>
References: <20230120102555.1523394-1-astrid.rost@axis.com>
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

Add jack-type: Bitmap value of snd_jack_type to allow combining
card drivers to create a jack for it.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
index 785930658029..1d949b805f98 100644
--- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
@@ -27,6 +27,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  jack-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bitmap value of snd_jack_type to allow combining
+      card drivers to create a jack for it. Supported is
+        1 SND_JACK_HEADPHONE
+        2 SND_JACK_MICROPHONE
+    default: 3
+
   ti,micbias:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Intended MICBIAS voltage (datasheet section 9.6.7).
-- 
2.30.2

