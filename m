Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A17062FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEQIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEQIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:33:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B726126A3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so54048425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684312414; x=1686904414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAyV66Y/Vm4PdBxW7vmpRw9zo8Rm8rLzK1v/t96n/70=;
        b=0LyM6eRNeXVHw96sTahfkYDddwZBUiG/2gbmWN4LmZSolnoQL+CXA7+L3KBruUIFkr
         zgMoxwiTNKYh5aMgCojMMxYIyPZh4I7xTfUdEnrMgCAvD5D2Fa+zEp08NuFZyCHl1lb+
         EpSP0fbyC48bbX5vPZpQtcSEg0CKWFthuTu5EKuhsGxxm0KNnOHDqmMpqazVd0TOs5fC
         P1awl2EbggGDUSzNE6S7bSpc5LjVdJ6T6KGyXMgteVa4THC26TFyo156ljcEOcK8y9df
         vMvE8BK1jNfLf+t+HYzMY3TgLlan3gB3/FiIbX0U5NXSggLLJr/BmOmexRyhlLaCOl4h
         qD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312414; x=1686904414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAyV66Y/Vm4PdBxW7vmpRw9zo8Rm8rLzK1v/t96n/70=;
        b=XU9Xk45mSXFAGsGtj7tqtKJc0rcagZ5XSMs8c+eu7XPdThnJRdKt4VKyVC3z/Oi3fO
         zg8jzRY5l1zh6D/R86Ovvjx5h/wGTqHdl0meUm65rIH//zdD9UG4xc30TLTm2YO3DBmA
         6Jw6OWI5/+GIQbbWoIAgl5qwOQCs0BdLz3Hb+4G+zcvSgZHn3AKurvEVFOrx1S7A/dM3
         29B6NoX51o05R1m6/7CEI3yXtZ+7h4HYCWPodj6iHicABF/mJWQi4e7t4QfVEkK5EKRj
         prDm/GO8bp7wRZCLvwxMY4lIAyLjbDNrH9aMMQ425YNoNh1wVR4zsKbfGlP3L8+5NfqT
         +OeQ==
X-Gm-Message-State: AC+VfDzYAZTRwlde6v881mDhvsKzYQljZHWHfStS2EaCLS6Mt2exjA/2
        Bj0MzgzdgMx//aaVEX6x1qqNvpURBqhzWjW//HgseA==
X-Google-Smtp-Source: ACHHUZ5I/uZ1/+ekNO4XJmKarVhu6IImpQGEI0CR+p8LwqebofT1NelNaJWTJoXXU5GxHdgLVmF8+1GCkIpQqLj7ikg=
X-Received: by 2002:a05:6000:1b87:b0:2fe:e455:666c with SMTP id
 r7-20020a0560001b8700b002fee455666cmr955985wru.33.1684312414102; Wed, 17 May
 2023 01:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <5902235c8f5046be9cbd7411955ec43e@EXMBX066.cuchost.com> <CAHVXubg-v=Xe4LQ-bTbf3=FN4cpdBU+xrX7qm8GnUNrmvKDkSQ@mail.gmail.com>
 <7578a14b360542159ee360482e7cc579@EXMBX066.cuchost.com>
In-Reply-To: <7578a14b360542159ee360482e7cc579@EXMBX066.cuchost.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 17 May 2023 10:33:23 +0200
Message-ID: <CAHVXubi8CfCYZOx_mwqpkrLOXs-enQPamxOMrktUDgivxOR3Zw@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     Song Shuai <suagrfillet@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 1:27=E2=80=AFPM JeeHeng Sia
<jeeheng.sia@starfivetech.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Sent: Tuesday, May 16, 2023 7:15 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: Song Shuai <suagrfillet@gmail.com>; robh@kernel.org; Andrew Jones <=
ajones@ventanamicro.com>; anup@brainfault.org;
> > palmer@rivosinc.com; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason =
Huo <mason.huo@starfivetech.com>; Paul Walmsley
> > <paul.walmsley@sifive.com>; Conor Dooley <conor.dooley@microchip.com>; =
Guo Ren <guoren@kernel.org>; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: Bug report: kernel paniced when system hibernates
> >
> > Hi JeeHeng,
> >
> > On Tue, May 16, 2023 at 11:55=E2=80=AFAM JeeHeng Sia
> > <jeeheng.sia@starfivetech.com> wrote:
> > >
> > > Hi Song,
> > >
> > > Thanks for the investigation. Indeed, the exposure of the PMP reserve=
d region to the kernel page table is causing the problem.
> > > Here is the similar report: https://groups.google.com/u/0/a/groups.ri=
scv.org/g/sw-dev/c/ITXwaKfA6z8
> >
> > IMO, we should discuss the kernel related stuff on the linux riscv ML,
> > I'm not subscribed to the group above and you did not answer my last
> > direct emails regarding this problem either.
> Hi Alex, it's strange that I haven't received a reply from you.

I should stop using my personal email as it gets more and more
blocked, I don't know why.

> Seems like I have forgot to update to the mailing list.
> By the way, the reason hibernation failed with the recent page table is b=
ecause during the initiation of the hibernation process, the hibernation co=
re accesses the page table to check if the page can be saved. Since the pag=
e is reserved and is available to the page table, the kernel tries to acces=
s the PMP region, which causes a kernel panic. The code can be found under:
> /kernel/power/snapshot.c/ line #1340
> if (PageReserved(page) && (!kernel_page_present(page) || pfn_is_nosave(pf=
n)))

