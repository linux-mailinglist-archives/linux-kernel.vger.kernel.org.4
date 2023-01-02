Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480565B75A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 22:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjABVSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 16:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjABVSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 16:18:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400EDA459
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eIJ71EhbsqRhJUGU4fUu+NShCuoIP64RjPYjklH6uCQ=; b=LHB6EmdsyfdaXlmLxgYuvXWGqB
        Bgcs2WLc1cdHHY3N2X36233j4iQe646ZIvL89XP+MzxPexY7MXcMw3mzFw+OeXT1nS4ZA1XEN7Ga7
        YMMe3mMDbmTE8NerYUmkuO0O5QlUSXghjdxZcsczNAOvXQ1+LsTyGmCZGK7zh2Xt22hxH2XMeGHFm
        ucuNCkBEnpUJsERcoIirTBWspbmZsZ0v4Uh5MDk8xHGve+gyT4dYyf/c2Mr+Pm3WYCzxRRO6UTkCF
        wNarQ15Sv7ImkcyiYJe0u5OhFQfYZpZ/koLg9NJZK733krhT/oA2dTSvyXJGSvxZnZYebqMwOqN6E
        uaqKhdnQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCSCV-00EJ8G-0A; Mon, 02 Jan 2023 21:18:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cpumask: fix function description kernel-doc notation
Date:   Mon,  2 Jan 2023 13:18:30 -0800
Message-Id: <20230102211830.2674-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel-doc notation for the function description to prevent
a warning:

lib/cpumask.c:160: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Returns an arbitrary cpu within srcp1 & srcp2.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/cpumask.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/lib/cpumask.c b/lib/cpumask.c
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(cpumask_local_spread);
 static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
 
 /**
- * Returns an arbitrary cpu within srcp1 & srcp2.
+ * cpumask_any_and_distribute - Return an arbitrary cpu within srcp1 & srcp2.
  *
  * Iterated calls using the same srcp1 and srcp2 will be distributed within
  * their intersection.
