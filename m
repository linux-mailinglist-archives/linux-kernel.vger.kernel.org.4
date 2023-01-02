Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E465AF4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjABKHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjABKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:07:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AE6E36
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:07:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u9so65756077ejo.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx6T4WLfFSDBQiZhBJRsGO1zXz9AGhabpmerplrsex4=;
        b=Z2qFnb0B9mfjFSc4wUu47+eQ2eX5IWjCuyUctlvtNy4ZLdcLgc84XCqle8ysdytG85
         3bgQodxaLSuHr03WzVW/9TNaUB+8b7PwWV+qbsP5yhmsAMp05KthOHs0n96Ju0wnKlFY
         wDwU9ZnFGy+RZCjPveiZ/0a7z5yPHFtay2me5qL1HPgaQWLut8cdoNX6qH3A3vnPh6E/
         IfddHhGj9HrvgLwwZx02vp/4yHGc+NesHd59vAwKBZowQGoBlW72kHlOMtkCrd0AZwEy
         onwdB1OMJNLaC4cVLKWWq3TZ6hYX8K+y0/tCKJsUWOqBeIwd9jLkJzhgninUTUHuOEsz
         g+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx6T4WLfFSDBQiZhBJRsGO1zXz9AGhabpmerplrsex4=;
        b=cZxNimbSOCFqidyqnEAV0l7g3JaMP36kCh7pf6cJOeoGVFG0ALGcmnNeQLV8UUNZEV
         eLr/oBqywEXvjby8IG/tkCuF4Ll0HpTrMhlyNBzVLk8j4U0VuBvW+arE6ysiTc7CjYLv
         Mt6gJx1sOBNSWhGeLOC7UNQ0NAZuYBuzD+Eniq+GFV47886GPCnivCtmAqjnqFlaQDkX
         U6r+0r/gLMdbetRsPmy8GcBPJ1hgTOCHn/S8U0RY9iw42bES7+GDzivMpN5aHjXPG9tT
         18Lz59oE3S2fTxWCYoSMp+pa7oAh0FZNDfjV3SUtaZFUuucyA1a6fG8D+Fc6Nc9aXKy9
         5b/w==
X-Gm-Message-State: AFqh2kqSX1qKLKHQz3XB5McO80m0ynDTV+Ll44Evlg8MXIr2slEMhdEq
        vo7NeghW/+oX3QHfBGXWgraqqf+stdFMvbmYN+K1pA==
X-Google-Smtp-Source: AMrXdXui9PtjFpdH3SVM62Gps+BjelTU//TlWTXD5bMyieVnIt76JP5vmaWIK6ar/fx7qyHc9/xAMNZY3YrsmC0MLzw=
X-Received: by 2002:a17:907:90d7:b0:7c0:f20c:2f64 with SMTP id
 gk23-20020a17090790d700b007c0f20c2f64mr2186440ejb.230.1672654030655; Mon, 02
 Jan 2023 02:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <CAOnJCULbRSSjYvQP_2bysj1jd0_ywNjQ+gH7eteU7uJWZZ2KiQ@mail.gmail.com>
 <CAOnJCUL-FzBuaZmTT+1ybmj_PgZ_8AwD-eCX76X56YAuTH1gBQ@mail.gmail.com> <CAOnJCULeJuxuKaxM2wWUyOdCcoYrDnQ-_zQ-MnqbGse1zF1d4Q@mail.gmail.com>
