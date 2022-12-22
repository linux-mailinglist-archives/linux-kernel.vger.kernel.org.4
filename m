Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AC654084
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiLVL6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiLVL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:56:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7642EFAC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:50:21 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so1614137ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6zbNVvUnUZ8o4kZcOTLR6KagKMfi5R7wiaU4278DEU=;
        b=a/zmMZNdXQeHq719bi47ZJCtdikNXOc0xis60e5rgzIAMoUR/FScBMs7i7jjbgSIrC
         VR2YS+apShCH1+PhG9sTCNYAa9OozWx7Yp2EpmMf0jLBLLrOJt5BJ7BEQJMgRgpm7kVQ
         6HIoCjSFNOBCq30HVlhHtHuD8Lx9vzYKqD4MspTgltifTgPEwsvaZbbCNacUDbSpVaW3
         0QGMxaEx/4hzxqiO1mP+v64VnnB4UXfkADDkL3YnN3m4IAYtrYjXTo/P7j9IkIeP2E2I
         P2knlEf/rmUoY2MD7CAFzZNDH9nVkHLkB4vVSGkHQZOrAGCoEksRXMP8Z/DzayIJ3Ob3
         kfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6zbNVvUnUZ8o4kZcOTLR6KagKMfi5R7wiaU4278DEU=;
        b=z6fz3oI8Bs36C2dWEuO3qzxJ4JfsDwLLfDl+ksUnsfGK5BajNut7K74KgpQevE3hR7
         myvC/GoCOiyQfxSf5VynLMbpNopm+nabFtv9rCtz1N8Vom7f6E+oh8WN4AP47oCCS1bY
         rZV38d3sTXvgUDs6TiUlTqjYhXIDp7TQ6FZxNbStGPtGN0cVtzv3F92r0T3UIvNhs1Ik
         6utkl4YI0Kjw8NZKd0HrteKwEDxkEV3ZkNQGX+bbLEBnr5kg/ZnMlNrhz2mJ36Pl/9A7
         SLqgQjg3jtkGxhsVuj7O8vYGh2fQ0LiQvQiOu1TT0xCqqdKhL20+wdS/bzzvyvJyQrcU
         8LMg==
X-Gm-Message-State: AFqh2kpG9r0z4/2KxjVVpemdA+gEVmwcz1sE+yZLJBdTrDV1rRdDdzJN
        xoyTIjRTWlxxHVnoGpZm3xhuJA==
X-Google-Smtp-Source: AMrXdXtFCO9TlMOcSbYrHeCeIWjx6v7GVy95v/qvA+USs+fHF3IExmCDsebPaR9GuVGgSfO7psI7SQ==
X-Received: by 2002:a2e:99d4:0:b0:279:e84f:cd08 with SMTP id l20-20020a2e99d4000000b00279e84fcd08mr1314614ljj.48.1671709819749;
        Thu, 22 Dec 2022 03:50:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l4-20020a2ea304000000b00279f3c58278sm26857lje.51.2022.12.22.03.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:50:19 -0800 (PST)
Message-ID: <4115ec26-dedf-ca80-b81a-409d9db88f52@linaro.org>
Date:   Thu, 22 Dec 2022 12:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 05/21] dt-bindings: msm: dsi-controller-main: Deprecate
 qcom,dsi-ctrl-6g-qcm2290 in favour of qcom,qcm2290-dsi-ctrl
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-6-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220123634.382970-6-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 13:36, Bryan O'Donoghue wrote:
> Deprecate qcom,dsi-ctrl-6g-qcm2290 in favour of the desired format
> qcom,qcm2290-dsi-ctrl.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 36 +++++++++++--------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 01afa9e9c4b3c..98d54a7ee28d4 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -14,21 +14,27 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - qcom,apq8064-dsi-ctrl
> -          - qcom,msm8916-dsi-ctrl
> -          - qcom,msm8953-dsi-ctrl
> -          - qcom,msm8974-dsi-ctrl
> -          - qcom,msm8996-dsi-ctrl
> -          - qcom,msm8998-dsi-ctrl
> -          - qcom,dsi-ctrl-6g-qcm2290
> -          - qcom,sc7180-dsi-ctrl
> -          - qcom,sc7280-dsi-ctrl
> -          - qcom,sdm660-dsi-ctrl
> -          - qcom,sdm845-dsi-ctrl
> -          - qcom,sm8250-dsi-ctrl
> -      - const: qcom,mdss-dsi-ctrl
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,apq8064-dsi-ctrl
> +              - qcom,msm8916-dsi-ctrl
> +              - qcom,msm8953-dsi-ctrl
> +              - qcom,msm8974-dsi-ctrl
> +              - qcom,msm8996-dsi-ctrl
> +              - qcom,msm8998-dsi-ctrl
> +              - qcom,qcm2290-dsi-ctrl
> +              - qcom,sc7180-dsi-ctrl
> +              - qcom,sc7280-dsi-ctrl
> +              - qcom,sdm660-dsi-ctrl
> +              - qcom,sdm845-dsi-ctrl
> +              - qcom,sm8250-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
> +      - items:

I would just squash it with previous. You are adding some code and in
next patch immediately:
1. re-indent it,
2. remove it (qcom,dsi-ctrl-6g-qcm2290)


Best regards,
Krzysztof

