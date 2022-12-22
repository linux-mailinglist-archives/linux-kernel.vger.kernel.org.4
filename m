Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5EE6548B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLVWqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVWqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:46:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02C15805;
        Thu, 22 Dec 2022 14:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F14861DB6;
        Thu, 22 Dec 2022 22:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505FDC433EF;
        Thu, 22 Dec 2022 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671749209;
        bh=uDvMQxnpistxp86ARXjK5OoHAXBlFc4XFFQSaDuieFE=;
        h=Date:From:To:Cc:Subject:From;
        b=UUVu+xPi76j95dibDzNOkQtqdOK77giSpb38zHwBZ0j8z+HtSumA4db5jWk4ftWej
         pk4gu0t1ACGnr0oBH1X6su7w4hCJjao9Sw5CbSfd96Gjmr5gTFw25qtNnyMVfR+hY6
         58MRMqeaacUzZAcmw/67E3i1J5J01zPksqnxWX2w=
Date:   Thu, 22 Dec 2022 14:46:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.2-rc1
Message-Id: <20221222144648.db034ee4087ea4bb126545ec@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes.

Thanks.


The following changes since commit 1644d755d0b06d0f1ee93e1c44336c29386546b4:

  Merge branch 'linus' (2022-12-20 15:02:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-22-14-34

for you to fetch changes up to e96b95c2b7a63a454b6498e2df67aac14d046d13:

  gcov: add support for checksum field (2022-12-21 14:31:52 -0800)

----------------------------------------------------------------
Eight fixes, all cc:stable.   One is for gcov and the remainder are MM.

----------------------------------------------------------------
Arnd Bergmann (2):
      kmsan: include linux/vmalloc.h
      kmsan: export kmsan_handle_urb

Liam Howlett (2):
      maple_tree: fix mas_spanning_rebalance() on insufficient data
      test_maple_tree: add test for mas_spanning_rebalance() on insufficient data

Mathieu Desnoyers (1):
      mm/mempolicy: fix memory leak in set_mempolicy_home_node system call

Mike Kravetz (1):
      hugetlb: really allocate vma lock for all sharable vmas

Rickard x Andersson (1):
      gcov: add support for checksum field

Vlastimil Babka (1):
      mm, mremap: fix mremap() expanding vma with addr inside vma

 kernel/gcov/gcc_4_7.c |   5 +
 lib/maple_tree.c      |   4 +-
 lib/test_maple_tree.c |  23 ++++
 mm/hugetlb.c          | 333 ++++++++++++++++++++++----------------------------
 mm/kmsan/hooks.c      |   1 +
 mm/kmsan/kmsan_test.c |   1 +
 mm/mempolicy.c        |   1 +
 mm/mremap.c           |   3 +-
 8 files changed, 184 insertions(+), 187 deletions(-)

