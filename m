Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4968B121
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBERq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBERq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:46:57 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3718B10;
        Sun,  5 Feb 2023 09:46:53 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pOj6D-001lfB-K2; Sun, 05 Feb 2023 18:46:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=iZBGeO9WCqRwOlETkxHySJfwXaLhexLr0iCCz/TmwEY=; b=l3SY45xY/2vihZB3L4+x4jldK4
        jNCrWi94i3lof4fQyYhUzTdQQbhkl9SJAgbnJp7Aw395eVJqnbEi6rdXSPJBM/ySeJJkaI37DB9IQ
        oLXuaEjFYCHk2hIe8JXUIg79E8xq22TNer3kVvrHzDjG8fjpoJGLT1QXqNs73bQNMOTVHjf8MG1Zi
        8nIrtTt/iLrbaEfycqXh0XBPb2rSFt+PtS1vhvRK0vmrbggINJRoSQgjvWc7eYO5aYUlqoROpH14Y
        9s2MjlhnTXrR8F3VRQwUTH8G6bd1Uo2SR4l3ihNxgZ2/NUzPG9GEQzExPNX4/+vbzbS07GMHt+N7W
        JgUVPj8w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=iZBGeO9WCqRwOlETkxHySJfwXaLhexLr0iCCz/TmwEY=; b=cpARrJhB34nZcCqbeF/eoxcKYA
        +lirKHpeeCNvRpNFwIKXCyOA0xzF8DBsMpVymLfLFhYli8xHEnoiKb96cwawcTjd4ACff4iDLp+a8
        CJN4X2uXS95eIbFCNn3NRsvmyUMKyENX09ipR4LQdf8GDm/sbPO7wOHM7mJZVEXz/pr8nXxxlG0KB
        jfiuIcaYVh8wZlMcOTDGfDr0gN1EetEaNnflDpTww/wWWhVNK7iBRj3gDmIwSLtYtOJu/Dvlfp7ID
        KRK8dVckL8ohjLc6PK/TOnzvJuup9WyQlhgJicoNmCqB7Ll3TEgqnQegAurqnDtX/k4VuG1kst7dx
        Qd8Dabcw==;
Received: from [2a02:908:1b0:8800:1554:6239:a4eb:816f]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pOj69-000cIi-QL; Sun, 05 Feb 2023 18:46:44 +0100
Message-ID: <3648e749-76de-01d3-f598-cb73de70d58a@feldner-bv.de>
Date:   Sun, 5 Feb 2023 18:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iio: dht11: forked a driver version that polls
 sensor's signal from GPIO
To:     Harald Geyer <harald@ccbib.org>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y9groXq2oI6lqFea@debian-qemu.internal.flying-snail.de>
 <ee14f0c8bfbae887d21f827baece8b6e@ccbib.org>
 <d03ec6a7-62c0-0a82-a0f0-d2030ed5723d@feldner-bv.de>
 <9219a1dd4371a106f9eda9c90ef96066f9ff6446.camel@ccbib.org>
From:   pelzi@flying-snail.de
In-Reply-To: <9219a1dd4371a106f9eda9c90ef96066f9ff6446.camel@ccbib.org>
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

As it turned out, on my Allwinner H3 based BananaPi M2 Zero, it is
required to explicitly set a low IRQ debounce filter time, as there is
a default debounce filter active that appears to filter something
around 150µs. This causes IRQs from DTH11/22 devices to be filtered
out, evenly over the transmission time.

Reading the datasheet carefully it seems to be documented that a
32kHz clock, scaled by 1, is the default base of an interrupt
debounce filter – taking a simple notice "Default Value 0x00000000"
very verbatim. Depending on the algorithm, this 32µs clock as basis
seems plausible to destroy the expected signal and anyway, so it does.

The device tree overlay quoted below makes the IRQ based driver (in
my falling-edge-only flavour) work like a charm. Tests of reliability,
system load, comparison to the original driver are still ongoing.

Are there any useful next steps arising from this observation? Perhaps
at least some Documentation? I'm even concerned about the default
setting being used by

arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts

As far as I understand, this setting applies to the full IRQ bank,
appearently including GPIOs usable for UARTs including the separate
UART used for debugging (CON3).

OTOH, applying the dt overlay below relaxes a filter and could make
bounces show up in applications that do not currently experience
bouncing artefacts.

Obviously, a polling version of the driver is not required in this case,
I vote to rejecting it.

Cheers

Andreas


// Definitions for dht11 module
/*
Adapted from dht11.dts for Raspberrypi, by Keith Hall
Adapted by pelzi.
*/
/dts-v1/;
/plugin/;

