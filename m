Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A922671158
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjARCyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjARCyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:54:22 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379738E82;
        Tue, 17 Jan 2023 18:54:19 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id NTU00114;
        Wed, 18 Jan 2023 10:54:14 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 10:54:15 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <corbet@lwn.net>, <akpm@linux-foundation.org>,
        <fmdefrancesco@gmail.com>, <bigeasy@linutronix.de>,
        <ira.weiny@intel.com>, <rppt@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] Documentation: mm: use `s/higmem/highmem/` fix typo for highmem
Date:   Tue, 17 Jan 2023 21:54:03 -0500
Message-ID: <20230118025403.1531-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   2023118105414298dc68352fb344208d4cb16a7c8b3c1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use highmem replace higmem.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 Documentation/mm/highmem.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
index 59d1078f53df..7da4a0d175f0 100644
--- a/Documentation/mm/highmem.rst
+++ b/Documentation/mm/highmem.rst
@@ -83,7 +83,7 @@ list shows them in order of preference of use.
   for pages which are known to not come from ZONE_HIGHMEM. However, it is
   always safe to use kmap_local_page() / kunmap_local().
 
-  While it is significantly faster than kmap(), for the higmem case it
+  While it is significantly faster than kmap(), for the highmem case it
   comes with restrictions about the pointers validity. Contrary to kmap()
   mappings, the local mappings are only valid in the context of the caller
   and cannot be handed to other contexts. This implies that users must
-- 
2.27.0

