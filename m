Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE4693358
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBKTpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBKTpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:45:46 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D911815A;
        Sat, 11 Feb 2023 11:45:43 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 39901320027A;
        Sat, 11 Feb 2023 14:45:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 11 Feb 2023 14:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676144734; x=
        1676231134; bh=nAfDCv4pIOfY0PAcpVEd13mZpp4d1bY5NKYeBEKLtY8=; b=c
        M3tKyMDQ6T3ypKhzSasgMSKqpIXx9FcpW9Kud0162tNpjIXgm5T2eLa20U003lWT
        MN0pF3oiuxGL/jbunG1Cr11ge19vzhoZqvBbAVbragCml7pBXps2k+LvCyiwMkk4
        gw9IwLzbL/FEL1PQRmjPlGyAWVC0UDxx+Q+6xZtNP6U7GTns/px6QWt0b+kzLNqm
        jacZTUiYYHMSxoOeF99ulbKdNaAUBxr70gtbcC+Jv0hhcoZonXXw50qIryEx7N1S
        BG5tfRqtLzEByL41MK7K75F8liU5MQMAUo56q2bR1i5Y9DqXNyyPu1mXfD4O6ef3
        w1+JR0cBH0hZtm4Mw8bUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676144734; x=
        1676231134; bh=nAfDCv4pIOfY0PAcpVEd13mZpp4d1bY5NKYeBEKLtY8=; b=B
        LX0pZotXAdKf4FiqFxIQOUJAxJRxU/RLP16YYXfXfNfCQJu67be2Ml/HGIkaNUQb
        xaPo11AARF7o0XsyYt3Gv8TqMSBOKdWfYr+R87fIUgVUDx+l/14XV2pTqHxW/c1d
        a5FWjPsfJkLaCDAgq/SYD+ol38sdfV8t+J6fpvqRkCf0I+Xj91NZg/6LXuFuYkpe
        utVNrN0uQ0CnE794nQja1s1VJGYfR5ej1jevFr8Tc1Yk9GYTfdXFuVoNOYuw4g7U
        r9tqpMjMmjqPdmuRItNFX4a+nrPX/w3VfqNA3o8FC60W9WPmBYduPM2bb91aP7by
        8i1VdE1W4Pt70EDEk+UIw==
X-ME-Sender: <xms:XfDnY8JpE8jQYpszHur2BxTjOEZ23TYtXS-Xi3wCkKK-oZO_0uxrhQ>
    <xme:XfDnY8JvFqQG6kgmq-3Ke5dNdvf5s3fDjXHiQlzBFAGgJ6cbEbE4PbXdzDnR1q_xM
    p82YDytmwma9EaA6g>
X-ME-Received: <xmr:XfDnY8s5LkCvq_tG-HphoJ8pukrQ61m-aFagX_S5BE37tzJtVBjgX-GpQLqdrpq0qUPDAkNJiHFrqE7R7J2TI1vSQhTmW3Uat0rnebD-7NfpGGqiBVCwRXrl4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehjedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeff
    gfdvffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:XfDnY5ZponFTd60fXxnbkAhgpmcvRAbKVDMky_lNytSsbB9V7-VmmA>
    <xmx:XfDnYzZ9j_NJBwakM8SOHBMYvP4NuL6OQeZWK8FOO3N-M2sLKq89zQ>
    <xmx:XfDnY1BwRWG2M0NqtOEh7z8ppmNoh-nheablZa5nEW6vmiAGy43lRA>
    <xmx:XvDnYwTJR4OQl25ZjNQIqr1PToOxkVsYZBglZXF0kpZfZs5lA06AiQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Feb 2023 14:45:32 -0500 (EST)
