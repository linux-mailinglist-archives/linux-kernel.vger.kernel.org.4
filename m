Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EBD7231C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjFEU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFEU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:56:10 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A116EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:56:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so59863321fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1685998567; x=1688590567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+VjQC/3FZMRhBnW1leNU2wGf62bCTHxEuF7S30g0gU=;
        b=GtsZdAXqhZnN3PMUfxUoUynt9W/ZP+S4464DonG/M1Qz2lefLODWHU6AGUF4AIBh0i
         +Z73NbyVFfhzg85YHiOWCZoigAnZw52oQ+dNiubzTo6LZWYzLMRqF9tvslT13CBP4hiJ
         q76lvKbF6C2vO2bXXHWqGeeJzKVd20VrcKuYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998567; x=1688590567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+VjQC/3FZMRhBnW1leNU2wGf62bCTHxEuF7S30g0gU=;
        b=iez7S6Ov6mJkdYak3kbFHqu1tbTENZzvIHhCtbhiM6yF5gNM3KBNHX4lUlAPeeJSKh
         zpfoSJM1LrddvHBUZ/zP2JgIDFoOE0imPBT8mf1zyr3ksNqC5K7qnOEbda8SpMMkqww5
         TpcZGcz7UzEwXEPtMK8FBE80okD7v4H/DohB/odIbdyUSmk2LYdn9TUddRm28iiF3iMk
         hZriY6rhTPs+TDTXptjEgbxIVYqMhCLskzCbPwawvwLHNCrEprepluLcmssFk83cOoA2
         r/M+OnluwerQ4hvMCHczJKXVaK/H0sncqgUM3dOyutBTx+Gr484ZgB5JFmXhmWbFCWoB
         ndLg==
X-Gm-Message-State: AC+VfDzXR/n9vWHodK3ww2NgTXytZwUGmXVZRctZgjUyirJ/OwekDuVa
        gPAWymT2DohY7f1MZZLU3q8dTs7kGrz7Vkex8jUkmQkt+UeorDatWNbC
X-Google-Smtp-Source: ACHHUZ7yCVOd2ncyULAi2yoAY7KnOUPO153oV23HaYJ9F6JAJVfUVpnFJxwT6aqwgxRZQDDtL1tSKxHbR1XGQLFm0e0=
X-Received: by 2002:a2e:88c9:0:b0:2af:228a:8670 with SMTP id
 a9-20020a2e88c9000000b002af228a8670mr226471ljk.2.1685998567237; Mon, 05 Jun
 2023 13:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com> <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop>
In-Reply-To: <ZH37WMnx/rYSRF/o@sunil-laptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 5 Jun 2023 13:55:55 -0700
Message-ID: <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
Subject: Re: Bug report: kernel paniced while booting
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        robh <robh@kernel.org>, ajones <ajones@ventanamicro.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 8:13=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> > Hi Song,
> >
> > On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai <songshuaishuai@tiny=
lab.org> wrote:
> > >
> > > Description of problem:
> > >
> > > Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page faul=
t was trapped to trigger a kernel panic.
> > > The entire log has been posted at this link : https://termbin.com/nga=
4.
> > >
> > > You can reproduce it with the following step :
> > >
> > > 1. prepare the environment with
> > >    - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> > >    - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce=
 the number of random tests")
