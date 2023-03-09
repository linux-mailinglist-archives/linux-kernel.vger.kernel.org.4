Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9943E6B2D40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCIS6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCIS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:58:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3C4AFC9;
        Thu,  9 Mar 2023 10:58:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u9so11106695edd.2;
        Thu, 09 Mar 2023 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678388304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owmgCOlzjzSmTLsvLFtUp1VdFrvtzaEkSR1qk7Evx2k=;
        b=hZUZeIpeAF/agNfjqy61ZhgY6RbfPcJiSp0FQRgywwohSpfj+pVh5wuRjgipmaptNA
         7DbxR7J/KTzehya+TezM5j0FFGsfBQpa2rGa91r5fDngliNZByhbQv65tg3NjkvzIW2r
         JU05+Ooc+feied8G6Wfs91khBoRLhkgA6/eqBblHR2vZY1dQlb0pF3Loka2nyzrQQ4ri
         C61NewzPC920cL2PlxVZ5j7zC58+WKk1eid82ceZi8rcHvc/I2Hn77NGNWgI8lmAerYZ
         Cbqo3g8PO2kueJWBVbR3FtDeFuBMsh7cCNf9QuyFSLQmNm6Qr/u9P5bpU6F7FLVcBcW5
         L8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owmgCOlzjzSmTLsvLFtUp1VdFrvtzaEkSR1qk7Evx2k=;
        b=7sT0NluHVzpuXijP45j8TQGdeyg5EcIrvgjBlEw548Xya1syoviXIe/56vUfMx2cxp
         VSYvWnnqwLzxqysfIQrxT3ZaZ1M1BlfZl2Oc4CoaaRnl7sLnfCW6/tsoVwykUUyVfaFd
         mFBKi9v1FpgVKjIB3haSstTr619wnkm/6u9ER474pRBRLM3sehaUaoSH3pRpeKNTShDy
         yP8f1MbXjRj0yo0nfcq4CjvB91dzHOFJ0QKI6gb4a6n+PWua4K4kd/U9pDctuFlhXwWl
         jlgy4hZ402a0bxb1QIt4qODPC4kASwY13k3yZeexGQfz3rOQgcF2Ebwp+9yBHeKUr+sU
         xHxw==
X-Gm-Message-State: AO0yUKVQdbs3SIGidvS+iK4eJOmFSoYRTsFUDpHTuojckNRxpiqTaZCs
        w/3M5i+sfkmgYD9257bBk40=
X-Google-Smtp-Source: AK7set+N18YKFkvztcUshIFpRWgFbTkUNg9bYiQfMV0lY6N33OsXZUmsfYc0BcZh4amuYP78MMdXgA==
X-Received: by 2002:a17:907:31c3:b0:8af:2d2e:5d31 with SMTP id xf3-20020a17090731c300b008af2d2e5d31mr30331438ejb.31.1678388304131;
        Thu, 09 Mar 2023 10:58:24 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-172.cust.vodafonedsl.it. [188.217.49.172])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906615700b008d5d721f8a4sm9100777ejl.197.2023.03.09.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:58:23 -0800 (PST)
Date:   Thu, 9 Mar 2023 19:58:21 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <ZAosTc6VNco1okyR@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
 <ZAb7JVghuiwZF1Q5@wendy>
 <2f03dfb2-5cf8-e954-913c-f0c27db6bcf5@starfivetech.com>
 <ZAh/UeSlUeGoKxki@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <4c071642-e3c8-4716-a580-5b42e25efb1c@spud>
 <ZAoOLIERMYI8UVlA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <09630acb-f1ae-4dbd-9c9c-9adb1743bfe4@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09630acb-f1ae-4dbd-9c9c-9adb1743bfe4@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 05:52:49PM +0000, Conor Dooley wrote:
