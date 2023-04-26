Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC76EF140
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjDZJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbjDZJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:35:13 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 021E7E7;
        Wed, 26 Apr 2023 02:35:10 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1prbYL-0003H5-00; Wed, 26 Apr 2023 11:35:09 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C4D12C02AE; Wed, 26 Apr 2023 11:35:00 +0200 (CEST)
Date:   Wed, 26 Apr 2023 11:35:00 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.4
Message-ID: <20230426093500.GA6891@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.4

for you to fetch changes up to 46e614cc91f7bd6f7872e434e6bcfda44454aac3:

  MIPS: uprobes: Restore thread.trap_nr (2023-04-24 13:31:44 +0200)

----------------------------------------------------------------
- added support for Huawei B593u-12
- added support for virt board aligned to QEMU MIPS virt board
- added support for doing DMA coherence on a per device base
- reworked handling of RALINK SoCs
- cleanup for Loongon64 barriers
- removed deprecated support for MIPS_CMP SMP handling method
- removed support Sibyte CARMEL and CHRINE boards
- cleanups and fixes

----------------------------------------------------------------
Aleksander Jan Bajkowski (1):
      MIPS: lantiq: remove unused function declaration

Henry Willard (1):
      MIPS: Don't clear _PAGE_SPECIAL in _PAGE_CHG_MASK

Jiaxun Yang (23):
      MIPS: Loongson64: Prefix ipi register address pointers with __iomem
      MIPS: Loongson64: smp: Use nudge_writes instead of wbflush
      MIPS: Loongson64: smp: Correct nudge_writes usage
      MIPS: Loongson64: Remove CPU_HAS_WB
      MIPS: Loongson64: Opt-out war_io_reorder_wmb
      MIPS: Always select ARCH_HAS_SETUP_DMA_OPS
      MIPS: Always select ARCH_HAS_SYNC_DMA_FOR_CPU for noncoherent platforms
      MIPS: c-r4k: Always install dma flush functions
      MIPS: Move declaration of bcache ops to cache.c
      MIPS: smp-cps: Disable coherence setup for unsupported ISA
      MIPS: mips-cm: Check availability of config registers
      MIPS: Octeon: Opt-out 4k_cache feature
      MIPS: cpu-features: Enable octeon_cache by cpu_type
      MIPS: c-octeon: Provide alternative SMP cache flush function
      MIPS: Octeon: Allow CVMSEG to be disabled
      MIPS: Loongson: Move arch cflags to MIPS top level Makefile
      MIPS: Loongson: Don't select platform features with CPU
      MIPS: Octeon: Disable CVMSEG by default on other platforms
      MIPS: Add board config for virt board
      MIPS: generic: Enable all CPUs supported by virt board in Kconfig
      MIPS: fw: Allow firmware to pass a empty env
      MIPS: loongson2ef: Add missing break in cs5536_isa
      MIPS: octeon_switch: Remove duplicated labels

Keguang Zhang (1):
      dt-bindings: mips: loongson: Add Loongson-1 based boards

Lukas Bulwahn (2):
      MIPS: ath79: remove obsolete ATH79_DEV_* configs
      mips: Remove obsolete configs IRQ_MSP_CIC and IRQ_MSP_SLP

Nathan Chancellor (3):
      MIPS: Drop unused positional parameter in local_irq_{dis,en}able
      MIPS: Mark check_bugs() as __init
      MIPS: Sink body of check_bugs_early() into its only call site

Rafał Miłecki (1):
      MIPS: BCM47XX: Add support for Huawei B593u-12

Rob Herring (2):
      mips: Use of_property_read_bool() for boolean properties
      MIPS: octeon: Use of_address_to_resource()

Sergio Paracuellos (12):
      mips: ralink: rt305x: define RT305X_SYSC_BASE with __iomem
      mips: ralink: rt305x: soc queries and tests as functions
      mips: ralink: rt305x: introduce 'soc_device' initialization
      mips: ralink: rt3883: define RT3883_SYSC_BASE with __iomem
      mips: ralink: rt3883: soc queries and tests as functions
      mips: ralink: rt3883: introduce 'soc_device' initialization
      mips: ralink: rt288x: define RT2880_SYSC_BASE with __iomem
      mips: ralink: rt288x: soc queries and tests as functions
      mips: ralink: rt288x: introduce 'soc_device' initialization
      mips: ralink: mt7620: define MT7620_SYSC_BASE with __iomem
      mips: ralink: mt7620: soc queries and tests as functions
      mips: ralink: mt7620: introduce 'soc_device' initialization

Thomas Bogendoerfer (10):
      MIPS: sibyte: remove no longer needed board_mem_region
      MIPS: sibyte: Remove unused config option SIBYTE_BCM1x55
      MIPS: sibyte: Remove Sibyte CARMEL and CRHINE board support
      MIPS: sibyte: Replace BCM1125H with SB1250 option
      MIPS: octeon: Fix compile error
      MIPS: mm: Remove unused *cache_page_indexed flush functions
      MIPS: Remove no longer used ide.h
      MIPS: mm: Remove local_cache_flush_page
      MIPS: Remove deprecated CONFIG_MIPS_CMP
      Revert "MIPS: generic: Enable all CPUs supported by virt board in Kconfig"

