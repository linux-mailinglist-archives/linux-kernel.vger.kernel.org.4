Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1975FF252
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiJNQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiJNQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:35:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D843EA5B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:35:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h10so5251976plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtNNlXIYPSXjux0nsb6BrW6Ap/y15OPYKh7ad1Ei0iY=;
        b=y1GEA5glgSmw7Knc4lyosZI8DK/GpwKkRnfTvqWTVxA5z8EEmlXE2oILkB5pRd2oAU
         AbIbegTyzoO4q5ab60BEvnfxXwfZasMb9cIER0JY1EoH0PpEefqBItQVNEZlj1zjHh5m
         OmoFlCI+tmyWJFeMoJYw984IwDezCFtjPYkRQ1b9xeZ5fnN+uNivuJhXjNxThV05TeiN
         UaIB0QCFnPgSyGLVKhE+uDouljTcX3tJoly0nsk0kVIqS/7Rn1Uz0SWWPcVlKah+YFyD
         fJDn9c6A+yar88l1JtvRFZqBsL0HmY8xx2Lb2uew6vNxgimkVIdOHnAYEaBgeM6kfPAn
         H1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtNNlXIYPSXjux0nsb6BrW6Ap/y15OPYKh7ad1Ei0iY=;
        b=r8Iv1bUzCwguVpbY9JI9QCn18Q9En/UA/i8fV+SugfbBYQJyuvJ6+8Ltx49MMjcRqQ
         MUnnrj2hJMChu3Wm4A7h+3cUmBP1czaEZiAoF5b6oKoEdObMxGQBHxemoMmHpzzVXcO5
         wUZjBnHGn8rNwTbdWTCc0hYxEbhDookgkNFoBLsbLdtmF8l2w7xROhab4eDBD2orjbUi
         YZGlj/hrnnkA11qFYG/+IHCKK+XEd8h8ZLxIGu7vK2v8rMjR/h6ITGK4epun/a6i8tkV
         K20bZDYsbnQswr176K0XRyZ2I76/ZvYsUr3KuS6+Vr2Ln96YG4aEk5LjtWUiOdTAaF1M
         HvJg==
X-Gm-Message-State: ACrzQf0JjZijO/RUUjx2ABP2PBBjn2rXDk09+TGdZAgl0GZLNjNWVL9e
        03KYkIOdX3cFQlatZeq3mVHOaQ==
X-Google-Smtp-Source: AMsMyM7FBw8mwa8fq17nDE+rgVfpgfRNd4OS38L7ss+G07KE4qRD6dXuSxcHedQWYdGBYqYL9KimFQ==
X-Received: by 2002:a17:902:ced1:b0:184:ba6e:8c3b with SMTP id d17-20020a170902ced100b00184ba6e8c3bmr6174984plg.160.1665765344118;
        Fri, 14 Oct 2022 09:35:44 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b0017e64da44c5sm1964522plg.203.2022.10.14.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:35:43 -0700 (PDT)
Date:   Fri, 14 Oct 2022 09:35:43 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Oct 2022 09:35:42 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.1 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-569ea3ca-5e4e-4339-b3fa-84723ba9ca77@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-6.1-mw1'
The following changes since commit 2e64066dab157ffcd0e9ec2ff631862e6e222876:

  Merge tag 'riscv-for-linus-6.1-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2022-10-09 13:24:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-mw2

for you to fetch changes up to ab0c23b535f3f9d8345d8ad4c18c0a8594459d55:

  MAINTAINERS: add RISC-V's patchwork (2022-10-13 16:35:25 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.1 Merge Window, Part 2

* A handful of DT updates for the PolarFire SOC.
* A fix to correct the handling of write-only mappings.
* m{vetndor,arcd,imp}id is now in /proc/cpuinfo
* The SiFive L2 cache controller support has been refactored to also
  support L3 caches.

There's also a handful of fixes, cleanups and improvements throughout
the tree.

----------------------------------------------------------------
We still have these kasan/pcpu_alloc panics, but by all appearances the bug has
been around for a while so it's not the fault of any of these (even if it just
started manifesting very often for me in the middle of the merge window).  I've
got that and a build fix for drm/amd/display in my test trees, but otherwise
things seem clean on my end.

I've got one merge conflict with a master from last night, just a pair of
cleanups that happened to run into each other.  Here's my resolution if it
helps any:

