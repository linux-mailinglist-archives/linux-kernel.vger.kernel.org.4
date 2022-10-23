Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F0609205
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJWJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJWJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:36:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6313C71BD9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:36:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 823C61FD4A;
        Sun, 23 Oct 2022 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666517807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a2CSw/8rZWkxUuRs5fo3QIrgID+nd0kedAMIW6JAgs4=;
        b=Ek5FzeCC+vIbrz4H25njCQQRQbFsMAnE+b0rYXimqtQvhMSkC+ZvkJE119Yjz+/+8QLiw5
        Kwi8OHs1T9v+nUNRqfnPyplYjHGlRCtT+CkGz20jyW2T+DucEDPLgIxiKaBXCjjil64Qmt
        dt2QTETT8YOOBKW3yp89k+/6Lc5kj34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666517807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a2CSw/8rZWkxUuRs5fo3QIrgID+nd0kedAMIW6JAgs4=;
        b=pZFBjLLQe/FJ/+aMAObfXsc/CEm0rJq9HVSgJiPZPow7I6er8Q8It+58ay60zLcuZ5aCOr
        OuquBb4nzrc4BhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7637B139F0;
        Sun, 23 Oct 2022 09:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H4nNHC8LVWPQMwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Oct 2022 09:36:47 +0000
Date:   Sun, 23 Oct 2022 11:36:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 6.1
Message-ID: <Y1ULKYsASLRoVb7N@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as it is usually the case, right after a major release, the tip urgent
branches accumulate a couple more fixes than normal. And here is the
x86, a bit bigger, urgent pile.

Please pull,
thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0_rc2

for you to fetch changes up to 471f0aa7fa64e23766a1473b32d9ec3f0718895a:

  x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly (2022-10-21 15:22:09 -0700)

----------------------------------------------------------------
- Use the correct CPU capability clearing function on the error path in
  Intel perf LBR

- A CFI fix to ftrace along with a simplification

- Adjust handling of zero capacity bit mask for resctrl cache allocation
  on AMD

- A fix to the AMD microcode loader to attempt patch application on
  every logical thread

- A couple of topology fixes to handle CPUID leaf 0x1f enumeration info
  properly

- Drop a -mabi=ms compiler option check as both compilers support it now
  anyway

- A couple of fixes to how the initial, statically allocated FPU buffer
  state is setup and its interaction with dynamic states at runtime

----------------------------------------------------------------
Babu Moger (1):
      x86/resctrl: Fix min_cbm_bits for AMD

Borislav Petkov (1):
      x86/microcode/AMD: Apply the patch early on every logical thread

Chang S. Bae (4):
      x86/fpu: Configure init_fpstate attributes orderly
      x86/fpu: Fix the init_fpstate size check with the actual size
      x86/fpu: Exclude dynamic states from init_fpstate
      x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

Maxim Levitsky (1):
      perf/x86/intel/lbr: Use setup_clear_cpu_cap() instead of clear_cpu_cap()

Nathan Chancellor (1):
      x86/Kconfig: Drop check for -mabi=ms for CONFIG_EFI_STUB

Peter Zijlstra (2):
      x86/ftrace: Remove ftrace_epilogue()
      ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()

Zhang Rui (3):
      hwmon/coretemp: Handle large core ID value
      x86/topology: Fix multiple packages shown on a single-package system
      x86/topology: Fix duplicated core ID within a package

 arch/arm64/kernel/entry-ftrace.S    |  7 ++++-
 arch/x86/Kconfig                    |  1 -
 arch/x86/events/intel/lbr.c         |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c | 16 +++++++++--
 arch/x86/kernel/cpu/resctrl/core.c  |  8 ++----
 arch/x86/kernel/cpu/topology.c      | 16 +++++++----
 arch/x86/kernel/fpu/init.c          |  8 ------
 arch/x86/kernel/fpu/xstate.c        | 42 +++++++++++++++-------------
 arch/x86/kernel/ftrace_64.S         | 34 +++++++++-------------
 drivers/hwmon/coretemp.c            | 56 +++++++++++++++++++++++++++----------
 include/asm-generic/vmlinux.lds.h   | 18 ++++++++----
 11 files changed, 122 insertions(+), 86 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
