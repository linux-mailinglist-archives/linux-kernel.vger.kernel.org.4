Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E1B69CB32
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjBTMlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjBTMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:21 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DE1C589
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:19 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:e2ba:5470:259d:9c84])
        by albert.telenet-ops.be with bizsmtp
        id PQhH2900E2zSf1N06QhHwv; Mon, 20 Feb 2023 13:41:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pU5TR-009XSy-2Q;
        Mon, 20 Feb 2023 13:41:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pU5Tp-002qhx-HK;
        Mon, 20 Feb 2023 13:41:17 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.3
Date:   Mon, 20 Feb 2023 13:41:09 +0100
Message-Id: <20230220124109.679256-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.3-tag1

for you to fetch changes up to 1e5b5df65af99013b4d31607ddb3ca5731dbe44d:

  m68k: /proc/hardware should depend on PROC_FS (2023-02-13 11:34:49 +0100)

----------------------------------------------------------------
m68k updates for v6.3

  - Add seccomp support,
  - Defconfig updates,
  - Miscellaneous fixes and improvements.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.2-rc3

Michael Schmitz (3):
      m68k: Check syscall_trace_enter() return code
      m68k: Add kernel seccomp support
      selftests/seccomp: Add m68k support

Randy Dunlap (1):
      m68k: /proc/hardware should depend on PROC_FS

Xin Gao (1):
      m68k: q40: Do not initialise statics to 0

 .../seccomp/seccomp-filter/arch-support.txt        |  2 +-
 arch/m68k/68000/entry.S                            |  2 +
 arch/m68k/Kconfig                                  |  2 +
 arch/m68k/Kconfig.devices                          |  1 +
 arch/m68k/coldfire/entry.S                         |  2 +
 arch/m68k/configs/amiga_defconfig                  |  3 --
 arch/m68k/configs/apollo_defconfig                 |  3 --
 arch/m68k/configs/atari_defconfig                  |  3 --
 arch/m68k/configs/bvme6000_defconfig               |  3 --
 arch/m68k/configs/hp300_defconfig                  |  3 --
 arch/m68k/configs/mac_defconfig                    |  3 --
 arch/m68k/configs/multi_defconfig                  |  4 +-
 arch/m68k/configs/mvme147_defconfig                |  3 --
 arch/m68k/configs/mvme16x_defconfig                |  3 --
 arch/m68k/configs/q40_defconfig                    |  3 --
 arch/m68k/configs/sun3_defconfig                   |  3 --
 arch/m68k/configs/sun3x_defconfig                  |  3 --
 arch/m68k/include/asm/seccomp.h                    | 11 +++++
 arch/m68k/include/asm/syscall.h                    | 57 ++++++++++++++++++++++
 arch/m68k/include/asm/thread_info.h                |  2 +
 arch/m68k/kernel/entry.S                           |  6 +++
 arch/m68k/kernel/ptrace.c                          |  6 ++-
 arch/m68k/q40/q40ints.c                            |  4 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  8 ++-
 24 files changed, 99 insertions(+), 41 deletions(-)
 create mode 100644 arch/m68k/include/asm/seccomp.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
