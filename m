Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7297629BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiKOOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKOOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:15:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1987F09
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:15:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so24684429lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3diX76ypvjrVehA5dTE8kwpwanSYAnaRWdknsRKXCMI=;
        b=tJr375TFIl37vwPQoGTYpzPVXtpwqDq9idV7MjN/dt7uE8ze2e2dhZ3Ww9MMIg+MLw
         K/KAAtD18kxUzCjqKJ3H6vmBteMyoch9V4kxo6xrRapj7lftneiDT/olwD9WMxPvrQqR
         zes/Htl5uwYbJ+FloklFULDlbRHxr7YyCui4CBmDMZ9IoG5f0HfgpNCvqYaIPI2TtLyv
         SLfA+MlZ+pl7TNwKTHqRS0nfNw19iLPH0hWzX6zbY2ycwVLjgfFdsheK/dr411zS2GWx
         j32g0dPKdLf5ah6FBQutWhGS7BIMG6WLDx7X5C5u9I0UyrKkzPg4RbELsHrwJRq1YkwQ
         Sniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3diX76ypvjrVehA5dTE8kwpwanSYAnaRWdknsRKXCMI=;
        b=CYOElrXfV3uEhYtbsQjIK20mc5956HmxGbxyX5oh5N5K+57BXBbe+qgkSe34AxBiC5
         0/vdhmHA3trL08aP6DvRJ65JJpLL6Ry7xgFkurFqltdLlu8dPVrc/6K4TufF6kNqP3zN
         t2/xO+ObjZnkI2y8HxYymF1I/LEb1G6ppzLw9SvQVYAsEpPfNudGL1KkYXoxkBQzA528
         Z4t0r+u63JWeV+xBGtQePR1gT9zB0bYy2ew7gCars6hYUbAoVkYcfDcVuTINJMD4FeFA
         EAw0RD0ZlvkECQgjig239a0EUOJxoyPgV5iDERLPHrquh16QpLyyHHW4qAcKuIxOEyRV
         kBFA==
X-Gm-Message-State: ANoB5plUbtTj2WssiI2WlWjlE8B1//q9KWv6CXMGTp3CprzlLbyx92dx
        h/+JACQXyoSb2rw10OcOWpbERg==
X-Google-Smtp-Source: AA0mqf4mE5ZOMrdpLTeTOsuQnfibZuAC5L5TXWqQTyBRIOuSzsJ9KF97xlQp/3VxgdvlGpTphSVE2A==
X-Received: by 2002:a05:6512:4cd:b0:4b0:2da9:55d0 with SMTP id w13-20020a05651204cd00b004b02da955d0mr5347753lfq.187.1668521727232;
        Tue, 15 Nov 2022 06:15:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o20-20020ac25e34000000b004b40c2fccfdsm2226053lfg.59.2022.11.15.06.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:15:26 -0800 (PST)
Message-ID: <2505fcf3-6c0c-b5f2-6400-bea9a1f7a70b@linaro.org>
Date:   Tue, 15 Nov 2022 15:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <9be58cb4-4ee8-a6e0-7a0a-f2f581e394d3@linaro.org>
 <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
 <3f469c79-fc4e-9c29-9c47-6dd8e28484a5@linaro.org>
 <CAK9=C2VEZhxgqEDxxKRyvs7NdeRvPzVH=Yy_c_t-tLWhCt3wqA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK9=C2VEZhxgqEDxxKRyvs7NdeRvPzVH=Yy_c_t-tLWhCt3wqA@mail.gmail.com>
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

On 14/11/2022 16:04, Anup Patel wrote:
> On Mon, Nov 14, 2022 at 5:52 PM Krzysztof Kozlowski

>>>>> +  riscv,slow-ipi:
>>>>> +    type: boolean
>>>>> +    description:
>>>>> +      The presence of this property implies that software interrupts (i.e.
>>>>> +      IPIs) using IMSIC software injected MSIs is slower compared to other
>>>>> +      software interrupt mechanisms (such as SBI IPI) on the underlying
>>>>> +      RISC-V platform.
>>>>
>>>> Is this a property of software or hardware?
>>>
>>> This is a property of hardware (or implementation) because IPIs
>>> in IMSIC are software injected MSIs so if IMSIC is trap-n-emulated
>>> by a hypervisor then all writes to MSI register will trap to hypervisor
>>> in which case IPI injection via IMSIC is slow.
>>>
>>> The presence of "riscv,slow-ipi" DT property provides a hint to
>>> driver that using IPIs through IMSIC is slow on this platform so
>>> if there are other IPI mechanisms (such as SBI IPI calls) then
>>> OS should prefer those mechanisms.
>>
>> If this is specific to implementation, why it is not included already in
>> the compatible?
>>
>> The name is anyway too vague. What is "slow"? Describe real
>> characteristics of hardware, e.g. trapped via hypervisor.
> 
> Okay, how about renaming it to "riscv,trap-n-emulated" ?

Sounds ok.

> 
> Alternately, we can add "riscv,soft-imsics" as an implementation
> specific compatible string which hypervisors can use to describe
> trap-n-emulated IMSICs. This "riscv,soft-imsics" can also replace
> "vendor,chip-imsics" dummy string ?

soft-imsics would work only if it is a real device. My question was
rather whether this is something configurable or fixed in given
implementation.

Best regards,
Krzysztof

