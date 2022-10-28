Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9610B611731
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJ1QOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJ1QNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:13:45 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0ABDAC53
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:10:48 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso3253376otn.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YDA/V3/WxI2uvBdaH/vsS90qHvxwRGJNdsL6OYISOs=;
        b=FJJiBi5ePUSzZozBl2+gOy78g3g1Kfn3ow4477dPIZ6WqmMcUeHrQ/MTvz2oy+kRcj
         VSMy8ptnuQr9ud+/IbkZj4wT3ct8v8ZLN7SHH9bxfNLDz/Jc27tk1UZn9EDiAxARX0r9
         D+uHA2C5c4gyZIDuKuPh8uQdTJs1YkY3lk+MpGgplYnyFyX5WOfXKypeOL4F7lGo2MGF
         z7jlyfAFwywmwMI2b7DMNVXm3x3hn6duDB7clq9FwxbHTf+gKPAJUk5elKgZL/UQ9PcX
         2WlPhGhBe/zUKc3fC4wmmxuKawxbdLu5+UEU6dqPqMJ7jc+yZ5QQhK2kVaSxAiPQeW5n
         Cutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YDA/V3/WxI2uvBdaH/vsS90qHvxwRGJNdsL6OYISOs=;
        b=0+cfqTvVI8cNnPkCQ4exIDW3pvm6VwrT+dYiAqK3h+D61EbVU6r/zKK485a28lBu+2
         vjqWqr4TpI4BIKm7yfVJJql4oetucACdGrN+CGmFrG/bEKAHTIVN3TnpeIW/uwkeUUSk
         tUhE0P2mqQSGEPxtls6g6PU8n0HS7gcvDshRB6g7Zy9KUOzoA7SA02W2FgbK54v/OoCG
         7bI6L3eNuJIou7J0bM1C/r0BKfnx221DlAj6LnNzrO3Hin4DKnnsEeUs7PUbe0nV5ok7
         mR2Jy/h0ouCxVKWAUpZ0IqxmHIl/Kg/z2LHQlwWM01uikos9xkWNravuZIT0xtdaQKc2
         nvlQ==
X-Gm-Message-State: ACrzQf1OM+TAKKDvBn4yuN5g8PGgnvvyKf0/yT8zlDoSU64SLXcktSze
        pmCast9sPlWPzVKtEmmMLF0=
X-Google-Smtp-Source: AMsMyM4Oyr9JsXtOxMWn5V4puKPDfGPTig+b3wT8qmwDPxon0/fjk0VAfPMXKl6tiij3goJOr+YQag==
X-Received: by 2002:a05:6830:6a14:b0:662:28ac:e0cd with SMTP id cz20-20020a0568306a1400b0066228ace0cdmr37172otb.77.1666973447639;
        Fri, 28 Oct 2022 09:10:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k127-20020aca3d85000000b003549397fde4sm1112878oia.54.2022.10.28.09.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:10:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0dc2a887-d7ca-e842-3a01-0cebcbc1de00@roeck-us.net>
Date:   Fri, 28 Oct 2022 09:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20221027150525.753064657@goodmis.org>
 <20221027222404.GA3123386@roeck-us.net>
 <20221027185859.1087d3ca@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
