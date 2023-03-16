Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8F6BCFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCPMnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCPMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:43:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B3BCBAB;
        Thu, 16 Mar 2023 05:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DA8EB82161;
        Thu, 16 Mar 2023 12:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B090C433EF;
        Thu, 16 Mar 2023 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678970626;
        bh=Bn22MEAaLbE8PfB0Mig0iBGYLYZGpXb6TOMcZGydyCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TvN3CTBI4PVJzr40YBh7tMwpRxbvEmMqcwJO/r5la9UTSJpvsjrfiEYxDopXlbXF6
         x9l+L3FP8LQkFjnwXH+It4upLoZKMcPhq3H5xbgdNZpjd4YZHRTPyNXPB/tLbew98k
         Dli30Z/Bvzd3riOx7T3KbnZg2sAZqhL23EQx6sun0/Fq+bY24dhBH22ub5GAzDjMvL
         wqtpxPrOD/A+2YKNNeGfMxOnnSYQU4SE4W0WtmxHnUSuPirYa8hZkKQ9JsewRAxUQY
         Eg8G1zhzcVKsfWRKbm4fTeM5xyiBqRy6fDIDi2cSlduSrmiezB/77oUTg7NQm4bks0
         es+l4bYAW4fSw==
Received: by mail-lj1-f175.google.com with SMTP id z5so1523609ljc.8;
        Thu, 16 Mar 2023 05:43:46 -0700 (PDT)
X-Gm-Message-State: AO0yUKVc4nmO7NvDTvT9Zqdo5A4FLdahen7LbPLhOoghuPU4wc3EEHJy
        fJVSdknUpbwbqM4dHrD2MPR3HJPYD/4vZgmSn/k=
X-Google-Smtp-Source: AK7set+FZP5NUjM2xniaNqhtVmxnX6R/a73VMeQPbWUQJvUdTG4p4FGcohA6d5XHjCUIMZKudMArGY6bE+2Q7s1JwDU=
X-Received: by 2002:a2e:8e2a:0:b0:298:a8d6:9fad with SMTP id
 r10-20020a2e8e2a000000b00298a8d69fadmr2031766ljk.4.1678970624180; Thu, 16 Mar
 2023 05:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390> <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390> <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390> <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
 <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390> <CAMj1kXEtj_jEZeT6YNh9xB=8o=0LVKiPYucHU08s34xBgy1yDA@mail.gmail.com>
 <CAMj1kXF3pkxvDX6ZMpnRd3wQX2_T6CYmz7ML-h+PXeo+hM_ZdA@mail.gmail.com> <ZBMOitWwCDj3XiRw@righiandr-XPS-13-7390>
In-Reply-To: <ZBMOitWwCDj3XiRw@righiandr-XPS-13-7390>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Mar 2023 13:43:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
Message-ID: <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 13:41, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Thu, Mar 16, 2023 at 01:38:30PM +0100, Ard Biesheuvel wrote:
> > On Thu, 16 Mar 2023 at 13:21, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > >
> > > > On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > > > > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > > > > (cc Darren)
> > > > > > >
> > > > > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > Hello Andrea,
> > > > > > > > >
> > > > > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello,
> > > > > > > > > >
> > > > > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > > > > >
> > > > > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > > > > [   72.082595] Call trace:
> > > > > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > > > > >
> > > > > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > > > > >
> > > > > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > > > > this one:
> > > > > > > > > >
> > > > > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > > > > >
> > > > > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > > > > these arm64 boxes or something else.
> > > > > > > > > >
> > > > > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks for the report.
> > > > > > > > >
> > > > > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > > > > weeds and never returning.
> > > > > > > > >
> > > > > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > > > > different types of hardware?
> > > > > > > >
> > > > > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > > > > >
> > > > > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > > > > ^C^C^C^C
> > > > > > > >
> > > > > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > > > > >
> > > > > > >
> > > > > > > Could you please share the output of
> > > > > > >
> > > > > > > dmidecode -s bios
> > > > > > > dmidecode -s system-family
> > > > > >
> > > > > > $ sudo dmidecode -s bios-vendor
> > > > > > LENOVO
> > > > > > $ sudo dmidecode -s bios-version
> > > > > > hve104r-1.15
> > > > > > $ sudo dmidecode -s bios-release-date
> > > > > > 02/26/2021
> > > > > > $ sudo dmidecode -s bios-revision
> > > > > > 1.15
> > > > > > $ sudo dmidecode -s system-family
> > > > > > Lenovo ThinkSystem HR330A/HR350A
> > > > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > Mind checking if this patch fixes your issue as well?
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
> > > >
> > > > Unfortunately this doesn't seem to be enough, I'm still getting the same
> > > > problem also with this patch applied.
> > > >
> > >
> > > Thanks for trying.
> > >
> > > How about the last 3 patches on this branch?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
> >
> > Actually, that may not match your hardware.
> >
> > Does your kernel log have a line like
> >
> > SMCCC: SOC_ID: ID = jep106:036b:0019 Revision = 0x00000102
> >
> > ?
>
> $ sudo dmesg | grep "SMCCC: SOC_ID"
> [    5.320782] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
>

Thanks. Could you share the entire dmidecode output somewhere? Or at
least the type 4 record(s)?
