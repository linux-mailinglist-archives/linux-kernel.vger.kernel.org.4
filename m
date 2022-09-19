Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D45BCC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiISMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiISMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:54:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5EAA18D;
        Mon, 19 Sep 2022 05:54:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d82so27981807pfd.10;
        Mon, 19 Sep 2022 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=Tmpc5VmdBuLNmo/f3Keo3zjOhIaec8wRWgy0Dh7g4Xc=;
        b=IA1ULq2eITg3H242o0ceTuR+29XaGcATRGaKSuDc8T6b1OAXgPKHFsoE/F8qKLaEbj
         LHKF72D1D4D6AtFv3+T5yxrnjf3sZcQcoypvrSojyA0T41EVh3zsb7QO3PD14E7mOEzy
         cMj3HF1NpkzPiR5DWW3kjUKSDXWSbPb8KrU1d1daapDHlWrvM3bOMGFGCTx+nX9Mjuq5
         EFuRxKx/dWnBpQkKI0ovXtWn4cekG1ViBEbHBQdWSzZH+kDAZMOqyozq0ejQU4kNanzC
         JMdcnwOZ/rjbHytSrgKjQZFqpN/c5u521Tm4UFl3JUUUjRctDQfgiqtuX6/XIrevCd0h
         KOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tmpc5VmdBuLNmo/f3Keo3zjOhIaec8wRWgy0Dh7g4Xc=;
        b=VJ9NOlXeimGLQTBfEL0BKY0/p3walSrGNbO1DT197D39iouAu2n1TgZeND5GYD/uc1
         73AM3e5kcAtPHLooJamBnMDBIJVhh66daLieivhpYNBczxN5boPtMMQ7gpffiRTwdsAC
         KYO5l9LpwVwtuIgxWPefJjHOCSns119/SuqHuDV3vO3ked84Vq43mhYPGcasMSJQ/54z
         bWDITB0g5KFsjEddxHur53tQ11VmHSayoe8XpGUhgapW2/MH7jAFzAsVMr70s6rrelEX
         pdUzI4OUU6GNW5Xf1e9i+znUE6Qa8o2uEuaNTDZxS0BJOXUhY4OFcRtjSDy72rbb2L+t
         0R0Q==
X-Gm-Message-State: ACrzQf1ErKdXkYa+s/pU2YnvL3M8og665fbeaZYyjTWih2ROXGola/NZ
        5xw2Jpvg31jfCQbIykKhTrifHOAqnADqeA==
X-Google-Smtp-Source: AMsMyM5n8v4bAl9gCQfKXo/bFnEfAhrhcNlccrkoIujrz8tigtnIa/6BRh7KaefuUdNnAfjVvrwJaQ==
X-Received: by 2002:a63:594c:0:b0:438:f2ce:8780 with SMTP id j12-20020a63594c000000b00438f2ce8780mr15582233pgm.285.1663592076255;
        Mon, 19 Sep 2022 05:54:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c206-20020a621cd7000000b00536431c6ae0sm20195289pfc.101.2022.09.19.05.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:54:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ee31cd1-76af-dae7-0902-3808a2696754@roeck-us.net>
Date:   Mon, 19 Sep 2022 05:54:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20220806000706.3eeafc9c@endymion.delvare>
 <5a1c9872-52b5-1f96-6931-801185b03fd4@roeck-us.net>
 <20220919113335.18cebc74@endymion.delvare>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: wdat_wdt: Set the min and max timeout values
 properly
In-Reply-To: <20220919113335.18cebc74@endymion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 02:33, Jean Delvare wrote:
> Hi Guenter,
> 
> A few questions from an old discussion:
> 
> On Mon, 8 Aug 2022 04:36:42 -0700, Guenter Roeck wrote:
>> On 8/5/22 15:07, Jean Delvare wrote:
>>> To be honest, I'm not sold to the idea of a software-emulated
>>> maximum timeout value above what the hardware can do, but if doing
>>> that makes sense in certain situations, then I believe it should be
>>> implemented as a boolean flag (named emulate_large_timeout, for
>>> example) to complement max_timeout instead of a separate time value.
>>> Is there a reason I'm missing, why it was not done that way?
>>
>> There are watchdogs with very low maximum timeout values, sometimes less than
>> 3 seconds. gpio-wdt is one example - some have a maximum value of 2.5 seconds.
>> rzn1_wd is even more extreme with a maximum of 1 second. With such low values,
>> accuracy is important, second-based limits are insufficient, and there is an
>> actual need for software timeout handling on top of hardware.
> 
> Out of curiosity, what prevents user-space itself from pinging
> /dev/watchdog every 0.5 second? I assume hardware using such watchdog
> devices is "special" and would be running finely tuned user-space, so
> the process pinging /dev/watchdog could be given higher priority or
> even real-time status to ensure it runs without delays. Is that not
> sufficient?
> 

It took us forever to get the in-kernel support stable, using the right timers
and making sure that the kernel actually executes the code fast enough. Maybe
that would work nowadays from a userspace process with the right permissions,
but I would not trust it. Then there is watchdog support in, for example,
systemd. I would not want to force users to run systemd as high priority
real-time process just to make an odd watchdog work. I also would not want to
tell people that they must not use the systemd watchdog timer to make their
watchdog work.

Also, there is no guarantee that the odd hardware with the weird watchdog hardware
is actually always used in an application where such a fast timeout is needed or
even wanted.

On top of that, the code in the kernel also now supports "ping until opened"
for systems where the watchdog is already running when the system boots.

Overall, I don't think it would be a good idea to revert the in-kernel support
of pinging watchdogs.

>> At the same time, there is actually a need to make timeouts milli-second based
>> instead of second-based, for uses such as medical devices where timeouts need
>> to be short and accurate. The only reason for not implementing this is that
>> the proposals I have seen so far (including mine) were too messy for my liking,
>> and I never had the time to clean it up. Reverting milli-second support would
>> be the completely wrong direction.
> 
> I might look into this at some point (for example as a SUSE Hackweek
> project). Did you post your work somewhere? I'd like to take a look.
> 
There was one submission from someone else if I recall correctly, but mine never
got to the point where it was submittable.

Guenter
