Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D26BC693
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPHKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCPHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:10:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF1E3B0CA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:10:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so3757176edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678950593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DskVPGyg4XTBFcAu4u2wBMvd2V9vUe35DTxUMiqKo0=;
        b=Oii4tgqhM1+uytgl/uCtxEcAltbCiuY08aN8SwZk4cCYRC1mtyU92yp6QGwJaMR+69
         r2LeC8f3Pnt7+BBfqEX0Y2mR0KYes6/bpYwuaVes44qLaD3Yoidm5RLYgytOqFqnS54E
         bbxVDZhcftxAPs9cr3DplBamx/puAjOIABbLZR2V4/pPwyR/ws8N73HBXb0YDIo9mne6
         twQQ15hw8kjf+UkJZZK4x30B+ItMvq+3k2a31brrxDdHF6Nznf1V++OM0ARYBboE03Nb
         7whTxyvSJnd9wCfPtHRV2Pp2tv+7/3l7SMhlI9SkFiSclryfcOuK3xxpB9l4zNyg17zw
         Wvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DskVPGyg4XTBFcAu4u2wBMvd2V9vUe35DTxUMiqKo0=;
        b=z9IqXmoXSMHGB4wFD+xUdVKoErY3oWS5z2EiUOa0lVHSkFwWWJpmHqolapVxLJ7nOV
         rZ88hiBbyO2J7GwuSh/5W+MLW28ju0uekXmibjpGSNhMpCqHkF5BwKAk57yIVG250ZiM
         GkfHSsEuIpVDSPgK964KT3CPHCen/17ZbDB91fejPsoXMfLgKsWw6RrLJdGqAsVBlHgu
         1R8lLeuw9QGGbqyJIA5XkYe+tu6ykHTRrTcOg2PQfp2zCFlTaUcHeMLqUVrghUcyo+0F
         zGtL4QWhCg/xqo+qtUV4XW52y5oWBM4pyuXc9jnT39rjN8nhDv03SV0l6fUVIOLrKxJZ
         /mww==
X-Gm-Message-State: AO0yUKXLLhhw1s9AlqZIcDuXKx4aK16Y0BD576l89qzKbkGNMSv0GX1N
        tzE3mON9Kmmio16C/FhFPc8pog==
X-Google-Smtp-Source: AK7set8+NBsRtQMHynOv/FiocIqAaxXx01Y0YdEP/h944/7U8HpnrYGeH2MUJuKARg20j4XUNIwrZQ==
X-Received: by 2002:aa7:de82:0:b0:4fd:2b04:6e8b with SMTP id j2-20020aa7de82000000b004fd2b046e8bmr5524719edv.29.1678950593268;
        Thu, 16 Mar 2023 00:09:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id e20-20020a50d4d4000000b004fbf6b35a56sm3363840edj.76.2023.03.16.00.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:09:52 -0700 (PDT)
Message-ID: <04f9336b-2a49-ca3f-fd28-1f04db78d2bd@linaro.org>
Date:   Thu, 16 Mar 2023 08:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 02/14] dt-bindings: display/msm/gmu: Add GMU wrapper
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
 <20230223-topic-gmuwrapper-v4-2-e987eb79d03f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-2-e987eb79d03f@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 14/03/2023 16:28, Konrad Dybcio wrote:
> The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
> we'd normally assign to the GMU as if they were a part of the GMU, even
> though they are not". It's a (good) software representation of the GMU_CX
> and GMU_GX register spaces within the GPUSS that helps us programatically
> treat these de-facto GMU-less parts in a way that's very similar to their
> GMU-equipped cousins, massively saving up on code duplication.
> 
> The "wrapper" register space was specifically designed to mimic the layout
> of a real GMU, though it rather obviously does not have the M3 core et al.
> 
> To sum it all up, the GMU wrapper is essentially a register space within
> the GPU, which Linux sees as a dumbed-down regular GMU: there's no clocks,
> interrupts, multiple reg spaces, iommus and OPP. Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/gmu.yaml       | 49 ++++++++++++++++------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> index ab14e81cb050..021373e686e1 100644
> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> @@ -19,16 +19,18 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
> -      - const: qcom,adreno-gmu
> +    oneOf:
> +      - items:
> +          - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
> +          - const: qcom,adreno-gmu
> +      - const: qcom,adreno-gmu-wrapper
>  
>    reg:
> -    minItems: 3
> +    minItems: 1
>      maxItems: 4
>  
>    reg-names:
> -    minItems: 3
> +    minItems: 1
>      maxItems: 4
>  
>    clocks:
> @@ -44,7 +46,6 @@ properties:
>        - description: GMU HFI interrupt
>        - description: GMU interrupt
>  
> -
>    interrupt-names:
>      items:
>        - const: hfi
> @@ -72,14 +73,8 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - clocks
> -  - clock-names
> -  - interrupts
> -  - interrupt-names
>    - power-domains
>    - power-domain-names
> -  - iommus
> -  - operating-points-v2
>  
>  additionalProperties: false
>  
> @@ -216,6 +211,27 @@ allOf:
>              - const: cxo
>              - const: axi
>              - const: memnoc

Blank line (you added such between ifs in previous patch)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

