Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E76F62E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjEDCRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:17:51 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80A1185;
        Wed,  3 May 2023 19:17:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBcsg6Y8hz4f3mWJ;
        Thu,  4 May 2023 10:17:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgAHruvIFVNkuzZ0Ig--.19119S3;
        Thu, 04 May 2023 10:17:45 +0800 (CST)
Subject: Re: [PATCH RFC -next] block: support enable/disable blk-mq debugfs
 dynamically
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230415082042.2120295-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eabac8f5-108c-40dc-bd75-b5a04075a4d4@huaweicloud.com>
Date:   Thu, 4 May 2023 10:17:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230415082042.2120295-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAHruvIFVNkuzZ0Ig--.19119S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr15WFWUKFWDWry5trWrKrg_yoW3Cw4xpa
        yDGa15tw1vyr47XFyfCa17Ar93K3yvgr17ZryS9ryFvw1kKr1SqF18JrWUJrWkWrWkCw42
        vr15J3yq9ryDtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/04/15 16:20, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After a disk is created, debugfs inode and dentry will be created
> together, and the memory used for debugfs can't be freed until disk
> removal.
> 
> The number of debugfs inode and dentry is based on how many cpus and
> hctxs. For example, testing on a 128-core environemt, with default
> module parameters, each loop device will cost 1679KB memory, and debugfs
> will cost 336KB(20%).
> 
> The memory cost for debugfs for a disk seems little, but if a big machine
> contains thousands of disks, the cost will be xxGB. This memory overhead
> can be avoided by disabling CONFIG_BLK_DEBUG_FS.
> 
> This patch add a disk level switch that can enable/disable debugfs
> dynamically, so that user can disable debugfs if they care about the
> memory overhead, in the meantime, debugfs can be enabled again in demand.
> 

Friendly ping ...