/ {

         fragment@0 {
                 target-path = "/";
                 __overlay__ {

                         temperature_humidity: dht11@6 {
                                 compatible = "dht22", "dht11";
                                 pinctrl-names = "default";
                                 pinctrl-0 = <&dht11_pins>;
                                 gpios = <&pio 0 6 0>; /* PA6 (PIN 7), 
active high */
                                 status = "okay";
                         };

                 };
         };

         fragment@1 {
                 target = <&pio>;
                 __overlay__ {
                         input-debounce = <5 0>; /* 5µs debounce on IRQ 
bank 0, default on bank 1 */
                         dht11_pins: dht11_pins {
                                 pins = "PA6";
                                 function = "gpio_in";
                                 /*bias-pull-up; not required for 3-pin 
version of sensor */
                         };
                 };
         };

         __overrides__ {
                 gpiopin =       <&dht11_pins>,"pins:0",
<&temperature_humidity>,"gpios:8";
         };
};

Am 02.02.23 um 21:53 schrieb Harald Geyer:
> Am Mittwoch, dem 01.02.2023 um 13:51 +0100 schrieb
> pelzi@flying-snail.de:
>> I understand that the first priority is in finding out if there is
>> actually a proper
>> use case for a polling implementation at all. Only then, it might be
>> worth to extend
>> the existing dht11 module by an polling alternative.
>>
>> Am 31.01.23 um 11:18 schrieb harald@ccbib.org:
>>> On 2023-01-30 21:42, Andreas Feldner wrote:
>>>> On a BananaPi M2 Zero, the existing, IRQ based dht11 driver is
>>>> not
>>>> working,
>>>> but missing most IRQs.
>>> That's quite surprising as the driver works well on many similar
>>> systems
>>> based on Allwinner SoCs. I suspect the problem is with your setup.
>>> Maybe
>>> some other (polling?) driver is slowing everything down.
>> Can you give me a hint how to look for signs of such a situation?
> The obvious things to try:
>
> Enabling debug output for the dht11 driver, to look into which
> interrupts are actually missing: Is it a "block" of interrupts?
> Are they randomly distributed? Are they somewhat equally spaced?
> This should give some hints about the nature of the problem.
>
> Try to reproduce the problem on a minimal system:
> Unload as many modules as possible.
> Maybe just use a system on a ram disk.
> As little user space programms running as possbile.
> You might find OpenWRT helpful.
>
> Try other kernel versions. (Unlikely, but it might be some
> completely unrelated regression.)
>
> Implement debugging output in your polling driver to investigate,
> why *that* performs so bad. It probably is the same issue.
>
> If this doesn't lead anywhere, then it is a tough problem, so
> let's for now assume, you find something.
>
>
>> BTW I took some pride in building the board's system image from
>> reproduceable sources: Debian kernel package
>> linux-image-5.10.0-20-armmp-lpae, and the device tree from ﻿﻿﻿﻿
>>
>> arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>>
>> So the setup should be reproducible, unlike other approaches
>> advertised
>> in the BananaPi forum...
>>
>> What I did is
>>
>> - check /proc/interrupts. The highest volume interrupts there are two
>> instances of sunxi-mmc, one generating about 50 interrupts per
>> second,
>> the other about 25. Those (and most) interrupts are GICv2, but the
>> GPIO
>> releated are sunxi-pio-{level,edge}
>>
>> - check dmesg: literally no messages apart from dht11_poll itself
>>
>> - check top: sugov:0 is reported to eat 10% of one cpu, but I
>> understand
>> that's expected and an artifact anyway. Changing the scaling governor
>> to
>> "performance" eliminates this, but does not help in making the irq
>> driven dht11 work.
>>
>> - check vmstat: ir is between 50 and 200 apart from short spikes,
>> those
>> probably related to a certain cron job
>>
>> - check sysstat cpu, mem, threads, mutex: each of the 4 cores has a
>> low
>> performance (a factor of 15 lower than a Raspberrypi 3), but
>> constant,
>> low stddev, etc. No surprises running e.g. 8 threads instead of 4.
>>
>> So, apart from the fact that it is missing about 3/4 of the IRQs the
>> dht11 driver should get, I have no indication that something might be
>> wrong with the board or its setup. Where else should I look?
> There are many possible issues, that are difficult to investigate
> directly. E.g. cache poisoning, some code disabling interrupts just
> a bit to long etc. Thus the use of minimal systems.
>
>>>> Following the hints in Harald Geyer's comments I
>>>> tried to implement a version of the driver that is polling the
>>>> GPIO
>>>> sensor in a busy loop, not using IRQ altogether.
>>> IIRC one readout takes about 80 milliseconds. That's a very long
>>> time for
>>> a busy loop. I doubt this is acceptable for inclusion in the
>>> kernel. Of
>>> course also Jonathan's comments apply.
>> Seems to be a bit less, just in case that matters. Given the timing
>> chart I'd expect
>>
>> on average: 200µs + 40 * 100µs = 4,2ms
>>
>> worst case (device trying to send all one-bits): 200µs + 40 * 120µs =
>> 5,0ms
>>
> Ack.
>
> Good luck,
> Harald
>
>
