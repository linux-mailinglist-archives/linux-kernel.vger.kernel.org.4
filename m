Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369BE7419B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF1Ufo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjF1Ufd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CE2103
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso115509e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687984527; x=1690576527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLLOu6EAK11JlQ0QO2AgIEUtq9JTMwUO1xk6IzK6GXA=;
        b=VUgJVyNQ46SZc/SETfVTf12HpIBENSSxcaFVuzqg507r1sVSKchCPUa3vHyJI/bppn
         UcxEPsdyMDeIiJvMY5oBOHcBsBuJVPXp8h+hCVLycjlxEmPje2X0u/lHVBZVCnKTA2I+
         1Pqqzlmz5xsXXKZl8KtYo2v1YedypJZBW4/+TMD1etDB65KtmEQrEHfS56n59M++rpSA
         sBgpd41GpgjwmZ6OUR/mTzdVoaNQXEqe+AxI/RAR8W7caK57W13QJKjaMbt2VxVeDRNM
         +Qa2jv2JdqIVUau+8MX6CwBu6iynfhXjl0g7Gx+ERKLZyBo2CSvTn56cVf0HXNsu4vVb
         LezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984527; x=1690576527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLLOu6EAK11JlQ0QO2AgIEUtq9JTMwUO1xk6IzK6GXA=;
        b=XD8Aif4J2BcckeY19dPVnrFcTssQ3ZHC8oVgQlHRiPXZ1vOvAzESbHnFo9pdiQURen
         j+U2Ff7LH7VyzgkojQzAYiwtd50SOWTzrrNyyIn5eeZLh9Tb07cG47NUqHTLYy4TRQZU
         J6Tf1LQolFkfUMVYF8Y3WWkK/iSxA/T4M1UaRru89gZ/xE4tPoHz6+Z6FfR6bZWYlN4L
         MyWviDa5EQ739FVKrYTdHpRtG60c0A4EUrID/zk/x8v5cZulVe93lpp0vt+fSdI0YBk4
         wT+fFfN1TqsjTTNlnauCFk1TouAachQ5seEiAshHj4ZDDPuHQuBH4qjhvGy7ob/2lb1c
         ec4A==
X-Gm-Message-State: AC+VfDzjp+rwIDmr3xaEoBv8pCxioWaqdj8kBhlLOrXdfjj7O+O6zRub
        BGs/nnv29IM3KzMJjdGTKbDOgQ==
X-Google-Smtp-Source: ACHHUZ4f6DZNtS5mH9pmvdxVQq+DrFyWMbwfX2R/goxW7dVzoSM26jgIxZjeEllapv9bFzWCOVFFQA==
X-Received: by 2002:a19:9158:0:b0:4fb:8a0a:31f2 with SMTP id y24-20020a199158000000b004fb8a0a31f2mr3210468lfj.69.1687984527531;
        Wed, 28 Jun 2023 13:35:27 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512015900b004fb86c89fa1sm753363lfo.135.2023.06.28.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:35:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 22:35:01 +0200
Subject: [PATCH 01/14] dt-bindings: display/msm/gmu: Add Adreno 7[34]0 GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v1-1-a7f4496e0c12@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687984524; l=2620;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RNzmpAEyvVrlK1D1yM5aITAkelZKzAiwRalpUW62XcY=;
 b=zsJMeX/QAhEJ3yoD1GUVyN2bmubWhiczsOlwjhKASzR5mDDoHvzRWP9qGdM+HyX1nMfcovw2P
 Fd5dxgOALpdC63ZAGJBKtnJ9w+QXTBMDYN2K9mZr/dVX4nc7fIo4eVt
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

The GMU on the A7xx series is pretty much the same as on the A6xx parts.
It's now "smarter", needs a bit less register writes and controls more
things (like inter-frame power collapse) mostly internally (instead of
us having to write to G[PM]U_[CG]X registers from APPS)

The only difference worth mentioning is the now-required DEMET clock,
which is strictly required for things like asserting reset lines, not
turning it on results in GMU not being fully functional (all OOB requests
would fail and HFI would hang after the first submitted OOB).

Describe the A730 and A740 GMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 40 +++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 5fc4106110ad..20ddb89a4500 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -21,7 +21,7 @@ properties:
   compatible:
     oneOf:
       - items:
-          - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-gmu-[67][0-9][0-9]\.[0-9]$'
           - const: qcom,adreno-gmu
       - const: qcom,adreno-gmu-wrapper
 
@@ -213,6 +213,44 @@ allOf:
             - const: axi
             - const: memnoc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,adreno-gmu-730.1
+              - qcom,adreno-gmu-740.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+            - description: Resource controller registers
+            - description: GMU PDC registers
+        reg-names:
+          items:
+            - const: gmu
+            - const: rscc
+            - const: gmu_pdc
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU AXI clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+            - description: GPUSS DEMET clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: axi
+            - const: memnoc
+            - const: hub
+            - const: demet
+
   - if:
       properties:
         compatible:

-- 
2.41.0