Thanks,
Kuai
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-mq-debugfs.c | 58 ++++++++++++++++++++++++++++++++++++++----
>   block/blk-mq-debugfs.h |  1 +
>   block/blk-sysfs.c      | 41 +++++++++++++++++++++++++++++
>   include/linux/blkdev.h |  2 ++
>   4 files changed, 97 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 212a7f301e73..3ffc27fd4d07 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -657,6 +657,9 @@ void blk_mq_debugfs_register(struct request_queue *q)
>   	struct blk_mq_hw_ctx *hctx;
>   	unsigned long i;
>   
> +	if (!test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags))
> +		return;
> +
>   	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
>   
>   	/*
> @@ -685,6 +688,47 @@ void blk_mq_debugfs_register(struct request_queue *q)
>   	}
>   }
>   
> +static void debugfs_remove_files(struct dentry *parent,
> +				 const struct blk_mq_debugfs_attr *attr)
> +{
> +	if (IS_ERR_OR_NULL(parent))
> +		return;
> +
> +	for (; attr->name; attr++)
> +		debugfs_lookup_and_remove(attr->name, parent);
> +}
> +
> +void blk_mq_debugfs_unregister(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	if (q->rq_qos) {
> +		struct rq_qos *rqos = q->rq_qos;
> +
> +		while (rqos) {
> +			if (rqos->debugfs_dir)
> +				blk_mq_debugfs_unregister_rqos(rqos);
> +			rqos = rqos->next;
> +		}
> +	}
> +
> +	debugfs_remove_recursive(q->rqos_debugfs_dir);
> +	q->rqos_debugfs_dir = NULL;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (hctx->debugfs_dir)
> +			blk_mq_debugfs_unregister_hctx(hctx);
> +		if (hctx->sched_debugfs_dir)
> +			blk_mq_debugfs_unregister_sched_hctx(hctx);
> +	}
> +
> +	if (q->sched_debugfs_dir)
> +		blk_mq_debugfs_unregister_sched(q);
> +
> +	debugfs_remove_files(q->debugfs_dir, blk_mq_debugfs_queue_attrs);
> +}
> +
>   static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
>   					struct blk_mq_ctx *ctx)
>   {
> @@ -704,7 +748,7 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
>   	char name[20];
>   	int i;
>   
> -	if (!q->debugfs_dir)
> +	if (!q->debugfs_dir || !test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags))
>   		return;
>   
>   	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
> @@ -718,7 +762,8 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
>   
>   void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
>   {
> -	if (!hctx->queue->debugfs_dir)
> +	if (!hctx->queue->debugfs_dir ||
> +	    !test_bit(QUEUE_FLAG_DEBUGFS, &hctx->queue->queue_flags))
>   		return;
>   	debugfs_remove_recursive(hctx->debugfs_dir);
>   	hctx->sched_debugfs_dir = NULL;
> @@ -756,7 +801,8 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
>   	if (!q->debugfs_dir)
>   		return;
>   
> -	if (!e->queue_debugfs_attrs)
> +	if (!e->queue_debugfs_attrs ||
> +	    !test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags))
>   		return;
>   
>   	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
> @@ -802,7 +848,8 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>   
>   	lockdep_assert_held(&q->debugfs_mutex);
>   
> -	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
> +	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs ||
> +	    !test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags))
>   		return;
>   
>   	if (!q->rqos_debugfs_dir)
> @@ -828,7 +875,8 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
>   	if (!hctx->debugfs_dir)
>   		return;
>   
> -	if (!e->hctx_debugfs_attrs)
> +	if (!e->hctx_debugfs_attrs ||
> +	    !test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags))
>   		return;
>   
>   	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 9c7d4b6117d4..c8dd03f73d8c 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -21,6 +21,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
>   int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
>   
>   void blk_mq_debugfs_register(struct request_queue *q);
> +void blk_mq_debugfs_unregister(struct request_queue *q);
>   void blk_mq_debugfs_register_hctx(struct request_queue *q,
>   				  struct blk_mq_hw_ctx *hctx);
>   void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 1a743b4f2958..450acea23f21 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -618,6 +618,44 @@ QUEUE_RW_ENTRY(queue_iostats, "iostats");
>   QUEUE_RW_ENTRY(queue_random, "add_random");
>   QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
>   
> +#ifdef CONFIG_BLK_DEBUG_FS
> +static ssize_t queue_debugfs_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags),
> +			      page);
> +}
> +
> +static ssize_t queue_debugfs_store(struct request_queue *q, const char *page,
> +				   size_t count)
> +{
> +	unsigned long val;
> +	bool enabled;
> +	ssize_t ret = queue_var_store(&val, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&q->debugfs_mutex);
> +	enabled = test_bit(QUEUE_FLAG_DEBUGFS, &q->queue_flags);
> +	if (val) {
> +		if (!enabled && queue_is_mq(q)) {
> +			blk_queue_flag_set(QUEUE_FLAG_DEBUGFS, q);
> +			blk_mq_debugfs_register(q);
> +		}
> +	} else {
> +		if (enabled) {
> +			blk_mq_debugfs_unregister(q);
> +			blk_queue_flag_clear(QUEUE_FLAG_DEBUGFS, q);
> +		}
> +	}
> +	mutex_unlock(&q->debugfs_mutex);
> +
> +	return ret;
> +}
> +
> +QUEUE_RW_ENTRY(queue_debugfs, "debugfs");
> +#endif
> +
>   static struct attribute *queue_attrs[] = {
>   	&queue_requests_entry.attr,
>   	&queue_ra_entry.attr,
> @@ -664,6 +702,9 @@ static struct attribute *queue_attrs[] = {
>   #endif
>   	&queue_virt_boundary_mask_entry.attr,
>   	&queue_dma_alignment_entry.attr,
> +#ifdef CONFIG_BLK_DEBUG_FS
> +	&queue_debugfs_entry.attr,
> +#endif
>   	NULL,
>   };
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e3242e67a8e3..be51592751b2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -544,6 +544,7 @@ struct request_queue {
>   #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
>   #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
>   #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
> +#define QUEUE_FLAG_DEBUGFS	8	/* supports debugfs */
>   #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
>   #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
>   #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
> @@ -566,6 +567,7 @@ struct request_queue {
>   #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
>   
>   #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
> +				 (1UL << QUEUE_FLAG_DEBUGFS) |	\
>   				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
>   				 (1UL << QUEUE_FLAG_NOWAIT))
>   
> 

