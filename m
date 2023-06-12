Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79272B51D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjFLBd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLBd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:33:27 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B161C7;
        Sun, 11 Jun 2023 18:33:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-43b2da5b307so1030947137.2;
        Sun, 11 Jun 2023 18:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686533605; x=1689125605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud3GHaugFlTWgt3eVABQXSfDs3e4nTmgNYap85e+06E=;
        b=amWA2VIH0o7HsD/FEOm2D1dssGSZ1SWrW11XOMUTvmKYlCI0oPHoxRn7lxpx7G7T3R
         JaAUUDLqlMdyRQ82Vh+9G6CYqPPoVLLUIxT4bBrDz0vlEA0v43kLCwDnFmm+O/G3W+Hm
         SGUmtO2jdrwC6PVN+RPwQau4z7ld6L44eVT6wwdGmkwTLzbF4GBW73PlrOgQTj/eXcLp
         NK04lWhYl7M4wX40xhwWRBmaWhqBafVLdFsHPlIgtSgeO3z0Bfx3zGZtJN1FDB9fSz/e
         BsOEOa7VyIFts4pMffzJIcd+cIh3s99yo8516rtdUggHw/0t51MHA8H/Dyria/mhHABl
         nlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686533605; x=1689125605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud3GHaugFlTWgt3eVABQXSfDs3e4nTmgNYap85e+06E=;
        b=da4lCGauRBjZCsIjQwWK57Mx6wjdSUe8TrvQQjAHSuWarMjJE2FGEQpfAYJgsZPsMd
         XduPKZ7OgmOEBQaIR861QR2Sy4D6aKTwwMFNK/MvsXirFMcLidw1D1XxgnxK1smfkCZ4
         xtjt3c+e7nFADYQ3wfo5ibF2iEUXYyfs6Pv77M3S686hGANKqJ2z/RqN0LNnFClz/U6U
         dVSOLavNaQuTc6IlCr3uG2ffr0cB7C0nUdovrSe04ILtoLxBVm6SEHtUFqwKA5zJj/Fm
         Xv8XHe7OYhGiNxjs96JZ2/9GCUif108NppsG1cm8bm6pVaPEGyZVYYD2vPfA0twNTOXx
         7Big==
X-Gm-Message-State: AC+VfDw+nnm9NNHYecIVralFp3fTv9kJQHFOLrqmC2Ygul0Jl2s9nF8F
        BZvhJdCq0hZk+V6DBy4f0i8=
X-Google-Smtp-Source: ACHHUZ6vXKpHT1KclLMh/rpSgQLCkjHNmx/+qncsRUIzBAhLU/n62P9EpBZ9RWHnsTtNfAL8PE9XQw==
X-Received: by 2002:a67:efc2:0:b0:43d:ef1b:232c with SMTP id s2-20020a67efc2000000b0043def1b232cmr959325vsp.0.1686533605277;
        Sun, 11 Jun 2023 18:33:25 -0700 (PDT)
Received: from localhost.localdomain ([179.50.15.34])
        by smtp.gmail.com with ESMTPSA id k6-20020ab05386000000b006904fa86e7csm1476365uaa.2.2023.06.11.18.33.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Jun 2023 18:33:24 -0700 (PDT)
From:   Yang Hau <yuanyanghau@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Hau <yuanyanghau@gmail.com>
Subject: [PATCH 1/2] block: fix random typos
Date:   Sun, 11 Jun 2023 20:33:17 -0500
Message-Id: <20230612013317.87065-1-yuanyanghau@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some random typos.

Signed-off-by: Yang Hau <yuanyanghau@gmail.com>
---
 block/bdev.c              | 2 +-
 block/bfq-iosched.c       | 4 ++--
 block/blk-cgroup-rwstat.c | 2 +-
 block/blk-ia-ranges.c     | 2 +-
 block/blk-merge.c         | 6 +++---
 block/blk.h               | 2 +-
 block/elevator.c          | 2 +-
 block/kyber-iosched.c     | 2 +-
 block/mq-deadline.c       | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 1795c7d4b..6f8bff116 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -539,7 +539,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * @bdev: block device of interest
  * @holder: holder that has claimed @bdev
  *
