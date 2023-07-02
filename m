Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077DD744E36
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGBOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:51:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCBAE69;
        Sun,  2 Jul 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688309457; x=1688914257; i=deller@gmx.de;
 bh=mIIfORQoXVd4FidkQT6At7/JYvBsefCZTwJLJV8EidU=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=cK0J7RNpzpwqiF/uBOepoFooh3DRvJ5j99RSLT9Lb6ktaGgixFn5dsqS3jrdGTrIe5cjz7r
 Y1YySM+sTJmLTjygae//nyS4ppkt1LArxrbI6HtPQTDwn0IX5JqorOH2+LrBcqfdKC4J591T8
 Z7HKfXVRU3UeKuSt5l3jevaLDBtWIrRpQNif4XTuPiyw3lm5WCX4Gp7zH3f6U7JYTOwUckyx0
 zIk8MeyWXZl8PeRs2D3t12NPAGSVP26NV3h0L6sqbJzmhBWfV1dobBFemGIHiVm+oL0StBlY2
 /WKEBYnUKtyzOUczNP70OVXfTcQYFoNoBQB2T3c9MgNENGOBdJEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.159.131]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1qZHgU46Lu-00JNk0; Sun, 02
 Jul 2023 16:50:57 +0200
Date:   Sun, 2 Jul 2023 16:50:55 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes & updates for v6.5-rc1
Message-ID: <ZKGOzzDGM1925iYg@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:5SQMyxN27s4NHfBi/JuO/f6Ggnre/285bRtxkRnGdAFiMXW8xSM
 Ey4vkXK+s1se3EEx6VA5fZtduvigp+XIMiaHggkpGPAsVswldNf96TmIjgyeve4/Pz8K7dM
 RFeKt1u0xp8S+2OI95vU2wSkIAa6IsogDdII7jw9BUkIyGjbwNUq4uuzg9CWNVRH+qQ8gLr
 32eF4s2h6LZPf8IgRMZQA==
UI-OutboundReport: notjunk:1;M01:P0:hS39Y22vQaA=;ePO6xmyNedcMuJ2RXYVWS+YUuDa
 jg9cIZMRPiIxImLFiqcyg1me4sy8OvgPj4FFqRnDfMqOUCHrhgfqkQyJ59viBFwRSCXWb8hr/
 FdCm8URovs0vSx8D9597w1mdsY5EHv3qgwgJdSPM6q3cbS13VppytwF3fFNaRUyubOOmSr7pK
 v2px7ZdkCbLYU20+n6IW8+HrlD+l3lDXeVxoN8UMBazR5Dh7mecenOFDTu3Mp5CHYp+D9pWzs
 DRPX9jWBgEaEQIAAG/A4ma4s6y78yIjifHXLO0a1ugwMT2WasjgWYJtTie5VzNZwHmSwnQQKH
 eZ1GHdmdoqUQvQgQcRep3V/y0V02G8wb1ctIJ/O7NIBQ5s7zBhA1mA1VqDcyERXNXL8ykpLAG
 +NTHNkITidACunbg93zMHZvgjAb0jeXRdgJhZdoi1h6dddCeLButK+MLGg7HVCvEqfjjFMzAn
 vsdyjf4CEoxP2xM8OlKqNIWIjU5JeiuKLDXs8Hb90crcbU5R90ti3/9yjfJ4iURCA0AiDhotD
 7BZxsMJDy9KRXjdFzuBtz+VDgQOfFitbMl+TiTK8ViOpqHc+Ug28AsPMU+YjNpqyWUDhKbhO1
 Apna4qTR2bn+0KrwubBn0kns59LkYS4PN6Gc2DxYqCYa95ypp5rdhcxkenKwuPMEUMXd1fvN1
 oltfFmoCFZ4hcl9zxt6opJijpQgVXEp/QrM6OUBY+uCodROT/veF930E07ogONjxMlpZn02dn
 +gmLBzPsI2tG5SYQwa5YSAvViRbt+mE+MPuXHt24CbHiXIibUDJ5lCdYlg3htMpFOyewEnvnP
 cQJcUQvXulXN4oGKUins3q5C0Dptu4DCKHEsRUR+Fa6nz+QRZUSkpv1Pf2DpsJZSZ2zWku9Sm
 Fy8n2XtYr573wbbyOyEBcKCQr7vgE9ong/vI/lWTRDDLsyLR4JE/Moz4mjTkiMPASm8qDytdr
 sHi1ow==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the fixes & upates for the parisc architecture for kernel 6.5-rc1.

