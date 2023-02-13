Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71BE695398
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBMWIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBMWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:08:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4892CA273;
        Mon, 13 Feb 2023 14:08:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82E361307;
        Mon, 13 Feb 2023 22:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C3C433D2;
        Mon, 13 Feb 2023 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676326093;
        bh=i9TwxVSkwgF61NSvkuQGhtwSNYbYXtVRB5snHY42JT4=;
        h=Date:From:To:Cc:Subject:From;
        b=m9f+uxmpllO3COwWCrYPSMgMAkOTiYOR89B3+p6yWZZ7W/ezpY7EyU3BvxZBIEzz6
         zvc/sstoItjneWiws7N6TS5dKetP4vC/BxAIWueDpoZB1R3oVqdrTeJc3023TYMlKq
         iDHA4XVpoBjX1bn/GTsd0dau5UjColuD86z84dVc=
Date:   Mon, 13 Feb 2023 14:08:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.2
Message-Id: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
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


Linus, please merge this batch of fixes, thanks.


The following changes since commit ac86f547ca1002aec2ef66b9e64d03f45bbbfbb9:

  mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty_slowpath() (2023-01-31 16:44:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-13-13-50

for you to fetch changes up to ce4d9a1ea35ac5429e822c4106cb2859d5c71f3e:

  of: reserved_mem: Have kmemleak ignore dynamically allocated reserved mem (2023-02-09 15:56:51 -0800)

----------------------------------------------------------------
12 hotfixes, mostly against mm/.  Five of these fixes are cc:stable.

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      mailmap: add entry for Alexander Mikhalitsyn

Andrew Morton (1):
      revert "squashfs: harden sanity check in squashfs_read_xattr_id_table"

Arnd Bergmann (1):
      mm: extend max struct page size for kmsan

Christophe Leroy (1):
      kasan: fix Oops due to missing calls to kasan_arch_is_ready()

Isaac J. Manjarres (1):
      of: reserved_mem: Have kmemleak ignore dynamically allocated reserved mem

Jeff Xie (1):
      scripts/gdb: fix 'lx-current' for x86

Kefeng Wang (1):
      mm: hwpoison: support recovery from ksm_might_need_to_copy()

Kuan-Ying Lee (1):
      mm/gup: add folio to list when folio_isolate_lru() succeed

Li Lingfeng (1):
      lib: parser: optimize match_NUMBER apis to use local array

Qi Zheng (1):
      mm: shrinkers: fix deadlock in shrinker debugfs

Seth Jenkins (1):
      aio: fix mremap after fork null-deref

Shiyang Ruan (1):
      fsdax: dax_unshare_iter() should return a valid length

 .mailmap                     |  2 ++
 drivers/of/of_reserved_mem.c |  3 ++-
 fs/aio.c                     |  4 ++++
 fs/dax.c                     |  5 +++--
 fs/squashfs/xattr_id.c       |  2 +-
 include/linux/mm.h           | 12 +++++++++---
 include/linux/shrinker.h     |  5 +++--
 lib/parser.c                 | 39 ++++++++++++++++++++-------------------
 mm/gup.c                     |  2 +-
 mm/kasan/common.c            |  3 +++
 mm/kasan/generic.c           |  7 ++++++-
 mm/kasan/shadow.c            | 12 ++++++++++++
 mm/ksm.c                     |  7 +++++--
 mm/memory.c                  |  3 +++
 mm/shrinker_debug.c          | 13 ++++++++-----
 mm/swapfile.c                | 20 ++++++++++++++------
 mm/vmscan.c                  |  6 +++++-
 scripts/gdb/linux/cpus.py    |  2 +-
 18 files changed, 102 insertions(+), 45 deletions(-)

