Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE06DAF87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbjDGPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjDGPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:14:48 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77B81FE8;
        Fri,  7 Apr 2023 08:14:45 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 06E9148FBA;
        Fri,  7 Apr 2023 20:14:39 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680880480; bh=mBBL0XNgb3N8+wbsouLr7CbasX3BuGBQGk5RBo6+umQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtvZE85cmuQyF1R2vv1GhUCcoQo5861F6USv8kPwgffpi0bcUxrtlUV+No+byb89k
         x2kw4rP2O28yNkfr9YT5ogce1FdKNXxUx8WizSdWmvoTqnEm18zV58waVVhPmLRuRy
         31KA18irwUmNxetNSywedftAhLMHVR3SShRw1chFonm3ZVoN/JpuB1WQIfax+K2Msp
         CXH7TTBeVpKOA7uMNijTMs6dG9Bwf2t9l7XMJBUJ3fW+FilX/6OKDuhzP7uAiUuPpc
         Nk80FhGewxx95Sg9FS1aCNu/5NCGTlBFesc5s37edIZhlu3EvQe8fum7hfwcFrKidl
         jksysEhJoAfyg==
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
Subject: [PATCH v5 3/4] dt-bindings: arm: qcom: Add Acer Aspire 1
Date:   Fri,  7 Apr 2023 20:14:22 +0500
Message-Id: <20230407151423.59993-4-nikita@trvn.ru>
In-Reply-To: <20230407151423.59993-1-nikita@trvn.ru>
References: <20230407151423.59993-1-nikita@trvn.ru>
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

