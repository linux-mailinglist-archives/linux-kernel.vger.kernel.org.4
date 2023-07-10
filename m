Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C602A74D007
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGJIdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjGJIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:33:12 -0400
X-Greylist: delayed 92619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 01:32:58 PDT
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77482C2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688977976;
        bh=4i5QUV9T4fYpJF6lWkKhhD0RINkSEU8kNV+b+l4tVlA=;
        h=From:To:Cc:Subject:Date;
        b=SfZ07cqtmBfPAr8i1/QQIHI6r17qlJ/oCimhsKDGHmQwX+K48pF/9apv1bt1HtrEI
         cowea+DcnWNvBUgPZK7s2SwSl6lXNjSfKVCNiGqpuFNJBqz9ssZX7VYcW/HvGHA7/q
         4N5tkHoBd482thUCt9RJT6SzOQlOrXEu/RBoueJA=
Received: from linkpc.nju.edu.cn ([58.213.8.104])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 83499E43; Mon, 10 Jul 2023 16:32:52 +0800
X-QQ-mid: xmsmtpt1688977972t1gkhqqnj
Message-ID: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneOrBZtagOMB8w0L2ShAiZqzSQ/bHu49QVA1pORfWXS7M7rYN/CM
         e6rtjTlwdslgyDuWLoLnI0E5IHuudYTHD6QFQIHOMzSJIGwmtUircgSkDZTNdeM5pUSGt22VPbhc
         rSt5jVEcgkxbJLkade6H0Bj1p2/aDsQxlXJg+A637oIy0Qfz4W0bnrqJhivxa/4i/kuSGwHv7xwA
         5ljq2N37ypI19ydKu17puAGgj0MLLriNJWEWzfz1K0QSWJVrcYYFS2vSK490Sw/EyfkJ94mFZ0s2
         qXlV0pGd4q4gxKJgEq+WPs1YvLQGrG5QuPyn51yUdf+itd00NFsX6HaX13MWIfCLyZJaLatmf3FL
         Ovbr+ElmyaRToLSQQUXecqYKPbkaCxfNPvRsCJe6geXAjLkkVT6nS9KzctTGxxWgMneDEVz9yJwH
         17rH3UWR349vCdvpSgwM+IghZ696uSmQChIwMuSy3sIlqq/sjiH2/BJOrOr56y/tGZZMeJrTrMxg
         lndMeRWab0uiZ2Q+zDkgG5AzUet9CKFAPscKFm/vWwabmU9u837ysuvpPnZDEIY+xELzzG2mrFji
         EbsouKNafflkGw4EXcPzhrPmJjtoBd/OZhjs725gW+KVUgT+5w5QIU4fcGk7SdgCGaCly8BA4/MQ
         17i7sBijoVRSZh4IFYiGJOiya4b1HtkWnU7sogL2qHob0ATPCz5yRuQ6jcGT/8b5asfq/MCa4zTK
         wUAyzR3M+Ty9t8D9/xAZ2MbpL+Py88bdDKbGJSRPBXNUeRK6hAgCbh2Ai+2OBCu0wvQsrXtbeK7F
         DU6TdmHiVeGWmpW3Xn6fioOQWf/50Mt4x0KqSf5VgkIDyiliYbtpi6ezO5WUgY5EbRXRnShOb/BR
         HiYetc7gt0m2Hgdl0fbE9TV8RaCVON9QLLeHaTmjTPpOyLdnaK1OmW/ln378vkbgl6GEoZv45+I1
         5/5fGG4AHf7BHs/WwKT5jVjZDLk6zBbrrt1n0JermUPVYr6t3lNZKN+F1N2a1oW5MjgfjCjDE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Linke Li <lilinke99@foxmail.com>
To:     linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        Linke Li <lilinke99@gmail.com>
Subject: [PATCH] hugetlbfs: Fix integer overflow check in  hugetlbfs_file_mmap()
Date:   Mon, 10 Jul 2023 16:32:40 +0800
X-OQ-MSGID: <20230710083240.512379-1-lilinke99@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linke Li <lilinke99@gmail.com>

	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
	/* check for overflow */
	if (len < vma_len)
		return -EINVAL;

The existing code includes an integer overflow check, which indicates
that the variable len has the potential to overflow, leading to undefined
 behavior according to the C standard. However, both GCC and Clang
compilers may eliminate this overflow check based on the assumption
that there will be no undefined behavior. Although the Linux kernel
disables these optimizations by using the -fno-strict-overflow option,
there is still a risk if the compilers make mistakes in the future.

To address this potential issue, this patch introduces a new check
that effectively prevents integer overflow. This check ensures the
safe operation of the code even when the Linux kernel is compiled
without the -fno-strict-overflow option, providing an added layer
of protection against potential issues caused by compiler behavior.

Signed-off-by: Linke Li <lilinke99@gmail.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..1b4648a8e296 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -157,7 +157,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	/* check for overflow */
-	if (len < vma_len)
+	if (vma_len > LLONG_MAX - ((loff_t)vma->vm_pgoff << PAGE_SHIFT))
 		return -EINVAL;
 
 	inode_lock(inode);
-- 
2.25.1

