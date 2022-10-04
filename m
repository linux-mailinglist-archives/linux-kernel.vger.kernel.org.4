Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E145F4C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJDWyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJDWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:53:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4716F25A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664924025; x=1696460025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=61OqWLOJ1qZP4yhC+R446jKFAiOWBMQf9fOX2cvP8VE=;
  b=d6F9x+DdkcZtKou+kXZ7UxwsgXEYC0unc5uMd8YIjhQsaCa+bjDKTH3X
   AWjhU5kKc3ZALc9qUNYft716BmYqXR42h10aqHBdcQRL7oIN+lEcbL9+x
   ifGKeqtlK80SiRwf4KkCP6yQ5URlujfzDYdagod3RgNx/FMX0qnmLWQdU
   EbJ618EwoyZ2Dim/hS1n8hGOGTFwnLPYyJ9giUppteIedsZvZ3pdWbXY3
   XOtrwnri5dVD9oA0GEMrE+XHZc2cg5cZNiOfVD7FwfbrfbxMzER0HMB1x
   3cAa7DfWxPfgKeOwADr4ImNSCn93lA9lFFK2/9bZiJZ1/jLkuEIFIjsU0
   g==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="211344473"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 06:53:43 +0800
IronPort-SDR: tC92Ge5+jurFHHgPE2y3tDu1gCIypEGFU8BCheoxj50znyitGdy/vrGrFfks5SuJanVpiSH6O9
 xLtqBtyYjIUorw+P7ceudh7ZaiOw5w7wNYZv6l3bj3mHhVEjBsPNEQTHli8f9I0aZyPtGFsra0
 f2+6t0BjbhWDEF9gmtwxm+2/CCtjGvKPNApS4sxTLrIaJv4CDt2XPQi08ohiuED3E4P7JPgDeq
 A1bmJtYZ/Z4gBpsQAMYhX7Q8PeLGdZgfwYQvhQD2V/Xuy4KdbxyUYGiSUFX/N7VJmLDVz3+3Gb
 AIQl1d8e8L1MXmj9EX3glFrV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:07:57 -0700
IronPort-SDR: vVRF00XniOtB50SL56n9TSFpHI0NvoILmJXAaTZsXkfnnscNjJ6WMVwCIXo4TizRICH7ohT01B
 KjImjP0ajAlMfx6HeoqiyuZMfugeZGKZEsSG+MvfFEGxKLu4OaGnhjMJRLMGWujKOMvlAHHmAT
 Qc8q8wqnI4pnYUtr2nX5NKnoVIZz+FT0aDrNtKn5hJldoEj82RqYYkz6VlJqjqbDsoCSo0e+Cv
 ScWUwehFcaUs4nH2AqhRToqL5HvLXixLPDo9fK9MqsSUsfJ+RCBKzMf5Val8cmXIgIs9UOCfxM
 RRk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:53:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MhtKg1gHNz1RwtC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:53:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664924021; x=1667516022; bh=61OqWLOJ1qZP4yhC+R446jKFAiOWBMQf9fO
        X2cvP8VE=; b=RqzS3Znx3azzqhmri2R6GRvXevwMldY4Q0y+Zio730o1JGh4xCj
        vfEdfvWDYoZNSDwYNkoQLgSJ4K3dVJSVASX3fo7lK8weO33sR0BSL2CvXNWkIDpo
        BB3uUK7p2BrZzy5scAfQ5O+SejCVp9NLuiM3MbK+0OEYd7vh8IOB0lNhJh2DDHW8
        2q6fDbDjE6uLBagSX2x/Rm/2ExDZoztdgAtXSDyQdP4HeJafx0MQf68rFLo1PqL3
        +nCoGHk2n4xafB4H31I+B7WGE5Vukhi6CyW9TQY/6q+U6NrzWsc3eRekSzR/PcQq
        8xcitNKl7+QRFrO9lE9dAgLHKiRvMUTKcTw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gp8ZaUoCp3KU for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 15:53:41 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MhtKc0qG9z1RvLy;
        Tue,  4 Oct 2022 15:53:39 -0700 (PDT)
Message-ID: <5e696c5f-c39f-88a4-5f94-03fdf884bb34@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 07:53:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V3 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
 <20221004094010.80090-7-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221004094010.80090-7-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 18:40, Paolo Valente wrote:
> From: Federico Gavioli <f.gavioli97@gmail.com>
> 
> This patch implements the code to gather the content of the
> independent_access_ranges structure from the request_queue and copy
> it into the queue's bfq_data. This copy is done at queue initialization.
> 
> We copy the access ranges into the bfq_data to avoid taking the queue
> lock each time we access the ranges.
> 
> This implementation, however, puts a limit to the maximum independent
> ranges supported by the scheduler. Such a limit is equal to the constant
> BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
> dynamic memory.
> 
> Reviewed-by: Damien Le Moal <Damien.LeMoal@wdc.com>

I merely commented on a point you raised. That was not a patch review. So
please do not add my RB tag without me sending it. And my preferred email
address is damien.lemoal@opensource.wdc.com.

