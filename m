Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D480467FD70
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 08:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjA2Huh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 02:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjA2Hue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 02:50:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABE1212A4;
        Sat, 28 Jan 2023 23:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46EF7B80C69;
        Sun, 29 Jan 2023 07:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FA9C433EF;
        Sun, 29 Jan 2023 07:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674978630;
        bh=sITnkyDafQ250XMA34b7bUz9hNoHQuoMCW7+J0vMSiw=;
        h=From:To:Cc:Subject:Date:From;
        b=YC+j3LStP9TKJ7Qja46xKSuxOfCXB9bROFg6M4W1jWUdwk8GWAO4Jk5udyZkDAxQN
         xMOBxtj2uC4R7UDXDS+uBRciIoZj0+yQmmk9lFPWsH1fKnBsmEKqFMtm1hrSXqrczI
         k8G2L7n6UhIAIbMY3aaq56V9t1Pyve5yp862wQ7R0fRsD4bdp15z5H76yRtNcLHPoU
         34Oq6TswyhuAz8WC3hVTfz4yLZ+OgXAg5QAkjNrOOpMWeEKSQEscy3XJrvXaJl5Nj5
         Mwur6gdTdnvJWrfCuYbx7JtX+epClYaQWJOJ7tHBvJpU/BhRlY4pAuVknbCCry0MVT
         b/k+ni7B9/cKQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 0/2] docs/mm: remove useless markup
Date:   Sun, 29 Jan 2023 09:50:16 +0200
Message-Id: <20230129075018.207678-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

Following Jon's gripe about top-of-file labels [1], I went ahead and
updated admin-guide/mm and mm docs to use file names instead of labels for
document cross-referencing.

[1] https://lore.kernel.org/all/87r0vh9n17.fsf@meer.lwn.net

Mike Rapoport (IBM) (2):
  docs/admin-guide/mm: remove useless markup
  docs/mm: remove useless markup

 Documentation/admin-guide/mm/concepts.rst           | 13 +++++--------
 Documentation/admin-guide/mm/hugetlbpage.rst        |  4 +---
 Documentation/admin-guide/mm/idle_page_tracking.rst |  7 ++-----
 Documentation/admin-guide/mm/index.rst              |  3 +--
 Documentation/admin-guide/mm/ksm.rst                |  2 --
 Documentation/admin-guide/mm/memory-hotplug.rst     |  2 --
 Documentation/admin-guide/mm/numa_memory_policy.rst |  2 --
 Documentation/admin-guide/mm/numaperf.rst           |  2 --
 Documentation/admin-guide/mm/pagemap.rst            | 11 ++++-------
 Documentation/admin-guide/mm/shrinker_debugfs.rst   |  2 --
 Documentation/admin-guide/mm/soft-dirty.rst         |  2 --
 Documentation/admin-guide/mm/swap_numa.rst          |  2 --
 Documentation/admin-guide/mm/transhuge.rst          |  2 --
 Documentation/admin-guide/mm/userfaultfd.rst        |  2 --
 Documentation/admin-guide/mm/zswap.rst              |  2 --
 Documentation/mm/active_mm.rst                      |  2 --
 Documentation/mm/arch_pgtable_helpers.rst           |  2 --
 Documentation/mm/balance.rst                        |  2 --
 Documentation/mm/free_page_reporting.rst            |  2 --
 Documentation/mm/frontswap.rst                      |  2 --
 Documentation/mm/highmem.rst                        |  2 --
 Documentation/mm/hmm.rst                            |  4 +---
 Documentation/mm/hugetlbfs_reserv.rst               |  4 +---
 Documentation/mm/hwpoison.rst                       |  2 --
 Documentation/mm/ksm.rst                            |  4 +---
 Documentation/mm/memory-model.rst                   |  2 --
 Documentation/mm/mmu_notifier.rst                   |  2 --
 Documentation/mm/numa.rst                           |  4 +---
 Documentation/mm/page_frags.rst                     |  2 --
 Documentation/mm/page_migration.rst                 |  6 ++----
 Documentation/mm/page_owner.rst                     |  2 --
 Documentation/mm/page_table_check.rst               |  2 --
 Documentation/mm/remap_file_pages.rst               |  2 --
 Documentation/mm/slub.rst                           |  2 --
 Documentation/mm/split_page_table_lock.rst          |  2 --
 Documentation/mm/transhuge.rst                      |  2 --
 Documentation/mm/unevictable-lru.rst                |  2 --
 Documentation/mm/z3fold.rst                         |  2 --
 Documentation/mm/zsmalloc.rst                       |  2 --
 39 files changed, 19 insertions(+), 99 deletions(-)

-- 
2.35.1

