Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE326900F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBIHOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBIHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B573C28;
        Wed,  8 Feb 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MQhbP0hMtr6BqR9ppLU18nCzMDHRZuJTLBNnsV14sTQ=; b=BmDj84f8W9J0+5LNbakfRrzHdo
        PDONN7berws3awmJ/xzVCoxhMFnINWWcazwcGAwI22xhbuNZOCsXTgf6DDLGP3zzuw3xJfKKjN3xU
        OP75Q7YAEdY/ui5J1Ops8tqYIUZmw0LSzEl9dOCJ9X/7ncTQ0M9Mwl4dB1Tg9pzQxKBHNlTx4xQvk
        ClZjk9qkKuad+81b4QAvvSg7Rq+hgHM/XQQ5wCmsRUIMagt9i1kWo2tlgBjsKEHY9FuH2QiBiu3wl
        Hc1MtDKtptDmAQGSH/I0RDyz/MJzkxY731/nOGL1KYTPF/ju+tJNpmBC0QAmqp3eoYdnurkme8xiK
        Bcl2u43g==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18B-000LPt-9b; Thu, 09 Feb 2023 07:14:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 06/24] Documentation: features: correct spelling
Date:   Wed,  8 Feb 2023 23:13:42 -0800
Message-Id: <20230209071400.31476-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/features/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/features/core/thread-info-in-task/arch-support.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -1,7 +1,7 @@
 #
 # Feature name:          thread-info-in-task
 #         Kconfig:       THREAD_INFO_IN_TASK
-#         description:   arch makes use of the core kernel facility to embedd thread_info in task_struct
+#         description:   arch makes use of the core kernel facility to embed thread_info in task_struct
 #
     -----------------------
     |         arch |status|
