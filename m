Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5631C6B9399
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjCNMUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCNMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:17:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E295BD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:15:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d36so19719492lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678796062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWw370fgLD0HuRvp3mvzxHwlUz7uiZNuT1LLG7WatHE=;
        b=BR8ArhoapVcMZY0cxumbwhT+4XFfjagIBWxWW7+ZT77+kP39rOZ4tZVylbD1D10w+Q
         bGEfqWNKHW1IPM9CpeRIVNdBZVv6HpuUAXTvPlrFm4rexBJZSFfBr78zsdDJjkESwLCq
         X7jTQphjo/TZ6ktmsE9Dfqgo5nLTUW8eMdaACXn1rYqw3tu+6a06udcObap9xDEvetil
         Yt2xJNhb7/12kt6pAHYqi32iAGAwrRlX5bAmZffMKrcJI5rFhf/x82q7jotQRocFtiL/
         8eXKBXD1TcKXxhcqoVPBJJF04CrPxNua6rL9HfXNbyYRRvs/GppEu6Fq+mfPG9jsrQVJ
         ilpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678796062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWw370fgLD0HuRvp3mvzxHwlUz7uiZNuT1LLG7WatHE=;
        b=zjCDJ4xASNDPxnuxX4D8Tu2PU2IyLMIiZ8ObyHPgEkfjimi5c12TF5KMq/2dWNxkYi
         sfR1jqAqloOjI0n7rffCTYjteq7tlTAxDEFrwqjk1pOFPJv4urDMVnlH/RyFYUFz5xPH
         OXTzKdgStb8GTXOXfft++2Fm6kpMS7ECUqP1EXKoX9WodOGrcN51h64NYzGm3ErQjDb/
         L8zngld487JDNrpHWKyadxeDKkGkBeSrEar1kmIu//PlQS+VobOGxMOCqscAyPyNcSaH
         5JmvKBdh/JOOQHrFQs28XQWcPcTKUsq1jlO2PLUgNhqpU6KZ8rH6WbCZahniGH0khTr1
         GzZw==
X-Gm-Message-State: AO0yUKXULCy9myAU8X12HfZkNBhfGrt9aYQ8B74xoUFePwZ/H6dx+c89
        0Ax+RnZ5fms+cT1FvM0aGWJm/w==
X-Google-Smtp-Source: AK7set+172hSpy52PLzeDpjRg5xVEmg74JjZc1Tx+uPWqEXPab7FQ1Uhtw85j7Tiwx/TkZDOfqo4jg==
X-Received: by 2002:a05:6512:21c2:b0:4dd:a785:83aa with SMTP id d2-20020a05651221c200b004dda78583aamr622076lft.31.1678796062249;
        Tue, 14 Mar 2023 05:14:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s4-20020a19ad44000000b004dda87ecae3sm379058lfd.246.2023.03.14.05.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:14:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:13:46 +0100
Subject: [PATCH v4 08/10] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v4-8-54b4898189cb@linaro.org>
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678796043; l=1205;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1EfelHpNhZt1wPf/IjMVjhdrSdK64CK4dz3kGi3pPQM=;
 b=okBWwdgQUh8QE+PTDW404ps/EZPQpW+e2juB8VF46sCJW23XqUwNzrji/vbQ6+8M3/zhirNWv8uQ
 9XvQ1DHWD7rj0uCKWdYDtlOQZwfr07hGb/0Ec5qoo8PWjvJ/0f6A
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
alone. This however didn't quite work out and the property became
undocumented instead of deprecated. Fix that.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 2494817c1bd6..94f4cdf88c95 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -34,7 +34,7 @@ properties:
       - items:
           - enum:
               - qcom,dsi-ctrl-6g-qcm2290
-          - const: qcom,mdss-dsi-ctrl
+              - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
         deprecated: true
 
   reg:

-- 
2.39.2