Thanks for this pointer, it really helps!

> If the virtual memory is mapped to the kernel page table, then hibernatio=
n core will try to access the page.
>
> > Thanks,
> >
> > Alex
> >
> > >
> > > Thanks
> > > Regards
> > > Jee Heng

Is your issue also related to hibernation?

> > >
> > > > -----Original Message-----
> > > > From: Song Shuai <suagrfillet@gmail.com>
> > > > Sent: Tuesday, May 16, 2023 5:24 PM
> > > > To: alexghiti@rivosinc.com; robh@kernel.org; Andrew Jones <ajones@v=
entanamicro.com>; anup@brainfault.org;
> > > > palmer@rivosinc.com; JeeHeng Sia <jeeheng.sia@starfivetech.com>; Le=
yfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo
> > > > <mason.huo@starfivetech.com>; Paul Walmsley <paul.walmsley@sifive.c=
om>; Conor Dooley <conor.dooley@microchip.com>;
> > Guo
> > > > Ren <guoren@kernel.org>
> > > > Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: Bug report: kernel paniced when system hibernates
> > > >
> > > > Description of problem:
> > > >
> > > > The latest hibernation support[1] of RISC-V Linux produced a kernel=
 panic.
> > > > The entire log has been posted at this link: https://termbin.com/sp=
hl .
> > > >
> > > > How reproducible:
> > > >
> > > > You can reproduce it with the following step :
> > > >
> > > > 1. prepare the environment with
> > > > - Qemu-virt v8.0.0 (with OpenSbi v1.2)
> > > > - Linux v6.4-rc1
> > > >
> > > > 2. start the Qemu virt
> > > > ```sh
> > > > $ cat ~/8_riscv/start_latest.sh
> > > > #!/bin/bash
> > > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv6=
4 \
> > > > -smp 2 -m 4G -nographic -machine virt \
> > > > -kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
> > > > -append "root=3D/dev/vda ro eaylycon=3Duart8250,mmio,0x10000000
> > > > early_ioremap_debug console=3DttyS0 loglevel=3D8 memblock=3Ddebug
> > > > no_console_suspend audit=3D0 3" \
> > > > -drive file=3D/home/song/8_riscv/fedora/stage4-disk.img,format=3Dra=
w,id=3Dhd0 \
> > > > -device virtio-blk-device,drive=3Dhd0 \
> > > > -drive file=3D/home/song/8_riscv/fedora/adisk.qcow2,format=3Dqcow2,=
id=3Dhd1 \
> > > > -device virtio-blk-device,drive=3Dhd1 \
> > > > -gdb tcp::1236 #-S
> > > > ```
> > > > 3. execute hibernation
> > > >
> > > > ```sh
> > > > swapon /dev/vdb2 # this is my swap disk
> > > >
> > > > echo disk > /sys/power/state
> > > > ```
> > > >
> > > > 4. Then you will encounter the kernel panic logged in the above lin=
k
> > > >
> > > >
> > > > Other Information:
> > > >
> > > > After my initial and incomplete dig-up, the commit (3335068f8721
> > > > "riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
> > > > is closely related to this panic. This commit uses re-defined
> > > > `MIN_MEMBLOCK_ADDR` to discover the entire system memory
> > > > and extends the `va_pa_offset` from `kernel_map.phys_addr` to
> > > > `phys_ram_base` for linear memory mapping.
> > > >
> > > > If the firmware delivered the firmware memory region (like: a PMP
> > > > protected region in OpenSbi) without "no-map" propriety,
> > > > this commit will result in firmware memory being directly mapped by
> > > > `create_linear_mapping_page_table()`.
> > > >
> > > > We can see the mapping via ptdump :
> > > > ```c
> > > > ---[ Linear mapping ]---
> > > > 0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A=
 G
> > > > . . W R V ------------- the firmware memory
> > > > 0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D =
A G . . . R V
> > > > 0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A=
 G . . W R V
> > > > 0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A=
 G . . . R V
> > > > 0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD =
D A
> > > > G . . W R V
> > > > 0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A=
 G . . W R V
> > > > ---[ Modules/BPF mapping ]---
> > > > ---[ Kernel mapping ]---
> > > > 0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D =
A G . X . R V
> > > > 0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A=
 G . . . R V
> > > > 0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A=
 G . . W R V
> > > > 0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A=
 G . . . R V
> > > > 0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
> > > > ```
> > > >
> > > > In the hibernation process, `swsusp_save()` calls
> > > > `copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
> > > > bitmaps,
> > > > the Oops(load access fault) occurred while copying the page of
> > > > PAGE_OFFSET (which maps the firmware memory).
> > > >
> > > > I also did two other tests:
> > > > Test1:
> > > >
> > > > The hibernation works well in the kernel with the commit 3335068f87=
21
> > > > reverted at least in the current environment.
> > > >
> > > > Test2:
> > > >
> > > > I built a simple kernel module to simulate the access of the value =
of
> > > > `PAGE_OFFSET` address, and the same panic occurred with the load
> > > > access fault.
> > > > So hibernation seems not the only case to trigger this panic.
> > > >
> > > > Finally, should we always leave the firmware memory with
> > > > `MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at lea=
st
> > > > in the current environment) or any other suggestions?
> > > >
> > > > Please correct me if I'm wrong.
> > > >
> > > > [1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia=
@starfivetech.com
> > > > [2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@ri=
vosinc.com
> > > >
> > > > --
> > > > Thanks,
> > > > Song