Also, please send the whole series to have context for each patch.

> Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
> ---
>  block/bfq-cgroup.c  |  2 +-
>  block/bfq-iosched.c | 59 ++++++++++++++++++++++++++++++++++++++-------
>  block/bfq-iosched.h | 12 +++++++++
>  3 files changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 3b4a0363d617..080d9160217b 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -764,7 +764,7 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
>  	struct bfq_entity *entity;
>  	unsigned int act_idx;
>  
> -	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
> +	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
>  		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0, act_idx);
>  		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1, act_idx);
>  
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index d8a15427a96d..9203b4604da8 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -689,7 +689,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  		limit = (limit * depth) >> bfqd->full_depth_shift;
>  	}
>  
> -	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
> +	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
>  		struct bfq_queue *bfqq =
>  			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
>  
> @@ -1829,10 +1829,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
>  /* get the index of the actuator that will serve bio */
>  static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
>  {
> -	/*
> -	 * Multi-actuator support not complete yet, so always return 0
> -	 * for the moment.
> -	 */
> +	struct blk_independent_access_range *iar;
> +	unsigned int i;
> +	sector_t end;
> +
> +	if (bfqd->num_ia_ranges == 1)
> +		return 0;
> +
> +	/* bio_end_sector(bio) gives the sector after the last one */
> +	end = bio_end_sector(bio) - 1;
> +
> +	for (i = 0; i < bfqd->num_ia_ranges; i++) {
> +		iar = &(bfqd->ia_ranges[i]);
> +		if (end >= iar->sector && end < iar->sector + iar->nr_sectors)
> +			return i;
> +	}
> +
> +	WARN_ONCE(true,
> +		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
> +		  end);
>  	return 0;
>  }
>  
> @@ -2477,7 +2492,6 @@ static void bfq_remove_request(struct request_queue *q,
>  
>  	if (rq->cmd_flags & REQ_META)
>  		bfqq->meta_pending--;
> -
>  }
>  
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
> @@ -2673,7 +2687,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
>  {
>  	int i, j, k;
>  
> -	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
> +	for (k = 0; k < bfqd->num_ia_ranges; k++) {
>  		for (i = 0; i < 2; i++)
>  			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
>  				if (bfqg->async_bfqq[i][j][k])
> @@ -5432,7 +5446,7 @@ static void bfq_exit_icq(struct io_cq *icq)
>  	if (bfqd)
>  		spin_lock_irqsave(&bfqd->lock, flags);
>  
> -	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
> +	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
>  		if (bic->stable_merge_bfqq[act_idx])
>  			bfq_put_stable_ref(bic->stable_merge_bfqq[act_idx]);
>  
> @@ -7003,7 +7017,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>  {
>  	int i, j, k;
>  
> -	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
> +	for (k = 0; k < bfqd->num_ia_ranges; k++) {
>  		for (i = 0; i < 2; i++)
>  			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
>  				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
> @@ -7120,6 +7134,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  {
>  	struct bfq_data *bfqd;
>  	struct elevator_queue *eq;
> +	unsigned int i;
> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>  
>  	eq = elevator_alloc(q, e);
>  	if (!eq)
> @@ -7162,6 +7178,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  
>  	bfqd->queue = q;
>  
> +	/*
> +	 * If the disk supports multiple actuators, we copy the independent
> +	 * access ranges from the request queue structure.
> +	 */
> +	spin_lock_irq(&q->queue_lock);
> +	if (ia_ranges) {
> +		/*
> +		 * Check if the disk ia_ranges size exceeds the current bfq
> +		 * actuator limit.
> +		 */
> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
> +					ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
> +			pr_crit("Falling back to single actuator mode.\n");
> +			bfqd->num_ia_ranges = 1;

Setting this to one, one would expect bfqd->ia_ranges[0] to contain valid
information. So shouldn't you set it to sector 0 and nr_sector == capacity ?

> +		} else {
> +			bfqd->num_ia_ranges = ia_ranges->nr_ia_ranges;
> +
> +			for (i = 0; i < bfqd->num_ia_ranges; i++)
> +				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
> +		}
> +	} else
> +		bfqd->num_ia_ranges = 1;

Missing the curly brackets after else.

> +	spin_unlock_irq(&q->queue_lock);
> +
>  	INIT_LIST_HEAD(&bfqd->dispatch);
>  
>  	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index f9ccf468edc2..34f7603bb62f 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -796,6 +796,18 @@ struct bfq_data {
>  	 */
>  	unsigned int word_depths[2][2];
>  	unsigned int full_depth_shift;
> +
> +	/*
> +	 * Number of independent access ranges. This is equal to 1 in
> +	 * case of single actuator drives.
> +	 */
> +	unsigned int num_ia_ranges;
> +
> +	/*
> +	 * Disk independent access ranges for each actuator
> +	 * in this device.
> +	 */
> +	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
>  };
>  
>  enum bfqq_state_flags {

-- 
Damien Le Moal
Western Digital Research

