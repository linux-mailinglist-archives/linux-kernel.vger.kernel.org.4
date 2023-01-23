Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8267835D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjAWRfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjAWRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:35:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7B93D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:35:05 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso9150302wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TPRDH9sV4lQywdE8MIDkH2mPRD34wpLzx6FwcGwHA4=;
        b=Q7VYm7gpdVmiUMM6Oc/gAGdMeoSLElSlh9CuYBuNFITYKiovm18GFaKW+ZKZHztT2j
         e2CiMIxha8gEof84x2/zL7UXxpUS+ira2BG5dYObf3Oht52Si2IQ+hwF7g7DkkAGvZGf
         Z91rI42W8nK5xgNwAeeZirKSyy1jfpcLmZMh4H4gNwn0T5OA4cI+m1pay6kmCjm/jiOv
         rsSxouC+fq5Q/CvhXyBfoDfZT36EmqF+fsZjlPoTo9nmY9RhC5ZKhwK8YOsc42l1vrgb
         ksshn0o+J2hk3R1wGo6hzKUNZ6o7Njb7E5FZ3xbYj+g5GBSbeZE1Ts/6/P+EQC5zJVVr
         KCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TPRDH9sV4lQywdE8MIDkH2mPRD34wpLzx6FwcGwHA4=;
        b=IKxrlyh3AucmKPkGDN3MLsEtc3rmZ2mEVmmoy1JIqEa79YPh5GUI1cA9tAr8LrmgbN
         q+c81EJj+2zhsqcKg7iF3owJr+CiIVXIYIgAFJWoyn3LUJdhwwTo1nhIqqkaav/UNZ0o
         VPCqkazz+wyHu/67+N7BV/oY0qgC/EW3Go10UrWZfEwMOOr4OVXIhOOQZXiThGdMVux8
         R3HwOsMgu+cYGjQZk1rIbZbMR6o/AO66fgCAnP6BgVQ6erAgKoOFAvCa579gfnIVMWYo
         LvTXVRrI3sS6WCqQI5PH+/0bFoq3XV1I+BbcyOYmHs07FH6Ts9XCRBMfa9w8ad1kP0by
         fS4A==
X-Gm-Message-State: AFqh2kr/Zj+QhKwGmOjAyegFKH7IJJFtE1E4G0RFf5lZdg7W055NLzSo
        eK8842EvGq2GQOwppml+Blozsw==
X-Google-Smtp-Source: AMrXdXsHotOHlDVoYuAqjZWIFOOnSQ4gUkaIQITTVMk0yUBjqzxVd+mu8o8/i9bz9vEkx7jgM0Lgvg==
X-Received: by 2002:a7b:cc07:0:b0:3da:fcb7:39e5 with SMTP id f7-20020a7bcc07000000b003dafcb739e5mr23705787wmh.23.1674495297191;
        Mon, 23 Jan 2023 09:34:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b003daf681d05dsm12050772wms.26.2023.01.23.09.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:34:56 -0800 (PST)
Message-ID: <ac8f30a7-fc72-9a44-74b3-a69001bfdaaf@linaro.org>
Date:   Mon, 23 Jan 2023 18:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
Content-Language: en-US
To:     Thierry Reding <treding@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mohan Kumar D <mkumard@nvidia.com>, will@kernel.org,
        dmitry.baryshkov@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
 <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
 <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org> <Y8rHzJpEg7bMzYM6@arm.com>
 <fbeff3da-e03b-aa82-1a53-d92f95b63770@linaro.org> <Y86uw7QF/hMrIvbs@orome>
 <2c6deeff-bf5f-24e5-4cf2-2640ea1e7402@linaro.org> <Y87DNf1tnB8aaKJS@orome>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y87DNf1tnB8aaKJS@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 18:26, Thierry Reding wrote:
