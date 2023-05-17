Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D70706618
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjEQLFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEQLF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:05:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5BF3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:05:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53063897412so558596a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684321515; x=1686913515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRYfbndqw0GAOZpH/vsYXNBBpwjp+WGrkXYUGyBITM4=;
        b=gg581gxLstRezO6s8W1LWvncJc6g5GcMB/tBpL0mBKNDETuF4MHBpH5wfii2Mwh7Eu
         l6mRmhjgTbM/oQCxjsJpMhvFDRZsqSxSwe3Dw9L3RxT6KtWO18CFNCX8nSm33UFgats/
         nTycrFqs4B7zluRcKarPGZAz3+62rsdo0PvxinyhT7Fn7rZM6IdGWogDXQhI4hSrPyw4
         MBnswndbMFjHfzoOJp9XL8PMnb6R9G/FF8xN8vTHZW6OByF4TPLbF8By7glUJnvKWXow
         /J1jgEqBLXazcya7e3APjhNv1qMTnw1jaCmR9LXu6OO3iPxtqA0ocZnHotu0rpX4QMIq
         yz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321515; x=1686913515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRYfbndqw0GAOZpH/vsYXNBBpwjp+WGrkXYUGyBITM4=;
        b=YnM4bet/IyFJJ6LJEgncsfpjg4n+jcPqmZ4M2zZV1fhmz1h87Sa/PpS3U9upq0BQhL
         A+bqSzTpRvfuOSGQ+rD7R1oyZsQyDMPjBTY7UdEVj1qDBIvJ+75i5tRy2LELCEfd0fWb
         LVMpFgwqtnoMq27dy13u32xiWQ6s3s67aCb94GSmp8gbZOiJ1cgx1r5COlDQZZMMooVr
         gwOU2rNPCcYPMmP7AcW6oS6khAhvhtSSrKiwKJlz0nT5Apv7m1juPTSpBI5okehpNNnI
         ++K+ijtfdvWz4BeegBtsl6vwc5bn4Si5Fkum8M4tATk6yU5nhOW6PKqAd46tp3Svy8/p
         M5pw==
X-Gm-Message-State: AC+VfDwhv5CKbeQWrw0u62enmAiUhrPf76nxwNWmwvkudcXxBHo6uELi
        goxCQE2DwIoKIFd20BH4bqru1M7auz4B/CLPDSI=
X-Google-Smtp-Source: ACHHUZ5Nl0fyhRquqzdQhV2mBueKXkBYxXf6E205akl28piwIP4k3IVZugynV92RbFZEt4qFIoU9kdb++z9O484dN5g=
X-Received: by 2002:a17:90a:4ec5:b0:253:3481:84cf with SMTP id
 v5-20020a17090a4ec500b00253348184cfmr3893116pjl.10.1684321514571; Wed, 17 May
 2023 04:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com> <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
In-Reply-To: <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 17 May 2023 11:05:02 +0000
Message-ID: <CAAYs2=gtfhVYUsXkSiCZdzF+Cr573AecWyBn6u_D1C4N4THNVw@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     robh@kernel.org, Andrew Jones <ajones@ventanamicro.com>,
        anup@brainfault.org, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 08:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Song,
> >
> > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gmail.=
com> wrote:
> > >
> > > Description of problem:
> > >
> > > The latest hibernation support[1] of RISC-V Linux produced a kernel p=
anic.
> > > The entire log has been posted at this link: https://termbin.com/sphl=
 .
