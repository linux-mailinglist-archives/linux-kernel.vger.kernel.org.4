Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63B73D937
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFZIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFZIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:10:11 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF510CC;
        Mon, 26 Jun 2023 01:10:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqL9h0wZYz4f3nyZ;
        Mon, 26 Jun 2023 16:10:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLPWR5lkQbNDMg--.19922S5;
        Mon, 26 Jun 2023 16:10:02 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, ashok_raj@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v4 1/4] block/badblocks: change some members of badblocks to bool
Date:   Mon, 26 Jun 2023 16:09:10 +0800
Message-Id: <20230626080913.3493135-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626080913.3493135-1-linan666@huaweicloud.com>
References: <20230626080913.3493135-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLPWR5lkQbNDMg--.19922S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45KFW3uryUWFWftw48tFb_yoW5XryUpF
        nxGwn3tr4jgr1vqF1DZ3W7Cr109w4xJF48t3y7Jw15K34Utw1xJa4kXryrtFWjqrW3CrsI
        vF1FgrW5Zry8C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8BWlDUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

"changed" and "unacked_exist" are used as boolean type. Change the type
of them to bool. No functional changed intended.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 include/linux/badblocks.h |  9 +++++----
 block/badblocks.c         | 14 +++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index 2426276b9bd3..2feb143a1856 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -27,15 +27,16 @@
 struct badblocks {
 	struct device *dev;	/* set by devm_init_badblocks */
 	int count;		/* count of bad blocks */
-	int unacked_exist;	/* there probably are unacknowledged
-				 * bad blocks.  This is only cleared
-				 * when a read discovers none
+	bool unacked_exist;	/* there probably are unacknowledged
+				 * bad blocks. This is only cleared
+				 * when a read of unacknowledged bad
+				 * blocks discovers none
 				 */
 	int shift;		/* shift from sectors to block size
 				 * a -ve shift means badblocks are
 				 * disabled.*/
 	u64 *page;		/* badblock list */
-	int changed;
+	bool changed;
 	seqlock_t lock;
 	sector_t sector;
 	sector_t size;		/* in sectors */
diff --git a/block/badblocks.c b/block/badblocks.c
index 3afb550c0f7b..f28e971a4b94 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -141,7 +141,7 @@ static void badblocks_update_acked(struct badblocks *bb)
 	}
 
 	if (!unacked)
-		bb->unacked_exist = 0;
+		bb->unacked_exist = false;
 }
 
 /**
@@ -302,9 +302,9 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		}
 	}
 
-	bb->changed = 1;
+	bb->changed = true;
 	if (!acknowledged)
-		bb->unacked_exist = 1;
+		bb->unacked_exist = true;
 	else
 		badblocks_update_acked(bb);
 	write_sequnlock_irqrestore(&bb->lock, flags);
@@ -414,7 +414,7 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 	}
 
 	badblocks_update_acked(bb);
-	bb->changed = 1;
+	bb->changed = true;
 out:
 	write_sequnlock_irq(&bb->lock);
 	return rv;
@@ -435,7 +435,7 @@ void ack_all_badblocks(struct badblocks *bb)
 		return;
 	write_seqlock_irq(&bb->lock);
 
-	if (bb->changed == 0 && bb->unacked_exist) {
+	if (!bb->changed && bb->unacked_exist) {
 		u64 *p = bb->page;
 		int i;
 
@@ -447,7 +447,7 @@ void ack_all_badblocks(struct badblocks *bb)
 				p[i] = BB_MAKE(start, len, 1);
 			}
 		}
-		bb->unacked_exist = 0;
+		bb->unacked_exist = false;
 	}
 	write_sequnlock_irq(&bb->lock);
 }
@@ -493,7 +493,7 @@ ssize_t badblocks_show(struct badblocks *bb, char *page, int unack)
 				length << bb->shift);
 	}
 	if (unack && len == 0)
-		bb->unacked_exist = 0;
+		bb->unacked_exist = false;
 
 	if (read_seqretry(&bb->lock, seq))
 		goto retry;
-- 
2.39.2

