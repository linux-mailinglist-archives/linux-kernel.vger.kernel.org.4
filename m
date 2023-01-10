Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39D1663AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjAJIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjAJIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:25:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59B43A1B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:25:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so6345032wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMoqZy8lL6lKnv3mK+SHjAH6f5V4KXyJJY9vMCQj/VM=;
        b=TV/zP38nT/DV77mwIwJKMtCilXcLYKNqFaSt4ttTXejVQPETGHaTze/gAgtQUETvZh
         x8MuR/5XO92gVTfPK4sbIgmeJ1giXD0x8jCqPRETWfHCEpPfi2VxeU+Jkw37+IgzYzNJ
         aDaD8rJzgn0485gyM4LgU0Ityeo5tL8MVyZ7lj1FZkCTZ4rH6Xf1lPaR3u6rKtqQfgGs
         EDGjisRz/4hvrQDBOkWvyIQMnAw+KRLExidd/YoMBJhrX8LTX8Yx5WFWLnE8QcW4UqS3
         P1XQq9wx/lbuw+k9lbrnrWglair+kGIjSphEoBBUrsPUIQdtXyWN09igCGzqQz7OcHoR
         w46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMoqZy8lL6lKnv3mK+SHjAH6f5V4KXyJJY9vMCQj/VM=;
        b=3+ST4g+r7zAI4OZQvbn58gEmsB/bVfPnLp+HPq6le3/dK0c5bS9QhsFVdTr9dx1PEv
         x3ug8pzvusXr0pb+dNyef18QO5ENMztRqmC1nC6hhEmG/hcuwYYRGKLZClgCXHt5uUff
         8oeYt5OY7H7YemuBR4OHs68wdXqBLw05YN7x6zSVGv562A4ZrawS0tQTGGY31KkvaJTM
         viqPbA4I0/e+e8BagzV3zkdHl2Gc7lx0LczRb50SzTMymp5yi5ycPvXxMvNXZ4q7D39A
         +PHX6hjKjS3kbDdcmRgvatj2AiNBotWrzS8rdErjMXIIdyy6fmvTzTDCN1qN7YbYfpS/
         XIyw==
X-Gm-Message-State: AFqh2kqkE/TR4S8FLOYM8zhXLqsoiyv7fyGfOieyaNftoPklhdzfSolT
        wPp3TYZqezounlNDpeFoj8uuCg==
X-Google-Smtp-Source: AMrXdXs5LDxIeadvFOYauvtpjU/gcobZo9BXdvfHf5RlHyauK1UfZsK3bydJnx2PQECskqIfaSL1Ig==
X-Received: by 2002:a05:600c:1f18:b0:3cf:5583:8b3f with SMTP id bd24-20020a05600c1f1800b003cf55838b3fmr47116237wmb.20.1673339100837;
        Tue, 10 Jan 2023 00:25:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c6b70a4d69sm15783317wmq.42.2023.01.10.00.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 00:25:00 -0800 (PST)
Message-ID: <6f1c38fc-9586-8ed5-8403-947ed6863b03@linaro.org>
Date:   Tue, 10 Jan 2023 09:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/3] dt-bindings: timer: Add timer for StarFive JH7110
 SoC
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
 <20221223094801.181315-2-xingyu.wu@starfivetech.com>
 <179e66a8-c6c0-6d3e-4f4a-6b884f532572@linaro.org>
 <4febeef1-a42a-7d6f-d1af-d8fe19582822@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4febeef1-a42a-7d6f-d1af-d8fe19582822@starfivetech.com>
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

On 10/01/2023 03:14, Xingyu Wu wrote:
> On 2022/12/23 18:25, Krzysztof Kozlowski wrote:
>> On 23/12/2022 10:47, Xingyu Wu wrote:
>>> Add bindings for the timer on the JH7110
>>> RISC-V SoC by StarFive Technology Ltd.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
>>
>>
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>>  .../timer/starfive,jh7110-timers.yaml         | 105 ++++++++++++++++++
>>>  1 file changed, 105 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml b/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
>>> new file mode 100644
>>> index 000000000000..fe58dc056313
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
>>> @@ -0,0 +1,105 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/timer/starfive,jh7110-timers.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: StarFive Timers
>>
>>
>> Not enough, really not enough. Describe the hardware.
> 
> Will add. Thanks.
> 
>>
>>> +
>>> +maintainers:
>>> +  - Samin Guo <samin.guo@starfivetech.com>
>>> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: starfive,jh7110-timers
>>
>> Why plural "timers", not "timer"? The module is usually called timer -
>> see other hardware that type.
>>
> 
> Will fix. Thanks.
> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description: timer channel 0 interrupt
>>> +      - description: timer channel 1 interrupt
>>> +      - description: timer channel 2 interrupt
>>> +      - description: timer channel 3 interrupt
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: timer0
>>> +      - const: timer1
>>> +      - const: timer2
>>> +      - const: timer3
>>
>> I would just drop the names, not really useful. Unless you plan to add
>> here some generic interrupt (like you did for clock-names)?
> 
> Will drop. Thanks.
> 
>>
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: timer channel 0 clock
>>> +      - description: timer channel 1 clock
>>> +      - description: timer channel 2 clock
>>> +      - description: timer channel 3 clock
>>> +      - description: APB clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: timer0
>>> +      - const: timer1
>>> +      - const: timer2
>>> +      - const: timer3
>>> +      - const: apb
>>> +
>>> +  resets:
>>> +    items:
>>> +      - description: timer channel 0 reset
>>> +      - description: timer channel 1 reset
>>> +      - description: timer channel 2 reset
>>> +      - description: timer channel 3 reset
>>> +      - description: APB reset
>>> +
>>> +  reset-names:
>>> +    items:
>>> +      - const: timer0
>>> +      - const: timer1
>>> +      - const: timer2
>>> +      - const: timer3
>>> +      - const: apb
>>> +
>>> +  clock-frequency:
>>> +    description: The frequency of the clock that drives the counter, in Hz.
>>
>> Why do you need it? Use common clk framework to get that frequency.
> 
> Because normally this timer driver is loaded earlier than the clock tree driver, it won't get
> that frequency by clk framework and this 'clock-frequency' node is used instead.

I don't think that clk framework or fixed clocks are not available at
this time... of_clk_init is before timer.

> 
>>
>> Also, sort the nodes somehow, e.g.
>> compatible/reg/clocks/clock-frequency/interrupts/resets.
> 
> Will reorder. Thanks.
> 
>>
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - interrupt-names
>>> +  - clocks
>>> +  - clock-names
>>> +  - resets
>>> +  - reset-names
>>> +  - clock-frequency
>>> +
>>> +unevaluatedProperties: false
>>
>> Did you test the binding?
> 
> Yes, I had tested by 'dt_binding_check'. Do you mean the 'unevaluatedProperties' is wrong
> and use 'additionalProperties'?

Yes, previously it was generating a warning but I do not see Rob's bot
answer so maybe something changed.

Best regards,
Krzysztof

