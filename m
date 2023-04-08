Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193A6DB98E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDHIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDHIOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:14:21 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB7D53C;
        Sat,  8 Apr 2023 01:14:20 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C865D423D4;
        Sat,  8 Apr 2023 13:14:16 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680941658; bh=mBBL0XNgb3N8+wbsouLr7CbasX3BuGBQGk5RBo6+umQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a76OXMnCJoByov5GlsUhF9EdQ2D4IPaYk3pX5Rwq+qG2gKy2629HCSxZ8zMmgOWSf
         44ELhZnzO68dj1iw04W9mEuaq0+OG+NkW/B7LN5ShS7qAnUZNa0UX+b1GJCi2h3YjF
         22wXSQjfC4wre0cLk90pAtGz5esoXcwIJqZ5SUm4lwR7GFtJsvVGaQLeKG7aZhldgv
         wDbrW7P++Z1HmyFKHxGdWcoEkm1ZEdQlvAXtD/uorB7/uZQOc47RW2hJP55odfA523
         9pTpc7AyeJH+jf5VQ3JjpPUoW5bMhPG1R19F6+Fc2Xx2vozz63Qyv2qOWrjQGNKJY7
         /EOxIbbIZQKyQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 3/4] dt-bindings: arm: qcom: Add Acer Aspire 1
Date:   Sat,  8 Apr 2023 13:13:15 +0500
Message-Id: <20230408081316.234293-4-nikita@trvn.ru>
In-Reply-To: <20230408081316.234293-1-nikita@trvn.ru>
References: <20230408081316.234293-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer Aspire 1 is a laptop based on sc7180. Document it's compatible.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
 - Merge with IDP (Krzysztof)
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index f8d29b65f28b..db97a61e8ccb 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -367,9 +367,9 @@ properties:
               - qcom,qru1000-idp
           - const: qcom,qru1000
 
-      - description: Qualcomm Technologies, Inc. SC7180 IDP
-        items:
+      - items:
           - enum:
+              - acer,aspire1
               - qcom,sc7180-idp
           - const: qcom,sc7180
 
-- 
2.39.2

