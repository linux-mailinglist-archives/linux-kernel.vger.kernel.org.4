Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A2669311C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBKMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBKMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:51:28 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EC4232;
        Sat, 11 Feb 2023 04:51:24 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pQpLF-002hh1-Am; Sat, 11 Feb 2023 13:50:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=d9+iGEgIwRxflVdlATRLt0hCy8G+dB+4w5pm+7iqI14=; b=PI/Q80g4tetscIgyvihMyUpGh4
        nnz/oFO9lfOvUvBmHx6ol16tXHqmEtPREVxnK64egg8NBbUoVRq4w7jWclL/v6yJmQ8FKcUI/6kAe
        Tluxm2ghldkUGi25fB//AJj7256gClRKKfq++VK+FveHCiLOcwMXxjpnHMwrjqa/OEWxTB4nybMQx
        g6Am0BU6vsrE7GwPICQIk9l25oHglOgzPNfzhU5MFHFz/qYIy0VLfkcnXFGwRuNu5TFkKUXHHJKyV
        ScYTpaM0ifzPej26OTfLMh2InAhJGOm1HpCvW8OmTLsbDxO4mGXCEESF6Pol+tL0sY8dKPVmsMTpw
        X4883lPg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=d9+iGEgIwRxflVdlATRLt0hCy8G+dB+4w5pm+7iqI14=; b=fJgY/eWzvmTTCcO7ad/pIzRmpZ
        Gp+xQX7tyZnZk4va0rRX26ficlzosr7VBrv4ZWLskyTQkhSpX8DQaVkAeZbm1J5MzKyx/AdFaxAPH
        1o0SAnFsLzvfEZ5wp+vOi+ub7VPpy8q4NQPxatyRhhlG+W1Pb3NFQlFsUOTCIxlrn8JiUioSt3ESd
        EC0+saalsfrqNkIItLn8kxRH0G6bBHj/R0vBx7lq0fSr7Gph28lDfIC6K2qF7Rr+SgMB0CnRW6s85
        HhIERDokogpKV6zMMKhkp7KQug16pUV5EtA+38+f73pIayL+59gBH6zALtuePrKhEpCsna64/mk0d
        4NqvmPbQ==;
Received: from [2a02:908:1b0:8800:b4d0:2d46:3866:fddf]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pQpLC-000diM-25; Sat, 11 Feb 2023 13:50:56 +0100
Message-ID: <ba463d40-3d39-a621-b198-191fdbe239a1@feldner-bv.de>
Date:   Sat, 11 Feb 2023 13:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
 <20230210082936.qefzz4fsp3jpalvp@houat>
 <20230210094425.474cfba5@donnerap.cambridge.arm.com>
 <20230210100620.z6j7rvkiwyu7paij@houat>
 <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
