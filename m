Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB3693FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBMIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:50:20 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE054ED2;
        Mon, 13 Feb 2023 00:50:17 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pRUX9-0034f1-BO; Mon, 13 Feb 2023 09:49:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=D6MuNRohfsBhCYGBsum0yLL3ZqtP1FjupA4uVal3vSo=; b=BaHLhjdQ/Pn9o4EISJcsyCAmt1
        JDusPDyS3XPbRXGeadZxVNSYeSgBkf4WCDL2al9iNo3RbLHt9/59cxJqbb2AURre5ojdizLfcQFBW
        lYvFtMcTDEi86TZLktafjEWdGAWv+4Yof8RDrhH0L4Sm/FVhJqrhVsGRFpIeqnVIubW5jHFf5OJrh
        elMoBCqokzOD1wjFltbbCm5NFT2JzCc8M908UlslMlY3qca5AngLIzu8oIHzwoibLpv2dnh+rvBM+
        eWLlw/l4AlcmxTrvRUdtbWZMD1BQ0sLI2lLSRutr+wy/GWJUknsv6s1pa6Ab7G+3pIEaWwUBMeVP4
        w385Y6uw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=D6MuNRohfsBhCYGBsum0yLL3ZqtP1FjupA4uVal3vSo=; b=nPUG585Mxn2ezJObymPA4CjNxg
        78yCxzVwRv7+6EcbWF5R8W5OapMbmhEvYY248ANyfbt+EkBLF/Llkym536pxNlRoR/m8LGZnoyCLG
        2+Krp6Td1o0u/vLOv/TC++SRUV9tisNhQMGsfpmqIZxGGUc9IDMrqizrRAwaeQzp/usKG3MN3cMKb
        gYcSyOQAkgRz5o+F/ZXyjMJpAXqAW2GonhO/M76zY3XNYL/9XUvQuVEPNW6HcrJxUTMowjOhjdxC0
        /X0+1LBKCqmhexFecIK7gNPLFUYQ1d8FFiuvoLWUxgPZ8n58p+2ZVpDFyMCAdBM5mZBNYjUPnNqb7
        HIFd0m3A==;
Received: from [2a02:908:1b0:8800:5057:a51f:9eb5:f4ee]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pRUX5-000pl1-QK; Mon, 13 Feb 2023 09:49:57 +0100
Message-ID: <c3dda403-6963-040a-3827-443edf0a377a@flying-snail.de>
Date:   Mon, 13 Feb 2023 09:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
To:     Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Andreas Feldner <pelzi@flying-snail.de>,
        Rob Herring <robh+dt@kernel.org>,
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
From:   pelzi@flying-snail.de
In-Reply-To: <20230213084329.ulckaigwd7dof37u@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.02.23 um 09:43 schrieb Maxime Ripard:
> On Fri, Feb 10, 2023 at 10:18:14AM +0000, Andre Przywara wrote:
>>>> Not sure if you were actually arguing this, but the change I sketched
>>>> above (interpreting 0 as 24MHz/1) is separate though, as the current
>>>> default is "no DT property", and not 0. There is no input-debounce
>>>> property user in the kernel tree at the moment, so we wouldn't break
>>>> anyone. The only thing that would change is if a downstream user was
>>>> relying on "0" being interpreted as "skip the setup", which isn't
>>>> really documented and could be argued to be an implementation detail.
>>>>
>>>> So I'd suggest to implement 0 as "lowest possible", and documenting that
>>>> and the 32KHz/1 default if no property is given.
>>> Ah, my bad.
>>>
>>> There's another thing to consider: there's already a generic per-pin
>>> input-debounce property in pinctrl.
>>>
>>> Since we can't control it per pin but per bank, we moved it to the
>>> controller back then, but there's always been this (implicit)
>>> expectation that it was behaving the same way.
>>>
>>> And the generic, per-pin, input-debounce documentation says:
>>>
>>>> Takes the debounce time in usec as argument or 0 to disable debouncing
>>> I agree that silently ignoring it is not great, but interpreting 0 as
>>> the lowest possible is breaking that behaviour which, I believe, is a
>>> worse outcome.
>> Is it really? If I understand the hardware manuals correctly, we cannot
>> really turn that feature off, so isn't the lowest possible time period (24
>> MHz/1 at the moment) the closest we can get to "turn it off"? So
>> implementing this would bring us actually closer to the documented
>> behaviour? Or did I get the meaning of this time period wrong?
>> At least that's my understanding of how it fixed Andreas' problem: 1µs
>> is still not "off", but much better than the 31µs of the default. The new
>> 0 would then be 0.041µs.
> My point was that the property we share the name (and should share the
> semantics with) documents 0 as disabled. We would have a behavior that
> doesn't disable it. It's inconsistent.
>
> The reason doesn't really matter, we would share the same name but have
> a completely different behavior, this is super confusing to me.

I got the point. As far as I can tell from the datasheet, it is not possible
to actually switch off input-debounce. But as a debounce filter is actually
a low-pass filter, setting the cut-off frequency as high as possible,
appears to be the equivalent to switching it off.
To me it does not appear inconsistent, as any hardware will have an
implicit cut-off frequency given by its physical capabilites.

Cheers,

Andreas.


