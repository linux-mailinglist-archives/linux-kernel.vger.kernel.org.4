Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8735873FB57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjF0LsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjF0LsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:48:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC2E4C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:48:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-312826ffedbso4931658f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687866488; x=1690458488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhf96h+BLy7Mn8WF98nFDpnBxh2T+MIkCjbsKeZTtrM=;
        b=S8lKLAzEq20ijjS/vcbmd+8wkpX/zgUsiolr8eFXbqnF7U48qsA8LlIIh6KSHlS8eT
         PTCvIqSXrlA5DUiMjlVXbYe1BgSFdazD3XWozafOyajAFxkBHFHzhuAsH/z40+vog/XU
         Gxoa99Sc9y2PgiW7VRZh+lBfNU1AxoXuzMCKFvwTgNHJrppDLcgYpndIg19y5DdDGZ88
         n2JI7+V/i6ZAfTu4F4PKbqtwM6oRzaH3Mu5CO+POXAEjK5N6zkmTK6jb80/4DR1PoCLJ
         c68M6rUZg4qQX6279MwmgkvozcweuY+ONctxbRnP1QIqsfWMqNpGpwIpFYJdH5zQR9ob
         KCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866488; x=1690458488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rhf96h+BLy7Mn8WF98nFDpnBxh2T+MIkCjbsKeZTtrM=;
        b=aT0xyArz4ox38bBBS2AWQRA0RZiReMlUtBhhpbDEfYumpf04Dgtb2fPutJkJjrptwI
         YOduHq0xjQp9OrVdnlDAEBTSRBpRoCysGjPVbmhV4oXH8pYvcwyUzdF3J0hqwZi/2Vxp
         W/6QQ/Wlq/L7svnZgEjwvp9yAIp29i+vbkcPYl0wfv9oOr0PIcILD8sPoFeTt7vSLfBM
         WgMfDVj8FJAJ38LSoZHevtR4hR1BGrt9zqLim6rfpL7kQyLTsjh8BC7CZ32X1d38zjD+
         J1XiU49hT0cEaxxuTnaFV+GTVkCGLaNdQObRl8mEWcMzHZK1cDHAGG0Hc2uc/JWn2cHM
         vSJw==
X-Gm-Message-State: AC+VfDyOQJsqQbudBb5AW+2bL74PNeotqPdphtMJrSNDoIMOALIv/UL7
        szDKi+XV5KHQH4mcSs+GzOIfIyqA260RfcYc+B2YlA==
X-Google-Smtp-Source: ACHHUZ5vrLIQ67kjQ4XG6OlMA5EomoKXk6bTnttA1HboRHkY//pIphAuNx5JqZeVfJJQqWsnXAsEvrA9ZXcQWQxMxOk=
X-Received: by 2002:a5d:4fd2:0:b0:313:f0e3:2fdc with SMTP id
 h18-20020a5d4fd2000000b00313f0e32fdcmr4557100wrw.2.1687866487638; Tue, 27 Jun
 2023 04:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org> <CAHVXubgJcGPq_uC6iJCLTys5J6Ooa1EYcfOhBjEQwYfd+baWxw@mail.gmail.com>
In-Reply-To: <CAHVXubgJcGPq_uC6iJCLTys5J6Ooa1EYcfOhBjEQwYfd+baWxw@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 27 Jun 2023 13:47:56 +0200
Message-ID: <CAHVXubi-FmwJxeb5ymw_bU5NM7HyteNyyJxG7D+hDzOJWnix5Q@mail.gmail.com>
Subject: Re: [PATCH V1 0/3] Revert huge-paged linear mapping and its related fixups
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, mpe@ellerman.id.au, arnd@arndb.de,
        rppt@kernel.org, samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Sun, Jun 25, 2023 at 10:36=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> Hi Song,
