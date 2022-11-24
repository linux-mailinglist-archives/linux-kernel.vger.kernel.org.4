Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E052B63757F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKXJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKXJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:46:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C4125229
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:46:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so1737024lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AHLY9tvsduLZ3njRuW/wWWCfiDjBIzVHOyfG6QyGr8=;
        b=q2QpvAlDEp2M1ST1ggUdvgHWTGfPFND9+jl3nUF37uw6ACZ3TYoqpNfK/lmnNy91R0
         NXpJXBmvNu+CalRsPTpWt2dv+WlT8cpIaKGPAgue4Y7Bh7+nwN0ISrmv06ekD4bJ5RlA
         809/yPwF/u92xz+c2V0pB9Zefvv5MD2zaxPOXOa4YfHd1HEbuvzvJ0RZWP5hqeUgpnBR
         8XN2WhqktrVYryCyLbGwR9LNM+Z+00lU6fphh+wGXl5PzCcZAiPWvsZxSNJq1M1Hpex4
         2YmHfruNsmzUV9yx81GmvewYUK7Kec2riP5tmZfCEQ0N1bsfovsmtOx35LtsWhSbXqJC
         VscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AHLY9tvsduLZ3njRuW/wWWCfiDjBIzVHOyfG6QyGr8=;
        b=HwgRmJtLHrd3yhPV0VhI0rFUDGOn0FNlx4F7hVbQt+uXTYkisYd4pEZPmtpDCKb7ti
         94M/Vydj+TDsloGx+nmIZsFS4PZ1/hNZO3GfR+Xe2mwKL0VgRUJlZBQDS/Z05eFj60rk
         WMX6UwQDWDK7tTy12GmZT5ceN7rKcpfYmI4uKwU0lHaWqV3d6VZRdHa9MULQxsBtEaQS
         Kag6qu+zR8EaCPmEIY3VTPQ5kLL5cY8w0hckIfOvbQSwZdjC8bbcRP5VQ9IvRpTzBZqk
         j94deTyUn9Q0Gd/YzaSmlqzDfpMS6OtQU0hrCJOofvZE8fxDb4atIns1HPgTtPqHQB5G
         Ygag==
X-Gm-Message-State: ANoB5pnvprpo7y1t1VrRvCT9+3VZer+m04Um7FWA3YrYtDEpmfKNu+3U
        Ryq6AG/UwTHVZgyoo3VpNK/BFw==
X-Google-Smtp-Source: AA0mqf5si/qdBp2lP358+XC7JTHyYHx6da8Z1w936M8Y+N2aXKI2RFCT+rn7cQSaqN52dC6NcAgEgg==
X-Received: by 2002:a05:6512:750:b0:4b0:a1e7:9160 with SMTP id c16-20020a056512075000b004b0a1e79160mr10030565lfs.566.1669283176500;
        Thu, 24 Nov 2022 01:46:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t18-20020a056512209200b0049a4862966fsm69509lfr.146.2022.11.24.01.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:46:15 -0800 (PST)
Message-ID: <d203a6ce-7032-a423-5158-fa551922dea1@linaro.org>
Date:   Thu, 24 Nov 2022 10:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
 <20221115150417.513955a7@bootlin.com> <20221118112349.7f09eefb@bootlin.com>
 <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com>
 <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
 <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
 <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
 <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
 <20221122100706.739cec4d@bootlin.com>
 <3856e2d8-1c16-a69f-4ac5-34b8e7f18c2b@linaro.org>
 <CAMuHMdXPndkt=+k1CAcDbH7eK=TFfS6wMu+xdqWZSCz1+hyhEA@mail.gmail.com>
 <02db6a5d-ae9d-68b5-f5c5-bebb471e0f70@linaro.org>
 <20221124103633.4fbf483f@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124103633.4fbf483f@xps-13>
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

