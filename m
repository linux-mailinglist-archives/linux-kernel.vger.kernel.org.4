Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE56274FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiKNDdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiKNDdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:33:21 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E515838;
        Sun, 13 Nov 2022 19:33:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N9Zdj6MLcz4f3jqv;
        Mon, 14 Nov 2022 11:33:13 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgAH_qz7tnFjWPXbAQ--.18277S3;
        Mon, 14 Nov 2022 11:33:16 +0800 (CST)
Subject: Re: [PATCH v1] block, bfq: do the all counting of pending-request if
 CONFIG_BFQ_GROUP_IOSCHED is enabled
To:     Yuwei Guan <ssawgyw@gmail.com>, paolo.valente@linaro.org,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3153dcb3-dd9b-7a2b-a15a-8244d805f246@huaweicloud.com>
Date:   Mon, 14 Nov 2022 11:33:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAH_qz7tnFjWPXbAQ--.18277S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxtrWxZFW7Gry7tF48Xrb_yoW5tF1kpa
        98K3W5CF1rJrs5Wry5A3W8Xr93Wr95ZFy2kF4qy34Skr47ZF9aq3ZIkr1Fvr1Igr93Awsr
        ZF10grWDZw17taUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/11/10 19:26, Yuwei Guan Ð´µÀ:
> The 'bfqd->num_groups_with_pending_reqs' is used when
> CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
> take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.
> 

This patch looks good to me, fell free to add:
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

BTW, this patch need to be reviewed by Jan or Paolo before it can be
applied.

Thanks,
Kuai

> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   block/bfq-iosched.c | 2 ++
>   block/bfq-iosched.h | 4 ++++
>   block/bfq-wf2q.c    | 8 ++++----
>   3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 2381cf220ba2..5f54091e7fe9 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7051,7 +7051,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>   	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
>   
>   	bfqd->queue_weights_tree = RB_ROOT_CACHED;
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	bfqd->num_groups_with_pending_reqs = 0;
> +#endif
>   
>   	INIT_LIST_HEAD(&bfqd->active_list);
>   	INIT_LIST_HEAD(&bfqd->idle_list);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 9fa89577322d..41aa151ccc22 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -197,8 +197,10 @@ struct bfq_entity {
>   	/* flag, set to request a weight, ioprio or ioprio_class change  */
>   	int prio_changed;
>   
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	/* flag, set if the entity is counted in groups_with_pending_reqs */
>   	bool in_groups_with_pending_reqs;
> +#endif
>   
>   	/* last child queue of entity created (for non-leaf entities) */
>   	struct bfq_queue *last_bfqq_created;
> @@ -491,6 +493,7 @@ struct bfq_data {
>   	 */
>   	struct rb_root_cached queue_weights_tree;
>   
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	/*
>   	 * Number of groups with at least one process that
>   	 * has at least one request waiting for completion. Note that
> @@ -538,6 +541,7 @@ struct bfq_data {
>   	 * with no request waiting for completion.
>   	 */
>   	unsigned int num_groups_with_pending_reqs;
> +#endif
>   
>   	/*
>   	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index b02b53658ed4..ea4c3d757fdd 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1612,28 +1612,28 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   
>   void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>   {
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	struct bfq_entity *entity = &bfqq->entity;
>   
>   	if (!entity->in_groups_with_pending_reqs) {
>   		entity->in_groups_with_pending_reqs = true;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
>   			bfqq->bfqd->num_groups_with_pending_reqs++;
> -#endif
>   	}
> +#endif
>   }
>   
>   void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>   {
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	struct bfq_entity *entity = &bfqq->entity;
>   
>   	if (entity->in_groups_with_pending_reqs) {
>   		entity->in_groups_with_pending_reqs = false;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
>   			bfqq->bfqd->num_groups_with_pending_reqs--;
> -#endif
>   	}
> +#endif
>   }
>   
>   /*
> 

