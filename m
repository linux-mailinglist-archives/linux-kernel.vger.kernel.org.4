Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0287A72A96E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 08:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjFJGi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 02:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFJGi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 02:38:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642B1FDB;
        Fri,  9 Jun 2023 23:38:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25665d2a8bdso1050807a91.0;
        Fri, 09 Jun 2023 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686379134; x=1688971134;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGVhz1sAD6q2mvEjxF0pg4PBT4Cx0EoYk9cX0ojzw7k=;
        b=rHJzw9HMsYn6a13iz3WbD0crMFkPlXc0e8Yb3nBTH/Ssm1T5sus7EQNukL9JfVVGS4
         NhFFKST/ybZ2ELB4j6sU9HWzeGhDnkWYc6bApg66RF/nJ7p81ynn0Xj09jqfa2134tU0
         /4Ljln+XrOsfWgJ1KF8UuRv49o+em+kJMeogJjkB1rfs4jiShcJAhSumot7jlyjxC7SG
         yI6No0XFpSdVPrNoMNNjrWNtTw1qkJxxQ+wbecsZjI21H2np7W4N8Sv5fkRoirIqtvNN
         M3nYQExXPHipcWnwKCRlLTPLQwZB3Idn1BV7NmThpnCNR6AsWJS6+aI790ro7O/iAVyC
         1FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686379134; x=1688971134;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGVhz1sAD6q2mvEjxF0pg4PBT4Cx0EoYk9cX0ojzw7k=;
        b=AuD9uK2PXJ0Az6U0zIjszscxAaDzTZISmYAeKReb4EAGDOR7MqNMuo6SiRa8OdBDMu
         wprPQjUFPLApw0k/IssAsVU6dKLU4sCom1JjeglYzOw+l3UFCtoxMnIC7Ew51F6CM3/0
         8lZ7zaFAvCXHgeY5KUF3UHzCta+FArzmNDs+sC8RipSph2nzrIA2CvI3VRtGtc6OxYiZ
         8SXW/vhZcCIKz/XmJN4YBH24PawTh2fPos5Qd055BaP4tqJBKJZ2LIzaiCZM1bi7VIlA
         TAMhx25HP6IjJYSn7aWEQAr1V/jsrSZQ6TIHK2VVNtGuHngdRhEDYs7lY2SlmGlS7jKA
         6DbQ==
X-Gm-Message-State: AC+VfDyZDjT17IdDjZNS9TuUFth7XwJO+6JoUzFqDmysRLxVPjURhzXa
        zKQb7s6F2tdViyJgWu2U6qA=
X-Google-Smtp-Source: ACHHUZ6U8LuPYo6qTIzC6FmLnF/Ulx2KVvuwaayPVlE29Z3/R06/68EjE8sPxR6bbsBIv8SJ3NMpvA==
X-Received: by 2002:a17:90a:9746:b0:255:b1d3:5220 with SMTP id i6-20020a17090a974600b00255b1d35220mr2753407pjw.20.1686379134369;
        Fri, 09 Jun 2023 23:38:54 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id j24-20020a17090a589800b0023b3d80c76csm3841294pji.4.2023.06.09.23.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 23:38:53 -0700 (PDT)
Message-ID: <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
Date:   Sat, 10 Jun 2023 13:38:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Joe Breuer <linux-kernel@jmbreuer.net>
Cc:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
In-Reply-To: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 18:04, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> I'm running LibreELEC.tv on an x86_64 machine that, following a (kernel) update, now locks up hard while trying to device_resume() => device_lock() on sr 2:0:0:0 (the only sr device in the system).
>>
>> Through some digging of my own, I can pretty much isolate the fault in this device_lock() call:
>> https://elixir.bootlin.com/linux/v6.3.4/source/drivers/base/power/main.c#L919
>>
>> I put an additional debug line exactly before the device_lock(dev) call, like this:
>> dev_info(dev, "device_lock() in device_resume()");
>>
>> This is the last diagnostic I see, that device_lock() call never returns, ie line 920 in main.c is never reached (confirmed via TRACE_RESUME).
>> The device, in my case, is printed as sr 2:0:0:0.
>>
>> Knowing this, as a workaround, booting with libata.force=3:disable (libata port 3 corresponds to the SATA channel that sr 2:0:0:0 is attached to) allows suspend/resume to work correctly (but the optical drive is not accessible, obviously).
>>
>> When resume hangs, the kernel is not _completely_ locked, interestingly the machine responds to pings and I see the e1000e 'link up' message a couple seconds after the hanging sr2 device_lock().
>> Magic SysRq, however, does NOT work in that state; possibly because not enough of USB is resumed yet. Resuming devices seems to broadly follow a kind of breadth-first order; I see USB ports getting resumed closely before the lockup, but no USB (target) devices.
>>
>> This is a regression, earlier kernels would work correctly on the exact same hardware. Since it's an 'embedded' type (LibreELEC.tv) install that overwrites its system parts completely on each update, I don't have a clear historical record of kernel versions. From the timeline and my memory, moving from 5.x to 6.x would make sense. Due to the nature of the system, it's somewhat inconvenient for me to try numerous kernel versions blindly for a bisection; I will try to test against some current 5.x soon, however.
>>
>> I do have the hope that this information already might give someone with more background a strong idea about the issue.
>>
>> Next, I will try to put debug_show_all_locks() before device_lock(), since I can't Alt+SysRq+d.
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding it to regzbot (with rough version range since the reporter
> only knows major kernel version numbers):
> 
> #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bug.cgi?id=217530
> #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
> 

The reporter had found the culprit (via bisection), so:

#regzbot introduced: a19a93e4c6a98c

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

