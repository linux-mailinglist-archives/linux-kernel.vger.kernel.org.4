Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF863BCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiK2JS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiK2JSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:18:24 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0D2018E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:18:19 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so8681095otb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq+M8I9ourU5JGtvx7CAysaHGTlBXUBBlVJ4IO6dNtE=;
        b=gTre9Yd3WAvRWIMI92/UAwT5NcIIH6E5wVaoD4seOyfwY69cg/1Si04zngmFyhD5vl
         IA1J0wXEgF5Xfco9cTAHWQucjz4q2HvJmfWkKpuNUPVAjfhB0aTqqihy+vAw/4LytSPG
         1NjE2/zhaoOsqdEP3ifcOFsgJI+beASwqgDEhmVw0VXEgvooAZyHtMwLlQLCVtXoXdSv
         yAVhe6tOg68xMHM1fs0xZzupemF+oUlRTdxsh+KkQIJbfnkRxI+HPcFCzGmpoAGJSkMo
         3XjGyyhF/+Z3sIy9BSE2VLBl3o7XfoPz0mvfj8W3GfLMDq9jPh5KrM2NGVuZNu/CYkLY
         YEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mq+M8I9ourU5JGtvx7CAysaHGTlBXUBBlVJ4IO6dNtE=;
        b=Gs05yE+XNXOwZHFD1+eqAbP4gyXk4FnbCdnBZK86otDapDi91CRjG0vUgitz5Tgyoj
         89sTFvQQ01i6Jq1T4UyM3pfL8fffZlHHtsXfMiCP0lMCiElKd5aSNSl0FAQiOEE8bG9j
         0yxr4yjQrpgElSQ22hbZMHlJjXOb2OS8E8Q9NhR7uRJ0wGSsxlnNgYuqC4nrXxZcCL8F
         x0+1R4sYWxcT9sxNgBFwslLj9muXUNqjAWnNGQZOIQ7NA98lq6xgux2BFS/LP0hXU2eD
         SaCH7O6+kbTH1xP0b0TqnEctXsraABAfhgKDh/67M6m4D97YREFTliFMXgh3YkVnhG8S
         YFmw==
X-Gm-Message-State: ANoB5pn9j/kUkxs8fl3rr1lrqsuauCzNyyNbBpwwNgIWhXpU130ehXGo
        P4Khxy5Jg57bGoWzMjNugNtbWom6YamlN3DOvVZ70A==
X-Google-Smtp-Source: AA0mqf4M9WPpgu5o0bKUU3S1DuefQLuGU6o98qT9aYktvIskR/xEHM0BML0V0+dmJtYh3k3fBUNNlSPYZGZ5+LtVrNs=
X-Received: by 2002:a9d:5e0f:0:b0:662:2458:3ef7 with SMTP id
 d15-20020a9d5e0f000000b0066224583ef7mr27837215oti.150.1669713498572; Tue, 29
 Nov 2022 01:18:18 -0800 (PST)
MIME-Version: 1.0
References: <e39851df-251d-662d-3319-af9d948a9430@sholland.org> <mhng-028a3e75-6cd0-4775-ac68-3e0eb70c91ae@palmer-ri-x1c9>
In-Reply-To: <mhng-028a3e75-6cd0-4775-ac68-3e0eb70c91ae@palmer-ri-x1c9>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 29 Nov 2022 14:48:08 +0530
Message-ID: <CAK9=C2VCXLOMBa4JQPRDjXQN5LnNdp3gFKmuMb28EONbkHiRpg@mail.gmail.com>
Subject: Re: [PATCH] riscv: head: use 0 as the default text_offset
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     samuel@sholland.org, Atish Patra <atishp@rivosinc.com>,
        jszhang@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:50 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 28 Nov 2022 21:04:48 PST (-0800), samuel@sholland.org wrote:
> > On 11/28/22 14:11, Atish Kumar Patra wrote:
> >> On Mon, Nov 28, 2022 at 7:34 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >>>
> >>> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
> >>> parse.") adds an image header which "is based on ARM64 boot image
> >>> header and provides an opportunity to combine both ARM64 & RISC-V
> >>> image headers in future.". At that time, arm64's default text_offset
> >>> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
> >>> the swapper page tables" as commit cfa7ede20f13 ("arm64: set TEXT_OFFSET
> >>> to 0x0 in preparation for removing it entirely") pointed out, but
> >>> riscv doesn't need the space, so use 0 as the default text_offset.
> >>>
> >>> Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
> >>> with u-boot booti cmd:
> >>> [    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
> >>> ...
> >>> [    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
> >>> As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
> >>> linux.
> >>>
> >>> After this patch, the 64MB DDR is fully usable by linux
> >>> [    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]
> >>>
> >>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >>> ---
> >>>  arch/riscv/kernel/head.S | 12 +-----------
> >>>  1 file changed, 1 insertion(+), 11 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> >>> index b865046e4dbb..ef95943f7a70 100644
> >>> --- a/arch/riscv/kernel/head.S
> >>> +++ b/arch/riscv/kernel/head.S
> >>> @@ -38,18 +38,8 @@ ENTRY(_start)
> >>>         .word 0
> >>>  #endif
> >>>         .balign 8
> >>> -#ifdef CONFIG_RISCV_M_MODE
> >>> -       /* Image load offset (0MB) from start of RAM for M-mode */
> >>> +       /* Image load offset (0MB) from start of RAM */
> >>>         .dword 0
> >>> -#else
> >>> -#if __riscv_xlen == 64
> >>> -       /* Image load offset(2MB) from start of RAM */
> >>> -       .dword 0x200000
> >>> -#else
> >>> -       /* Image load offset(4MB) from start of RAM */
> >>> -       .dword 0x400000
> >>> -#endif
> >>> -#endif
> >>
> >> NACK.
> >> RV64 needs to boot at a 2MB aligned address and RV32 needs to boot at
> >> a 4MB aligned address.
> >> The firmware is assumed to live at the start of DRAM for Linux running
> >> in S-mode.
> >
> > What needs to happen so we can stop making this assumption? If the SBI
> > implementation wants to reserve memory, it should use the devicetree to
> > do so. OpenSBI already does this.
>
> IMO we've really screwed up the boot flow on RISC-V.  Having Linux
> reserve space for the firmware is just all backwards, Linux can't know
> how much memory the firmware needs (which manifests under large hart
> counts in OpenSBI, for example).  Unfortunately there's no specification
> that defines these platform-level details, so we're stuck depending on
> unspecified behavior like this.
>
> I think we could fix this by either making Linux's early boot relocation
> code work sanely (fix whatever bugs are there, document what can't be
> fixed, and then add some sort of Image flag to tell firmware the kernel
> can be relocated) or relying on relocatable firmware, but both of those
> come with some costs ...

Clearly, there is a misunderstanding about the "offset" field in the kernel
image header.

The "offset" field is not for reserving memory for firmware (OpenSBI). The
value of "offset" is a hint to bootloader that kernel expects to be booted
at a particular aligned physical address (2M for RV64 and 4M for RV32).
This "offset" hint is based on the fact that the kernel tries its best to use
huge mappings for kernel virtual addresses which results in good
performance in kernel space.

In fact, even today a bootloader can happily load the kernel at the
RAM_START and it will boot perfectly fine.

The real issue is that whenever __pa(PAGE_OFFSET) > RAM_START,
kernel will reserve memory from RAM_START to __pa(PAGE_OFFSET)
and this will happen irrespective where the firmware is running. The
patch posted by Alex tries to solve this issue whereas the current patch
tries to change the "offset" in the image header which is totally wrong.

Also, the Linux reserved-memory DT bindings define a standard way
to inform the kernel about reserved memory areas. The OpenSBI
firmware uses reserved-memory DT bindings to reserve its own
memory so kernel does not have to guess anything.

>
> > Throwing away 2 MiB of RAM is quite wasteful considering we have
> > multiple SoCs (D1s, BL808) that are limited to 64 MiB of in-package RAM.
>
> ... and I'd argue that users on systems don't want to pay those costs.
> In fact, I'd argue that systems like that don't want resident firmware
> at all.
>
> So let's just add a CONFIG_SBI=n, and then just use direct drivers for
> everything.  If the firmware doesn't need to be resident then it's
> pretty straight-forward to support these 0 offsets, so we can just add
> that as another Kconfig.  Sure this will trip up firmware that depends
> on these fixed reservations, but saying "the resident firmware fits in 0
> superpages" is just as much of a platform-specific dependency as saying
> "the resident firmware fits in 1 superpage".  If firmware can't handle
> this field in the Image format then we're going to end up with breakages
> at some point, it might as well be now.

The firmware (OpenSBI) does not depend on any fixed memory
reservations from the kernel. It is capable of running from any
memory location since it is compiled using -fPIC.

>
> If these systems don't have all the ISA bits necessary to avoid M-mode
> entirely then we can just implement a tiny M-mode stub in Linux that
> gets left around during early boot and then shims stuff to S-mode.
> That'll be a bit of a headache and with some extensions it can be
> avoided, the standard stuff won't allow for that until the latest round
> of specs is done but if it's possible via whatever custom extensions are
> in these things then that's probably the way to go.

Another misunderstanding here is that SBI stuff == firmware stuff. All
RISC-V hypervisors implement the SBI spec for Guest/VM. In absence
of SBI, how will Guest/VM bring-up secondary VCPUs or reboot itself ?

In fact without SBI, all paravirt approaches (such as steal time
accounting, time scaling, system reset, CPU hotplug etc) become
fragmented across hypervisors. Do we expect all hypervisors (proprietary
or opensource) send their own non-standard driver support to Linux
which is otherwise standardized through SBI spec ?

The M-mode can have dedicated resources (debug CSRs, PMU
counter configuration CSRs, etc) so in absence of SBI how will
S-mode use these features? We have more M-mode only resources
being defined by RVI (example Resumable NMIs) which will eventually
require SBI abstraction for S-mode.

Let alone CSRs, on future platforms, the M-mode will have attestation
capability so without SBI how will S-mode get this attestation facility.

>
> We'll probably also end up shaking out some bugs in that early
> relocation code, but again no big deal: we'll need to chase those down
> at some point, it might as well be now.

Regards,
Anup
