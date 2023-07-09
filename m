Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780D974C46F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGINtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGINtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:49:23 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E76114
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:49:20 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzT575MT9zBRpqk
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:49:15 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688910555; x=1691502556; bh=ZOH8K2/UuQKKcatgEp6FYAcgKm9
        SgqIrMLy+hBWjlaY=; b=mvivnT+EXiX7IMr5hHUqHXIw0ouKDKAYUBGsXa07kfH
        62SO6GPbrk8O+opn5Nk2ySN00Y+MxddklDZOX1ZEl3nYE6h55Oh6T1an+FBFrb/j
        HyvJEn9GocB4pW5zQBjy+LSkG6vCbzjm3BeDX3tO6dWGoMVvk74mkjLm2Uh+F8P0
        HQiFvZjZMrouJi2qzQkktIzCvC74XZAAFkgL1dWVfLbWFW0sttZrAmt2xjRvd1mJ
        9nXCCkFIEOhZebN/FZ4M7KRrDi611bFcqpvxvfIrfiupwK+eIk3a4I+0chNV3wpF
        TxoR6SU11BHmfFXVLK4BBCnny4tDFkirz9bz0hcu4QQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pvh86RESuxNw for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 21:49:15 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzT566hdMzBRL6L;
        Sun,  9 Jul 2023 21:49:14 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 21:49:14 +0800
From:   xuanzhenggang001@208suo.com
To:     linux@armlinux.org.uk, wangkefeng.wang@huawei.com,
        rmk+kernel@armlinux.org.uk
Cc:     linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mm: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <20230709133846.39984-1-denghuilong@cdjrlc.com>
References: <20230709133846.39984-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9bdef764d257da49dbfdc44992903b86@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by checkpatch:

arch/arm/mm/dump.c:52: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:229: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:315: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:346: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:370: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:386: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:402: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/arm/mm/dump.c:429: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
---
  arch/arm/mm/dump.c | 16 ++++++++--------
  1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index a9381095ab36..d73e8d8a08d6 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -49,7 +49,7 @@ struct pg_state {
      struct seq_file *seq;
      const struct addr_marker *marker;
      unsigned long start_address;
-    unsigned level;
+    unsigned int level;
      u64 current_prot;
      bool check_wx;
      unsigned long wx_pages;
@@ -226,7 +226,7 @@ static struct pg_level pg_level[] = {

  static void dump_prot(struct pg_state *st, const struct prot_bits 
*bits, size_t num)
  {
-    unsigned i;
+    unsigned int i;

      for (i = 0; i < num; i++, bits++) {
          const char *s;
@@ -312,7 +312,7 @@ static void walk_pte(struct pg_state *st, pmd_t 
*pmd, unsigned long start,
  {
      pte_t *pte = pte_offset_kernel(pmd, 0);
      unsigned long addr;
-    unsigned i;
+    unsigned int i;

      for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
          addr = start + i * PAGE_SIZE;
@@ -343,7 +343,7 @@ static void walk_pmd(struct pg_state *st, pud_t 
*pud, unsigned long start)
  {
      pmd_t *pmd = pmd_offset(pud, 0);
      unsigned long addr;
-    unsigned i;
+    unsigned int i;
      const char *domain;

      for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
@@ -367,7 +367,7 @@ static void walk_pud(struct pg_state *st, p4d_t 
*p4d, unsigned long start)
  {
      pud_t *pud = pud_offset(p4d, 0);
      unsigned long addr;
-    unsigned i;
+    unsigned int i;

      for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
          addr = start + i * PUD_SIZE;
@@ -383,7 +383,7 @@ static void walk_p4d(struct pg_state *st, pgd_t 
*pgd, unsigned long start)
  {
      p4d_t *p4d = p4d_offset(pgd, 0);
      unsigned long addr;
-    unsigned i;
+    unsigned int i;

      for (i = 0; i < PTRS_PER_P4D; i++, p4d++) {
          addr = start + i * P4D_SIZE;
@@ -399,7 +399,7 @@ static void walk_pgd(struct pg_state *st, struct 
mm_struct *mm,
              unsigned long start)
  {
      pgd_t *pgd = pgd_offset(mm, 0UL);
-    unsigned i;
+    unsigned int i;
      unsigned long addr;

      for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
@@ -426,7 +426,7 @@ void ptdump_walk_pgd(struct seq_file *m, struct 
ptdump_info *info)

  static void __init ptdump_initialize(void)
  {
-    unsigned i, j;
+    unsigned int i, j;

      for (i = 0; i < ARRAY_SIZE(pg_level); i++)
          if (pg_level[i].bits)