From:   pelzi@flying-snail.de
In-Reply-To: <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.02.23 um 11:18 schrieb Andre Przywara:
> On Fri, 10 Feb 2023 11:06:20 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>
>> On Fri, Feb 10, 2023 at 09:44:25AM +0000, Andre Przywara wrote:
>>> On Fri, 10 Feb 2023 09:29:36 +0100
>>> Maxime Ripard <maxime@cerno.tech> wrote:
>>>
>>> Hi Maxime,
>>>
>>> thanks for the reply!
>>>    
>>>> On Thu, Feb 09, 2023 at 08:29:52PM +0000, Andre Przywara wrote:
>>>>>>>>    &pio {
>>>>>>>> +	/* 1ï¿½s debounce filter on both IRQ banks */
>>>>>>> Is that supposed to be <micro> in UTF-8? It seems to have got lost in
>>>>>>> translation, or is that just me?
>>>>>> O yes, the Greek character slipped into the comment.
>>>>>>>> +	input-debounce = <1 1>;
>>>>>>> As mentioned above, I am not so sure this is generic enough to put it
>>>>>>> here for PA. And what is the significance of "1 us", in particular? Is
>>>>>>> that just the smallest value?
>>>>>> Yes indeed it's a bit more complicated than I feel it needs to be. The
>>>>>> configuration is taken as microseconds and translated into the best
>>>>>> matching clock and divider by the driver. However, 0 is not translated
>>>>>> to the lowest divider of the high speed clock as would be logical if
>>>>>> you ask for zero microseconds, but to "leave at default". The default
>>>>>> of the board is 0 in the register, translating to lowest divider on the
>>>>>> _low_ speed clock.
>>>>> I'd say the "if (!debounce) continue;" code is just to defend against
>>>>> the division by zero, which would be the next statement to execute.
>>>>>
>>>>> We might want to change that to interpret 0 as "lowest possible", which
>>>>> would be 24MHz/1. Please feel free to send a patch in this regard, and
>>>>> CC: Maxime, to get some input on that idea.
>>>> I never had any complaint on that part either, so the default looks sane
>>>> to me.
>>>>
>>>> If some board needs a higher debouncing rate, then we should obviously
>>>> set it up in the device tree of that board, but changing it for every
>>>> user also introduces the risk of breaking other boards that actually
>>>> require a lower debouncing frequency.
>>> Yeah, we definitely should keep the default at 32KHz/1, as this is also
>>> the hardware reset value.
>>>
>>> Not sure if you were actually arguing this, but the change I sketched
>>> above (interpreting 0 as 24MHz/1) is separate though, as the current
>>> default is "no DT property", and not 0. There is no input-debounce
>>> property user in the kernel tree at the moment, so we wouldn't break
>>> anyone. The only thing that would change is if a downstream user was
>>> relying on "0" being interpreted as "skip the setup", which isn't
>>> really documented and could be argued to be an implementation detail.
>>>
>>> So I'd suggest to implement 0 as "lowest possible", and documenting that
>>> and the 32KHz/1 default if no property is given.
>> Ah, my bad.
>>
>> There's another thing to consider: there's already a generic per-pin
>> input-debounce property in pinctrl.
>>
>> Since we can't control it per pin but per bank, we moved it to the
>> controller back then, but there's always been this (implicit)
>> expectation that it was behaving the same way.
>>
>> And the generic, per-pin, input-debounce documentation says:
>>
>>> Takes the debounce time in usec as argument or 0 to disable debouncing
>> I agree that silently ignoring it is not great, but interpreting 0 as
>> the lowest possible is breaking that behaviour which, I believe, is a
>> worse outcome.
> Is it really? If I understand the hardware manuals correctly, we cannot
> really turn that feature off, so isn't the lowest possible time period (24
> MHz/1 at the moment) the closest we can get to "turn it off"? So
> implementing this would bring us actually closer to the documented
> behaviour? Or did I get the meaning of this time period wrong?
> At least that's my understanding of how it fixed Andreas' problem: 1µs
> is still not "off", but much better than the 31µs of the default. The new
> 0 would then be 0.041µs.
I would fully agree. There seems to be no way to turn off the debouncing
filter, and in terms of that filter, the lowest possible time is closest 
to "off".
The SoC default is equivalent to 31 us, far, far away from "off", the 
currently
configurable minimum is 1us.

I did a patch that enables to set "0" in the device tree configuration 
and it
takes care not to do a #div0, but to determine the lowest possible time. As
the patch is done in the driver for a device that cannot switch off 
debouncing,
I'd say, the driver patched in that way does its best to come as close 
to the
intended outcome as is possible.

I tested this setting on the Banana M2 Zero board, and it is working (does
the right thing setting the relevant registers to value 0x0001, and the 
board
works in general, w/o producing smoke. (I have no idea how to test if
the debouncing filter is actually faster with setting "0" than with 
setting "1",
I can only confirm it is not significantly slower).

If we can agree on a concrete way to go I'm happy to try to produce a new
patch version. My suggestion from the discussion:

- Change drivers/pinctrl/sunxi/pinctrl-sunxi.c to set the minimum
    possible filter time when input-debounce is configured to "0"
    (corresponding to 1 on the affected hardware register).
    What I don't like is the huge gap between configuration 1 and 0, but
    I have no idea what to do about it without breaking all compatibility.

- in arch/arm/boot/dts/sunxi-h3-h5.dtsi, set input-debounce <31 31>
    corresponding to the default "0" in both affected hardware registers.
    Note that the clocks hosc and losc that make this 31 map to 0 are
    configured exactly here.

- in arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts, set
    input-debounce <31 0> as this board has electronic devices
    attached to bank G and only exposes bank A to its users.
    I'd like to advertise on that one: this board does not require
    debouncing on bank G. Plus it feels the board got more stable
    by this setting: my BananaPi is connected via WiFi (only) and in the
    past it went apparently dead every other day or so. Nothing like
    this happened after switching off input debounce. Anectdotal
    evidence, I know...

- (in my devicetree overlay, I set input-debounce <0 0> to make IRQ
    based drivers like drivers/iio/humidity/dht11.c work on bank A) -
    not part of the patch.

Would that appear right?

Best regards,

Andreas.

PS: Perhaps someone can point me to further reading regarding
drivers for electronic devices attached to GPIO. Assuming I want
to attach a device to a GPIO that is not accidentally covered by
hardware support of the pinctrl subsystem, what options do I
have _apart_ from registering edge IRQs to react on a digital
signal from that device? Isn't it called bit-banging and the
usual technique?