Tiezhu Yang (3):
      MIPS: Use def_bool y for ARCH_SUPPORTS_UPROBES
      MIPS: Remove set_swbp() in uprobes.c
      MIPS: uprobes: Restore thread.trap_nr

 .../devicetree/bindings/mips/loongson/devices.yaml |  12 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/mips/Kbuild.platforms                         |   1 -
 arch/mips/Kconfig                                  |  77 +--------
 arch/mips/Makefile                                 |  38 +++++
 arch/mips/ath79/Kconfig                            |  16 --
 arch/mips/bcm47xx/board.c                          |   1 +
 arch/mips/bcm47xx/leds.c                           |   8 +
 arch/mips/cavium-octeon/Kconfig                    |   3 +-
 arch/mips/cavium-octeon/octeon-irq.c               |  35 ++--
 arch/mips/configs/generic/board-virt.config        |  38 +++++
 arch/mips/fw/lib/cmdline.c                         |   2 +-
 arch/mips/include/asm/asmmacro.h                   |   4 +-
 arch/mips/include/asm/bugs.h                       |   8 +-
 arch/mips/include/asm/cache.h                      |   2 +
 arch/mips/include/asm/cacheflush.h                 |   1 -
 arch/mips/include/asm/cpu-features.h               |  21 ++-
 arch/mips/include/asm/ide.h                        |  13 --
 arch/mips/include/asm/io.h                         |   2 +-
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |   1 +
 arch/mips/include/asm/mach-generic/ide.h           | 138 ----------------
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |   3 -
 arch/mips/include/asm/mach-ralink/mt7620.h         |   3 +-
 arch/mips/include/asm/mach-ralink/rt288x.h         |   3 +-
 arch/mips/include/asm/mach-ralink/rt305x.h         |   3 +-
 arch/mips/include/asm/mach-ralink/rt3883.h         |   4 +-
 arch/mips/include/asm/pgtable-bits.h               |   3 +-
 arch/mips/include/asm/processor.h                  |   7 +-
 arch/mips/include/asm/rtlx.h                       |   1 -
 arch/mips/include/asm/sibyte/board.h               |   6 +-
 arch/mips/include/asm/sibyte/carmel.h              |  45 ------
 arch/mips/include/asm/sibyte/swarm.h               |   5 -
 arch/mips/include/asm/smp-ops.h                    |  16 --
 arch/mips/include/asm/vpe.h                        |   4 -
 arch/mips/kernel/Makefile                          |   3 -
 arch/mips/kernel/asm-offsets.c                     |   3 +
 arch/mips/kernel/cps-vec.S                         |   5 +
 arch/mips/kernel/cpu-probe.c                       |   2 +
 arch/mips/kernel/mips-cm.c                         |   9 +-
 arch/mips/kernel/octeon_switch.S                   |   6 -
 arch/mips/kernel/rtlx-cmp.c                        | 122 --------------
 arch/mips/kernel/setup.c                           |   3 +-
 arch/mips/kernel/smp-cmp.c                         | 148 -----------------
 arch/mips/kernel/smp-cps.c                         |   5 +
 arch/mips/kernel/uprobes.c                         |  19 +--
 arch/mips/kernel/vpe-cmp.c                         | 180 ---------------------
 arch/mips/kernel/vpe.c                             |   2 +-
 arch/mips/loongson2ef/Kconfig                      |   3 +
 arch/mips/loongson2ef/Platform                     |  35 ----
 arch/mips/loongson2ef/common/cs5536/cs5536_isa.c   |   2 +-
 arch/mips/loongson64/Platform                      |  16 --
 arch/mips/loongson64/setup.c                       |  15 --
 arch/mips/loongson64/smp.c                         |  50 +++---
 arch/mips/mm/c-octeon.c                            |   5 +
 arch/mips/mm/c-r3k.c                               |   5 -
 arch/mips/mm/c-r4k.c                               | 129 +--------------
 arch/mips/mm/cache.c                               |  21 ++-
 arch/mips/mti-malta/Makefile                       |   2 -
 arch/mips/mti-malta/malta-amon.c                   |  88 ----------
 arch/mips/mti-malta/malta-init.c                   |   2 -
 arch/mips/mti-malta/malta-platform.c               |   2 -
 arch/mips/pci/pci-lantiq.c                         |   2 +-
 arch/mips/pci/pci-rt3883.c                         |   2 +-
 arch/mips/ralink/Kconfig                           |   4 +
 arch/mips/ralink/mt7620.c                          | 145 ++++++++++++++---
 arch/mips/ralink/mt7621.c                          |   2 -
 arch/mips/ralink/rt288x.c                          |  94 +++++++++--
 arch/mips/ralink/rt305x.c                          | 147 ++++++++++++++---
 arch/mips/ralink/rt3883.c                          |  94 +++++++++--
 arch/mips/sibyte/Kconfig                           |  33 +---
 arch/mips/sibyte/Makefile                          |   6 -
 arch/mips/sibyte/Platform                          |   8 -
 arch/mips/sibyte/common/bus_watcher.c              |   4 +-
 arch/mips/sibyte/common/cfe.c                      |  17 +-
 arch/mips/sibyte/common/sb_tbprof.c                |  10 +-
 arch/mips/sibyte/swarm/setup.c                     |  12 +-
 drivers/irqchip/irq-mips-gic.c                     |  26 ---
 77 files changed, 657 insertions(+), 1357 deletions(-)
 create mode 100644 arch/mips/configs/generic/board-virt.config
 delete mode 100644 arch/mips/include/asm/ide.h
 delete mode 100644 arch/mips/include/asm/mach-generic/ide.h
 delete mode 100644 arch/mips/include/asm/sibyte/carmel.h
 delete mode 100644 arch/mips/kernel/rtlx-cmp.c
 delete mode 100644 arch/mips/kernel/smp-cmp.c
 delete mode 100644 arch/mips/kernel/vpe-cmp.c
 delete mode 100644 arch/mips/mti-malta/malta-amon.c

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
