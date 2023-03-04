Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3886AACAB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 22:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCDVPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 16:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:15:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB38113CC;
        Sat,  4 Mar 2023 13:15:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2E69B808CA;
        Sat,  4 Mar 2023 21:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA9C433EF;
        Sat,  4 Mar 2023 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677964529;
        bh=+Y2m+IP7jGozXAwj2nxeYFm6U7IKcWCRftHdfTjrJ2U=;
        h=Date:From:To:Cc:Subject:From;
        b=jN/aVVCIJ8QjG7BSMP55SHkm81LHpDUpGWvgxSY2Q284j2zC2quO92kGfGt8K6j1f
         FGLSToNjxEwgTwZUjLnj4MLZwYw+MFqWt10D5GqWfaFpH13ZGXL2T6BkCRGOM+CxgN
         3SClZtRvRYSpql9qhTDgdmsUvrpSo3Cd9sAoPSyc=
Date:   Sat, 4 Mar 2023 13:15:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.3-rc1
Message-Id: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.

The following changes since commit 1ec35eadc3b448c91a6b763371a7073444e95f9d:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2023-02-25 15:16:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-04-13-12

for you to fetch changes up to ecf1d926661bec4080a79c0ac9dbfe02b31702cf:

  mailmap: map Dikshita Agarwal's old address to his current one (2023-03-02 21:54:24 -0800)

----------------------------------------------------------------
17 hotfixes.  Eight are for MM and seven are for other parts of the
kernel.  Seven are cc:stable and eight address post-6.3 issues or were
judged unsuitable for -stable backporting.

----------------------------------------------------------------
Andrew Morton (1):
      fs/cramfs/inode.c: initialize file_ra_state

Dongliang Mu (1):
      fs: hfsplus: fix UAF issue in hfsplus_put_super

Eric Biggers (1):
      lib: parser: update documentation for match_NUMBER functions

Guilherme G. Piccoli (1):
      panic: fix the panic_print NMI backtrace setting

Heming Zhao via Ocfs2-devel (2):
      ocfs2: fix defrag path triggering jbd2 ASSERT
      ocfs2: fix non-auto defrag path not working issue

Konrad Dybcio (3):
      mailmap: map Georgi Djakov's old Linaro address to his current one
      mailmap: map Vikash Garodia's old address to his current one
      mailmap: map Dikshita Agarwal's old address to his current one

Marco Elver (4):
      kasan: emit different calls for instrumentable memintrinsics
      kasan: treat meminstrinsic as builtins in uninstrumented files
      kasan: test: fix test for new meminstrinsic instrumentation
      kasan, x86: don't rename memintrinsics in uninstrumented files

Mikhail Zaslonko (1):
      lib/zlib: DFLTCC deflate does not write all available bits for Z_NO_FLUSH

Naoya Horiguchi (1):
      mm/hwpoison: convert TTU_IGNORE_HWPOISON to TTU_HWPOISON

Vlastimil Babka (1):
      mm/mremap: fix dup_anon_vma() in vma_merge() case 4

andrew.yang (1):
      mm/damon/paddr: fix missing folio_put()

 .mailmap                         |  3 +++
 arch/x86/include/asm/string_64.h | 19 -----------------
 fs/cramfs/inode.c                |  2 +-
 fs/hfsplus/super.c               |  4 ++--
 fs/ocfs2/move_extents.c          | 34 ++++++++++++-------------------
 include/linux/rmap.h             |  2 +-
 kernel/panic.c                   | 44 ++++++++++++++++++++++++----------------
 lib/Kconfig.kasan                |  9 ++++++++
 lib/parser.c                     | 14 ++++++-------
 lib/zlib_deflate/defutil.h       |  4 +++-
 mm/damon/paddr.c                 |  7 +++----
 mm/kasan/Makefile                |  9 +++++++-
 mm/kasan/kasan.h                 |  4 ++++
 mm/kasan/kasan_test.c            | 29 ++++++++++++++++++++++++++
 mm/kasan/shadow.c                | 16 ++++++++++++++-
 mm/memory-failure.c              |  8 ++++----
 mm/mmap.c                        |  2 +-
 mm/rmap.c                        |  2 +-
 scripts/Makefile.kasan           | 17 ++++++++++++++++
 19 files changed, 147 insertions(+), 82 deletions(-)

