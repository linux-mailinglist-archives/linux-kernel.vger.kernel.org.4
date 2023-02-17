Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612B69AA62
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBQLa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBQLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:30:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA065686
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:30:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id dn12so10808612edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBs3G+5rDOAD7jz6/mROi4c/cabIc4TAXJ4KNHRdV7Y=;
        b=xdjshueeGfdfkVtEqdmdj/CHWIs7xaE5c4jvbsQpmt2UQWO3DWcFWQDXbOqXyjLzmg
         QDxt7nWPHa8d9XZdU8QxjONPQaMrRNOotXOzqPTCtb0lbk0bQx/nvv/cNeX/t6fjBMNc
         bT3IVdfOZ/8KFRyPBs+4Ak5T4wb/iM73iES1CCLgraAC2IC67fK2vmWUMxlcyRMHICIR
         cy+SVJSfHFgUnWg004CIIBWvxuwVBetSk9TNh+M5k7iKsVR6Ysyq9aSBn6c+Q4jAaid9
         eD/GiYXcMF1xA5R5KtwAA7Rj2IbgVobOB7p4+64O8WENZ4tWVSmum8Ui7/VfUJ7oIMwM
         XfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBs3G+5rDOAD7jz6/mROi4c/cabIc4TAXJ4KNHRdV7Y=;
        b=yRshEiOe/7KOe6Lfev/pNDKZO0BNiFoXruJfkdUWG24x611Gm0L9zFVuaPGh+ngsUg
         N/rLwCS/4qSea0Dz+MN97TplqhCMf/MMzKfVWSFZieva7wZXJ9mEG3V9rWzk4FljusRZ
         ksC5khH20fsWFDyABij9f1ZzlEI0BcBoXEvgaIW7Ab88jU1lJ3EAE/U1TozV1h2BtgXD
         cUATNCF97lTImHECkGdPrSl1FlSQeLxk08yOx5rWL1uyMS0xSrgi6WPBflNmQ7AXPmYP
         b4NFpZ/GQ8559moOIQ0JivP9IKmR3U0DevkkaVCttEEW4TWq00q3DfkwlTDfnXbo1wfD
         kPog==
X-Gm-Message-State: AO0yUKWXoQp04eDWFnHHRHVzbEL5yfB5dQF2TNUmkwdokwpTB0AulC64
        3rdvSKSVTOL7nQSuIOwmeexDJw==
X-Google-Smtp-Source: AK7set84zZR/iqCf2WhRExqzAoyqtlMbTwfj3Shf6m/+1SOuGTvZ+sZaA/bAqfZcJy4eRAzK/G8eaw==
X-Received: by 2002:a05:6402:695:b0:4aa:a0ed:e373 with SMTP id f21-20020a056402069500b004aaa0ede373mr1235952edy.7.1676633406486;
        Fri, 17 Feb 2023 03:30:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a50c44a000000b004ad1815f3e9sm2110588edf.97.2023.02.17.03.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:30:06 -0800 (PST)
Message-ID: <c49904be-d842-fc12-a443-17f229d53166@linaro.org>
Date:   Fri, 17 Feb 2023 12:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111316.306241-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217111316.306241-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 12:13, Konrad Dybcio wrote:
> SM6115 previously erroneously added just "qcom,dsi-ctrl-6g-qcm2290",
> without the generic fallback. Fix the deprecated binding to reflect
> that.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Depends on (and should have been a part of):
> 
> https://lore.kernel.org/linux-arm-msm/20230213121012.1768296-1-konrad.dybcio@linaro.org/
> 
> v1 -> v2:
> New patch
> 
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml     | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 41cdb631d305..ee19d780dea8 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -37,7 +37,6 @@ properties:
>        - items:

If this way stays, drop the items as it is just an enum.

>            - enum:
>                - qcom,dsi-ctrl-6g-qcm2290
> -          - const: qcom,mdss-dsi-ctrl

Wasn't then intention to deprecate both - qcm2290 and mdss - when used
alone?


Best regards,
Krzysztof

