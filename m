Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C166A2B81
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBYT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYT3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:29:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76452CC30
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:29:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq23so10374252edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edVifE6bSwZq5HJRu0gexANKAFLl3RFtj1sINE9szoM=;
        b=XsQy/gRPHKewpwRluZoF+tgjeCmf4qznip97bWDbVY33C/f9fOQ42OOdkF+yNFIX4O
         lqBFMuI6cfHvcISzYJiBmQROAX7GLvGv/oJvXNXwJEAMCzQh/yP1UF+mFoitMlraD6yj
         sVnWPabWA8oAbRApUmbfjK1LbEQJbXSP/7ysMZMiLPlSSsD4ctxbE1lnYIqVm7ESgsM3
         FNrAvR7grRgkjUKZMwKHThWBix2nt0a7LfuiwSBE1WZc4iYcp2bzKfxA+2PSXH90B/Il
         mq/OqEnKigcYiVpEozetkZ5KgZI3RZnYpmLPp61XceLnlyNXnPFXjfliv43+9Pz3Cz7U
         eDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edVifE6bSwZq5HJRu0gexANKAFLl3RFtj1sINE9szoM=;
        b=NraGuMBfUOxgoBSjQlZ4c7olH1d1ZNPOMhJo2gxxypGoNpVmp3tPt1RS5AYi7t85/c
         AnHH0sG5MFJ50b74OMJchxoYkbPckpki5gMkT19rBGSalYUbJTIgGNKf2fcNX6Er0oed
         8RxkgRjHEaCzAFuSj9A+cQBPM7PcW/G3V9zvSDecbrrPnCruzADbKwcHlOr+vaKzNEsh
         wBRXxfUlzr0w8VWjDQ/yrNRjHH2+qfr/5929pXfVKx8vsfJ7cye7OXXtPYIPJbtiV1Xx
         Kb82aYf1cDSYtL70ekSDIRCaZ6xcX8UEw8hP8ypspKCiy0odiNA0EaND7j4fUnknWgzo
         eCTA==
X-Gm-Message-State: AO0yUKWXBmECESMQd4UC9OafPDiIcsl86ffu7gEfw/6T308Jm3bSd1WC
        bfL7L/GVio4thl2yvAnNMKw=
X-Google-Smtp-Source: AK7set/C+pOecxKEb98MuHPxnPZvOk6mZjNvB/uZI4I3oztA2jR9QQ1406E81QyYMk7lhd+MUVtK7w==
X-Received: by 2002:a17:906:4550:b0:8b1:7ae8:ba79 with SMTP id s16-20020a170906455000b008b17ae8ba79mr30322125ejq.30.1677353349851;
        Sat, 25 Feb 2023 11:29:09 -0800 (PST)
Received: from curiosity ([80.211.22.60])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709064f8f00b008b17662e1f7sm1134303eju.53.2023.02.25.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:29:08 -0800 (PST)
Date:   Sat, 25 Feb 2023 22:29:04 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Zong Li <zongbox@gmail.com>, Guo Ren <guoren@linux.alibaba.com>,
        guoren@kernel.org
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, guoren@kernel.org,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <Y/phgGFWMf/4WRSS@curiosity>
References: <20221111075902.798571-1-guoren@kernel.org>
 <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
 <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 01:57:55AM +0800, Zong Li wrote:
> Lad, Prabhakar <prabhakar.csengg@gmail.com> 於 2022年12月23日 週五 下午8:54寫道：
> >
> > Hi Guo,
> >
> > Thank you for the patch.
> >
> > On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > After use_asid_allocator is enabled, the userspace application will
> > > crash by stale TLB entries. Because only using cpumask_clear_cpu without
> > > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > > Then set_mm_asid would cause the user space application to get a stale
> > > value by stale TLB entry, but set_mm_noasid is okay.
> > >
> > > Here is the symptom of the bug:
> > > unhandled signal 11 code 0x1 (coredump)
> > >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> > >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> > > => 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > > (gdb) i r s0
> > > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > > (gdb) x /2x 0x3fd6d92490
> > > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > > The core dump file shows that register s0 is wrong, but the value in
> > > memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
> > > in TLB and got a wrong result from an incorrect physical address.
> > >
> > > When the task ran on CPU0, which loaded/speculative-loaded the value of
> > > address(0x3fd6d92490), then the first version of the mapping entry was
> > > PTWed into CPU0's TLB.
> > > When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here by
> > > asid), it happened to write a value on the address (0x3fd6d92490). It
> > > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > > ptep_get_and_clear & flush_tlb_page.
> > > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
> > > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> > > switch_mm. So we only flushed the CPU1 TLB and set the second version
> > > mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU0
> > > still used a stale TLB mapping entry which contained a wrong target
> > > physical address. It raised a bug when the task happened to read that
> > > value.
> > >
> > >    CPU0                               CPU1
> > >    - switch 'task' in
> > >    - read addr (Fill stale mapping
> > >      entry into TLB)
> > >    - switch 'task' out (no tlb_flush)
> > >                                       - switch 'task' in (no tlb_flush)
> > >                                       - write addr cause pagefault
> > >                                         do_page_fault() (change to
> > >                                         new addr mapping)
> > >                                           wp_page_copy()
> > >                                             ptep_clear_flush()
> > >                                               ptep_get_and_clear()
> > >                                               & flush_tlb_page()
> > >                                         write new value into addr
> > >                                       - switch 'task' out (no tlb_flush)
> > >    - switch 'task' in (no tlb_flush)
> > >    - read addr again (Use stale
> > >      mapping entry in TLB)
> > >      get wrong value from old phyical
> > >      addr, BUG!
> > >
> > > The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm,
> > > which could guarantee to invalidate all stale TLB entries during TLB
> > > flush.
> > >
> > > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > > ---
> > > Changes in v3:
> > >  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
> > >    with Andrew's advice)
> > >  - Optimize comment description
> > >
> > > Changes in v2:
> > >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
> > >    test robot <lkp@intel.com>)
> > >  - Keep cpumask_clear_cpu for noasid
> > > ---
> > >  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
> > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > >
> > As reported on the patch [0] I was seeing consistent failures on the
> > RZ/Five SoC while running bonnie++ utility. After applying this patch
> > on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
> > seeing this issue.
> >
> > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > [0] https://patchwork.kernel.org/project/linux-riscv/patch/20220829205219.283543-1-geomatsi@gmail.com/
> >
> 
> Hi all,
> I got the same situation (i.e. unhandle signal 11) on our internal
> multi-core system, I tried the patch[0] & [1], but it still doesn't
> work, I guess there are still some potential problems. After applying
> this patch, the situation disappeared, I took some time to look at
> other arches' implementations, such as arc, they don't clear the
> mm_cpumask due to the similar issue. I can't say which approach might
> be better, but I'd like to point out that this patch works to me.
> Thanks.
> 
> Tested-by: Zong Li <zong.li@sifive.com>
> 
> [0] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
> [1] https://lore.kernel.org/linux-riscv/20230129211818.686557-1-geomatsi@gmail.com/

Thanks for the report! By the way, could you please share some
information about the reproducing workload ?

Initial idea was to reduce the number of TLB flushes by deferring (and
possibly avoiding) some of them. But we have already bug reports from
two different vendors, so apparently something is overlooked here.
Lets switch to 'aggrregating' mm_cpumask approach suggested by Guo Ren.

@Guo Ren, do you mind if I re-send your v3 patch together with the
remaining reverts of my changes ?

Regards,
Sergey
