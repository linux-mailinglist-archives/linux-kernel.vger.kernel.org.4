Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB469085C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBIMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBIMLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:15 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAED50B;
        Thu,  9 Feb 2023 04:09:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCFz15pJ3z4f3m7Y;
        Thu,  9 Feb 2023 20:09:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFr4uRj4rAuDQ--.53349S9;
        Thu, 09 Feb 2023 20:09:19 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz
Cc:     andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] blk-mq: remove stale comment of function called for iterated request
Date:   Fri, 10 Feb 2023 04:11:16 +0800
Message-Id: <20230209201116.579809-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230209201116.579809-1-shikemeng@huaweicloud.com>
References: <20230209201116.579809-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFr4uRj4rAuDQ--.53349S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUWFy7uF4fKw1fGryDWrg_yoWrCF4DpF
        Wava1vkr4Fqr1xCr4DA3y8Cr95urs3trnrGan3t34F9wn0krs5Xr4DKrW8Xr4jkF48uay8
        Ars0y34kuw1DX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call function with type "bool (busy_tag_iter_fn)(struct request *,
void *)" for each iterated request now. Remove the stale arguments
@hctx and @reserved in comment which are not needed by iterate
function.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq-tag.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7f1777dc11e5..f1187c901019 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -303,9 +303,9 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each request
  *		associated with @hctx that has been assigned a driver tag.
- *		@fn will be called as follows: @fn(@hctx, rq, @data, @reserved)
- *		where rq is a pointer to a request. Return true to continue
- *		iterating tags, false to stop.
+ *		@fn will be called as follows: @fn(@rq, @data) where rq is a
+ *		pointer to a request. Return true to continue iterating tags,
+ *		false to stop.
  * @data:	Will be passed as third argument to @fn.
  * @reserved:	Indicates whether @bt is the breserved_tags member or the
  *		bitmap_tags member of struct blk_mq_tags.
@@ -372,9 +372,9 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request. Return true
- *		to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @data) where
+ *		rq is a pointer to a request. Return true to continue
+ *		iterating tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @flags:	BT_TAG_ITER_*
  */
@@ -407,10 +407,9 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
  * blk_mq_all_tag_iter - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
  * @fn:		Pointer to the function that will be called for each
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @priv)
+ *		where rq is a pointer to a request. Return true to
+ *		continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  *
  * Caller has to pass the tag map from which requests are allocated.
@@ -425,10 +424,9 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
  * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
  * @tagset:	Tag set to iterate over.
  * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @priv) where
+ *		rq is a pointer to a request. Return true to continue
+ *		iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  *
  * We grab one request reference before calling @fn and release it after
@@ -484,10 +482,9 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
  * @fn:		Pointer to the function that will be called for each request
- *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
- *		reserved) where rq is a pointer to a request and hctx points
- *		to the hardware queue associated with the request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
+ *		on @q. @fn will be called as follows: @fn(rq, @priv) where
+ *		rq is a pointer to a request. Return true to continue
+ *		iterating tags, false to stop.
  * @priv:	Will be passed as third argument to @fn.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
-- 
2.30.0

