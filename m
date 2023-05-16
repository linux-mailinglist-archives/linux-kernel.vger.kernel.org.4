Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD6704C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjEPLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjEPLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:16:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C8826B1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:15:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso74583145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684235706; x=1686827706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoCpJAH0z2qhvEAjZCzfNnUqzIB2wxfKon1CpWBbdJ8=;
        b=ZhiTrSKYN63kswWHE9vTaCw+2FGddfcIitp5mG09y6YcnOURGd46p46finPdFAbxaD
         CPRgkWT36+fctUgusDd6ehOwURMS/MWY5mjAnb5qlVR8DXfeGTvy2Gi7cgwXZfFh41Fq
         XlifmMkZFeEQ9Z3deQibKYuJz77TmZsRI26EHLlQ+qffr/eL2y8hZu7pTbg4+O4SifrB
         HBIgBEIm0uXVA5zK2IV648UW9V/Gz1M3z1xm3fCDHqiU3wGA6nysyCkpD21fIMoUIFwy
         Kl4x8xyTJW/8hgKwJwdQcO9b3qkZK8gmu6uuUta/+LukjpoqiqiYNw62gPB3cHYLvV49
         4ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235706; x=1686827706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoCpJAH0z2qhvEAjZCzfNnUqzIB2wxfKon1CpWBbdJ8=;
        b=KZA+sgBtM0SXmEDt88bbLABBd4Ktdtqr1lTMDt/Qbs8+H0dl/xGWS45xGVFJve7Xb4
         uPJInCB6x2RrV/OaeA/Mm31Kyy+iMhPt7/ATFPR/MxOGWNVRrkJYke3ZYkvTIMkrcbZm
         M09FqhcjcLXo8oacrHL6mYylElNDUOHfnRZrYRUZqcRmZgWe5JoVwUzeTHcjX58AOEM/
         9JJsxXSmNeJzTAapDXkTqG8Hl7STYJ5PQ7sTXrIrfca2Z7Ld0BDG2q5BBZHgJ3xKJyKW
         5UWVBmxM75DFHab8ndUT0+zSjrWCJO+V+qm3aYc1n0c381czN0XOUTk9DNmo0yuh4nII
         W4YA==
X-Gm-Message-State: AC+VfDwG1P8GvW5+aEq1jtZBE/7oCdCWqZmo0d0GhqDqFbNWOMFlXnRf
        scTnPP0XM6v8D9QBYV2BK6KhYb/zU/XcYmBiJQJELQ==
X-Google-Smtp-Source: ACHHUZ6ne7jHNpkNUh0GL9MfcoLs24RtQ6qb4SlVgWklr3B6Ku66xAju7AcVG8p69sMkLlvTIV+cM8UdV5SiDktvV8c=
X-Received: by 2002:a5d:4d92:0:b0:306:26d6:dd7a with SMTP id
 b18-20020a5d4d92000000b0030626d6dd7amr25995644wru.32.1684235705796; Tue, 16
 May 2023 04:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <5902235c8f5046be9cbd7411955ec43e@EXMBX066.cuchost.com>
In-Reply-To: <5902235c8f5046be9cbd7411955ec43e@EXMBX066.cuchost.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 16 May 2023 13:14:55 +0200
Message-ID: <CAHVXubg-v=Xe4LQ-bTbf3=FN4cpdBU+xrX7qm8GnUNrmvKDkSQ@mail.gmail.com>
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

Hi JeeHeng,

On Tue, May 16, 2023 at 11:55=E2=80=AFAM JeeHeng Sia
<jeeheng.sia@starfivetech.com> wrote:
>
> Hi Song,
>
> Thanks for the investigation. Indeed, the exposure of the PMP reserved re=
gion to the kernel page table is causing the problem.
> Here is the similar report: https://groups.google.com/u/0/a/groups.riscv.=
org/g/sw-dev/c/ITXwaKfA6z8

IMO, we should discuss the kernel related stuff on the linux riscv ML,
I'm not subscribed to the group above and you did not answer my last
direct emails regarding this problem either.

Thanks,

Alex

