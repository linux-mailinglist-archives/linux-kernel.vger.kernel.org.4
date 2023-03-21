Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6196B6C2B43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCUHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCUHUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:20:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E227D65
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:20:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so55948963edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679383199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZIGEy0iMA/skXFEpAT9p9LlHDsXSn75UBt5GupjNso=;
        b=KObOZI3Cvv7ICcPJ/fLiBA4mv2/1SFABKFSG4veuCHlK2L+RvloMWx0O7bRWU25C+X
         9DLyLRsASHmzHfyMkMWh7R4yTL9h/FAKdsBJ0IJjOC7+4srnKtiDbOy4GDHg4wHe+u/2
         syCvWrcgz0tiVeufSuwFPNU/x6EswLyzW3u/Ug0AuBT0tJSSa3RBGjqVdeJjJOuQ9vWE
         YKtTRL0QVxdt/De7XB8V1xoTnXJQWctQYOhVhsOiSWh3YcXBdMv8Mo8WICRnJUhF9fRK
         /a+uNsuwhbGepMj8jZj47fJnmyzHUaz4ozZ+nkHmWenrvTYFtRsDZKagk15k4K6P4llq
         qYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679383199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZIGEy0iMA/skXFEpAT9p9LlHDsXSn75UBt5GupjNso=;
        b=ic1bxkrj2f5oEvQBLdydH3Y+2oxADRk1p4dQqH31iOamFECPNWSO0HYMS/S52c+02F
         OyTZ/P8cBAUcGOtoclfAcziH920RcPOH228ND0u/1eJpZ0t12lNPoQ3igjpjVWJ2e3Wb
         JNg39xVApLj7eNB09/LG+9SVsI71euU8+ikimDbr5H2u1lzAmBQKC5Y5EHeIxdG+8awf
         SjsdnGf3IFEzLKHB6ZIYTLt9rfjMfnyeTaQTCtqxzb+ZHveXvM32dO1idXGYYoHaceD0
         sE3e6cxJ8h2wdCCkbL/j6Nad/483NSX3REkuaR09KgBxWoygAiCVaay2auSyjpRVeSJz
         nkhw==
X-Gm-Message-State: AO0yUKXzBk0fviAC+0ZnyG6SyU5edM0Q+IsL/fqhtUTWIU0h8iInFepS
        DcIvYLEJ7EWQYj/J6D1fo9d8iQ==
X-Google-Smtp-Source: AK7set8rg29ejugrhvh2BtRl3Ln8/Jgtcz/Bt45lxQP6Cq+lhCQwZWjzn5kF9h+qErP6iwhEXgQfNA==
X-Received: by 2002:a05:6402:389:b0:501:da04:b09b with SMTP id o9-20020a056402038900b00501da04b09bmr1602172edv.10.1679383199412;
        Tue, 21 Mar 2023 00:19:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm5893477edi.36.2023.03.21.00.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 00:19:59 -0700 (PDT)
Message-ID: <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
Date:   Tue, 21 Mar 2023 08:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
 <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org>
 <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org>
 <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
 <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org>
 <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
 <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org>
 <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 07:56, Sergio Paracuellos wrote:
> On Tue, Mar 21, 2023 at 7:43 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/03/2023 07:38, Arınç ÜNAL wrote:
>>>>>>
>>>>>> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs which are
>>>>>> ARM, so mediatek,mtmips-sysc would work.
>>>>>
>>>>> I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles will
>>>>> start with ralink. There are already some existent compatibles for
>>>>> mt762x already having ralink as prefix, so to be coherent ralink
>>>>> should be maintained as prefix.
>>>>
>>>> The compatibles I mentioned start already with mediatek, so why do you
>>>> want to introduce incorrect vendor name for these?
>>>
>>> Can you point out where these compatible strings for mt7620 and mt7628 are?
>>
>> git grep
> 
> Not for *-sysc nodes. The only current one in use (from git grep):

We do not talk about sysc nodes at all. They do not matter.

> 
> arch/mips/ralink/mt7620.c:      rt_sysc_membase =
> plat_of_remap_node("ralink,mt7620a-sysc");
> 
> That's the reason I also used prefix ralink for the rest.
> 
> Does it make sense to you to maintain this one as ralink,mt7620a-sysc
> and add the following with mediatek prefix?
> 
> mediatek,mt7620-sysc
> mediatek,mt7628-sysc
> mediatek,mt7688-sysc
> 
> That would be weird IMHO.

What exactly would be weird? Did you read the discussion about vendor
prefix from Arinc? mt7620 is not a Ralink product, so what would be
weird is to use "ralink" vendor prefix. This was never a Ralink. However
since there are compatibles using "ralink" for non-ralink devices, we
agreed not to change them.

These though use at least in one place mediatek, so the above argument
does not apply. (and before you say "but they also use ralink and
mediatek", it does not matter - it is already inconsistent thus we can
choose whatever we want and ralink is not correct).


Best regards,
Krzysztof

