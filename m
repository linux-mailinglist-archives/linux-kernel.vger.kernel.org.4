Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E4C6B8B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCNGwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCNGwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:52:05 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 23:52:02 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CC5B43F;
        Mon, 13 Mar 2023 23:52:02 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 1998240543;
        Tue, 14 Mar 2023 11:43:35 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678776216; bh=S8nOEmwUGC8ihgWGDS4+h8wuVwmKlwkTYGS5edObdAM=;
        h=From:To:Cc:Subject:Date:From;
        b=xWH7ji8aAqSccx7EOdxVf8CnY1jJ0lWD/BAv7tY05myus5H9cWDiYKKbkc5a9zBTv
         MbXPJ5QdP/ydpcy0CJfX0/N+oDHx1/iyCTHknkt+JQ90dN7laKgOzdYndqCXjsOaNQ
         fFTdwUSYxpJlWLqgvkBQwroAcE67VeCwKUcBicmAd5M/FYfFdvKQvvPudTbEFjhDtC
         jIZHY0s4/AM1ES7Y5LMhVhSyRb0bF8XxYgS3URvrAsDfzOnWdD0QdldmVNzoMh0/hO
         iOb3+yOMsOmLNUqwf1ICJVhy70dFRG4UahJzIKdx4NW1HRYQd8HrdX9/nxSSW78E9m
         A35YpERAVAYNg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Acer Aspire 1
Date:   Tue, 14 Mar 2023 11:43:21 +0500
Message-Id: <20230314064322.65429-1-nikita@trvn.ru>
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
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1bb24d46e4ee..903a5ea42cf6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -352,6 +352,11 @@ properties:
               - qcom,qru1000-idp
           - const: qcom,qru1000
 
+      - items:
+          - enum:
+              - acer,aspire1
+          - const: qcom,sc7180
+
       - description: Qualcomm Technologies, Inc. SC7180 IDP
         items:
           - enum:
-- 
2.39.2

