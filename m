Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7535764A7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiLLTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiLLTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:15:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD72613CCD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670872541; x=1702408541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LwreiDcR9VjlgS4szTKVrgupxDG5c6jZMZHvnhDMPUo=;
  b=mICXtfmtqiH7jVwchM17TJRpTsKDLTyBgn9y4gK6L9r1wPIZxGBfVkza
   Y6jGSA0nEdVziT+LaiSe+DUTju8ko7x46E3vZtFxSlVm3e2rzJ2WmODAe
   5JElOEqpHshXMFhZNW6PPCUlfYMxXXhgkI8pcR1QWX2XneUtKtAoLRnAT
   3R/qltoafggugDyUnLS6wdT9xiYLJ4Jn+NunL3KdAuHOS65ZcTnr/lEuk
   52JhuZhr4prA27TKSbaFouKVWBDuZHukyaEyBZ1EOvpzCSSjfcOXktoEu
   JIlwQrK6jiPq3AuAIYgaE+PuR36Nl+9TxFxV/GsTk64G3WoXuOkhL61+K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="317973425"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="317973425"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 11:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="716911515"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="716911515"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2022 11:15:23 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT PULL] x86/cache for 6.2
Date:   Mon, 12 Dec 2022 11:15:23 -0800
Message-Id: <20221212191523.553233-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/cache changes for v6.2.  These declare the
resource control (rectrl) MSRs a bit more normally and clean up
an unnecessary structure member.

--

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.2

for you to fetch changes up to 97fa21f65c3eb5bbab9b4734bed37fd624cddd86:

  x86/resctrl: Move MSR defines into msr-index.h (2022-11-27 23:00:45 +0100)

----------------------------------------------------------------
Minor cleanups:
 * Remove unnecessary arch_has_empty_bitmaps structure memory
 * Move rescrtl MSR defines into msr-index.h, like normal MSRs

----------------------------------------------------------------
Babu Moger (1):
      x86/resctrl: Remove arch_has_empty_bitmaps

Borislav Petkov (1):
      x86/resctrl: Move MSR defines into msr-index.h

 arch/x86/include/asm/msr-index.h          | 21 +++++++++++++++------
 arch/x86/include/asm/resctrl.h            |  8 +++-----
 arch/x86/kernel/cpu/resctrl/core.c        |  4 +---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +--
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
 include/linux/resctrl.h                   |  6 +++---
 7 files changed, 25 insertions(+), 31 deletions(-)
