Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EAD6C0C53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCTIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCTIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:36:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409671B567
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:36:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so43410369edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679301367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXj7AxGe8a/AWVZK9V6ITMJ6vFa0cOONXWJXMR9eH6M=;
        b=ZQhU+h+p+BSi1x7xKlAkzSzjTnRY8ptpMPTRGk8YvWOgg0b+/aYcwerQJHi1ZHd+z8
         qwwCUJsC0K0/yb7Xz0Omts3aL/rg+/jOCtWGO6bmkSqbdBDqdYWbKnaK5bVubZ1pPEIN
         DZtvKYmzGG4xQEGvlN1f3HdYtKTlTRuYoz5gNPq6vI6yEp1xaV0B//MjZIeUZGyoxQkj
         kxgvWTmgAbJi1rHZqY5x4XAfCBilV1PCVogq5t1FTeeZHES5hKTDW/Z8JffY9w0MHtT+
         AzQxlbCK6yg/n32kMCwC6rDWc88qo52ruUtdU8okzrbqkNDmB1EnEd9yjCBzAkb6vvDO
         wF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679301367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXj7AxGe8a/AWVZK9V6ITMJ6vFa0cOONXWJXMR9eH6M=;
        b=jPjUIXGTRxCcc4A98X31T5ANtQxtw5V5POCDQv32A6aa6B+4G4UvOSkul9fNz0Ddac
         bL5cmuKngZGQ3KMEb3PqBEzdqO7ZYnhcFuGT7DFE1gNLwFeDGcinHHDnibXZGO/N7neB
         +njedlDS79G+GZwikkTIXxhyFO8hC/zhnhuNSZ7kmw1YwZAotv3z37q+mMNENCdzQrqw
         5WFx1E37vfyMM/9wis1gEBKwQrKjrB8SiIEhpU4ITNjV+EIOQZDnF7J4R/VwsdSYg2Tl
         GbqeqSqqVZsYTDi9GGeK7a6LyuLNjwExZdNNLr0oLYAG7apbbs8qYlnfg74L0two1/CY
         ulmw==
X-Gm-Message-State: AO0yUKXxbh8rF4Oy1o/eEwG5NHIfEU9o3L4M1WjO2UXswOwY4SfZ+zg8
        9JBfY0M1S9VkZ1O9azznGaJjrICAMCVqhLLjWhI=
X-Google-Smtp-Source: AK7set+23hCkEkPd4JCHw6bubA3/j+6AoHuaXJw9oOpouh+B0Jv9DY4FNJBSb5CMIfZXywHy9tZ64w==
X-Received: by 2002:a05:6402:53:b0:4fb:4f1a:d4e1 with SMTP id f19-20020a056402005300b004fb4f1ad4e1mr10966091edu.37.1679301366716;
        Mon, 20 Mar 2023 01:36:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4428:8354:afb6:2992? ([2a02:810d:15c0:828:4428:8354:afb6:2992])
        by smtp.gmail.com with ESMTPSA id r29-20020a50d69d000000b004c2158e87e6sm4448985edi.97.2023.03.20.01.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 01:36:06 -0700 (PDT)
Message-ID: <8c5a7421-2948-674d-91a0-9cafe336401b@linaro.org>
Date:   Mon, 20 Mar 2023 09:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: starfive: syscon: Add optional
 patternProperties
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-4-xingyu.wu@starfivetech.com>
 <1f352445-4677-e33b-be14-c76bd7ffa188@linaro.org>
 <45221a1c-dc01-2759-3e32-658636625529@starfivetech.com>
 <a6b9bab2-4151-c811-85ff-2424866e21d8@linaro.org>
 <ce674ea9-41ec-2862-c39c-207f0b6c45a2@starfivetech.com>
 <a65697f4-0a75-23e2-517c-2784b0c382bc@linaro.org>
 <2eb0380e-bbb7-83fd-3916-9bdd8b068334@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2eb0380e-bbb7-83fd-3916-9bdd8b068334@starfivetech.com>
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

On 20/03/2023 09:26, Xingyu Wu wrote:
> On 2023/3/20 15:40, Krzysztof Kozlowski wrote:
>> On 20/03/2023 08:29, Xingyu Wu wrote:
>>> On 2023/3/20 14:37, Krzysztof Kozlowski wrote:
>>>> On 20/03/2023 04:54, Xingyu Wu wrote:
>>>>> On 2023/3/19 20:28, Krzysztof Kozlowski wrote:
>>>>>> On 16/03/2023 04:05, Xingyu Wu wrote:
>>>>>>> Add optional compatible and patternProperties.
>>>>>>>
>>>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>>>> ---
>>>>>>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 39 ++++++++++++++++---
>>>>>>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>>>> index ae7f1d6916af..b61d8921ef42 100644
>>>>>>> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>>>> @@ -15,16 +15,31 @@ description: |
>>>>>>>  
>>>>>>>  properties:
>>>>>>>    compatible:
>>>>>>> -    items:
>>>>>>> -      - enum:
>>>>>>> -          - starfive,jh7110-aon-syscon
>>>>>>> -          - starfive,jh7110-stg-syscon
>>>>>>> -          - starfive,jh7110-sys-syscon
>>>>>>> -      - const: syscon
>>>>>>> +    oneOf:
>>>>>>> +      - items:
>>>>>>> +          - enum:
>>>>>>> +              - starfive,jh7110-aon-syscon
>>>>>>> +              - starfive,jh7110-stg-syscon
>>>>>>> +              - starfive,jh7110-sys-syscon
>>>>>>> +          - const: syscon
>>>>>>> +      - items:
>>>>>>> +          - enum:
>>>>>>> +              - starfive,jh7110-aon-syscon
>>>>>>> +              - starfive,jh7110-stg-syscon
>>>>>>> +              - starfive,jh7110-sys-syscon
>>>>>>> +          - const: syscon
>>>>>>> +          - const: simple-mfd
>>
>> BTW, this also looks wrong. You just said that clock controller exists
>> only in few variants. Also, why sometimes the same device  goes with
>> simple-mfd and sometimies without? It's the same device.
> 
> Oh yes, If modified to:
> 
> oneOf:
>       - items:
>           - enum:
>               - starfive,jh7110-aon-syscon
>               - starfive,jh7110-stg-syscon
>           - const: syscon
>       - items:
>           - const: starfive,jh7110-sys-syscon
>           - const: syscon
>           - const: simple-mfd
> 
> Or:
> 
>      - minItems: 2
>        items:
>          - enum:
>              - starfive,jh7110-aon-syscon
>              - starfive,jh7110-stg-syscon
>              - starfive,jh7110-sys-syscon
>          - const: syscon
>          - const: simple-mfd
> 
> 
> Which one is better?

If aon and stg are not supposed to have children, then only the first is
correct. It's not which is better, the second is not really correct in
such case.

Best regards,
Krzysztof

