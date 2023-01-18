Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9CD670F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjARA5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjARA5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:57:24 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049854B30;
        Tue, 17 Jan 2023 16:44:22 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id NRK00002;
        Wed, 18 Jan 2023 08:44:02 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:44:03 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <corbet@lwn.net>, <fmdefrancesco@gmail.com>,
        <akpm@linux-foundation.org>, <bigeasy@linutronix.de>,
        <ira.weiny@intel.com>, <rppt@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] mm/highmem: fix spelling mistakeo
Date:   Tue, 17 Jan 2023 19:43:56 -0500
Message-ID: <20230118004356.4198-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   20231180844025254d30dc75da09cb9c5affca0996322
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute occurrencies of "higmem" with "highmem".

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

