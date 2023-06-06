Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE1723550
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjFFC3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjFFC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:29:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18821100
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:29:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso56143765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 19:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1686018573; x=1688610573;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g/FdJBLdOP0pOmxgTepe2Yp+gpwhSq7jwb8omte010=;
        b=UBBO/4aM/KMru++iKT55ZQfPoQsC/BlYty7h3a/cohOGxLnFb/iY7ghjuam6UGH5i8
         YZOM5JueTgzYVviRHcu/wdMF//xicsqTau3mWxBHXcXY8fxy32bG8qwjnNx4OQYPgYuI
         EIKY9nhrzh6g8Elb3Ho8hnVUBcTjDvp8jO8CeHa+YF1VJ25GfJ2NYXQ+Gy+rnUb0FeO+
         Hk5Fm+AwY8TOwkaPLTzLskY6Eg9XKVmeaQk8iNWU+yfXIiMNzcvdyszLKdSyhS93S4Kh
         ngbDnDBRyXzaiMWEKhfq9jrS4UAJtXinoDxfo+Z3PrQINut/2bo1zDb5zFMJTUHdmWhN
         9AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686018573; x=1688610573;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9g/FdJBLdOP0pOmxgTepe2Yp+gpwhSq7jwb8omte010=;
        b=FEau8V8arsZxsRX7/Y/sUUlDFRRTcr928V39EV1JkMgiFITkLB7gGWKl0k2UJZp7gJ
         S1BMA7WRWaE77+yI/VGYOlM//TuCIYs8pPx9NucKVI7VxjWAmggvJkWJxGBFp3+KO82k
         tT8zH6FnQ4bGVQDqDRBis/WaZ/1Au0qfpqqzgcco9cgMW4dgtl4G6ol5bblj7N2RUDKe
         Itit+xchZ2dcqIyX8knXekq9wuZj8EnNW95eqR7Ro50amFoY+6wvYkT9N1kOOSYrmEHV
         XuYlSG0tkDzu7OoJ5+EPfUHdb+aHj88ws5IO7GS4uukGFSYCXYrcqCP4ICHrsHrsBP00
         eiEw==
X-Gm-Message-State: AC+VfDzW3aPxon2+0VdvGGrSyM4AawhiUyWvv2qnSS1kFHc5tTIVbnsb
        qw4G65ov35DV86V7yOWiDRCADw==
X-Google-Smtp-Source: ACHHUZ4qMlTfTgFKvzX8FyM5ziJHbf7PlEfnzCjKkdRFFcomXTgM+XMluDMyU0RUZAPrRc3oEGXNmg==
X-Received: by 2002:a05:600c:202:b0:3f6:1474:905 with SMTP id 2-20020a05600c020200b003f614740905mr899252wmi.29.1686018573420;
        Mon, 05 Jun 2023 19:29:33 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f42a75ac2asm12411250wml.23.2023.06.05.19.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2023 19:29:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Bug report: kernel paniced while booting
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <bbc2d1d2e32587c4e212965dab9480b6790f1d37.camel@icenowy.me>
Date:   Tue, 6 Jun 2023 03:29:22 +0100
Cc:     Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D78F9B5-FA9F-41A7-9840-733DE07B5F7E@jrtc27.com>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
 <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop>
 <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
 <bbc2d1d2e32587c4e212965dab9480b6790f1d37.camel@icenowy.me>
