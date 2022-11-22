Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849E5633655
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiKVHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:53:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45BB32078
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:53:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j4so22428878lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQ8bx9Dfh1gie+oi8LKa4eXodAjbnVF4JmRQw+L+qtk=;
        b=CSspjfWtIHwBoOPsy6am26ZbMCFZ80QhorAj2jlrYz0GUwR1uOvIRvNqbXCQqaRsj3
         6iNscXtXKhCzw71Va0eTmiEr4/Jzfk4hss9FY877Usc/bOxdF66u9FMiFu2+QDcYj/J6
         7pCA6RTTTN+qraj4/PSqIXXeRQ0Bo5dx8csRs6NWBLKWzNjSEOqOyjtZIZQfz65td0nK
         YWTITL7T9WIVqFfs184FTg3OV4XnLse99NPgcQGyU21iuLZHSvbw362awcQY6UUlW1Q7
         7+5jc31ELnVkmZBPbhPASKt/NyFSoGR2rUBJe33DA7AD1W06f/P92c839JnIqSffHS1q
         /G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ8bx9Dfh1gie+oi8LKa4eXodAjbnVF4JmRQw+L+qtk=;
        b=OucYwiu6aQa8VW4sO+rByyyasz1qpJkC2JAfjyLpIgr/98XfpByIOgsoNrCZY/nZtX
         0vIrSJLnz1XYvn97hKmON0212TjJ4F4tMZQTWHOwNITpaaMU4NW5HysmabuVCepBhutH
         YBdqZ2U8TK6YQfE0ud1/y8OCALFIsxMoepi1A+aMfV5zOLhBZNVyVMM6Jq9dFgw/vXIC
         ppSI68hbDC0hcDhC+Q0XUNNbnP2ViHu/lX/OH9RhQ79aZ6UdHGmn6RlwywVKG8qMK2tN
         nIhUAY/d98wdNWwjphgPco7af621kj1cLKAj562ZW1QT2m9tDw+43VMBIQYMNW7zcT1y
         WCUA==
X-Gm-Message-State: ANoB5pnka188eMEr+ZVSgEB85+6sIbclEKYN1m1u4e2j4P1G4acxxZ6c
        IxKyK9Dc06aE/ufWia5FHLfPyQ==
X-Google-Smtp-Source: AA0mqf5eixL3752WiUasLPWshn4I/1Ey1WjzR+4530DoafEveNak/4ymR+A4YOjxu3BHlPR5lc6v3g==
X-Received: by 2002:a19:5e12:0:b0:4a9:b9cc:fbeb with SMTP id s18-20020a195e12000000b004a9b9ccfbebmr7011585lfb.581.1669103597073;
        Mon, 21 Nov 2022 23:53:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j5-20020ac24545000000b0048aee825e2esm2376972lfm.282.2022.11.21.23.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:53:16 -0800 (PST)
Message-ID: <a9f3f08a-aca0-5054-c457-da030558eba7@linaro.org>
Date:   Tue, 22 Nov 2022 08:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: timer: add a binding for LiteX Timer
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221121042545.421532-1-uwu@icenowy.me>
 <0dc15e61-62a3-fa23-1fa9-09179d90874b@linaro.org>
 <16603756642bf557ab27db3948ded467a55a85ac.camel@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <16603756642bf557ab27db3948ded467a55a85ac.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 15:39, Icenowy Zheng wrote:
> 在 2022-11-21星期一的 11:19 +0100，Krzysztof Kozlowski写道：
>> On 21/11/2022 05:25, Icenowy Zheng wrote:
>>> The LiteX SoC generator has a timer core, which by default only
>>> generates a simple down counter.
>>
>> Subject: drop second, redundant "bindings".
>>
>>>
>>> Add a DT binding for it.
>>>
>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>>> ---
>>>  .../bindings/timer/litex,timer.yaml           | 52
>>> +++++++++++++++++++
>>>  1 file changed, 52 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/timer/litex,timer.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/timer/litex,timer.yaml
>>> b/Documentation/devicetree/bindings/timer/litex,timer.yaml
>>> new file mode 100644
>>> index 000000000000..bece07586c6b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/timer/litex,timer.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/timer/litex,timer.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: LiteX Timer
>>> +
>>> +maintainers:
>>> +  - Icenowy Zheng <uwu@icenowy.me>
>>> +
>>> +description: |
>>> +  The LiteX Timer is a count-down timer that is defaultly embedded
>>> +  into all LiteX SoCs, unless explicitly disabled. It's fed
>>> directly
>>> +  by the system clock like other LiteX peripherals.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: litex,timer
>>
>> No model name/number? If it is part of Soc, then a SoC specific
>> number
>> is expected usually.
> 
> Ah it's part of a SoC generator, as a default core. [1]
> 
> If you like, I think the version of LiteX SoC generator itself could be
> added, like `litex,timer-22.08`.

How can you be sure that all soft-cores from Litex will be exactly the
same and use the same compatible? The naming is poor here, but I don't
know whether some arbitrary version number is the solution.

> 
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  litex,width:
>>> +    description:
>>> +      The width of the timer's value, specified as the width
>>> argument
>>> +      when creating an instance of litex.soc.cores.Timer.
>>
>> This lacks type ($ref) and units in description, but more important -
>> why this is not part of compatible? Is it a width of register(s)?
>>
>> And what is "instance of litex.soc.cores.Timer"? Is it configurable,
>> soft-core?
> 
> Yes, it is a configurable soft core, although the configuration of a
> non-32-bit counter is only available when directly generating this core
> w/o using the full SoC generator (the full SoC generator defaults to
> 32-bit).
> 
>>
>> BTW, there is reg-io-width property.
> 
> This is not register I/O width, it's only the width of the counter.
> 
> And because of the LiteX CSR bus nature, all registers after this will
> be automatically moved if this register's size goes beyond the
> alignment (current all LiteX support in Linux mainline assumes 32-bit
> alignment, which is also the default configuration).

OK

Best regards,
Krzysztof

