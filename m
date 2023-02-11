Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614EF692C66
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBKBEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBKBEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:04:42 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6375F7C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:04:40 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id s203so3287074ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCmOGuBPv31UY5B1zXCetlCYTSlsv5u9zQ46BG1wFyA=;
        b=bnrJaquB/tPkt/lJWzNkdevVm8WHdDmXnnxixhXv0x9lnfGxe4gwzSWC98z54m+fR/
         adc82mymHz1NF4uljr7ef9/vKIIjKFR94YrzBrY88RH369na61ieBQ7AEGLtnJCeQjiv
         PY4QbVjAedTx4HcKD0p+ArD0R0MYFW3hzmatI3y89dgPFsPdmOZ1Lw86dyTguSFCZjYf
         0kPXBjj/LUbak2pOD0hpKK+FhaJgbt9oe57x9P0aF0N7Vo336x6Cck4WfUn0Rw8IJw+s
         EzN0uvaGkooCyHezU7zRqbsXBKyXcVHclFnkD6IZvHT7zorm7uGFGo9UOYgAa6WxZY5/
         /nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCmOGuBPv31UY5B1zXCetlCYTSlsv5u9zQ46BG1wFyA=;
        b=YaHZIh/vyCgl3CX4Ru6U0XUzlEoJivCku0g4lqCyDu4R5yHhUBTfj9tJeAGrmGGJDL
         o47B8Q3NfnLDWfJi8yCP8A2NUXY0MK2J7hLDbmhy9EwbvXLIXGjl0USNJx83dcSazUbK
         FWfm0timJLyM5SUa5vPfdWskmi08s35WdlUDUxbaJs0/2xBeyHMZoEggifHaVybeDVp2
         z2gbu6SUFFOihFrjClhad2oFx7hSZ9YPPDlFomziOIpMZQnOt6W381LrvOYddw9lZkcS
         btRu+cKHm3vKJSmc8hUXSYBawdy2IJ46G5zQFDUAbCDZzihS5CKhyIVFrqGhYletn6or
         hvzw==
X-Gm-Message-State: AO0yUKWiiXLh9iLF0hpJgXbOUKbnkl7JNY0nhWhAeg3ASmCWdYktPkz1
        3hsrrYABbEwSm/rUxCEidhNoelk7Jw5jmZ7So23D8fGKwYRoDBXj5A==
X-Google-Smtp-Source: AK7set9g6Mafb/QDw8fUZh0hFORiAihjBIDqPTa+Vzv8SHnlH6la0bZEvLhiVF1mS2/6YN3/Z0uCPt1e1hdjSE9v81c=
X-Received: by 2002:a05:6902:24c:b0:8b9:66a7:bb53 with SMTP id
 k12-20020a056902024c00b008b966a7bb53mr1742717ybs.219.1676077480028; Fri, 10
 Feb 2023 17:04:40 -0800 (PST)
MIME-Version: 1.0
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org>
 <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de> <20190902074917.GA21922@piout.net>
 <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
 <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de> <alpine.DEB.2.21.1909040047210.1902@nanos.tec.linutronix.de>
 <Y+O+VBSNywC7LKhn@panicking> <87edr02fsc.ffs@tglx> <CAOf5uwn1SKBR+pREZy9f-wnQf6Lw3epyHxiX_hjf_pOaiiSDWA@mail.gmail.com>
 <87zg9m26f2.ffs@tglx>
In-Reply-To: <87zg9m26f2.ffs@tglx>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 10 Feb 2023 17:04:28 -0800
Message-ID: <CANDhNCopf___L_3cARqK8WDHSJWFYYikxvANHh2CRMjDRag9yw@mail.gmail.com>
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time delta
 is zero
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Michael <michael@mipisi.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 7:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, Feb 09 2023 at 12:19, Michael Nazzareno Trimarchi wrote:
> > On Wed, Feb 8, 2023 at 7:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> I wrote that patch against the back then mainline code. No idea if it's
> >> still applying, but the underlying issue is still the same AFAICT.
> >>
> >> It needs some polishing and a proper changelog.
> >>
> > Ok, I will try to update it on some mainline kernel in my environment
> > and test it back. I need
> > a little information if it's possible. Consider that I have no
> > experience in this area. I understand how
> > code was designed in general but the part around the freezer and all
> > those code you remove, what was the logic behind in the removed code?
>
> What I can oracle out of that well commented gem is:
>
>   A userspace task invokes clock_nanosleep(CLOCK_*_ALARM, ...), which
>   arms an alarm timer. The expiry of an alarmtimer causes the system to
>   come out of suspend.
>
>   As the task invokes schedule() it can also be brought back from
>   schedule() via a signal. If that happens then the task cancels the
>   alarmtimer and returns to handle the signal. While doing that it can
>   be frozen, which means the alarm and therefore the wake from suspend
>   is lost.
>
>   To prevent that the code tries to save the earliest expiring alarm if
>   the task is marked freezing() and the suspend code takes that into
>   account.
>
> John, did I summarize that correctly?
>
> The change I made remove that magic and marks the task freezable when it
> goes to schedule, which prevents the signal wakeup. That ensures that
> the alarm stays armed during freeze/suspend.
>
> That obviously needs some testing and scrunity by the folks which use
> this mechanism. IIRC that's used by android, but I might be wrong.

So, thanks for dredging this old thread up, I'm sorry I didn't see it
the first time it came around.

Not having a clear memory of why we do the (min == 0) early return, I
went digging in, and found it was in the original git commit, so I
went looking to the archives.

It's completely not present in the first version of the patch:
  https://lore.kernel.org/lkml/1288809079-14663-8-git-send-email-john.stultz@linaro.org/

But it did appear in the second version:
  https://lore.kernel.org/lkml/1290136329-18291-6-git-send-email-john.stultz@linaro.org/

And from there it's a clear case of wanting to avoid setting the RTC
if there were just no timers to expire.

But, indeed this is a bug, as initializing min to ktime_set(0, 0) as
the "invalid" case isn't a good plan, as it might be possible that
suspend is run right as an alarmtimer expires, and you get a real zero
delta value (as has been reported).

Instead it seemed I should have used KTIME_MAX as the "invalid" case
(as Thomas' patch uses).

However, before the patch was merged, it changed further to handle the
freezer waking a current sleeper:
  https://lore.kernel.org/lkml/1294280159-2513-13-git-send-email-john.stultz@linaro.org/

Which was then used to initialize the min value (still erroneously
using 0 as an "invalid" value) in the case that the freezer woke a
task sleeping which would cause the alarm to be lost (as Thomas
summarized).

Thomas' patch fixes the erronious 0-as-invalid initialization issue
using KTIME_MAX but also simplifies the logic getting rid of the
freezer handling.

I don't have as much familiarity with the freezer handling change, so
while it looks sane, I can't say I would likely catch an issue doing a
visual review.

Michael: If you are still intending to send the patch out, please do,
otherwise I've already forward ported it so I can do some testing with
it. I'm happy to put together a commit message and send it out if
that's easier for you.

And, just for correct Reported-by: tags: Michael Trimarchi, are you
the same Michael (michael@mipisi.de) that originally reported this
issue?

thanks
-john
