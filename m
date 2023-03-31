Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB16D2198
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjCaNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjCaNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:44:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191F5B88
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:44:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s20so2753207ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680270261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IheJlONFtPM7ki6UXfuwGq3nIRoSOV5Cdp2p/ZTSFZo=;
        b=yuV7kREdfx12xlHlYMiKVwLBvhg9ce9BHX/pm1IYHQ7flFlOituOxMiiwEgvKXv5Gi
         uIQIZSyKQwJe9LJc6mDvuPa1cDJq4e/PRPDA5LdGzB58rKGgaqIJPw7labdgwzN/4sQN
         ujmI/7mRkneoxZcpP7Mzm3gvRYMpxqajsMLT98KeA4RPgs+lvqvSUyb5fQpxYPhW7dBG
         6A5DluTaNY5WCEfKPO+71ISjx5Q/CCsEc+bziiPn5SYxoePG/FtSdmuv5BquUbtfnXEm
         gl8CDSC6tBNbsPomzgOyR6CLHAWX7CrMWMYmuwtL1EHl9Lm+AV6JxvFyr2BiglUF890k
         c6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680270261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IheJlONFtPM7ki6UXfuwGq3nIRoSOV5Cdp2p/ZTSFZo=;
        b=dDafUGZ3QwFeQsy0quvIMjHkPrmLuM9k0KKPub6J5fzPiKCqWZi+fSJEEMv1sh8atk
         MyS+coyB60RqUDKIIXWa+nwXopPOyJS1yPymK0PXEHD0dZAAXcrVUZoKJxQnkAhSIejJ
         VkiUIu6lRFsxPSUhVPUprM7IMPRZEk/3ESAmhoNLa1sLe0Ovie1SvoiQgavj39w2GN7I
         jSvNCEOLyZ6IOePer9OG4KVWaqaPZ7jk7jUlCCVLVkiI4X/p4sEylXvQqNKzKXIrH6/g
         u7pAzXFcHd/j2qFzO9DCHtaGjTATHvpCyxKh2aLHGLhZ8qIfvC/pJXyAZUf7Ap6QYvhP
         WB7Q==
X-Gm-Message-State: AAQBX9csRSX6K7fEnJw7vG+JHZwNOrUOSNDLdnfGb5XuYbtLsOzhd1Do
        OAxczDWpyAPEUO4QMcZ1ZK/Orw==
X-Google-Smtp-Source: AKy350bWsdGPWV3KvW7SvF4FPvx7B6jlnZVlmd+/Z5hjH7yj0LVm6SlY8eEM0JoLpn55NYjAj88UEw==
X-Received: by 2002:a2e:6a0f:0:b0:295:a458:e2ce with SMTP id f15-20020a2e6a0f000000b00295a458e2cemr2810764ljc.6.1680270260918;
        Fri, 31 Mar 2023 06:44:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j15-20020a2e3c0f000000b0029d45b15338sm365817lja.42.2023.03.31.06.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 06:44:20 -0700 (PDT)
Message-ID: <a642e653-e3e2-c3d2-68cb-1efc92be05bb@linaro.org>
Date:   Fri, 31 Mar 2023 15:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
 <20230328092645.634375-3-herve.codina@bootlin.com>
 <20230330160510.GB489249@google.com> <20230331094208.41ab4420@bootlin.com>
 <6d39e9c3-fb6a-4b2a-9889-8fe8d86716d5@linaro.org>
 <20230331141104.42445da9@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331141104.42445da9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 14:11, Herve Codina wrote:
