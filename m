Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DA86B050F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCHKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCHKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:53:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B817B56FC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:53:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o12so63919796edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4hMshLQxc1+Yuk9bOGISqamQ12PACobpwu6CEhurm0=;
        b=oB69PsT8hhW95FEInNHN7YtVxJcoDJp/SLotzrDdTvGsbiWdbq0Zwbo6wl2ns5mB4T
         NKy1DIosI3Upe3NeOV+Up2nkOoFM9LEUVelCk3finWaUuYwzLF/a9S0v2Iyat5e3CupB
         5B8yjuTXg4Q2fu+quoibo1CXvNfCIBFpeQa8lkifUjmM5+IUzC05LV/jXbIJIUtKrD2Z
         emYgLCKh4yFUH5q922gjOTE535ZyCYdkfxSxHXPD4VPW9JnbcG8ucqSt6kqDeHScda6l
         MQ39DaeG1utIt4NHV7nE5KHhEd0zV4azzY3QndCL2pEsZqSNd7L9CsYYT/Chk7PxbeT0
         SDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4hMshLQxc1+Yuk9bOGISqamQ12PACobpwu6CEhurm0=;
        b=egsrOhEEN35mzQR9MLR0xmkQfAQksv5Nrh9fuuC3qJeceH1hGwndatpcAuuahPM/kb
         ZPX373FqxX7zDdu8hkYcBBuvOK4+PeIRlJWmE+T/qisN2ZrzQeqa5NFgZ8Z/NRXW9Gzq
         QJxfIsuR2NeLEqIQ10amjFkOjzSJtgZ4w3fM0iXApMDdwS+38h8d+OG6PIJdG9OEnxug
         sWb99ShRA6NW8fNp2skicTatF85lMSW+1r/udiVvPD+h0/iBShjQh1zQNdvm4Pysjamu
         iNTXHOVwFZTkk/fM8uLeL2lOHxsMCPWDzc/2Uo3b/elq9xV9XtmQvu1IeaNnKOlDBnIf
         zCaA==
X-Gm-Message-State: AO0yUKXE2SU9esqS5dey45lJpPimhpML9MD35rIz2GUFJ9QbMRKJkaQO
        73YnOjBhi3PRyBw5tffektIdVA==
X-Google-Smtp-Source: AK7set/fozt7BN6FTgJlP50iO5D4QKloILUZywX279YdbN/DAM6lY/a+S+jA5F0GjNz60n1kE9Areg==
X-Received: by 2002:aa7:d782:0:b0:4c1:74fe:b52e with SMTP id s2-20020aa7d782000000b004c174feb52emr17070012edq.11.1678272814143;
        Wed, 08 Mar 2023 02:53:34 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id v18-20020a17090651d200b008bbc9115038sm7370836ejk.56.2023.03.08.02.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:53:33 -0800 (PST)
Message-ID: <d0d0617d-8a2e-7a71-f4fe-f69896f84ede@linaro.org>
Date:   Wed, 8 Mar 2023 11:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040: update
 properties
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-2-clamor95@gmail.com>
 <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org>
 <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
 <bbc7c183-3f98-9ea4-d5e5-0d58dd65d416@linaro.org>
 <CAPVz0n3sKH_7x=aNVLaHVN0F1FWLVRW+MGoj9qBO9V=TDuv_jQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n3sKH_7x=aNVLaHVN0F1FWLVRW+MGoj9qBO9V=TDuv_jQ@mail.gmail.com>
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

On 08/03/2023 11:51, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 12:44 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 10:15, Svyatoslav Ryhel wrote:
>>
>>>> max17040 does not have ADC temperature input... so is it system
>>>> configuration?
>>>>
>>>
>>> yes, I own a device (LG Optimus Vu P895) which uses max17043
>>> coupled with ADC thermal sensor
>>>
>>>>> +
>>>>> +  io-channel-names:
>>>>> +    items:
>>>>> +      - const: temp
>>>>
>>>> Drop the names property, not needed for one item.
>>>>
>>>
>>> Alright, but driver patch expects temp name. I will look if this
>>> is adjustable.
>>
>> I think I saw cases without names.
>>
> 
> There is no io-channel without a name. And io-channels are mostly used
> by power supply devices.
> 
>>>
>>>>> +
>>>>>    wakeup-source:
>>>>>      type: boolean
>>>>>      description: |
>>>>> @@ -95,3 +109,26 @@ examples:
>>>>>          wakeup-source;
>>>>>        };
>>>>>      };
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    i2c0 {
>>>>> +      #address-cells = <1>;
>>>>> +      #size-cells = <0>;
>>>>> +
>>>>> +      fuel-gauge@36 {
>>>>> +        compatible = "maxim,max17043";
>>>>> +        reg = <0x36>;
>>>>> +
>>>>> +        interrupt-parent = <&gpio>;
>>>>> +        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
>>>>> +
>>>>> +        monitored-battery = <&battery>;
>>>>> +        power-supplies = <&charger>;
>>>>
>>>> But here you suggests something else than VDD... The hardware does not
>>>> take charger as input. It takes power supply - vdd.
>>>>
>>>
>>> Power system allows passing properties from other power devices.
>>> In this case battery health and status are passed from charger.
>>
>> So this is not an input to device? Then it does not really look like
>> property of this hardware. Fuel gauge does not control the charger, also
>> from system configuration point of view.
>>
> 
> It is not controlling charger, the charger provides the status and
> health of the battery to the fuel gauge. This option is also used in
> other fuel gauges.

How regulator provides health and status of the battery? I don't understand.

Best regards,
Krzysztof

