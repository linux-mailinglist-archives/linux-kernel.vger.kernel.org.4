Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4F64CF88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiLNSkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiLNSkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:40:09 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCC1E6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:40:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 65so5080714pfx.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28v+Usm1lZe3hhqKtgjE2II+AFu+GpCD77DgUFeOlTo=;
        b=uj2KhMW5T9Y8LymkemgmORUk4ErSPJC7zYT17cudI++S9qmLQiqnl/odKzLqIyIUEe
         mgJIkczhK90wcXNCxBA2VItbHP2Yk+CwxkYyYNPccYafV1OZhbv3yffJFJDluFHtXqhH
         TnrXyPgltxFoiOdTJXUhXoYaLdnuF3Nb+NTotp53C45rwk36P1Ql7bHXg4LXHkv8k3Vq
         Zw7EOtV1e7E3PzOSgOWVht9ecO51OyEW5JyGV1iMP263N3N2+77T05EgvMoVKUPGGv8M
         E/oSwcQGKCuDnznbpZD0QUkDfycXcZ/68S6RJtJ5Lbm0WcH8B5h14bu9VUOeDFyuZ5JG
         sM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28v+Usm1lZe3hhqKtgjE2II+AFu+GpCD77DgUFeOlTo=;
        b=aGvss1WA/FKZya9HmCMP7n3V6gCP3EvfAOCjqQ9oghoDZfqC4oCj2AbqqObOjAPGqT
         9wSyqt0yT9Wf2vGhhW2IXiVTdrrJXl2UvA9V+n5dyWlRvFvaIRxjxSaKTmZaGF98qt88
         k6bw58tTwy0uITj+mMSd5SuL6jKStx8rrZyt7xS4lPNsyMnc0L6ySDTTXjgtM5vYmcWe
         F0OD6L+J31wiRzWWaGD7a3VucobhDDXHVKicuUJEw35ob0/Cg3RDyqUn1FG7OhRLknFS
         3XUN5mJEqUMndlhC0jgivQAnrGN04nttrxLqepDuD8jDo3cqIZGv3GJB3hWKCBLENvua
         /ExA==
X-Gm-Message-State: ANoB5pl8J5SdXJ8j7+6RbsSlPvnXRh+IxfxENhoBfhr6xCL/erBfV5sY
        khyXF2Netjlmi6yJ+m7td7FwVpdFaukQiiMN
X-Google-Smtp-Source: AA0mqf6LQd3O6KXpgz/F2rAfxr3r/Fp9AsCwkHSPl82E/frKyC+4pwLiX+ImCYPqlwzLlDXzri4xbg==
X-Received: by 2002:a62:17cf:0:b0:577:50c4:6dbe with SMTP id 198-20020a6217cf000000b0057750c46dbemr25180361pfx.4.1671043206751;
        Wed, 14 Dec 2022 10:40:06 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id q8-20020aa78428000000b0057627521e82sm168876pfn.195.2022.12.14.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:40:05 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:40:05 -0800 (PST)
X-Google-Original-Date: Wed, 14 Dec 2022 10:39:59 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 6.2 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f76eb33c-7cc1-426f-8f29-37f6bb78baec@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-mw1

for you to fetch changes up to 6e66e96e31b81fb08075d18a3e2c201f1e2171da:

  Merge patch series "Documentation: RISC-V: patch-acceptance changes" (2022-12-13 09:38:30 -0800)

----------------------------------------------------------------
RISC-V Patches for the 6.2 Merge Window, Part 1

* Support for the T-Head PMU via the perf subsystem.
* ftrace support for rv32.
* Support for non-volatile memory devices.
* Various fixes and cleanups.

----------------------------------------------------------------
I didn't have a part 2 planned, but I just stumbled into a build issue with
the Arm LPAE IOMMU being enabled on rv32, which is worked around via
https://lore.kernel.org/r/20221214180409.7354-1-palmer@rivosinc.com/ .
Anything would be a fix, though, as I'm essentially pretending we're in RCs
aside from what's here.

