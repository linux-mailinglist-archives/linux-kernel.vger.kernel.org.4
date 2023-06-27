Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D973FF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjF0PN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0PNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:13:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA9626AF;
        Tue, 27 Jun 2023 08:13:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eec46206so4131799b3a.3;
        Tue, 27 Jun 2023 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878802; x=1690470802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXZOH/PHDrh2TthSxMggay95849Ug6bU1pXX4QAThzI=;
        b=ftlRh0wF1ZPcLPZCxuDzvQ8gQPRtrtqFJFlZaHtuM43lCMmg/ckslMbJ2KLp7L0X8F
         eIHPu2fi2ib22kvQn4EA97roFzMgFwT9IFM4892mtxoSgPexysYUCAFJgKRgdIRMlkqb
         WxAmUYQNAaeLtyfKpncyLmjsTQGi5f+r+RNM0f29ZhUAptJu6ma43UDEGbkrFK/lHoqY
         RKRJgvYIJuJWk4181YK5Z02mkIiJZtALLzCCtEaSKzSwMSvqpbE/MEoCGiIXebGNLIn/
         KqSLySi242JuMyPxuEOSSwTjNtT+cZ8bhTxF1cKmuYWGsdjly+SL0Y2aZqVvLiq+0f3C
         S07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878802; x=1690470802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VXZOH/PHDrh2TthSxMggay95849Ug6bU1pXX4QAThzI=;
        b=g68BoFX/MuhKnPFXnfCYU4r28eBousSmOhMFGqKmAMEq4LPlIJZmFWhXygQYLbAAMa
         Xz7xqjV0i/85Ru7x+zxiBWFn7qSo0ZwMwhhaCp4Q5NnEBr9AMv0dZkRBFXP/7htNFnLV
         tN0Bxezx9eY1vGR2xzALZ7g5cryo4jzvgMwekPm9N0VWp0JoPpsrWlngB/axeepPWGLA
         eX3lOw9R5Yg1qv27YlS+x4VNbQX2X470OtpzzgXUwJDv5HgN8Ma7kE8QM7HheyGjbDl5
         UYBvolbU7lzDVYhA+q8Ch1OqPy7ccUVw541HSGHKT6W8BZg18bSLeY5jhR6LyuiqwZZd
         yvkw==
X-Gm-Message-State: AC+VfDy926adzjPv39Cw358okPlipE+bfpzJa3yaHxoGSg6jLY33yl1F
        ir9+SN3eIRP7pf8Qkq8iN3I=
X-Google-Smtp-Source: ACHHUZ5tlxW0msX3NuUhoJjfu5y1DELLaJLraiQT0vX/NleFFtiBgovgyltyL56aD2U5XdxDNNDEJA==
X-Received: by 2002:a05:6a20:3956:b0:128:86a3:f7f3 with SMTP id r22-20020a056a20395600b0012886a3f7f3mr4880428pzg.48.1687878802273;
        Tue, 27 Jun 2023 08:13:22 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id m18-20020aa79012000000b0064fc715b380sm5705428pfo.176.2023.06.27.08.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 08:13:21 -0700 (PDT)
Message-ID: <33372b6e-853f-e7d2-9785-167e2218947c@gmail.com>
Date:   Tue, 27 Jun 2023 23:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V1 0/3] Revert huge-paged linear mapping and its related
 fixups
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, mpe@ellerman.id.au, arnd@arndb.de,
        rppt@kernel.org, samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
 <CAHVXubgJcGPq_uC6iJCLTys5J6Ooa1EYcfOhBjEQwYfd+baWxw@mail.gmail.com>
 <CAHVXubi-FmwJxeb5ymw_bU5NM7HyteNyyJxG7D+hDzOJWnix5Q@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <CAHVXubi-FmwJxeb5ymw_bU5NM7HyteNyyJxG7D+hDzOJWnix5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