> On Thu, Mar 09, 2023 at 05:49:48PM +0100, Tommaso Merciai wrote:
> > On Wed, Mar 08, 2023 at 01:36:41PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 08, 2023 at 01:28:01PM +0100, Tommaso Merciai wrote:
> > > > On Tue, Mar 07, 2023 at 06:08:53PM +0800, Hal Feng wrote:
> > > 
> > > > > The above two methods can fix the problem. Here are my test results.
> > > > > The VisionFive board can boot up successfully if and only if all above
> > > > > two applied.
> > > > > The VisionFive 2 board can boot up successfully if I merge Linus's new
> > > > > changes.
> > > > 
> > > > Tested also on my side. Hope this can be helpfull.
> > > > 
> > > > > Hope your fix will be merged in rc2. Thank you for your reply.
> > > > 
> > > > Fully agree.
> > > 
> > > If you only have a VisionFive 2, it shouldn't matter to you, as you
> > > don't need to fix up any SiFive errata (at the moment at least).
> > > Linus' fix is already in his tree, so should be in -rc2!
> > > The fix for the VisionFive was applied to Palmer's RISC-V fixes tree
> > > last night:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=fixes&id=bf89b7ee52af5a5944fa3539e86089f72475055b
> > > 
> > > Thanks,
> > > Conor.
> > 
> > 
> > Hi Conor,
> > Thanks for the info.
> > Playing with this series I got the following error:
> > 
> > [    6.278182] BUG: spinlock bad magic on CPU#0, udevd/136
> > [    6.283414]  lock: 0xffffffd84135e6c0, .magic: ffffffff, .owner: <none>/-1, .owner_cpu: -1
> > [    6.291677] CPU: 0 PID: 136 Comm: udevd Not tainted 6.3.0-rc1-g92569901a7f9-dirty #14
> > [    6.299502] Hardware name: StarFive VisionFive 2 v1.3B (DT)
> > [    6.305069] Call Trace:
> > [    6.307517] [<ffffffff80005530>] dump_backtrace+0x1c/0x24
> > [    6.312921] [<ffffffff80844b4e>] show_stack+0x2c/0x38
> > [    6.317976] [<ffffffff8085032c>] dump_stack_lvl+0x3c/0x54
> > [    6.323377] [<ffffffff80850358>] dump_stack+0x14/0x1c
> > [    6.328429] [<ffffffff80845668>] spin_dump+0x64/0x70
> > [    6.333394] [<ffffffff80058f26>] do_raw_spin_lock+0xb4/0xf2
> > [    6.338970] [<ffffffff80857d04>] _raw_spin_lock+0x1a/0x22
> > [    6.344370] [<ffffffff8008153c>] add_timer_on+0x8a/0x132
> > [    6.349684] [<ffffffff8084b9fa>] try_to_generate_entropy+0x216/0x278
> > [    6.356037] [<ffffffff804ebfdc>] urandom_read_iter+0x40/0xb8
> > [    6.361697] [<ffffffff801a1216>] vfs_read+0x17e/0x1f8
> > [    6.366752] [<ffffffff801a1986>] ksys_read+0x5e/0xc8
> > [    6.371710] [<ffffffff801a19fe>] sys_read+0xe/0x16
> > [    6.376503] [<ffffffff8000357a>] ret_from_syscall+0x0/0x2
> > [    6.381905] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000007
> > [    6.390683] Oops [#1]
> > [    6.392956] Modules linked in:
> > [    6.396011] CPU: 0 PID: 136 Comm: udevd Not tainted 6.3.0-rc1-g92569901a7f9-dirty #14
> > [    6.403835] Hardware name: StarFive VisionFive 2 v1.3B (DT)
> > [    6.409401] epc : enqueue_timer+0x1a/0x90
> > [    6.413414]  ra : add_timer_on+0xe2/0x132
> > [    6.417425] epc : ffffffff80080c60 ra : ffffffff80081594 sp : ffffffc8044dbc60
> > [    6.424640]  gp : ffffffff814ffe50 tp : ffffffd8c171ad00 t0 : 6666666666663c5b
> > [    6.431855]  t1 : 000000000000005b t2 : 666666666666663c s0 : ffffffc8044dbcc0
> > [    6.439070]  s1 : ffffffc8044dbd08 a0 : ffffffd84135e6c0 a1 : ffffffc8044dbd08
> > [    6.446284]  a2 : ffffffffffffffff a3 : 000000003e000000 a4 : 000000000000023e
> > [    6.453498]  a5 : 000000000000023e a6 : ffffffd84135f930 a7 : 0000000000000038
> > [    6.460712]  s2 : ffffffd84135e6c0 s3 : 0000000000000040 s4 : ffffffff81501080
> > [    6.467926]  s5 : ffffffd84135e6c0 s6 : ffffffff815011b8 s7 : ffffffffffffffff
> > [    6.475141]  s8 : ffffffff81502820 s9 : 0000000000000040 s10: 0000002ab0a49320
> > [    6.482355]  s11: 0000000000000001 t3 : ffffffff81512e97 t4 : ffffffff81512e97
> > [    6.489569]  t5 : ffffffff81512e98 t6 : ffffffc8044db948
> > [    6.494875] status: 0000000200000100 badaddr: 0000000000000007 cause: 000000000000000f
> > [    6.502783] [<ffffffff80080c60>] enqueue_timer+0x1a/0x90
> > [    6.508095] [<ffffffff8084b9fa>] try_to_generate_entropy+0x216/0x278
> > [    6.514448] [<ffffffff804ebfdc>] urandom_read_iter+0x40/0xb8
> > [    6.520107] [<ffffffff801a1216>] vfs_read+0x17e/0x1f8
> > [    6.525160] [<ffffffff801a1986>] ksys_read+0x5e/0xc8
> > [    6.530126] [<ffffffff801a19fe>] sys_read+0xe/0x16
> > [    6.534918] [<ffffffff8000357a>] ret_from_syscall+0x0/0x2
> > [    6.540322] Code: 87b2 0813 0805 1613 0037 9832 3603 0008 e190 c211 (e60c) 5613
> > [    6.547711] ---[ end trace 0000000000000000 ]---
> > [    6.552325] note: udevd[136] exited with irqs disabled
> > [    6.557531] note: udevd[136] exited with preempt_count 2
> > 
> > 
> > I'm working on top of Linux version 6.3.0-rc1-g92569901a7f.

Hi Conor,

> 
> Unfortunately, this g<sha> bit doesn't mean anything outside of your
> repo so it's hard to infer anything from that.
> This looks exactly like a bug is in v6.3-rc1, but Linus fixed in like
> the second commit *after* -rc1.

Thanks for the tips.
I rebase my working branch on top of:

6a98c9cae232 (origin/master, origin/HEAD) Merge tag 'fs_for_v6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
https://github.com/Scott31393/linux/tree/tm/master_visionv2_v1.3b_vf2-6.2-gmac

I'm able to boot the board using nfs ;)
(without issue)

[    0.000000] Linux version 6.3.0-rc1-gcf4a201af313 (tom@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation) (riscv64-buildroot-linux-gnu-gcc.br_real (Buildroot VF2_v2.10.4) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #16 SM
P Thu Mar  9 19:31:50 CET 2023
[    0.000000] OF: fdt: Ignoring memory range 0x40000000 - 0x40200000
[    0.000000] Machine model: StarFive VisionFive 2 v1.3B
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: bootconsole [sbi0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000040200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node


> 
> What branch/commit/tag did you apply the series on top of?

Thanks again,
Tommaso

> 
> Cheers,
> Conor.