On 24/11/2022 10:36, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> krzysztof.kozlowski@linaro.org wrote on Wed, 23 Nov 2022 10:39:41 +0100:
> 
>> On 22/11/2022 11:47, Geert Uytterhoeven wrote:
>>> Hi Krzysztof,
>>>
>>> On Tue, Nov 22, 2022 at 11:30 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:  
>>>> On 22/11/2022 10:07, Herve Codina wrote:  
>>>>> On Tue, 22 Nov 2022 09:42:48 +0100
>>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>  
>>>>>> On 22/11/2022 09:25, Geert Uytterhoeven wrote:  
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
>>>>>>> <krzysztof.kozlowski@linaro.org> wrote:  
>>>>>>>> On 21/11/2022 21:46, Geert Uytterhoeven wrote:  
>>>>>>>>>> This does not change anything. Herve wrote:
>>>>>>>>>>  
>>>>>>>>>>> probe some devices (USB host and probably others)  
>>>>>>>>>>
>>>>>>>>>> Why some can be probed earlier and some not, if there are no
>>>>>>>>>> dependencies? If there are dependencies, it's the same case with sysctrl
>>>>>>>>>> touching the register bit and the USB controller touching it (as well
>>>>>>>>>> via syscon, but that's obvious, I assume).
>>>>>>>>>>
>>>>>>>>>> Where is the synchronization problem?  
>>>>>>>>>
>>>>>>>>> The h2mode bit (and probably a few other controls we haven't figured out
>>>>>>>>> yet) in the sysctrl must be set before any of the USB devices is active.
>>>>>>>>> Hence it's safest for the sysctrl to do this before any of the USB drivers
>>>>>>>>> probes.  
>>>>>>>>
>>>>>>>> Again, this does not differ from many, many of other devices. All of
>>>>>>>> them must set something in system controller block, before they start
>>>>>>>> operating (or at specific time). It's exactly the same everywhere.  
>>>>>>>
>>>>>>> The issue here is that there are two _different drivers_ (USB host
>>>>>>> and device). When both are modular, and the driver that depends on the
>>>>>>> sysctrl setting is loaded second, you have a problem: the sysctrl change
>>>>>>> must not be done when the first driver is already using the hardware.
>>>>>>>
>>>>>>> Hence the sysctrl driver should take care of it itself during early
>>>>>>> initialization (it's the main clock controller, so it's a dependency
>>>>>>> for all other I/O device drivers).  
>>>>>>
>>>>>> I assumed you have there bit for the first device (which can switch
>>>>>> between USB host and USB device) to choose appropriate mode. The
>>>>>> bindings also expressed this - "the USBs are". Never said anything about
>>>>>> dependency between these USBs.
>>>>>>
>>>>>> Are you saying that the mode for first device cannot be changed once the
>>>>>> second device (which is only host) is started? IOW, the mode setup must
>>>>>> happen before any of these devices are started?
>>>>>>
>>>>>> Anyway with sysctrl approach you will have dependency and you cannot
>>>>>> rely on clock provider-consumer relationship to order that dependency.
>>>>>> What if you make all clocks on and do not take any clocks in USB device?
>>>>>> Broken dependency. What if you want to use this in a different SoC,
>>>>>> where the sysctrl does not provide clocks? Broken dependency.  
>>>>>
>>>>> The issue is really related to the Renesas sysctrl itself and not related
>>>>> to the USB drivers themselves.
>>>>> From the drivers themselves, the issue is not seen (I mean the driver
>>>>> takes no specific action related to this issue).
>>>>> If we change the SOC, the issue will probably not exist anymore.  
>>>>
>>>> Yeah, and in the next SoC you will bring 10 of such properties to
>>>> sysctrl arguing that if one was approved, 10 is also fine. Somehow
>>>> people on the lists like to use that argument - I saw it somewhere, so I
>>>> am allowed to do here the same.  
>>>
>>> Like pin control properties? ;-)
>>> This property represents a wiring on the board...
>>> I.e. a system integration issue.
>>>   
>>>> I understand that the registers responsible for configuration are in
>>>> sysctrl block, but it does not mean that it should be described as part
>>>> of sysctrl Devicetree node. If there was no synchronization problem,
>>>> this would be regular example of register in syscon which is handled
>>>> (toggled) by the device (so USB device/host controller). Since there is
>>>> synchronization problem, you argue that it is correct representation of
>>>> hardware. No, it is not, because logically in DT you do not describe
>>>> mode or existence of other devices in some other node and it still does
>>>> not describe this ordering.  
>>>
>>> So we have to drop the property, and let the sysctrl block look
>>> for <name>@<reg> nodes, and check which ones are enabled?
>>>
>>> Running out of ideas...  
> 
> I'm stepping in, hopefully I won't just be bikeshedding on something
> that has already been discussed but here is my grain of salt.
> 
>> One solution could be making USB nodes children of the sysctrl block which:
>> 1. Gives proper ordering (children cannot start before parent)
>> regardless of any other shared resources,
>> 2. Allows to drop this mode property and instead check what type of
>> children you have and configure mode depending on them.
>>
>> However this also might not be correct representation of hardware
>> (dunno...), so I am also running out of ideas.
> 
> I see what you mean here, but AFAICS that is clearly a wrong
> representation of the hardware. Sorting nodes by bus seems the aim of
> device tree because there is a physical relationship, that's why we
> have (i2c as an example):
> 
> 	ahb {
> 		foo-controller@xxx {
> 			reg = <xxx>;
> 		};
> 	};
> 
> But what you are describing now is conceptually closer to:
> 
> 	clk-controller {
> 		foo-controller {
> 			reg = ?
> 		};
> 	};