>
> Thanks
> Regards
> Jee Heng
>
> > -----Original Message-----
> > From: Song Shuai <suagrfillet@gmail.com>
> > Sent: Tuesday, May 16, 2023 5:24 PM
> > To: alexghiti@rivosinc.com; robh@kernel.org; Andrew Jones <ajones@venta=
namicro.com>; anup@brainfault.org;
> > palmer@rivosinc.com; JeeHeng Sia <jeeheng.sia@starfivetech.com>; Leyfoo=
n Tan <leyfoon.tan@starfivetech.com>; Mason Huo
> > <mason.huo@starfivetech.com>; Paul Walmsley <paul.walmsley@sifive.com>;=
 Conor Dooley <conor.dooley@microchip.com>; Guo
> > Ren <guoren@kernel.org>
> > Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Bug report: kernel paniced when system hibernates
> >
> > Description of problem:
> >
> > The latest hibernation support[1] of RISC-V Linux produced a kernel pan=
ic.
> > The entire log has been posted at this link: https://termbin.com/sphl .
> >
> > How reproducible:
> >
> > You can reproduce it with the following step :
> >
> > 1. prepare the environment with
> > - Qemu-virt v8.0.0 (with OpenSbi v1.2)
> > - Linux v6.4-rc1
> >
> > 2. start the Qemu virt
> > ```sh
> > $ cat ~/8_riscv/start_latest.sh
> > #!/bin/bash
> > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> > -smp 2 -m 4G -nographic -machine virt \
> > -kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
> > -append "root=3D/dev/vda ro eaylycon=3Duart8250,mmio,0x10000000
> > early_ioremap_debug console=3DttyS0 loglevel=3D8 memblock=3Ddebug
> > no_console_suspend audit=3D0 3" \
> > -drive file=3D/home/song/8_riscv/fedora/stage4-disk.img,format=3Draw,id=
=3Dhd0 \
> > -device virtio-blk-device,drive=3Dhd0 \
> > -drive file=3D/home/song/8_riscv/fedora/adisk.qcow2,format=3Dqcow2,id=
=3Dhd1 \
> > -device virtio-blk-device,drive=3Dhd1 \
> > -gdb tcp::1236 #-S
> > ```
> > 3. execute hibernation
> >
> > ```sh
> > swapon /dev/vdb2 # this is my swap disk
> >
> > echo disk > /sys/power/state
> > ```
> >
> > 4. Then you will encounter the kernel panic logged in the above link
> >
> >
> > Other Information:
> >
> > After my initial and incomplete dig-up, the commit (3335068f8721
> > "riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
> > is closely related to this panic. This commit uses re-defined
> > `MIN_MEMBLOCK_ADDR` to discover the entire system memory
> > and extends the `va_pa_offset` from `kernel_map.phys_addr` to
> > `phys_ram_base` for linear memory mapping.
> >
> > If the firmware delivered the firmware memory region (like: a PMP
> > protected region in OpenSbi) without "no-map" propriety,
> > this commit will result in firmware memory being directly mapped by
> > `create_linear_mapping_page_table()`.
> >
> > We can see the mapping via ptdump :
> > ```c
> > ---[ Linear mapping ]---
> > 0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A G
> > . . W R V ------------- the firmware memory
> > 0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D A G =
. . . R V
> > 0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A G .=
 . W R V
> > 0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A G .=
 . . R V
> > 0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD D A
> > G . . W R V
> > 0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A G .=
 . W R V
> > ---[ Modules/BPF mapping ]---
> > ---[ Kernel mapping ]---
> > 0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D A G =
. X . R V
> > 0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A G .=
 . . R V
> > 0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A G .=
 . W R V
> > 0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A G .=
 . . R V
> > 0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
> > ```
> >
> > In the hibernation process, `swsusp_save()` calls
> > `copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
> > bitmaps,
> > the Oops(load access fault) occurred while copying the page of
> > PAGE_OFFSET (which maps the firmware memory).
> >
> > I also did two other tests:
> > Test1:
> >
> > The hibernation works well in the kernel with the commit 3335068f8721
> > reverted at least in the current environment.
> >
> > Test2:
> >
> > I built a simple kernel module to simulate the access of the value of
> > `PAGE_OFFSET` address, and the same panic occurred with the load
> > access fault.
> > So hibernation seems not the only case to trigger this panic.
> >
> > Finally, should we always leave the firmware memory with
> > `MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at least
> > in the current environment) or any other suggestions?
> >
> > Please correct me if I'm wrong.
> >
> > [1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia@sta=
rfivetech.com
> > [2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@rivosi=
nc.com
> >
> > --
> > Thanks,
> > Song
