Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7957410A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF1MCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:02:12 -0400
Received: from elvis.franken.de ([193.175.24.41]:45244 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbjF1MCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:02:10 -0400
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qETs8-0001nL-00; Wed, 28 Jun 2023 14:02:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C1436C02FD; Wed, 28 Jun 2023 14:02:01 +0200 (CEST)
Date:   Wed, 28 Jun 2023 14:02:01 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.5
Message-ID: <20230628120201.GA10364@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

there will be small conflict with the slab tree. Resolution is to
keep CONFIG_SLAB removed. See also

https://lore.kernel.org/all/20230613151008.28167567@canb.auug.org.au/

Other than that my test merge didn't show anything.

Thomas.

The following changes since commit 4897a898a216058dec55e5e5902534e6e224fcdf:

  mips: Move initrd_start check after initrd address sanitisation. (2023-05-23 11:01:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.5

for you to fetch changes up to e47084e116fccaa43644360d7c0b997979abce3e:

  MIPS: Loongson64: DTS: Add RTC support to Loongson-2K1000 (2023-06-26 09:18:43 +0200)

----------------------------------------------------------------
- added support for TP-Link HC220 G5 v1
- added support for Wifi/Bluetooth on CI20
- reworked Ralink clock and reset handling
- cleanups and fixes

----------------------------------------------------------------
Aidan MacDonald (2):
      mips: dts: ingenic: Remove unnecessary AIC clocks
      mips: dts: ingenic: x1000: Add AIC device tree node

Arnd Bergmann (2):
      mips: provide unxlate_dev_mem_ptr() in asm/io.h
      mips: asm-offsets: add missing prototypes

Binbin Zhou (2):
      MIPS: Loongson64: DTS: Add RTC support to LS7A PCH
      MIPS: Loongson64: DTS: Add RTC support to Loongson-2K1000

Franziska Naepelt (1):
      mips: Fix spacing issue

Gustavo A. R. Silva (1):
      MIPS: dec: prom: Address -Warray-bounds warning

Jiaxun Yang (4):
      MIPS: generic: Allow R5 CPUs to be selected
      MIPS: cpu-features: Use boot_cpu_type for CPU type based features
      MIPS: Rework smt cmdline parameters
      MIPS: Select CONFIG_GENERIC_IDLE_POLL_SETUP

Keguang Zhang (1):
      MIPS: Loongson32: Remove reset.c

Ladislav Michl (7):
      MIPS: OCTEON: octeon-usb: add all register offsets
      MIPS: OCTEON: octeon-usb: use bitfields for control register
      MIPS: OCTEON: octeon-usb: use bitfields for host config register
      MIPS: OCTEON: octeon-usb: use bitfields for shim register
      MIPS: OCTEON: octeon-usb: move gpio config to separate function
      MIPS: OCTEON: octeon-usb: introduce dwc3_octeon_{read,write}q
      MIPS: OCTEON: octeon-usb: cleanup divider calculation

Liviu Dudau (2):
      dt-bindings: mips: Add bindings for TP-Link HC220 G5 v1 board
      mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board

Maciej W. Rozycki (2):
      MIPS: Alchemy: Enable PATA_PLATFORM support
      Revert "MIPS: unhide PATA_PLATFORM"

Nathan Chancellor (2):
      MIPS: Mark core_vpe_count() as __init
      clk: ralink: mtmips: Fix uninitialized use of ret in mtmips_register_{fixed,factor}_clocks()

Paul Cercueil (13):
      mips: ingenic: Remove useless __maybe_unused
      mips: ingenic: Enable EXT/2 divider on JZ4750/55/60 if EXT is 24 MHz
      MIPS: DTS: qi_lb60: Don't use unit address for regulators
      MIPS: DTS: CI20: Fix regulators
      MIPS: DTS: CI20: Fix ACT8600 regulator node names
      MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators
      MIPS: DTS: CI20: Do not force-enable CIM and WiFi regulators
      MIPS: DTS: CI20: Misc. cleanups
      MIPS: DTS: CI20: Parent MSCMUX clock to MPLL
      MIPS: DTS: CI20: Enable support for WiFi / Bluetooth
      MIPS: configs: CI20: Regenerate defconfig
      MIPS: configs: CI20: Enable WiFi / Bluetooth
      MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts

Sergio Paracuellos (9):
      dt-bindings: clock: add mtmips SoCs system controller
      clk: ralink: add clock and reset driver for MTMIPS SoCs
      mips: ralink: rt288x: remove clock related code
      mips: ralink: rt305x: remove clock related code
      mips: ralink: rt3883: remove clock related code
      mips: ralink: mt7620: remove clock related code
      mips: ralink: remove reset related code
      mips: ralink: get cpu rate from new driver code
      MAINTAINERS: add Mediatek MTMIPS Clock maintainer

Shiji Yang (4):
      mips: pci-mt7620: do not print NFTS register value as error log
      mips: pci-mt7620: use dev_info() to log PCIe device detection result
      mips: ralink: introduce commonly used remap node function
      mips: ralink: match all supported system controller compatible strings

Siarhei Volkau (1):
      MIPS: uaccess: emulate Ingenic LXW/LXH/LXHU uaccess

Sui Jingfeng (1):
      MIPS: Loongson64: loongson3_defconfig: Enable amdgpu drm driver

Thomas Bogendoerfer (2):
      Merge tag 'mips-fixes_6.4_1' into mips-next
      MIPS: mm: Remove special handling for OCTEON CPUs

Tony Lindgren (1):
      mips: dts: ralink: mt7628a: Unify pinctrl-single pin group nodes

Uwe Kleine-König (1):
      MIPS: PCI: Convert to platform remove callback returning void

Yu Zhao (1):
      kvm/mips: update MAINTAINERS

 Documentation/admin-guide/kernel-parameters.txt    |    8 +-
 .../bindings/clock/mediatek,mtmips-sysc.yaml       |   64 ++
 Documentation/devicetree/bindings/mips/ralink.yaml |    1 +
 MAINTAINERS                                        |    7 +-
 arch/mips/Kconfig                                  |    4 +-
 arch/mips/alchemy/Kconfig                          |    1 +
 arch/mips/boot/dts/ingenic/ci20.dts                |  152 ++-
 arch/mips/boot/dts/ingenic/jz4725b.dtsi            |    7 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |    7 +-
 arch/mips/boot/dts/ingenic/jz4770.dtsi             |    5 +-
 arch/mips/boot/dts/ingenic/qi_lb60.dts             |    6 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi              |   18 +
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |    7 +
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          |    7 +
 arch/mips/boot/dts/ralink/Makefile                 |    3 +-
 .../boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts  |   84 ++
 arch/mips/boot/dts/ralink/mt7628a.dtsi             |   40 +-
 arch/mips/cavium-octeon/octeon-usb.c               |  629 +++++------
 arch/mips/configs/ci20_defconfig                   |   47 +-
 arch/mips/configs/loongson3_defconfig              |    7 +
 arch/mips/generic/board-ingenic.c                  |   61 +-
 arch/mips/include/asm/cpu-features.h               |    4 +-
 arch/mips/include/asm/dec/prom.h                   |    2 +-
 arch/mips/include/asm/io.h                         |    1 +
 arch/mips/include/asm/mach-loongson32/loongson1.h  |    1 -
 arch/mips/include/asm/mach-loongson32/regs-wdt.h   |   15 -
 arch/mips/include/asm/mach-ralink/mt7620.h         |   35 -
 arch/mips/include/asm/mach-ralink/rt288x.h         |   10 -
 arch/mips/include/asm/mach-ralink/rt305x.h         |   21 -
 arch/mips/include/asm/mach-ralink/rt3883.h         |    8 -
 arch/mips/include/asm/smp.h                        |    2 +
 arch/mips/include/uapi/asm/inst.h                  |   33 +
 arch/mips/kernel/asm-offsets.c                     |   14 +
 arch/mips/kernel/smp-cps.c                         |   15 +-
 arch/mips/kernel/smp-mt.c                          |    3 +-
 arch/mips/kernel/smp.c                             |   18 +
 arch/mips/kernel/unaligned.c                       |   41 +
 arch/mips/loongson32/common/Makefile               |    2 +-
 arch/mips/loongson32/common/reset.c                |   51 -
 arch/mips/mm/tlbex.c                               |   24 +-
 arch/mips/pci/pci-mt7620.c                         |    7 +-
 arch/mips/pci/pci-xtalk-bridge.c                   |    8 +-
 arch/mips/ralink/clk.c                             |   61 +-
 arch/mips/ralink/common.h                          |    7 -
 arch/mips/ralink/mt7620.c                          |  235 ----
 arch/mips/ralink/mt7621.c                          |    9 -
 arch/mips/ralink/of.c                              |   51 +-
 arch/mips/ralink/reset.c                           |   61 --
 arch/mips/ralink/rt288x.c                          |   40 -
 arch/mips/ralink/rt305x.c                          |   87 --
 arch/mips/ralink/rt3883.c                          |   53 -
 arch/mips/sibyte/swarm/platform.c                  |   14 +-
 drivers/char/mem.c                                 |    7 -
 drivers/clk/ralink/Kconfig                         |    7 +
 drivers/clk/ralink/Makefile                        |    1 +
 drivers/clk/ralink/clk-mtmips.c                    | 1117 ++++++++++++++++++++
 56 files changed, 2093 insertions(+), 1137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
 create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
 delete mode 100644 arch/mips/loongson32/common/reset.c
 create mode 100644 drivers/clk/ralink/clk-mtmips.c

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