In-Reply-To: <20221027185859.1087d3ca@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 15:58, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 15:24:04 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Thu, Oct 27, 2022 at 11:05:25AM -0400, Steven Rostedt wrote:
>>>
>>> Back in April, I posted an RFC patch set to help mitigate a common issue
>>> where a timer gets armed just before it is freed, and when the timer
>>> goes off, it crashes in the timer code without any evidence of who the
>>> culprit was. I got side tracked and never finished up on that patch set.
>>> Since this type of crash is still our #1 crash we are seeing in the field,
>>> it has become a priority again to finish it.
>>>
>>> This is v2 of that patch set. Thomas Gleixner posted an untested version
>>> that makes timer->function NULL as the flag that it is shutdown. I took that
>>> code, tested it (fixed it up), added more comments, and changed the
>>> name to del_timer_shutdown() as Linus had asked. I also converted it to use
>>> WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.
>>>    
>>
>> Here are various warnings and crashes. Complete logs are at
>>
>> https://kerneltests.org/builders
>>
>> in the "testing" column of the qemu test results.
>>
>> This is with the published patch set plus the fixups in
>> timer_fixup_init() and timer_fixup_free().
>>
>> Guenter
>>
>> ---
>> Block code:
>>
>> WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0x66/0x7a
>> ODEBUG: free active (active state 0) object type: timer_list hint: blk_rq_timed_out_timer+0x0/0xc
> 
> This is probably just missing a switch to shutdown.
> 
>>
>> ---
>> In tcp:
>>
>> WARNING: CPU: 0 PID: 255 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: free active (active state 0) object type: timer_list hint: tcp_keepalive_timer+0x0/0x3a8
>>
>> WARNING: CPU: 0 PID: 255 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: free active (active state 0) object type: timer_list hint: tcp_write_timer+0x0/0x1a8
> 
> Looking at these, I think the del_timer_try_shutdown() needs to always
> shutdown (let's try that, and see if that fixes things before we rename
> anything).
> 
>>
>> ---
>> Other networking:
>>
>> WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x468
>>
>> ---
>>
>> WARNING: CPU: 0 PID: 280 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: init active (active state 0) object type: timer_list hint: tulip_timer+0x0/0x38
>>
>> That one is often followed by:
>>
>> [   29.833216] ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
>> [   29.833723] WARNING: CPU: 0 PID: 365 at lib/debugobjects.c:502 debug_print_object+0xb8/0x100
>>
>> in the same code line, suggesting that the timer may be shut down
>> more than once (?). Then there is another crash with
>>
>> [   29.863890] Insufficient stack space to handle exception!
>> [   29.863939] ESR: 0x0000000096000047 -- DABT (current EL)
>> [   29.863952] FAR: 0xffff800008b17f80
>> [   29.863959] Task stack:     [0xffff800008b18000..0xffff800008b1c000]
>> [   29.863967] IRQ stack:      [0xffff800008000000..0xffff800008004000]
>> [   29.863975] Overflow stack: [0xffff30a35fe7a0f0..0xffff30a35fe7b0f0]
>> [   29.863987] CPU: 0 PID: 365 Comm: ip Tainted: G        W        N 6.1.0-rc2-00138-gced58c742836 #1
>> [   29.863999] Hardware name: linux,dummy-virt (DT)
>>
>> followed by a sequence of
>>
>> [   29.864572]  __try_to_del_timer_sync+0x40/0xdc
>> [   29.864582]  __del_timer_sync+0xa4/0x100
>> [   29.864590]  timer_fixup_init+0x2c/0x5c
>> [   29.864599]  __debug_object_init+0x248/0x53c
>> [   29.864606]  debug_object_init+0x24/0x30
>> [   29.864614]  timer_fixup_init+0x40/0x5c
>> [   29.864622]  __debug_object_init+0x248/0x53c
>> [   29.864630]  debug_object_init+0x24/0x30
>> [   29.864637]  timer_fixup_init+0x40/0x5c
>> [   29.864645]  __debug_object_init+0x248/0x53c
>> [   29.864658]  debug_object_init+0x24/0x30
>> [   29.864666]  timer_fixup_init+0x40/0x5c
>> ...
>> [   29.866492]  debug_object_init+0x24/0x30
>> [   29.866500]  init_timer_key+0x7c/0x80
>> [   29.866508]  tulip_down+0x1d0/0x24c
>> [   29.866518]  tulip_close+0x3c/0xc0
>>
>> This crash is seen with variants on several platforms/architectures.
> 
> Hmm, I'll have to take a deeper look here.
> 
>>
>> ---
>>
>> WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: free active (active state 0) object type: timer_list hint: addrconf_dad_work+0x0/0x628
> 
> Hmm, I was afraid of this one.
> 
> Looks to be from the workqueue code for delayed work. I don't see a place
> that frees besides just flushing it. And we can't determine if a flush is
> permanent or will be armed again.
> 
> May need to add a helper function that resets the debugging so that it
> doesn't trigger on delayed work timers. There's a DEBUG_OBJECTS_WORK that
> handles bad work queue issues.
> 
> 
>>
>> ---
>> mips64:
>>
>> WARNING: CPU: 0 PID: 280 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
> 
> Not a very good hint.
> 
>> Modules linked in:
>> CPU: 0 PID: 280 Comm: ip Tainted: G        W        N 6.1.0-rc2-00138-gced58c742836 #1
>> Stack : 0000000000000056 ffffffffffffffff 0000000000000008 00b65275abba8126
>>          00b65275abba8126 0000000000000000 9000000004193728 ffffffff80f29f38
>>          ffffffff8105c9d8 ffffffffffff8880 9000000004193668 0000000000000000
>>          0000000000000005 0000000000000010 ffffffff80c731a0 ffffffff81030000
>>          2020205720202020 ffffffff81030000 0000000000000000 ffffffff80f29f38
>>          0000000000000009 00000000000001f6 ffffffff8063d45c ffffffff81cb94c0
>>          ffffffff81d76240 0000000000000000 ffffffff807575a8 0000000000000000
>>          ffffffff81230000 9000000004190000 9000000004193720 9000000018002030
>>          ffffffff80c8f528 0000000000000000 0000000000000000 00b65275abba8126
>>          ffffffff8122e050 000000001000a4e1 ffffffff8010a884 00b65275abba8126
>>          ...
>> Call Trace:
>> [<ffffffff8010a884>] show_stack+0x3c/0x120
>> [<ffffffff80c8f528>] dump_stack_lvl+0x4c/0x90
>> [<ffffffff80130e54>] __warn+0xdc/0x1c8
>> [<ffffffff80c75a08>] warn_slowpath_fmt+0x98/0xc4
>> [<ffffffff8063d45c>] debug_print_object+0xa4/0xd8
>> [<ffffffff8063e590>] __debug_object_init+0x2d0/0x670
>> [<ffffffff801b44b8>] timer_fixup_init+0x40/0x58
>>
>> irq event stamp: 1537
>> hardirqs last  enabled at (1549): [<ffffffff8018e67c>] __up_console_sem+0x9c/0xc8
>> hardirqs last disabled at (1560): [<ffffffff8018e658>] __up_console_sem+0x78/0xc8
>> softirqs last  enabled at (1324): [<ffffffff80a572bc>] dev_deactivate_many+0x32c/0x458
>> softirqs last disabled at (1322): [<ffffffff80a57288>] dev_deactivate_many+0x2f8/0x458
>> ---[ end trace 0000000000000000 ]---
>>
>> =====================================
>> WARNING: bad unlock balance detected!
>> 6.1.0-rc2-00138-gced58c742836 #1 Tainted: G        W        N
>> -------------------------------------
>> �������␈␂/-1 is trying to release lock (&obj_hash[i].lock) at:
>> [<ffffffff801b41e0>] __try_to_del_timer_sync+0x48/0x140
>> but there are no more locks to release!
>>
>> other info that might help us debug this:
>> qemu-system-mips64: terminating on signal 15 from pid 2525787 (/bin/bash)
>>
>> ---
>> Openrisc fails completely. Lots of the following, then boot stalls.
>>
>> WARNING: CPU: 0 PID: 88 at lib/debugobjects.c:502 debug_print_object+0xc0/0xe8
>> ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
>> Modules linked in:
>> CPU: 0 PID: 88 Comm: udhcpc Not tainted 6.1.0-rc2-00138-gced58c742836 #1
>> Call trace:
>> [<8eaa3f51>] dump_stack_lvl+0x44/0x80
>> [<4da6c5ef>] dump_stack+0x1c/0x2c
>> [<1b9f58b7>] __warn+0xdc/0x118
>> [<86d4d066>] ? debug_print_object+0xc0/0xe8
>> [<689beae8>] warn_slowpath_fmt+0x78/0x90
>> [<86d4d066>] debug_print_object+0xc0/0xe8
>> [<872f4074>] __debug_object_init+0x2bc/0x7f4
>> [<c30d6214>] ? _raw_spin_unlock_irqrestore+0x50/0x84
>> [<c3f3be91>] ? debug_check_no_locks_freed+0xb8/0x194
>> [<558675c1>] ? slob_alloc+0xe8/0x350
>> [<26225550>] ? lockdep_init_map_type+0x68/0x38c
>> [<c3f3be91>] ? debug_check_no_locks_freed+0xb8/0x194
>> [<2c9cf7b5>] ? inet_create+0x2e8/0x404
>> [<bab055df>] debug_object_init+0x30/0x40
>> [<6d2e468f>] init_timer_key+0xb4/0x110
>> [<60c0d3e7>] ? sk_init_common+0x1a0/0x1c0
>> [<b52686c2>] sock_init_data+0x60/0x2a4
>> [<1ff904c3>] ? sk_alloc+0xe8/0x138
>> [<ca3e6ef9>] inet_create+0x1e0/0x404
>> [<623d726a>] ? inet_create+0x80/0x404
>> [<a3256728>] ? lock_release+0x1c0/0x30c
>> [<960a454e>] __sock_create+0x140/0x288
>> [<0290cd64>] ? __sock_create+0x98/0x288
>> [<b62bc649>] __sys_socket+0x7c/0x128
>> [<fa003224>] ? do_work_pending+0x4c/0x118
>> [<705147e9>] sys_socket+0x14/0x24
>> [<9c4e015d>] ? _syscall_return+0x0/0x4
>> ---[ end trace 0000000000000000 ]---
>>
>> ---
>> parisc crashes.
>>
>> [    3.015186] ------------[ cut here ]------------
>> [    3.015580] ODEBUG: init active (active state 0) object type: timer_list hint: timeout_waiting_on_port+0x0/0x2c
>> [    3.016945] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0x98/0xc8
>> ...
>> [    3.026117] ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
>> [    3.026355] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0x98/0xc8
>> ...
>> [ many more of the same ]
>>
>> [    3.054542] stackcheck: swapper/0 will most likely overflow irq stack (sp:11e51800, stk bottom-top:11460004-11468004)
>> [    3.054592] Kernel panic - not syncing: low stack detected by irq handler - check messages
>>
>> and boom.
>>
>> ---
>> usb:
>>
>> [   23.993737] WARNING: CPU: 0 PID: 343 at lib/debugobjects.c:502 debug_print_object+0xac/0xc8
>> [   23.993953] ODEBUG: free active (active state 0) object type: timer_list hint: hub_init_func2+0x0/0xc
> 
> Yeah, there's going to be lots of these.
> 
>>
>> ---
>> ppc:
>>
>> [    6.607478][    T1] ODEBUG: init active (active state 0) object type: timer_list hint: .ibmvscsi_timeout+0x0/0x58
>> [    6.608536][    T1] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 .debug_print_object+0xbc/0xf0
>>
>> followed by several of
>>
>> [    6.623661][    T1] ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
>> [    6.624155][    T1] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 .debug_print_object+0xbc/0xf0
>>
>> and finally:
>>
>> [    6.694785][    C0] BUG: Kernel NULL pointer dereference on read at 0x000000b8
>> [    6.694796][    C0] Faulting instruction address: 0xc0000000001ece44
>> [    6.694807][    C0] Thread overran stack, or stack corrupted
>> [    6.694967][    C0] Oops: Kernel access of bad area, sig: 7 [#1]
> 
> 
> 
> Anyway, this is all an issue with the last patch that makes calling
> shutdown a requirement before freeing and not just a hint.
> 

I can see this is a real problem. I see it all over the place. The latest is
in drivers/scsi/ibmvscsi/ibmvscsi.c where, again, timer_setup() is called
repeatedly and the timer is stopped with del_timer(), causing a crash.
Replacing those calls with del_timer_shutdown() or, where this isn't possible,
with del_timer_try_shutdown() fixes that problem.

> You may want to test all but the last patch, as only the last patch is
> what's going to trigger all the above, as it modifies the semantics of
> DEBUG_OBJECTS_TIMER.
> 

I'll do that after running a test with the change below, to see if there
are any other problems.

> But for the tcp one, add this to the queue and see if the tcp one goes away?
> 
> -- Steve
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index ecf625378078..e9838ce6a6cd 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1255,7 +1255,7 @@ int __del_timer(struct timer_list *timer, bool free)
>   	if (timer_pending(timer)) {
>   		base = lock_timer_base(timer, &flags);
>   		ret = detach_if_pending(timer, base, true);
> -		if (free && ret) {
> +		if (free) {
>   			timer->function = NULL;
>   			debug_timer_deactivate(timer);
>   		}

Just noticed that one (too many patches floating around, sorry).
Applied, and I'll test again.

Thanks,
Guenter

