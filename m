Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A726129B1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJ3Jpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJ3JpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:45:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29089D2E5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:44:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBD8233A12;
        Sun, 30 Oct 2022 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667123072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TpSnwwVoTvTa+Iz5l9GerfTccR8vy/JKwptFZiJo7pg=;
        b=lIhlqxyY2zvZbaQe0D7S7i97pDW0AWukiWCvEKQk9HRGjwB3AD3CY/bx6yYEYqidX0vA0D
        ZZaImaLF1BCI225lX5y3uX/5eyWZ288ZEJp6RV1yi6MMVEPT1/zCuLPekm+1OgrwVfn5kn
        K97OBVHkyf7Mb9HOSu7xr4KXNEja9+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667123072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TpSnwwVoTvTa+Iz5l9GerfTccR8vy/JKwptFZiJo7pg=;
        b=FKPcOZCWTSv64YGMYzkivtWVQHK1WYjlYb79ejR6VXGlOpIys521JwLiKb1iwlfGLh4QpJ
        8q+4EloRUqhp3qAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2F9B13A37;
        Sun, 30 Oct 2022 09:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ID3AJ4BHXmPHKgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 30 Oct 2022 09:44:32 +0000
Date:   Sun, 30 Oct 2022 10:44:27 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 6.1-rc3
Message-ID: <Y15He+PfiChMoTJv@zn.tnic>
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

please pull a couple of urgent perf fixes for 6.1.

Thx.

---

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc3

for you to fetch changes up to cb6c18b5a41622c7a439508f7421f8766a91cb87:

  perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL (2022-10-27 10:27:32 +0200)

----------------------------------------------------------------
- Rename a perf memory level event define to denote it is of CXL type

- Add Alder and Raptor Lakes support to RAPL

- Make sure raw sample data is output with tracepoints

----------------------------------------------------------------
James Clark (1):
      perf: Fix missing raw data on tracepoint events

Ravi Bangoria (1):
      perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL

Zhang Rui (2):
      perf/x86/rapl: Add support for Intel AlderLake-N
      perf/x86/rapl: Add support for Intel Raptor Lake

 arch/x86/events/amd/ibs.c       | 2 +-
 arch/x86/events/rapl.c          | 4 ++++
 include/uapi/linux/perf_event.h | 2 +-
 kernel/events/core.c            | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
