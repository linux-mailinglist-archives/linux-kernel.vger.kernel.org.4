Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3576B741677
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjF1QaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjF1Q3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:29:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53DD2D71
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:29:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so6708440e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687969789; x=1690561789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9KnMtZLR40pDXGElESmmZUvDm4CZ/ghYZ4Hvek4pbQ=;
        b=m1/0vpJU7e/vmira8hvb7shwcPdAr25+sj5szdqtuv4qnL85+sOOo/xfk7nVR4wSbF
         8cK9NOV8cxuLtUEDAnyiO+S4B0oPjEvOBGvy6r7HmD40YUyFOvf57zr/6ZZr5vKBFWo7
         SdTrH7sqljfa9vtyGc9Oa+zOD9UPUKOAhP4xIBk+e4GxAzZCPw3XRDsPt8JufSTJ8N+2
         ibbABJN6DcwG3X1McvSxXbbJknNaMyAuM4W+XL8TL2bP78Fe9B25xRScrpWCvGqr96V9
         zjpxFkw4nFFWuvUlf/p2tZkmFFApu2xqbsyQeLJZcrVoMs3ejMNDWRv9cO4BjxgNCm68
         LQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969789; x=1690561789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9KnMtZLR40pDXGElESmmZUvDm4CZ/ghYZ4Hvek4pbQ=;
        b=A79EMv5Ob7M8wLIyHFsSys9iy9x3l6SInbv9O6DmPbfIpUZBtSEuAZwMNuv6crbtPC
         QfDjxilw1LpfOGbIO90MldsgSbweJ2lCxY1ebS08otNcguOcEX68RBUO3hnryDMwSMLP
         iRla6XyA2d1S49jhl1keErE8MZGzPNTr3My10bo2c1TOdlMPTueCkTqKNq6h+CLlBsVs
         7nIIFV/p5adr3b1gBerB6JvaZskwhi1mJ6SoOGKnLoMzBgldxz58YE/ihZvdcykBPyba
         VAqJzvmT3/w2yIiP4DjgliYKmK7qJ53FBDpS11Fmxl54s2Gt7ElhC0g5VNcaLdKDtfxz
         4+Qw==
X-Gm-Message-State: AC+VfDyMRZN9h5LY0yY2CfNdIKtyCgWedGfDNAaB4NRhuYZft+DHeNNF
        7mf36F+ED6z1KJOXbbYED9h2uw==
X-Google-Smtp-Source: ACHHUZ5DA8AehWO58Dkwqvm39GPuJsu46ahFH3l4cIqAJIyjqBRvcGw8M9F4RnDDYxcvk8eLPANVTg==
X-Received: by 2002:ac2:4f07:0:b0:4f9:6528:fb15 with SMTP id k7-20020ac24f07000000b004f96528fb15mr14393398lfr.12.1687969788869;
        Wed, 28 Jun 2023 09:29:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id v28-20020a056512049c00b004faeedbb29dsm1678783lfq.64.2023.06.28.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:29:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 18:29:45 +0200
Subject: [PATCH 1/4] dt-bindings: regulator: Describe Qualcomm REFGEN
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-refgen-v1-1-126e59573eeb@linaro.org>
References: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
In-Reply-To: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687969785; l=2253;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=E6OpwKaLxLMqeufp2J5Sb8wXLqiG8TBOqY/1j2yTMwM=;
 b=Fl3PQ2gQQ2JC6dxfvdudrWKD2Y7+XzJSj9IfqR6O8URn9dgYJuKM7wqNx30GKtD2rIIg/tfEy
 qr+tcyV4xcrAYut9JAKjPW+iBve7g+7t66P2/sjfsFVzrZkhOqZAd+H
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../regulator/qcom,sdm845-refgen-regulator.yaml    | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
new file mode 100644
index 000000000000..19d3eb9db98f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
@@ -0,0 +1,56 @@
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
+description: |
+    The REFGEN (reference voltage renegator) regulator provides reference
+    voltage for on-chip IPs (like PHYs) on some Qualcomm SoCs.
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
+  reg: true
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
+      reg = <0 0x0162f000 0 0x84>;
+    };
+...

-- 
2.41.0