> > >
> > > How reproducible:
> > >
> > > You can reproduce it with the following step :
> > >
> > > 1. prepare the environment with
> > > - Qemu-virt v8.0.0 (with OpenSbi v1.2)
> > > - Linux v6.4-rc1
> > >
> > > 2. start the Qemu virt
> > > ```sh
> > > $ cat ~/8_riscv/start_latest.sh
> > > #!/bin/bash
> > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 =
\
> > > -smp 2 -m 4G -nographic -machine virt \
> > > -kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
> > > -append "root=3D/dev/vda ro eaylycon=3Duart8250,mmio,0x10000000
> > > early_ioremap_debug console=3DttyS0 loglevel=3D8 memblock=3Ddebug
> > > no_console_suspend audit=3D0 3" \
> > > -drive file=3D/home/song/8_riscv/fedora/stage4-disk.img,format=3Draw,=
id=3Dhd0 \
> > > -device virtio-blk-device,drive=3Dhd0 \
> > > -drive file=3D/home/song/8_riscv/fedora/adisk.qcow2,format=3Dqcow2,id=
=3Dhd1 \
> > > -device virtio-blk-device,drive=3Dhd1 \
> > > -gdb tcp::1236 #-S
> > > ```
> > > 3. execute hibernation
> > >
> > > ```sh
> > > swapon /dev/vdb2 # this is my swap disk
> > >
> > > echo disk > /sys/power/state
> > > ```
> > >
> > > 4. Then you will encounter the kernel panic logged in the above link
> > >
> > >
> > > Other Information:
> > >
> > > After my initial and incomplete dig-up, the commit (3335068f8721
> > > "riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
> > > is closely related to this panic. This commit uses re-defined
> > > `MIN_MEMBLOCK_ADDR` to discover the entire system memory
> > > and extends the `va_pa_offset` from `kernel_map.phys_addr` to
> > > `phys_ram_base` for linear memory mapping.
> > >
> > > If the firmware delivered the firmware memory region (like: a PMP
> > > protected region in OpenSbi) without "no-map" propriety,
> > > this commit will result in firmware memory being directly mapped by
> > > `create_linear_mapping_page_table()`.
> > >
> > > We can see the mapping via ptdump :
> > > ```c
> > > ---[ Linear mapping ]---
> > > 0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A G
> > > . . W R V ------------- the firmware memory
> > > 0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D A =
G . . . R V
> > > 0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A G=
 . . W R V
> > > 0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A G=
 . . . R V
> > > 0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD D =
A
> > > G . . W R V
> > > 0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A G=
 . . W R V
> > > ---[ Modules/BPF mapping ]---
> > > ---[ Kernel mapping ]---
> > > 0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D A =
G . X . R V
> > > 0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A G=
 . . . R V
> > > 0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A G=
 . . W R V
> > > 0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A G=
 . . . R V
> > > 0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
> > > ```
> > >
> > > In the hibernation process, `swsusp_save()` calls
> > > `copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
> > > bitmaps,
> > > the Oops(load access fault) occurred while copying the page of
> > > PAGE_OFFSET (which maps the firmware memory).
> >
> > I'm not saying that the hibernation process is in fault here, but
> > that's weird that it is trying to access pages that are not available
> > to the kernel: this region is mapped in the page table so that we can
> > use a 1GB page, but it is reserved so that it is not added to the
> > kernel memory pool.
Yes, my fault, the Test2 is not a correct testcase.
> >
> > >
> > > I also did two other tests:
> > > Test1:
> > >
> > > The hibernation works well in the kernel with the commit 3335068f8721
> > > reverted at least in the current environment.
> > >
> > > Test2:
> > >
> > > I built a simple kernel module to simulate the access of the value of
> > > `PAGE_OFFSET` address, and the same panic occurred with the load
> > > access fault.
> > > So hibernation seems not the only case to trigger this panic.
> > >
> > > Finally, should we always leave the firmware memory with
> > > `MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at least
> > > in the current environment) or any other suggestions?
> > >
> >
> > I actually removed this flag a few years ago, and I have to admit that
> > I need to check if that's necessary: the goal of commit 3335068f8721
> > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
> > the "right" start of DRAM so that we can align virtual and physical
> > addresses on a 1GB boundary.
> >
> > So I have to check if a nomap region is actually added as a
> > memblock.memory.regions[] or not: if yes, that's perfect, let's add
> > the nomap attributes to the PMP regions, otherwise, I don't think that
> > is a good solution.
>
> So here is the current linear mapping without nomap in openSBI:
>
> ---[ Linear mapping ]---
> 0xff60000000000000-0xff60000000200000    0x0000000080000000         2M
> PMD     D A G . . W R V
> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> PMD     D A G . . . R V
>
> And below the linear mapping with nomap in openSBI:
>
> ---[ Linear mapping ]---
> 0xff60000000080000-0xff60000000200000    0x0000000080080000      1536K
> PTE     D A G . . W R V
> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> PMD     D A G . . . R V
>
> So adding nomap does not misalign virtual and physical addresses, it
> prevents the usage of 1GB page for this area though, so that's a
> solution, we just lose this 1GB page here.
>
> But even though that may be the fix, I think we also need to fix that
> in the kernel as it would break compatibility with certain versions of
> openSBI *if* we fix openSBI...So here are a few solutions:
>
> 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> before the linear mapping is established (IIUC, those nodes are added
> by openSBI to advertise PMP regions)
>     -> This amounts to the same fix as opensbi and we lose the 1GB hugepa=
ge.
> 2. we can tweak pfn_is_nosave function to *not* save pfn corresponding
> to PMP regions
>     -> We don't lose the 1GB hugepage \o/
> 3. we can use register_nosave_region() to not save the "mmode_resv"
> regions (x86 does that
> https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820.c#L=
753)
>     -> We don't lose the 1GB hugepage \o/
> 4. Given JeeHeng pointer to
> https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapshot.c#=
L1340,
> we can mark those pages as non-readable and make the hibernation
> process not save those pages
>     -> Very late-in-the-day idea, not sure what it's worth, we also
> lose the 1GB hugepage...
>
> To me, the best solution is 3 as it would prepare for other similar
> issues later, it is similar to x86 and it allows us to keep 1GB
> hugepages.

I agree,
register_nosave_region() is a good way in the early initialization to
set page frames (like the PMP regions) in forbidden_pages_map and mark
them as no-savable for hibernation.

Look forward to your fixing.
>
> I have been thinking, and to me nomap does not provide anything since
> the kernel should not address this memory range, so if it does, we
> must fix the kernel.
>
> Let me know what you all think, I'll be preparing a PoC of 3 in the meant=
ime!
>
> Alex
>
>
>
> >
> > And a last word: Mike Rapoport recently gave a speech [1] where he
> > states that mapping the linear mapping with hugepages does not give
> > rise to better performance so *maybe* reverting this commit may be a
> > solution too as it may not provide the expected benefits (even though
> > I'd rather have it and another benefit of mapping the linear mapping
> > with 1GB hugepages is that it is faster to boot, but that needs to be
> > measured).
> >
> > [1] https://lwn.net/Articles/931406/
> >
> > > Please correct me if I'm wrong.
> > >
> > > [1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia@s=
tarfivetech.com
> > > [2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@rivo=
sinc.com
> > >
> > > --
> > > Thanks,
> > > Song
> >
> > Thanks for the thorough report!
> >
> > Alex



--=20
Thanks,
Song
