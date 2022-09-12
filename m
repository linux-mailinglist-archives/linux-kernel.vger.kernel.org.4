Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4C5B5E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiILQpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:45:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A162165AD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:45:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t3so9152388ply.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=EY8pYvzj3D9WSf0m53dkV0F4IK2jIdSrZJTjXWVz+t8=;
        b=piCwhde3FyxUle5fItN9yo1o3zDe2FtN2sqTlue6eCG3dXPJIQ4UaHi1ihhY1yMQ+N
         CRPQZojxsMiTjhF1E2NinJnw7iOhvqPmrS9Mdl5v+MNYO1RDuxATEpwWbbrrRZhbjNOD
         l2JyqaVon0rjlyhhSDg/tdSw8Jz9LrrvynyPnIPa5FPRnn/udMl+Bx27CDAt7bUdCWuZ
         b9fdswFek3JFsZiA16ydh81QfyASMLbFB1T8bi79Ry5aCLWGyQacMIkjnRiFACzGLiwY
         S5eq/NSbfXc00prhmK0/TEtdVUjmaJoDbPLknG5Rm83n5lGtvN+xhOEp4RJtBoqvCyKQ
         UluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EY8pYvzj3D9WSf0m53dkV0F4IK2jIdSrZJTjXWVz+t8=;
        b=ftsPeL3SDnkbz6NDOy1jLsB62g88oBt76vWEDa22laVf6rXcUMkLXwidf8ibd1h3At
         f28F38OImPHkt/HPcNDBkYDl15kS+gKkyEpzw2mukGyHvQuVgHN8LvRtUUJSCiJ8eXiy
         iq3HKCArxNx00zXnW1EwxOz79YDDiIXN8BLx6+wXLlmNrhskGNeJdSrGNlMcme6A5bhF
         hV+ZHH7fFGBKGdkJ1OmVAP26+fUwm129XjyuarKqd7CWgeXhU/vXP9uEEqY2/2DpN1rV
         RDCrpnpJhYonYvi1M/18OeYf3NmjmXUjEW+fYbSqhHSkqBsPvA6jsNxZYDi7OUA+GdKR
         9qpQ==
X-Gm-Message-State: ACgBeo3Ktm0RufweS2a3IxttbpP3X9qTH+PYfszglmvrH+F5OOZVdyUc
        XWq36yEgpBrIvpdRiuE6TYWjL/Mp3qZBVPJK
X-Google-Smtp-Source: AA6agR63KA9OjhF7FtQRziFsMqfmkeFeUpGD+3t6ovJrO6Cklj8LpLP3VSDAizQxLysOZsWzZtnmMg==
X-Received: by 2002:a17:90a:ec17:b0:202:6e66:750a with SMTP id l23-20020a17090aec1700b002026e66750amr23132924pjy.211.1663001099903;
        Mon, 12 Sep 2022 09:44:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g186-20020a6252c3000000b00541e7922fa0sm4703477pfb.191.2022.09.12.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:44:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 12 Sep 2022 09:44:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.0-rc5
Message-ID: <20220912164456.GA3677150@roeck-us.net>
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 05:03:53PM -0400, Linus Torvalds wrote:
> It's Sunday afternoon, time for another -rc release.
> 
> Things look fairly normal for the rc5 timeframe, at least in number of
> commits, and in the diffstat.
> 
> A bit over half the diff is drivers: GPU, rdma, iommu, networking,
> sound, scsi... A little bit of everything.
> 
> The rest is the usual random fixes, with i2c doc updates standing out,
> but also various DT updates, a few filesystem fixes (btrfs and erofs),
> some core networking, and some tooling (perf and selftests).
> 
> Nothing looks particularly scary, so jump right in.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 490 pass: 489 fail: 1
Failed tests:
	mcf5208evb:m5208:m5208evb_defconfig:initrd

Guenter

---
TL;DR: Patches / reverts needed to fix known regressions

Revert "net: fec: Use a spinlock to guard `fep->ptp_clk_on`"
Revert "fec: Restart PPS after link state change"
    revert b353b241f1eb
    revert f79959220fa5
    Rationale:
	The patches result in various tracebacks and crashes.
	https://lore.kernel.org/netdev/20220827160922.642zlcd5foopozru@pengutronix.de/

Note: As promised, CONFIG_CGROUP_FREEZER is now disabled
in my riscv qemu tests, and the warning observed after enabling it
is no longer reported.

==============================
Details:

Build:

No regressions observed in my build tests.

-----------

qemu tests:

Crashes:

---------
Crash in qemu's m68k:mcf5208evb emulation.

