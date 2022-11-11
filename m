Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7677762551B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiKKIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiKKIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:20:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA171F14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:20:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so7284278lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7Ka71WJnUiAb9fvGY9CNSs9KdiUBfWOURrQspmYDMA=;
        b=tD8dVfVTwQei5KACu20o0XLwgAARP34M1YmWgCtHFXL2eE04ultRTvyqqPIEbl41XH
         3h9a3UlXK9oGLr42gNN2P3fWJQ1FRbQdint+WleKKg+6kfwRimn6bhJ9fQeu8zDSkFIF
         GYS+MKs2cjHVRJC9+MYoXX30JxfzHFy9ogsdLBUC4gqH6WIDj130tROm195MPYGyL1eO
         UP1GG6IiIjJ14ky5R6VVvs/nronUHKiknMBsof5jL7IPDw48/ln5ahTjg/met3l+p8FO
         dIW6XXi7hMAncrN4+oDeeo4LQ/7l8d+RPx4gpXzt8LrVbD06aeQDIQEBVJhDvj/Zxas6
         s/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7Ka71WJnUiAb9fvGY9CNSs9KdiUBfWOURrQspmYDMA=;
        b=eF8KG7xBKRuZTy+RyEVx6Rn9kmZ2zLW+E2ojbt7RhHENKNIy+TNSZAjQGH0n1Y2MaS
         FPMNnbwtU/2HOZBSalA7EO0fZi6YiY30iQxpDI4L4iCcnFHbivIODzRfS5AXRZL8jf6d
         87rthVnA4kUieQeHRa5nWgk3iOju5gjxcsRdw7iAsiwlb1g8jC3ekb7YhWLzmGJZNZ9e
         c9v5As1Rq7osyWfR262U+8q2QzVQcH7/c7vjg6FS4GlZCNNdtggdW0WelqfMfXZVLk69
         AtIGPycJXt24TQQCBx73sjjHtpZMKcixRaRs5enjyHLPRshAOr8v4bTLDYgMNm81K2/q
         Wgmw==
X-Gm-Message-State: ANoB5pk3CVfluC7wS7KDiVsAzfm+ZQ9NgJJjPJ5KlbcT+ccrLttzkPAh
        Z2T9GiiNS5ryTO8pV4SgWmOllg==
X-Google-Smtp-Source: AA0mqf6oEBYq1lUaIJv8EvmNwB7aw0DrLt6oIirmfX4VsIKPBfkQ6dfRACGvX4/i69yzydm/945ajA==
X-Received: by 2002:ac2:4ecf:0:b0:4a2:741f:1909 with SMTP id p15-20020ac24ecf000000b004a2741f1909mr428635lfr.484.1668154838719;
        Fri, 11 Nov 2022 00:20:38 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25922000000b004946a1e045fsm208768lfi.197.2022.11.11.00.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:20:38 -0800 (PST)
Message-ID: <8931d67d-6f4a-913e-8873-995703dbb97f@linaro.org>
Date:   Fri, 11 Nov 2022 09:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
Content-Language: en-US
To:     "Yu, Richard" <richard.yu@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Chang, Clay" <clayc@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
 <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
 <SJ0PR84MB2085E6B922DAF1070DC802EF8D3C9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <c199600a-aad9-5639-ea57-a4d59d719ade@linaro.org>
 <SJ0PR84MB20853F3B0FCCF2A9583524B48D3E9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SJ0PR84MB20853F3B0FCCF2A9583524B48D3E9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 04:37, Yu, Richard wrote:
