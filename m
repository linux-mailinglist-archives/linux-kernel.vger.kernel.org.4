Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618A6B7CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCMPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjCMPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:54:03 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29354298C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:53:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r4so7179124ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678722811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GwmHsZ4aR/s+GWHvo1abiSlvkMUwX5enaxuZbVVdEk=;
        b=ZGZb9iAS2PdSYCyKo2MjEa7gCePvHm57os60uA0GV35/UACv17wDXCT1FA0zKn2b5h
         S5OnT126+LdT6FD9Mfz66iN/LSrpbI1TpRTb5HmeRF85VVszF1M5mKOv4mFon9Xa7ntK
         vkS/qnkR7Q2SIEQb+faOLJbF0U4Zk8bb/CC36eKKF73KwsN2vIqhEJP4v30FeBs8kN46
         mJvPRHIVdJ6cqJcFxaOpYVv5u/3NOvKIFiWjQgPx7DQ7K8tC+oLE7At7A+Hl/E0ciyHc
         aKW8R+oRIuLfYGVLsOlA41b2kdo4ua7eARWYGRu5AY2rZ5BDzHGc0Nv6QQ3LishbVZVf
         DjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678722811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GwmHsZ4aR/s+GWHvo1abiSlvkMUwX5enaxuZbVVdEk=;
        b=bUsxOKvqehlHiH9s79+VBDEM+AOuY2VZoXxuXmxgpIiEv4EEHZhPXClsfx8HBPAFOn
         mwQ9w9F04DoBrx/Ga4bMAWQJEvfPzlqTIHyRDZpU5XGEFT0DUbpmay2hZ5T4ixfi4FNw
         ozHa9KTkLCblSNAEQsCA7CUukAkmNpgGK9in/tp+kdNjfc7JVlv/VOORKVNKT9zo9lGV
         UYmJtFPzpbX3t3LSS2dVcEyWWPOMcB6URD43c+dXdoz1+NjfAr2yZnedBnkiN0ULRS0q
         Ir3v61ZV+wXANCQhXm+E6bmZiR/XFDtHhMQoBSl0K+x2V+eAtFb+n2J5l4zhs6mkcwky
         J48w==
X-Gm-Message-State: AO0yUKWyeIafzJKNKgFXFZphvnGc3vAY+Jy3Z43s9FTtfQLS6OFV/LG6
        s+bQNBjdQZ8+JpgNoSKQnTajBN9rApQ=
X-Google-Smtp-Source: AK7set+WXLqpBgPZWxmoqbyHxI5wyhF35SM3zbuC8fpc49r4NTcq2AGJObDfZaIo18PyZSpJXqKIRw==
X-Received: by 2002:a92:6011:0:b0:323:aa7:bf08 with SMTP id u17-20020a926011000000b003230aa7bf08mr110927ilb.18.1678722811086;
        Mon, 13 Mar 2023 08:53:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2-20020a02c882000000b003b39dcca1dfsm2578833jao.170.2023.03.13.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:53:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Mar 2023 08:53:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 04:45:57PM -0700, Linus Torvalds wrote:
> It's another Sunday afternoon. which must mean another rc release.
> 
> This one looks fairly normal, although if you look at the diffs, they
> are dominated by the removal of a staging driver (r8188eu) that has
> been superceded by a proper driver. That removal itself is 90% of the
> diffs.
> 
> But if you filter that out, it all looks normal. Still more than two
> thirds in drivers, but hey, that's pretty normal. It's mostly gpu and
> networking as usual, but there's various other driver fixes in there
> too.
> 
> Outside of that regular driver noise (and the unusual driver removal
> noise) it's a little bit of everything: core networking, arch fixes,
> documentation, filesystems (btrfs, xfs, and ext4, but also some core
> vfs fixes). And io_uring and some tooling.
> 
> The full shortlog is appended, for the adventurous souls that want to
> get that kind of details. The release feels fairly normal so far, but
> it's early days. Please keep testing and reporting any issues,
> 

Build results:
	total: 153 pass: 146 fail: 7
Failed builds:
	alpha:allmodconfig
	csky:allmodconfig
	m68k:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 517 pass: 517 fail: 0

---
Build failures:

alpha:allmodconfig
csky:allmodconfig
m68k:allmodconfig
openrisc:allmodconfig
parisc:allmodconfig
s390:allmodconfig
sparc64:allmodconfig

Tracked at https://linux-regtracking.leemhuis.info/regzbot/mainline.

- Build failures for sparc64:allmodconfig and parisc:allmodconfig with gcc 11.x
- Build error in drivers/media/i2c/imx290.c if PM support is disabled

Fixes pending.

===
Runtime:

Warning backtraces in calls from ct_nmi_enter(),
seen randomly.

   28.758119] ------------[ cut here ]------------
