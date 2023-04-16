Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FA6E3693
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjDPJUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjDPJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61661BFB;
        Sun, 16 Apr 2023 02:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431D161548;
        Sun, 16 Apr 2023 09:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FC2AC4339C;
        Sun, 16 Apr 2023 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681636794;
        bh=wsbojbo7df/LUKeCeNIX/OxYtqkIzPpLb1QyaWizIoU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=ChyVdhKQxg6PzIeRASo8TBsWF6mjkmyxJU6Cfh6FM0H9dXwqlEaUH24BqHHf1l4A0
         w0KmxPyXEn9kjmiHxU9XIlGtAALh1MfhqFFcK4MhQZSjAo7Dwke6o7BG6BXHnMSuHr
         YMi9NzMDcwP6q9OIGsTuKzIHrOzKn1GvUIqi22NYbSKIwF7rvFSMA1ld5TxIqdYA/a
         HCTXHNfZU/S9UNX8ATzXZBWnCxFAtAiRE0jwaNEXWy5Zs4WDY0uV0v8YfKfbPceTwe
         L0brjpPotpjzUR9x8dmCpXFc+Qr9fFpKp3C4Tv4sDtjDGEep681Mrr5Hw/mqYPxFG5
         x8/KkovUn77dQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6ADC77B76;
        Sun, 16 Apr 2023 09:19:54 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sun, 16 Apr 2023 17:19:35 +0800
Subject: [PATCH RFC v4 4/4] dt-binding: mmc: histb-dw-mshc: Add Hi3798MV200
 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v4-4-44096e187f53@outlook.com>
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681636790; l=1593;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=q5GM8oNU5gnf/3ltWXbVzjwL+8fph3xf831mMOi9Dsk=;
 b=sASercxLEOoqglzvstfLuHzFGTm0s2nnT7EchZrLhr0uqiVFQtjGG7XcIeJv5rRi3L1U/BsYD
 tfTt3eSo7jVCeEF2xxPbI4r0dOamp2qh3J6pn8dSgtN7kgqRkkfOy0M
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Add Hi3798MV200 compatible string and an extra clock for it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/mmc/hisilicon,histb-dw-mshc.yaml      | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
index 301b6ad39c5af..2f8335fd2c965 100644
--- a/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - hisilicon,hi3798cv200-dw-mshc
+      - hisilicon,hi3798mv200-dw-mshc
 
   reg:
     maxItems: 1
@@ -27,14 +28,16 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
+    minItems: 4
     items:
       - const: ciu
       - const: biu
       - const: ciu-sample
       - const: ciu-drive
+      - const: sap-dll-mode
 
 required:
   - compatible
@@ -45,6 +48,27 @@ required:
 
 allOf:
   - $ref: synopsys-dw-mshc-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-dw-mshc
+
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
+        clock-names:
+          minItems: 5
+
+    else:
+      properties:
+        clocks:
+          maxItems: 4
+
+        clock-names:
+          maxItems: 4
 
 unevaluatedProperties: false
 

-- 
2.39.2

