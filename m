Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC46CEED8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjC2QJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjC2QIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:08:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E765619C;
        Wed, 29 Mar 2023 09:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0BE3ACE243A;
        Wed, 29 Mar 2023 16:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727EC433A0;
        Wed, 29 Mar 2023 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680106040;
        bh=YVojyzV7I2zxywGSu8koM3+fA1i/6QFns/eP6CWmng0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u70eZqqBR/2FPEKYU9lt4k9neO/yaPErzV3lS/YcyDd/gZifMtk4r3IKmt8jzELbC
         EnaL1wJcls4J6rv7ZY9dbHnHTDeJYUeI1Mdneievyj/eY4nnHxJK+smGX1l+PUY/vH
         Ws4t0X1z4Wh8Ufn3QfgTzTUy8D/CTsoccYsqsPdEFvREblbDE8IvHUszB6fgibryvu
         tt3cZXFuTbpiEYOBE3QtWQ6MiDTe1T1FO6nS7N3dWYoqEj915O5XUKnYC1EvlzkhYR
         wczzdx2Qazng9MLf7LbHfMzQ6/lHWYpJHRstRSAF3nFxxuVwMfo0byNHLk4VKVi44Q
         Bzg4KhpDorctQ==
Received: by mail-lf1-f53.google.com with SMTP id c9so10474139lfb.1;
        Wed, 29 Mar 2023 09:07:20 -0700 (PDT)
X-Gm-Message-State: AAQBX9ecUtJBLbSSsmj9BIG9btNNLy+1GyjcVREGS1f0JQt7lZ3lSwQW
        pGGR4QrIYgvdDo+NG7g5bsRJRZvT5qdsPzpZUFA=
X-Google-Smtp-Source: AKy350bh8npink4uSFW5NTbZr4LUGarnr5B8TIPB3MzdliaetP7r3vp7NRiXadQoj8onxRmpoyOITpqET3EzQJIirBs=
X-Received: by 2002:ac2:522e:0:b0:4dc:4b06:9d67 with SMTP id
 i14-20020ac2522e000000b004dc4b069d67mr5835427lfl.9.1680106038333; Wed, 29 Mar
 2023 09:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230326170756.3021936-1-sdonthineni@nvidia.com>
 <CAMj1kXF4MUGbuiW1bcupMs1VdxxE_74WWDt1YdUTg0o9ft+=JQ@mail.gmail.com> <159ceeab-09af-3174-5058-445bc8dcf85b@nvidia.com>
In-Reply-To: <159ceeab-09af-3174-5058-445bc8dcf85b@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Mar 2023 18:07:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGGUzzyN9BS7OeQcn3tvfmsH8Y_CJu5xQx-y7V7hEgXFA@mail.gmail.com>
Message-ID: <CAMj1kXGGUzzyN9BS7OeQcn3tvfmsH8Y_CJu5xQx-y7V7hEgXFA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Increase MODULES_VSIZE to 512MB
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2023 at 20:59, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
> Thanks Ard for a quick feedback.
>
> On 3/26/23 12:35, Ard Biesheuvel wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Sun, 26 Mar 2023 at 19:08, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
> >>
> >> The allocation of modules occurs in two regions: the first region
> >> MODULES_VSIZE (128MB) is shared with the core kernel, while the
> >> the second region (2GB) is shared with other vmalloc callers.
> >> Depending on the size of the core kernel, the 128MB region may
> >> quickly fill up after loading a few modules, causing the system
> >> to switch to the 2GB region.
> >
> > How much module space are you actually using? This 128 MiB region is
> > not shared with vmalloc() so it should be dedicated to modules
> > entirely.
> >
> Is it correct to say that if the KASLR feature is disabled, 128MB is
> being shared between the kernel and modules? Approximately 110MB used
> by the NVIDIA GPU driver, resulting in the usage of more than 128MB.
>
> root@localhost:~# cat /proc/kallsyms | grep -wE '_etext|_stext|_end'
> ffff8000081d0000 T _stext
> ffff800009390000 D _etext
> ffff80000b4d0000 B _end
>
> root@localhost:~# cat /proc/vmallocinfo | more
> 0xffff800001390000-0xffff800001450000  786432 move_module+0x2c/0x190 pages=11 vmalloc N0=11
> 0xffff800001450000-0xffff8000014b0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
> 0xffff8000014f0000-0xffff800001550000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
> 0xffff800001590000-0xffff8000015f0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
> 0xffff800001630000-0xffff800001690000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
> 0xffff8000016d0000-0xffff800001740000  458752 move_module+0x2c/0x190 pages=6 vmalloc N0=6
> 0xffff800001780000-0xffff8000017e0000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
> 0xffff800001820000-0xffff800001880000  393216 move_module+0x2c/0x190 pages=5 vmalloc N0=5
> ...
>
> The first modules loaded at the address 0xffff800001390000.
>
> Less than 128MB is available for modules if KASLR is disabled.
>
> > If you are doing EFI boot, you may need to following patch to ensure
> > that the 128 MiB region is actually the one being used.
> >
> > commit 010338d729c1090036eb40d2a60b7b7bce2445b8
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Thu Feb 23 21:41:01 2023 +0100
> >
> >      arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN
> >
> >
> I have included your patch to prevent the incorrect detection of the
> KASLR feature. Otherwise, experiencing the different error
> "overflow in relocation type 261", R_AARCH64_PREL32. Seems this is
> due to the incorrect initialization of module_alloc_base.
>

Hmm, not sure - there was a report about this a while ago but I forgot
the details.

In any case, could we perhaps try something like the below? That way,
we still prefer allocating from the 128 MiB region that is within
direct branching range from the core kernel.

--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -46,7 +46,7 @@
 #define KIMAGE_VADDR           (MODULES_END)
 #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR          (_PAGE_END(VA_BITS_MIN))
-#define MODULES_VSIZE          (SZ_128M)
+#define MODULES_VSIZE          (SZ_2G)
 #define VMEMMAP_START          (-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
 #define VMEMMAP_END            (VMEMMAP_START + VMEMMAP_SIZE)
 #define PCI_IO_END             (VMEMMAP_START - SZ_8M)
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 5af4975caeb58ff7..b4affe775f23e84f 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -37,7 +37,7 @@ void *module_alloc(unsigned long size)
                /* don't exceed the static module region - see below */
                module_alloc_end = MODULES_END;

-       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
+       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_end - SZ_128M,
                                module_alloc_end, gfp_mask,
PAGE_KERNEL, VM_DEFER_KMEMLEAK,
                                NUMA_NO_NODE, __builtin_return_address(0));
