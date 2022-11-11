Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD349625638
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiKKJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:07:55 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0556571
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:07:54 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id l127so4382374oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xn4hzaJgmW74wHFSWaJP0C7Hb1AFQ8yMZSzGcgWTOY8=;
        b=fMONzNJHFaeISk9j0fhhmxmv6RKjiGNlvwOEYxWzmeFGRm707i4piVcLTzdUcZMC2I
         VF7Hl70DRN12vgbzf6uJWGmmGNsnJd1qRrWFclz5t9nN+J/p8AFFbg/gNL/8tl3wmB89
         IoAt/8BdZIOVIbbi/hRwjvKtOwNiQmSt0ills=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xn4hzaJgmW74wHFSWaJP0C7Hb1AFQ8yMZSzGcgWTOY8=;
        b=mOAfwDb8ni/0dT/VRtmJuqEg8SWEKP2eywIh5p+5CFL+FfLvCo7zeN8laeMlN0PRT6
         y/XFbewZY5cCmrGkuhIVwXs3DzcdP8/cCcgVxwp7rLm2dO3JKVzfmqsSAw1V97B5L9jZ
         +4PtTyWZx+ihV0eA3nFgnlEijAcFwJsvSGg6tJWDMyIYNX9VE2QXQc/KCypNlg4u/afA
         +68OkEiZ7XKGOT8oYDP2IYZ3JYd6ExsStviv6cnWw0wP19UKfA099+YA8tYoAOhYfQt3
         SRSNbszvXtzpsnHsetN4GMlzCI0d95CRnY3EDKJtqIpu6DSOQtO7qfk+A2mrSuQP2GMV
         2toA==
X-Gm-Message-State: ANoB5pmo9FImlePJMHEe90JVS0OJNBZNhOXwk28TvSc42F6Bu744lfP4
        LHH9ZZi0aV3YR31iluvCEWrx+NXoU0UfEy6mkELy
X-Google-Smtp-Source: AA0mqf4kJv0cKPFbfNTldL3acQuypljQSeGl3FqPy5ZbmsYzCjWUuaioyoG3/m/3aJCVhxmuHjm1FFiRoQas7NnxGyo=
X-Received: by 2002:a05:6808:22a5:b0:354:8922:4a1a with SMTP id
 bo37-20020a05680822a500b0035489224a1amr319082oib.181.1668157673234; Fri, 11
 Nov 2022 01:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