Which is not a problem. reg can be anything - offset from sysctrl node
or absolute offset. We have it in many places already. What's the issue
here?

> 
> Not mentioning that this only works once, because foo-controller might
> also need other blocks to be ready before probing and those might
> be different blocks (they are the same in the rzn1 case, but
> more generally, they are not).

But what is the problem of needing other blocks? All devices need
something and we solve it...

> So in the end I am not in favor of this
> solution.
> 
> If we compare the dependency between the USB device controller and the
> sysctrl block which contains the h2mode register to existing
> dependencies, they are all treated with properties. These properties,
> eg:
> 
> 	foo-controller {
> 		clocks = <&provider [index]>;
> 	};
> 
> were initially used to just tell the consumer which resource it should
> grab/enable. If the device was not yet ready, we would rely on the
> probe deferral mechanism to try again later. Not optimal, but not
> bad either as it made things work. Since v5.11 and the addition of
> automatic device links, the probe order is explicitly ordered.
> <provider> could always get probed before <foo-controller>. So, isn't
> what we need here? What about the following:
> 
> 	sysctrl {
> 		h2mode = "something";
> 	};
> 
> 	usb-device {
> 		h2mode-provider = <&sysctrl>;
> 	};

No, because next time one will add 10 of such properties:
sysctrl {
	h2mode = ""
	g2mode = ""
	i2mode = ""
	....
}

and keep arguing that because these registers are in sysctrl, so they
should have their own property in sysctrl mode.

That's not correct representation of hardware.
> 
> We can initially just make this work with some additional logic on both
> sides. The USB device controller would manually check whether sysctrl
> has been probed or not (in practice, because of the clocks and power
> domains being described this will always be a yes, but IIUC we want to
> avoid relying on it) and otherwise, defer its probe. On the sysctrl side
> it is just a matter of checking (like we already do):
> 
> 	if (!sysctrl_priv)
> 		return -EPROBE_DEFER;
> 
> To be honest I would love to see the device link mechanism extended to
> "custom" phandle properties like that, it would avoid the burden of
> checking for deferrals manually, aside with boot time improvements. If
> we go this way, we shall decide whether we want to:
> * extend the list of properties that will lead to a dependency creation [1]
> * or maybe settle on a common suffix that could always be used,
>   especially for specific cases like this one where there is an
>   explicit provider-consumer dependency that must be fulfilled:
> 
> 	DEFINE_SUFFIX_PROP(provider, "-provider", "#provider-cells")
> 
> * or perhaps extend struct of_device_id to contain the name of the
>   properties pointing to phandles that describe probe dependencies with:
> 
> 	char *provider_prop_name;
> 	char *provider_cells_prop_name;
> 
>   and use them from of/property.c to generate the links when relevant.
> 
> [1] https://elixir.bootlin.com/linux/v6.0/source/drivers/of/property.c#L1298
> 
> 
> Thanks,
> Miquèl

Best regards,
Krzysztof