> > >    - Linux : v6.4-rc1 and later version
> > >
> > > 2. start the Qemu virt board
> > >
> > > ```sh
> > > $ cat ~/8_riscv/start_latest.sh
> > > #!/bin/bash
> > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 =
\
> > >         -s -nographic -drive file=3D/home/song/8_riscv/3_acpi/Build_v=
irt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=3Draw,un=
it=3D1 \
> > >         -machine virt,acpi=3Doff -smp 2 -m 2G \
> > >         -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Im=
age \
> > >         -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/roo=
tfs.ext2 \
> > >         -append "root=3D/dev/ram ro console=3DttyS0 earlycon=3Duart82=
50,mmio,0x10000000 efi=3Ddebug loglevel=3D8 memblock=3Ddebug" ## also panic=
 by memtest
> > > ```
> > > 3. Then you will encounter the kernel panic logged in the above link
> > >
> > > Other Information:
> > >
> > > 1. -------
> > >
> > > This report is not identical to my prior report -- "kernel paniced wh=
en system hibernates" [1], but both of them
> > > are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D=
/PGD pages for the linear mapping").
> > >
> > > With this commit, hibernation is trapped with "access fault" while ac=
cessing the PMP-protected regions (mmode_resv0@80000000)
> > > from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
> > >
> > > In this report, efi_init handoffs the memory mapping from Boot Servic=
es to memblock where reserves mmode_resv0@80000000,
> > > so there is no "access fault" but "page fault".
> > >
> > > And reverting commit 3335068f8721 indeed fixed this panic.
> > >
> > > 2. -------
> > >
> > > As the gdb-pt-dump [3] tool shows, the PTE which covered the fault vi=
rtual address had the appropriate permission to store.
> > > Is there another way to trigger the "Store/AMO page fault"? Or the cr=
eation of linear mapping in commit 3335068f8721 did something wrong?
> > >
> > > ```
> > > (gdb) p/x $satp
> > > $1 =3D 0xa000000000081708
> > > (gdb) pt -satp 0xa000000000081708
> > >              Address :     Length   Permissions
> > >   0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> > >   0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> > >   0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> > >   0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> > >   0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> > >   0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff60=
00007fdb1000
> > >   0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> > >   0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> > >   0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> > >   0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> > >
> > > ```
> > >
> > > 3. ------
> > >
> > > You can also reproduce similar panic by appending "memtest" in kernel=
 cmdline.
> > > I have posted the memtest boot log at this link: https://termbin.com/=
1twl.
> > >
> > > Please correct me if I'm wrong.
> > >
> > > [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdt=
NF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > > [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9=
ae120051159@wendy/
> > > [3]: https://github.com/martinradev/gdb-pt-dump
> >
> > Thanks for the thorough report, really appreciated.
> >
> > So there are multiple issues here:
> >
> > - the first one is that the memory region for opensbi is marked as not
> > cacheable in the efi memory map, and then this region is not mapped in
> > the linear mapping:
> > [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
> >  |  |  |  |  |  |  |  |   |  |  |  |UC]
> >

@Alex: The OpenSBI region is marked reserved because EDK2 chooses to
do that explicitly as explained by Sunil.
I don't think UC has to do anything with it. All the EFI memory regions are=
 UC.

> > - the second one (that I feel a bit ashamed of...) is that I did not
> > check the alignment of the virtual address when choosing the map size
> > in best_map_size() and then we end up trying to map a physical region
> > aligned on 2MB that is actually not aligned on 2MB virtually because
> > the opensbi region is not mapped at all.
> >
> > - the possible third one is that we should not map the linear mapping
> > using 4K pages, this would be slow in my opinion, and I think we
> > should waste a bit of memory to align va and pa on a 2MB boundary.
> >
> > So I'll fix the second issue, and possibly the third one, and if no
> > one looks into why the opensbi region is mapped in UC, I'll take a
> > look at edk2.
> >
> Hi Alex,
>
> EDK2 marks opensbi range as reserved memory in EFI map. According to DT
> spec, if the no-map is not set, we need to mark it as
> EfiBootServicesData but EfiBootServicesData is actually considered as
> free memory in kernel, as per UEFI spec. To avoid kernel using this
> memory, we deviated from the DT spec for opensbi ranges.
>

IMO, that should be the correct way unless we can change it to
EfiRunServicesData/Code.
Looking at U-Boot code, it sets the no-map region to
EfiBootServicesData which may cause
issues in RISC-V as well if we linear mapping sets up the initial 2MB.


> Let me know your thoughts how we can handle this better in EDK2
> considering it has to support ACPI also.
>
> Thanks,
> Sunil
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