This patchset adds the missing cacheflush() syscall and fixes the STI
(text) console on machines which allow only 64-bit firmware calls.
The other patches fix warnings for W=1 and refresh the defconfigs.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit e55e5df193d247a38a5e1ac65a5316a0adcc22fa:

  csky: fix up lock_mm_and_find_vma() conversion (2023-06-29 23:34:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc1

for you to fetch changes up to 4ad1218bed3d1ea4c5fd28588f8628b92df30ad7:

  parisc: Refresh defconfigs (2023-06-30 17:19:49 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.5-rc1:

* Add missing cacheflush() syscall
* Fix STI console on 64-bit-only machines
* Move kernel debug options to Kconfig.debug
* Lots of warning fixes in arch/parisc/ and drivers/parisc/ when
  compiled with W=1
* Enable some more graphics drivers in refreshed defconfigs

----------------------------------------------------------------
Helge Deller (29):
      parisc: Move TLB_PTLOCK option to Kconfig.debug
      parisc: Check if IRQs are disabled when calling arch_local_irq_restore()
      parisc: Add cacheflush() syscall
      parisc: Fix missing prototype warning for arch_report_meminfo()
      parisc: Default to 8 CPUs for 64-bit kernel
      sticon/parisc: Allow 64-bit STI calls in PDC firmware abstration
      sticon/parisc: Fix STI console on 64-bit only machines
      parisc: sba_iommu: Fix kdoc warnings
      parisc: Fold 32-bit compat code into audit_classify_syscall()
      parisc: drivers: Fix kdoc warnings
      parisc: firmware: Fix kdoc warnings
      parisc: pdc_chassis: Fix kdoc warnings
      parisc: module: Mark symindex __maybe_unused
      parisc: Mark image_size __maybe_unused in perf_write()
      parisc: pci-dma: Make pcxl_alloc_range() static
      parisc: pdc_stable: Fix kdoc and compiler warnings
      parisc: ccio-dma: Fix kdoc and compiler warnings
      parisc: sys_parisc: parisc_personality() is called from asm code
      parisc: processor: Fix kdoc for init_cpu_profiler()
      parisc: traps: Mark functions static
      parisc: init: Drop unused variable end_paddr
      parisc: unwind: Mark start and stop variables __maybe_unused
      parisc: signal: Mark do_notify_resume() and sys_rt_sigreturn() asmlinkage
      parisc: unaligned: Include header file to avoid missing prototype warnings
      parisc: lba_pci: Mark two variables __maybe_unused
      parisc: dino: Make dino_init() returning void
      parisc: Move init function declarations into header file
      parisc: irq: Add irq-related function declarations
      parisc: Refresh defconfigs

 arch/parisc/Kconfig                         |  12 +--
 arch/parisc/Kconfig.debug                   |  11 ++
 arch/parisc/configs/generic-32bit_defconfig |  54 ++++++++--
 arch/parisc/configs/generic-64bit_defconfig |  47 ++++++--
 arch/parisc/include/asm/irqflags.h          |   5 +
 arch/parisc/include/asm/pdc.h               |   4 +-
 arch/parisc/include/asm/processor.h         |  35 ++++++
 arch/parisc/include/uapi/asm/cachectl.h     |  12 +++
 arch/parisc/kernel/audit.c                  |   9 +-
 arch/parisc/kernel/cache.c                  |  49 +++++++++
 arch/parisc/kernel/compat_audit.c           |  16 ---
 arch/parisc/kernel/drivers.c                |  33 +++---
 arch/parisc/kernel/firmware.c               |  61 ++++++-----
 arch/parisc/kernel/irq.c                    |   5 +-
 arch/parisc/kernel/module.c                 |   2 +-
 arch/parisc/kernel/pci-dma.c                |   2 +-
 arch/parisc/kernel/pdc_chassis.c            |  17 +--
 arch/parisc/kernel/pdt.c                    |   1 +
 arch/parisc/kernel/perf.c                   |   2 +-
 arch/parisc/kernel/processor.c              |   2 +-
 arch/parisc/kernel/setup.c                  |  23 +---
 arch/parisc/kernel/signal.c                 |  10 +-
 arch/parisc/kernel/sys_parisc.c             |   3 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/parisc/kernel/traps.c                  |   7 +-
 arch/parisc/kernel/unaligned.c              |   1 +
 arch/parisc/kernel/unwind.c                 |   5 +-
 arch/parisc/mm/init.c                       |   2 -
 drivers/parisc/ccio-dma.c                   |  18 ++--
 drivers/parisc/dino.c                       |   5 +-
 drivers/parisc/eisa.c                       |   2 +-
 drivers/parisc/lba_pci.c                    |   8 +-
 drivers/parisc/pdc_stable.c                 |  36 ++++++-
 drivers/parisc/sba_iommu.c                  |  32 +++---
 drivers/video/fbdev/stifb.c                 |   4 +-
 drivers/video/sticore.c                     | 159 ++++++++++++++++++----------
 include/video/sticore.h                     |  42 ++++----
 37 files changed, 485 insertions(+), 252 deletions(-)
 create mode 100644 arch/parisc/include/uapi/asm/cachectl.h
