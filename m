Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46463609247
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJWKPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 06:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJWKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 06:15:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373757895
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 03:15:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D17EC1FD4A;
        Sun, 23 Oct 2022 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666520141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lUwWVi+RZkHeWALq2yE+VkXRFffNsKsCIXrbyEHrrzs=;
        b=chW0KU0ITFjg1b3cxgv8jNTZVBuMYEwJFLmD4c9OTcCkEsde64Idzk3wS1/wybO8QIpo6k
        K911yH0cM40ELMZpHCaGIzpr5lyf5BUop1n8nGebx+Nl/E/E1VRsA0aqiw2EmLutrU6BgB
        c/gj8QavotFVIH8QRe3gOXbU/hcsUFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666520141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lUwWVi+RZkHeWALq2yE+VkXRFffNsKsCIXrbyEHrrzs=;
        b=u9DNyhsfzK0vnP9MRPKpDX4LCci/NdXdPFfTeBaAOLtHg2I1Z5I35bGzkfmHFvlFcVmXsD
        4AwmYNxkq6mQNcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4B8C139F0;
        Sun, 23 Oct 2022 10:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id urv4L00UVWPZQgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 23 Oct 2022 10:15:41 +0000
Date:   Sun, 23 Oct 2022 12:15:37 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 6.1
Message-ID: <Y1UUSef0KUKy2RUE@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

by popular demand, here are a couple of urgent perf fixes for 6.1.

Please pull,
thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc2

for you to fetch changes up to 21da7472a040420f2dc624ffec70291a72c5d6a6:

  bpf: Fix sample_flags for bpf_perf_event_output (2022-10-17 16:32:06 +0200)

----------------------------------------------------------------
- Fix raw data handling when perf events are used in bpf

- Rework how SIGTRAPs get delivered to events to address a bunch of
  problems with it. Add a selftest for that too

----------------------------------------------------------------
Marco Elver (1):
      selftests/perf_events: Add a SIGTRAP stress test with disables

Peter Zijlstra (1):
      perf: Fix missing SIGTRAPs

Sumanth Korikkar (1):
      bpf: Fix sample_flags for bpf_perf_event_output

 include/linux/perf_event.h                         |  19 ++-
 kernel/events/core.c                               | 151 +++++++++++++++------
 kernel/events/ring_buffer.c                        |   2 +-
 kernel/trace/bpf_trace.c                           |   2 +
 .../selftests/perf_events/sigtrap_threads.c        |  35 ++++-
 5 files changed, 163 insertions(+), 46 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