[   28.758418] WARNING: CPU: 0 PID: 301 at kernel/locking/lockdep.c:5527 check_flags+0x170/0x258
[   28.759084] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[   28.759127] Modules linked in:
[   28.759652] CPU: 0 PID: 301 Comm: run.sh Tainted: G                 N 6.2.0-13115-gee3f96b16468 #1
[   28.759959] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   28.760324]  unwind_backtrace from show_stack+0x10/0x14
[   28.760567]  show_stack from dump_stack_lvl+0x68/0x90
[   28.760708]  dump_stack_lvl from __warn+0x70/0x1e0
[   28.760863]  __warn from warn_slowpath_fmt+0x118/0x230
[   28.761015]  warn_slowpath_fmt from check_flags+0x170/0x258
[   28.761179]  check_flags from lock_is_held_type+0x6c/0x308
[   28.761326]  lock_is_held_type from rcu_read_lock_sched_held+0x3c/0x70
[   28.761505]  rcu_read_lock_sched_held from trace_rcu_dyntick+0x7c/0x128
[   28.761698]  trace_rcu_dyntick from ct_nmi_enter+0x6c/0xe4
[   28.761857]  ct_nmi_enter from irq_enter+0x8/0x10
[   28.762021]  irq_enter from generic_handle_arch_irq+0xc/0x64
[   28.762187]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[   28.762370]  call_with_stack from __irq_svc+0x9c/0xbc
[   28.762594] Exception stack(0xd1b15f60 to 0xd1b15fa8)
[   28.762849] 5f60: ecac8b10 40000000 b6ec9418 c1c2607c 00000000 40000000 c557b00b 00000001
[   28.763056] 5f80: 00000b00 c0101278 c557b0f0 00000000 00000051 d1b15fb0 c01011c4 c0103c00
[   28.763249] 5fa0: 40000013 ffffffff
[   28.763394]  __irq_svc from vfp_support_entry+0x1c/0x30
[   28.763659] irq event stamp: 6348
[   28.763783] hardirqs last  enabled at (6347): [<c010106c>] __und_usr+0x6c/0x98
[   28.764030] hardirqs last disabled at (6348): [<c0100bd4>] __irq_svc+0x54/0xbc
[   28.764232] softirqs last  enabled at (6328): [<c0103814>] vfp_sync_hwstate+0x48/0x8c
[   28.764453] softirqs last disabled at (6326): [<c01037cc>] vfp_sync_hwstate+0x0/0x8c
[   28.764665] ---[ end trace 0000000000000000 ]---
[   28.764907] irq event stamp: 6348
[   28.765018] hardirqs last  enabled at (6347): [<c010106c>] __und_usr+0x6c/0x98
[   28.765202] hardirqs last disabled at (6348): [<c0100bd4>] __irq_svc+0x54/0xbc
[   28.765386] softirqs last  enabled at (6328): [<c0103814>] vfp_sync_hwstate+0x48/0x8c
[   28.765575] softirqs last disabled at (6326): [<c01037cc>] vfp_sync_hwstate+0x0/0x8c

Sample decoded stack trace:

[   11.848957] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
[   11.848999] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
[   11.849026] dump_stack_lvl from __warn (./include/linux/jump_label.h:260 ./include/linux/jump_label.h:270 ./include/trace/events/error_report.h:69 kernel/panic.c:681)
[   11.849053] __warn from warn_slowpath_fmt (./include/asm-generic/preempt.h:59 ./include/linux/context_tracking.h:154 kernel/panic.c:706)
[   11.849081] warn_slowpath_fmt from check_flags (kernel/locking/lockdep.c:5527 (discriminator 9))
[   11.849110] check_flags from lock_is_held_type (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5711)
[   11.849138] lock_is_held_type from rcu_read_lock_sched_held (kernel/rcu/update.c:125)
[   11.849170] rcu_read_lock_sched_held from ct_nmi_enter (./include/trace/events/rcu.h:480 ./include/trace/events/rcu.h:480 kernel/context_tracking.c:297)
[   11.849202] ct_nmi_enter from irq_enter (kernel/softirq.c:625)
[   11.849227] irq_enter from generic_handle_arch_irq (kernel/irq/handle.c:238)
[   11.849256] generic_handle_arch_irq from call_with_stack (arch/arm/lib/call_with_stack.S:45)
[   11.849287] call_with_stack from __irq_svc (arch/arm/kernel/entry-armv.S:232)

Seen if CONFIG_DEBUG_LOCK_ALLOC=y and CONFIG_CONTEXT_TRACKING_IDLE=y.
It seems that rcu_read_lock_sched_held() can be true when entering an interrupt.

The problem is not seen in v6.2, but occurs randomly on ToT with various
arm emulations.
First time observed and reproduced with v6.2-5715-g0175ec3a28c6. Still trying
to track down further.

Guenter
