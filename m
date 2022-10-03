Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0785F2F44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJCLFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJCLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:05:43 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 786A615709;
        Mon,  3 Oct 2022 04:05:41 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ofJGV-0008KH-00; Mon, 03 Oct 2022 13:05:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 913EEC0D3A; Mon,  3 Oct 2022 13:05:33 +0200 (CEST)
Date:   Mon, 3 Oct 2022 13:05:33 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.1
Message-ID: <20221003110533.GA9355@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.1

for you to fetch changes up to 90c2d2eb7ab5848c4f853751f12b96bdc460ad1b:

  MIPS: pci: lantiq: switch to using gpiod API (2022-10-01 18:07:51 +0200)

----------------------------------------------------------------
- mainly cleanups
- fix enabling interrupts on second VPE for Lantiq platform
- switch to use gpiod API
- allow firmware passing RND seed

----------------------------------------------------------------
Aleksander Jan Bajkowski (2):
      MIPS: dts: lantiq: rename dts files with soc name being the prefix
      MIPS: lantiq: enable all hardware interrupts on second VPE

Dmitry Torokhov (3):
      MIPS: Lantiq: switch vmmc to use gpiod API
      MIPS: Lantiq: vmmc: fix compile break introduced by gpiod patch
      MIPS: pci: lantiq: switch to using gpiod API

Gaosheng Cui (9):
      MIPS: Loongson2ef: remove orphan sbx00_acpi_init() declaration
      MIPS: Octeon: remove orphan octeon_swiotlb declaration
      MIPS: Octeon: remove orphan cvmx_fpa_setup_pool() declaration
      MIPS: Octeon: remove orphan octeon_hal_setup_reserved32() declaration
      MIPS: IRQ: remove orphan declarations from arch/mips/include/asm/irq.h
      MIPS: remove orphan sni_cpu_time_init() declaration
      MIPS: AR7: remove orphan declarations from arch/mips/include/asm/mach-ar7/ar7.h
      MIPS: remove orphan sb1250_time_init() declaration
      MIPS: IRQ: remove orphan allocate_irqno() declaration

Jason A. Donenfeld (1):
      mips: allow firmware to pass RNG seed to kernel

Jason Wang (1):
      MIPS: Fix comment typo

Kees Cook (1):
      MIPS: BCM47XX: Cast memcmp() of function to (void *)

Lin Yujun (2):
      MIPS: SGI-IP30: Fix platform-device leak in bridge_platform_create()
      MIPS: SGI-IP27: Fix platform-device leak in bridge_platform_create()

Liu Shixin (3):
      mips: cavium: convert to DEFINE_SHOW_ATTRIBUTE
      mips: kernel: convert to DEFINE_SHOW_ATTRIBUTE
      mips: ralink: convert to DEFINE_SHOW_ATTRIBUTE

Lukas Bulwahn (1):
      mips: update config files

Rafał Miłecki (1):
      mips: bmips: bcm63268: add TWD block binding

Randy Dunlap (1):
      MIPS: ath25: clean up non-kernel-doc comment warning

Shaomin Deng (1):
      MIPS: Fix comments typo

Tiezhu Yang (2):
      MIPS: Silence missing prototype warning
      MIPS: Simplify __bswapdi2() and __bswapsi2()