To:     Icenowy Zheng <uwu@icenowy.me>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jun 2023, at 01:48, Icenowy Zheng <uwu@icenowy.me> wrote:
>=20
> =E5=9C=A8 2023-06-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 13:55 =
-0700=EF=BC=8CAtish Patra=E5=86=99=E9=81=93=EF=BC=9A
>> On Mon, Jun 5, 2023 at 8:13=E2=80=AFAM Sunil V L =
<sunilvl@ventanamicro.com>
>> wrote:
>>>=20
>>> On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
>>>> Hi Song,
>>>>=20
>>>> On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai
>>>> <songshuaishuai@tinylab.org> wrote:
>>>>>=20
>>>>> Description of problem:
>>>>>=20
>>>>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO
>>>>> page fault was trapped to trigger a kernel panic.
>>>>> The entire log has been posted at this link :
>>>>> https://termbin.com/nga4.
>>>>>=20
>>>>> You can reproduce it with the following step :
>>>>>=20
>>>>> 1. prepare the environment with
>>>>>    - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
>>>>>    - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib:
>>>>> Reduce the number of random tests")
>>>>>    - Linux : v6.4-rc1 and later version
>>>>>=20
>>>>> 2. start the Qemu virt board
>>>>>=20
>>>>> ```sh
>>>>> $ cat ~/8_riscv/start_latest.sh
>>>>> #!/bin/bash
>>>>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-
>>>>> riscv64 \
>>>>>         -s -nographic -drive
>>>>> file=3D/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE
>>>>> _GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=3Draw,unit=3D1 \
>>>>>         -machine virt,acpi=3Doff -smp 2 -m 2G \
>>>>>         -kernel
>>>>> /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
>>>>>         -initrd
>>>>> /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
>>>>>         -append "root=3D/dev/ram ro console=3DttyS0
>>>>> earlycon=3Duart8250,mmio,0x10000000 efi=3Ddebug loglevel=3D8
>>>>> memblock=3Ddebug" ## also panic by memtest
>>>>> ```
>>>>> 3. Then you will encounter the kernel panic logged in the above
>>>>> link
>>>>>=20
>>>>> Other Information:
>>>>>=20
>>>>> 1. -------
>>>>>=20
>>>>> This report is not identical to my prior report -- "kernel
>>>>> paniced when system hibernates" [1], but both of them
>>>>> are closely related with the commit (3335068f8721 "riscv: Use
>>>>> PUD/P4D/PGD pages for the linear mapping").
>>>>>=20
>>>>> With this commit, hibernation is trapped with "access fault"
>>>>> while accessing the PMP-protected regions
>>>>> (mmode_resv0@80000000)
>>>>> from OpenSbi (BTW, hibernation is marked as nonportable by
>>>>> Conor[2]).
>>>>>=20
>>>>> In this report, efi_init handoffs the memory mapping from Boot
>>>>> Services to memblock where reserves mmode_resv0@80000000,
>>>>> so there is no "access fault" but "page fault".
>>>>>=20
>>>>> And reverting commit 3335068f8721 indeed fixed this panic.
>>>>>=20
>>>>> 2. -------
>>>>>=20
>>>>> As the gdb-pt-dump [3] tool shows, the PTE which covered the
>>>>> fault virtual address had the appropriate permission to store.
>>>>> Is there another way to trigger the "Store/AMO page fault"? Or
>>>>> the creation of linear mapping in commit 3335068f8721 did
>>>>> something wrong?
>>>>>=20
>>>>> ```
>>>>> (gdb) p/x $satp
>>>>> $1 =3D 0xa000000000081708
>>>>> (gdb) pt -satp 0xa000000000081708
>>>>>              Address :     Length   Permissions
>>>>>   0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>>   0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>>   0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
>>>>>   0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
>>>>>   0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
>>>>>   0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  //
>>>>> badaddr: ff6000007fdb1000
>>>>>   0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
>>>>>   0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>>   0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
>>>>>   0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
>>>>>=20
>>>>> ```
>>>>>=20
>>>>> 3. ------
>>>>>=20
>>>>> You can also reproduce similar panic by appending "memtest" in
>>>>> kernel cmdline.
>>>>> I have posted the memtest boot log at this link:
>>>>> https://termbin.com/1twl.
>>>>>=20
>>>>> Please correct me if I'm wrong.
>>>>>=20
>>>>> [1]:
>>>>> =
https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+vm_=
1dHJxPNi75YDQ_Q@mail.gmail.com/
>>>>> [2]:
>>>>> =
https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae12005115=
9@wendy/
>>>>> [3]: https://github.com/martinradev/gdb-pt-dump
>>>>=20
>>>> Thanks for the thorough report, really appreciated.
>>>>=20
>>>> So there are multiple issues here:
>>>>=20
>>>> - the first one is that the memory region for opensbi is marked
>>>> as not
>>>> cacheable in the efi memory map, and then this region is not
>>>> mapped in
>>>> the linear mapping:
>>>> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved  =20
>>>> |   |
>>>>  |  |  |  |  |  |  |  |   |  |  |  |UC]
>>>>=20
>>=20
>> @Alex: The OpenSBI region is marked reserved because EDK2 chooses to
>> do that explicitly as explained by Sunil.
>> I don't think UC has to do anything with it. All the EFI memory
>> regions are UC.
>>=20
>>>> - the second one (that I feel a bit ashamed of...) is that I did
>>>> not
>>>> check the alignment of the virtual address when choosing the map
>>>> size
>>>> in best_map_size() and then we end up trying to map a physical
>>>> region
>>>> aligned on 2MB that is actually not aligned on 2MB virtually
>>>> because
>>>> the opensbi region is not mapped at all.
>>>>=20
>>>> - the possible third one is that we should not map the linear
>>>> mapping
>>>> using 4K pages, this would be slow in my opinion, and I think we
>>>> should waste a bit of memory to align va and pa on a 2MB
>>>> boundary.
>>>>=20
>>>> So I'll fix the second issue, and possibly the third one, and if
>>>> no
>>>> one looks into why the opensbi region is mapped in UC, I'll take
>>>> a
>>>> look at edk2.
>>>>=20
>>> Hi Alex,
>>>=20
>>> EDK2 marks opensbi range as reserved memory in EFI map. According
>>> to DT
>>> spec, if the no-map is not set, we need to mark it as
>>> EfiBootServicesData but EfiBootServicesData is actually considered
>>> as
>>> free memory in kernel, as per UEFI spec. To avoid kernel using this
>>> memory, we deviated from the DT spec for opensbi ranges.
>>>=20
>>=20
>> IMO, that should be the correct way unless we can change it to
>> EfiRunServicesData/Code.
>> Looking at U-Boot code, it sets the no-map region to
>> EfiBootServicesData which may cause
>> issues in RISC-V as well if we linear mapping sets up the initial
>> 2MB.
>=20
> Semantically I think no-map means the kernel should not be utilizing
> it, so it should be EfiRunServicesData instead.

no-map *is* EfiRuntimeServicesData in the DT spec; the problem is that
OpenSBI isn=E2=80=99t marking it no-map, but has nothing in its place to =
mark
it as =E2=80=9Cyou can map it but you really cannot touch it=E2=80=9D; =
normally
reserved memory is =E2=80=9Cdon=E2=80=99t treat it as normal memory but =
you can use it
for specific purposes (e.g. DMA memory pool)=E2=80=9D, so it gets =
treated as
the latter (what that state has always meant) despite definitely not
being that. Or, to put it another way, OpenSBI went from something that
was correct-but-slow to something that is incorrect-but-fast and the
consumers of the FDT are now paying the price for its brokenness. So we
need some other approach that isn=E2=80=99t incorrect by definition.

Jess

>>=20
>>=20
>>> Let me know your thoughts how we can handle this better in EDK2
>>> considering it has to support ACPI also.
>>>=20
>>> Thanks,
>>> Sunil
>>>=20
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>=20
>>=20
>>=20
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