Message-ID: <76a1cabd-f173-f86a-423a-ba5be7c1efd0@sholland.org>
Date:   Sat, 11 Feb 2023 13:45:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Andreas Feldner <pelzi@flying-snail.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Andreas Feldner <andreas@feldner-bv.de>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
In-Reply-To: <20230209202952.673d5a60@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 2/9/23 14:29, Andre Przywara wrote:
> On Wed, 8 Feb 2023 13:50:04 +0100
> Andreas Feldner <andreas@feldner-bv.de> wrote:
> 
> Hi Andreas,
> 
> CC:ing Maxime, who wrote the debouncing code back then.
> 
>> Am 07.02.23 um 02:16 schrieb Andre Przywara:
>>> On Mon, 6 Feb 2023 20:51:50 +0100
>>> Andreas Feldner <pelzi@flying-snail.de> wrote:
>>>
>>> Hi Andreas,
>>>
>>> thanks for taking care about this board and sending patches!  
>> Thank YOU for maintaining it!
>>>> The SoC features debounce logic for external interrupts. Per default,
>>>> this is based on a 32kHz oscillator, in effect filtering away multiple
>>>> interrupts separated by less than roughly 100ï¿½s.
>>>>
>>>> This patch sets different defaults for this filter for this board:
>>>> PG is connected to non-mechanical components, without any risk for
>>>> showing bounces. PA is mostly exposed to GPIO pins, however the
>>>> existence of a debounce filter is undesirable as well if electronic
>>>> components are connected.  
>>> So how do you know if that's the case? It seems to be quite normal to
>>> just connect mechanical switches to GPIO pins.
>>>
>>> If you are trying to fix a particular issue you encountered, please
>>> describe that here, and say how (or at least that) the patch fixes it.
>>>
>>> And I would suggest to treat port G and port A differently. If you
>>> need a lower debounce threshold for port A, you can apply a DT overlay
>>> in U-Boot, just for your board.  
>>
>> Fair enough. You run into problems when you connect (electronic)
>> devices to bank A (typically by the 40pin CON2 connector), where
>> the driver requires fast IRQs to work. In my case this has been a
>> DHT22 sensor, and the default debounce breaking the dht11.ko
>> driver.
> 
> Sure, what I meant is that this is a property of your particular
> setup (because you attach something to the *headers*) , so it shouldn't
> be in the generic DT, but just in your copy. Which ideally means using
> a DT overlay.
> 
>> Now, what kind of problem is this - I'm no way sure:
>>
>> a) is it an unlucky default, because whoever connects a mechanical
>> switch will know about the problem of bouncing and be taking
>> care to deal with it (whereas at least I was complete unsuspecting
>> when connecting an electronic device that a debounce function
>> might be in place), or
> 
> The Linux default is basically the reset default: just leave the
> register at 0x0. It seems like you cannot really turn that off at all
> in hardware, and the reset setting is indeed 32KHz/1. So far there
> haven't been any complaints, though I don't know if people just
> don't use it in anger, or cannot be bothered to send a report to the
> list.
> 
>> b) is it a bug in the devicetree for (at least) the BananaPi M2 Zero,
>> because the IRQ bank G is hard wired to electronic devices that
>> should not be fenced by a debouncing function, or
> 
> Well, we could try to turn that "off" as much as possible, but on the
> other hand the debounce only affects *GPIO* *interrupts*, so not sure
> that gives us anything. The PortG pins are used for the SDIO Wifi, BT
> UART, and the wakeup pins for the Wifi chip. Only the wakeup pins would
> be affected, and I doubt that we wake up that often that it matters. If
> you've made other observations, please let me know.
> 
> Certainly no board with an in-tree DT sets the debounce property, which
> means everyone uses 32KHz/1, and also did so before the functionality
> was introduced.

One side note relevant to wakeup pins: if the debounce clock source is
set to HOSC, and the 24 MHz oscillator is disabled, then IRQs for those
pins will never fire.

Currently, Crust does not check the debounce configuration when deciding
if it can turn off the 24 MHz crystal during system suspend (or fake-off
on boards without PMICs), so any wakeup-capable GPIOs need to use LOSC
as their debounce clock.

Do you have any thoughts about if/how we should handle this
automatically? Should Linux (or Crust) override the debounce
configuration when entering suspend? I imagine no wakeup source will
require a particularly short debounce time.

Regards,
Samuel