> On Mon, Jan 23, 2023 at 05:05:08PM +0100, Krzysztof Kozlowski wrote:
>> On 23/01/2023 16:58, Thierry Reding wrote:
>>> On Fri, Jan 20, 2023 at 06:00:25PM +0100, Krzysztof Kozlowski wrote:
>>>> On 20/01/2023 17:56, Catalin Marinas wrote:
>>>>> On Fri, Jan 20, 2023 at 07:20:01AM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 20/01/2023 06:48, Mohan Kumar D wrote:
>>>>>>> On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>> On 18/01/2023 12:46, Mohan Kumar D wrote:
>>>>>>>>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
>>>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>>> On 17/01/2023 19:16, Mohan Kumar wrote:
>>>>>>>>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>>>>>>>>>>> ARM64 based platforms as Intel PCI driver was used for registering the
>>>>>>>>>>> sound card.
>>>>>>>>>> It's not a part of SoC, not a common device used during debugging or
>>>>>>>>>> development, so I don't think it is reasonable to enable it. We do not
>>>>>>>>>> enable driver just because someone uses them. Otherwise please clarify
>>>>>>>>>> which board has this device embedded (not pluggable by user, but embedded).
>>>>>>>>> This change is required for enabling HDA sound registration for Nvidia
>>>>>>>>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
>>>>>>>> You can plug anything to PCI slot and we do not enable every such PCI
>>>>>>>> adapter.
>>>>>>> Without this config enabled, the Intel hda audio driver won't be built 
>>>>>>> and dGPU won't be able to register sound card. Do you have any 
>>>>>>> suggestion here?
>>>>>>
>>>>>> Without hundreds of other drivers they also won't be built and won't be
>>>>>> usable. Anyway, this is just defconfig, so it does not matter. You can
>>>>>> always enable it in your setup, why is this a problem?
>>>>>>
>>>>>> Again, we do not enable drivers for every PCI card.
>>>>>
>>>>> I don't think we have any set rules for what goes in a defconfig. If one
>>>>> has a real use-case, we tend to enable stuff in defconfig, especially if
>>>>> it's a module.
>>>>
>>>> There will be always an use case for every PCI and USB card. It's not
>>>> related to storage or networking which could justify device bringup
>>>> (rootfs). It's really not needed for any board operation. defconfig is
>>>> not for marketing products but for our development and reference platforms.
>>>
>>> If defconfig were only for boot-critical drivers, it's terribly bloated
>>
>> We enable drivers for devices present in our platforms. Everything which
>> is on such platforms. For pluggable USB/PCI/whatever third-party
>> devices, then comes the argument as boot-related.
>>
>>> as it is. We enable things like multimedia, infrared and audio. None of
>>> those are critical to booting a system. Heck, we also enable most of
>>> DRM/KMS, which are useful for boot on consumer devices, but are rarely
>>> critical on development and reference platforms.
>>>
>>> Besides, a PCI board can be considered a development platform depending
>>> on who you are.
>>>
>>> I've always looked at defconfig as more of a guideline as to what's a
>>> useful baseline configuration for an architecture.
>>
>> Yep and this one here is nowhere near that architecture. It's pluggable
>> card, not related to hardware nor arm64 (If I understood correctly). Why
>> you do not enable it on x86? Or multi_v7? or hundreds of other defconfigs?
> 
> My understanding is that the code behind SND_HDA_INTEL, despite the
> name, is in fact generic PCI HDA code and is compatible with a number of
> non-Intel devices. It's also nothing x86-specific because this code
> works on any PCI-enabled platform (it's for driving generic PCI HDA
> controllers).
> 
> It's quite common for people to hook up PCI cards on NVIDIA Jetson
> platforms (which are arm64). Often these will be NVIDIA GPUs, but they
> can be any brand of GPU, really (SND_HDA_INTEL supports hardware from a
> large number of vendors).

Like with every other board with PCI or miniPCI slots. You can hook up
there anything and we do not enable all these possible devices.

> 
>>>> The only argument behind this change is "I have a PCI card and I want it
>>>> in defconfig", but why it has to be in defconfig in the first place?
>>>> There is no reason. This is not distro...
>>>
>>> That's highly subjective and honestly that argument can go in both
>>> directions. People can, after all, start from an allnoconfig and then
>>> work their way up to something that's usable on their particular device.
>>> Or they could start from an allmodconfig and work their way down.
>>
>> I am sorry, but adding new stuff does not require arguments against.
>> Adding new stuff requires argument for it. You reverse the argumentation
>> that I need to find proves that we do not need it in mainline platforms,
>> if I got your response correctly.
> 
> Adding new stuff also doesn't require arguments in favour. At least
> that's not been my experience in kernel development. If somebody spends
> the time to write a driver, we don't tend to ask proof of why it's
> useful, we trust that they wouldn't have spent the effort if they didn't
> think it worth it.

We need that argument and submitter provides - I have a device for it.
That's the argument for including driver in the kernel. That's not an
argument good enough for including in defconfig, though.

> Besides, this is to enable support for these various HDA controllers
> that can be plugged into Jetson platforms, which very well are mainline
> platforms.
> 
>>> The point of defconfig is to give you something that's somewhere between
>>> the two extremes. Obviously if we start enabling everything, it defeats
>>> that purpose. If we prohibit the enablement of new options, we equally
>>> limit its usefulness.
>>
>> I don't think we discuss the same thing. There are no extremes here at
>> all. The patch is about enabling arm64-unrelated PCI pluggable device,
>> just because it came from @nvidia.com author. If you think some PCI
> 
> I think you're making this into something it's not. What would be the
> benefit for NVIDIA to enable something that is unused? If there's
> consensus that only boot-critical pieces should go into defconfig, then
> that's fine with me. Currently that's not the case, so painting this as
> some sort of marketing stunt is hardly fair.

As I said - no one here  speaks about boot-critical pieces. We enable
everything which is on the boards. Everything.

Now for fully user pluggable, common devices - like USB, PCI - we enable
stuff relevant to the boot.

> 
>> pluggable 3rd party device is suitable for defconfig, I will bring
>> hundreds of other drivers I am also plugging over PCI to my boards, just
>> because I want some audio.
>>
>> It's not reasonable path...
> 
> Well, then what is a reasonable path? We've had per-platform defconfigs
> on 32-bit ARM and people weren't happy about those. But if the single
> defconfig on 64-bit ARM doesn't generate a configuration that is useful
> for many people, then we don't need it. People could then just keep
> their own, local default configurations.

And what is the problem with it? It's just defconfig, so what's the big
deal for them to have out of tree patch?

For me it is big deal because I am using and building defconfig all the
time. It uses my electricity, so directly my money. It uses my time,
which is even more important than money.

If anyone wants user-pluggable devices, please add fragments or one more
defconfig, so I won't be affected by such drivers.

> 
> Surely I'm not the only one that gets annoyed if I have to tweak config
> and rebuild multiple times until I have the right configuration.
> 
> Thierry

Best regards,
Krzysztof