In-Reply-To: <CAOnJCULeJuxuKaxM2wWUyOdCcoYrDnQ-_zQ-MnqbGse1zF1d4Q@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 2 Jan 2023 15:36:59 +0530
Message-ID: <CAAhSdy0Le1Nnha4L_eLh2w8vx6ZM0uS574+jtk3_1PojcNe8wQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Linux RISC-V AIA Support
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 12:31 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Fri, Nov 11, 2022 at 1:13 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Fri, Nov 11, 2022 at 1:07 AM Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Thu, Nov 10, 2022 at 8:42 PM Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > The RISC-V AIA specification is now frozen as-per the RISC-V international
> > > > process. The latest frozen specifcation can be found at:
> > > > https://github.com/riscv/riscv-aia/releases/download/1.0-RC1/riscv-interrupts-1.0-RC1.pdf
> > > >
> > > > At a high-level, the AIA specification adds three things:
> > > > 1) AIA CSRs
> > > >    - Improved local interrupt support
> > > > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> > > >    - Per-HART MSI controller
> > > >    - Support MSI virtualization
> > > >    - Support IPI along with virtualization
> > > > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> > > >    - Wired interrupt controller
> > > >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
> > > >    - In Direct-mode, injects external interrupts directly into HARTs
> > > >
> > > > For an overview of the AIA specification, refer the recent AIA virtualization
> > > > talk at KVM Forum 2022:
> > > > https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_in_KVM_RISCV_final.pdf
> > > > https://www.youtube.com/watch?v=r071dL8Z0yo
> > > >
> > > > This series adds required Linux irqchip drivers for AIA and it depends on
> > > > the recent "RISC-V IPI Improvements".
> > > > (Refer, https://lore.kernel.org/lkml/20221101143400.690000-1-apatel@ventanamicro.com/t/)
> > > >
> > > > To test this series, use QEMU v7.1 (or higher) and OpenSBI v1.1 (or higher).
> > > >
> > > > These patches can also be found in the riscv_aia_v1 branch at:
> > > > https://github.com/avpatel/linux.git
> > > >
> > > > Anup Patel (9):
> > > >   RISC-V: Add AIA related CSR defines
> > > >   RISC-V: Detect AIA CSRs from ISA string
> > > >   irqchip/riscv-intc: Add support for RISC-V AIA
> > > >   dt-bindings: Add RISC-V incoming MSI controller bindings
> > > >   irqchip: Add RISC-V incoming MSI controller driver
> > > >   dt-bindings: Add RISC-V advanced PLIC bindings
> > > >   irqchip: Add RISC-V advanced PLIC driver
> > > >   RISC-V: Select APLIC and IMSIC drivers for QEMU virt machine
> > > >   MAINTAINERS: Add entry for RISC-V AIA drivers
> > > >
> > > >  .../interrupt-controller/riscv,aplic.yaml     |  136 ++
> > > >  .../interrupt-controller/riscv,imsic.yaml     |  174 +++
> > > >  MAINTAINERS                                   |   12 +
> > > >  arch/riscv/Kconfig.socs                       |    2 +
> > > >  arch/riscv/include/asm/csr.h                  |   92 ++
> > > >  arch/riscv/include/asm/hwcap.h                |    8 +
> > > >  arch/riscv/kernel/cpu.c                       |    2 +
> > > >  arch/riscv/kernel/cpufeature.c                |    2 +
> > > >  drivers/irqchip/Kconfig                       |   32 +-
> > > >  drivers/irqchip/Makefile                      |    2 +
> > > >  drivers/irqchip/irq-riscv-aplic.c             |  656 +++++++++
> > > >  drivers/irqchip/irq-riscv-imsic.c             | 1207 +++++++++++++++++
> > > >  drivers/irqchip/irq-riscv-intc.c              |   37 +-
> > > >  include/linux/irqchip/riscv-aplic.h           |  117 ++
> > > >  include/linux/irqchip/riscv-imsic.h           |   92 ++
> > > >  15 files changed, 2564 insertions(+), 7 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> > > >  create mode 100644 drivers/irqchip/irq-riscv-aplic.c
> > > >  create mode 100644 drivers/irqchip/irq-riscv-imsic.c
> > > >  create mode 100644 include/linux/irqchip/riscv-aplic.h
> > > >  create mode 100644 include/linux/irqchip/riscv-imsic.h
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > I am seeing the following boot failure with your branch and upstream
> > > qemu (tag: v7.2.0-rc0).
> > > It seems IPIs are probably not getting delivered after a point. I saw
> > > that IPIs are delivered in the same path earlier (via gdb).
> > >
> > > [    0.990152] NET: Registered PF_INET6 protocol family
> > > [    1.004885] Segment Routing with IPv6
> > > [    1.005385] In-situ OAM (IOAM) with IPv6
> > > [    1.006371] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> > > [    1.011609] NET: Registered PF_PACKET protocol family
> > > [    1.014877] 9pnet: Installing 9P2000 support
> > > [    1.015603] Key type dns_resolver registered
> > > [    1.026396] debug_vm_pgtable: [debug_vm_pgtable         ]:
> > > Validating architecture page table helpers
> > > [    1.144097] EXT4-fs (vda2): recovery complete
> > > [    1.146345] EXT4-fs (vda2): mounted filesystem with ordered data
> > > mode. Quota mode: disabled.
> > > [    1.147020] VFS: Mounted root (ext4 filesystem) on device 254:2.
> > > [    1.152238] devtmpfs: mounted
> > > [    1.183914] Freeing unused kernel image (initmem) memory: 2176K
> > > [    1.185898] Run /sbin/init as init process
> > > [   29.412287] rcu: INFO: rcu_sched self-detected stall on CPU
> > > [   29.412992] rcu:     3-....: (5250 ticks this GP)
> > > idle=fc3c/1/0x4000000000000002 softirq=78/78 fqs=2230
> > > [   29.413427]  (t=5251 jiffies g=-1047 q=3 ncpus=8)
> > > [   29.414199] CPU: 3 PID: 1 Comm: init Not tainted
> > > 6.1.0-rc4-00024-g5b711f2d7b91 #198
> > > [   29.414578] Hardware name: riscv-virtio,qemu (DT)
> > > [   29.414896] epc : smp_call_function_many_cond+0x138/0x372
> > > [   29.415157]  ra : smp_call_function_many_cond+0x154/0x372
> > > [   29.415318] epc : ffffffff8008d2e6 ra : ffffffff8008d302 sp :
> > > ff2000000004bb40
> > > [   29.415512]  gp : ffffffff812e9eb0 tp : ff600000016d8000 t0 :
> > > ff6000007ed88610
> > > [   29.415686]  t1 : 00000000000000ff t2 : 0000000000000002 s0 :
> > > ff2000000004bc00
> > > [   29.415837]  s1 : ff6000007ed85448 a0 : 0000000000000007 a1 :
> > > 00000000000000f7
> > > [   29.416008]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
> > > ff6000007edd1780
> > > [   29.416188]  a5 : 0000000000000001 a6 : ffffffff812eb1c0 a7 :
> > > ff600000016d8000
> > > [   29.416613]  s2 : ffffffff81323c30 s3 : ffffffff812e9964 s4 :
> > > 0000000000000000
> > > [   29.416810]  s5 : 0000000000000000 s6 : ff6000007ed85440 s7 :
> > > 0000000000000038
> > > [   29.416997]  s8 : 0000000000000003 s9 : ffffffff81323c30 s10:
> > > ff6000007ed85448
> > > [   29.417159]  s11: 0000000000000008 t3 : 00ffffffad08a000 t4 :
> > > ff60000001613e0c
> > > [   29.417331]  t5 : 0000000000000000 t6 : 00ffffffad177fff
> > > [   29.417482] status: 0000000200000120 badaddr: 0000000000000000
> > > cause: 8000000000000005
> > > [   29.417939] [<ffffffff8008d590>] on_each_cpu_cond_mask+0x20/0x32
> > > [   29.418179] [<ffffffff80008d32>] flush_icache_all+0x38/0x40
> > > [   29.418324] [<ffffffff80008eb2>] flush_icache_pte+0x4a/0x7a
> > > [   29.418442] [<ffffffff80139e00>] do_set_pte+0x132/0x192
> > > [   29.418594] [<ffffffff8010b42e>] filemap_map_pages+0x178/0x3a0
> > > [   29.418738] [<ffffffff8013ad00>] __handle_mm_fault+0x992/0xbac
> > > [   29.418876] [<ffffffff8013afde>] handle_mm_fault+0xc4/0x1d4
> > > [   29.419010] [<ffffffff80008372>] do_page_fault+0x120/0x326
> > > [   29.419145] [<ffffffff800033e6>] ret_from_exception+0x0/0xc
> > >
> > >
> >
> > Sorry. I forgot to mention that this happens while booting Fedora on
> > an 8 cpu virt machine.
> > I am yet to reproduce this issue for 4 or 2 cpus.
> >
>
> This warning splat appears with 4 cpus though.
>
> [  126.977213] e1000e 0000:00:02.0 enp0s2: NIC Link is Up 1000 Mbps
> Full Duplex, Flow Control: Rx/Tx
> [  126.988275] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s2: link becomes ready
> [  128.210090] ------------[ cut here ]------------
> [  128.210476] WARNING: CPU: 0 PID: 294 at
> drivers/irqchip/irq-riscv-aplic.c:318 aplic_msi_write_msg+0x110/0x12a
> [  128.211702] Modules linked in:
> [  128.212473] CPU: 0 PID: 294 Comm: (agetty) Not tainted
> 6.1.0-rc4-00024-g5b711f2d7b91 #198
> [  128.212839] Hardware name: riscv-virtio,qemu (DT)
> [  128.213459] epc : aplic_msi_write_msg+0x110/0x12a
> [  128.213652]  ra : aplic_msi_write_msg+0x1c/0x12a
> [  128.213823] epc : ffffffff8039eb80 ra : ffffffff8039ea8c sp :
> ff2000001054bb10
> [  128.213884]  gp : ffffffff812e9eb0 tp : ff600000032d3840 t0 :
> 0000000000000002
> [  128.213945]  t1 : 0000000000000008 t2 : 0000000000000040 s0 :
> ff2000001054bb30
> [  128.214015]  s1 : ff600000018443a8 a0 : ff600000017e8c30 a1 :
> 0000000000000000
> [  128.214083]  a2 : 0000000000000001 a3 : 000000000000000c a4 :
> 0000000000000003
> [  128.214141]  a5 : 0000000000000000 a6 : 0000000000000000 a7 :
> 0000000000000000
> [  128.214173]  s2 : ff2000001054bb40 s3 : ff600000017e8c30 s4 :
> 0000000200000022
> [  128.214246]  s5 : ff600000017e8d78 s6 : 000000000000000c s7 :
> ff600000017e8cb0
> [  128.214295]  s8 : ffffffff80c5c8f0 s9 : ff6000000e97ab60 s10:
> 0000000000000000
> [  128.214327]  s11: ff6000000e97ab78 t3 : 0000000000000004 t4 :
> 0000000000000002
> [  128.214383]  t5 : 0000000000000000 t6 : 0000000000028000
> [  128.214414] status: 0000000200000100 badaddr: 0000000000000000
> cause: 0000000000000003
> [  128.215267] [<ffffffff80453060>] platform_msi_write_msg+0x18/0x20
> [  128.215413] [<ffffffff80060b7a>] msi_domain_deactivate+0x2a/0x48
> [  128.215432] [<ffffffff8005e5a2>] __irq_domain_deactivate_irq+0x1c/0x30
> [  128.215450] [<ffffffff8005e5aa>] __irq_domain_deactivate_irq+0x24/0x30
> [  128.215464] [<ffffffff8005f9ea>] irq_domain_deactivate_irq+0x1c/0x30
> [  128.215477] [<ffffffff8005b8f6>] free_irq+0x1d0/0x27c
> [  128.219393] [<ffffffff8041be06>] univ8250_release_irq+0xa4/0xaa
> [  128.219417] [<ffffffff8041e018>] serial8250_do_shutdown+0xf0/0x166
> [  128.219431] [<ffffffff8041e0a8>] serial8250_shutdown+0x1a/0x22
> [  128.219444] [<ffffffff804174f0>] uart_port_shutdown+0x2c/0x42
> [  128.220230] [<ffffffff8041908a>] uart_shutdown+0x66/0x11e
> [  128.220247] [<ffffffff8041a69a>] uart_hangup+0x5e/0x100
> [  128.220260] [<ffffffff803fdaa2>] __tty_hangup.part.0+0x286/0x2ac
> [  128.220859] [<ffffffff803fec6c>] tty_ioctl+0x684/0x802
> [  128.220875] [<ffffffff8019ec48>] sys_ioctl+0x37e/0x95e
> [  128.221284] [<ffffffff800033d8>] ret_from_syscall+0x0/0x2
> [  128.221653] ---[ end trace 0000000000000000 ]---

I will address this in v2 of the AIA series.

Regards,
Anup

>
>
> > >
> > > --
> > > Regards,
> > > Atish
> >
> >
> >
> > --
> > Regards,
> > Atish
>
>
>
> --
> Regards,
> Atish
