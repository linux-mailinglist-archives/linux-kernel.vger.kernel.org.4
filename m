Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAF6FD0A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjEIVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjEIVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:16:52 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568F30EE;
        Tue,  9 May 2023 14:16:51 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 17CC1CED2D;
        Tue,  9 May 2023 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683667009; bh=9R6SRvAGjxwi8/vkLzlzpi22W4hAaJIg2Z7jYqDUgMM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=cS2x4pL1Y8Euyv1qBu++8aFNleQrxUtYNqxI+RllW08ZCyKEeyXifp612yVsM2Oqu
         oxWU+msVpQZkVIfUR2lCjgSqEMPysj4Sfikis2ZozEVv90whjW5Ge3DFabM5aRANQ4
         4eJWvY5sGUr4b+pjADva8LwesFTxCCLJKhAX8BbA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 09 May 2023 23:16:36 +0200
Subject: [PATCH 2/3] dt-bindings: clock: qcom,mmcc: define
 clocks/clock-names for MSM8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-msm8226-mmcc-parents-v1-2-83a2dfc986ab@z3ntu.xyz>
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=9R6SRvAGjxwi8/vkLzlzpi22W4hAaJIg2Z7jYqDUgMM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkWrg+uif8+jTU5wl9DJ5FMzUmRYuPndkpfWHFt
 NiMI50zSkyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFq4PgAKCRBy2EO4nU3X
 VkU7D/4jngTUQhY5BeZ5sP31TJfQjU7Nk+96d/wKqr9W8ah+CKQfbZWlGiVIAtXSF3goT+KSqs+
 3K3v9l4WO3Amo8YEDNaHp6wyz/9F20Uupx3tfgJaHqlHBO/R1fYWnjOA8B/9nIOd8e7xn87Upzf
 fjofGrLtAavDDpOAo7W97+txlyMZsbQiznj/Ddd29u2CcUnIEDleN83C2XwdX+/4/qt2awlOPv/
 OG5wBr/neJLuUUBFNrMb5LTfQICotR0IkCWRmyZBJyuionkr3AiNvPbv8WtOB42526diTdOjaaZ
 JvxbuC6YYpJR7067xUwA2hiVn5oiR8e+Uk3PSmJjycltp2AyXmsvyTlKQZRtjiYTK86j8jWWH0k
 3UDWsv2HF7PsTuPIsYsO8/SvYdKgvoPuHuUK4kIHU7srw4u2slr0/+Fono5zyCbyPefJF+C3qy9
 QX7tpd8kiXaF7das0h9jvrJwKluEE44Yx4Si6neyW3gGViw2CgIxzw2QT5BnHtp3r426ztL8PlP
 cThmYhEr/uJ/MRQnuRsVtUDXQtLulUD2dkd6WbI9wgksAa00hgd8rrv+n3dQncE2clyIt65GhaR
 pQ3D+jZ3dlGb9/9/xep0h1uRHIbheakG3XItfnsOv7PgLkr5Je67B6rOJdGaCFWIYGNs1SPfklR
 yJtgcI6Hy0dGCbw==
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

Define clock/clock-names properties of the MMCC device node to be used
on MSM8226 platform.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/clock/qcom,mmcc.yaml       | 32 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
index acf0c923c24f..422f5776a771 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
@@ -31,11 +31,11 @@ properties:
       - qcom,mmcc-sdm660
 
   clocks:
-    minItems: 8
+    minItems: 7
     maxItems: 13
 
   clock-names:
-    minItems: 8
+    minItems: 7
     maxItems: 13
 
   '#clock-cells':
@@ -99,6 +99,34 @@ allOf:
             - const: dsi2pllbyte
             - const: hdmipll
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,mmcc-msm8226
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: MMSS GPLL0 voted clock
+            - description: GPLL0 voted clock
+            - description: GPLL1 voted clock
+            - description: GFX3D clock source
+            - description: DSI phy instance 0 dsi clock
+            - description: DSI phy instance 0 byte clock
+
+        clock-names:
+          items:
+            - const: xo
+            - const: mmss_gpll0_vote
+            - const: gpll0_vote
+            - const: gpll1_vote
+            - const: gfx3d_clk_src
+            - const: dsi0pll
+            - const: dsi0pllbyte
+
   - if:
       properties:
         compatible:

-- 
2.40.1

