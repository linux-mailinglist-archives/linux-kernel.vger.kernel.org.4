Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77305BB795
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIQJlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:41:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B731A3A16F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:41:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1761429pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I2k6FBkPq2fQ+qY+MPawIgHovGyQd2pxR4RTiazNyF8=;
        b=dajvXB6kZu8KO+gyPyFElF2PIjCqvUmoEXdq2fOMtfG++18dZaL1b843kJfZfLJSO3
         7E3nMhS96Qf1BL+yuOZDmsi4YE4FugYd8/68MOGaaaFiGro9ryPlvtqbyhfFGiL5BfXr
         NspXhgjzr/VCkLZiV5addqJo5r3svDhKKLsNexNgoXeMbkig1LnJRr2h42FPBjkz3oU6
         EvFQC1KhUsH3e6IHe7ErqM8rSvA0YB3KvvGqy79N9hMA4aM/dO/YdaNHvGUf5QBgOxbZ
         HObPOftpFzZXJ2qJab132C4wQhg0xnweWSR/R6bSJ62L+qfu+5WDTaok4GkWYRZJeCmb
         wqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I2k6FBkPq2fQ+qY+MPawIgHovGyQd2pxR4RTiazNyF8=;
        b=0cT/7YDX6HqzZF413f/I5Fm55BSKLDpWRfIk+VZN9fhhuZeh45WrpKEvwVFS2xqfhv
         U9mt5EDX1q1Y32feYIqXrZCS+AGGotSQAZsWTDa6r+mSr2D0c5FNMDUwIdE5sxX4pxkR
         bY5O4NZsqYSQjumHyj2tPM9mvUMzgUOj5ozyXEAMOR+E+cdl8ijs7d8RWl5AwnmGKW3P
         sYpnD4a8RCDxA602q6NJSnw6TB+eclvY6CO3udykjGMMz8fitlJ6sMDsWJS/VMD5RPj8
         mal6SQJ+Qr6ZAzR1TZEOJF3mAxzeJNpCnctrwDAg2gatXhBGb2C9Na509mDsii98CNka
         +S2Q==
X-Gm-Message-State: ACrzQf3vQKPNFfyIyE2GhJVU4+qUE2UQ0UqoB+eD0/lCeAyFoULnsZ8j
        WvzNQDRaXeSgn/LCsYYo2w==
X-Google-Smtp-Source: AMsMyM7ln3m0NecF9yNpxgD75PxgQiwoGa5iE4K0cnpq0dyZyINyb2ggzi7tkMEzvoxMVtf79NTzDA==
X-Received: by 2002:a17:90b:390e:b0:202:affa:1c91 with SMTP id ob14-20020a17090b390e00b00202affa1c91mr20791969pjb.233.1663407668074;
        Sat, 17 Sep 2022 02:41:08 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b001714c36a6e7sm16310677plb.284.2022.09.17.02.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Sep 2022 02:41:06 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: rename damon_pageout_score() to damon_cold_score()
Date:   Sat, 17 Sep 2022 17:39:18 +0800
Message-Id: <1663407558-21316-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

In the beginning there is only one damos_action 'DAMOS_PAGEOUT'
that need to get the coldness score of a region for a scheme,
which using damon_pageout_score() to do that. But now there are
also other damos_action actions need the coldness score, so
rename it to damon_cold_score() to make more sense.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/ops-common.c | 2 +-
 mm/damon/ops-common.h | 2 +-
 mm/damon/paddr.c      | 5 ++---
 mm/damon/vaddr.c      | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 9310df72e1c5..75409601f934 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -130,7 +130,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	return hotness;
 }
 
-int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
 	int hotness = damon_hot_score(c, r, s);
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 52329ff361cd..8d82d3722204 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -12,7 +12,7 @@ struct page *damon_get_page(unsigned long pfn);
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
 
-int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dfeebffe82f4..e495146e49e9 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -287,11 +287,10 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pageout_score(context, r, scheme);
+	case DAMOS_LRU_DEPRIO:
+		return damon_cold_score(context, r, scheme);
 	case DAMOS_LRU_PRIO:
 		return damon_hot_score(context, r, scheme);
-	case DAMOS_LRU_DEPRIO:
-		return damon_pageout_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index f53c2ff2bcc8..ea94e0b2c311 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -673,7 +673,7 @@ static int damon_va_scheme_score(struct damon_ctx *context,
 
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pageout_score(context, r, scheme);
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
-- 
2.27.0

