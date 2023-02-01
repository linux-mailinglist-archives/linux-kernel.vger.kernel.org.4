Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F20686644
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjBAMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjBAMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:52:14 -0500
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC6F410AE;
        Wed,  1 Feb 2023 04:52:05 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pNCai-001B9i-Ji; Wed, 01 Feb 2023 13:51:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9Kc52uTv16sb0p6oBN78b7mTEi6EW2H8uLi6sYCMDIs=; b=ktkS87f+Kf7kubR0H5oGcj8eZv
        G6jhE5RrjOOZugFvEOR04xFilf27mHg2FB0WT314q6eDl1FrAgaHEntKoZL8VctuT4g3Dbm4ahsAY
        yPkmSDzCyDdH9liMl9whoiVqn03AcUTrDRB/cPcF1plG37t01KhvpzYhKNjW1/5uB2H6D438Kp0Z7
        W9hYQGVnDPJUtEv5wTOcg3eVqQIhVqGsU7QItQ2dFZRL+yu8pQnhmrAOJqwohbFHzIn3xfw+vT7S7
        QB43IJMy+RkHKiYRTbIszwAbfANdDWr+b9Ru3gQLSjkDdk5Kzg56WpQSF2rFmzu4/PUQjDNlqwQQU
        phUFRtAA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9Kc52uTv16sb0p6oBN78b7mTEi6EW2H8uLi6sYCMDIs=; b=A2+j3qmKGfUl0SkB5cGY5Og1pb
        gAgrZghlO7cegCW5GtT6iNdOzcdpevwFJG73qLrM7Gb0Ej1tOfGc2YgOgUq2Y1g5qG236Yv3+b+fn
        +Kkrl8ADg4dju14fDGz5N1Kh76btdq3sh2XyRqHlcSxHkBReluM/HG8tyBWerBlE/a4I5VBbUM9Bz
        juiLB9JMpNKeiKQ/3LkhAxh/Fp3mcavn6FvNiX9SAwGqkqoN2r5kZwLuPoqrKtnqVGtIz4PxA4W71
        y19x4/b0OE0LODIh4zLs1wCqJyqCi0XUEXrHKi0LpOG26X1/Ny9/f6ACrFrAKD2Lb8Rd1o0Ver1xw
        YTOZFRXw==;
Received: from [2a02:908:1b0:8800:89e8:729d:cb4e:3baa]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pNCae-000APG-Gj; Wed, 01 Feb 2023 13:51:55 +0100
Message-ID: <d03ec6a7-62c0-0a82-a0f0-d2030ed5723d@feldner-bv.de>
Date:   Wed, 1 Feb 2023 13:51:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iio: dht11: forked a driver version that polls
 sensor's signal from GPIO
To:     harald@ccbib.org
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y9groXq2oI6lqFea@debian-qemu.internal.flying-snail.de>
 <ee14f0c8bfbae887d21f827baece8b6e@ccbib.org>
From:   pelzi@flying-snail.de
In-Reply-To: <ee14f0c8bfbae887d21f827baece8b6e@ccbib.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I understand that the first priority is in finding out if there is 
actually a proper
use case for a polling implementation at all. Only then, it might be 
worth to extend
the existing dht11 module by an polling alternative.

Am 31.01.23 um 11:18 schrieb harald@ccbib.org:
> On 2023-01-30 21:42, Andreas Feldner wrote:
>> On a BananaPi M2 Zero, the existing, IRQ based dht11 driver is not 
>> working,
>> but missing most IRQs.
>
> That's quite surprising as the driver works well on many similar systems
> based on Allwinner SoCs. I suspect the problem is with your setup. Maybe
> some other (polling?) driver is slowing everything down.

Can you give me a hint how to look for signs of such a situation?

BTW I took some pride in building the board's system image from 
reproduceable sources: Debian kernel package 
linux-image-5.10.0-20-armmp-lpae, and the device tree from ﻿﻿﻿﻿

arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts

So the setup should be reproducible, unlike other approaches advertised 
in the BananaPi forum...

What I did is

- check /proc/interrupts. The highest volume interrupts there are two 
instances of sunxi-mmc, one generating about 50 interrupts per second, 
the other about 25. Those (and most) interrupts are GICv2, but the GPIO 
releated are sunxi-pio-{level,edge}

- check dmesg: literally no messages apart from dht11_poll itself

- check top: sugov:0 is reported to eat 10% of one cpu, but I understand 
that's expected and an artifact anyway. Changing the scaling governor to 
"performance" eliminates this, but does not help in making the irq 
driven dht11 work.

- check vmstat: ir is between 50 and 200 apart from short spikes, those 
probably related to a certain cron job

- check sysstat cpu, mem, threads, mutex: each of the 4 cores has a low 
performance (a factor of 15 lower than a Raspberrypi 3), but constant, 
low stddev, etc. No surprises running e.g. 8 threads instead of 4.

So, apart from the fact that it is missing about 3/4 of the IRQs the 
dht11 driver should get, I have no indication that something might be 
wrong with the board or its setup. Where else should I look?

Some additional remarks of questionable relevance:

Prior to attempt to put the logic into a kernel module, I implemented a 
polling PoC in userspace using libgpiod by nailing together parts of 
gpioset, gpiomon, and the dht11 kernel module:
https://github.com/pelzvieh/banana_resources/blob/main/poll_dht11.c

This works "reasonably", once in a few shots, but the diagnostics show 
that there are only typically 5 to 7 samples for a high pulse 
corresponding to a zero bit (26-28 µs). My naive interpretation was that 
the board is just quite slow for this task.

BTW the constant timing of the low pulse of 50 µs was confirmed by that 
experiment as well. It seems to work as given in the DHT22 datasheet 
floating arount in internet (e.g. for download at 
https://www.mikrocontroller-elektronik.de/dht22-am2302-luftfeuchte-und-temperatursensor/).

>> Following the hints in Harald Geyer's comments I
>> tried to implement a version of the driver that is polling the GPIO
>> sensor in a busy loop, not using IRQ altogether.
>
> IIRC one readout takes about 80 milliseconds. That's a very long time for
> a busy loop. I doubt this is acceptable for inclusion in the kernel. Of
> course also Jonathan's comments apply.

Seems to be a bit less, just in case that matters. Given the timing 
chart I'd expect

on average: 200µs + 40 * 100µs = 4,2ms

worst case (device trying to send all one-bits): 200µs + 40 * 120µs = 5,0ms

Yours,

Andreas.

