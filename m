Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0315B6397B6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKZSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKZSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:55:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640F15FFF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:55:36 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r8so8664730ljn.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbCBADLIPXF7TNfiwageJ9mTDj5FI0xwrrvz+HsWwAg=;
        b=w09ks6qaH8b9qQcgi8GXTnBK8RyoaE6DXPbG5xAVAvux8WkSz/kSGitbaXvJPyZ+uG
         MYfsD3AI/uz4atcTYv+RmnTHGQhMYEoueEBUX30LJHj6gKSZo6Rj9iu4+GHy8SHVrrWr
         /aLZtM7uuZFPRdQmo8I4RJAtwEQp8hjAB1nCzQrJEnY7y82gWPH7xiThs6e3Ndf55aoW
         sMvlZxCjzrvHsYl4MnVC8jQLVbxv1S2QZuT0f40w6pw6M1Baht7/nr5wx3QdjbaoLiH1
         UkjKkR/wQWIBIkcId8h/hpNjkiLA+4qxpaLJQXaVRih+k1lJilukEbVYQPvPtBilQu4r
         Z7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbCBADLIPXF7TNfiwageJ9mTDj5FI0xwrrvz+HsWwAg=;
        b=flGfMj3lYfkoIW96yNjdHvIYQtNdxfRT/31H9iGu7MwDjw5MyZqdD1W7eEWBNDke+/
         ai+hTlmKuOeUQP8qDDa3lE8Q9tw5P3bj8HMpMoWwKGJGV1MX06RG5F7sO6aCGtr7gjAt
         Zg8YZs4nuKUWRROENIHvcouFq8dbM9uu9p9808RtEKq8V016eCMzIWEB8gIdVLKHYaQc
         TvzX681i6cfPfCBIOLHkx3SMIRbvuigssXtZmnIg/3XQNqqv31359G6cRKBkUmAQuK9r
         +CZZA8hxw3oYLuraNvISLWmsVxFvWoUU+gAMbiOOWq2A3B7yO39fFodWPmG2v8KdKQmh
         oVdQ==
X-Gm-Message-State: ANoB5plEsHd7c8Hp7mMgnLBb1VEZKepzPnJZAajAhlwJsfVVSOnmPGIc
        nFxQGFnC342s7l3Q45uttjmKRA==
X-Google-Smtp-Source: AA0mqf5Kernurc3hkhUufFar+cj2qeo7AMUGpIxEazneIz/6FDqGsiX+Gx/zU89mp4LCOsCl1Pr3uA==
X-Received: by 2002:a2e:a263:0:b0:276:be89:5616 with SMTP id k3-20020a2ea263000000b00276be895616mr7615840ljm.347.1669488934794;
        Sat, 26 Nov 2022 10:55:34 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c125300b00267232d0652sm748076ljh.46.2022.11.26.10.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:55:34 -0800 (PST)
Message-ID: <1bb5309f-8e77-16bd-630a-707228e5dacc@linaro.org>
Date:   Sat, 26 Nov 2022 20:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 04/18] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-5-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> Currently we do not differentiate between the various users of the
> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
> compatible string but, the hardware does have some significant differences
> in the number of clocks.
> 
> To facilitate documenting the clocks add the following compatible strings
> 
> - qcom,apq8064-dsi-ctrl
> - qcom,msm8916-dsi-ctrl
> - qcom,msm8974-dsi-ctrl
> - qcom,msm8996-dsi-ctrl
> - qcom,sc7180-dsi-ctrl
> - qcom,sc7280-dsi-ctrl
> - qcom,sdm630-dsi-ctrl
> - qcom,sdm660-dsi-ctrl
> - qcom,sdm845-dsi-ctrl
> - qcom,sm8250-dsi-ctrl
> 
> Each SoC dtsi should declare "qcom,socname-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../display/msm/dsi-controller-main.yaml      | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 67d08dc338925..0cd2079137b02 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -14,9 +14,20 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - qcom,mdss-dsi-ctrl
> -      - qcom,qcm2290-dsi-ctrl
> +    items:
> +      - enum:
> +          - qcom,apq8064-dsi-ctrl
> +          - qcom,msm8916-dsi-ctrl
> +          - qcom,msm8974-dsi-ctrl
> +          - qcom,msm8996-dsi-ctrl
> +          - qcom,qcm2290-dsi-ctrl
> +          - qcom,sc7180-dsi-ctrl
> +          - qcom,sc7280-dsi-ctrl
> +          - qcom,sdm630-dsi-ctrl
> +          - qcom,sdm660-dsi-ctrl
> +          - qcom,sdm845-dsi-ctrl
> +          - qcom,sm8250-dsi-ctrl
> +      - const: qcom,mdss-dsi-ctrl
>   
>     reg:
>       maxItems: 1
> @@ -146,7 +157,7 @@ examples:
>        #include <dt-bindings/power/qcom-rpmpd.h>
>   
>        dsi@ae94000 {
> -           compatible = "qcom,mdss-dsi-ctrl";
> +           compatible = "qcom,sc7180-dsi-ctrl", "qcom,mdss-dsi-ctrl";

Other examples (from qcom,SOC-mdss.yaml) also must be updated.

>              reg = <0x0ae94000 0x400>;
>              reg-names = "dsi_ctrl";
>   

-- 
With best wishes
Dmitry