*** ILLEGAL INSTRUCTION ***   FORMAT=4
Current process id is 1
BAD KERNEL TRAP: 00000000
PC: [<00000000>] 0x0
SR: 2714  SP: (ptrval)  a2: 40829634
d0: 00002710    d1: 00002010    d2: 40829442    d3: 00002010
d4: 00000000    d5: 402e818a    a0: 00000000    a1: 40824000
Process swapper (pid: 1, task=(ptrval))
Frame format=4 eff addr=400681c2 pc=00000000
Stack from 40831cec:
        40829442 00002010 40831e0c 402e818a 40b9e000 00000008 408295a4 40829000
        401b0cea 40829634 40829420 00000000 40829420 40829000 00000200 401dcd1a
        40884a50 401b13b6 408295a4 40829702 40347ee0 401ad0ce 40829420 40347eea
        00000000 40831e0c 402e818a 40b9e000 00000008 40347ee0 40829000 fffffff8
        4082945a 40829000 408294c7 00000002 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 [<401b0cea>] fec_ptp_gettime+0x3a/0x8c
 [<401dcd1a>] __alloc_skb+0xb0/0x24c
 [<401b13b6>] fec_ptp_save_state+0x12/0x3e
 [<401ad0ce>] fec_restart+0x5a/0x770
 [<401ae2fe>] fec_probe+0x74a/0xd06
 [<402c1144>] strcpy+0x0/0x18
 [<402d3a1c>] mutex_unlock+0x0/0x40
 [<402d39dc>] mutex_lock+0x0/0x40
 [<401840b9>] uart_carrier_raised+0x45/0xe6
 [<4019391e>] platform_probe+0x22/0x60
...

Bisect points to commit f79959220fa5fbd ("fec: Restart PPS after link state
change"). Reverting this commit fixes the problem.

---------
Warnings:

Seen in various arm imx emulations:

[   18.401688] BUG: sleeping function called from invalid context at drivers/clk/imx/clk-pllv3.c:68
[   18.402277] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
[   18.402531] preempt_count: 1, expected: 0
[   18.402781] 3 locks held by swapper/0/1:
[   18.402967]  #0: c423ac8c (&dev->mutex){....}-{3:3}, at: __driver_attach+0x80/0x158
[   18.404364]  #1: c40dc8e8 (&fep->tmreg_lock){....}-{2:2}, at: fec_enet_clk_enable+0x58/0x250
[   18.404752]  #2: c1a71af8 (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0xc/0xd4
[   18.405246] irq event stamp: 129384
[   18.405403] hardirqs last  enabled at (129383): [<c10850b0>] _raw_spin_unlock_irqrestore+0x50/0x64
[   18.405667] hardirqs last disabled at (129384): [<c1084e70>] _raw_spin_lock_irqsave+0x64/0x68
[   18.405915] softirqs last  enabled at (129218): [<c01017bc>] __do_softirq+0x2ac/0x604
[   18.406255] softirqs last disabled at (129209): [<c012eee4>] __irq_exit_rcu+0x138/0x17c
[   18.406792] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.0.0-rc5 #1
[   18.407131] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   18.407590]  unwind_backtrace from show_stack+0x10/0x14
[   18.407890]  show_stack from dump_stack_lvl+0x68/0x90
[   18.408097]  dump_stack_lvl from __might_resched+0x17c/0x284
[   18.408328]  __might_resched from clk_pllv3_wait_lock+0x4c/0xcc
[   18.408557]  clk_pllv3_wait_lock from clk_core_prepare+0xc4/0x328
[   18.408783]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.408986]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.409205]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.409416]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.409631]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.409847]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.410065]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.410284]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.410513]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   18.410729]  clk_core_prepare from clk_prepare+0x20/0x30
[   18.410936]  clk_prepare from fec_enet_clk_enable+0x68/0x250
[   18.411143]  fec_enet_clk_enable from fec_probe+0x32c/0x1430
[   18.411352]  fec_probe from platform_probe+0x58/0xbc
[   18.411558]  platform_probe from really_probe+0xc4/0x2f4
[   18.411772]  really_probe from __driver_probe_device+0x80/0xe4
[   18.411983]  __driver_probe_device from driver_probe_device+0x2c/0xc4
[   18.412203]  driver_probe_device from __driver_attach+0x8c/0x158
[   18.412418]  __driver_attach from bus_for_each_dev+0x74/0xc0
[   18.412631]  bus_for_each_dev from bus_add_driver+0x154/0x1e8
[   18.412844]  bus_add_driver from driver_register+0x88/0x11c
[   18.413055]  driver_register from do_one_initcall+0x68/0x428
[   18.413271]  do_one_initcall from kernel_init_freeable+0x18c/0x240
[   18.413502]  kernel_init_freeable from kernel_init+0x14/0x144
[   18.413721]  kernel_init from ret_from_fork+0x14/0x28
[   18.414036] Exception stack(0xd0825fb0 to 0xd0825ff8)
[   18.414523] 5fa0:                                     00000000 00000000 00000000 00000000
[   18.414792] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   18.415032] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000

Caused by "net: fec: Use a spinlock to guard `fep->ptp_clk_on`".
