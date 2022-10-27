Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139B6100E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiJ0S7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiJ0S7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:59:04 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD2275EB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:59:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id i7so3414497oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X6PZXTgrpLxNQ1hiwzzkLSIXuBvkTPvlJjM8QCe5bE=;
        b=KgmhV7u3eeMqpWjeEYhFKDjpWWv7WPpQCN3Wc1fRiz3UyVhqZ6uU1ib3ExRTtX5d27
         DTUfeN2g6EhS0vc1noFD9J3MTEcXn+0DYFfc20skrlo84MFUxpPzOB7KEttNgaMiwviu
         1TyDRwfXEK1oNGyapwn/2KL1A984xdm2PlwHFTdQKF/BK1+GXKN14u26YoL6hgBVdNxb
         h+6jUoMqvSUqqvQqsqQfZHJ39EfSbYmdZyM62Z0V+kqvGFWQh1JPQGcBCPfVY5jnY1Zj
         t4TO289jVC9Vn57hFe/sGumSBMKA9lj206nceIQakv8IlSl7QGcYaboXJ9uPdGepmkbr
         MMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X6PZXTgrpLxNQ1hiwzzkLSIXuBvkTPvlJjM8QCe5bE=;
        b=R1raZh9UPCfVqBA24wI1mHnzFTZTkSrW7ypfGxENxtjDm+JyD8PFmzv6U4oN1o5hWl
         CzNfRG28rC934Sh9gecg8mfRioL4zcOF+qtcgsUq3dfLxLsX5P/FYsTziO3Xmw7H+3fl
         VkE7z+ce6bOcgtK3L4GblM9OlCiHpz4VZQvCudisLlEYcPeoJh0wuHt76P9ugpiv2gXQ
         wKlWyZt91XH3ZkTMX6VxgIeQ3jtMJ9LKaeKu2Bx/2JIDEWou0vW5xWjM0jlL7UZ5bf/M
         7SDls4cP9QRdtBqjjta+VMRHhvMuiVAjGy2xF9iBHyhn+bqD+EEVGTNNlyY0XEINlf53
         KkVQ==
X-Gm-Message-State: ACrzQf1O3ZSnDD290CqSZp3VHq1wxZDuDMbdGjlCFLRi5On+3Gp2841E
        C6z2mrjfvpDQa7PHqJiP+yMjUVNbuTc=
X-Google-Smtp-Source: AMsMyM53G7zgGBWbmlYDvbciRr2OhzqMIHLI7eYxB8RUPqVbj1dpgp+Oum13gUSl1D362OU+zUdtZA==
X-Received: by 2002:a05:6808:8f4:b0:354:946e:8dc5 with SMTP id d20-20020a05680808f400b00354946e8dc5mr5518448oic.183.1666897143222;
        Thu, 27 Oct 2022 11:59:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e17-20020a9d5611000000b00661a1a48079sm811234oti.7.2022.10.27.11.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 11:59:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
Date:   Thu, 27 Oct 2022 11:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20221027150525.753064657@goodmis.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
In-Reply-To: <20221027150525.753064657@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/27/22 08:05, Steven Rostedt wrote:
> Back in April, I posted an RFC patch set to help mitigate a common issue
> where a timer gets armed just before it is freed, and when the timer
> goes off, it crashes in the timer code without any evidence of who the
> culprit was. I got side tracked and never finished up on that patch set.
> Since this type of crash is still our #1 crash we are seeing in the field,
> it has become a priority again to finish it.
> 
> This is v2 of that patch set. Thomas Gleixner posted an untested version
> that makes timer->function NULL as the flag that it is shutdown. I took that
> code, tested it (fixed it up), added more comments, and changed the
> name to del_timer_shutdown() as Linus had asked. I also converted it to use
> WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.
> 

I rebased the series on top of v6.1-rc2 and gave it a try. Unfortunately it
blows up in my face, first with

[   16.212535] ------------[ cut here ]------------
[   16.212887] ODEBUG: free active (active state 0) object type: timer_list hint: tcp_write_timer+0x0/0x190
[   16.213725] WARNING: CPU: 0 PID: 310 at lib/debugobjects.c:502 debug_print_object+0xb8/0x100

which, of course, might be real, but after a couple of those I get

