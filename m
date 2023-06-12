Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9272CB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjFLQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjFLQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:27:30 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE5E52
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:27:28 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33dbad61311so3138325ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686587248; x=1689179248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DamFb9KrPkrodrikB75BJEmIeuFQkyiO8xBxyfEiGU=;
        b=DDASE38qvGW9uZSRU7BmI0kF7I5ApbcdKkQiChxsAdBBITf0JPe9Pcn8BX9f2HGfLw
         LL5G7u7/XXc/iZCFWtjC/rJImW9/y5/kQ1f72m4hINAi7206kUip0v5z3J8Yku3SoM2E
         DQyzfGDGQInH8uECwWRnQUyVeg74kkcYe+IpOKNSdLkLXS7kGjblwkMRM6xJ6OwZJ6Th
         X/oVwHoDTpHJ0ODhhb/dgganv0XHfpQNnJPQK9Z/ix9L73rlG3zM2jqGnR0qYhKBd1/q
         P3q+v88sqReFCK6j8UyjI08PMcVaXSBgIkicA4RkZSp2UQCWccV5vR1Shv8dqvdtcByy
         4btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587248; x=1689179248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DamFb9KrPkrodrikB75BJEmIeuFQkyiO8xBxyfEiGU=;
        b=RjEkF0ayC9BNh70FWDiHwoG24eIgvmA+K1TrLwXVGanAP6yqY+9IZWLSUzaY0kURW0
         Iv8TLPS19mdcx+4JH6jNrJ8ecOyPcLAayQtmpJb+iAuxkuNl3hvdKPZbUN0ib6AEm4g3
         7T0MZMo2ny6QRj6V9A+WftvEDoH6kz7icPev6PlCEMXhN7BHTn8+8NEoCPU81L0qY+6E
         lJU1htnZAGKEIbyseKDJpwg6poo5Qis7mqdMpWTddI0oOzezyHZuxpkPbFCufLfvIbDj
         px9bmHF5CKZ3KlOUTKEajfASmZ9qidcFLS5Qbs9ekENsUlbMlu420yTU8WG6IiwJJ90y
         yidw==
X-Gm-Message-State: AC+VfDy241IG9sAxb/6cmbWjOPQifF4oey7UD8dQJRY6bJ6g4wwNAJla
        lZ0YaupWhCNCgkP4RhDgkPPvZA==
X-Google-Smtp-Source: ACHHUZ5l1BeOj6wOnr+OY1oi25lCVCteIJ6FxXg1uuXpv9FAMywsS7cXbeXg6hNTzyqMQ3RZnYA1Mw==
X-Received: by 2002:a05:6e02:1c0a:b0:330:a1eb:c5a4 with SMTP id l10-20020a056e021c0a00b00330a1ebc5a4mr6231479ilh.1.1686587247763;
        Mon, 12 Jun 2023 09:27:27 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e18-20020a926912000000b0033ba7c76f4bsm1230106ilc.44.2023.06.12.09.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:27:27 -0700 (PDT)
Message-ID: <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk>
Date:   Mon, 12 Jun 2023 10:27:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Zorro Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs>
 <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 9:56?AM, Linus Torvalds wrote:
> On Mon, Jun 12, 2023 at 8:36?AM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>>> Or maybe Darrick (who doesn't see the issue) is running on raw
>>> hardware, and you and Zorro are running in a virtual environment?
>>
>> Ahah, it turns out that liburing-dev isn't installed on the test fleet,
>> so fstests didn't get built with io_uring support.  That probably
>> explains why I don't see any of these hangs.
>>
>> Oh.  I can't *install* the debian liburing-dev package because it has
>> a versioned dependency on linux-libc-dev >= 5.1, which isn't compatible
>> with me having a linux-libc-dev-djwong package that contains the uapi
>> headers for the latest upstream kernel and Replaces: linux-libc-dev.
>> So either I have to create a dummy linux-libc-dev with adequate version
>> number that pulls in my own libc header package, or rename that package.
>>
>> <sigh> It's going to take me a while to research how best to split this
>> stupid knot.
> 
> Oh, no, that's great. It explains why you don't see the problem, and
> Dave and Zorro do. Perfect.
> 
> No need for you to install any liburing packages, at least for this
> issue. You'll probably want it eventually just for test coverage, but
> for now it's the smoking gun we wanted - I was looking at why vhost
> would be impacted, because that commit so intentionally *tried* to not
> do anything at all to io_uring.
> 
> But it obviously failed. Which then in turn explains the bug.
> 
> Not that I see exactly where it went wrong yet, but at least we're
> looking at the right thing. Adding Jens to the participants, in case
> he sees what goes wrong.
> 
> Jens, commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix
> freezer/ps regression") seems to have broken core dumping with
> io_uring threads, even though it tried very hard not to. See
> 
>   https://lore.kernel.org/all/20230611124836.whfktwaumnefm5z5@zlang-mailbox/
> 
> for the beginning of this thread.
> 
> Honestly, that "try to not change io_uring" was my least favorite part
> of that patch, because I really think we want to try to aim for these
> user helper threads having as much infrastructure in common as
> possible. And when it comes to core dumps, I do not believe that
> waiting for the io_uring thread adds anything to the end result,
> because the only reason we wait for it is to put in the thread
> register state into the core dump, and for kernel helper threads, that
> information just isn't useful. It's going to be the state that caused
> the thread to be created, not anything that is worth saving in a core
> dump for.
> 
> So I'd actually prefer to just simplify the logic entirely, and say
> "PF_USER_WORKER tasks do not participate in core dumps, end of story".
> io_uring didn't _care_, so including them wasn't a pain, but if the
> vhost exit case can be delayed, I'd rather just say "let's do thig
> thing for both io_uring and vhost, and not split those two cases up".
> 
> Anyway, I don't see exactly what goes wrong, but I feel better just
> from this having been narrowed down to io_uring threads. I suspect
> Jens actually might even have a core-dumping test-case somewhere,
> since core dumping was a thing that io_uring ended up having some
> issues with at one point.

I'll take a look - at the exact same time as your email, someone just
reported this issue separately on the liburing GH page as well. Tried
myself, and yup, anything that ends up spawning an io-wq worker and then
core dumps will now get stuck:

[  136.271250] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  136.271711] task:ih              state:D stack:0     pid:736   ppid:727    flags:0x00000004
[  136.272218] Call trace:
[  136.272353]  __switch_to+0xb0/0xc8
[  136.272555]  __schedule+0x528/0x584
[  136.272757]  schedule+0x4c/0x90
[  136.272936]  schedule_timeout+0x30/0xdc
[  136.273179]  __wait_for_common+0x8c/0x118
[  136.273407]  wait_for_completion_state+0x1c/0x30
[  136.273686]  do_coredump+0x334/0x1000
[  136.273898]  get_signal+0x19c/0x5d8
[  136.274108]  do_notify_resume+0x10c/0xa0c
[  136.274346]  el0_da+0x50/0x5c
[  136.274555]  el0t_64_sync_handler+0xb8/0x134
[  136.274812]  el0t_64_sync+0x168/0x16c

Not good... I don't immediately see what the issue is, but I'll poke
shortly after a few meetings.

-- 
Jens Axboe

