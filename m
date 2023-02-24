Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8E6A1979
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBXKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBXKEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:04:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C4497DF;
        Fri, 24 Feb 2023 02:03:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F14B81C0D;
        Fri, 24 Feb 2023 10:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C969C4339C;
        Fri, 24 Feb 2023 10:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677233001;
        bh=JcaoNJrrzRyblpW44xrHcPtS0V3c05D77kFNfjfdkPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqvMft38tVREJubaC2DooLNUN3Ztr+TBXiRP83DAotj2mkYrV5NPXCHw85IOEFV7b
         GDiow14+ht6yhJoK1ati/hFrGb7LZE4z6cw9rUTMSTng3mmssj0Y7TsEEKq2embSpF
         E2uEOFpfl9/0mozpXdUVe+yg1cphFMpUi1FYoeHWEZikXaees5sWHD/QGEDQ+CZLJ4
         jpsEYunhrIDJ9M3UGARZYF0oxficE2snPIO8+zpAJ8UKR13aYZvjgCWJP32H26MGnq
         ApwM8ssuY8TwSYIv7AOHpZ7so+XjaCIx9nsYVXg8yDqE7RtdHpy8J50QHvQSDwiVY6
         +3NAziroN2rbA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     kernel test robot <lkp@intel.com>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/mm: hugetlbfs_reserv: fix a reference to a file that doesn't exist
Date:   Fri, 24 Feb 2023 12:03:06 +0200
Message-Id: <20230224100306.2287696-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230224100306.2287696-1-rppt@kernel.org>
References: <20230224100306.2287696-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_20,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

kbuild reports:

>> Warning: Documentation/mm/hugetlbfs_reserv.rst references a file that doesn't exist: Documentation/mm/hugetlbpage.rst
>> Warning: Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst references a file that doesn't exist: Documentation/mm/hugetlbpage.rst

Fix the filename to be 'Documentation/admin-guide/mm/hugetlbpage.rst'.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302231854.sKlCmx9K-lkp@intel.com/
Fixes: ee86588960e2 ("docs/mm: remove useless markup")
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/hugetlbfs_reserv.rst                    | 8 ++++----
 Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hugetlbfs_reserv.rst
index 05a44760da32..f2fdcd637f97 100644
--- a/Documentation/mm/hugetlbfs_reserv.rst
+++ b/Documentation/mm/hugetlbfs_reserv.rst
@@ -5,10 +5,10 @@ Hugetlbfs Reservation
 Overview
 ========
 
-Huge pages as described at Documentation/mm/hugetlbpage.rst are typically
-preallocated for application use.  These huge pages are instantiated in a
-task's address space at page fault time if the VMA indicates huge pages are
-to be used.  If no huge page exists at page fault time, the task is sent
+Huge pages as described at Documentation/admin-guide/mm/hugetlbpage.rst are
+typically preallocated for application use.  These huge pages are instantiated
+in a task's address space at page fault time if the VMA indicates huge pages
+are to be used.  If no huge page exists at page fault time, the task is sent
 a SIGBUS and often dies an unhappy death.  Shortly after huge page support
 was added, it was determined that it would be better to detect a shortage
 of huge pages at mmap() time.  The idea is that if there were not enough
diff --git a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
index 80787af29222..f1f0bdf27676 100644
--- a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
+++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
@@ -15,7 +15,8 @@ Hugetlbfs 预留
 概述
 ====
 
-Documentation/mm/hugetlbpage.rst 中描述的巨页通常是预先分配给应用程序使用的。如果VMA指
+Documentation/admin-guide/mm/hugetlbpage.rst
+中描述的巨页通常是预先分配给应用程序使用的 。如果VMA指
 示要使用巨页，这些巨页会在缺页异常时被实例化到任务的地址空间。如果在缺页异常
 时没有巨页存在，任务就会被发送一个SIGBUS，并经常不高兴地死去。在加入巨页支
 持后不久，人们决定，在mmap()时检测巨页的短缺情况会更好。这个想法是，如果
-- 
2.35.1

