Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94964FD9B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 05:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLREbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 23:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLREay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 23:30:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2FF10DD;
        Sat, 17 Dec 2022 20:30:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E8D2B802C6;
        Sun, 18 Dec 2022 04:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33FFC433EF;
        Sun, 18 Dec 2022 04:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671337849;
        bh=29vipqUzgRfr8/xX4ev9TCXklk9mjpLvKRNUDuszUEY=;
        h=Date:From:To:Cc:Subject:From;
        b=JGSK2bL0MJ4wCfGHWYXNeJCS3Orm03UZURiSYSEE7/HBDyhVKlHSEdWRpmoVFVSmf
         RvDK6SH/0uv1VWprHqxKWS1YsStXQ7EtC9d8ppsSsrFDMbaQ3a8qR2YZGf2HAgYyoh
         T5x1b3lyNkVJo6JweGgiTAitYAPisSLDZARLVMYg=
Date:   Sat, 17 Dec 2022 20:30:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] Final MM updates for 6.2-rc1
Message-Id: <20221217203048.c502a0c0ba87b5be1bfb7824@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this handful of leftovers.

Thanks.



The following changes since commit 8fa590bf344816c925810331eea8387627bbeb40:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2022-=
12-15 11:12:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022=
-12-17-2

for you to fetch changes up to 8b777594d2341a82f00b57c020f8af05bded1178:

  MAINTAINERS: zram: zsmalloc: Add an additional co-maintainer (2022-12-15 =
16:37:49 -0800)

----------------------------------------------------------------
- A few late-breaking minor fixups

- Two minor feature patches which were awkwardly dependent on mm-nonmm.
  I need to set up a new branch to handle such things.

----------------------------------------------------------------
Cl=E9ment L=E9ger (1):
      mm/kmemleak: use %pK to display kernel pointers in backtrace

David Hildenbrand (1):
      mm/gup_test: free memory allocated via kvcalloc() using kvfree()

Liam Howlett (2):
      maple_tree: fix mas_find_rev() comment
      maple_tree: update copyright dates for test code

Minchan Kim (1):
      MAINTAINERS: zram: zsmalloc: Add an additional co-maintainer

Zhaoyang Huang (1):
      mm: use stack_depot for recording kmemleak's backtrace

 CREDITS                          |  4 ++++
 MAINTAINERS                      |  6 ++---
 lib/Kconfig.debug                |  1 +
 lib/maple_tree.c                 |  2 +-
 mm/gup_test.c                    |  4 ++--
 mm/kmemleak.c                    | 48 ++++++++++++++++++++++++------------=
----
 tools/testing/radix-tree/maple.c |  5 +++--
 7 files changed, 42 insertions(+), 28 deletions(-)

