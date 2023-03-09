Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE36B21D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCIKtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCIKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:49:10 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE957A4B2A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OvsYp
        BSOpJLCgoLG0m1RFhy11HQJB8nTU9NPvUqBqLo=; b=TVwV6E3OjuelinbiDIYu+
        JSjCbZZ2FZkNTdVEN8P7vHykvzq9uFoORqHomdYjiFvyL25bKdKGvrZMYH1CjZI7
        9gcEaSB14FhQq11eYLu5DZ0YYHonYUHGYmULPUV7TyiqOQ/60XUsPj241lmvfw/n
        8LERRCAeuJMG1Jq21k4wm8=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [103.208.12.108])
        by smtp16 (Coremail) with SMTP id MNxpCgD3bUqYuQlkfy61Gw--.5660S4;
        Thu, 09 Mar 2023 18:49:17 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] mm/gup.c: fix typo in comments
Date:   Thu,  9 Mar 2023 18:48:13 +0800
Message-Id: <20230309104813.170309-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: MNxpCgD3bUqYuQlkfy61Gw--.5660S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry7CrykJrWUGry5Ww1rWFg_yoWftFg_WF
        40yrykXayruas8tr15Ca4fJF9FkF93uryrZ3y0grW7tFyDAFn3CFyDJrW8Xryjgw43CFnx
        urnYk347KF1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_SfOUUUUUU==
X-Originating-IP: [103.208.12.108]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBdQUtF1aED+a8owAAsu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index eab18ba045db..1f72a717232b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2193,7 +2193,7 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
  * This does not guarantee that the page exists in the user mappings when
  * get_user_pages_remote returns, and there may even be a completely different
  * page there in some cases (eg. if mmapped pagecache has been invalidated
- * and subsequently re faulted). However it does guarantee that the page
+ * and subsequently re-faulted). However it does guarantee that the page
  * won't be freed completely. And mostly callers simply care that the page
  * contains data that was valid *at some point in time*. Typically, an IO
  * or similar operation cannot guarantee anything stronger anyway because
-- 
2.34.1

