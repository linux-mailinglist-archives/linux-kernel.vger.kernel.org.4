Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4323A6BA68E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCOFMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCOFMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:12:39 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D7A5FEA0;
        Tue, 14 Mar 2023 22:12:32 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 2F9EE40AC9;
        Wed, 15 Mar 2023 10:12:26 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678857147; bh=64bT/kFi+yswTFpAsaUqn77BuPVLNngQ7eDIFLAoZBE=;
        h=From:To:Cc:Subject:Date:From;
        b=5Ru4g3EZWdFnHAIg9ynVatKG0xOixcPa0bvea9U/ryaMyGa6ENUhNTdBw+jxWTaYU
         67p1L5khPOfJpSiuMtep9uouXV4tKD4nCLEfcSoZ1zxUcHK/X3Z7ec3IkSAPLSm1Y+
         aQk+YCjyHQFxdGBecrcciwL9zJtWF8PCIRq47A7JnXWW9pu8QGlsI/rdvJB1b16JBP
         sKzhAe1eWH75uKBiCugwSORiYJYI1+LArw0qX9wqTQzkBM2QUAY0WHWITf/xTLZGym
         arLQgC7hixwUfNz+7kUnbpiLQa3r8MsWLKq9+jI5bq+jOYpCP2H6D//AcGK/SttZlf
         0J0qWkSsI03Kg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Acer Aspire 1
Date:   Wed, 15 Mar 2023 10:12:19 +0500
Message-Id: <20230315051220.5614-1-nikita@trvn.ru>
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

