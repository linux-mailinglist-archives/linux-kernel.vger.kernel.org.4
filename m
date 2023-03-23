Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40BC6C64D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCWKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCWKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:25:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE77E385
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:25:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l12so19850760wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679567128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbMpIW2XeTgOIuij0DvAphORXQYIJr8R5bBmK3u0n4s=;
        b=OiM1Yacj+a6ZH6zyF+4WbfsKHoee7NXm2MM9OOs2n5bJzfOLIGXc12cwtoMMbg5V3G
         3E7MUGqH2EfT+LLrFi30N1TD5vnz9MtKSQJ7qwGhKdoghrG2YNuKlZpFNEbNpPfb+JNC
         For/VV8QIang/A28V7HMQQzpxwmJI796xxhu2taDRIfLRuuphtt55iNSeSB1TPRM88kr
         MbeZOoHUYvYqUSMsB/kCZa2vQ1FUlEiDJMmqJPeIQn3BXlnkPEmWDHVnFESQ6FJvikYa
         cSWdtPSS6SLsNYVNt6bjg783EluGuECjGfV2WXUqqcBqC1eByii9qGUXoZ2JXGQ/O6yJ
         vBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbMpIW2XeTgOIuij0DvAphORXQYIJr8R5bBmK3u0n4s=;
        b=gNwoXV4A4awOgWnrXuo5Vk66bsdrzCIMivj33SfXIsDW6/3jKkY0Z2U1AgAYshWW6n
         ZjqkXNbVF50BpMJWLpL49yb8HpGvzcbMl0hePwuzNHS+Tt7Fo1QCHuHjPqHStGqNVEoh
         GC5uBLWDHwvJiSagidUmUcHaZnjFr29XNpVtZqKlz03gQMVIMswDjeesnLbdGo5s4yne
         MvdTsAUrWQqm8l/6X2E6ZYc3n424S02q8Ee+kSRe9rvN8P95b59uXr5jAAv3sGBiVf/s
         hGJlOob2/Jaapk2c+v5DCqDvCGZFlujCQmWlRdf4upulneZINLWA28MXCo+tyM2JpY+/
         e2BA==
X-Gm-Message-State: AAQBX9dCE1wNWljfq0gmOkpkooBEZTfQxFF7d9h/EW8go+J3U2W+Cidf
        Q1kWgDXEhfiMEqiUiMB1LrIZWw==
X-Google-Smtp-Source: AKy350YnpJ9aARdt0vtWcfFYEivcldCh8Vl38PKNmqoJ8yqlx/THGzhpYzjoV1hW1Xn0hKBSv96fHw==
X-Received: by 2002:adf:ed43:0:b0:2ce:a8d5:4a89 with SMTP id u3-20020adfed43000000b002cea8d54a89mr2146384wro.37.1679567128111;
        Thu, 23 Mar 2023 03:25:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm15753530wri.98.2023.03.23.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:25:27 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 23 Mar 2023 11:25:17 +0100
Subject: [PATCH 2/8] dt-bindings: mfd: qcom,spmi-pmic: document pm8450 pmic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-2-3ead1e418fe4@linaro.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for PM8450, commonly found with SM8450.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 975c30aad23c..15deeff2d447 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -57,6 +57,7 @@ properties:
           - qcom,pm8350
           - qcom,pm8350b
           - qcom,pm8350c
+          - qcom,pm8450
           - qcom,pm8550
           - qcom,pm8550b
           - qcom,pm8550ve

-- 
2.34.1

