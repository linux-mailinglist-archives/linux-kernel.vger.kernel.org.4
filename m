Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D860EBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiJZXAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiJZXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F32A41A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B4B620ED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C01C433D6;
        Wed, 26 Oct 2022 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825196;
        bh=QkoSP5dy50ivjFi2Kea4D2nh4Z8LDeoDCm4zKPAaAhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALm56epckyb/8rY95yBicPcsnjav4f+T26VCXKs6HLb5x+abgQaLlxHSCewgdBFgG
         DmBDFTQbQf9i1yAAJ3O91Qqkmtsg/8OSKXdGQKyKltSzOsnCpg8zxq6HlYfMG8dPgU
         ggiJ7kjnBJ2MbC3Ex0BlPUAk7UqDIdSEtzRR1mCHOclIQ6Qo6Q8pYa08iKBCWk8AIw
         6XozkgTsCSvFP1spmNDTYeBgcoD1RYHGDW2RCX1rNsjrCq53tiZWQJt0Dntinf5tLC
         Cinn0dXhLsNZo5uRyLGqgMXi1vmyF5iD7a3R90G1EueEexUPmekq+yzDc8fxlHisa0
         E3iIL0zsIovBg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 12/12] mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers
Date:   Wed, 26 Oct 2022 22:59:43 +0000
Message-Id: <20221026225943.100429-13-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
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

Some headers that 'reclaim.c' and 'lru_sort.c' are including are
unnecessary now owing to previous cleanups and refactorings.  Remove
those.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
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

