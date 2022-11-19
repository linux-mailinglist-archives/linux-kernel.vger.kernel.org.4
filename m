Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CA6310CC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiKSUje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiKSUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:39:17 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4513CCC;
        Sat, 19 Nov 2022 12:39:12 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6572AD05D1;
        Sat, 19 Nov 2022 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668890321; bh=pDMbbV3tKdaZDTFgXz4iSvwSeCqGO4wqmQzHXYEVKk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r8SYhJirVHQ0uqckZXCxJ4wl862RgJyWRlfjRBKvGy5dtIb5DLK4fOV6UxeRBadpK
         MOUXYy1DgX8NTZqEEtLZFh7MwX/sjLMUkEBtOR1yT/bqy4KeJM4Oqxg2mfzkxy3HJ5
         NJ1q5abSrFHSsDauHeoKDuqPCfsmziFefcrym2uU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: arm: qcom: document new msm8953-family devices
Date:   Sat, 19 Nov 2022 21:37:42 +0100
Message-Id: <20221119203758.888207-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119203758.888207-1-luca@z3ntu.xyz>
References: <20221119203758.888207-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the various phones added in upcoming patches. Also allow
qcom,msm-id and qcom,board-id for msm8953 and sdm450.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* Add msm8953 & sdm450 to qcom,board-id exception list

 .../devicetree/bindings/arm/qcom.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..0f6192f8d888 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -35,6 +35,7 @@ description: |
         mdm9615
         msm8226
         msm8916
+        msm8953
         msm8974
         msm8992
         msm8994
@@ -50,6 +51,7 @@ description: |
         sc8180x
         sc8280xp
         sda660
+        sdm450
         sdm630
         sdm632
         sdm636
@@ -199,6 +201,15 @@ properties:
           - const: qcom,msm8916-v1-qrd/9-v1
           - const: qcom,msm8916
 
+      - items:
+          - enum:
+              - motorola,potter
+              - xiaomi,daisy
+              - xiaomi,mido
+              - xiaomi,tissot
+              - xiaomi,vince
+          - const: qcom,msm8953
+
       - items:
           - enum:
               - lg,bullhead
@@ -669,6 +680,11 @@ properties:
               - qcom,sc8280xp-qrd
           - const: qcom,sc8280xp
 
+      - items:
+          - enum:
+              - motorola,ali
+          - const: qcom,sdm450
+
       - items:
           - enum:
               - sony,discovery-row
@@ -685,6 +701,7 @@ properties:
       - items:
           - enum:
               - fairphone,fp3
+              - motorola,ocean
           - const: qcom,sdm632
 
       - items:
@@ -896,10 +913,12 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8953
               - qcom,msm8992
               - qcom,msm8994
               - qcom,msm8996
               - qcom,msm8998
+              - qcom,sdm450
               - qcom,sdm630
               - qcom,sdm632
               - qcom,sdm845
-- 
2.38.1

