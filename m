Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060CB6A0D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjBWQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjBWQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:10:56 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AD7D5328F;
        Thu, 23 Feb 2023 08:10:52 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pVEBH-0005zF-00; Thu, 23 Feb 2023 17:10:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D5699C0158; Thu, 23 Feb 2023 17:10:25 +0100 (CET)
Date:   Thu, 23 Feb 2023 17:10:25 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.3
Message-ID: <20230223161025.GA11164@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.3

for you to fetch changes up to 91dc288f4edf0d768e46c2c6d33e0ab703403459:

  MIPS: vpe-mt: drop physical_memsize (2023-02-20 15:11:01 +0100)

----------------------------------------------------------------
just cleanups and fixes

----------------------------------------------------------------
Arınç ÜNAL (3):
      mips: ralink: make SOC_MT7621 select PINCTRL_MT7621 and fix help section
      mips: dts: align LED node names with dtschema
      mips: dts: ralink: mt7621: add port@5 as CPU port

Elvira Khabirova (1):
      mips: fix syscall_get_nr

Genjian Zhang (1):
      MIPS: dts: Boston: Fix dtc 'pci_device_reg' warning

H. Nikolaus Schaller (2):
      MIPS: DTS: CI20: fix otg power gpio
      MIPS: DTS: jz4780: add #clock-cells to rtc_dev

Jonathan Neuschäfer (1):
      MIPS: dts: lantiq: Remove bogus interrupt-parent; line

Ladislav Michl (1):
      MIPS: OCTEON: octeon-usb: Consolidate error messages

Masahiro Yamada (1):
      MIPS: remove CONFIG_MIPS_LD_CAN_LINK_VDSO

Rafał Miłecki (1):
      MIPS: BCM47XX: Add support for Linksys E2500 V3

Randy Dunlap (2):
      MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not set
      MIPS: vpe-mt: drop physical_memsize

Sander Vanheule (1):
      mips: Realtek RTL: select NO_EXCEPT_FILL

Ye Xingchen (4):
      MIPS: lantiq: xway: Use devm_platform_get_and_ioremap_resource()
      MIPS: pci: lantiq: Use devm_platform_get_and_ioremap_resource()
      MIPS: pci-mt7620: Use devm_platform_get_and_ioremap_resource()
      MIPS: ralink: Use devm_platform_get_and_ioremap_resource()

xurui (1):
      MIPS: Fix a compilation issue

 arch/mips/Kconfig                                  |  1 +
 arch/mips/bcm47xx/board.c                          |  1 +
 arch/mips/bcm47xx/buttons.c                        |  9 +++++
 .../boot/dts/cavium-octeon/dlink_dsr-1000n.dts     | 10 +++---
 .../mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts |  6 ++--
 arch/mips/boot/dts/img/boston.dts                  |  2 +-
 arch/mips/boot/dts/ingenic/ci20.dts                | 10 +++---
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  2 ++
 arch/mips/boot/dts/lantiq/danube.dtsi              |  1 -
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts          |  6 ++--
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |  8 ++---
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts     |  8 ++---
 arch/mips/boot/dts/qca/ar9331_omega.dts            |  2 +-
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts        |  8 ++---
 .../dts/ralink/gardena_smart_gateway_mt7688.dts    | 22 ++++++------
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 20 ++++-------
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 21 +++++++----
 arch/mips/boot/dts/ralink/mt7621.dtsi              | 19 +++++++++-
 arch/mips/cavium-octeon/octeon-usb.c               | 42 +++++++++++-----------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  1 +
 arch/mips/include/asm/mach-rc32434/pci.h           |  2 +-
 arch/mips/include/asm/syscall.h                    |  2 +-
 arch/mips/include/asm/vpe.h                        |  1 -
 arch/mips/kernel/smp-cps.c                         |  8 +++--
 arch/mips/kernel/vpe-mt.c                          |  7 ++--
 arch/mips/lantiq/prom.c                            |  6 ----
 arch/mips/lantiq/xway/dcdc.c                       |  5 +--
 arch/mips/lantiq/xway/dma.c                        |  4 +--
 arch/mips/lantiq/xway/gptu.c                       |  5 +--
 arch/mips/pci/pci-lantiq.c                         |  8 ++---
 arch/mips/pci/pci-mt7620.c                         |  8 ++---
 arch/mips/ralink/Kconfig                           |  5 +--
 arch/mips/ralink/timer.c                           |  3 +-
 arch/mips/vdso/Kconfig                             | 14 +-------
 arch/mips/vdso/Makefile                            |  3 --
 35 files changed, 136 insertions(+), 144 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
