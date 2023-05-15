Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E257029F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjEOKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbjEOKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:03:12 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD9E52;
        Mon, 15 May 2023 03:02:52 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D497641A9F;
        Mon, 15 May 2023 14:37:52 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1684143473; bh=XMJXsG6Vm7tZtS4pzVLRqJnhwv+Pz9VXRWq+ceEo6Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fvvbg7rH/ViCAVAXp4k3IZHXLAiV1ducDSA4I/Fs50sjZhAy+eGc3wwSJqitPMzwf
         sMgHKsoD2QIDWRmGFTsCkkGQNsjoNuq5MpMH4VyyzfS8QV7Gfb+xHTHOG4ZNhR7V2w
         nFa1kB/X3th83Bxvxqe48KiP+4m0MWQmOrFBp3h3MPiy0GGO88BmDNrmSACphTW9HX
         83ypYQ+XTU0b9ZrzynSeaROuL0RHBB7mAH8pXRoWANPnSfX+2fJK8PXIsQCVhAFzqE
         ZC9lj5LApvypP/vfPCPeNtRgxfgZ7NUnUce1ijEafSG4DXY7lYN98m/sqUU0SaXSLq
         TbKAKW4axxSnw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 RESEND 3/4] dt-bindings: arm: qcom: Add Acer Aspire 1
Date:   Mon, 15 May 2023 14:37:43 +0500
Message-Id: <20230515093744.289045-4-nikita@trvn.ru>
In-Reply-To: <20230515093744.289045-1-nikita@trvn.ru>
References: <20230515093744.289045-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index d9dd25695c3d..d30ce938e303 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -380,9 +380,9 @@ properties:
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
2.40.0