- * Finish exclusive open of a block device. Mark the device as exlusively
+ * Finish exclusive open of a block device. Mark the device as exclusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
 static void bd_finish_claiming(struct block_device *bdev, void *holder)
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d9ed3108c..3adb03633 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1963,7 +1963,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * As for throughput, we ask bfq_better_to_idle() whether we
 	 * still need to plug I/O dispatching. If bfq_better_to_idle()
 	 * says no, then plugging is not needed any longer, either to
-	 * boost throughput or to perserve service guarantees. Then
+	 * boost throughput or to preserve service guarantees. Then
 	 * the best option is to stop plugging I/O, as not doing so
 	 * would certainly lower throughput. We may end up in this
 	 * case if: (1) upon a dispatch attempt, we detected that it
@@ -2491,7 +2491,7 @@ static int bfq_request_merge(struct request_queue *q, struct request **req,
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
 
-		if (blk_discard_mergable(__rq))
+		if (blk_discard_mergeable(__rq))
 			return ELEVATOR_DISCARD_MERGE;
 		return ELEVATOR_FRONT_MERGE;
 	}
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index 3304e841d..0039e4756 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(blkg_rwstat_exit);
  * @pd: policy private data of interest
  * @rwstat: rwstat to print
  *
- * Print @rwstat to @sf for the device assocaited with @pd.
+ * Print @rwstat to @sf for the device associated with @pd.
  */
 u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			 const struct blkg_rwstat_sample *rwstat)
diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index c9eb4241e..f65f7a2cf 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -63,7 +63,7 @@ static const struct sysfs_ops blk_ia_range_sysfs_ops = {
 };
 
 /*
- * Independent access range entries are not freed individually, but alltogether
+ * Independent access range entries are not freed individually, but all together
  * with struct blk_independent_access_ranges and its array of ranges. Since
  * kobject_add() takes a reference on the parent kobject contained in
  * struct blk_independent_access_ranges, the array of independent access range
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6460abdb2..29034bb9d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -790,7 +790,7 @@ static void blk_account_io_merge_request(struct request *req)
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
-	if (blk_discard_mergable(req))
+	if (blk_discard_mergeable(req))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
 		return ELEVATOR_BACK_MERGE;
@@ -864,7 +864,7 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	req->__data_len += blk_rq_bytes(next);
 
-	if (!blk_discard_mergable(req))
+	if (!blk_discard_mergeable(req))
 		elv_merge_requests(q, req, next);
 
 	/*
@@ -947,7 +947,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
+	if (blk_discard_mergeable(rq))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
diff --git a/block/blk.h b/block/blk.h
index cc4e8873d..eb2ae2df1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -148,7 +148,7 @@ static inline bool rq_mergeable(struct request *rq)
  *  2) Otherwise, the request will be normal read/write requests.  The ranges
  *     need to be contiguous.
  */
-static inline bool blk_discard_mergable(struct request *req)
+static inline bool blk_discard_mergeable(struct request *req)
 {
 	if (req_op(req) == REQ_OP_DISCARD &&
 	    queue_max_discard_segments(req->q) > 1)
diff --git a/block/elevator.c b/block/elevator.c
index 24909069f..a6ab90cff 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -310,7 +310,7 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
 
-		if (blk_discard_mergable(__rq))
+		if (blk_discard_mergeable(__rq))
 			return ELEVATOR_DISCARD_MERGE;
 		return ELEVATOR_BACK_MERGE;
 	}
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 214696923..678448cf9 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -142,7 +142,7 @@ struct kyber_cpu_latency {
  */
 struct kyber_ctx_queue {
 	/*
-	 * Used to ensure operations on rq_list and kcq_map to be an atmoic one.
+	 * Used to ensure operations on rq_list and kcq_map to be an atomic one.
 	 * Also protect the rqs on rq_list when merge.
 	 */
 	spinlock_t lock;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f10c2a0d1..910a23ef4 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -734,7 +734,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 
 		if (elv_bio_merge_ok(__rq, bio)) {
 			*rq = __rq;
-			if (blk_discard_mergable(__rq))
+			if (blk_discard_mergeable(__rq))
 				return ELEVATOR_DISCARD_MERGE;
 			return ELEVATOR_FRONT_MERGE;
 		}
-- 
2.39.0

