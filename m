Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892EB6F4224
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjEBK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjEBK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:59:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24B49FA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:59:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so5579741a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683025182; x=1685617182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdDZqOttphOYv9U+1zrZaT0zA9hRSu+yE6K9FwESJIc=;
        b=ERNh5lp7qwxuvqIuM07/VEe2lkVVyPlwoh0NrOMBXEPTjUwo0lzFR8WGDgvOEXSj+Q
         W/Fqy3pxlfIWyKLfeUQKXJ3X7Vyc3GEXtIPcpWI2VQwHRcCNpTyWVOkKTwbHL8blCZ+Y
         OiYw3a6J7eEEJ+5sbu5vj/JTa84yUCBOssMHtevwVVMrGNv+ZZxk7iKB2lJASfWC2Ywv
         LFYqfzGBbJ8B6ncMiRhP4znXf9IW0sZv7vNjhWIEcdhwxS/64MxfOoprk1rye2PojNEc
         s1h5xDFupsopUgmrnUuP5B2mo2sGKJmgXuinSqqdPzJKrud8J0ArBonk8GBlVoInTQD/
         8p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025182; x=1685617182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdDZqOttphOYv9U+1zrZaT0zA9hRSu+yE6K9FwESJIc=;
        b=Xf/AtMZ6BBgwND7EXP5clIJQmlPPOcFp/Gny273TWGdhLCVYmI1IpFwtiNeOkp6wlb
         /ILL4tsovVr1PwGDy+niq08RKMkqZkiDThdKU++9oS8sXEkUsG8BDFE4fhv0N8uxddLY
         TyLo1ykep6lwRVZpjLFtTUPfZCsj9KWUaPBLbMZhvO+MGIFBYt9LnBPVvEMxiNfH5adk
         7h2U1vfUOKJystj3I8bTxOS1MER0439FHU2EMmzZLMbKx6IeQQvapYMnI9mJr8rsU8JE
         0h/O1gjRF+X/f1grZ8ITkq5aIv/8e98+dZz46GT5LKVGwbKjpN2A7Xzg2HVBdymrIaqs
         mRlw==
X-Gm-Message-State: AC+VfDzeD/2NxXxPkrW+a2iDJcDaDPeRH+qk5BPI0Kdz3KfrypQVL5wo
        ol0FNUnFE/HIbeDSqytMbP1yjg==
X-Google-Smtp-Source: ACHHUZ72mUrm5HA31mQawpD3/IrgOPhq7juHhvyRzwMQfL7RY+YIilMqz9yIbzWwF3xOMPT6aAsYUQ==
X-Received: by 2002:a05:6402:18d:b0:506:741e:5c14 with SMTP id r13-20020a056402018d00b00506741e5c14mr7398805edv.30.1683025182695;
        Tue, 02 May 2023 03:59:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b0094f1d0bad81sm15853265ejy.139.2023.05.02.03.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:59:42 -0700 (PDT)
Message-ID: <a0f4252d-7f27-6dd9-dea0-f8d242011f70@linaro.org>
Date:   Tue, 2 May 2023 12:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1682636929.git.jahau@rocketmail.com>
 <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
 <1d187f41-ad9a-4e82-8557-20694a8294d0@linaro.org>
 <e9d75e57-bdea-593d-7b05-136c9ad2e2fe@rocketmail.com>
 <14daa006-5260-81a8-8ba0-4122e0c0509a@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <14daa006-5260-81a8-8ba0-4122e0c0509a@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 23:16, Jakob Hauser wrote:
> Hi Krzysztof,
> 
> On 01.05.23 19:35, Jakob Hauser wrote:
>> On 01.05.23 09:21, Krzysztof Kozlowski wrote:
>>> On 28/04/2023 01:30, Jakob Hauser wrote:
>>>> Add device tree binding documentation for rt5033 multifunction 
>>>> device, voltage
>>>> regulator and battery charger.
>>>>
>>>> Cc: Beomho Seo <beomho.seo@samsung.com>
>>>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>>>
>>>
>>> (...)
>>>
>>>> +
>>>> +required:
>>>> +  - monitored-battery
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    charger {
>>>> +        compatible = "richtek,rt5033-charger";
>>>> +        monitored-battery = <&battery>;
>>>> +        extcon = <&muic>;
>>>
>>>
>>> Everything up to here looked ok, but extcon is not a hardware property.
>>> Please do not mix adding missing bindings for existing device with
>>> adding new properties. You should use connector for the USB port.
>>>
> 
> ...
> 
>> And how to set up the rt5033-charger to retrieve the information of the 
>> extcon/muic driver in that case?
>>
> 
> ...
> 
> To add more context:
> According to my understanding, the extcon subsystem provides three ways 
> to get an extcon device [3]:
> - by name
> - by devicetree node
> - by phandle
> 
> For rt5033-charger, the extcon device name can be different depending on 
> the consumer device. For the node I wouldn't know how to get from the 
> charger/mfd node to the extcon node, I don't see a direct relation in 
> case of rt5033-charger (it's no parent node or something like that). 
> Therefore I chose the third option: phandle.
> 
> In the rt5033-charger driver, the location of the 
> extcon_get_edev_by_phandle() call is shown in link [4], it gets added in 
> patch 6.
> 

Hi Jakob,

I am currently busy, so I won't be able to help you and dig in your
reply. I will get to you a bit later (or maybe Rob will help here).

However please check if ports graph does not solve your case:
https://lore.kernel.org/all/20230501121111.1058190-6-bryan.odonoghue@linaro.org/

It is already used for orientation and usb-role-switch (which should
solve the need for extcon, AFAIR).

If it does not help, ping me again, and I'll try to get to you a bit later.

Apologies for this, just very busy times. :)

Best regards,
Krzysztof

