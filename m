Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3246780D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjAWQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjAWQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:05:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3495CDE7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:05:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m15so9411440wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJgifFmGKk6Gfq2X/5CS219yGWLFL5yq1TqTmMEdkvw=;
        b=f5XgxvFPIvIsXmxqJSz92xPHu6e7Sqwn6t0wdJLFkRC+ZYzCCNOBeqo9PuxZaPq1l6
         T5wgiG2s4UqLpKt0/GbHslbaRTn6sD2KDjRS+4V23ibZZP9KCUXcVbTi5+f0pHQ235QU
         kqsi+pxTqkEfAJABydRntloYWApftMUAyOsJ5/5ObUt4eMm2fMENcR3LUdsvgleK+qH6
         l6+qAn+9Zy61fx4Uf8xrbsxHBfHqVkLAXyATUj12LjVYmVX98euyGSrPNIX2Dtf9PVPN
         s4xT9VC+qWPeieaZBGzefGbJ9Ed4c9nYMAzSbX3HNAJggRSnZe3s7+VHB5f1r9wX7uFp
         o1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJgifFmGKk6Gfq2X/5CS219yGWLFL5yq1TqTmMEdkvw=;
        b=uDhwhagBrJBGl3IEsREEIQBcbAm1Q1IMUxmo3fXoze/rzvFpIQ34e6Dco+FiFXQozS
         uq8b/eYgiQ69iPnVF7PJk5vpPIpsh6k7yhQXquEfI6P+IJbW+5mVG/bNzAtvjmgzTpga
         oAWRbJ9XwMsO+tWvCIVFeIK+4iAKzaM0YHfPMinrIh/tfHHGZBwU0OkM59dEvekJJ2ca
         1/mBoPy9UUZbDypTVCw+hvsrtI51JKDbvFhIK6BNU/G5UoKa74O/w+mVBfMHFGZmFEfJ
         MlX03VVQ6nfVTF81EP4+IBgNgEWU1QeAQftCs+6nN1AivNzKl3Synh1hkZvn+vE/fmZC
         v9lQ==
X-Gm-Message-State: AFqh2kqKvYQbdox/SXxwymzIH1lzrhOPjWJ317kTqKbMkno7JI2cJee6
        Dp0ktgTmfSOf0eCIw9PBtjPQXw==
X-Google-Smtp-Source: AMrXdXsWd0Cg0Uulq35fIxYBAqgC/elNmQsg6JJeYqTcYAa60KFPeG6235hdvVANeGjvOUgpNVrI6A==
X-Received: by 2002:a05:600c:3b05:b0:3d6:b691:b80d with SMTP id m5-20020a05600c3b0500b003d6b691b80dmr24723408wms.21.1674489910461;
        Mon, 23 Jan 2023 08:05:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003d1e3b1624dsm12367377wmq.2.2023.01.23.08.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:05:10 -0800 (PST)
Message-ID: <2c6deeff-bf5f-24e5-4cf2-2640ea1e7402@linaro.org>
Date:   Mon, 23 Jan 2023 17:05:08 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y86uw7QF/hMrIvbs@orome>
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

On 23/01/2023 16:58, Thierry Reding wrote:
> On Fri, Jan 20, 2023 at 06:00:25PM +0100, Krzysztof Kozlowski wrote:
>> On 20/01/2023 17:56, Catalin Marinas wrote:
>>> On Fri, Jan 20, 2023 at 07:20:01AM +0100, Krzysztof Kozlowski wrote:
>>>> On 20/01/2023 06:48, Mohan Kumar D wrote:
>>>>> On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>> On 18/01/2023 12:46, Mohan Kumar D wrote:
>>>>>>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>> On 17/01/2023 19:16, Mohan Kumar wrote:
>>>>>>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>>>>>>>>> ARM64 based platforms as Intel PCI driver was used for registering the
>>>>>>>>> sound card.
>>>>>>>> It's not a part of SoC, not a common device used during debugging or
>>>>>>>> development, so I don't think it is reasonable to enable it. We do not
>>>>>>>> enable driver just because someone uses them. Otherwise please clarify
>>>>>>>> which board has this device embedded (not pluggable by user, but embedded).
>>>>>>> This change is required for enabling HDA sound registration for Nvidia
>>>>>>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
>>>>>> You can plug anything to PCI slot and we do not enable every such PCI
>>>>>> adapter.
>>>>> Without this config enabled, the Intel hda audio driver won't be built 
>>>>> and dGPU won't be able to register sound card. Do you have any 
>>>>> suggestion here?
>>>>
>>>> Without hundreds of other drivers they also won't be built and won't be
>>>> usable. Anyway, this is just defconfig, so it does not matter. You can
>>>> always enable it in your setup, why is this a problem?
>>>>
>>>> Again, we do not enable drivers for every PCI card.
>>>
>>> I don't think we have any set rules for what goes in a defconfig. If one
>>> has a real use-case, we tend to enable stuff in defconfig, especially if
>>> it's a module.
>>
>> There will be always an use case for every PCI and USB card. It's not
>> related to storage or networking which could justify device bringup
>> (rootfs). It's really not needed for any board operation. defconfig is
>> not for marketing products but for our development and reference platforms.
> 
> If defconfig were only for boot-critical drivers, it's terribly bloated

We enable drivers for devices present in our platforms. Everything which
is on such platforms. For pluggable USB/PCI/whatever third-party
devices, then comes the argument as boot-related.

> as it is. We enable things like multimedia, infrared and audio. None of
> those are critical to booting a system. Heck, we also enable most of
> DRM/KMS, which are useful for boot on consumer devices, but are rarely
> critical on development and reference platforms.
> 
> Besides, a PCI board can be considered a development platform depending
> on who you are.
> 
> I've always looked at defconfig as more of a guideline as to what's a
> useful baseline configuration for an architecture.

Yep and this one here is nowhere near that architecture. It's pluggable
card, not related to hardware nor arm64 (If I understood correctly). Why
you do not enable it on x86? Or multi_v7? or hundreds of other defconfigs?

> 
>> The only argument behind this change is "I have a PCI card and I want it
>> in defconfig", but why it has to be in defconfig in the first place?
>> There is no reason. This is not distro...
> 
> That's highly subjective and honestly that argument can go in both
> directions. People can, after all, start from an allnoconfig and then
> work their way up to something that's usable on their particular device.
> Or they could start from an allmodconfig and work their way down.

I am sorry, but adding new stuff does not require arguments against.
Adding new stuff requires argument for it. You reverse the argumentation
that I need to find proves that we do not need it in mainline platforms,
if I got your response correctly.

> 
> The point of defconfig is to give you something that's somewhere between
> the two extremes. Obviously if we start enabling everything, it defeats
> that purpose. If we prohibit the enablement of new options, we equally
> limit its usefulness.

I don't think we discuss the same thing. There are no extremes here at
all. The patch is about enabling arm64-unrelated PCI pluggable device,
just because it came from @nvidia.com author. If you think some PCI
pluggable 3rd party device is suitable for defconfig, I will bring
hundreds of other drivers I am also plugging over PCI to my boards, just
because I want some audio.

It's not reasonable path...

Best regards,
Krzysztof

