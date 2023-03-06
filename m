Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC96ABA7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCFJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCFJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:54:42 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64221A27
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:54:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h3so8934369lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678096479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIlgMgx4GC7LDA70SAaD5cK7DGGQZmITxjE2Ge49+kU=;
        b=vdcts+WbobnyEDJbIN+wXxsZ2qfWdS/GOfLuCC/rmeMZRDAJ7d10ljd1wrvy3CU0y1
         L+3QGxMvJgVySq27pa2cK5WaUkrVDw9dj10+7BNqlH3d16ZMcNYgWTI6GfxDXfYgn3VT
         fW0i3qo98cher9ZorHaXHIZdcSBTpV8WRSVb9kvp69ahi113hV9jP2yTLqzqHs1OyD/X
         Ii+eDuH7WT450rLNSPvlVPtdpwaVXOkxKkBlicyoDFUmpKfHLgWEhSLzbBf7+0Av6nTK
         JoSY5HNu0NKiDerIuqw4BjQe+jo2KA1xdpX7h3hs3ICMua9Gt1ulDialSjG/xxJf72qK
         siog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678096479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIlgMgx4GC7LDA70SAaD5cK7DGGQZmITxjE2Ge49+kU=;
        b=dCvwenrQ/xVVoa5J1yg8XIH5VTxqOfqUuG/Kg0WCu73fmbN2jvdDfW5/+kEhvh3ImL
         oGWalHYQk2cwmKtq5vq2+nKyvT80Y+5X1l22svkpXnfERH+CXcWnB9BdguLa1VVbajUs
         uYIPSkCuOuD16eY2nmKPrQvHeS/TuT71g+TAqSkmCC1mpg1UALHsDYF7RYqjtQz53C9i
         heemb9SBI91rTnugWlxwBbJE0s0+35Gusw6OwFZfpZo02oV8tpp4uYFmRdgD6L9j+ajt
         4fmTGjyyt62EMXJ+uhAJtI8NUaq6VI9ojhb3VTq9/8d/rxgy/OzJ8EF+Laj4dZEt5HzB
         xDxA==
X-Gm-Message-State: AO0yUKWE9qAtU2KjyD+8IoI6TI4dGKSf9OOU0RI2y8sjG9+y5JgvyN6l
        cSQzSifzp+45PJhv4DL2ScenZw==
X-Google-Smtp-Source: AK7set/qlPIMi2iBv9G4/ehNBJuY1m0NOP6QMZ7s6Vyfmdsj4JIY0n1S+2F1igceddstYxcbPL9PeQ==
X-Received: by 2002:a2e:7308:0:b0:293:4e6d:9194 with SMTP id o8-20020a2e7308000000b002934e6d9194mr2733124ljc.24.1678096479180;
        Mon, 06 Mar 2023 01:54:39 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u28-20020a2ea17c000000b002946a078ad6sm1629709ljl.125.2023.03.06.01.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:54:38 -0800 (PST)
Message-ID: <bd4caf3d-3994-da96-2d3f-175d429136d1@linaro.org>
Date:   Mon, 6 Mar 2023 10:54:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 global registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
 <20230304-topic-ddr_bwmon-v1-1-e563837dc7d1@linaro.org>
 <0e74ad9a-2333-ea9e-b569-1bf8c965b217@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0e74ad9a-2333-ea9e-b569-1bf8c965b217@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.03.2023 15:52, Krzysztof Kozlowski wrote:
> On 04/03/2023 16:39, Konrad Dybcio wrote:
>> The BWMON has two sets of registers: one for handling the monitor itself
>> and one called "global", which we didn't care about before, as on newer
>> SoCs it was made contiguous with (but not the same as) the monitor's
>> register range. Describe it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 28 ++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> index 12a0d3ecbabb..6dd0cb0a1f43 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> @@ -49,9 +49,13 @@ properties:
>>      type: object
>>  
>>    reg:
>> -    # BWMON v4 (currently described) and BWMON v5 use one register address
>> -    # space.  BWMON v2 uses two register spaces - not yet described.
>> -    maxItems: 1
>> +    # BWMON v5 uses one register address space, v1-v4 use one or two.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>  required:
>>    - compatible
>> @@ -63,6 +67,21 @@ required:
>>  
>>  additionalProperties: false
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          const: qcom,msm8998-bwmon
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +
>> +        reg-names:
>> +          items:
>> +            - const: monitor
>> +            - const: global
> 
> else:
>   reg:
>     maxItems: 1
> 
> and either disallow reg-names or move it to the top-level.
Disallowing makes more sense in this case imo, will do.

> 
>> +
>>  examples:
>>    - |
>>      #include <dt-bindings/interconnect/qcom,sdm845.h>
>> @@ -70,7 +89,8 @@ examples:
>>  
>>      pmu@1436400 {
>>          compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
>> -        reg = <0x01436400 0x600>;
>> +        reg = <0x01436400 0x600>, <0x01436300 0x200>;
> 
> That's not correct for sdm845. It's only one address space for sdm845.
Ack, leftover from an old version again..

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