In-Reply-To: <20221111044207.1478350-1-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 11 Nov 2022 01:07:42 -0800
Message-ID: <CAOnJCULbRSSjYvQP_2bysj1jd0_ywNjQ+gH7eteU7uJWZZ2KiQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Linux RISC-V AIA Support
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 8:42 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The RISC-V AIA specification is now frozen as-per the RISC-V international
> process. The latest frozen specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0-RC1/riscv-interrupts-1.0-RC1.pdf
>
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs
>
> For an overview of the AIA specification, refer the recent AIA virtualization
> talk at KVM Forum 2022:
> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_in_KVM_RISCV_final.pdf
> https://www.youtube.com/watch?v=r071dL8Z0yo
>
> This series adds required Linux irqchip drivers for AIA and it depends on
> the recent "RISC-V IPI Improvements".
> (Refer, https://lore.kernel.org/lkml/20221101143400.690000-1-apatel@ventanamicro.com/t/)
>
> To test this series, use QEMU v7.1 (or higher) and OpenSBI v1.1 (or higher).
>
> These patches can also be found in the riscv_aia_v1 branch at:
> https://github.com/avpatel/linux.git
>
> Anup Patel (9):
>   RISC-V: Add AIA related CSR defines
>   RISC-V: Detect AIA CSRs from ISA string
>   irqchip/riscv-intc: Add support for RISC-V AIA
>   dt-bindings: Add RISC-V incoming MSI controller bindings
>   irqchip: Add RISC-V incoming MSI controller driver
>   dt-bindings: Add RISC-V advanced PLIC bindings
>   irqchip: Add RISC-V advanced PLIC driver
>   RISC-V: Select APLIC and IMSIC drivers for QEMU virt machine
>   MAINTAINERS: Add entry for RISC-V AIA drivers
>
>  .../interrupt-controller/riscv,aplic.yaml     |  136 ++
>  .../interrupt-controller/riscv,imsic.yaml     |  174 +++
>  MAINTAINERS                                   |   12 +
>  arch/riscv/Kconfig.socs                       |    2 +
>  arch/riscv/include/asm/csr.h                  |   92 ++
>  arch/riscv/include/asm/hwcap.h                |    8 +
>  arch/riscv/kernel/cpu.c                       |    2 +
>  arch/riscv/kernel/cpufeature.c                |    2 +
>  drivers/irqchip/Kconfig                       |   32 +-
>  drivers/irqchip/Makefile                      |    2 +
>  drivers/irqchip/irq-riscv-aplic.c             |  656 +++++++++
>  drivers/irqchip/irq-riscv-imsic.c             | 1207 +++++++++++++++++
>  drivers/irqchip/irq-riscv-intc.c              |   37 +-
>  include/linux/irqchip/riscv-aplic.h           |  117 ++
>  include/linux/irqchip/riscv-imsic.h           |   92 ++
>  15 files changed, 2564 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
>  create mode 100644 drivers/irqchip/irq-riscv-aplic.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic.c
>  create mode 100644 include/linux/irqchip/riscv-aplic.h
>  create mode 100644 include/linux/irqchip/riscv-imsic.h
>
> --
> 2.34.1
>

I am seeing the following boot failure with your branch and upstream
qemu (tag: v7.2.0-rc0).
It seems IPIs are probably not getting delivered after a point. I saw
that IPIs are delivered in the same path earlier (via gdb).

[    0.990152] NET: Registered PF_INET6 protocol family
[    1.004885] Segment Routing with IPv6
[    1.005385] In-situ OAM (IOAM) with IPv6
[    1.006371] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.011609] NET: Registered PF_PACKET protocol family
[    1.014877] 9pnet: Installing 9P2000 support
[    1.015603] Key type dns_resolver registered
[    1.026396] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    1.144097] EXT4-fs (vda2): recovery complete
[    1.146345] EXT4-fs (vda2): mounted filesystem with ordered data
mode. Quota mode: disabled.
[    1.147020] VFS: Mounted root (ext4 filesystem) on device 254:2.
[    1.152238] devtmpfs: mounted
[    1.183914] Freeing unused kernel image (initmem) memory: 2176K
[    1.185898] Run /sbin/init as init process
[   29.412287] rcu: INFO: rcu_sched self-detected stall on CPU
[   29.412992] rcu:     3-....: (5250 ticks this GP)
idle=fc3c/1/0x4000000000000002 softirq=78/78 fqs=2230
[   29.413427]  (t=5251 jiffies g=-1047 q=3 ncpus=8)
[   29.414199] CPU: 3 PID: 1 Comm: init Not tainted
6.1.0-rc4-00024-g5b711f2d7b91 #198
[   29.414578] Hardware name: riscv-virtio,qemu (DT)
[   29.414896] epc : smp_call_function_many_cond+0x138/0x372
[   29.415157]  ra : smp_call_function_many_cond+0x154/0x372
[   29.415318] epc : ffffffff8008d2e6 ra : ffffffff8008d302 sp :
ff2000000004bb40
[   29.415512]  gp : ffffffff812e9eb0 tp : ff600000016d8000 t0 :
ff6000007ed88610
[   29.415686]  t1 : 00000000000000ff t2 : 0000000000000002 s0 :
ff2000000004bc00
[   29.415837]  s1 : ff6000007ed85448 a0 : 0000000000000007 a1 :
00000000000000f7
[   29.416008]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
ff6000007edd1780
[   29.416188]  a5 : 0000000000000001 a6 : ffffffff812eb1c0 a7 :
ff600000016d8000
[   29.416613]  s2 : ffffffff81323c30 s3 : ffffffff812e9964 s4 :
0000000000000000
[   29.416810]  s5 : 0000000000000000 s6 : ff6000007ed85440 s7 :
0000000000000038
[   29.416997]  s8 : 0000000000000003 s9 : ffffffff81323c30 s10:
ff6000007ed85448
[   29.417159]  s11: 0000000000000008 t3 : 00ffffffad08a000 t4 :
ff60000001613e0c
[   29.417331]  t5 : 0000000000000000 t6 : 00ffffffad177fff
[   29.417482] status: 0000000200000120 badaddr: 0000000000000000
cause: 8000000000000005
[   29.417939] [<ffffffff8008d590>] on_each_cpu_cond_mask+0x20/0x32
[   29.418179] [<ffffffff80008d32>] flush_icache_all+0x38/0x40
[   29.418324] [<ffffffff80008eb2>] flush_icache_pte+0x4a/0x7a
[   29.418442] [<ffffffff80139e00>] do_set_pte+0x132/0x192
[   29.418594] [<ffffffff8010b42e>] filemap_map_pages+0x178/0x3a0
[   29.418738] [<ffffffff8013ad00>] __handle_mm_fault+0x992/0xbac
[   29.418876] [<ffffffff8013afde>] handle_mm_fault+0xc4/0x1d4
[   29.419010] [<ffffffff80008372>] do_page_fault+0x120/0x326
[   29.419145] [<ffffffff800033e6>] ret_from_exception+0x0/0xc



-- 
Regards,
Atish
