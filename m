Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549885F456B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJDO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJDO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:26:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F260236849
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:26:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACB3321993;
        Tue,  4 Oct 2022 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664893566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ayRdI8+kHfUZzA5cpgP5P606RzHFtWCs3aHQypzSoDg=;
        b=lFbY/rPAjQhjftYk8VvCQiWcrAb5r6R8IFq45ZM6eM5z9giiVOMtATzyMR+XdeC7SvIFrH
        7ffcwWKG8XO3CQA52SvEzNxO20XigjKBsXUkj5D7zWDOSNl8i3N7kOSlVxPOb0yV6HPuuM
        SMucxAdzLzI4MLRq7qjzwxIjXCw6WdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664893566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ayRdI8+kHfUZzA5cpgP5P606RzHFtWCs3aHQypzSoDg=;
        b=YW3gxc0rk+i88MV0OzEHWaLxnaJ9z1SfxwsgFfPHIMhqZad8eyf/NltXqlchwFKi+uXFeg
        Isf7IqBxTBvQzyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A090E139EF;
        Tue,  4 Oct 2022 14:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I3YvJ35CPGMcdgAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 14:26:06 +0000
Date:   Tue, 4 Oct 2022 16:26:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for 6.1
Message-ID: <YzxCfhYNjqfl2DFK@zn.tnic>
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

the x86/cache branch saw a lot more action this time around. Please
pull.

Thx.

---
The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.1_rc1

for you to fetch changes up to f7b1843eca6fe295ba0c71fc02a3291954078f2b:

  x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes (2022-09-23 14:25:05 +0200)

----------------------------------------------------------------
- More work by James Morse to disentangle the resctrl filesystem generic
code from the architectural one with the endgoal of plugging ARM's MPAM
implementation into it too so that the user interface remains the same

- Properly restore the MSR_MISC_FEATURE_CONTROL value instead of blindly
overwriting it to 0

----------------------------------------------------------------
James Morse (21):
      x86/resctrl: Kill off alloc_enabled
      x86/resctrl: Merge mon_capable and mon_enabled
      x86/resctrl: Add domain online callback for resctrl work
      x86/resctrl: Group struct rdt_hw_domain cleanup
      x86/resctrl: Add domain offline callback for resctrl work
      x86/resctrl: Remove set_mba_sc()s control array re-initialisation
      x86/resctrl: Abstract and use supports_mba_mbps()
      x86/resctrl: Create mba_sc configuration in the rdt_domain
      x86/resctrl: Switch over to the resctrl mbps_val list
      x86/resctrl: Remove architecture copy of mbps_val
      x86/resctrl: Allow update_mba_bw() to update controls directly
      x86/resctrl: Calculate bandwidth from the previous __mon_event_count() chunks
      x86/resctrl: Add per-rmid arch private storage for overflow and chunks
      x86/resctrl: Allow per-rmid arch private storage to be reset
      x86/resctrl: Abstract __rmid_read()
      x86/resctrl: Pass the required parameters into resctrl_arch_rmid_read()
      x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
      x86/resctrl: Move get_corrected_mbm_count() into resctrl_arch_rmid_read()
      x86/resctrl: Rename and change the units of resctrl_cqm_threshold
      x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's boot_cpu_data
      x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes

Kohei Tarumizu (1):
      x86/resctrl: Fix to restore to original value when re-enabling hardware prefetch register

 arch/x86/include/asm/resctrl.h            |   9 ++
 arch/x86/kernel/cpu/resctrl/core.c        | 117 +++++----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 +++++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  61 ++++----
 arch/x86/kernel/cpu/resctrl/monitor.c     | 232 +++++++++++++++++++-----------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 216 +++++++++++++++++++++++-----
 include/linux/resctrl.h                   |  64 ++++++++-
 8 files changed, 523 insertions(+), 265 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
