Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9462C724B27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbjFFSWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbjFFSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43826172B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:22:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso37567881fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686075731; x=1688667731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScrqRajsXuRz/Jxa/wn1YHpW5SZBMJtc3Pk2wTGEuw4=;
        b=gQ8GWU8+obIaxXLTX6adxdjNfq66ubGuWUWSeS09J+eaQQymWfyzH7gkbwGMVWzSFg
         HxBKr2NtBoW5yWc2+qL96hSP0mtU+oAzD55qr+YNHIlwLd21TsLK4FloNelpd4c0J3Py
         dqr2swmB8TuzMn0FTG2wZyqTH2z/esRt0fqMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075731; x=1688667731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScrqRajsXuRz/Jxa/wn1YHpW5SZBMJtc3Pk2wTGEuw4=;
        b=LMm0LYE6ateZ3IAxmA5ZYrO0Rl/YTck+df8AOtklZ+NZf/t9h8vCPq9vMFb9p3QdcS
         0Kj3fiFuaKP7v3xEsTiG5tWRKuZ5Y9rJ0zD8RNwID0h/Emnzh0YrTldMSeihA3DbqQVm
         V1S8RyZFMpQbQTZgsgPDLitseAAOSRoeuWZWJfQblomJ0t+bAVSa3XvwB0cuVJ0QPhLQ
         emFSC32f/j8deq9PJZWP2WbbfIqTN7BhfYR8tEwlkv9HLQH8/OtiEoB3ZeGbX8zQydWK
         X7mFM7J2o680V181DYLG9J1I4/n3fGBWqt06N7GQjefnrM5kEZNXvuY53K8PBODnj7HH
         XnvQ==
X-Gm-Message-State: AC+VfDyTajn+2vc51kkoeRTtPHimqQ2yD8MCgPB+l1RKh/MqjVSZiyGM
        EBoHMPpI6jZhcDTB8PrESwJIO/nyGW3G/eahGSyV
X-Google-Smtp-Source: ACHHUZ4Hw/6Z0bR0pIVt/cwsfopIqJoiFf+GDDk+q4wC+3mtFimK8hahJac/ZajRXeUo5Gj3zv4HPWYFFJQoggZT5N4=
X-Received: by 2002:a2e:3c04:0:b0:2aa:41a1:cd70 with SMTP id
 j4-20020a2e3c04000000b002aa41a1cd70mr1568245lja.3.1686075731347; Tue, 06 Jun
 2023 11:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com> <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop> <38747287-B219-4B48-B088-A33ADC7954A0@jrtc27.com>
 <ZH7U6QTbKsO0kfYx@sunil-laptop> <6b2ac044-fc66-b4e8-81e7-3375b85674b7@ghiti.fr>
In-Reply-To: <6b2ac044-fc66-b4e8-81e7-3375b85674b7@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 6 Jun 2023 11:21:59 -0700
Message-ID: <CAOnJCUJG7V3jFhaHmDxwET_Q3P2eE5Cq84FQr5qdDCZ2hT_4PQ@mail.gmail.com>
Subject: Re: Bug report: kernel paniced while booting
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 12:26=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
>
> On 06/06/2023 08:40, Sunil V L wrote:
> > On Mon, Jun 05, 2023 at 10:42:33PM +0100, Jessica Clarke wrote:
> >> On 5 Jun 2023, at 16:12, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >>> On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> >>>> Hi Song,
> >>>>
> >>>> On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai <songshuaishuai@t=
inylab.org> wrote:
> >>>>> Description of problem:
> >>>>>
> >>>>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fa=
ult was trapped to trigger a kernel panic.
> >>>>> The entire log has been posted at this link : https://termbin.com/n=
ga4.
> >>>>>
> >>>>> You can reproduce it with the following step :
> >>>>>
> >>>>> 1. prepare the environment with
> >>>>>    - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> >>>>>    - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Redu=
ce the number of random tests")
> >>>>>    - Linux : v6.4-rc1 and later version
> >>>>>
> >>>>> 2. start the Qemu virt board
> >>>>>
> >>>>> ```sh
> >>>>> $ cat ~/8_riscv/start_latest.sh
> >>>>> #!/bin/bash
> >>>>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv6=
4 \
> >>>>>         -s -nographic -drive file=3D/home/song/8_riscv/3_acpi/Build=
_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=3Draw,=
unit=3D1 \
> >>>>>         -machine virt,acpi=3Doff -smp 2 -m 2G \
> >>>>>         -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/=
Image \
> >>>>>         -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/r=
ootfs.ext2 \
> >>>>>         -append "root=3D/dev/ram ro console=3DttyS0 earlycon=3Duart=
8250,mmio,0x10000000 efi=3Ddebug loglevel=3D8 memblock=3Ddebug" ## also pan=
ic by memtest
> >>>>> ```
> >>>>> 3. Then you will encounter the kernel panic logged in the above lin=
k
> >>>>>
> >>>>> Other Information:
> >>>>>
> >>>>> 1. -------
> >>>>>
> >>>>> This report is not identical to my prior report -- "kernel paniced =
when system hibernates" [1], but both of them
> >>>>> are closely related with the commit (3335068f8721 "riscv: Use PUD/P=
4D/PGD pages for the linear mapping").
> >>>>>
> >>>>> With this commit, hibernation is trapped with "access fault" while =
accessing the PMP-protected regions (mmode_resv0@80000000)
> >>>>> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]=
).
> >>>>>
> >>>>> In this report, efi_init handoffs the memory mapping from Boot Serv=
ices to memblock where reserves mmode_resv0@80000000,
> >>>>> so there is no "access fault" but "page fault".
> >>>>>
> >>>>> And reverting commit 3335068f8721 indeed fixed this panic.
> >>>>>
> >>>>> 2. -------
> >>>>>
> >>>>> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault =
virtual address had the appropriate permission to store.
> >>>>> Is there another way to trigger the "Store/AMO page fault"? Or the =
creation of linear mapping in commit 3335068f8721 did something wrong?
> >>>>>
> >>>>> ```
> >>>>> (gdb) p/x $satp
> >>>>> $1 =3D 0xa000000000081708
> >>>>> (gdb) pt -satp 0xa000000000081708
> >>>>>              Address :     Length   Permissions
> >>>>>   0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> >>>>>   0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> >>>>>   0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> >>>>>   0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> >>>>>   0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> >>>>>   0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff=
6000007fdb1000
> >>>>>   0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> >>>>>   0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> >>>>>   0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> >>>>>   0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> >>>>>
> >>>>> ```
> >>>>>
> >>>>> 3. ------
> >>>>>
> >>>>> You can also reproduce similar panic by appending "memtest" in kern=
el cmdline.
> >>>>> I have posted the memtest boot log at this link: https://termbin.co=
m/1twl.
> >>>>>
> >>>>> Please correct me if I'm wrong.
> >>>>>
> >>>>> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGj=
dtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> >>>>> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator=
-9ae120051159@wendy/
> >>>>> [3]: https://github.com/martinradev/gdb-pt-dump
> >>>> Thanks for the thorough report, really appreciated.
> >>>>
> >>>> So there are multiple issues here:
> >>>>
> >>>> - the first one is that the memory region for opensbi is marked as n=
ot
> >>>> cacheable in the efi memory map, and then this region is not mapped =
in
> >>>> the linear mapping:
> >>>> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |  =
 |