[   16.325257] Insufficient stack space to handle exception!
[   16.325326] ESR: 0x0000000096000047 -- DABT (current EL)
[   16.325355] FAR: 0xffff800008677fe0
[   16.325366] Task stack:     [0xffff800008678000..0xffff80000867c000]
[   16.325376] IRQ stack:      [0xffff800008000000..0xffff800008004000]
[   16.325387] Overflow stack: [0xffff51e19feab300..0xffff51e19feac300]
[   16.325406] CPU: 0 PID: 310 Comm: telnet Tainted: G        W        N 6.1.0-rc2-00032-g895257c4037a #1
[   16.325425] Hardware name: linux,dummy-virt (DT)
[   16.325434] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   16.325450] pc : mark_lock+0x4/0x620
[   16.325482] lr : __lock_acquire+0x3e8/0x1950
[   16.325493] sp : ffff800008678090
[   16.325499] x29: ffff800008678090 x28: ffff51e18651ccc0 x27: ffffc690a5583000
[   16.325530] x26: ffff51e18651d590 x25: 0000000000000001 x24: 0000000000000001
[   16.325552] x23: 0000000000000001 x22: 0000000000000028 x21: ffff51e18651d568
[   16.325571] x20: ffffc690a61b5710 x19: 0000000000000000 x18: ffffffffffffffff
[   16.325589] x17: 6e6968207473696c x16: 5f72656d6974203a x15: 6570797420746365
[   16.325608] x14: 6a626f2029302065 x13: ffffc690a55a78c0 x12: 00000000000c02e7
[   16.325626] x11: 0000000030fa562e x10: ffffc690a5a9f208 x9 : ffffc690a5a9f200
[   16.325645] x8 : ffff51e18651ccc0 x7 : 0000000000000000 x6 : 000000000002e9fa
[   16.325663] x5 : 0000000000000028 x4 : 0000000000000002 x3 : 00000000000c0003
[   16.325681] x2 : 0000000000000008 x1 : ffff51e18651d590 x0 : ffff51e18651ccc0
[   16.325902] Kernel panic - not syncing: kernel stack overflow
[   16.325992] CPU: 0 PID: 310 Comm: telnet Tainted: G        W        N 6.1.0-rc2-00032-g895257c4037a #1
[   16.326008] Hardware name: linux,dummy-virt (DT)
[   16.326026] Call trace:
[   16.326031]  dump_backtrace.part.0+0xe0/0xf0
[   16.326048]  show_stack+0x18/0x40
[   16.326058]  dump_stack_lvl+0x9c/0xd8
[   16.326073]  dump_stack+0x18/0x34
[   16.326083]  panic+0x194/0x38c
[   16.326093]  nmi_panic+0xac/0xb0
[   16.326103]  panic_bad_stack+0x104/0x124
[   16.326113]  handle_bad_stack+0x34/0xe0
[   16.326124]  __bad_stack+0x78/0x7c
[   16.326134]  mark_lock+0x4/0x620
[   16.326144]  lock_acquire.part.0+0xf0/0x26c
[   16.326155]  lock_acquire+0x68/0x84
[   16.326166]  _raw_spin_lock_irqsave+0x70/0x150
[   16.326178]  debug_object_assert_init+0xa0/0x1a4
[   16.326193]  __try_to_del_timer_sync+0x40/0xdc
[   16.326207]  __del_timer_sync+0xa4/0x100
[   16.326218]  timer_fixup_free+0x2c/0x54
[   16.326229]  debug_object_free.part.0+0x188/0x1b0
...
(many more of those)
...
[   16.329989]  timer_fixup_free+0x40/0x54
[   16.329996]  __debug_check_no_obj_freed+0x1ec/0x25c
[   16.330003]  debug_check_no_obj_freed+0x20/0x90
[   16.330009]  slab_free_freelist_hook.constprop.0+0xac/0x1b0
[   16.330019]  kmem_cache_free+0x1ac/0x500
[   16.330026]  __sk_destruct+0x140/0x2a0
[   16.330035]  sk_destruct+0x54/0x64
[   16.330042]  __sk_free+0x74/0x120
[   16.330048]  sk_free+0x64/0x8c
[   16.330055]  tcp_close+0x94/0xc0
[   16.330064]  inet_release+0x50/0xb0
[   16.330071]  __sock_release+0x44/0xbc
[   16.330076]  sock_close+0x18/0x30
[   16.330081]  __fput+0x84/0x270
[   16.330088]  ____fput+0x10/0x20
[   16.330094]  task_work_run+0x88/0xf0
[   16.330102]  do_exit+0x334/0xafc
[   16.330108]  do_group_exit+0x34/0x90
[   16.330115]  __arm64_sys_exit_group+0x18/0x20
[   16.330121]  invoke_syscall+0x48/0x114
[   16.330133]  el0_svc_common.constprop.0+0x60/0x11c
[   16.330146]  do_el0_svc+0x30/0xd0
[   16.330157]  el0_svc+0x48/0xc0
[   16.330170]  el0t_64_sync_handler+0xbc/0x13c
[   16.330179]  el0t_64_sync+0x18c/0x190
[   16.330645] Kernel Offset: 0x46909ae00000 from 0xffff800008000000
[   16.330664] PHYS_OFFSET: 0xffffae1ec0000000
[   16.330686] CPU features: 0x22000,2033c080,0000421b
[   16.330752] Memory Limit: none

This is with arm64_defconfig plus various debug options.
Running the same test with v6.0.4 produces no errors, and neither
does running it with v6.1-rc2-105-gb229b6ca5abb (current mainline).

Guenter

