Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF1693FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBMIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBMIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:38:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C3CDF2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:38:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10664454wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x93TSjXtO2TlBbQBk5NGYGAmIwuwgwhV00wjEqEE7Ys=;
        b=cENjSiAp/PKrOCayJWJN1sfYW7o5AjlEiGfBmJW6RbMtdZDQ+Tgr5Lz/zBpkcdTiZw
         lY9XIPWbgwgPKc83YQDqDJic4iWhRledbERbyDRX9vv5VKn9kzqi582th6XVx/qr+AFA
         3bdwU116Zd0XZkPh6/RmFVKrrBQK1NO6DFqaAKl+LocAHAdSD1TFKOQkRxldhBLVwro1
         Jzm5hW1reFVAcD9AEqHSvFpGN2xw8bACf+/SMZD/U/bWmRLg+rAibvGdbnfMcs1Sc+0i
         a/gr21XFHk7ZoHXs3/+vyxLufhJ8rOSxqkDJzux/IxJw9RiFbnP67n3j80xfCRNcz26R
         SjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x93TSjXtO2TlBbQBk5NGYGAmIwuwgwhV00wjEqEE7Ys=;
        b=xJ5CAbV0wqXyRLbsGS9F5AU1L8Xth68xDArhBjejYPzpfyHhnW/zRng6Qt4c6gDLTg
         cMWfVeJQWsyGkvHyhRhL32EJcynM28z5dUtDFpzInkTxs8SFQhouaHhZxpp1jvsrkRlO
         IuVKC81ySITAbQovwYXE5WwgYBQNH5st0yT2ZtgevijSwu7ky9vYlydh6NUR3qLQ6Uer
         4cGbtabysFES8dSKtJfiIql4qVMzS4w1sJtnsKqX/BZbPvDSagnDIRa8GUbuyo7NdgNV
         JhgjPt9LKLaPyedColY4bHQBDNMcXHCXtCjDSp8TffCAy66Cd8czMacpFXDqYbhYYW6u
         aVzg==
X-Gm-Message-State: AO0yUKWeejmBJE39/rNhTfLXbR3hQwekehMdS00O3RZX54aPCdYKAVK9
        myGxKXO12hJqBa+MxWyPDy+DxLpPpz25CWnR
X-Google-Smtp-Source: AK7set/x2ojpgyB5m1IoMLipum1xi70lchdc6voJigmp6PgY5rE/K5spEew1vHApe+/oMNVamvMVCQ==
X-Received: by 2002:a05:600c:491d:b0:3da:2a78:d7a4 with SMTP id f29-20020a05600c491d00b003da2a78d7a4mr18267334wmp.21.1676277487553;
        Mon, 13 Feb 2023 00:38:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c379300b003b47b80cec3sm16081969wmr.42.2023.02.13.00.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 00:38:07 -0800 (PST)
Message-ID: <d10e541a-cdfd-08af-6a2c-eb7edcdb486a@linaro.org>
Date:   Mon, 13 Feb 2023 09:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com>
 <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
 <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org>
 <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 09:13, Sergio Paracuellos wrote:
> On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/02/2023 12:01, Sergio Paracuellos wrote:
>>> On Sat, Feb 11, 2023 at 11:47 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>
>>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
>>>>> On Sat, Feb 11, 2023 at 10:10 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>>>
>>>>>> Is this mediatek,sysctl property required after your changes on the
>>>>>> watchdog code?
>>>>>
>>>>> I don't really understand the question :-) Yes, it is. Since we have
>>>>> introduced a new phandle in the watchdog node to be able to access the
>>>>> reset status register through the 'sysc' syscon node.
>>>>> We need the bindings to be aligned with the mt7621.dtsi file and we
>>>>> are getting the syscon regmap handler via
>>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Arınç.
>>>>
>>>> I believe you need to put mediatek,sysctl under "required:".
>>>
>>> Ah, I understood your question now :-). You meant 'required' property.
>>> I need more coffee, I guess :-). I am not sure if you can add
>>> properties as required after bindings are already mainlined for
>>> compatibility issues. The problem with this SoC is that drivers become
>>> mainlined before the device tree was so if things are properly fixed
>>> now this kind of issues appear.  Let's see Krzysztof and Rob comments
>>> for this.
>>
>> If your driver fails to probe without mediatek,sysctl, you already made
>> it required (thus broke the ABI) regardless what dt-binding is saying.
>> In such case you should update dt-binding to reflect reality.
>>
>> Now ABI break is different case. Usually you should not break it without
>> valid reasons (e.g. it was never working before). Your commit msg
>> suggests that you only improve the code, thus ABI break is not really
>> justified. In such case - binding is correct, driver should be reworked
>> to accept DTS without the new property.
> 
> Thanks for clarification, Krzysztof. Ok, so if this is the case I need
> to add this property required (as Arinc was properly pointing out in
> previous mail) since without it the driver is going to fail on probe
> (PATCH 5 of the series). I understand the "it was never working
> before" argument reason for ABI breaks. What happens if the old driver
> code was not ideal and totally dependent on architecture specific
> operations when this could be totally avoided and properly make arch
> independent agnostic drivers?

It's just an improvement and improvements should be incremental and not
break ABI.

> This driver was added in 2016 [0]. There
> was not a device tree file in the kernel for this SoC mainlined until
> 2022 [1]. 

2022 march was almost a year ago, so there were kernel releases with
this ABI.

Also, what about all out of tree DTS? What about other operating
systems, bootloaders, firmwares etc?


Best regards,
Krzysztof

