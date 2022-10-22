Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33160848E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJVFaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJVF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:29:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC7A56BBD;
        Fri, 21 Oct 2022 22:29:54 -0700 (PDT)
X-QQ-mid: bizesmtp66t1666416585tduavish
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:29:43 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 6ArnuSDJ+insJi8w8/fz0awjfMjITR6xTr4lIFX8e7bST+em3zV3/XSXFSlpg
        UB8apUyny8pKu/rvXV8qzkXj4m57aBfidz3PwTBbDdysmWAT5Aif7l3YSQ1zWp6zH/Mjwiw
        DJqiOVYReuDcWenITylRX73RHm2AkZj8Ri7n60iSGQ5WfRIz9P+MDb5JG8/HTwjtyPkllH+
        PFVCvHhJGgMf7dM+iTjWQ6sKIVdAZVN+lf7PUSs/sGrdwr347eEr7eh4gBMpU9S1PshqaFf
        BgjoBla10uEv5NetH0o3BdVpvvRj+XljX4aKCEBnVexEjetMK15X3g/Hw2poY6n708OYzH3
        AmVER1ioqeI2z/cYTtR5w22CF6IXez6DwAa60ns/UVaPQl5b0A=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] s390/kernel: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:29:37 +0800
Message-Id: <20221022052937.17717-1-wangjianli@cdjrlc.com>
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
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..0fda19b1e21d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1160,7 +1160,7 @@ static void perf_event_count_update(struct perf_event *event, u64 count)
  * combined-sampling data entry consists of a basic- and a diagnostic-sampling
  * data entry.	The sampling function is determined by the flags in the perf
  * event hardware structure.  The function always works with a combined-sampling
- * data entry but ignores the the diagnostic portion if it is not available.
+ * data entry but ignores the diagnostic portion if it is not available.
  *
  * Note that the implementation focuses on basic-sampling data entries and, if
  * such an entry is not valid, the entire combined-sampling data entry is
-- 
2.36.1

