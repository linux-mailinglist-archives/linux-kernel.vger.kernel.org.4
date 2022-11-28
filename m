Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8F63AEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiK1R0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiK1RZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:25:44 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F30B27909;
        Mon, 28 Nov 2022 09:25:43 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E8ADED066B;
        Mon, 28 Nov 2022 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669656342; bh=IfmTaICdqswW4Lb7vIl8B1Dt74KuohxAAb8mcVQuCSE=;
        h=From:To:Cc:Subject:Date;
        b=K8LZqgjxPqJGhf1QPpriSd8PJ9rUdkJTFKWf0quuVXuRgBZjTZZ2BXk4pLOck6NL5
         7V7LrutKMX4e0qBMUj/M73DnJF2QCDhyAzRlzgmpvO4f8jGrzjXFxgH71pQYeGiGKd
         FZ3nim1z0tSceBF+8uANHobhthnLgSNFJ9S0kiQc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
Date:   Mon, 28 Nov 2022 18:25:29 +0100
Message-Id: <20221128172531.828660-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the OnePlus One ("bacon") which is a smartphone based on the
Snapdragon 801 SoC.

Also allow msm8974(pro) devices to use qcom,msm-id and qcom,board-id.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
* Rebase on https://lore.kernel.org/linux-arm-msm/21a20298-0e95-2185-38ea-0920336f4276@linaro.org/T/
  Include qcom,msm8974pro in compatible

Note, that this'll still conflict with msm8956/msm8976 patches to this
file. But conflict should be trivial to solve, depending on what gets
applied first.

 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index a53a24b3edbb..8ad92bd1ab6c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -173,6 +173,7 @@ properties:
       - items:
           - enum:
               - fairphone,fp2
+              - oneplus,bacon
               - samsung,klte
               - sony,xperia-castor
           - const: qcom,msm8974pro
@@ -901,6 +902,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8974
               - qcom,msm8992
               - qcom,msm8994
               - qcom,msm8996
-- 
2.38.1

