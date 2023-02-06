Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5B868B86F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBFJSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjBFJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:18:26 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80165C16D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:18:21 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id CDZ00016;
        Mon, 06 Feb 2023 17:18:16 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.16; Mon, 6 Feb 2023 17:18:17 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <anton@tuxera.com>
CC:     <linux-ntfs-dev@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] ntfs: Correct spelling
Date:   Mon, 6 Feb 2023 04:18:15 -0500
Message-ID: <20230206091815.1687-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202320617181683225ff5bebc786006c158be72b58f58
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use this replace thie.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index a3865bc4a0c6..f79408f9127a 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2491,7 +2491,7 @@ s64 ntfs_attr_extend_allocation(ntfs_inode *ni, s64 new_alloc_size,
  * byte offset @ofs inside the attribute with the constant byte @val.
  *
  * This function is effectively like memset() applied to an ntfs attribute.
- * Note thie function actually only operates on the page cache pages belonging
+ * Note this function actually only operates on the page cache pages belonging
  * to the ntfs attribute and it marks them dirty after doing the memset().
  * Thus it relies on the vm dirty page write code paths to cause the modified
  * pages to be written to the mft record/disk.
-- 
2.27.0

