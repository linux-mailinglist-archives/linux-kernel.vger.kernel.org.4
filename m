Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4B72326D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjFEVmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFEVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:42:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F14E9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:42:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so3877556f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1686001365; x=1688593365;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LgjrKN+wjMH42ISANHiTqCT6nDW3U22wKpUgG9wT3A=;
        b=bVq2//S2ZasBkEqaT3bXZ7Wf+rkt5IAaZKgnwUcrgqwFPd7PBvtrnubW0nAhl1arDp
         FniLhqmYj8QnPT9lOLv0ApzafiE1L/Dx/OQsC6AJQNMfXVl9wzJpVoYZHYX3IvYtI/ck
         HssXy14JLo1z+A5nWFyiOcG76nJvGspgMXcSk6X+7DWgYBxb0flfRnBQyP+qhh53g4Dv
         SIAihpLDkdoisA82+K5hBMKha/zNdPCh8hWe0Krm6zi/PLj/ONUM59PYihvlhJMS9nRU
         ZU0QXYDaW3OflY/nkPp81k4H98soo7Strnojih4obtZUbiedWzwwo58iVv31e0BypN8t
         NZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001365; x=1688593365;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LgjrKN+wjMH42ISANHiTqCT6nDW3U22wKpUgG9wT3A=;
        b=Cq19Tj2BtceANscloseCXyJ64c1gg5DiBcoytikdm5w+qJHuRwItCdIczXCgrjZOsj
         vRRfAysdyXUyO9/Gqoh0vq2BUMB6wddOXYlG4FWgYIM3j+2t+iWWTrj03HzT3PXR+oRf
         auyzFI0+Vh0gcSuvsaSx01hWXlE3rNMBdVP1z0nH6o8sR+q+RQ92q5n9FYO2nWV2EFCP
         Ni5Fc8Tk1B2UUmSRjihE3GL9mN1FH4RdnhB7b4bWi1H+eYjRlzjTFUChVai7OwY+ypyY
         OWHsBOZ9pMw9LgJlXB3bd4EFnECprAbu53kacVPC9Yagg7FkviKe/EDGvMkskwzpPRKJ
         fVJg==
X-Gm-Message-State: AC+VfDwip3JzCXXboNXXolnSaTAd0v0lhqafM7JkEJUoKMCQMfnPRzae
        Slx+wCfAexXq6PPIqPlk1kLPvsb1Pr3KZXsvUi06kDqR
X-Google-Smtp-Source: ACHHUZ6fajNvK1GtLEp6bPHOwBmzormt+gl48Yi1iW0Ml5iubD6K7iEUExkpKZ+upqokZnDY9V4xpA==
X-Received: by 2002:adf:f64c:0:b0:307:c0c4:109a with SMTP id x12-20020adff64c000000b00307c0c4109amr142920wrp.6.1686001364752;
        Mon, 05 Jun 2023 14:42:44 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4c52000000b0030ae901bc54sm10635125wrt.62.2023.06.05.14.42.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:42:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Bug report: kernel paniced while booting
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <ZH37WMnx/rYSRF/o@sunil-laptop>
Date:   Mon, 5 Jun 2023 22:42:33 +0100
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <38747287-B219-4B48-B088-A33ADC7954A0@jrtc27.com>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
 <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop>