> Hi Krzysztof, Lee
> 
> On Fri, 31 Mar 2023 11:13:30 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 31/03/2023 09:42, Herve Codina wrote:
>>> Hi Lee,
>>>
>>> On Thu, 30 Mar 2023 17:05:10 +0100
>>> Lee Jones <lee@kernel.org> wrote:
>>>   
>>>> On Tue, 28 Mar 2023, Herve Codina wrote:
>>>>  
>>>>> The Lantiq PEF2256 is a framer and line interface component designed to
>>>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
>>>>> digital PCM system highway/H.100 bus.    
>>>>
>>>> My goodness!
>>>>
>>>> It's been a long time since I've seen anything quite like this.  
>>>
>>> Yes, old things but working on recent kernel.
>>>   
>>>>
>>>> My suggestion to you:
>>>>
>>>> * Split this up into components that fit functional subsystems  
>>>
>>> It is done. The audio part is present in ASoC subsystem (path 5 in this
>>> series). pinctrl function is implemented in this driver and, as I don't
>>> want to share registers, I would prefer to keep this function inside this
>>> driver.  
>>
>> The amount of defines and huge functions like pef2256_setup_e1()
>> contradict it.
>>
>> Even the pef2256_setup_e1() really does not follow Linux coding style -
>> you know the size requirement, right?
> 
> I know that pef2256_setup_e1() is quite big and I will look at a way
> to split it in a consistent way.
> 
>>
>> pef2256_get_groups_count, struct pinmux_ops and others - this is
>> pinctrl, not MFD! They cannot be in MFD driver.
> 
> Maybe the issue is that MFD was not a good choice.
> The "function" provided are not independent of each other.
> The "main" driver (pef2256.c) needs to do the setup and handle the interrupt.

Just like all PMICs...

> The "function" provided are some glues in order to be used in some sub-systems
> such as audio. Indeed, ASoC needs a codec DAI to be connected to a CPU DAI.

Just like in all other cases...

> These "functions" need to be started (ie probe()) after the pef2256 setup was
> done. So a start (probe()) order relationship is needed.

Just like in all other cases, so I really do not see here anything special.

> 
> If a MFD driver needs independent children to handle independent functions,
> the pef2256 does not fit well as a MFD driver.

Why? So far everything is exactly the same.

> 
> I switched from misc to MFD just to handle child DT nodes instead of having
> phandles. Using child DT nodes instead of phandles is really a good thing and
> need to be kept.

Your DT bindings and nodes are not related to driver design. It does not
matter for Devicetree if you put it to misc or MFD.

It does not matter for driver whether you call it in Devicetree foo or bar.

> The switch to MFD was probably not the best thing to do.

Maybe, but your existing arguments are not really related...

> 
> What do you think if I switched back the pef2256 "main" driver (pef2256.c) to
> misc ?

Why? What would it solve? You want to stuff pinctrl driver to misc, to
avoid Lee's review? No. Pinctrl goes to pinctrl. Not to misc. Not to MFD.

> 
> 
>>
>>>
>>> Also, I sent a RFC related to HDLC and PHY. In this RFC, the pef2256 is
>>> considered as a PHY and handled in the PHY subsystem.
>>>   https://lore.kernel.org/linux-kernel/20230323103154.264546-1-herve.codina@bootlin.com/
>>>   
>>>> * Run checkpatch.pl  
>>>
>>> I did.  
>>
>> There are tons of weird indentation,e.g.:
>> +#define     PEF2256_2X_PC_XPC_XLT	(0x8 << 0)
>>         ^^^^ there is only one space after #define
> 
> I ran checkpatch.pl, not checkpatch.pl --strict.
> 
> The spaces related the #define can be seen on many other drivers.
> 
> #define FOO_REG_BAR	0x10
> #define   FOO_REG_BAR_BIT0	BIT(0)
> #define   FOO_REG_BAR_BIT4	BIT(4)
> 
> The first line is the register offset and the other lines (indented) are
> the bits description related to this register.

I don't think we have such convention in general and argument that some
drivers do it in some subsystems is never a good argument. If they also
misspell things or use Hungarian notation, shall we do the same?

Although maybe it is fine for Lee. I find it unreadable.

git grep '#define  \+[A-Z]' | wc -l
73889
git grep '#define [A-Z]' | wc -l
3996054

In MFD there is only one driver doing this.

Most of other cases are net and gpu.


Best regards,
Krzysztof

