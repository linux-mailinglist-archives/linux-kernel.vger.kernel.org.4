Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84B5F62FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJFIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJFIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:45:03 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468E4AD58;
        Thu,  6 Oct 2022 01:44:58 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id BKZ00051;
        Thu, 06 Oct 2022 16:44:51 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Thu, 6 Oct 2022 16:44:52 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] block: Remove the repeat word 'can'
Date:   Thu, 6 Oct 2022 04:44:50 -0400
Message-ID: <20221006084450.1513-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202210061644511c3f968f2379d69f85dbb1d08d96c882
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeat word 'can' from the comments of bio_kmalloc.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ec350e040b64..633a902468ec 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -567,7 +567,7 @@ EXPORT_SYMBOL(bio_alloc_bioset);
  * be reused by calling bio_uninit() before calling bio_init() again.
  *
  * Note that unlike bio_alloc() or bio_alloc_bioset() allocations from this
- * function are not backed by a mempool can can fail.  Do not use this function
+ * function are not backed by a mempool can fail.  Do not use this function
  * for allocations in the file system I/O path.
  *
  * Returns: Pointer to new bio on success, NULL on failure.
-- 
2.27.0