To:     Sunil V L <sunilvl@ventanamicro.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Jun 2023, at 16:12, Sunil V L <sunilvl@ventanamicro.com> wrote:
>=20
> On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
>> Hi Song,
>>=20
>> On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai =
<songshuaishuai@tinylab.org> wrote:
>>>=20
>>> Description of problem:
>>>=20
>>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page =
fault was trapped to trigger a kernel panic.
>>> The entire log has been posted at this link : =
https://termbin.com/nga4.
>>>=20
>>> You can reproduce it with the following step :
>>>=20
>>> 1. prepare the environment with
>>>   - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
>>>   - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce =
the number of random tests")
>>>   - Linux : v6.4-rc1 and later version
>>>=20
>>> 2. start the Qemu virt board
>>>=20
>>> ```sh
>>> $ cat ~/8_riscv/start_latest.sh
>>> #!/bin/bash
>>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 =
\
>>>        -s -nographic -drive =
file=3D/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/=
RISCV_VIRT.fd,if=3Dpflash,format=3Draw,unit=3D1 \
>>>        -machine virt,acpi=3Doff -smp 2 -m 2G \
>>>        -kernel =
/home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
>>>        -initrd =
/home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
>>>        -append "root=3D/dev/ram ro console=3DttyS0 =
earlycon=3Duart8250,mmio,0x10000000 efi=3Ddebug loglevel=3D8 =
memblock=3Ddebug" ## also panic by memtest
>>> ```
>>> 3. Then you will encounter the kernel panic logged in the above link
>>>=20
>>> Other Information:
>>>=20
>>> 1. -------
>>>=20
>>> This report is not identical to my prior report -- "kernel paniced =
when system hibernates" [1], but both of them
>>> are closely related with the commit (3335068f8721 "riscv: Use =
PUD/P4D/PGD pages for the linear mapping").
>>>=20
>>> With this commit, hibernation is trapped with "access fault" while =
accessing the PMP-protected regions (mmode_resv0@80000000)
>>> from OpenSbi (BTW, hibernation is marked as nonportable by =
Conor[2]).
>>>=20
>>> In this report, efi_init handoffs the memory mapping from Boot =
Services to memblock where reserves mmode_resv0@80000000,
>>> so there is no "access fault" but "page fault".
>>>=20
>>> And reverting commit 3335068f8721 indeed fixed this panic.
>>>=20
>>> 2. -------
>>>=20
>>> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault =
virtual address had the appropriate permission to store.
>>> Is there another way to trigger the "Store/AMO page fault"? Or the =
creation of linear mapping in commit 3335068f8721 did something wrong?
>>>=20
>>> ```
>>> (gdb) p/x $satp
>>> $1 =3D 0xa000000000081708
>>> (gdb) pt -satp 0xa000000000081708
>>>             Address :     Length   Permissions
>>>  0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
>>>  0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
>>>  0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
>>>  0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
>>>  0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
>>>  0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: =
ff6000007fdb1000
>>>  0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
>>>  0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
>>>  0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
>>>  0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
>>>=20
>>> ```
>>>=20
>>> 3. ------
>>>=20
>>> You can also reproduce similar panic by appending "memtest" in =
kernel cmdline.
>>> I have posted the memtest boot log at this link: =
https://termbin.com/1twl.
>>>=20
>>> Please correct me if I'm wrong.
>>>=20
>>> [1]: =
https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+vm_=
1dHJxPNi75YDQ_Q@mail.gmail.com/
>>> [2]: =
https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae12005115=
9@wendy/
>>> [3]: https://github.com/martinradev/gdb-pt-dump
>>=20
>> Thanks for the thorough report, really appreciated.
>>=20
>> So there are multiple issues here:
>>=20
>> - the first one is that the memory region for opensbi is marked as =
not
>> cacheable in the efi memory map, and then this region is not mapped =
in
>> the linear mapping:
>> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   =
|
>> |  |  |  |  |  |  |  |   |  |  |  |UC]
>>=20
>> - the second one (that I feel a bit ashamed of...) is that I did not
>> check the alignment of the virtual address when choosing the map size
>> in best_map_size() and then we end up trying to map a physical region
>> aligned on 2MB that is actually not aligned on 2MB virtually because
>> the opensbi region is not mapped at all.
>>=20
>> - the possible third one is that we should not map the linear mapping
>> using 4K pages, this would be slow in my opinion, and I think we
>> should waste a bit of memory to align va and pa on a 2MB boundary.
>>=20
>> So I'll fix the second issue, and possibly the third one, and if no
>> one looks into why the opensbi region is mapped in UC, I'll take a
>> look at edk2.
>>=20
> Hi Alex,
>=20
> EDK2 marks opensbi range as reserved memory in EFI map. According to =
DT
> spec, if the no-map is not set, we need to mark it as
> EfiBootServicesData but EfiBootServicesData is actually considered as
> free memory in kernel, as per UEFI spec. To avoid kernel using this
> memory, we deviated from the DT spec for opensbi ranges.

Violating specs is never the answer. Do one of:

1. Use no-map and take the performance hit
2. Exclude the memory range from /memory itself
3. Come up with a new no-access property that=E2=80=99s a weaker no-map
   (i.e. that allows mapping and speculative access) and uses
   EfiRuntimeServicesData in EFI land

2 feels most normal to me, personally, but all are fine.

Jess

> Let me know your thoughts how we can handle this better in EDK2
> considering it has to support ACPI also.
>=20
> Thanks,
> Sunil
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