diff --cc arch/riscv/kernel/vdso.c
index 4abc9aebdfae,692e7ae3dcb8..123d05255fcf
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@@ -119,18 -114,16 +119,19 @@@ int vdso_join_timens(struct task_struc
  {
        struct mm_struct *mm = task->mm;
        struct vm_area_struct *vma;
+       VMA_ITERATOR(vmi, mm, 0);
 -      struct __vdso_info *vdso_info = mm->context.vdso_info;

        mmap_read_lock(mm);

-       for (vma = mm->mmap; vma; vma = vma->vm_next) {
+       for_each_vma(vmi, vma) {
                unsigned long size = vma->vm_end - vma->vm_start;

 -              if (vma_is_special_mapping(vma, vdso_info->dm))
 +              if (vma_is_special_mapping(vma, vdso_info.dm))
                        zap_page_range(vma, vma->vm_start, size);
 +#ifdef CONFIG_COMPAT
 +              if (vma_is_special_mapping(vma, compat_vdso_info.dm))
 +                      zap_page_range(vma, vma->vm_start, size);
 +#endif
        }

        mmap_read_unlock(mm);

Sorry it's another big one late in the merge window, I'm trying to not do that
but things keep slipping.

----------------------------------------------------------------
Andrew Bresticker (2):
      riscv: Make VM_WRITE imply VM_READ
      riscv: Allow PROT_WRITE-only mmap()

Anup Patel (1):
      RISC-V: Add mvendorid, marchid, and mimpid to /proc/cpuinfo output

Ben Dooks (2):
      soc: sifive: ccache: reduce printing on init
      soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes

Conor Dooley (18):
      riscv: dts: microchip: add qspi compatible fallback
      dt-bindings: riscv: microchip: document icicle reference design
      dt-bindings: riscv: microchip: document the aries m100pfsevp
      riscv: dts: microchip: add pci dma ranges for the icicle kit
      riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi
      riscv: dts: microchip: icicle: update pci address properties
      riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
      riscv: dts: microchip: reduce the fic3 clock rate
      riscv: dts: microchip: add a devicetree for aries' m100pfsevp
      riscv: dts: microchip: update memory configuration for v2022.10
      riscv: dts: microchip: fix fabric i2c reg size
      MAINTAINERS: update polarfire soc clock binding
      dt-bindings: riscv: update microchip.yaml's maintainership
      dt-bindings: timer: sifive,clint: add legacy riscv compatible
      dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
      dt-bindings: riscv: add new riscv,isa strings for emulators
      riscv: enable software resend of irqs
      MAINTAINERS: add RISC-V's patchwork

Fangrui Song (1):
      riscv: Pass -mno-relax only on lld < 15.0.0

Greentime Hu (2):
      soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
      riscv: Add cache information in AUX vector

Heiko Stuebner (5):
      riscv: cleanup svpbmt cpufeature probing
      riscv: drop some idefs from CMO initialization
      riscv: use BIT() macros in t-head errata init
      riscv: use BIT() marco for cpufeature probing
      riscv: check for kernel config option in t-head memory types errata

Jisheng Zhang (1):
      riscv: vdso: fix NULL deference in vdso_join_timens() when vfork

Maciej W. Rozycki (1):
      RISC-V: Make port I/O string accessors actually work

Palmer Dabbelt (9):
      doc: RISC-V: Document that misaligned accesses are supported
      Merge tag 'dt-for-palmer-v6.1-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into for-next
      Merge patch series "Fix dt-validate issues on qemu dtbdumps due to dt-bindings"
      RISC-V: Avoid dereferening NULL regs in die()
      Merge patch series "Some style cleanups for recent extension additions"
      Merge patch series "Use composable cache instead of L2 cache"
      RISC-V: Re-enable counter access from userspace
      RISC-V: Make mmap() with PROT_WRITE imply PROT_READ
      RISC-V: Add mvendorid, marchid, and mimpid to /proc/cpuinfo output

Shravan Chippa (1):
      dt-bindings: riscv: microchip: document the sev kit

Vattipalli Praveen (1):
      riscv: dts: microchip: add sevkit device tree

Wenting Zhang (1):
      riscv: always honor the CONFIG_CMDLINE_FORCE when parsing dtb

Zong Li (3):
      dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
      soc: sifive: ccache: determine the cache level from dts
      soc: sifive: ccache: define the macro for the register shifts

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   5 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   5 +-
 .../devicetree/bindings/riscv/microchip.yaml       |  24 +-
 .../{sifive-l2-cache.yaml => sifive,ccache0.yaml}  |  28 ++-
 .../devicetree/bindings/timer/sifive,clint.yaml    |  18 +-
 Documentation/riscv/index.rst                      |   1 +
 Documentation/riscv/uabi.rst                       |   6 +
 MAINTAINERS                                        |   4 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/Makefile                                |   2 +
 arch/riscv/boot/dts/microchip/Makefile             |   2 +
 .../boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi |  43 +++-
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts  |  18 +-
 .../boot/dts/microchip/mpfs-m100pfs-fabric.dtsi    |  45 ++++
 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts  | 179 +++++++++++++++
 .../boot/dts/microchip/mpfs-polarberry-fabric.dtsi |  29 +++
 .../boot/dts/microchip/mpfs-sev-kit-fabric.dtsi    |  45 ++++
 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts     | 145 ++++++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi            |  31 +--
 arch/riscv/errata/thead/errata.c                   |  14 +-
 arch/riscv/include/asm/cacheflush.h                |   2 +
 arch/riscv/include/asm/elf.h                       |   4 +
 arch/riscv/include/asm/io.h                        |  16 +-
 arch/riscv/include/asm/mmu.h                       |   1 -
 arch/riscv/include/uapi/asm/auxvec.h               |   4 +-
 arch/riscv/kernel/cpu.c                            |  51 +++++
 arch/riscv/kernel/cpufeature.c                     |  39 ++--
 arch/riscv/kernel/setup.c                          |   4 +-
 arch/riscv/kernel/sys_riscv.c                      |   3 -
 arch/riscv/kernel/traps.c                          |   9 +-
 arch/riscv/kernel/vdso.c                           |  13 +-
 arch/riscv/mm/fault.c                              |   3 +-
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/sifive_edac.c                         |  12 +-
 drivers/perf/riscv_pmu_sbi.c                       |   7 +-
 drivers/soc/sifive/Kconfig                         |   6 +-
 drivers/soc/sifive/Makefile                        |   2 +-
 drivers/soc/sifive/sifive_ccache.c                 | 255 +++++++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c               | 237 -------------------
 include/soc/sifive/sifive_ccache.h                 |  16 ++
 include/soc/sifive/sifive_l2_cache.h               |  16 --
 41 files changed, 968 insertions(+), 379 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
 create mode 100644 Documentation/riscv/uabi.rst
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
 create mode 100644 drivers/soc/sifive/sifive_ccache.c
 delete mode 100644 drivers/soc/sifive/sifive_l2_cache.c
 create mode 100644 include/soc/sifive/sifive_ccache.h
 delete mode 100644 include/soc/sifive/sifive_l2_cache.h