在 2023/6/27 19:47, Alexandre Ghiti 写道:
> On Sun, Jun 25, 2023 at 10:36 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>
>> Hi Song,
>>
>> On Sun, Jun 25, 2023 at 4:10 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>>
>>> We have encountered these two issues about huge-paged linear mapping since v6.4-rc1:
>>>
>>> 1. Bug report: kernel paniced when system hibernates[1]
>>>
>>> OpenSbi [v0.8,v1.3) set the PMP regions as !no-map, and the commit 3335068f8721
>>> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") mapped them in linear mapping.
>>> The hibernation process attempted to save/restore these mapped regions resulting in access fault.
>>>
>>> This issue was temporarily fixed by commit ed309ce52218 ("RISC-V: mark hibernation as nonportable").
>>> But as Alex's RFC and Rob's response stats in another thread [2] ,
>>> "Hibernation is only one case. Speculative accesses could also occur."
>>> So this fixing commit seems not the perfect answer to this issue.
>>>
>>>
>>> 2. Bug report: kernel paniced while booting (with UEFI )[3]
>>>
>>> During the booting with UEFI, UEFI Memory Mapping overwrote the memblock.
>>> The phys_ram_base was set as the end address of mmoderes0 (like 0x80040000 for 256 KiB mmoderes0@80000000),
>>> which resulted the VA based on 2M-aligned PA was not 2M-aligned using va_pa_offset
>>> (PAGE_OFFSET - phys_ram_base) to translate.
>>>
>>> The best_map_size() from commit 3335068f8721 didn't check the virtual alignment
>>> before choosing a map size. and then a "VA hole" was created where page faults always occurred.
>>>
>>> This issue was fixed by commit 49a0a3731596 ("riscv: Check the virtual alignment before choosing a map size"),
>>> But this fixing commit has a side-effect ("the possible third one" as Alex said in this thread).
>>> There are numerous PTE allocations slowing down the boot time and consuming some system memory when UEFI booting
>>> (Note that it's not involved when booting directly with OpenSbi, where phys_ram_base is the 2M-aligned base of DRAM).
>>>
>>> In my test, compared with/out reverting both commit 49a0a3731596 and commit 3335068f8721,
>>> I must wait ~20s for the linear mapping creation and mem_init_print_info() reported ~8M extra reserved memory.
>>
>> Indeed, phys_ram_base is not aligned on a 2MB boundary when booting
>> with EDK2, IIRC that's because the first chunk of memory at
>> 0x8000_0000 is marked as UC and is then completely evicted.
>>
>>>
>>> To eliminate this side-effect, We should find a way to align VA and PA on a 2MB boundary.
>>> The simplest way is reverting the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping").
>>>
>>
>> I disagree, the simplest way is to align phys_ram_base on a 2MB
>> boundary, either by aligning to the upper boundary (and then wastes
>> memory, like we used to) or by aligning to the lower boundary (but I
>> want to make sure it works).
>>
>> I'll come up with something tomorrow.
> 
> @Song Shuai : can you test the following please?
> 
> commit a35b5e5e3f29e415f54fea064176315e79e21fb7 (HEAD ->
> dev/alex/align_va_pa_v1)
> Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> Date:   Mon Jun 5 14:26:55 2023 +0000
> 
>      riscv: Start of DRAM should at least be aligned on PMD size for
> the direct mapping
> 
>      So that we do not end up mapping the whole linear mapping using 4K
>      pages, which is slow at boot time, and also very likely at runtime.
> 
>      So make sure we align the start of DRAM on a PMD boundary.
> 
>      Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4fa420faa780..4a43ec275c6d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
>          memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> 
>          phys_ram_end = memblock_end_of_DRAM();
> +
> +       /*
> +        * Make sure we align the start of the memory on a PMD boundary so that
> +        * at worst, we map the linear mapping with PMD mappings.
> +        */
>          if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> -               phys_ram_base = memblock_start_of_DRAM();
> +               phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
> 
>          /*
>           * In 64-bit, any use of __va/__pa before this point is wrong as we
> 
I tested your patch and it really fixed what I concerned :

`There are numerous PTE allocations slowing down the boot time and 
consuming some system memory when UEFI booting.`

FYI, I posted the `ptdmp` and the available memory with/out the patch 
from my test:

```
 >> v6.4

---[ Linear mapping ]---
0xff60000000000000-0xff600000001c0000    0x0000000080040000      1792K 
PTE     D A G . . W R V
0xff600000001c0000-0xff60000000bc0000    0x0000000080200000        10M 
PTE     D A G . . . R V
0xff60000000bc0000-0xff60000000fc0000    0x0000000080c00000         4M 
PTE     D A G . . W R V
0xff60000000fc0000-0xff600000015c0000    0x0000000081000000         6M 
PTE     D A G . . . R V
0xff600000015c0000-0xff600000ffdfd000    0x0000000081600000   4169972K 
PTE     D A G . . W R V
0xff600000fffbf000-0xff600000fffc0000    0x000000017ffff000         4K 
PTE     D A G . . W R V

 >> v6.4 with the patch

---[ Linear mapping ]---
0xff60000000040000-0xff60000000200000    0x0000000080040000      1792K 
PTE     D A G . . W R V
0xff60000000200000-0xff60000000c00000    0x0000000080200000        10M 
PMD     D A G . . . R V
0xff60000000c00000-0xff60000001000000    0x0000000080c00000         4M 
PMD     D A G . . W R V
0xff60000001000000-0xff60000001600000    0x0000000081000000         6M 
PMD     D A G . . . R V
0xff60000001600000-0xff60000040000000    0x0000000081600000      1002M 
PMD     D A G . . W R V
0xff60000040000000-0xff600000c0000000    0x00000000c0000000         2G 
PUD     D A G . . W R V
0xff600000c0000000-0xff600000ffe00000    0x0000000140000000      1022M 
PMD     D A G . . W R V
0xff600000ffe00000-0xff600000ffe3d000    0x000000017fe00000       244K 
PTE     D A G . . W R V
0xff600000fffff000-0xff60000100000000    0x000000017ffff000         4K 
PTE     D A G . . W R V
```

```
 >> v6.4

Memory: 3945340K/4194048K available (8391K kernel code, 4959K rwdata, 
4096K rodata, 2195K init, 476K bss, 248708K reserved, 0K cma-reserved)

 >> v6.4 with the patch

Memory: 3953524K/4194048K available (8391K kernel code, 4959K rwdata, 
4096K rodata, 2195K init, 476K bss, 240524K reserved, 0K cma-reserved)
```
> An example of output when phys_ram_base is not aligned on a 2MB boundary:
> 
> ---[ Linear mapping ]---
> 0xffffaf8000008000-0xffffaf8000200000    0x0000000080008000      2016K
> PTE     D A G . . W R V
> 0xffffaf8000200000-0xffffaf8000e00000    0x0000000080200000        12M
> PMD     D A G . . . R V
> 0xffffaf8000e00000-0xffffaf8001200000    0x0000000080e00000         4M
> PMD     D A G . . W R V
> 0xffffaf8001200000-0xffffaf8001a00000    0x0000000081200000         8M
> PMD     D A G . . . R V
> 0xffffaf8001a00000-0xffffaf807e600000    0x0000000081a00000      1996M
> PMD     D A G . . W R V
> 0xffffaf807e600000-0xffffaf807e714000    0x00000000fe600000      1104K
> PTE     D A G . . W R V
> 0xffffaf807e715000-0xffffaf807e718000    0x00000000fe715000        12K
> PTE     D A G . . W R V
> 0xffffaf807e71b000-0xffffaf807e71c000    0x00000000fe71b000         4K
> PTE     D A G . . W R V
> 0xffffaf807e720000-0xffffaf807e800000    0x00000000fe720000       896K
> PTE     D A G . . W R V
> 0xffffaf807e800000-0xffffaf807fe00000    0x00000000fe800000        22M
> PMD     D A G . . W R V
> 0xffffaf807fe00000-0xffffaf807ff54000    0x00000000ffe00000      1360K
> PTE     D A G . . W R V
> 0xffffaf807ff55000-0xffffaf8080000000    0x00000000fff55000       684K
> PTE     D A G . . W R V
> 0xffffaf8080000000-0xffffaf83c0000000    0x0000000100000000        13G
> PUD     D A G . . W R V
> 0xffffaf83c0000000-0xffffaf83ffe00000    0x0000000440000000      1022M
> PMD     D A G . . W R V
> 0xffffaf83ffe00000-0xffffaf8400000000    0x000000047fe00000         2M
> PTE     D A G . . W R V
> 
> I found that it was easier to align phys_ram_base on the lower 2MB
> boundary. Aligning on the upper boundary is more complicated to me
> since there may be "something" between phys_ram_base and the upper 2MB
> boundary that needs to be accessed using the linear mapping (DT is
> accessed using fixmap so not a problem, initrd? ACPI tables? I don't
> know actually).
> 

And would there be possible influence from the diff between 
phys_ram_base and memblock_start_of_DRAM()?

> Weirdly simple though, I may be missing something, so any comment/test
> is welcome, it is currently running our internal CI.
> 
> Thanks,
> 
> Alex
> 
>>
>> Thanks,
>>
>> Alex
>>
>>>
>>>
>>> Using PUD/P4D/PGD pages for the linear mapping to improve the performance is marginal from a recent talk [4]
>>> from Mike Rapoport. OpenSbi had marked all the PMP-protected regions as "no-map" [5] to practice this talk.
>>>

I noticed best_map_size() still creates some huge-paged mapping (like 
above 2G PUD) with this patch.
How about to revert best_map_size() to disable huge-paged mapping to 
practice the Mike's talk.

>>> For all those reasons, let's revert these related commits:
>>>
>>> - commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
>>> - commit 49a0a3731596 ("riscv: Check the virtual alignment before choosing a map size")
>>> - commit ed309ce52218 ("RISC-V: mark hibernation as nonportable")
>>>
>>> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
>>> [2]: https://lore.kernel.org/linux-kernel/20230530080425.18612-1-alexghiti@rivosinc.com/
>>> [3]: https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1@qq.com/
>>> [4]: https://lwn.net/Articles/931406/
>>> [5]: https://github.com/riscv-software-src/opensbi/commit/8153b2622b08802cc542f30a1fcba407a5667ab9
>>>
>>> Song Shuai (3):
>>>    Revert "RISC-V: mark hibernation as nonportable"
>>>    Revert "riscv: Check the virtual alignment before choosing a map size"
>>>    Revert "riscv: Use PUD/P4D/PGD pages for the linear mapping"
>>>
>>>   arch/riscv/Kconfig            |  5 +---
>>>   arch/riscv/include/asm/page.h | 16 -------------
>>>   arch/riscv/mm/init.c          | 43 +++++++----------------------------
>>>   arch/riscv/mm/physaddr.c      | 16 -------------
>>>   drivers/of/fdt.c              | 11 ++++-----
>>>   5 files changed, 14 insertions(+), 77 deletions(-)
>>>
>>> --
>>> 2.20.1
>>>
> 

-- 
Thanks
Song Shuai
