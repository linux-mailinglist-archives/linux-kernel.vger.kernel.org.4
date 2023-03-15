Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1E6BB846
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjCOPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjCOPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:43:49 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D21E5CB;
        Wed, 15 Mar 2023 08:43:28 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 11D8B41856;
        Wed, 15 Mar 2023 20:43:21 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678895003; bh=yC9QeX1/CinFj0AXF0UOx48KkeA3BvO26z/oJWW3jyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=4dLGXha+rE+udEGHXMwpBmKMo5ENiTjMtZe/iUj3+DAKahkMzANQD9LiE59vBPlYG
         1AnPpn4ASpccOjx4+f7lyRZQz7oN7O0AA/QOOKhR1PzN+MRTobwSivwqpGvI2KLrpb
         +FugMSjjhADtImrPL2WQMWFakbmWanO9t3wZejTwG2yhllbnOST8h2AP8NyeosEfyI
         SPG/IuBUvQ10H80N4pYiPp/BidkY6tvgrPokVLWGonCi6gM7Z+goxEeXt30ESCuMfA
         5aYcMzc5RvFRkJZD5yfmilMomqYZEyWSYj8U05yoRh6J/rkBczh0mmg4+u62F428Pu
         s2GYaKAL9Wfbw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/4] dt-bindings: arm: qcom: Add Acer Aspire 1
Date:   Wed, 15 Mar 2023 20:43:10 +0500
Message-Id: <20230315154311.37299-4-nikita@trvn.ru>
In-Reply-To: <20230315154311.37299-1-nikita@trvn.ru>
References: <20230315154311.37299-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 23c9c9ba5d52..10e92bdec11e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -352,9 +352,9 @@ properties:
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

