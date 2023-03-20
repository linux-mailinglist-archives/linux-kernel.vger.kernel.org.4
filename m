Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371626C0AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCTGhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCTGhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:37:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA4812052
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:37:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so42544887edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679294241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMAbHeAxn10XpZBHVp/8FgkoGfk6Ak3SIPc/tdQAzaU=;
        b=cKNT2IPoYuLDU3GHiau+62cf+h4z8T6ZyosMDPFLS7tYFBxWRjiygHSJFE56UKTXsj
         GVgZTvOke3jD3hhizxQ/iV+y9D+TULtf+CCRjJFqBlIFG6o08a9UwLyWAlm3wGSqTyqo
         53iHnDyWzIr7IlqSzhUaEsQzf59Qn8M8CA6dgCd2yn0gZPS2jDy0dqy0ChJo8U9gfF35
         oyGLDa0bchDbYA2aE8rIfl0wavTdFSCwb5npB6+N9NxcEWOnnIp5a8qNKR6e1YrLL78B
         6Wcq4DmHjKJlR3MGHqrU3vcLB7f1gl/Jx9mxGbuX0yz7CPX1DWuRNAe6RgnRcQ53pLH4
         P8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679294241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMAbHeAxn10XpZBHVp/8FgkoGfk6Ak3SIPc/tdQAzaU=;
        b=bLW1mQy7pTUWobZmvqXpopFqlcTob5VXVQOJOhFaqYnNkuZUdvQi6ojlDzVCQ8tr3n
         uNx+12n6xOwvanc+YkwRNVXEjq9Y5BkfxhvD+FY629HiI3uPDXt3Q/WrLPYlpolYVvzu
         XAUcAsSLtJi6Hfa1J+lOtyjPjywkc5Qrd39BESzlYTZmaUYi7XGUnHDnvdDApFHLr4UW
         ohg0SwjgxpxQIgnri+vw+pXTp+52mDXroKXN1Wf6c8jJG7d6aVKrlrLABC8luTLDGY3v
         9H/Ip2a43jdqjMkPtEkQq3OtRLX8Q8kkP74x8N104OOUMsDzYuFOyvaJxQoq0CtHiHxk
         l+8w==
X-Gm-Message-State: AO0yUKXRvtiXuGX6U5IAF7BISXk+Bur68L/AMzS7i0/o2Ms6FnVULL5q
        7nIscRv6/9l0osnPlxd3xjoyCg==
X-Google-Smtp-Source: AK7set8VRtL9ZQsZfjAfc7z9H6C2FM1URQbMoaWzmaCRPc426Ay97st5q+LNo4+luc9BKJHApke3UA==
X-Received: by 2002:a05:6402:211:b0:500:50f6:dd33 with SMTP id t17-20020a056402021100b0050050f6dd33mr7570647edv.2.1679294240864;
        Sun, 19 Mar 2023 23:37:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4428:8354:afb6:2992? ([2a02:810d:15c0:828:4428:8354:afb6:2992])
        by smtp.gmail.com with ESMTPSA id y70-20020a50bb4c000000b004fa380a14e7sm4389167ede.77.2023.03.19.23.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 23:37:20 -0700 (PDT)
Message-ID: <a6b9bab2-4151-c811-85ff-2424866e21d8@linaro.org>
Date:   Mon, 20 Mar 2023 07:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: starfive: syscon: Add optional
 patternProperties
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <45221a1c-dc01-2759-3e32-658636625529@starfivetech.com>
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

On 20/03/2023 04:54, Xingyu Wu wrote:
> On 2023/3/19 20:28, Krzysztof Kozlowski wrote:
>> On 16/03/2023 04:05, Xingyu Wu wrote:
>>> Add optional compatible and patternProperties.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 39 ++++++++++++++++---
>>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>> index ae7f1d6916af..b61d8921ef42 100644
>>> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>> @@ -15,16 +15,31 @@ description: |
>>>  
>>>  properties:
>>>    compatible:
>>> -    items:
>>> -      - enum:
>>> -          - starfive,jh7110-aon-syscon
>>> -          - starfive,jh7110-stg-syscon
>>> -          - starfive,jh7110-sys-syscon
>>> -      - const: syscon
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - starfive,jh7110-aon-syscon
>>> +              - starfive,jh7110-stg-syscon
>>> +              - starfive,jh7110-sys-syscon
>>> +          - const: syscon
>>> +      - items:
>>> +          - enum:
>>> +              - starfive,jh7110-aon-syscon
>>> +              - starfive,jh7110-stg-syscon
>>> +              - starfive,jh7110-sys-syscon
>>> +          - const: syscon
>>> +          - const: simple-mfd
>>>  
>>>    reg:
>>>      maxItems: 1
>>>  
>>> +patternProperties:
>>> +  # Optional children
>>> +  "pll-clock-controller":
>>
>> It's not a pattern.
> 
> Does it use 'properties' instead of 'patternProperties'?

Yes.

> 
>>
>> Anyway should be clock-controller
> 
> Will fix.
> 
>>
>>> +    type: object
>>> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>>> +    description: Clock provider for PLL.
>>> +
>>
>> You just added these bindings! So the initial submission was incomplete
>> on purpose?
>>
>> No, add complete bindings.
> 
> Does you mean that it should drop the 'description', or add complete 'description',
> or add 'compatible', 'clocks' and 'clock-cells' of complete clock-controller bindings?

It means it should be squashed with the patch which adds it.

> 
>>
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -38,4 +53,16 @@ examples:
>>>          reg = <0x10240000 0x1000>;
>>>      };
>>>  
>>> +  - |
>>> +    syscon@13030000 {
>>
>> No need for new example... Just put it in existing one.
>>
> 
> Actually, the PLL clock-controller are just set in sys-syscon resgisters. The stg-syscon and
> aon-syscon don't need it. So PLL clock-controller node only is added in sys-syscon node.

So why having other examples if they are included here? Drop them.



Best regards,
Krzysztof

