Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306346E3638
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDPIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjDPIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05A10C4;
        Sun, 16 Apr 2023 01:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA13961920;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43036C433A4;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634829;
        bh=EQQXcjijUBA91sk7bWhgGNYpJ3hJiVVDLZWTBPGYot4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=nZy1ZNZOLXoy/ztAxG+WOCbeaqpvQMC7XJSaZLcqcbSSPGdRNixvknQDmYqsnZOJQ
         28VifdVl533Bqn9eD6NOIyLTwD9snu8CW9obuRl1Hwcllx4L17s2SP5xnn2ONmujRQ
         JhZCr/jC5OkC+5baC2IbXwMTltC/pnPqBydnCN7OWlsHuV9JHp7HupJiUGN7vWHzE5
         mSBpN1AIcwOZb5OXS/qTDKJszspIpoiIIM9geOr3E2FSOWB8NriDGqzydgl/7lu10d
         dkkqaJWWXYFjH8p4br8kjBYEfiVqlWWc/hAG7HU7IVpqqB+Lf+MjISGovEBgQHeVKV
         R5+yEfvHh4SRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 32351C77B78;
        Sun, 16 Apr 2023 08:47:09 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Sun, 16 Apr 2023 16:46:02 +0800
Subject: [PATCH RFC v3 4/4] dt-binding: mmc: histb-dw-mshc: Add Hi3798MV200
 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230415-mmc-hi3798mv200-v3-4-00e2368c0709@outlook.com>
References: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
In-Reply-To: <20230415-mmc-hi3798mv200-v3-0-00e2368c0709@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681634825; l=1381;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=DChNXTsR5GdTAljXgm4pZiZ+L6iJZkFwTbHaR8G7CCs=;
 b=cuUE0RIRK/e2Gjbkq1dM5lB6Bv4YLFUYjY64ZF9NFtIvDFaT730d5GuJMXA8yTcQ51bpXfdCd
 wyE36bSoLPpA6Bxg9v/nKCcBd5zTMPr9TYZy8VXE3kA0GqY8zcwQv3k
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Add Hi3798MV200 compatible string and an extra clock for it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
index 4711ad293b9e8..bcc8ea393981f 100644
--- a/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - hisilicon,hi3798cv200-dw-mshc
+      - hisilicon,hi3798mv200-dw-mshc
 
   reg:
     maxItems: 1
@@ -28,13 +29,16 @@ properties:
 
   clocks:
     minItems: 4
+    maxItems: 5
 
   clock-names:
+    minItems: 4
     items:
       - const: ciu
       - const: biu
       - const: ciu-sample
       - const: ciu-drive
+      - const: sap-dll-mode
 
 unevaluatedProperties: false
 
@@ -47,6 +51,18 @@ required:
 
 allOf:
   - $ref: synopsys-dw-mshc-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-dw-mshc
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
+        clock-names:
+          minItems: 5
 
 examples:
   - |

-- 
2.39.2

