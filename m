Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A073051C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjFNQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjFNQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:36:47 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D521BD4;
        Wed, 14 Jun 2023 09:36:43 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 308C9CFDC3;
        Wed, 14 Jun 2023 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686760571; bh=YDl2tvHHlHynpu6yX+1RRCk0EMdjswQ742sDIsDbcEQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=LzrVXewQaK3NM+myFVY67p5y86JuEt2MBPfRCqwU5uNsBtvB0mOOn7GFIdCDVR0Qb
         7vQCUt2MSBhA1E6qCdNcajFPY1cHrELMaBZ/Nr34zyxvCjMggN64wFN5heIyhnM6uQ
         0ZbmWwHly/ta0xGD4UHyZuvBwKU9buPOGZwYsl1M=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 14 Jun 2023 18:35:50 +0200
Subject: [PATCH v3 4/6] dt-bindings: sram: qcom,ocmem: Add msm8226 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v3-4-79da95a2581f@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
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
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=YDl2tvHHlHynpu6yX+1RRCk0EMdjswQ742sDIsDbcEQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkiex3PqIJUJA1I7YxQu4nSojJ4YWb5CZNxFSTT
 9L39yLTMCyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZInsdwAKCRBy2EO4nU3X
 VnruEACC+AoxPpJqOz/fFKRniSPON+RnZBUgxdx6q7gZK/p4gppq4qm1ysNyyM5CvXepyc4a4NK
 1hEzMN2bxqMje+OPRAU95HWm1ethnmRn/R8OYPdJJYcyB+tWRXxZJnWFL9cqDcoSWsPzxDUPxss
 1zKp4MeDg85zkDzcxfoP9CsM25lSv8WTjttWy1c9MrYAVxT8Y/OY0HkeumZaontCt57SgTTq3fw
 qvW+GQulTHdnp2QiHWQi2kkhsIjlOY48ZwnFwFdMo8Nq2mNsA47bSe+ts45VlztoojIm1bAII1J
 E57Y5C8+8bJaN0+dKBt+SRI9E4QwV9nM94ETgznOlD8KBuXeYgjEwJ4ZtWVmrT+pb045VRz2hQb
 /ObxxhU5i5/J0ot3Myyw1t7iCYHX+YetaYL2EKGQd5ndtM1YyecDDKkWhBBqzaDqEbWVdnZIIY4
 NremeuFAQg4OOZqKtJPfwTq4FSaks1Z+tJDL2D4tzP0fUpAPO6wUY6jvFGOCpLYGW8BdGqlNRvx
 dbgpOuSdbfFydxk/j+BABPM75aDF2EZvWIiwbNyxrQtAiV4fzFRSHrus1oUEseroiChLfYkiGRJ
 qaRJvr+q8Ot6Y5+UolGRh9cnvZZ2lyB9I6SWu7PkQj2Gcf1ZjlaGT/LA0P1K4MqtBu1wQpLxaRO
 8E2PV4FqHA+mFSA==
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/sram/qcom,ocmem.yaml       | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
index 4bbf6db0b6bd..61c784ef7b51 100644
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
@@ -58,6 +62,26 @@ required:
 
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
+    else:
+      properties:
+        clocks:
+          minItems: 1
+        clock-names:
+          minItems: 1
+
 patternProperties:
   "-sram@[0-9a-f]+$":
     type: object

-- 
2.41.0

