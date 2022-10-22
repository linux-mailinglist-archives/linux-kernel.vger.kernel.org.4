Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A1608545
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJVGtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJVGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:49:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11E2CE3E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:49:46 -0700 (PDT)
X-QQ-mid: bizesmtp64t1666421379tdghh5bq
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:49:38 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: Fc2LLDWeHZ8ncJpcRXXv8FFb9RUQmVfVD8exnjpcuQlHgmQAZOpymvMnOlKCF
        ej16OYRqJroVJ2O+f0d0u669L5pxe3aQ7tVNIQ1yRCHP8tg+u4+2fkKoBwDxWERE1sGhs0q
        mrM7y6wehZPM4uTbkGm4EyQmi8PrxlcvAWpS4ktm53yq8Om+ylLNjCtUyjV+5DwLReTRsUQ
        hoe+Z71cqJt8P3udFmgePLdEQYvfXTKajUMPUahvXisebkOopojVU3tzbt6PseWT01FK7tR
        17j0NWN5Z9NBI/5SVqSBBtbNnarz3vEVNUHRHfPj3x3Vh3L4xBBE1Aga3O25LD9dXwOGYmS
        yugFDIxb3lmiz9MVlb+pApyxVLSYn9X/hsvcN8v4D/2SVFxnD8=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] include/linux: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:49:31 +0800
Message-Id: <20221022064931.39217-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e9027947..4e2ae90554cd 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -863,7 +863,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
-- 
2.36.1