I've sent the diffstat against v6.1-rc1, as targeting a recent master produces
something huge (though still a reasonable shortlog).  I'm not entirely sure
what's going on there: I have some old merge bases (due to old patch sets) so
hopefully that's the problem, but it's also my first time seriously using b4 so
sorry if I've screwed something up.  The only intentionally suspect thing I've
done is include 5c20a3a9df19 ("RISC-V: Fix compilation without
RISCV_ISA_ZICBOM") as it fixes a build issue in the following patch set and
didn't land via the usual flow, but I think that's the cleanest way to do it as
the patch was already directly on top of rc1.

I'm seeing one merge conflict, here's my resolution if it helps any:

@@@ -161,7 -161,7 +163,8 @@@ CONFIG_VIRTIO_MMIO=
  CONFIG_RPMSG_CHAR=y
  CONFIG_RPMSG_CTRL=y
  CONFIG_RPMSG_VIRTIO=y
 +CONFIG_LIBNVDIMM=y
+ CONFIG_ARCH_R9A07G043=y
  CONFIG_EXT4_FS=y
  CONFIG_EXT4_FS_POSIX_ACL=y
  CONFIG_EXT4_FS_SECURITY=y

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix P4D_SHIFT definition for 3-level page table mode

Andrew Bresticker (1):
      RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path

Andrew Jones (9):
      RISC-V: Fix compilation without RISCV_ISA_ZICBOM
      riscv: Don't duplicate __ALTERNATIVE_CFG in __ALTERNATIVE_CFG_2
      riscv: alternatives: Don't name unused macro parameters
      riscv: alternatives: Drop the underscores from the assembly macro names
      riscv: Don't duplicate _ALTERNATIVE_CFG* macros
      RISC-V: Improve use of isa2hwcap[]
      RISC-V: Introduce riscv_isa_extension_check
      RISC-V: Ensure Zicbom has a valid block size
      riscv: Apply a static assert to riscv_isa_ext_id

Anup Patel (3):
      RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
      RISC-V: Implement arch specific PMEM APIs
      RISC-V: Enable PMEM drivers

Binglei Wang (1):
      riscv: add riscv rethook implementation

Cleo John (1):
      riscv: fix styling in ucontext header

Conor Dooley (4):
      RISC-V: enable sparsemem by default for defconfig
      irqchip/sifive-plic: remove user selectability of SIFIVE_PLIC
      irqchip/riscv-intc: remove user selectability of RISCV_INTC
      RISC-V: stop selecting SIFIVE_PLIC at the SoC level

Guo Ren (3):
      riscv: stacktrace: Fixup ftrace_graph_ret_addr retp argument
      riscv: stacktrace: Make walk_stackframe cross pt_regs frame
      riscv: Fixup compile error with !MMU

Hal Feng (1):
      RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW

Heiko Stuebner (2):
      RISC-V: Cache SBI vendor values
      drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores

Heinrich Schuchardt (1):
      riscv/vdso: typo therefor

Jamie Iles (4):
      RISC-V: use REG_S/REG_L for mcount
      RISC-V: reduce mcount save space on RV32
      RISC-V: preserve a1 in mcount
      RISC-V: enable dynamic ftrace for RV32I

Jinyu Tang (1):
      riscv: support update_mmu_tlb()

Jisheng Zhang (3):
      riscv: remove special treatment for the link order of head.o
      riscv: fix race when vmap stack overflow
      riscv: boot: add zstd support

Lad Prabhakar (1):
      riscv: Kconfig: Enable cpufreq kconfig menu

Li Huafei (2):
      RISC-V: kexec: Fix memory leak of fdt buffer
      RISC-V: kexec: Fix memory leak of elf header buffer

Liu Shixin (2):
      riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
      riscv: Enable HAVE_ARCH_HUGE_VMALLOC for 64BIT

Palmer Dabbelt (17):
      riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
      Merge patch series "RISC-V: Dynamic ftrace support for RV32I"
      Merge patch series "Support VMCOREINFO export for RISCV64"
      Merge patch "RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path"
      Merge patch series "Add PMEM support for RISC-V"
      Merge patch series "RISC-V interrupt controller select cleanup"
      Merge patch series "riscv: Fix crash during early errata patching"
      Merge patch series "RISC-V: Ensure Zicbom has a valid block size"
      Merge patch series "riscv: alternative-macros.h cleanups"
      RISC-V: Align the shadow stack
      RISC-V: Add some comments about the shadow and overflow stacks
      Merge patch series "RISC-V: Align the shadow stack"
      Documentation: RISC-V: Fix a typo in patch-acceptance
      Documentation: RISC-V: Allow patches for non-standard behavior
      Documentation: RISC-V: Mention the UEFI Standards
      Documentation: RISC-V: patch-acceptance: s/implementor/implementer
      Merge patch series "Documentation: RISC-V: patch-acceptance changes"

Qinglin Pan (1):
      riscv: mm: call best_map_size many times during linear-mapping

Samuel Holland (2):
      riscv: Fix crash during early errata patching
      riscv: Move cast inside kernel_mapping_[pv]a_to_[vp]a

Sergey Matyukevich (1):
      riscv: mm: notify remote harts about mmu cache updates

Tong Tiangen (2):
      riscv/mm: hugepage's PG_dcache_clean flag is only set in head page
      riscv/mm: add arch hook arch_clear_hugepage_flags

Xianting Tian (2):
      RISC-V: Add arch_crash_save_vmcoreinfo support
      Documentation: kdump: describe VMCOREINFO export for RISCV64

 Documentation/admin-guide/kdump/vmcoreinfo.rst     | 29 +++++++
 .../features/vm/huge-vmap/arch-support.txt         |  2 +-
 Documentation/riscv/patch-acceptance.rst           | 22 +++--
 arch/riscv/Kconfig                                 | 19 +++--
 arch/riscv/Kconfig.erratas                         | 13 +++
 arch/riscv/Kconfig.socs                            |  5 --
 arch/riscv/boot/Makefile                           |  3 +
 arch/riscv/configs/defconfig                       |  3 +
 arch/riscv/errata/thead/errata.c                   | 19 +++++
 arch/riscv/include/asm/alternative-macros.h        | 99 +++++++---------------
 arch/riscv/include/asm/asm.h                       |  1 +
 arch/riscv/include/asm/cacheflush.h                | 15 ++--
 arch/riscv/include/asm/errata_list.h               | 16 +++-
 arch/riscv/include/asm/hugetlb.h                   |  6 ++
 arch/riscv/include/asm/hwcap.h                     |  3 +-
 arch/riscv/include/asm/io.h                        |  5 ++
 arch/riscv/include/asm/kexec.h                     |  5 ++
 arch/riscv/include/asm/kprobes.h                   |  2 -
 arch/riscv/include/asm/mmu.h                       |  2 +
 arch/riscv/include/asm/page.h                      | 18 ++--
 arch/riscv/include/asm/pgtable-64.h                |  6 +-
 arch/riscv/include/asm/pgtable.h                   |  5 +-
 arch/riscv/include/asm/sbi.h                       |  5 ++
 arch/riscv/include/asm/tlbflush.h                  | 18 ++++
 arch/riscv/include/asm/vdso.h                      |  2 +-
 arch/riscv/include/asm/vmalloc.h                   | 18 ++++
 arch/riscv/include/uapi/asm/ucontext.h             | 12 ++-
 arch/riscv/kernel/Makefile                         |  1 +
 arch/riscv/kernel/cpu.c                            | 30 ++++++-
 arch/riscv/kernel/cpufeature.c                     | 43 +++++++---
 arch/riscv/kernel/crash_core.c                     | 21 +++++
 arch/riscv/kernel/elf_kexec.c                      | 14 +++
 arch/riscv/kernel/entry.S                          | 34 +++++---
 arch/riscv/kernel/mcount.S                         | 44 +++++-----
 arch/riscv/kernel/probes/Makefile                  |  2 +-
 arch/riscv/kernel/probes/kprobes.c                 | 13 ---
 arch/riscv/kernel/probes/rethook.c                 | 27 ++++++
 arch/riscv/kernel/probes/rethook.h                 |  8 ++
 .../{kprobes_trampoline.S => rethook_trampoline.S} |  6 +-
 arch/riscv/kernel/signal.c                         | 34 +++++---
 arch/riscv/kernel/stacktrace.c                     | 11 ++-
 arch/riscv/kernel/traps.c                          | 30 ++++++-
 arch/riscv/mm/Makefile                             |  2 +
 arch/riscv/mm/cacheflush.c                         | 45 ++++++++++
 arch/riscv/mm/context.c                            | 10 +++
 arch/riscv/mm/dma-noncoherent.c                    | 41 ---------
 arch/riscv/mm/init.c                               | 25 +++---
 arch/riscv/mm/pgtable.c                            | 83 ++++++++++++++++++
 arch/riscv/mm/physaddr.c                           |  2 +-
 arch/riscv/mm/pmem.c                               | 21 +++++
 arch/riscv/mm/tlbflush.c                           | 28 +++---
 drivers/irqchip/Kconfig                            | 21 +----
 drivers/perf/riscv_pmu_sbi.c                       | 34 +++++---
 scripts/head-object-list.txt                       |  1 -
 54 files changed, 684 insertions(+), 300 deletions(-)
 create mode 100644 arch/riscv/kernel/crash_core.c
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook.h
 rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)
 create mode 100644 arch/riscv/mm/pgtable.c
 create mode 100644 arch/riscv/mm/pmem.c
