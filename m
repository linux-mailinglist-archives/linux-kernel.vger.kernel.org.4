Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAD6A06DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjBWK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjBWK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:59:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156EB474;
        Thu, 23 Feb 2023 02:59:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k14so12313561lfj.7;
        Thu, 23 Feb 2023 02:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwgI0W9mSCQx+OfiolXpoLKChj85RiWCAIb74m80ZB8=;
        b=cybRpt1DGb0ASh4VUJ6VVn96cG+t5goJa6YbJdgl5GKyQmMk32wtUI1tV55azLI1Aw
         OUJW6QRWrhoKXprvfyVA6Hf7Z61bovHOQU57fpITgDtTAXoQS3wLdylkN0pgFbloPH2d
         IRzxvtdx1I6P+4PI+bG7jF9jYk0GBWQJzV5FIIksys8Zk8sUtpdLE6d6XKpVQzwjB3TM
         NrQZfO0uA0/Mpd0oeyEKudaidEYItb1loct2/YxC9Qj+M6Ug2//PCcg0gB4CagswBTJ8
         ZvUMPJ+f4A10byo+OivJ4INWTUL8AKwfdgF5Fb7xfD12h38ShI0idKDXj+GiiAGLfzIh
         LLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwgI0W9mSCQx+OfiolXpoLKChj85RiWCAIb74m80ZB8=;
        b=kue0wf9sUOYzf/4po1F25INGKo0s6urv5H5ueg9blX2/qk7lgyXaOYIMnHz9OjAYrv
         zS12Hjgh96spCp9+3xuFtNGaSutJAK7v2eKCOrEhM3kh6U4s/GZKYpw6P+fmI/1eamo1
         AU7cj/NHYNXyKoRERgA/ObNzPeQ/ZHbcIYNrYqu0lGEbIfyVxDS7CLs1piAtq0aofidx
         veZ/4GSeVAK515Ymk2q0SUsq01oursLSpucf6o+xQelSNJGAxYP/ZDNaiywQNmD2DumS
         QXBmBieUxXKVOEbXNrj1tFSoQxoKG8mI09zvTlTUFpbBC5vMo9AlzLxBW6krINZDbaSw
         Mk9w==
X-Gm-Message-State: AO0yUKVSrpx678kfVo4Zd2VkZgKPd+wBV/8HyiGzOgiYozjhzymEhCX7
        KoZ2y6+DyATPgXUBfEUD6f0=
X-Google-Smtp-Source: AK7set9v8Ue/45J6ZfsE0E1+iF169cfZ/M8pzKAeEBsk1kGvMnjX/nJuYEEhpM/6mxK2Vrr803o+Rg==
X-Received: by 2002:a05:6512:48c:b0:4db:ee9:7684 with SMTP id v12-20020a056512048c00b004db0ee97684mr3653596lfq.56.1677149971482;
        Thu, 23 Feb 2023 02:59:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id b1-20020a056512218100b004db3aa3c542sm448442lft.47.2023.02.23.02.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:59:31 -0800 (PST)
Message-ID: <f8b2115d-b0ea-75f9-b76f-b7979d705362@gmail.com>
Date:   Thu, 23 Feb 2023 12:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
 <e6b2a6f4-d710-7f74-e85d-1cd3f5b96460@linaro.org>
 <101db5e2-e878-b751-9679-6ea45eb24c26@fi.rohmeurope.com>
 <33abc8a3-39f7-af7c-9676-723228624b0f@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
In-Reply-To: <33abc8a3-39f7-af7c-9676-723228624b0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 11:26, Krzysztof Kozlowski wrote:
> On 23/02/2023 07:20, Vaittinen, Matti wrote:
>> On 2/22/23 20:57, Krzysztof Kozlowski wrote:
>>> On 22/02/2023 17:14, Matti Vaittinen wrote:
>>>> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
>>>> capable of detecting a very wide range of illuminance. Typical application
>>>> is adjusting LCD and backlight power of TVs and mobile phones.
>>>>
>>>> Add initial dt-bindings.
>>>
>>> Driver can be "initial", but bindings better to be closer to complete,
>>> even if not used by the driver currently.
>>
>> Out of the curiosity - why is that? (Please, don't take me wrong, I am
>> not trying to argue against this - just learn the reason behind). I
>> can't immediately see the harm caused by adding new properties later
>> when we learn more of hardware. (and no, I don't expect this simple IC
>> to gain at least many properties).
> 
> Linux drivers change, but the hardware does not, thus DTS, which
> describes the hardware, can be complete. It should be written based on
> the hardware, not based on Linux drivers. If you add incomplete
> bindings, this suggests you wrote them to match your driver, not to
> match hardware. This in turn (adjusting bindings to driver) makes them
> less portable, narrowed to one specific driver implementation and more
> ABI-break-prone later.
> 
> Imagine you that clock inputs, which you skipped in the binding, were
> actually needed but on your board they were enabled by bootloader. The
> binding is then used on other systems or by out of tree users. On your
> new system the clocks are not enabled by bootloader anymore, thus you
> add them to the binding. They are actually required for device to work,
> so you make them required. But all these other users cannot be fixed...
> 
> What's more, incomplete binding/DTS is then used together with other
> pieces - DTS and driver, e.g. via some graphs or other
> phandles/supplies/pinctrl. So some other DTS or driver code might rely
> on your particular binding. Imagine you had only vdd-supply regulator,
> but no reset pins, so the only way to power-cycle device was to turn
> off/on regulator supply. Then you figure out that you have reset pins
> and it would be useful to add and use it. But already drivers are
> written to power cycle via regulator... or even someone wrote new driver
> regulator-pwrseq to power cycle your device due to missing reset GPIOs...

Thanks for explanation Krzysztof. I think that what you wrote here makes 
sense. Still, I don't think this "adding features only later can cause 
problems to others" is in any way fundamentally different for bindings 
and software. Sure this clock example is a valid thing, adding a clock 
later could cause kernel to suddenly be aware of it can disable it - but 
disabling the clock would still require a new piece of clk driver too...

I think same problems can happen when lower layer SW does not implement 
all the features - upper layers may need to implement some odd quircks 
and workarounds to get things working, and all that can be useless or 
even incompatible with the new low-level SW which finally adds the 
missing implementation.

I guess the 'fundamental' difference I was looking for is that the 
hardware itself should not change - so in theory we should know the HW 
from the day 1. Still, we (I) at times notice we need some information 
about the hardware only when we are (I am) writing the drivers ;) 
Unfortunately there are companies where all the information about the 
hardware is not immediately available ...

Out of the curiosity 2 (an no need to respond if you're in hurry) - how 
should one treat hardware logic which is implemented on FPGA? I have in 
the past worked for a good while on a project where FPGA blocks were 
also described in dt - but this _really_ blurs the line between 
"immutable" hardware and "mutable" software. (And yes, we had a great 
deal of "fun" with updating the FPGA images, FPGA device-trees, linux 
images and board device-trees...)

Anyways, I agree with you. It would be good to have as complete bindings 
as possible from the day 1.

By the way - planning to attend ELCE next summer? It'd be great to have 
a lecture part II about writing the bindings ;)

Yours,
	--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

