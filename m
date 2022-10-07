Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F345F7E64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJGUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJGUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:00:49 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825A1103DB5;
        Fri,  7 Oct 2022 13:00:48 -0700 (PDT)
Received: from localhost.localdomain (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 7D0E13F359;
        Fri,  7 Oct 2022 22:00:45 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: apple,aic: Document A7-A11 compatibles
Date:   Fri,  7 Oct 2022 22:00:21 +0200
Message-Id: <20221007200022.22844-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007200022.22844-1-konrad.dybcio@somainline.org>
References: <20221007200022.22844-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatibles for Apple A7-A11 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v3:
- Bindings: A7-A10+M1 only get SoC compat and generic fallback,
A11 gets M1 fallback and generic fallback (removed A11 compatible)
- Drop Rob's A-b as this is essentially yet another rewrite..

 .../bindings/interrupt-controller/apple,aic.yaml | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index e18107eafe7c..1427ea9b04a2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -36,9 +36,19 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: apple,t8103-aic
-      - const: apple,aic
+    oneOf:
+      - items:
+          - enum:
+              - apple,s5l8960x-aic
+              - apple,s8000-aic
+              - apple,t7000-aic
+              - apple,t8010-aic
+              - apple,t8103-aic
+          - const: apple,aic
+      - items:
+          - const: apple,t8015-aic
+          - const: apple,t8103-aic
+          - const: apple,aic
 
   interrupt-controller: true
 
-- 
2.37.3