>
> On Sun, Jun 25, 2023 at 4:10=E2=80=AFPM Song Shuai <songshuaishuai@tinyla=
b.org> wrote:
> >
> > We have encountered these two issues about huge-paged linear mapping si=
nce v6.4-rc1:
> >
> > 1. Bug report: kernel paniced when system hibernates[1]
> >
> > OpenSbi [v0.8,v1.3) set the PMP regions as !no-map, and the commit 3335=
068f8721
> > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") mapped them in =
linear mapping.
> > The hibernation process attempted to save/restore these mapped regions =
resulting in access fault.
> >
> > This issue was temporarily fixed by commit ed309ce52218 ("RISC-V: mark =
hibernation as nonportable").
> > But as Alex's RFC and Rob's response stats in another thread [2] ,
> > "Hibernation is only one case. Speculative accesses could also occur."
> > So this fixing commit seems not the perfect answer to this issue.
> >
> >
> > 2. Bug report: kernel paniced while booting (with UEFI )[3]
> >
> > During the booting with UEFI, UEFI Memory Mapping overwrote the membloc=
k.
> > The phys_ram_base was set as the end address of mmoderes0 (like 0x80040=
000 for 256 KiB mmoderes0@80000000),
> > which resulted the VA based on 2M-aligned PA was not 2M-aligned using v=
a_pa_offset
> > (PAGE_OFFSET - phys_ram_base) to translate.
> >
> > The best_map_size() from commit 3335068f8721 didn't check the virtual a=
lignment
> > before choosing a map size. and then a "VA hole" was created where page=
 faults always occurred.
> >
> > This issue was fixed by commit 49a0a3731596 ("riscv: Check the virtual =
alignment before choosing a map size"),
> > But this fixing commit has a side-effect ("the possible third one" as A=
lex said in this thread).
> > There are numerous PTE allocations slowing down the boot time and consu=
ming some system memory when UEFI booting
> > (Note that it's not involved when booting directly with OpenSbi, where =
phys_ram_base is the 2M-aligned base of DRAM).
> >
> > In my test, compared with/out reverting both commit 49a0a3731596 and co=
mmit 3335068f8721,
> > I must wait ~20s for the linear mapping creation and mem_init_print_inf=
o() reported ~8M extra reserved memory.
>
> Indeed, phys_ram_base is not aligned on a 2MB boundary when booting
> with EDK2, IIRC that's because the first chunk of memory at
> 0x8000_0000 is marked as UC and is then completely evicted.
>
> >
> > To eliminate this side-effect, We should find a way to align VA and PA =
on a 2MB boundary.
> > The simplest way is reverting the commit 3335068f8721 ("riscv: Use PUD/=
P4D/PGD pages for the linear mapping").
> >
>
> I disagree, the simplest way is to align phys_ram_base on a 2MB
> boundary, either by aligning to the upper boundary (and then wastes
> memory, like we used to) or by aligning to the lower boundary (but I
> want to make sure it works).
>
> I'll come up with something tomorrow.

@Song Shuai : can you test the following please?

commit a35b5e5e3f29e415f54fea064176315e79e21fb7 (HEAD ->
dev/alex/align_va_pa_v1)
Author: Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon Jun 5 14:26:55 2023 +0000

    riscv: Start of DRAM should at least be aligned on PMD size for
the direct mapping

    So that we do not end up mapping the whole linear mapping using 4K
    pages, which is slow at boot time, and also very likely at runtime.

    So make sure we align the start of DRAM on a PMD boundary.

    Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4fa420faa780..4a43ec275c6d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
        memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);

        phys_ram_end =3D memblock_end_of_DRAM();
+
+       /*
+        * Make sure we align the start of the memory on a PMD boundary so =
that
+        * at worst, we map the linear mapping with PMD mappings.
+        */
        if (!IS_ENABLED(CONFIG_XIP_KERNEL))
-               phys_ram_base =3D memblock_start_of_DRAM();
+               phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;

        /*
         * In 64-bit, any use of __va/__pa before this point is wrong as we

An example of output when phys_ram_base is not aligned on a 2MB boundary:

---[ Linear mapping ]---
0xffffaf8000008000-0xffffaf8000200000    0x0000000080008000      2016K
PTE     D A G . . W R V
0xffffaf8000200000-0xffffaf8000e00000    0x0000000080200000        12M
PMD     D A G . . . R V
0xffffaf8000e00000-0xffffaf8001200000    0x0000000080e00000         4M
PMD     D A G . . W R V
0xffffaf8001200000-0xffffaf8001a00000    0x0000000081200000         8M
PMD     D A G . . . R V
0xffffaf8001a00000-0xffffaf807e600000    0x0000000081a00000      1996M
PMD     D A G . . W R V
0xffffaf807e600000-0xffffaf807e714000    0x00000000fe600000      1104K
PTE     D A G . . W R V
0xffffaf807e715000-0xffffaf807e718000    0x00000000fe715000        12K
PTE     D A G . . W R V
0xffffaf807e71b000-0xffffaf807e71c000    0x00000000fe71b000         4K
PTE     D A G . . W R V
0xffffaf807e720000-0xffffaf807e800000    0x00000000fe720000       896K
PTE     D A G . . W R V
0xffffaf807e800000-0xffffaf807fe00000    0x00000000fe800000        22M
PMD     D A G . . W R V
0xffffaf807fe00000-0xffffaf807ff54000    0x00000000ffe00000      1360K
PTE     D A G . . W R V
0xffffaf807ff55000-0xffffaf8080000000    0x00000000fff55000       684K
PTE     D A G . . W R V
0xffffaf8080000000-0xffffaf83c0000000    0x0000000100000000        13G
PUD     D A G . . W R V
0xffffaf83c0000000-0xffffaf83ffe00000    0x0000000440000000      1022M
PMD     D A G . . W R V
0xffffaf83ffe00000-0xffffaf8400000000    0x000000047fe00000         2M
PTE     D A G . . W R V

I found that it was easier to align phys_ram_base on the lower 2MB
boundary. Aligning on the upper boundary is more complicated to me
since there may be "something" between phys_ram_base and the upper 2MB
boundary that needs to be accessed using the linear mapping (DT is
accessed using fixmap so not a problem, initrd? ACPI tables? I don't
know actually).

Weirdly simple though, I may be missing something, so any comment/test
is welcome, it is currently running our internal CI.

Thanks,

Alex

>
> Thanks,
>
> Alex
>
> >
> >
> > Using PUD/P4D/PGD pages for the linear mapping to improve the performan=
ce is marginal from a recent talk [4]
> > from Mike Rapoport. OpenSbi had marked all the PMP-protected regions as=
 "no-map" [5] to practice this talk.
> >
> > For all those reasons, let's revert these related commits:
> >
> > - commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear map=
ping")
> > - commit 49a0a3731596 ("riscv: Check the virtual alignment before choos=
ing a map size")
> > - commit ed309ce52218 ("RISC-V: mark hibernation as nonportable")
> >
> > [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF=
_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > [2]: https://lore.kernel.org/linux-kernel/20230530080425.18612-1-alexgh=
iti@rivosinc.com/
> > [3]: https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488E=
C1@qq.com/
> > [4]: https://lwn.net/Articles/931406/
> > [5]: https://github.com/riscv-software-src/opensbi/commit/8153b2622b088=
02cc542f30a1fcba407a5667ab9
> >
> > Song Shuai (3):
> >   Revert "RISC-V: mark hibernation as nonportable"
> >   Revert "riscv: Check the virtual alignment before choosing a map size=
"
> >   Revert "riscv: Use PUD/P4D/PGD pages for the linear mapping"
> >
> >  arch/riscv/Kconfig            |  5 +---
> >  arch/riscv/include/asm/page.h | 16 -------------
> >  arch/riscv/mm/init.c          | 43 +++++++----------------------------
> >  arch/riscv/mm/physaddr.c      | 16 -------------
> >  drivers/of/fdt.c              | 11 ++++-----
> >  5 files changed, 14 insertions(+), 77 deletions(-)
> >
> > --
> > 2.20.1
> >
