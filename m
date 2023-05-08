Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE4C6FA26A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjEHIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:38:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF89100EB
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:38:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4effb818c37so4802886e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683535130; x=1686127130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7M+LYvpo0uL6DRxOtraYhuPAgoiRvl+qFGnzZSo79f4=;
        b=w3GXeMtyzwuRY7sysKSaMD++ZLTRpHQQAxAhiRO+cBGtPVZwBPcfj+CVxdPugtuHtj
         e0jGozykIPHw5c9oZwVLX8uwlyUdbj2k8HVOcEaKtDonm73JFiFk0vOZ5QpvC/lbEJjZ
         gNw9+uexlJCgR0LjtLiJy4hcGh2PNmrb91VcwpuP4LKMNMiJTjIdEVIOKJMm7Ah7Vdva
         UZ0Ukpm0CB3oJ9RMa82eQ8RCq4FLpyjPIy6iF6bXapEF92JcVGEFZY9jpyX5pJVij2h1
         bwcvGE7KevjjBG1wbaIWnL4K4Hh7bdXdH499QfbJ0qKzJFa/P2oOJye7I9Y1IMX46t/m
         3GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683535130; x=1686127130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M+LYvpo0uL6DRxOtraYhuPAgoiRvl+qFGnzZSo79f4=;
        b=jWbs8xln7FcsW38HAwP0f/DO1VkCESpfCjbdUSx29wKCm6I+0BVbZXUP0XsDBh47Lm
         VKK8msvPy4rv2MAiwkAgZNF77Fb/4B7gfZrKBsq7NYtTeAaT4g7QKcvxMlvkCs3oI9uA
         woYBLE7+ECZVipZN/2EqQNZODhEFddNK7f1aa16AAcYLPQM45NZfWTc0J/wVSiN8BWti
         fdpaBDXLxqIvudJMKDcbmfGhmGtN1ad6qrjsYxQbykCKgAPGEEc7gsO6VcZyNiH+w4oM
         jKIvCeyfFSk+PqIsLC7mjQZluJeCKCN6wFM2OqhidOoFhi7nwtnQWaBA7U2l0xwkR2DU
         B90A==
X-Gm-Message-State: AC+VfDynUjlS8ooeuO3PRjx6zvqtWVu3KYPYUa77uQJmCjfbUyhoCxpg
        zdq8tBhLvsWvysfUIcUmzvYZ3A==
X-Google-Smtp-Source: ACHHUZ7BOe90sL4z+719tAJbqmfFOlSnY6F/doGifg/JqPAqaNHcSKmqP/u6JkByUE0L1pZ0R1Ag1g==
X-Received: by 2002:ac2:52a9:0:b0:4f1:4602:fb63 with SMTP id r9-20020ac252a9000000b004f14602fb63mr2201009lfm.41.1683535130246;
        Mon, 08 May 2023 01:38:50 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c5-20020a05651221a500b004f143c11cbcsm1227074lft.51.2023.05.08.01.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:38:49 -0700 (PDT)
Message-ID: <faa64d3d-48bd-b6db-535e-05d6d50aebd7@linaro.org>
Date:   Mon, 8 May 2023 10:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 03/12] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6350 and SM6375
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
 <20230411-topic-straitlagoon_mdss-v3-3-9837d6b3516d@linaro.org>
 <31147c6d-e77a-8abd-0b55-73ead2385bb9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <31147c6d-e77a-8abd-0b55-73ead2385bb9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 10:14, Krzysztof Kozlowski wrote:
> On 05/05/2023 23:40, Konrad Dybcio wrote:
>> SC7180, SM6350 and SM6375 use a rather similar hw setup for DPU, with
>> the main exception being that the last one requires an additional
>> throttle clock.
>>
>> It is not well understood yet, but failing to toggle it on makes the
>> display hardware stall and not output any frames.
>>
>> Document SM6350 and SM6375 DPU.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/msm/qcom,sc7180-dpu.yaml      | 23 +++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
>> index 1fb8321d9ee8..630b11480496 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
>> @@ -13,7 +13,10 @@ $ref: /schemas/display/msm/dpu-common.yaml#
>>  
>>  properties:
>>    compatible:
>> -    const: qcom,sc7180-dpu
>> +    enum:
>> +      - qcom,sc7180-dpu
>> +      - qcom,sm6350-dpu
>> +      - qcom,sm6375-dpu
>>  
>>    reg:
>>      items:
>> @@ -26,6 +29,7 @@ properties:
>>        - const: vbif
>>  
>>    clocks:
>> +    minItems: 6
>>      items:
>>        - description: Display hf axi clock
>>        - description: Display ahb clock
>> @@ -33,8 +37,10 @@ properties:
>>        - description: Display lut clock
>>        - description: Display core clock
>>        - description: Display vsync clock
>> +      - description: Display core throttle clock
>>  
>>    clock-names:
>> +    minItems: 6
>>      items:
>>        - const: bus
>>        - const: iface
>> @@ -42,6 +48,7 @@ properties:
>>        - const: lut
>>        - const: core
>>        - const: vsync
>> +      - const: throttle
>>  
>>  required:
>>    - compatible
>> @@ -52,6 +59,20 @@ required:
>>  
>>  unevaluatedProperties: false
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          const: qcom,sm6375-dpu
> 
> And the two other variants? Is the clock valid there or not? If not
> really, then you should have else: with maxItems: 6.
Oh right!

> 
>> +
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 7
>> +
>> +        clock-names:
>> +          minItems: 7
> 
> If there is going new version - put allOf: before
> unevaluatedProperties:. Otherwise it is fine.
Thanks!

Konrad
> 
>> +
>>  examples:
>>    - |
>>      #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
>>
> 
> Best regards,
> Krzysztof
> 
