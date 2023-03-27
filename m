Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA266C9BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjC0HRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjC0HRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:17:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8537422F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:17:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so7535166plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679901470;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWSVNJk/bfwWX8b0n0HSlnZIGIsvONb5lwc/xcHmAjM=;
        b=G7vb0uugGhn2s4BXyI0ntWGcXcBoiLpXjRc7DJ1MSK7K4mN4Vp+UeQRl2kXpvRwSdl
         UZtzg5zGEY3hA6SCzDlLslro1PBWXnDJcqEN80CDR0hAiuQbCHi2X/4QIaY5N64gMenT
         fGTZUpJttKNB7EtkvGnIHQwnUarplv67pW87eJ78HZ6ywDfNz9nE5otDlmQixmenXe92
         Uz8qjGpjev7YcE7eAcycaU/xiFd0kHmG2rXzCSGt9E5bE//oxtn762NMRq2H4x9DvUjV
         DSvbrVCf6CUEy+zamXkbCz9tmlnndt22M1jvRWjD1BQsTc479UX2OJNhpwM601AKuYtS
         9PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679901470;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWSVNJk/bfwWX8b0n0HSlnZIGIsvONb5lwc/xcHmAjM=;
        b=0lzGSGlBbopkS47GNOIkqTkcJ85VVH+lwXeNPokpqo8adK8q1WyL9LKIQfhgHUbl2l
         FGiGf7el3zkV2KUhssCJVENoPWnOFaMFuSNVzuiXtj5LECdg3yBBuFJ/GrQwLL8hDbF2
         6NtP78QY9xH8D9lD8geB0jLQsIuCKKpDjWelfR0SmJeNPlq9uq7znPmPkdSdjJ1Rjp54
         2SgGjTGeKiTeHvVuFQj615OZjFP4hlWv9FUxl3LM+io2n7N9wFi/a5aeh/ViSpTy3uYT
         0Q+XdRBW2CsA56P+E422OqZEqHBv1Lhaf1B+XakX7mB5Sk6vg8eMDR4BaBsT0XS8Fx96
         FV/Q==
X-Gm-Message-State: AO0yUKVjx8p6oBcvwifTOhn0EV6NXOYWXZT+nRxIW5FG+SHoZ0zFOPNe
        gPsOq6NqbNt4AggmbMC0D7FsI/hK38A=
X-Google-Smtp-Source: AK7set9Fl4HRg/qPMTOkdyKC5K/9e+uJFHr5PdEOzN/l3gjLKStQUVTj9g1hmFmAsxJ3yc0KNbEbvA==
X-Received: by 2002:a05:6a20:c511:b0:d4:e980:9f90 with SMTP id gm17-20020a056a20c51100b000d4e9809f90mr11045810pzb.44.1679901470032;
        Mon, 27 Mar 2023 00:17:50 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id x5-20020aa784c5000000b006262520ac59sm17979318pfn.127.2023.03.27.00.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:17:49 -0700 (PDT)
Date:   Mon, 27 Mar 2023 16:17:46 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: WARNING in do_timer_settime
Message-ID: <ZCFDGrz5mJXLLC49@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking an issue detected during fuzzing "WARNING in
do_timer_settime". Its report is attached at the end of this email.

I think this does not cause any serious issue, but my rough sketch of
a scenario causing the warning is a race condition caused by two
timer_settime() system calls for CLOCK_PROCESS_CPUTIME_ID.

CPU1                                       CPU2
-----                                      -----
do_timer_settime(CLOCK_PROCESS_CPUTIME_ID)
  posix_cpu_timer_set()
    arm_timer(timer, p);

timer interrupt handler
  run_posix_cpu_timers()
    handle_posix_cpu_timers()
      lock_task_sighand()
      check_process_timers()
        collect_posix_cpu_timers()         do_timer_settime(CLOCK_PROCESS_CPUTIME_ID)
          ctmr->firing = 1; - (1)            posix_cpu_timer_set()
      unlock_task_sighand() - (2)
                                               lock_task_sighand() // can acquire the sighand
                                                                   // lock because of (2)
                                               if (timer->it.cpu.firing)) // true because of (1) and (3)
                                                 ret = TIMER_RETRY;
                                                 ..
                                                 return tret;
                                             timer_wait_running()
                                               WARN_ON(!kc->timer_was_running);
                                               // kc->timer_was_running is NULL in clock_posix_cpu
     timer->it.cpu.firing = 0; - (3)


But regardless of the scenario, I wonder if the commit ec8f954a40d
("posix-timers: Use a callback for cancel synchronization on
PREEMPT_RT") missed initializations to the timer_was_running field in
clock_posix_cpu. I can see that the commit initialized the
timer_was_running field of all other clocks but clock_posix_cpu.  So I
think the warning does not occur if the timer_was_running field of
clock_posix_cpu is initialized to, for example,
common_timer_wait_running. Could you please check this?

Thank you in advance.


Best regards,
Dae R. Jeong

-----
- Kernel version:
  6.2.0-rc7

- Report:
WARNING: CPU: 1 PID: 13389 at kernel/time/posix-timers.c:849 do_timer_settime+0x193/0x200 kernel/time/posix-timers.c:929
Modules linked in:
CPU: 1 PID: 13389 Comm: syz-executor.0 Not tainted 6.2.0-rc7-32171-g7f09e8f6ebfb #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
<- omitting registers ->
Call Trace:
 <TASK>
 __do_sys_timer_settime kernel/time/posix-timers.c:952 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:938 [inline]
 __x64_sys_timer_settime+0xa3/0x110 kernel/time/posix-timers.c:938
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x478d29
<- omitting registers ->
 </TASK>
---[ end trace 0000000000000000 ]---
