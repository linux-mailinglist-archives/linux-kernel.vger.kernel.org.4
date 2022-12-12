Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5B649B91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLLKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiLLKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:01:58 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD8B964C0;
        Mon, 12 Dec 2022 02:01:56 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p4fdC-0003dF-00; Mon, 12 Dec 2022 11:01:54 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7E038C01C5; Mon, 12 Dec 2022 11:01:49 +0100 (CET)
Date:   Mon, 12 Dec 2022 11:01:49 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.2
Message-ID: <20221212100149.GA4565@alpha.franken.de>
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

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.2

for you to fetch changes up to 4c587a982603d7e7e751b4925809a1512099a690:

  MIPS: OCTEON: warn only once if deprecated link status is being used (2022-12-09 23:37:46 +0100)

----------------------------------------------------------------
- DT cleanups
- fix for early use of kzalloc on mt7621 platform
- cleanups and fixes

----------------------------------------------------------------
Anastasia Belova (1):
      MIPS: BCM63xx: Add check for NULL for clk in clk_enable

Arınç ÜNAL (3):
      mips: ralink: mt7621: fix phy-mode of external phy on GB-PC2
      mips: ralink: mt7621: change DSA port labels to generic naming
      mips: dts: remove label = "cpu" from DSA dt-binding

Dmitry Torokhov (1):
      MIPS: DTS: CI20: fix reset line polarity of the ethernet controller

Geert Uytterhoeven (1):
      MIPS: mscc: jaguar2: Fix pca9545 i2c-mux node names

Genjian Zhang (1):
      MIPS: Restore symbol versions for copy_page_cpu and clear_page_cpu

Huacai Chen (1):
      platform/mips: Adjust Kconfig to keep consistency

John Thomson (3):
      mips: ralink: mt7621: define MT7621_SYSC_BASE with __iomem
      mips: ralink: mt7621: soc queries and tests as functions
      mips: ralink: mt7621: do not use kzalloc too early

Ladislav Michl (1):
      MIPS: OCTEON: warn only once if deprecated link status is being used

Rafał Miłecki (2):
      mips: dts: bcm63268: add TWD block timer
      mips: dts: brcm: bcm7435: add "interrupt-names" for NAND controller

Sergio Paracuellos (2):
      dt-bindings: mips: add CPU bindings for MIPS architecture
      dt-bindings: mips: brcm: add Broadcom SoCs bindings

Tiezhu Yang (1):
      MIPS: Use "grep -E" instead of "egrep"

Xu Panda (1):
      MIPS: OCTEON: cvmx-bootmem: use strscpy() to instead of strncpy()

Yang Yingliang (2):
      MIPS: vpe-mt: fix possible memory leak while module exiting
      MIPS: vpe-cmp: fix possible memory leak while module exiting

zhang songyi (1):
      mips/pci: use devm_platform_ioremap_resource()

 .../devicetree/bindings/mips/brcm/brcm,bmips.txt   |   8 --
 .../devicetree/bindings/mips/brcm/soc.yaml         |  96 +++++++++++++++++
 Documentation/devicetree/bindings/mips/cpus.yaml   | 115 +++++++++++++++++++++
 .../bindings/mips/ingenic/ingenic,cpu.yaml         |  69 -------------
 arch/mips/Makefile                                 |   2 +-
 arch/mips/bcm63xx/clk.c                            |   2 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   5 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |   1 +
 arch/mips/boot/dts/ingenic/ci20.dts                |   2 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts         |   4 +-
 arch/mips/boot/dts/qca/ar9331.dtsi                 |   1 -
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts |   2 +-
 arch/mips/boot/dts/ralink/mt7621.dtsi              |  11 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |   3 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   2 +-
 arch/mips/include/asm/asm-prototypes.h             |   3 +
 arch/mips/include/asm/mach-ralink/mt7621.h         |   4 +-
 arch/mips/kernel/vpe-cmp.c                         |   4 +-
 arch/mips/kernel/vpe-mt.c                          |   4 +-
 arch/mips/pci/pci-rt3883.c                         |   4 +-
 arch/mips/ralink/mt7621.c                          |  97 +++++++++++------
 arch/mips/vdso/Makefile                            |   2 +-
 drivers/platform/Kconfig                           |   2 -
 drivers/platform/mips/Kconfig                      |   1 +
 25 files changed, 313 insertions(+), 133 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/brcm/brcm,bmips.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/soc.yaml
 create mode 100644 Documentation/devicetree/bindings/mips/cpus.yaml
 delete mode 100644 Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
