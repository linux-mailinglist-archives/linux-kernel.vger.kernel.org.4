Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00999704C19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjEPLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjEPLPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:15:05 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A316A4D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:14:43 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3063891d61aso13339985f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684235571; x=1686827571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhe8/xrQVpvl5wOQHXySxU5sp+vX+3ZhJIxKiYSK2KQ=;
        b=IDq0FyVbmG4rtF/Espvot2T3WSYf6pKtvJhWtcjdzESN8velyFzXAVVZlrpIupqPY5
         e2nmeeQreDfd8de6uzer/IgBIKTjWAjAcpM2/GMytIQTriki5Rm9L2TgGe/RQo9XFiOp
         oUV9vmwAqNNgIh6aZbs5NAP8fvIb37EIegO9qzr3kaH5QX1RgADa7YiHqgSCTQbHdlsE
         Ipyb9KD1f85p00m1GMENOPr9q28YKIgOMgWjQXQhOeWsf97SYaCVCA3pj4VIUqVFEcMa
         l5yjL3bcffajTD2P1zWBtx0PvXMC2ECUlSKimdoDXHv4iirWkmSSAMagCHBM1R4xm617
         R7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235571; x=1686827571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhe8/xrQVpvl5wOQHXySxU5sp+vX+3ZhJIxKiYSK2KQ=;
        b=WIfSH0wOrZOnspdLsT8etgAVNV3ZLD/sXdDl3IDFSBP0xHEA0adQCHcV/+a0Amf6OF
         RX7zPsjObcVM50Uag/n4EPvGWjVbEpWN+hvvsT0kJOQCFafeXaHodVDdRmr4t4DwxV8y
         gi43enLaPtTBrDbS74oH5+HdrR+hv+L6x2Vmz7iNzAaGcmqLWm7ysYRnVVdt35T+U+wa
         ax2jsyEYgjlITYMhwViJNqiBXShZQ2fTjxe4cukFL4IO0LzNfC7IWITfGMHvyjJrN4iW
         1u8sPuvfKfc1DtzzDVHM4J24Cu1F4bC3zntzWE8xX3mKpQGjzlhxvmQ+0MoOKoVWRmde
         1cbw==
X-Gm-Message-State: AC+VfDydnYlbcLt860SMGFxx7I2rDa4O5XtiihUD+3PeLBSb9HqW7NCl
        AciFRvvwfAi2JQXAx9KYZEVJK6I6JcVy/pMwzxJ5vw==
X-Google-Smtp-Source: ACHHUZ5oBkyExOi35OAar5P7cLuup4TgVrXKpnOTdWpEBypBtucnlN31tQwzzrnCEhdFE1Ejp9ccV5ssBmfqj0MuHyU=
X-Received: by 2002:adf:dec6:0:b0:2cf:f279:378f with SMTP id
 i6-20020adfdec6000000b002cff279378fmr24852351wrn.44.1684235571552; Tue, 16
 May 2023 04:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
In-Reply-To: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 16 May 2023 13:12:40 +0200
Message-ID: <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Song Shuai <suagrfillet@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gmail.com>=
 wrote:
>
> Description of problem:
>
> The latest hibernation support[1] of RISC-V Linux produced a kernel panic=
.
> The entire log has been posted at this link: https://termbin.com/sphl .
>
> How reproducible:
>
> You can reproduce it with the following step :
>
> 1. prepare the environment with
> - Qemu-virt v8.0.0 (with OpenSbi v1.2)
> - Linux v6.4-rc1
>
> 2. start the Qemu virt
> ```sh
> $ cat ~/8_riscv/start_latest.sh
> #!/bin/bash
> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> -smp 2 -m 4G -nographic -machine virt \
> -kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
> -append "root=3D/dev/vda ro eaylycon=3Duart8250,mmio,0x10000000
> early_ioremap_debug console=3DttyS0 loglevel=3D8 memblock=3Ddebug
> no_console_suspend audit=3D0 3" \
> -drive file=3D/home/song/8_riscv/fedora/stage4-disk.img,format=3Draw,id=
=3Dhd0 \
> -device virtio-blk-device,drive=3Dhd0 \
> -drive file=3D/home/song/8_riscv/fedora/adisk.qcow2,format=3Dqcow2,id=3Dh=
d1 \
> -device virtio-blk-device,drive=3Dhd1 \
> -gdb tcp::1236 #-S
> ```
> 3. execute hibernation
>
> ```sh
> swapon /dev/vdb2 # this is my swap disk
>
> echo disk > /sys/power/state
> ```
>
> 4. Then you will encounter the kernel panic logged in the above link
>
>
> Other Information:
>
> After my initial and incomplete dig-up, the commit (3335068f8721
> "riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
> is closely related to this panic. This commit uses re-defined
> `MIN_MEMBLOCK_ADDR` to discover the entire system memory
> and extends the `va_pa_offset` from `kernel_map.phys_addr` to
> `phys_ram_base` for linear memory mapping.
>
> If the firmware delivered the firmware memory region (like: a PMP
> protected region in OpenSbi) without "no-map" propriety,
> this commit will result in firmware memory being directly mapped by
> `create_linear_mapping_page_table()`.
>
> We can see the mapping via ptdump :
> ```c
> ---[ Linear mapping ]---
> 0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A G
> . . W R V ------------- the firmware memory
> 0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D A G . =
. . R V
> 0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A G . .=
 W R V
> 0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A G . .=
 . R V
> 0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD D A
> G . . W R V
> 0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A G . .=
 W R V
> ---[ Modules/BPF mapping ]---
> ---[ Kernel mapping ]---
> 0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D A G . =
X . R V
> 0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A G . .=
 . R V
> 0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A G . .=
 W R V
> 0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A G . .=
 . R V
> 0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
> ```
>
> In the hibernation process, `swsusp_save()` calls
> `copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
> bitmaps,
> the Oops(load access fault) occurred while copying the page of
> PAGE_OFFSET (which maps the firmware memory).

I'm not saying that the hibernation process is in fault here, but
that's weird that it is trying to access pages that are not available
to the kernel: this region is mapped in the page table so that we can
use a 1GB page, but it is reserved so that it is not added to the
kernel memory pool.

>
> I also did two other tests:
> Test1:
>
> The hibernation works well in the kernel with the commit 3335068f8721
> reverted at least in the current environment.
>
> Test2:
>
> I built a simple kernel module to simulate the access of the value of
> `PAGE_OFFSET` address, and the same panic occurred with the load
> access fault.
> So hibernation seems not the only case to trigger this panic.
>
> Finally, should we always leave the firmware memory with
> `MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at least
> in the current environment) or any other suggestions?
>

I actually removed this flag a few years ago, and I have to admit that
I need to check if that's necessary: the goal of commit 3335068f8721
("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
the "right" start of DRAM so that we can align virtual and physical
addresses on a 1GB boundary.

So I have to check if a nomap region is actually added as a
memblock.memory.regions[] or not: if yes, that's perfect, let's add
the nomap attributes to the PMP regions, otherwise, I don't think that
is a good solution.

And a last word: Mike Rapoport recently gave a speech [1] where he
states that mapping the linear mapping with hugepages does not give
rise to better performance so *maybe* reverting this commit may be a
solution too as it may not provide the expected benefits (even though
I'd rather have it and another benefit of mapping the linear mapping
with 1GB hugepages is that it is faster to boot, but that needs to be
measured).

[1] https://lwn.net/Articles/931406/

> Please correct me if I'm wrong.
>
> [1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia@starf=
ivetech.com
> [2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@rivosinc=
.com
>
> --
> Thanks,
> Song

Thanks for the thorough report!

Alex