> >>>> |  |  |  |  |  |  |  |   |  |  |  |UC]
> >>>>
> >>>> - the second one (that I feel a bit ashamed of...) is that I did not
> >>>> check the alignment of the virtual address when choosing the map siz=
e
> >>>> in best_map_size() and then we end up trying to map a physical regio=
n
> >>>> aligned on 2MB that is actually not aligned on 2MB virtually because
> >>>> the opensbi region is not mapped at all.
> >>>>
> >>>> - the possible third one is that we should not map the linear mappin=
g
> >>>> using 4K pages, this would be slow in my opinion, and I think we
> >>>> should waste a bit of memory to align va and pa on a 2MB boundary.
> >>>>
> >>>> So I'll fix the second issue, and possibly the third one, and if no
> >>>> one looks into why the opensbi region is mapped in UC, I'll take a
> >>>> look at edk2.
> >>>>
> >>> Hi Alex,
> >>>
> >>> EDK2 marks opensbi range as reserved memory in EFI map. According to =
DT
> >>> spec, if the no-map is not set, we need to mark it as
> >>> EfiBootServicesData but EfiBootServicesData is actually considered as
> >>> free memory in kernel, as per UEFI spec. To avoid kernel using this
> >>> memory, we deviated from the DT spec for opensbi ranges.
> >> Violating specs is never the answer. Do one of:
> >>
> >> 1. Use no-map and take the performance hit
> >> 2. Exclude the memory range from /memory itself
> >> 3. Come up with a new no-access property that=E2=80=99s a weaker no-ma=
p
> >>     (i.e. that allows mapping and speculative access) and uses
> >>     EfiRuntimeServicesData in EFI land
> >>
> >> 2 feels most normal to me, personally, but all are fine.
> >>
> > Hi Jess,
> >
> > IMO, all the physical memory installed by the user should be visible.
> > Some part of the memory may be reserved and not available for the user
> > but excluding from /memory can cause issues.
> >
> > Whether we mark as EfiReservedMemory or EfiRuntimeServiceData, I think
> > it will be marked as no-map in memblock and can not be used by the OS
> > linear mapping. Alex can confirm this.
>
>
> Yes, I think you're right, EfiRuntimeServiceData will be marked as
> no-map anyway (see is_usable_memory()).
>
>
> >
> > So, my preference is option 1.
>
>
> Yes, again, I think you're right, this is feeling more and more like the
> most "natural" solution to me too, we are struggling for a performance
> benefit that was never proven...
>

I am inclined towards this option as well. After going through the
rationale for marking
any /reserved-memory node without "no-map" as EfiBootServicesData,
this will trip
kernel in future if not happening already. Any region marked as
EfiBootServicesData will
be available to the kernel for use after ExitBootServices.

Let's have a no-map set for the reserved memory set for the firmware.
The fallout would be
anybody with kernel > 6.4 has to upgrade the firmware version that
sets the no-map correctly if they care
about hibernation or EFI booting. OpenSBI v1.3 is planned this month anyway=
.
We can communicate the same to the rust-sbi project as well.

Any thoughts ?

>
> >
> > Thanks,
> > Sunil
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
