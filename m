Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D573EB48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFZTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:47:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D33BD9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687808844; x=1719344844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ckfibBdj5E1w4bt7oXIRWhpXW2G8XCexQleh7eQUGbs=;
  b=h6hHf6p8pKIrFIsv0TQEn2eSOrq81MyRA2N+HBxq2WP1XVC4EIem4hO0
   O+8hm97RErJw/O3x44nl84zYTj9mFh5RomjeiSgxFcaLN3MS/KQgK7Rmf
   V5sAdk6u3sZUqX5ckw+7pA9rWe+PxkUL9OehaCDjU83oC3tenX3uVFq2p
   oPIRbscCumlWlV+nLtjLoVx7h8DD2Pvouo0CsYSz1ioJFu003rKg83ON2
   rLdpodkCBxjA4AEoYAFLkzEovG112bVERSuZ+7f+U+3+H9BgKHD0P2Rqh
   vvn3gqXq9YEHYVOL8ScHufEHPFedcLWHgEIgWWd+/LInaMC5tWFmyW8Qj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340958042"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340958042"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781574541"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="781574541"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2023 12:47:23 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/cleanups for 6.5
Date:   Mon, 26 Jun 2023 12:47:12 -0700
Message-Id: <20230626194712.1536077-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/cleanups changes for 6.5.

As usual, these are all over the map. The biggest cluster is
work from Arnd to eliminate -Wmissing-prototype warnings.

--

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_6.5

for you to fetch changes up to b360cbd254fde61cb500a4a3ca2e65dff3dfa039:

  x86/acpi: Remove unused extern declaration acpi_copy_wakeup_routine() (2023-06-21 10:57:54 -0700)

----------------------------------------------------------------
 - Address -Wmissing-prototype warnings
 - Remove repeated 'the' in comments
 - Remove unused current_untag_mask()
 - Document urgent tip branch timing
 - Clean up MSR kernel-doc notation
 - Clean up paravirt_ops doc
 - Update Srivatsa S. Bhat's maintained areas
 - Remove unused extern declaration acpi_copy_wakeup_routine()

----------------------------------------------------------------
Arnd Bergmann (15):
      x86/ftrace: Move prepare_ftrace_return prototype to header
      x86/pci: Mark local functions as 'static'
      x86: Add dummy prototype for mk_early_pgtbl_32()
      x86/fpu: Include asm/fpu/regset.h
      x86: Avoid missing-prototype warnings for doublefault code
      x86/mm: Include asm/numa.h for set_highmem_pages_init()
      x86/quirks: Include linux/pnp.h for arch_pnpbios_disabled()
      x86/entry: Add do_SYSENTER_32() prototype
      x86/hibernate: Declare global functions in suspend.h
      x86/fbdev: Include asm/fb.h as needed
      x86/mce: Add copy_mc_fragile_handle_tail() prototype
      x86/vdso: Include vdso/processor.h
      x86/usercopy: Include arch_wb_cache_pmem() declaration
      x86/mm: Add early_memremap_pgprot_adjust() prototype
      x86/platform: Avoid missing-prototype warnings for OLPC

Bo Liu (1):
      x86/mm: Remove repeated word in comments

Borislav Petkov (AMD) (1):
      x86/mm: Remove unused current_untag_mask()

Christian Kujau (1):
      Documentation/process: Explain when tip branches get merged into mainline

Randy Dunlap (2):
      x86/lib/msr: Clean up kernel-doc notation
      Documentation: virt: Clean up paravirt_ops doc

Srivatsa S. Bhat (VMware) (1):
      MAINTAINERS: Update Srivatsa S. Bhat's maintained areas

YueHaibing (1):
      x86/acpi: Remove unused extern declaration acpi_copy_wakeup_routine()

 CREDITS                                  |  6 ++++++
 Documentation/process/maintainer-tip.rst |  3 +++
 Documentation/virt/paravirt_ops.rst      | 16 ++++++++--------
 MAINTAINERS                              |  6 +++---
 arch/x86/entry/vdso/vgetcpu.c            |  1 +
 arch/x86/include/asm/doublefault.h       |  4 ++++
 arch/x86/include/asm/ftrace.h            |  3 +++
 arch/x86/include/asm/mce.h               |  3 +++
 arch/x86/include/asm/syscall.h           |  6 ++++--
 arch/x86/include/asm/tlbflush.h          | 11 ++---------
 arch/x86/kernel/acpi/sleep.h             |  1 -
 arch/x86/kernel/doublefault_32.c         |  1 +
 arch/x86/kernel/ftrace.c                 |  3 ---
 arch/x86/kernel/head32.c                 |  1 +
 arch/x86/kernel/platform-quirks.c        |  1 +
 arch/x86/lib/msr.c                       | 32 +++++++++++++++++++-------------
 arch/x86/lib/usercopy_64.c               |  1 +
 arch/x86/math-emu/fpu_entry.c            |  1 +
 arch/x86/mm/highmem_32.c                 |  1 +
 arch/x86/mm/pat/set_memory.c             |  2 +-
 arch/x86/pci/ce4100.c                    |  4 ++--
 arch/x86/platform/olpc/olpc_dt.c         |  2 +-
 arch/x86/video/fbdev.c                   |  1 +
 include/linux/io.h                       |  5 +++++
 include/linux/olpc-ec.h                  |  2 ++
 include/linux/suspend.h                  |  4 ++++
 kernel/power/power.h                     |  5 -----
 mm/internal.h                            |  6 ------
 28 files changed, 78 insertions(+), 54 deletions(-)
