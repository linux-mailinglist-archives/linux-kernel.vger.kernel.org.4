Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABE9653F43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiLVLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiLVLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:47:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5727DF7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:47:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so2379239lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EHYXR6sSgB5vdGVmrtOtKLZP6yhiJpLufZUquvuMTM=;
        b=pn1uImfgSjqommdSMhzsURLzDugGu0FTd7vckLh0eIppD+Hkw6yti7KierhwC+ebZK
         YF138uC/8YhdSSV20XcVnzKKwga9gEKb1OcBV+e08oHnK+JtwEPEbB735yPazKU/no34
         XDTspm8RPAH0vFr4eyWfXAmb8lnd2u+PpHJBrEeIE8NyCKdi4D61hKBafoBeLdnKj14V
         mMeoiV/ttwezyotlUUS5QQqu0dXsDHglxuBhKe49Qn9dWEmYTIa7TYC8tFmAugoJS5/B
         r0XnifxQkvH4tQF90cwlwL7BOj8N0wx2F/WMw04riTFamr+FzXbqRhlobs1jLiN4TepR
         ny4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EHYXR6sSgB5vdGVmrtOtKLZP6yhiJpLufZUquvuMTM=;
        b=W2jv5M9hEgHAm694FaUxF2MPqAPzHEtRHNVOxQKTW39Gfiy9p2OFxAaqlmEj4R3F6H
         xgJzTvURAmpH/hjgxcWjRbUuz/BZlwJ5pXc0h4Q1T5bKx2HKdeda9IdRHbMRhpr16BAE
         IND1EkiI9iKeQBe0v3AskfaJdCL10QH91pd1/aqQJ/V40N++iblwm5H5kUgcfFq0YH2n
         0NOX0Dgn/1oLvG0eeIFAmMfFjx96al/69EtDnTheiZSgKdaEM7+0cOBpghNzoCGNLYnl
         BxDNmZvsKSHFD8MzIGAMa50uv0aI7YLJehdNaMnrxFgOI4p0q9hsovGhZFfn2ivFXdTt
         eE6A==
X-Gm-Message-State: AFqh2kqDalWkgFpLhL3G9SpBuLUdvKDaPyvYdzvSXdjVcqV0yyfs3XTT
        B66XiRvmGO8NoqC/iDstONSvmg==
X-Google-Smtp-Source: AMrXdXvejv9SNAwlLbnZmw6FcDQmaKFCvnGJeIOT1kCLtjTtnwqqgUvY/tTwCYifiYAFep31jdzGkA==
X-Received: by 2002:a05:6512:1582:b0:4b6:e494:a98d with SMTP id bp2-20020a056512158200b004b6e494a98dmr2133911lfb.44.1671709645143;
        Thu, 22 Dec 2022 03:47:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r12-20020ac25a4c000000b00492d064e8f8sm42937lfn.263.2022.12.22.03.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:47:24 -0800 (PST)
Message-ID: <51770a1c-45f6-9f5a-871d-022cd78a0d4b@linaro.org>
Date:   Thu, 22 Dec 2022 12:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 04/21] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
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
 <20221220123634.382970-5-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220123634.382970-5-bryan.odonoghue@linaro.org>
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
> Currently we do not differentiate between the various users of the
> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
> compatible string but, the hardware does have some significant differences
> in the number of clocks.
> 
> To facilitate documenting the clocks add the following compatible strings
> 
> - qcom,apq8064-dsi-ctrl
> - qcom,msm8916-dsi-ctrl
> - qcom,msm8953-dsi-ctrl
> - qcom,msm8974-dsi-ctrl
> - qcom,msm8996-dsi-ctrl
> - qcom,msm8998-dsi-ctrl
> - qcom,sc7180-dsi-ctrl
> - qcom,sc7280-dsi-ctrl
> - qcom,sdm660-dsi-ctrl
> - qcom,sdm845-dsi-ctrl
> - qcom,sm8250-dsi-ctrl
> 
> Each SoC dtsi should declare "qcom,socname-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 6e2fd6e9fa7f0..01afa9e9c4b3c 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -14,9 +14,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,mdss-dsi-ctrl
> -      - qcom,dsi-ctrl-6g-qcm2290
> +    items:
> +      - enum:
> +          - qcom,apq8064-dsi-ctrl
> +          - qcom,msm8916-dsi-ctrl
> +          - qcom,msm8953-dsi-ctrl
> +          - qcom,msm8974-dsi-ctrl
> +          - qcom,msm8996-dsi-ctrl
> +          - qcom,msm8998-dsi-ctrl
> +          - qcom,dsi-ctrl-6g-qcm2290
> +          - qcom,sc7180-dsi-ctrl
> +          - qcom,sc7280-dsi-ctrl
> +          - qcom,sdm660-dsi-ctrl
> +          - qcom,sdm845-dsi-ctrl
> +          - qcom,sm8250-dsi-ctrl

Usual comment: can we keep the list sorted?

Best regards,
Krzysztof