Wolfram Sang (1):
      MIPS: move from strlcpy with unused retval to strscpy

 arch/mips/bcm47xx/prom.c                           |  4 +-
 arch/mips/boot/dts/brcm/bcm63268.dtsi              | 18 ++++--
 arch/mips/boot/dts/lantiq/Makefile                 |  2 +-
 .../lantiq/{easy50712.dts => danube_easy50712.dts} |  0
 arch/mips/cavium-octeon/oct_ilm.c                  | 17 +-----
 arch/mips/cavium-octeon/setup.c                    |  2 +-
 arch/mips/configs/ar7_defconfig                    |  4 --
 arch/mips/configs/ath25_defconfig                  |  4 --
 arch/mips/configs/ath79_defconfig                  | 10 ----
 arch/mips/configs/bcm63xx_defconfig                |  3 -
 arch/mips/configs/bigsur_defconfig                 |  9 ---
 arch/mips/configs/bmips_be_defconfig               |  3 -
 arch/mips/configs/bmips_stb_defconfig              | 23 +------
 arch/mips/configs/cavium_octeon_defconfig          |  1 -
 arch/mips/configs/db1xxx_defconfig                 |  1 -
 arch/mips/configs/decstation_64_defconfig          | 10 ----
 arch/mips/configs/decstation_defconfig             | 10 ----
 arch/mips/configs/decstation_r4k_defconfig         | 10 ----
 arch/mips/configs/fuloong2e_defconfig              |  9 ---
 arch/mips/configs/generic/board-ocelot.config      |  1 -
 arch/mips/configs/gpr_defconfig                    |  8 ---
 arch/mips/configs/ip22_defconfig                   | 10 ----
 arch/mips/configs/ip27_defconfig                   | 19 ------
 arch/mips/configs/ip28_defconfig                   |  3 -
 arch/mips/configs/ip32_defconfig                   |  2 -
 arch/mips/configs/jazz_defconfig                   |  1 -
 arch/mips/configs/lemote2f_defconfig               |  9 ---
 arch/mips/configs/loongson1b_defconfig             |  4 --
 arch/mips/configs/loongson1c_defconfig             |  4 --
 arch/mips/configs/loongson2k_defconfig             |  3 -
 arch/mips/configs/loongson3_defconfig              |  2 -
 arch/mips/configs/malta_defconfig                  |  5 --
 arch/mips/configs/malta_kvm_defconfig              |  5 --
 arch/mips/configs/malta_qemu_32r6_defconfig        |  3 -
 arch/mips/configs/maltaaprp_defconfig              |  3 -
 arch/mips/configs/maltasmvp_defconfig              |  3 -
 arch/mips/configs/maltasmvp_eva_defconfig          |  3 -
 arch/mips/configs/maltaup_defconfig                |  3 -
 arch/mips/configs/maltaup_xpa_defconfig            |  5 --
 arch/mips/configs/mtx1_defconfig                   | 10 ----
 arch/mips/configs/omega2p_defconfig                |  3 -
 arch/mips/configs/pic32mzda_defconfig              |  1 -
 arch/mips/configs/rb532_defconfig                  |  4 --
 arch/mips/configs/rbtx49xx_defconfig               |  7 ---
 arch/mips/configs/rm200_defconfig                  |  7 ---
 arch/mips/configs/rt305x_defconfig                 |  4 --
 arch/mips/configs/sb1250_swarm_defconfig           |  2 -
 arch/mips/configs/vocore2_defconfig                |  3 -
 arch/mips/configs/xway_defconfig                   |  4 --
 arch/mips/include/asm/irq.h                        |  4 --
 arch/mips/include/asm/mach-ar7/ar7.h               |  2 -
 arch/mips/include/asm/octeon/cvmx-fpa.h            | 20 -------
 arch/mips/include/asm/octeon/octeon.h              |  1 -
 arch/mips/include/asm/octeon/pci-octeon.h          |  2 -
 arch/mips/include/asm/sibyte/sb1250.h              |  1 -
 arch/mips/include/asm/sni.h                        |  3 -
 arch/mips/kernel/prom.c                            |  6 +-
 arch/mips/kernel/relocate.c                        |  2 +-
 arch/mips/kernel/segment.c                         | 15 +----
 arch/mips/kernel/setup.c                           | 21 +++++++
 arch/mips/lantiq/prom.c                            | 26 +++++++-
 arch/mips/lantiq/xway/vmmc.c                       | 24 +++++---
 arch/mips/lib/bswapdi.c                            | 14 ++---
 arch/mips/lib/bswapsi.c                            | 10 ++--
 arch/mips/loongson2ef/common/pci.c                 |  2 -
 arch/mips/math-emu/cp1emu.c                        |  2 +-
 arch/mips/pci/pci-ar2315.c                         |  2 +-
 arch/mips/pci/pci-lantiq.c                         | 28 ++++-----
 arch/mips/pic32/pic32mzda/init.c                   |  2 +-
 arch/mips/ralink/bootrom.c                         | 15 +----
 arch/mips/sgi-ip27/ip27-xtalk.c                    | 70 +++++++++++++++-------
 arch/mips/sgi-ip30/ip30-xtalk.c                    | 70 +++++++++++++++-------
 arch/mips/sibyte/sb1250/irq.c                      |  6 --
 73 files changed, 215 insertions(+), 414 deletions(-)
 rename arch/mips/boot/dts/lantiq/{easy50712.dts => danube_easy50712.dts} (100%)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
