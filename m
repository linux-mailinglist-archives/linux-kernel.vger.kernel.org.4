Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE180682F82
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjAaOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjAaOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:42:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA943933;
        Tue, 31 Jan 2023 06:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3089A61545;
        Tue, 31 Jan 2023 14:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BC7C433D2;
        Tue, 31 Jan 2023 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176152;
        bh=PVL8pzYrXQLxkNp/hZkDnpMwVuGdtCOb52DzFha9bEs=;
        h=From:To:Cc:Subject:Date:From;
        b=LuDLVX7di/gVHcb0ZxtiajeQD/9JB+9+KEQ9+ZR3+lIDxm3lQjNAHP0Uttbb49rjr
         M/KQOSRugNhjPN/cCUUdMCcFDmKVIKm7xKrmCadXsvEtGRQJb3+/ODsb+U31wgmzYJ
         pvhWTWGsLhhn4ZC5lluZisrIA0nSvWHdPyxnVd5sheiSkfTQEC0jX6GM9X7alhMZcJ
         dleuE4YeK31vfR19cnz1G7bc72bHAhFNPljWr93k6qqssInE5Fyfdms8AruvXLXKOZ
         Q2xBSK/46DazrQqUNoJD1r0OXQsNxwhAlProsKod9rXhnnKnnPoimDVmUvKbroldyU
         t5gX6r0znRbtA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/2] docs/mm: remove useless markup
Date:   Tue, 31 Jan 2023 16:42:18 +0200
Message-Id: <20230131144220.822989-1-rppt@kernel.org>
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

v2:
* fix missed reference in zn_CH translation (kbuild)

v1: https://lore.kernel.org/all/20230129075018.207678-1-rppt@kernel.org

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
 .../translations/zh_CN/admin-guide/mm/index.rst     |  2 +-
 40 files changed, 20 insertions(+), 100 deletions(-)


base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
-- 
2.35.1

