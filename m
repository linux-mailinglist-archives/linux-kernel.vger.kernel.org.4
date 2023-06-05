Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46F7228C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjFEOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFEOZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:25:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6099
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:25:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f73617a292so18636425e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685975117; x=1688567117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxY/DFb0Xc65/sIk33eQ5kU5e3RFqDt3i4PU+gIaqZo=;
        b=RWxQCw+404bQg7ZrNY8wzn/xkbMoQbmONRI/WtuGQ9FU7P5BqYhK2dtbgOaqKZePn2
         UHo+FNU1SFKy5CCg9HpHoVKm7V1Yal/OVU46R2nAoM6QDllKrzeSAcUBQnhiZlqT2JXi
         BfPHa2U9aJ6z7bJEPZM9MEocy2ixUrbr206NvykYVPt8dCflixenhUbtk/MAbzNgOmwU
         nYrFUtD59USCl3H1/d5Ly+nreoJ2gKnarOuXMOQrao7FndovWlnfR/JZjXqwe6GBQMfy
         LCailM5r+s9EsUqGUFi3a9o+WpWZZTILTT02wUUvSljYAXN+heMi1JQdZFhk1M5xU7x+
         mQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975117; x=1688567117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxY/DFb0Xc65/sIk33eQ5kU5e3RFqDt3i4PU+gIaqZo=;
        b=O/usKfW86WdSJsj8JDVhqQZpJT1LNx1AB4WdIPgPcJRpzIjlHCtltDDCce0kMLtuBI
         eTwFEa1UThBzEJ7tZCrC9lAmq80l5+yIa2LFBE/Hmid6dPxhEBvrb/bqt6MeXSenkzsk
         HDZkcPftq9H8TogqPwLsM+KgXd/dEYel5yx8sa6ErChimH36JSYmfutG1JhXLxseZugR
         P7bb7j7Z0nfedrOogsEWrQXiwbGZEC34fj9Md4Lm82YI6izVAIUQRC8s4FGQBjREwJ7x
         gQsK/7IyQ7FsWp6KIwnVh9AQA/O4bNx72MEo0WUzV+gDgAMV5mzwha22O1Fj+BsIm5zE
         VFcw==
X-Gm-Message-State: AC+VfDxXvzWbmVzK16jsKKnGEQoEfd7p2MhtCcncbsHaR+Qgml7WTVaI
        5DK1+K2CoaEoch96rpE/gHYet4C4rEQxtl9hOy6Otw==
X-Google-Smtp-Source: ACHHUZ4/jLLozMZcxY703u73KSSPom54Lxv5yGos/FWpptJObFYaZBtT26FgQxTHny6dITyO2JpBUqYyf/wNplMzIM4=
X-Received: by 2002:a7b:cbc9:0:b0:3f6:76e:604b with SMTP id
 n9-20020a7bcbc9000000b003f6076e604bmr8031855wmi.0.1685975116855; Mon, 05 Jun
 2023 07:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
In-Reply-To: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 5 Jun 2023 16:25:06 +0200
Message-ID: <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
Subject: Re: Bug report: kernel paniced while booting
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     robh <robh@kernel.org>, ajones <ajones@ventanamicro.com>,
        anup <anup@brainfault.org>, palmer <palmer@rivosinc.com>,
        "jeeheng.sia" <jeeheng.sia@starfivetech.com>,
        "leyfoon.tan" <leyfoon.tan@starfivetech.com>,
        "mason.huo" <mason.huo@starfivetech.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        "conor.dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
> Description of problem:
>
> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault wa=
s trapped to trigger a kernel panic.
> The entire log has been posted at this link : https://termbin.com/nga4.
>
> You can reproduce it with the following step :
>
> 1. prepare the environment with
>    - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
>    - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the=
 number of random tests")
>    - Linux : v6.4-rc1 and later version
>
> 2. start the Qemu virt board
>
> ```sh
> $ cat ~/8_riscv/start_latest.sh
> #!/bin/bash
> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
>         -s -nographic -drive file=3D/home/song/8_riscv/3_acpi/Build_virt/=
RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=3Draw,unit=
=3D1 \
>         -machine virt,acpi=3Doff -smp 2 -m 2G \
>         -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image =
\
>         -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.=
ext2 \
>         -append "root=3D/dev/ram ro console=3DttyS0 earlycon=3Duart8250,m=
mio,0x10000000 efi=3Ddebug loglevel=3D8 memblock=3Ddebug" ## also panic by =
memtest
> ```
> 3. Then you will encounter the kernel panic logged in the above link
>
> Other Information:
>
> 1. -------
>
> This report is not identical to my prior report -- "kernel paniced when s=
ystem hibernates" [1], but both of them
> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD=
 pages for the linear mapping").
>
> With this commit, hibernation is trapped with "access fault" while access=
ing the PMP-protected regions (mmode_resv0@80000000)
> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
>
> In this report, efi_init handoffs the memory mapping from Boot Services t=
o memblock where reserves mmode_resv0@80000000,
> so there is no "access fault" but "page fault".
>
> And reverting commit 3335068f8721 indeed fixed this panic.
>
> 2. -------
>
> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtua=
l address had the appropriate permission to store.
> Is there another way to trigger the "Store/AMO page fault"? Or the creati=
on of linear mapping in commit 3335068f8721 did something wrong?
>
> ```
> (gdb) p/x $satp
> $1 =3D 0xa000000000081708
> (gdb) pt -satp 0xa000000000081708
>              Address :     Length   Permissions
>   0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
>   0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
>   0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
>   0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
>   0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
>   0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff600000=
7fdb1000
>   0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
>   0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
>   0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
>   0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
>
> ```
>
> 3. ------
>
> You can also reproduce similar panic by appending "memtest" in kernel cmd=
line.
> I have posted the memtest boot log at this link: https://termbin.com/1twl=
.
>
> Please correct me if I'm wrong.
>
> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_v=
hB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae12=
0051159@wendy/
> [3]: https://github.com/martinradev/gdb-pt-dump

Thanks for the thorough report, really appreciated.

So there are multiple issues here:

- the first one is that the memory region for opensbi is marked as not
cacheable in the efi memory map, and then this region is not mapped in
the linear mapping:
[    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
 |  |  |  |  |  |  |  |   |  |  |  |UC]

- the second one (that I feel a bit ashamed of...) is that I did not
check the alignment of the virtual address when choosing the map size
in best_map_size() and then we end up trying to map a physical region
aligned on 2MB that is actually not aligned on 2MB virtually because
the opensbi region is not mapped at all.

- the possible third one is that we should not map the linear mapping
using 4K pages, this would be slow in my opinion, and I think we
should waste a bit of memory to align va and pa on a 2MB boundary.

So I'll fix the second issue, and possibly the third one, and if no
one looks into why the opensbi region is mapped in UC, I'll take a
look at edk2.

Sorry for that,

Alex
