Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12F70E6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbjEWU4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjEWU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:56:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F542E47;
        Tue, 23 May 2023 13:55:54 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C2217CFBBE;
        Tue, 23 May 2023 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875321; bh=aPtCVb7bMGI3Bez5WNGrIPZXM0gwdzb6rJaHCsnocYU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=coK+yKsOw86vwe8Hi00MaAmKNDBCUZmxlp31PgyID85GJ4sEVdT+R1rKkfun0B1j+
         r4fmp09OFvlJHfXhhxBEXyROXPFYRDTEHUyWFJStpyhm7/C5Wf+PT45MKhQz588NNm
         SQPADe8B8Px1wNC0vg6iqCY6e1G1JF5pXGWoAHPo=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:55:11 +0200
Subject: [PATCH v2 4/6] dt-bindings: sram: qcom,ocmem: Add msm8226 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v2-4-177d697e43a9@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=aPtCVb7bMGI3Bez5WNGrIPZXM0gwdzb6rJaHCsnocYU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSgyWin8k5mWSVatDg1flE4t9aVuyq4JFZYg3
 OOBJTafggyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oMgAKCRBy2EO4nU3X
 Vi/LEADWu/gzjzzWKwuTgK0ZS+N6xklZGSQ/H8f6X8i6Oi0GvkD035oMlm5ylVw97hIzLblkPz6
 O1n1Tn0RSseS/XfSrh5s0wlzn5wcHLLuNFcgaRYXPiYnoBvE4IGKeyRkC4bSUHv4uls38oO7tVQ
 INJZBmXrnTdrcccDZWSJ5F7oZMKVD3wZSBsWiPoCNvV4Yx7Hw1rMYXdxX0+pLElx7LSgSswt92A
 DElKqvlcZyBDKatBHElj7dyLuZrW/qdgi/acXnVDe4US1OAqiqG4Cew6AXkSim9dzHF34lGIBWb
 IgbRdRMK8AW8LGA2XVDaLaFUe1pTmnPPSeUZ9MeGSrCgRFTjE+NgaVXst+mo/PYu+5Gy9/vXlhP
 7r8vXyT1YabttpzLiTKefm/kc4CX/TgCAIF41qU6cO0Yy12ZDy6oLqtYmBF1qyJCA5DFgGDKpdS
 HTpSN+y0gdGbW8IcoRPxAWlnDbPH91KEvFwor7TuoijJYOA3j84rBgNX5W0TwK5LCuMmbeR8qgP
 4UDfM/CVQOIfxOrArQzSpJUe9P+aqVijb2p/GLSaiiy5Kw+LKkxhVecOp3D14DD7h7t4eI0y1pm
 RCr69knGTJ1rABXnxX/jKfqndY0tN4DI/UOXAWi/eDPFKYEqyzehZHJKVvFGiTLuYdAtP0aD9+9
 qF1ia0L5LxqGMEw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the OCMEM found on msm8226 which compared to
msm8974 only has a core clock and no iface clock.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/sram/qcom,ocmem.yaml         | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
index 4bbf6db0b6bd..02e4da9649fd 100644
--- a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,msm8974-ocmem
+    enum:
+      - qcom,msm8226-ocmem  # v1.1.0
+      - qcom,msm8974-ocmem  # v1.4.0
 
   reg:
     items:
@@ -28,11 +30,13 @@ properties:
       - const: mem
 
   clocks:
+    minItems: 1
     items:
       - description: Core clock
       - description: Interface clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
       - const: iface
@@ -58,6 +62,20 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8974-ocmem
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+
 patternProperties:
   "-sram@[0-9a-f]+$":
     type: object

-- 
2.40.1

