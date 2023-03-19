Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34B36C01C5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCSM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:57:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02081149B8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:57:01 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77A231EC0657;
        Sun, 19 Mar 2023 13:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679230620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=+v5SPNv0OGKo/HJnWg7pJHZ9ItajWRpxnH3aUeap/PY=;
        b=NOq+xL1Q3G65b4zEadoWPlgvQQmaJHTvjw365U74FsjDDzcMBH4uRc2Cz+syjOkD5c6das
        GcsqhFZwRpZQ7sD38+U2JjjR9+qzGtQt9xY59XznkdOqxDetW70JGZstZymJFea5foqhhq
        QqEXkbIKYNxt4TBSlQJufT56RNtfetA=
Date:   Sun, 19 Mar 2023 13:56:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.3-rc3
Message-ID: <20230319125655.GBZBcGl5kNdF8qMFJU@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three urgent perf fixes for 6.3.

Thx.

---

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.3_rc3

for you to fetch changes up to fd0815f632c24878e325821943edccc7fde947a2:

  perf: Fix check before add_event_to_groups() in perf_group_detach() (2023-03-15 21:49:47 +0100)

----------------------------------------------------------------
- Check whether sibling events have been deactivated before adding them
  to groups

- Update the proper event time tracking variable depending on the
  event type

- Fix a memory overwrite issue due to using the wrong function argument
  when outputting perf events

----------------------------------------------------------------
Budimir Markovic (1):
      perf: Fix check before add_event_to_groups() in perf_group_detach()

Song Liu (1):
      perf: fix perf_event_context->time

Yang Jihong (1):
      perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output

 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
