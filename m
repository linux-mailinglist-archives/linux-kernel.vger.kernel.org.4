Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDEF6A1B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBXLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBXLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:51:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49869FF30
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:51:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i9so17405073lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677239485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnexSMd+XVoyj7y7yaOeBmQu7EBkAmuDHGXQa8H9Mtw=;
        b=pw5jsbH6Ahef7qZKvgF3EtWIxOg45xrKzGuv2DkJzX/meHHDnjUelN4xqa08NuR2Tz
         nyC+9kjJXnRTY0v+0wha6BAHyB6bgzSRaehem/88QFTzvOi/B+kMM3MBN9tD3LMQ7Qr9
         s+3+Frj3QYO7MGMXlpV6mebZl+VujPqZJgBP5laTCM99SnAhtLLFXMX/vnp7h/0cGsXK
         Ezv6W0u81c9yXmbluxS5WTj9ABCHi7RXwDrRL9kCZY/IC4QEMayF0STDLIezqy7cXnKu
         UOi1Ug4Ke2PRMehSgjU0fO/YhdulY7osNGhrkOov58zIpm7CSf2EhcTehGzPdwVHpwwY
         j06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677239485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnexSMd+XVoyj7y7yaOeBmQu7EBkAmuDHGXQa8H9Mtw=;
        b=ke7fpDoh4DLnzhjdajYytzmkhtj20zb52SVwYa2X/taLQ1h/k63oN8vJjh/kVTdLSC
         0DBBOomdaPq1DJV+Gb3EHjSVPeP414pjrPFIWvV4Apq2sGgmsHh5b3evzZDaNqMmyfnd
         r9kanVgUxvfO8hd65lHptquGyg+h8XvHu6bIs1BQM7tQc5LoEy6nXQ87XLdkmFqUFBQy
         uR+AK6k3QGsgfA3IP1iWnpMbBtr2pNTQFXNIeT242i3kCaTrFRQfAlLpmEWdet815XRe
         h5lvlJn8bSLykVbdOO3DsPZvff3SgrN4SMVY/DRd5PYC/deKyOaBtGqDxy6LYUBys7nP
         ucBg==
X-Gm-Message-State: AO0yUKV0s6pgNxy6R+q+nW0AostXJ0b9U12K+VNEIKt2PgBMHGcdfXyV
        Ss+0E8/Hv6VTpmBna5lMxoIcEg==
X-Google-Smtp-Source: AK7set/FkVC3ts6OtmMUhOGLdSYYVCrglgLPa706kH6YP7Eze6YmEYBTVypJE8rX+86gHX2+wzb/Yg==
X-Received: by 2002:a05:6512:3d90:b0:4da:f379:9f60 with SMTP id k16-20020a0565123d9000b004daf3799f60mr5682703lfv.33.1677239485520;
        Fri, 24 Feb 2023 03:51:25 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id l13-20020a19c20d000000b004dd6c32532bsm576631lfc.263.2023.02.24.03.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:51:25 -0800 (PST)
Message-ID: <a28c4e67-78b4-21b5-7094-9953316576b2@linaro.org>
Date:   Fri, 24 Feb 2023 12:51:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/15] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
 <20230223-topic-gmuwrapper-v3-1-5be55a336819@linaro.org>
 <c3376575-c24f-18a3-1d8b-c3d67f072287@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c3376575-c24f-18a3-1d8b-c3d67f072287@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 12:17, Krzysztof Kozlowski wrote:
> On 23/02/2023 13:06, Konrad Dybcio wrote:
>> GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
>> specified under the GPU node, just like their older cousins.
>> Account for that.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/display/msm/gpu.yaml       | 63 ++++++++++++++++++----
>>  1 file changed, 53 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index d4191cca71fb..e6d3160601bc 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -36,10 +36,7 @@ properties:
>>  
>>    reg-names:
>>      minItems: 1
>> -    items:
>> -      - const: kgsl_3d0_reg_memory
>> -      - const: cx_mem
>> -      - const: cx_dbgc
>> +    maxItems: 3
>>  
>>    interrupts:
>>      maxItems: 1
>> @@ -147,26 +144,72 @@ allOf:
>>                  description: GPU Alternative Memory Interface clock
>>                - const: gfx3d
>>                  description: GPU 3D engine clock
>> +              - const: gmu
>> +                description: CX GMU clock
>>                - const: rbbmtimer
>>                  description: GPU RBBM Timer for Adreno 5xx series
>>                - const: rbcpr
>>                  description: GPU RB Core Power Reduction clock
>> +              - const: xo
>> +                description: GPUCC clocksource clock
>>            minItems: 2
>> -          maxItems: 7
>> +          maxItems: 9
> 
> Your commit says A6xx but this is a3-5xx. I don't understand this change.
Right, it's a leftover unrelated hunk. I'll remove it.

> 
>>  
>>        required:
>>          - clocks
>>          - clock-names
>> +
>>    - if:
>>        properties:
>>          compatible:
>>            contains:
>> -            pattern: '^qcom,adreno-6[0-9][0-9]\.[0-9]$'
>> -
>> -    then: # Since Adreno 6xx series clocks should be defined in GMU
>> +            enum:
>> +              - qcom,adreno-610.0
>> +              - qcom,adreno-619.1
>> +    then:
>>        properties:
>> -        clocks: false
>> -        clock-names: false
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +              description: GPU Core clock
>> +            - const: iface
>> +              description: GPU Interface clock
>> +            - const: mem_iface
>> +              description: GPU Memory Interface clock
>> +            - const: alt_mem_iface
>> +              description: GPU Alternative Memory Interface clock
>> +            - const: gmu
>> +              description: CX GMU clock
>> +            - const: xo
>> +              description: GPUCC clocksource clock
>> +
>> +        reg-names:
>> +          minItems: 1
>> +          items:
>> +            - const: kgsl_3d0_reg_memory
>> +            - const: cx_dbgc
>> +
>> +      required:
>> +        - clocks
>> +        - clock-names
>> +    else:
>> +      if:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              pattern: '^qcom,adreno-6[0-9][0-9]\.[0-9]$'
>> +
>> +      then: # Starting with A6xx, the clocks are usually defined in the GMU node
> 
> The comment is not accurate anymore.
I'll argue the semantics, they are still "usually" defined
in the GMU node..

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
