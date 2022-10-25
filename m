Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045BF60C5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiJYHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiJYHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:42:47 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897A14704F;
        Tue, 25 Oct 2022 00:42:46 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 9BB7460480;
        Tue, 25 Oct 2022 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666683764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xStNbI+qmIaGoqmahuZTp38b/5MuCsHvo39qK7NqrGI=;
        b=lomFOLxpiIWu8V8qmQhQnF6Y/moZ2CQBEQdTOpHqktPJE59xh52PYsY5OTw1w0Tn9Fy/+F
        49YKxFWUzuJuhLgPyAiA5MTDv8YmCxkvLId4zdVNnP0LJhlCeiDbol50A6lDXUI9R/oHC4
        jCzJ+fzqkruukNKihN4A1yZEu9FOZuo=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 93B1F360678;
        Tue, 25 Oct 2022 07:42:43 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v4 2/6] dt-bindings: mmc: Add support for Mediatek MT7986
Date:   Tue, 25 Oct 2022 09:42:34 +0200
Message-Id: <20221025074238.18136-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025074238.18136-1-linux@fw-web.de>
References: <20221025074238.18136-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 42c42f34-b7e4-47a3-8309-8ce7891be767
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
Platform.
Add SoC specific section for defining clock configuration.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- drop assigned-clocks/assigned-clock-parents
- fix clock description
v4:
- update binding for mt7986 (new mtk version)
- squashed part 1 (compatible) and 3 (SoC specific clock config)
  and so dropped Ack from Rob for 1rst Part
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 0cedeb12892d..a7fb54416717 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -20,6 +20,7 @@ properties:
           - mediatek,mt6795-mmc
           - mediatek,mt7620-mmc
           - mediatek,mt7622-mmc
+          - mediatek,mt7986-mmc
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
@@ -237,6 +238,31 @@ allOf:
         reg:
           minItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7986-mmc
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: bus clock used for internal register access (required for MSDC0/3).
+            - description: msdc subsys clock gate
+        clock-names:
+          minItems: 3
+          items:
+            - const: source
+            - const: hclk
+            - const: "source_cg"
+            - const: "bus_clk"
+            - const: "sys_cg"
+
   - if:
       properties:
         compatible:
-- 
2.34.1

