Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D8742E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjF2Uf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjF2Ufx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:35:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963DD30EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6985de215so18601081fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688070949; x=1690662949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXHn6Y9ohB66Fq7/rdy4/Qmz5PjvLS1WDR/plz/VYq8=;
        b=TE/g4WJAzyHfArQXO/l9lmbm0FJZUGuiMXs+69BkFhJvABj1bj8B5IQlnKKwwZKV3e
         SuArpH+cehs42DKf1L2fhNyV08peyqG4nr7ValchciuTjTQxCKiEiE9Y1yWx81GcZoCO
         TdeAQ1+ryuBMKk8UkrrYtw07in93r0Fjs6dviP42jCNO6sR23gNM3GvaXuEbeTGRuu+A
         /E3XfBy1NQJO25jfSLOdACUyzWp1r+3q61RXRzhWGeAT8mIMeNfmMwzHJ5ngnFtVqBEv
         1pyDDZRhWC1gP/+Y25vyfu4QX31rJN2O7vjICVFhQhR+LJVRwBXB2GZhO436Tn7EDfv/
         FVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070949; x=1690662949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXHn6Y9ohB66Fq7/rdy4/Qmz5PjvLS1WDR/plz/VYq8=;
        b=IY56L83atQRCWb8+AwMb1drTrzIGsiPeJPIt9vZnDYCCNkmKsytSZczQbq744LgrK0
         rYOxEppYC/nwJ/txq6SesBRxxCT4HaB/o9JRt26vCgyLSW6eZYUtSyKKjjsMazysWWdp
         GwGHAqeEajrwA+FDmWW2PqKWxsw2Fo/pP9FoGC94UNAfvp/He5ZiLXxwkJmz/t8EHwAU
         59/7PuFvAhCH8ubqAoqEwnCfxElcDWyRajokHtT30hbszhkbYEtZwhvfj6PjKkGMKaqm
         SyxcAHk9ny15nz6UE2YaPYlkVpaWSn3ZDos1mql3QKDhUXjU/VP+MNnjcwhPtST5oh9e
         lKzw==
X-Gm-Message-State: ABy/qLZb+thXPxcSu1NVHkPjRrpjz9qAxkGuyf1pSs9ABMA3jp4JcIZB
        jVsAlaE1Y/9fb8TT5GEM/LjUFA==
X-Google-Smtp-Source: APBJJlHuoLuVxQzJifJYdzDqwr5mdS6n/LxpEmpolO12pPohRKRJdXrIRnXtSGdOIACCFSEuHnpUUA==
X-Received: by 2002:a2e:b60f:0:b0:2b6:cd12:24f7 with SMTP id r15-20020a2eb60f000000b002b6cd1224f7mr535567ljn.44.1688070949717;
        Thu, 29 Jun 2023 13:35:49 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e2403000000b002b6b849c894sm1136008ljk.111.2023.06.29.13.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:35:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 29 Jun 2023 22:35:41 +0200
Subject: [PATCH v2 1/4] dt-bindings: regulator: Describe Qualcomm REFGEN
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-refgen-v2-1-6136487c78c5@linaro.org>
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
In-Reply-To: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688070946; l=2256;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Dw17w0X3yguWSuWVzgIdOAGrOkzUUOLcbRD0QrQwKtw=;
 b=h9RLdfs6fCutcVVX8MqQ32l9TWdlE5G4S2/xc+l4+TR1xjoXppM6fF/S6Vpm4DnzAmBgWGCjT
 vK0WMm5WYxlAy2sFeLLaMPMaV+jsNOWD9qCXyS5jkr4+nf/4g7bCnER
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern Qualcomm SoCs have a REFGEN (reference voltage generator)
regulator, providing reference voltage to on-chip IP, like PHYs.
It's controlled through MMIO and we can toggle it or read its state back.

Describe it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../regulator/qcom,sdm845-refgen-regulator.yaml    | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
new file mode 100644
index 000000000000..f02f97d4fdd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,sdm845-refgen-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. REFGEN Regulator
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description:
+  The REFGEN (reference voltage generator) regulator provides reference
+  voltage for on-chip IPs (like PHYs) on some Qualcomm SoCs.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sc7180-refgen-regulator
+              - qcom,sc8180x-refgen-regulator
+              - qcom,sm8150-refgen-regulator
+          - const: qcom,sdm845-refgen-regulator
+
+      - items:
+          - enum:
+              - qcom,sc7280-refgen-regulator
+              - qcom,sc8280xp-refgen-regulator
+              - qcom,sm6350-refgen-regulator
+              - qcom,sm6375-refgen-regulator
+              - qcom,sm8350-refgen-regulator
+          - const: qcom,sm8250-refgen-regulator
+
+      - enum:
+          - qcom,sdm845-refgen-regulator
+          - qcom,sm8250-refgen-regulator
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    regulator@162f000 {
+      compatible = "qcom,sm8250-refgen-regulator";
+      reg = <0x0162f000 0x84>;
+    };
+...

-- 
2.41.0

