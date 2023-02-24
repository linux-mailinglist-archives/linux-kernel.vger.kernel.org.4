Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505106A1D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBXNtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBXNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:49:14 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A95F1815C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:49:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PNWH24W9mz9xGYl
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:40:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwAn8lg3wPhjZJxJAQ--.62941S2;
        Fri, 24 Feb 2023 14:48:49 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Date:   Fri, 24 Feb 2023 14:52:51 +0100
Message-Id: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GxC2BwAn8lg3wPhjZJxJAQ--.62941S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF48GrWDJryktw1UKr4kJFb_yoW8CrWxpr
        WDG3yrKa1qqr9Y9FyDXw4kuF1fuayrWw48JFWDCa45A3sxXFsxuFWkKFs8ZrySqrZrCayj
        qr4jvry2v398CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0
        eHDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the documentation and implied by its name, the ppo
(preserved program order) relation is intended to link po-earlier
to po-later instructions under certain conditions.  However, a
corner case currently allows instructions to be linked by ppo that
are not executed by the same thread, i.e., instructions are being
linked that have no po relation.

This happens due to the mb/strong-fence/fence relations, which (as
one case) provide order when locks are passed between threads
followed by an smp_mb__after_unlock_lock() fence.  This is
illustrated in the following litmus test (as can be seen when using
herd7 with `doshow ppo`):

P0(int *x, int *y)
{
    spin_lock(x);
    spin_unlock(x);
}

P1(int *x, int *y)
{
    spin_lock(x);
    smp_mb__after_unlock_lock();
    *y = 1;
}

The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
P0 passes a lock to P1 which then uses this fence.

The patch makes ppo a subrelation of po by letting fence contribute
to ppo only in case the fence links events of the same thread.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.cat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index cfc1b8fd46da..adf3c4f41229 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
+let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
-- 
2.17.1

