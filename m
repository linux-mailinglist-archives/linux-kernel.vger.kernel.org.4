Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4397D67A107
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjAXSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjAXSRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:17:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062924C6FA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=m/pasOdyMBc4nWtkzhzrsJ06EVonqIIgK3nxwNuLfaY=; b=uqSc5bi6l2Y16Asr6UUphEuoQb
        0+Cud98MUBjc0W8ZSt15kbrkK66ZueE99C8uitOSr9J9boRR2rWAWP1ja+UgrWp+vpRPzXJtZearF
        yNQOg2aHckb82r/vriNQXZLi2gURGQlwDip1wsmgEHkSrh3vYrzH14SvuN1joBr8BtmOYuxWIskpv
        J0osCvYGulVfUONgWA3pj9CJmci0V6shu6xRBvbjbCi5Js0pp9jSa/V1xN+tjnppbgg6ktCYVB6jL
        EDiDS0cKPgqGLDvVeqMh2lPf32ocybiiOve22OOa3sdUhPb3eRzi2CxJYx3KIA7W7N8DcQ/+vRzPT
        Fieb2Avw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNqq-004vdD-CS; Tue, 24 Jan 2023 18:16:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kasan-dev@googlegroups.com
Subject: [PATCH] lib: Kconfig: fix spellos
Date:   Tue, 24 Jan 2023 10:16:55 -0800
Message-Id: <20230124181655.16269-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
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

Fix spelling in lib/ Kconfig files.
(reported by codespell)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: kasan-dev@googlegroups.com
---
 lib/Kconfig.debug |    2 +-
 lib/Kconfig.kcsan |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1876,7 +1876,7 @@ config FUNCTION_ERROR_INJECTION
 	help
 	  Add fault injections into various functions that are annotated with
 	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
-	  value of theses functions. This is useful to test error paths of code.
+	  value of these functions. This is useful to test error paths of code.
 
 	  If unsure, say N
 
diff -- a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -194,7 +194,7 @@ config KCSAN_WEAK_MEMORY
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
 
-	  Depends on KCSAN_STRICT, because the options strenghtening certain
+	  Depends on KCSAN_STRICT, because the options strengthening certain
 	  plain accesses by default (depending on !KCSAN_STRICT) reduce the
 	  ability to detect any data races invoving reordered accesses, in
 	  particular reordered writes.