> Hi Mr. Kozlowski,
> 
> Thank you very much for inputs.
> 
>>>>> +
>>>>> +  vdevnum:
>>>>> +    description:
>>>>> +      virtual device number.
>>
>>>> That's unusual property... Why numbering devices is part of DT (hardware description)?
>>
>>>  In HPE GXP virtual EHCI controller chipset, it can support up to 8  
>>> virtual devices(gadgets). Each device/gadget will be represented  by 
>>> a bit in 8 bits register. For example, the interrupt register bit 0  
>>> indicates the interrupt from device 0, bit 1 for device 1 ... so on.
>>> When a user defines a device/gadget, he/she can define the device 
>>> number as between 0 and 7. Thus, the driver can look up to the bit 
>>> position. That is why we have numbering devices as part of DT.
> 
>> Wrap your lines properly, it's impossible to reply in-line to such messages.
> 
> Sorry for the improper wrapping. Hope the above fixed the problem.
> 
>> Then how do you specify two devices? You allow here only one, right?
> 
> In our current design, to specify two devices, we added the gadget 
> structure into the device tree, such as  gadget0:udc@80401000{}; gadget1:udc@80402000{};....
> 
> No, we can allow up to 8 devices by adding the gadget structure,
> such as gadget0:udc@80401000{}; gadget1:udc@80402000{};....gadget8:udc@80408000{};
> 
>> Which bit in which register? Your devices have separate address space, so why they cannot poke the same register, right? Then just always set it to 0...
> 
> In HPE GXP vEHCI controller, there are three register groups: standard USB EHCI registers, 
> virtual device global registers, and virtual device registers.
> 
> Standard USB EHCI registers ---- We defined as "hpe,gxp-vudc" in the device tree (vuhc0) 
> Virtual device global registers --- We defined as "hpe,gxp-udcg" 
> Virtual device registers -- We defined as "hpe,gxp-udc"
> 
> Each virtual device will have its own separate address space. 
> There is only single address space for the virtual device global registers. 
> 
> The virtual device global registers are including vDevice Global Interrupt Status register(EVGISTAT), 
> vDevice Global Interrupt Enable register(EVGIEN), vEHCI FlexEndpoint Mapping register (EVFEMAP) ....
> We need the vdevnum for the bit position in EVGISTAT and EVGIEN for each device.  
> We write vdevnum into the EVFEMAP register to assign an EP to a specific device. 
> 
>> I might miss here something but so far it looks to me like some hacky description matching the driver, not hardware, not existing bindings.
> 
> We create "vdevnum" as device configuration parameter due to our hardware need.

That's not an argument... everything can be a "hardware need".

> 
>>>>> +
>>>>> +  fepnum:
>>>>> +    description:
>>>>> +      number of the flexible end-points this device is needed.
>>>
>>>> Similar question.
>>>
>>> In HPE GXP virtual EHCI Controller chipset, there is a flexible End-Point(EP) pool. 
>>> Each flexible EP has its own mapping register. The mapping register 
>>> bit 0 to 3 is for device number (vdevnum) and bit 4 to 7 is for EP number inside the device.
>>> The device driver configures the mapping register to assign a flexible 
>>> EP to a specific device.  Here, "fepnum" is the input letting the 
>>> driver know how many EPs are needed for this device/gadget.
> 
>> Nope. So you create here some weird IDs to poke into syscon register.
>> First, syscon has offset if you need. You could treat it maybe as bits?
>> I don't know... but even then your design is poor - two devices 
>> changing the same register. Even though it is sunchronized by regmap, it is conflicting, obfuscated access.
> 
> The "fepnum" is the input parameter to define how many end-points (EPs) is needed
> for the device.
> 
> You are correct that all devices need to access the virtual 
> device global registers during the runtime. 
> Thus, we create " hpe,syscon-phandle = <&udc_system_controller>;'
> for the driver getting the vDevice Global registers address.

And how do you solve poking into the same register by two devices? Who
owns it? You don't...

> 
> In our current chip registers layout with the vDevice Global registers, I don’t see
> a way to avoid "two devices changing the same register".

I see at least an idea - create proper hierarchy, where parent device
instantiates its children (thus knows and increments the IDs) and is
responsible for proper handling of shared register (thus the parent owns
the register).

I understand why you created vdevnum/fepnum properties but the reason is
not matching DT bindings. These are not additional hardware properties
which deserve their own DT properties - they are already part of unit
address and/or just incremented ID based on device number managed by a
parent.

Best regards,
Krzysztof

