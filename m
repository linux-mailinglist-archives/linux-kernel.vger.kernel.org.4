Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673A26EF134
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbjDZJbQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbjDZJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:31:13 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAA319F;
        Wed, 26 Apr 2023 02:31:11 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1prbUH-002IGg-SU; Wed, 26 Apr 2023 11:30:57 +0200
Received: from p5b13a35e.dip0.t-ipconnect.de ([91.19.163.94] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1prbUH-003KgH-LD; Wed, 26 Apr 2023 11:30:57 +0200
Message-ID: <7ba5e47fd342b596937022a207ea630ab692a8a9.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Apr 2023 11:30:56 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.163.94
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This pull request is a bit larger than my previous one and mainly consists of
clean-up work in the arch/sh directory by Geert Uytterhoeven and Randy Dunlap.

Additionally, this PR fixes a bug in the Storage Queue code that was discovered
while I was reviewing a patch to switch the code to the bitmap API by Christophe
Jaillet.

Thus, the PR contains both a fix for the original bug in the Storage Queue code
that can be backported later as well as the Christophe's patch to swich the code
to the bitmap API.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.4-tag1

for you to fetch changes up to e5c23bec0f121b4160dc8ca61e751e734652bd05:

  sh: Replace <uapi/asm/types.h> by <asm-generic/int-ll64.h> (2023-04-25 09:16:51 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.4

- sh: Use generic GCC library routines
- sh: sq: Use the bitmap API when applicable
- sh: sq: Fix incorrect element size for allocating bitmap buffer
- sh: pci: Remove unused variable in SH-7786 PCI Express code
- sh: mcount.S: fix build error when PRINTK is not enabled
- sh: remove sh5/sh64 last fragments
- sh: math-emu: fix macro redefined warning
- sh: init: use OF_EARLY_FLATTREE for early init
- sh: nmi_debug: fix return value of __setup handler
- sh: SH2007: drop the bad URL info

----------------------------------------------------------------
Christophe JAILLET (1):
      sh: sq: Use the bitmap API when applicable

Geert Uytterhoeven (2):
      sh: Use generic GCC library routines
      sh: Replace <uapi/asm/types.h> by <asm-generic/int-ll64.h>

John Paul Adrian Glaubitz (2):
      sh: pci: Remove unused variable in SH-7786 PCI Express code
      sh: sq: Fix incorrect element size for allocating bitmap buffer

Randy Dunlap (6):
      sh: SH2007: drop the bad URL info
      sh: nmi_debug: fix return value of __setup handler
      sh: init: use OF_EARLY_FLATTREE for early init
      sh: math-emu: fix macro redefined warning
      sh: remove sh5/sh64 last fragments
      sh: mcount.S: fix build error when PRINTK is not enabled

 Documentation/kbuild/kbuild.rst                    |  1 -
 Documentation/scheduler/sched-arch.rst             |  2 --
 .../translations/zh_CN/scheduler/sched-arch.rst    |  2 --
 arch/sh/Kconfig                                    |  3 ++
 arch/sh/Kconfig.debug                              |  2 +-
 arch/sh/boards/Kconfig                             |  1 -
 arch/sh/boot/compressed/ashldi3.c                  |  4 +--
 arch/sh/drivers/pci/pcie-sh7786.c                  |  1 -
 arch/sh/include/asm/types.h                        |  2 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |  7 ++---
 arch/sh/kernel/head_32.S                           |  6 ++--
 arch/sh/kernel/nmi_debug.c                         |  4 +--
 arch/sh/kernel/setup.c                             |  4 +--
 arch/sh/lib/Makefile                               |  4 +--
 arch/sh/lib/ashldi3.c                              | 30 --------------------
 arch/sh/lib/ashrdi3.c                              | 32 ----------------------
 arch/sh/lib/lshrdi3.c                              | 30 --------------------
 arch/sh/math-emu/sfp-util.h                        |  4 ---
 scripts/checkstack.pl                              |  7 -----
 tools/perf/arch/common.c                           |  2 --
 tools/scripts/Makefile.arch                        |  5 ----
 tools/testing/selftests/mm/Makefile                |  2 +-
 tools/testing/selftests/mm/run_vmtests.sh          |  2 +-
 23 files changed, 20 insertions(+), 137 deletions(-)
 delete mode 100644 arch/sh/lib/ashldi3.c
 delete mode 100644 arch/sh/lib/ashrdi3.c
 delete mode 100644 arch/sh/lib/lshrdi3.c

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
