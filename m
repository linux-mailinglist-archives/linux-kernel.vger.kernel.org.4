Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E17696D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjBNSuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjBNSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:50:09 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96584213;
        Tue, 14 Feb 2023 10:50:05 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pS0N1-003KS1-3V; Tue, 14 Feb 2023 19:49:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2C4aeKAe8VY8+pv0anL8fCqEXWngPgoeMUda/EN7w8E=; b=LL5LUcmQ/eG9FYZMk/N4hTTFNQ
        XtKDSrpv2MCyBU8fEF/+/VtUkN+TZdiONWWs12XCsNEgompxkWaDHRskvZtZfa9rTb/32ABkbz0lj
        CMxUtkMHORsgH6NyUd3BwFKGYxclLWoo3vFjjM7VBEZLkvItd03c3qPtQNzYgNCVR0RFnmjWg8pwa
        3qPiILWti9UHaNFyB2EWdmNoK01YKS0h1RzHCZdvJFkifbrOeJYzShQMqtZzjRba0SXhTi+cZyYuj
        JaUfAe8XU8iC9ZQmWzHcTC0RuxsJ62d2B3He+0UPz3Hm8QCNnPujww8WSyuufvKdnaAnhCbxxOVvs
        g7qfreYw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2C4aeKAe8VY8+pv0anL8fCqEXWngPgoeMUda/EN7w8E=; b=J8A+WU+1RszoFo/SYXYucB+Oxy
        GSEdtFDaNeYXvru7Z2cxPg9e/LMrXkXEJXBp8AHzR+938MCnEBf0Z9ebfqwMvffQZ6TsWACHnuK/z
        gEmygxN1YcRJurYAEufm0eqhceZazgDYGICqnqrKCzVh+fZZ1USAksAOkT71T4gaXJ7KupIzgbACM
        Ql0QnIcweieVhEHwtOKHmIRNdhNWZM1H6cYsbS7caVu+X1HOWFxVz7DxYrp4c8McHtPwL6ffL3eTX
        dp9EZmawhi/q3Eh5cogCpNVCswV6SIy9eqzmz5fwP4sskLlcoHN9UptY0wTgmJYjlNBIE/DlifGvS
        nrJuqnwQ==;
Received: from [2a02:908:1b0:8800:fde1:4058:38b:64cf]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pS0Mz-0004Ik-5r; Tue, 14 Feb 2023 19:49:38 +0100
Message-ID: <9e7c91d0-d818-7990-2eb4-af02515098ec@flying-snail.de>
Date:   Tue, 14 Feb 2023 19:49:36 +0100
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
 <20230213084329.ulckaigwd7dof37u@houat>
 <c3dda403-6963-040a-3827-443edf0a377a@flying-snail.de>
 <20230213091803.bxle6ly2sapodsbs@houat>
 <20230213115652.3ab4f25c@donnerap.cambridge.arm.com>
