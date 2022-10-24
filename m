Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7760BD65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiJXWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiJXW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB91DDC0E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B76615C5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B0FC433D7;
        Mon, 24 Oct 2022 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644571;
        bh=ed3OO6jR2hviy6STfWb58XYnzMUxxyGe+e0xErjg1fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9cIXzhU9U1zWxdfPsC7S7cI+Ulc4SATnZVntGHQSe96wwChjQu3bcUIxth195MMp
         f4ukgLvBrlxZd/H8PRujs8KanGthShxmvvpLnHDKW1Lq299OzeaVMvog4X/ZgZdPDc
         gpM3BJ3Hn9RDw+azkUEHJHF155dHbvb5CGHOXw6Wpj2N2B1XvJx/RMFy6ILnUIFUIW
         PoUMZQoA9/tvPN6u7OKJusB50RP+v/mQIrqZw2hTUaX68Z3CYtid7Ykt9yjoi1Gflh
         D8BsHRcEsbV8Q8JtuFi3LFky/66KYi+CsQEkI+AyyL6UbExCY19nR679Fw2zEgoFJn
         9ENAJnc8bWkRg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers
Date:   Mon, 24 Oct 2022 20:49:19 +0000
Message-Id: <20221024204919.18524-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers that 'recalim.c' and 'lru_sort.c' are including are
unnecessary now owing to previous cleanups and refactorings.  Remove
those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 --
 mm/damon/reclaim.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index a1896c5acfe9..5c60163e556c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -8,9 +8,7 @@
 #define pr_fmt(fmt) "damon-lru-sort: " fmt
 
 #include <linux/damon.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/workqueue.h>
 
 #include "modules-common.h"
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3173f373435c..e14eb30c01f4 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -8,9 +8,7 @@
 #define pr_fmt(fmt) "damon-reclaim: " fmt
 
 #include <linux/damon.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/workqueue.h>
 
 #include "modules-common.h"
-- 
2.25.1

