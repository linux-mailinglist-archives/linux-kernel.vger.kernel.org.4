Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA76BC66B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCPG7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCPG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:59:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806152F40
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:59:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z21so3661374edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678949962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GJ4RBxZ712Klo+UmXypi79MzTgIT7iOamcqNsLMPOQ=;
        b=U3RaZU5JK+ElSE3D8SK48II4Cow+x8MfM8vox4NNEvaszAnAB+T94R0KIblOyYoImc
         ABJK5D9H2V8VJJTWQnmbd/xAli6OONjm4yK6431muTNwyMWCPaPYXUYM/10XUY0p5PEp
         ZVsAPB8nMxhxS47/cvck2Z8xb4Y1b3QQd40S3p2KssbS0xqKljj0UoXzAw6rQL4uK7xQ
         6/Y3jeBUB74Bk+5TESn/V8mePAsZbQjPdRRTRlKGPZUJRk3l5ysPxAHKfzsFYMXZxjWN
         xjs2ZEpqTpKrNTa9+Vl5OkbSEAZ14i3f5Y4tbAbWPqrWRoepR0K45sRwPszHDlBwT+3T
         ukEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678949962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GJ4RBxZ712Klo+UmXypi79MzTgIT7iOamcqNsLMPOQ=;
        b=Iiv1Vdz+7n9yaRUOv9cqMWnDrFV9GvJgaSeEvUX+IIXM1aR3HjO0MmsEelptnt/hUY
         As+Vqq7HXauVvWU93Oqa6+3SjX2a5vl2hroOnkBc0MSGIrHMnP344vAtOqeZXbB6M5XV
         1GLWcBG20b0+QvApBEWbQBb/Z/doUb2BtaqZu3T/seJAk0L0agTtvcEh800Q2050ifW5
         21xj5aravAMYiADfLZJnY/OgKMcu6y0bzts6nE/Pzo99L6pRoGbEU0/6LTUpCDWBR+op
         sA+P7wkQ7FZSpiVAj3ApdXyKkh5q4xW0Fp4lpO+nEjGJ8XlHRxYdZHS/b6Cc2bz+TMOj
         v71A==
X-Gm-Message-State: AO0yUKVwUC8T8hnwOBAGsVIZjXU1x3ZIlPA82ezuzfNveU45/1AKvfcP
        PyP3TSDhsuMxEo00gLp+1Z8dwA==
X-Google-Smtp-Source: AK7set9GpyQBtfPlGOriyIwY+B/yPUh5T1CI1WhiR4rhceJZrqhIVM8O+Ucn/hyY8qHeP36jlIqhiw==
X-Received: by 2002:a17:907:2d93:b0:8aa:33c4:87d5 with SMTP id gt19-20020a1709072d9300b008aa33c487d5mr11565369ejc.10.1678949962510;
        Wed, 15 Mar 2023 23:59:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id qh2-20020a170906eca200b008e2dfc6382asm3427107ejb.125.2023.03.15.23.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 23:59:22 -0700 (PDT)
Message-ID: <e46f257b-6a81-ce42-3b93-6cf702571faf@linaro.org>
Date:   Thu, 16 Mar 2023 07:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 01/14] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
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
 <20230223-topic-gmuwrapper-v4-1-e987eb79d03f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-1-e987eb79d03f@linaro.org>
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
> GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
> specified under the GPU node, just like their older cousins. Account
> for that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/gpu.yaml       | 57 ++++++++++++++++++----
>  1 file changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index d4191cca71fb..ac1a9bce2042 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -36,10 +36,7 @@ properties:
>  
>    reg-names:
>      minItems: 1
> -    items:
> -      - const: kgsl_3d0_reg_memory
> -      - const: cx_mem
> -      - const: cx_dbgc
> +    maxItems: 3
>  
>    interrupts:
>      maxItems: 1
> @@ -157,16 +154,58 @@ allOf:
>        required:
>          - clocks
>          - clock-names
> +
>    - if:
>        properties:
>          compatible:
>            contains:
> -            pattern: '^qcom,adreno-6[0-9][0-9]\.[0-9]$'
> -
> -    then: # Since Adreno 6xx series clocks should be defined in GMU
> +            enum:
> +              - qcom,adreno-610.0
> +              - qcom,adreno-619.1
> +    then:
>        properties:
> -        clocks: false
> -        clock-names: false
> +        clock-names:
> +          items:
> +            - const: core
> +              description: GPU Core clock
> +            - const: iface
> +              description: GPU Interface clock
> +            - const: mem_iface
> +              description: GPU Memory Interface clock
> +            - const: alt_mem_iface
> +              description: GPU Alternative Memory Interface clock
> +            - const: gmu
> +              description: CX GMU clock
> +            - const: xo
> +              description: GPUCC clocksource clock

Since you require fixed number of clocks, you also need:

clocks:
  minItems: 6
  maxItems: 6

Best regards,
Krzysztof

