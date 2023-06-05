Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31031722AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjFEPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjFEPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:15 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EEA1BCA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:12:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b0bfb76cfso20913845ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685977953; x=1688569953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k0AVfITaexd+O/8Zvhrtfpxkbv78ZJrYCvg9tdq3pU0=;
        b=pTRTTtTQ9D8lHog2KMH5n1WXsp/Avd08i2w30yEARIxzr8ULMc+wCM3/fPo3OMGAoR
         n5VaXzmIomVe9Y06XL5pn58AalI49hmn1VFVQ9PGZ3fGs4cjtEQo67PZd+hthlmqiRY5
         GE0EFzmk6gXXMPZC7Yr7vecDCKZKqV0ALG43JtfXTlJZoIU69HpNYYuoknFF+te5sOQU
         RDPSXvAHUSWpsVbVd9M/a8QsulFPTlRDs+JWZnYVzt6CrhCQKNCgi6WWIEc/gb2Xqc9L
         5R5Q8JbbCFvSGKpT7XAgSzw4b0zw8PxIh+Em+mpfXfHEQ+75vhbf4bOLUmWAlACW1UMD
         sXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685977953; x=1688569953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0AVfITaexd+O/8Zvhrtfpxkbv78ZJrYCvg9tdq3pU0=;
        b=erAfV6U4vD0YrBryaTUTMr5UK2o9endx8VkGCxdP82W2/i5/CJTvIqYmjivkMNslpX
         j5MikkffMyVvtAwEM43eLHxJhUQGSW1Amaggo7p9/XLhdbSosZq1nT/YPklUvMKzXjty
         Riu0wxp6vHTiR9iJ7Koa8v/3gIkeGfwnq0hOczMsX12kdrkCwyZ83MFuYrfFk3zOvkp6
         0c4y28AnSwbo15rDyygnNk6UFR7HLG+tiOnyYHXlEWwrRTCeWW91fPlhul3gdwonbKIt
         EDCp9nkp9ArQARyVB6WL1+NPSSw3mOSAtDhCz0sfdSc7jIpIDSwVZkYIB5Vrhxuqj+Li
         cpMQ==
X-Gm-Message-State: AC+VfDxOpg0vuryaIUcmQyqGQcxkw9r5kR2Mayv1lpquzTwY1NOlXnMf
        AWpkzx/rGCsaPH01rCoAbkrK7A==
X-Google-Smtp-Source: ACHHUZ59a2PNnpeAHGWsZsfwYG8+T7rs/U6QySUhlzItBA4G7E2PL3GQvP6c8vx4PpUN6OQz02TwYA==
X-Received: by 2002:a92:ad05:0:b0:328:a646:8bf5 with SMTP id w5-20020a92ad05000000b00328a6468bf5mr87728ilh.27.1685977952922;
        Mon, 05 Jun 2023 08:12:32 -0700 (PDT)
Received: from sunil-laptop ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a764f00b0024de0de6ec8sm6063564pjl.17.2023.06.05.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:12:32 -0700 (PDT)
Date:   Mon, 5 Jun 2023 20:42:24 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Song Shuai <songshuaishuai@tinylab.org>, robh <robh@kernel.org>,
        ajones <ajones@ventanamicro.com>, anup <anup@brainfault.org>,
        palmer <palmer@rivosinc.com>,
        "jeeheng.sia" <jeeheng.sia@starfivetech.com>,
        "leyfoon.tan" <leyfoon.tan@starfivetech.com>,
        "mason.huo" <mason.huo@starfivetech.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        "conor.dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug report: kernel paniced while booting
Message-ID: <ZH37WMnx/rYSRF/o@sunil-laptop>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
 <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> Hi Song,
> 
> On Mon, Jun 5, 2023 at 12:52 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
> >
> > Description of problem:
> >
> > Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault was trapped to trigger a kernel panic.
> > The entire log has been posted at this link : https://termbin.com/nga4.
> >
> > You can reproduce it with the following step :
> >
> > 1. prepare the environment with
> >    - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> >    - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the number of random tests")
> >    - Linux : v6.4-rc1 and later version
> >
> > 2. start the Qemu virt board
> >
> > ```sh
> > $ cat ~/8_riscv/start_latest.sh
> > #!/bin/bash
> > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> >         -s -nographic -drive file=/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
> >         -machine virt,acpi=off -smp 2 -m 2G \
> >         -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
> >         -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
> >         -append "root=/dev/ram ro console=ttyS0 earlycon=uart8250,mmio,0x10000000 efi=debug loglevel=8 memblock=debug" ## also panic by memtest
> > ```
> > 3. Then you will encounter the kernel panic logged in the above link
> >
> > Other Information:
> >
> > 1. -------
> >
> > This report is not identical to my prior report -- "kernel paniced when system hibernates" [1], but both of them
> > are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD pages for the linear mapping").
> >
> > With this commit, hibernation is trapped with "access fault" while accessing the PMP-protected regions (mmode_resv0@80000000)
> > from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
> >
> > In this report, efi_init handoffs the memory mapping from Boot Services to memblock where reserves mmode_resv0@80000000,
> > so there is no "access fault" but "page fault".
> >
> > And reverting commit 3335068f8721 indeed fixed this panic.
> >
> > 2. -------
> >
> > As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtual address had the appropriate permission to store.
> > Is there another way to trigger the "Store/AMO page fault"? Or the creation of linear mapping in commit 3335068f8721 did something wrong?
> >
> > ```
> > (gdb) p/x $satp
> > $1 = 0xa000000000081708
> > (gdb) pt -satp 0xa000000000081708
> >              Address :     Length   Permissions
> >   0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> >   0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> >   0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> >   0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> >   0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> >   0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff6000007fdb1000
> >   0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> >   0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> >   0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> >   0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> >
> > ```
> >
> > 3. ------
> >
> > You can also reproduce similar panic by appending "memtest" in kernel cmdline.
> > I have posted the memtest boot log at this link: https://termbin.com/1twl.
> >
> > Please correct me if I'm wrong.
> >
> > [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae120051159@wendy/
> > [3]: https://github.com/martinradev/gdb-pt-dump
> 
> Thanks for the thorough report, really appreciated.
> 
> So there are multiple issues here:
> 
> - the first one is that the memory region for opensbi is marked as not
> cacheable in the efi memory map, and then this region is not mapped in
> the linear mapping:
> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
>  |  |  |  |  |  |  |  |   |  |  |  |UC]
> 
> - the second one (that I feel a bit ashamed of...) is that I did not
> check the alignment of the virtual address when choosing the map size
> in best_map_size() and then we end up trying to map a physical region
> aligned on 2MB that is actually not aligned on 2MB virtually because
> the opensbi region is not mapped at all.
> 
> - the possible third one is that we should not map the linear mapping
> using 4K pages, this would be slow in my opinion, and I think we
> should waste a bit of memory to align va and pa on a 2MB boundary.
> 
> So I'll fix the second issue, and possibly the third one, and if no
> one looks into why the opensbi region is mapped in UC, I'll take a
> look at edk2.
> 
Hi Alex,

EDK2 marks opensbi range as reserved memory in EFI map. According to DT
spec, if the no-map is not set, we need to mark it as
EfiBootServicesData but EfiBootServicesData is actually considered as
free memory in kernel, as per UEFI spec. To avoid kernel using this
memory, we deviated from the DT spec for opensbi ranges.

Let me know your thoughts how we can handle this better in EDK2
considering it has to support ACPI also.

Thanks,
Sunil
