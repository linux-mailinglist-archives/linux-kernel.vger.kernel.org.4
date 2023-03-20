Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB26C0B81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCTHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCTHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:41:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811F2310B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:41:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t5so6152714edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679298058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEJwPUcj30LR1Jvi4gq3x/eDVKkkFRtCJxEfs4FDdm4=;
        b=K+smoDKcwnMxZrFNrJhdgowPDNaNTLyYz6zlEKxBEqQoEG3U+3ow0kJxlZknQwrGMB
         u04dEEYkv//4yL//8tVkINm9Ieh7vEfPxMPVPRU5Zxh3K6ves71YXuJonexO5/k0eruR
         Dw4HDFJYDAT8EGmLhsDNJTcXS/1bhC560OysoRkAxlvuoUCC4qx2VzVba6gN432Z3iCx
         JPMK8sefwNUC70ZxMHds79JkwuendtkP6KHYKc+KaAA9Yl+K1NY1bS7zb+5+KNlQ49cL
         5foHjP4G5g5hHiEThk8XHd+37eot8QkVHdL358kCzBtbTA7CKD9Shn76OLsosAJ7tU9U
         BLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679298058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEJwPUcj30LR1Jvi4gq3x/eDVKkkFRtCJxEfs4FDdm4=;
        b=h4vc53SS7i12bC6pxLn4Mcdazw1x0ZwzxoN6uPlRpgCafQxZX/TDPw7aa1kPF7AWLf
         jT+TUtlnpmDhwSllcN9Vk2R5msdT0lPYfH7eMVMoQW0HAikA523gPkhzXlM4fk5m/nO7
         sx/K2VGTaCUuwdrGyWIoJTCxRZr1dJJyt+L8tq/wsgk037YHhwcyu1c05/6COyxqxZ2c
         TtW/I4DeirRfkIbh5hzqShdIKYbQpe2A2gbLv2KooM9/qkWQZGn/dJcw9w/6dUJd/xfp
         JIhbd/cX6GWgw8GaZIR5ZxNAzaO6u9u3u8z/WsHSql/ZytmBusnRseoK/L0KCXroBQQg
         8gAg==
X-Gm-Message-State: AO0yUKX3dsJtuhuxjYtuRiveeCXEeL8CTQj0EK0EtIdUVjN3ZZm3fx57
        WDv23BMN6C1RIo7FJw9jft1pzQ==
X-Google-Smtp-Source: AK7set8K83XcDqgvWGsUDkVZexSnqd6rwD5aeLXBfdzVWwJ7+1NQq8zSCs4BDTyss9P7wWoUZ3G6Lw==
X-Received: by 2002:a17:906:1f53:b0:931:91a:fa4f with SMTP id d19-20020a1709061f5300b00931091afa4fmr8808137ejk.41.1679298058663;
        Mon, 20 Mar 2023 00:40:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4428:8354:afb6:2992? ([2a02:810d:15c0:828:4428:8354:afb6:2992])
        by smtp.gmail.com with ESMTPSA id kj2-20020a170907764200b009324717b9f3sm3513196ejc.71.2023.03.20.00.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 00:40:58 -0700 (PDT)
Message-ID: <a65697f4-0a75-23e2-517c-2784b0c382bc@linaro.org>
Date:   Mon, 20 Mar 2023 08:40:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: starfive: syscon: Add optional
 patternProperties
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
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
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-4-xingyu.wu@starfivetech.com>
 <1f352445-4677-e33b-be14-c76bd7ffa188@linaro.org>
 <45221a1c-dc01-2759-3e32-658636625529@starfivetech.com>
 <a6b9bab2-4151-c811-85ff-2424866e21d8@linaro.org>
 <ce674ea9-41ec-2862-c39c-207f0b6c45a2@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ce674ea9-41ec-2862-c39c-207f0b6c45a2@starfivetech.com>
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

On 20/03/2023 08:29, Xingyu Wu wrote:
> On 2023/3/20 14:37, Krzysztof Kozlowski wrote:
>> On 20/03/2023 04:54, Xingyu Wu wrote:
>>> On 2023/3/19 20:28, Krzysztof Kozlowski wrote:
>>>> On 16/03/2023 04:05, Xingyu Wu wrote:
>>>>> Add optional compatible and patternProperties.
>>>>>
>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>> ---
>>>>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 39 ++++++++++++++++---
>>>>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>> index ae7f1d6916af..b61d8921ef42 100644
>>>>> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>> @@ -15,16 +15,31 @@ description: |
>>>>>  
>>>>>  properties:
>>>>>    compatible:
>>>>> -    items:
>>>>> -      - enum:
>>>>> -          - starfive,jh7110-aon-syscon
>>>>> -          - starfive,jh7110-stg-syscon
>>>>> -          - starfive,jh7110-sys-syscon
>>>>> -      - const: syscon
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - starfive,jh7110-aon-syscon
>>>>> +              - starfive,jh7110-stg-syscon
>>>>> +              - starfive,jh7110-sys-syscon
>>>>> +          - const: syscon
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - starfive,jh7110-aon-syscon
>>>>> +              - starfive,jh7110-stg-syscon
>>>>> +              - starfive,jh7110-sys-syscon
>>>>> +          - const: syscon
>>>>> +          - const: simple-mfd

BTW, this also looks wrong. You just said that clock controller exists
only in few variants. Also, why sometimes the same device  goes with
simple-mfd and sometimies without? It's the same device.

>>>>>  
>>>>>    reg:
>>>>>      maxItems: 1
>>>>>  
>>>>> +patternProperties:
>>>>> +  # Optional children
>>>>> +  "pll-clock-controller":
>>>>
>>>> It's not a pattern.
>>>
>>> Does it use 'properties' instead of 'patternProperties'?
>>
>> Yes.
>>
>>>
>>>>
>>>> Anyway should be clock-controller
>>>
>>> Will fix.
>>>
>>>>
>>>>> +    type: object
>>>>> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>>>>> +    description: Clock provider for PLL.
>>>>> +
>>>>
>>>> You just added these bindings! So the initial submission was incomplete
>>>> on purpose?
>>>>
>>>> No, add complete bindings.
>>>
>>> Does you mean that it should drop the 'description', or add complete 'description',
>>> or add 'compatible', 'clocks' and 'clock-cells' of complete clock-controller bindings?
>>
>> It means it should be squashed with the patch which adds it.
> 
> Should I drop the 'decription' here and keep the 'decription' in patch1?

There should be no this patch at all. However I do not understand what
you want to do with description. What's wrong with description?
> 
>>
>>>
>>>>
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg
>>>>> @@ -38,4 +53,16 @@ examples:
>>>>>          reg = <0x10240000 0x1000>;
>>>>>      };
>>>>>  
>>>>> +  - |
>>>>> +    syscon@13030000 {
>>>>
>>>> No need for new example... Just put it in existing one.
>>>>
>>>
>>> Actually, the PLL clock-controller are just set in sys-syscon resgisters. The stg-syscon and
>>> aon-syscon don't need it. So PLL clock-controller node only is added in sys-syscon node.
>>
>> So why having other examples if they are included here? Drop them.
>>
> 
> Should I drop the old example of stg-syscon and add a new example of sys-syscon which
> include clock-controller child node?

No, there should be no stg-syscon example, it's useless.

Best regards,
Krzysztof