From:   pelzi@flying-snail.de
In-Reply-To: <20230213115652.3ab4f25c@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.02.23 um 12:56 schrieb Andre Przywara:
> On Mon, 13 Feb 2023 10:18:03 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
>> On Mon, Feb 13, 2023 at 09:49:55AM +0100, pelzi@flying-snail.de wrote:
>>> Am 13.02.23 um 09:43 schrieb Maxime Ripard:
>>>> On Fri, Feb 10, 2023 at 10:18:14AM +0000, Andre Przywara wrote:
>>>>>>> Not sure if you were actually arguing this, but the change I sketched
>>>>>>> above (interpreting 0 as 24MHz/1) is separate though, as the current
>>>>>>> default is "no DT property", and not 0. There is no input-debounce
>>>>>>> property user in the kernel tree at the moment, so we wouldn't break
>>>>>>> anyone. The only thing that would change is if a downstream user was
>>>>>>> relying on "0" being interpreted as "skip the setup", which isn't
>>>>>>> really documented and could be argued to be an implementation detail.
>>>>>>>
>>>>>>> So I'd suggest to implement 0 as "lowest possible", and documenting that
>>>>>>> and the 32KHz/1 default if no property is given.
>>>>>> Ah, my bad.
>>>>>>
>>>>>> There's another thing to consider: there's already a generic per-pin
>>>>>> input-debounce property in pinctrl.
>>>>>>
>>>>>> Since we can't control it per pin but per bank, we moved it to the
>>>>>> controller back then, but there's always been this (implicit)
>>>>>> expectation that it was behaving the same way.
>>>>>>
>>>>>> And the generic, per-pin, input-debounce documentation says:
>>>>>>    
>>>>>>> Takes the debounce time in usec as argument or 0 to disable debouncing
>>>>>> I agree that silently ignoring it is not great, but interpreting 0 as
>>>>>> the lowest possible is breaking that behaviour which, I believe, is a
>>>>>> worse outcome.
>>>>> Is it really? If I understand the hardware manuals correctly, we cannot
>>>>> really turn that feature off, so isn't the lowest possible time period (24
>>>>> MHz/1 at the moment) the closest we can get to "turn it off"? So
>>>>> implementing this would bring us actually closer to the documented
>>>>> behaviour? Or did I get the meaning of this time period wrong?
>>>>> At least that's my understanding of how it fixed Andreas' problem: 1µs
>>>>> is still not "off", but much better than the 31µs of the default. The new
>>>>> 0 would then be 0.041µs.
>>>> My point was that the property we share the name (and should share the
>>>> semantics with) documents 0 as disabled. We would have a behavior that
>>>> doesn't disable it. It's inconsistent.
>>>>
>>>> The reason doesn't really matter, we would share the same name but have
>>>> a completely different behavior, this is super confusing to me.
>>> I got the point. As far as I can tell from the datasheet, it is not possible
>>> to actually switch off input-debounce. But as a debounce filter is actually
>>> a low-pass filter, setting the cut-off frequency as high as possible,
>>> appears to be the equivalent to switching it off.
>> It's not really a matter of hardware here, it's a matter of driver
>> behavior vs generic behavior from the framework. The hardware obviously
>> influences the former, but it's marginal in that discussion.
>>
>> As that whole discussion shows, whether the frequency would be high
>> enough is application dependent, and thus we cannot just claim that it's
>> equivalent in all circumstances.
>>
>> Making such an assumption will just bite someone else down the road,
>> except this time we will have users (you, I'd assume) relying on that
>> behavior so we wouldn't be able to address it.
>>
>> But I also agree with the fact that doing nothing with 0 is bad UX and
>> confusing as well.
>>
>> I still think that we can address both by just erroring out on 0 /
>> printing an error message so that it's obvious that we can't support it,
>> and we wouldn't change the semantics of the property either.
>>
>> And then you can set the actual debouncing time you need instead of
>> "whatever" in the device tree.
> I am on the same page with regards to discouraging 0 as a proper value, and
> that we should warn if this is being used.
> However I think we should at the same time try to still get as low as
> possible when 0 is specified. The debounce property uses microseconds as
> the unit, but even the AW hardware allows us to go lower than this. So we
> would leave that on the table, somewhat needlessly: input-debounce = <1>
> would give us 1333 ns, when the lowest possible is about 42 ns (1/24MHz).
>
> So what about the following:
> We document that 0 does not mean off, but tries to get as low as possible.
> If the driver sees 0, it issues a warning, but still tries to lower the
> debounce period as much as possible, and reports that, like:
> [1.2345678] 1c20800.pinctrl: cannot turn off debouncing, setting to 41.7 ns
That would be trivial to implement. My only concern: this
leaves no way to configure the minimum setting without getting a
warning.

I'd like to show the acutally selected timing for values >= 1 as well (level
info, though), as it hardly ever exactly matches the value given.
> Alternatively we use a different property name, if that is a concern. We
> could then use nanoseconds as a unit value, and then can error out on 0.
> Re-using input-debounce is somewhat dodgy anyway, since the generic
> property is for a single value only, per pin (in the pinmux DT node, not
> in the controller node), whereas we use an array of some non-obvious
> subset of ports.

How to avoid breaking existing devicetrees? Wouldn't it be required to
handle input-debounce as well, but somehow obsolete it?

Cheers,

Andreas


