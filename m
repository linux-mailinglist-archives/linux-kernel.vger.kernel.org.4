Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC65F4C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJDXGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJDXG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:06:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF106275F9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664924784; x=1696460784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xVlEUpMlEbTYKBpqXysTIcl/6AymFTBVubGoimsZa/s=;
  b=KyRy71pEofKjPJDesJg+87kNT08jw2tKuoJmMb3N3JgYGxJ1Ufv0/apH
   GA33oaAYsR0mmeTWmK+OQfybtuVoJmUcyGd9hmwTpsVy3fmLq21Sfdh54
   Pd9t+pviTe+Twy9Q8GOS4FUmQ4iaHL0vwHVttuMO5lepsntIzrPwding3
   ernfmS3bf9kEWew8avt6XP3hkDtjkeM4NGPGv6Giri9oSRb6e/zaQ1no8
   DfoF7O15RCf56cH7RNNV53pyM7XYiIKby3Q/NPnSGdK5aZJVp5nW/GKHw
   98Iqwz4L8KoTBgXUmHKEfblNpWP+QgW+FxiYsYWX0RX4rCw/LLM85IrVR
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="212995654"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 07:06:23 +0800
IronPort-SDR: zSk4pRXzPxriOZBuc0jpus4TgQssyItG/r89ooQ/drBGCKJ5mDTrTLGjrWWkCwZ/JKzHX7+ERl
 5fNewM5aMEbcN+59nEJra30y+XXJmHFR1suj2lXJoI09A/n3RgUDIAzcflTYs8qZLYSVRh9Zcz
 90mTkPQBRB0GTF8TXm+TbNJz1eg42gzrtOcMWscKPtU3tGvmpMZy7+F/JYsH3xHRNOS0iRCVH2
 5TwrlyeLKDiGRBQVCJXNmJL8UXrwISQEADfMO2w96jpHr3EzN2RJWxNrL/SnCS/Zlm7OTqFz65
 zpy5u+u3hmSnRphRGSFWzTCW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:26:12 -0700
IronPort-SDR: QZTbEzS8kQGl28Ccc2NZZF4PKlIaac26quBqFWFJhXKsXy/sMdQ/PZn3cI0EtCd7m/wZ/vIHX9
 iW5L2HguZ+pjc8T6gR3WuXbIn2VWsqmd78v6cjiebhZ6PwyuMn386DFdGeg37CFY38BaI5G8i7
 TElT9VqSgiqRCWLNQIirTuvwqCs01VucLmVsBxs9KY6diD5FvgqyLC5CDq5vmwf+dNgvMco6qj
 3VzANlxHv7q0NnDnc+qrVCuCEbgthSd8f0IMNBiGB13h/fuof8BzYL9Xcedly6ffKfESNMR9Ba
 mkM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 16:06:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MhtcH5cFHz1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:06:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664924781; x=1667516782; bh=xVlEUpMlEbTYKBpqXysTIcl/6AymFTBVubG
        oimsZa/s=; b=jujZFQQiYO4S4C8n6aQo/IHv1hpuPLQj6V6VvWBq+z5TidA6spd
        G/6gq8OkUofGch3+23ecrfkwA7rxsYEz1qHx/mo6zXLJ13uAqIYMdbAy8pqrAbPK
        w9bcMg39IadOX1DNGDebabIFUiM+/h988WyQ+fj+XJ9ZxQGQf1OozXAG/iOkxcrX
        ICnKxXxucaySjYbc1OVAa+iIdy8bBkoZNp2r1unbZcmn7xdPgi4BJe5XS0mN5N10
        iQCEuF9QTkL//mvElcH3/N0s3I7E7Kw+6EYbuFb+EHfWRqRlP4rJxAGn+TRFoQXc
        29US/Toz/zPB1uuZo/YpJatxJ0HAizLmG8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gc_Rx0yO-44k for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 16:06:21 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MhtcC1Z31z1RvLy;
        Tue,  4 Oct 2022 16:06:19 -0700 (PDT)
Message-ID: <2030ac1d-4ce2-dd99-8b68-6f9e708f2aa1@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 08:06:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V3 3/8] block, bfq: turn scalar fields into arrays in
 bfq_io_cq
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Gabriele Felici <felicigb@gmail.com>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
 <20221004094010.80090-4-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221004094010.80090-4-paolo.valente@linaro.org>
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
> When a bfq_queue Q is merged with another queue, several pieces of
> information are saved about Q. These pieces are stored in the
> bfq_io_cq data structure of the process associated with Q. In
> particular, each such piece is represented by a scalar field in
> bfq_io_cq.
> 
> Yet, with a multi-actuator drive, a process gets associated with
> multiple bfq_queues: one queue for each of the N actuators. Each of
> these queues may undergo a merge. So, the bfq_io_cq data structure
> must be able to accommodate the above information for N queues.
> 
> This commit solves this problem by turning each scalar field into an
> array of N elements (and by changing code so as to handle these
> arrays).
> 
> This solution is written under the assumption that bfq_queues
> associated with different actuators cannot be cross-merged. This
> assumption holds naturally with basic queue merging: the latter is
> triggered by spatial locality, and sectors for different actuators are
> not close to each other. As for stable cross-merging, the assumption
> here is that it is disabled.
> 
> Signed-off-by: Gabriele Felici <felicigb@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 139 ++++++++++++++++++++++++--------------------
>  block/bfq-iosched.h |  52 ++++++++++-------
>  2 files changed, 105 insertions(+), 86 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 2a75009c1c06..dede0e948836 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -406,7 +406,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  	 */
>  	bic->bfqq[is_sync][actuator_idx] = bfqq;
>  
> -	if (bfqq && bic->stable_merge_bfqq == bfqq) {
> +	if (bfqq && bic->stable_merge_bfqq[actuator_idx] == bfqq) {
>  		/*
>  		 * Actually, these same instructions are executed also
>  		 * in bfq_setup_cooperator, in case of abort or actual
> @@ -415,9 +415,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  		 * did so, we would nest even more complexity in this
>  		 * function.
>  		 */
> -		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		bfq_put_stable_ref(bic->stable_merge_bfqq[actuator_idx]);
>  
> -		bic->stable_merge_bfqq = NULL;
> +		bic->stable_merge_bfqq[actuator_idx] = NULL;
>  	}
>  }
>  
> @@ -1176,36 +1176,38 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>  {
>  	unsigned int old_wr_coeff = 1;
>  	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
> +	unsigned int a_idx = bfqq->actuator_idx;
>  
> -	if (bic->saved_has_short_ttime)
> +	if (bic->saved_has_short_ttime[a_idx])
>  		bfq_mark_bfqq_has_short_ttime(bfqq);
>  	else
>  		bfq_clear_bfqq_has_short_ttime(bfqq);
>  
> -	if (bic->saved_IO_bound)
> +	if (bic->saved_IO_bound[a_idx])
>  		bfq_mark_bfqq_IO_bound(bfqq);
>  	else
>  		bfq_clear_bfqq_IO_bound(bfqq);
>  
> -	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
> -	bfqq->inject_limit = bic->saved_inject_limit;
> -	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
> +	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns[a_idx];
> +	bfqq->inject_limit = bic->saved_inject_limit[a_idx];
> +	bfqq->decrease_time_jif = bic->saved_decrease_time_jif[a_idx];
>  
> -	bfqq->entity.new_weight = bic->saved_weight;
> -	bfqq->ttime = bic->saved_ttime;
> -	bfqq->io_start_time = bic->saved_io_start_time;
> -	bfqq->tot_idle_time = bic->saved_tot_idle_time;
> +	bfqq->entity.new_weight = bic->saved_weight[a_idx];
> +	bfqq->ttime = bic->saved_ttime[a_idx];
> +	bfqq->io_start_time = bic->saved_io_start_time[a_idx];
> +	bfqq->tot_idle_time = bic->saved_tot_idle_time[a_idx];
>  	/*
>  	 * Restore weight coefficient only if low_latency is on
>  	 */
>  	if (bfqd->low_latency) {
>  		old_wr_coeff = bfqq->wr_coeff;
> -		bfqq->wr_coeff = bic->saved_wr_coeff;
> +		bfqq->wr_coeff = bic->saved_wr_coeff[a_idx];
>  	}
> -	bfqq->service_from_wr = bic->saved_service_from_wr;
> -	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
> -	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
> -	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
> +	bfqq->service_from_wr = bic->saved_service_from_wr[a_idx];
> +	bfqq->wr_start_at_switch_to_srt =
> +				bic->saved_wr_start_at_switch_to_srt[a_idx];
> +	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish[a_idx];
> +	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time[a_idx];
>  
>  	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
>  	    time_is_before_jiffies(bfqq->last_wr_start_finish +
> @@ -1824,6 +1826,16 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
>  	return bfqq_weight > in_serv_weight;
>  }
>  
> +/* get the index of the actuator that will serve bio */
> +static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
> +{
> +	/*
> +	 * Multi-actuator support not complete yet, so always return 0
> +	 * for the moment.
> +	 */
> +	return 0;
> +}
> +
>  static bool bfq_better_to_idle(struct bfq_queue *bfqq);
>  
>  static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
> @@ -1878,7 +1890,9 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	wr_or_deserves_wr = bfqd->low_latency &&
>  		(bfqq->wr_coeff > 1 ||
>  		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
> +		  (bfqq->bic ||
> +		   RQ_BIC(rq)->stably_merged
> +		   [bfq_actuator_index(bfqd, rq->bio)]) &&
>  		   (*interactive || soft_rt)));
>  
>  	/*
> @@ -2466,16 +2480,6 @@ static void bfq_remove_request(struct request_queue *q,
>  
>  }
>  
> -/* get the index of the actuator that will serve bio */
> -static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
> -{
> -	/*
> -	 * Multi-actuator support not complete yet, so always return 0
> -	 * for the moment.
> -	 */
> -	return 0;
> -}
> -
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -2902,6 +2906,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		     void *io_struct, bool request, struct bfq_io_cq *bic)
>  {
>  	struct bfq_queue *in_service_bfqq, *new_bfqq;
> +	unsigned int a_idx = bfqq->actuator_idx;
>  
>  	/* if a merge has already been setup, then proceed with that first */
>  	if (bfqq->new_bfqq)
> @@ -2923,21 +2928,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		 * stable merging) also if bic is associated with a
>  		 * sync queue, but this bfqq is async
>  		 */
> -		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
> +		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq[a_idx] &&
>  		    !bfq_bfqq_just_created(bfqq) &&
>  		    time_is_before_jiffies(bfqq->split_time +
>  					  msecs_to_jiffies(bfq_late_stable_merging)) &&
>  		    time_is_before_jiffies(bfqq->creation_time +
>  					   msecs_to_jiffies(bfq_late_stable_merging))) {
>  			struct bfq_queue *stable_merge_bfqq =
> -				bic->stable_merge_bfqq;
> +				bic->stable_merge_bfqq[a_idx];
>  			int proc_ref = min(bfqq_process_refs(bfqq),
>  					   bfqq_process_refs(stable_merge_bfqq));
>  
>  			/* deschedule stable merge, because done or aborted here */
>  			bfq_put_stable_ref(stable_merge_bfqq);
>  
> -			bic->stable_merge_bfqq = NULL;
> +			bic->stable_merge_bfqq[a_idx] = NULL;
>  
>  			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
>  			    proc_ref > 0) {
> @@ -2946,9 +2951,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  					bfq_setup_merge(bfqq, stable_merge_bfqq);
>  
>  				if (new_bfqq) {
> -					bic->stably_merged = true;
> +					bic->stably_merged[a_idx] = true;
>  					if (new_bfqq->bic)
> -						new_bfqq->bic->stably_merged =
> +						new_bfqq->bic->stably_merged
> +						    [new_bfqq->actuator_idx] =
>  									true;
>  				}
>  				return new_bfqq;
> @@ -3048,6 +3054,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
> +	/* State must be saved for the right queue index. */
> +	unsigned int a_idx = bfqq->actuator_idx;
>  
>  	/*
>  	 * If !bfqq->bic, the queue is already shared or its requests
> @@ -3057,18 +3065,18 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  	if (!bic)
>  		return;
>  
> -	bic->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> -	bic->saved_inject_limit = bfqq->inject_limit;
> -	bic->saved_decrease_time_jif = bfqq->decrease_time_jif;
> -
> -	bic->saved_weight = bfqq->entity.orig_weight;
> -	bic->saved_ttime = bfqq->ttime;
> -	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
> -	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
> -	bic->saved_io_start_time = bfqq->io_start_time;
> -	bic->saved_tot_idle_time = bfqq->tot_idle_time;
> -	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
> -	bic->was_in_burst_list = !hlist_unhashed(&bfqq->burst_list_node);
> +	bic->saved_last_serv_time_ns[a_idx] = bfqq->last_serv_time_ns;
> +	bic->saved_inject_limit[a_idx] = bfqq->inject_limit;
> +	bic->saved_decrease_time_jif[a_idx] = bfqq->decrease_time_jif;
> +
> +	bic->saved_weight[a_idx] = bfqq->entity.orig_weight;
> +	bic->saved_ttime[a_idx] = bfqq->ttime;
> +	bic->saved_has_short_ttime[a_idx] = bfq_bfqq_has_short_ttime(bfqq);
> +	bic->saved_IO_bound[a_idx] = bfq_bfqq_IO_bound(bfqq);
> +	bic->saved_io_start_time[a_idx] = bfqq->io_start_time;
> +	bic->saved_tot_idle_time[a_idx] = bfqq->tot_idle_time;
> +	bic->saved_in_large_burst[a_idx] = bfq_bfqq_in_large_burst(bfqq);
> +	bic->was_in_burst_list[a_idx] = !hlist_unhashed(&bfqq->burst_list_node);
>  	if (unlikely(bfq_bfqq_just_created(bfqq) &&
>  		     !bfq_bfqq_in_large_burst(bfqq) &&
>  		     bfqq->bfqd->low_latency)) {
> @@ -3081,17 +3089,17 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  		 * to bfqq, so that to avoid that bfqq unjustly fails
>  		 * to enjoy weight raising if split soon.
>  		 */
> -		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
> -		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
> -		bic->saved_last_wr_start_finish = jiffies;
> +		bic->saved_wr_coeff[a_idx] = bfqq->bfqd->bfq_wr_coeff;
> +		bic->saved_wr_start_at_switch_to_srt[a_idx] = bfq_smallest_from_now();
> +		bic->saved_wr_cur_max_time[a_idx] = bfq_wr_duration(bfqq->bfqd);
> +		bic->saved_last_wr_start_finish[a_idx] = jiffies;
>  	} else {
> -		bic->saved_wr_coeff = bfqq->wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt =
> +		bic->saved_wr_coeff[a_idx] = bfqq->wr_coeff;
> +		bic->saved_wr_start_at_switch_to_srt[a_idx] =
>  			bfqq->wr_start_at_switch_to_srt;
> -		bic->saved_service_from_wr = bfqq->service_from_wr;
> -		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
> -		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
> +		bic->saved_service_from_wr[a_idx] = bfqq->service_from_wr;
> +		bic->saved_last_wr_start_finish[a_idx] = bfqq->last_wr_start_finish;
> +		bic->saved_wr_cur_max_time[a_idx] = bfqq->wr_cur_max_time;
>  	}
>  }
>  
> @@ -5423,8 +5431,8 @@ static void bfq_exit_icq(struct io_cq *icq)
>  		spin_lock_irqsave(&bfqd->lock, flags);
>  
>  	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
> -		if (bic->stable_merge_bfqq)
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		if (bic->stable_merge_bfqq[act_idx])
> +			bfq_put_stable_ref(bic->stable_merge_bfqq[act_idx]);
>  
>  		bfq_exit_icq_bfqq(bic, true, act_idx);
>  		bfq_exit_icq_bfqq(bic, false, act_idx);
> @@ -5612,6 +5620,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  			  struct bfq_io_cq *bic,
>  			  struct bfq_queue *last_bfqq_created)
>  {
> +	unsigned int a_idx = last_bfqq_created->actuator_idx;
>  	struct bfq_queue *new_bfqq =
>  		bfq_setup_merge(bfqq, last_bfqq_created);
>  
> @@ -5619,8 +5628,8 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		return bfqq;
>  
>  	if (new_bfqq->bic)
> -		new_bfqq->bic->stably_merged = true;
> -	bic->stably_merged = true;
> +		new_bfqq->bic->stably_merged[a_idx] = true;
> +	bic->stably_merged[a_idx] = true;
>  
>  	/*
>  	 * Reusing merge functions. This implies that
> @@ -5750,7 +5759,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  			/*
>  			 * Record the bfqq to merge to.
>  			 */
> -			bic->stable_merge_bfqq = last_bfqq_created;
> +			bic->stable_merge_bfqq[last_bfqq_created->actuator_idx]
> +							   = last_bfqq_created;
>  		}
>  	}
>  
> @@ -6684,12 +6694,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  
>  	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>  	if (split && is_sync) {
> -		if ((bic->was_in_burst_list && bfqd->large_burst) ||
> -		    bic->saved_in_large_burst)
> +		if ((bic->was_in_burst_list[act_idx] && bfqd->large_burst) ||
> +		    bic->saved_in_large_burst[act_idx])
>  			bfq_mark_bfqq_in_large_burst(bfqq);
>  		else {
>  			bfq_clear_bfqq_in_large_burst(bfqq);
> -			if (bic->was_in_burst_list)
> +			if (bic->was_in_burst_list[act_idx])
>  				/*
>  				 * If bfqq was in the current
>  				 * burst list before being
> @@ -6778,6 +6788,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	struct bfq_queue *bfqq;
>  	bool new_queue = false;
>  	bool bfqq_already_existing = false, split = false;
> +	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
>  
>  	if (unlikely(!rq->elv.icq))
>  		return NULL;
> @@ -6804,12 +6815,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	if (likely(!new_queue)) {
>  		/* If the queue was seeky for too long, break it apart. */
>  		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
> -			!bic->stably_merged) {
> +			!bic->stably_merged[a_idx]) {
>  			struct bfq_queue *old_bfqq = bfqq;
>  
>  			/* Update bic before losing reference to bfqq */
>  			if (bfq_bfqq_in_large_burst(bfqq))
> -				bic->saved_in_large_burst = true;
> +				bic->saved_in_large_burst[a_idx] = true;
>  
>  			bfqq = bfq_split_bfqq(bic, bfqq);
>  			split = true;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 8b5225a9e080..0ff6be18f72a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -431,30 +431,37 @@ struct bfq_io_cq {
>  	uint64_t blkcg_serial_nr; /* the current blkcg serial */
>  #endif
>  	/*
> -	 * Snapshot of the has_short_time flag before merging; taken
> -	 * to remember its value while the queue is merged, so as to
> -	 * be able to restore it in case of split.
> +	 * Several fields follow, which are used to support
> +	 * queue-merging operations. Each field is an array, because a
> +	 * process may be associated with multiple bfq_queues (see the
> +	 * field bfqq above). And each of these queues may undergo a
> +	 * merge.
>  	 */
> -	bool saved_has_short_ttime;
> +	/*
> +	 * Snapshot of the has_short_time flags before merging; taken
> +	 * to remember their values while a queue is merged, so as to
> +	 * be able to restore them in case of split.
> +	 */
> +	bool saved_has_short_ttime[BFQ_NUM_ACTUATORS];
>  	/*
>  	 * Same purpose as the previous two fields for the I/O bound
>  	 * classification of a queue.
>  	 */
> -	bool saved_IO_bound;
> +	bool saved_IO_bound[BFQ_NUM_ACTUATORS];
>  
> -	u64 saved_io_start_time;
> -	u64 saved_tot_idle_time;
> +	u64 saved_io_start_time[BFQ_NUM_ACTUATORS];
> +	u64 saved_tot_idle_time[BFQ_NUM_ACTUATORS];
>  
>  	/*
> -	 * Same purpose as the previous fields for the value of the
> +	 * Same purpose as the previous fields for the values of the
>  	 * field keeping the queue's belonging to a large burst
>  	 */
> -	bool saved_in_large_burst;
> +	bool saved_in_large_burst[BFQ_NUM_ACTUATORS];
>  	/*
>  	 * True if the queue belonged to a burst list before its merge
>  	 * with another cooperating queue.
>  	 */
> -	bool was_in_burst_list;
> +	bool was_in_burst_list[BFQ_NUM_ACTUATORS];
>  
>  	/*
>  	 * Save the weight when a merge occurs, to be able
> @@ -463,27 +470,28 @@ struct bfq_io_cq {
>  	 * then the weight of the recycled queue could differ
>  	 * from the weight of the original queue.
>  	 */
> -	unsigned int saved_weight;
> +	unsigned int saved_weight[BFQ_NUM_ACTUATORS];
>  
>  	/*
>  	 * Similar to previous fields: save wr information.
>  	 */
> -	unsigned long saved_wr_coeff;
> -	unsigned long saved_last_wr_start_finish;
> -	unsigned long saved_service_from_wr;
> -	unsigned long saved_wr_start_at_switch_to_srt;
> -	unsigned int saved_wr_cur_max_time;
> -	struct bfq_ttime saved_ttime;
> +	unsigned long saved_wr_coeff[BFQ_NUM_ACTUATORS];
> +	unsigned long saved_last_wr_start_finish[BFQ_NUM_ACTUATORS];
> +	unsigned long saved_service_from_wr[BFQ_NUM_ACTUATORS];
> +	unsigned long saved_wr_start_at_switch_to_srt[BFQ_NUM_ACTUATORS];
> +	unsigned int saved_wr_cur_max_time[BFQ_NUM_ACTUATORS];
> +	struct bfq_ttime saved_ttime[BFQ_NUM_ACTUATORS];
>  
>  	/* Save also injection state */
> -	u64 saved_last_serv_time_ns;
> -	unsigned int saved_inject_limit;
> -	unsigned long saved_decrease_time_jif;
> +	u64 saved_last_serv_time_ns[BFQ_NUM_ACTUATORS];
> +	unsigned int saved_inject_limit[BFQ_NUM_ACTUATORS];
> +	unsigned long saved_decrease_time_jif[BFQ_NUM_ACTUATORS];

Instead of changing all these fields to an array, why not pack them into a
structure and have a single array of structures here ? That would be a lot
cleaner I think.

>  
>  	/* candidate queue for a stable merge (due to close creation time) */
> -	struct bfq_queue *stable_merge_bfqq;
> +	struct bfq_queue *stable_merge_bfqq[BFQ_NUM_ACTUATORS];
> +
> +	bool stably_merged[BFQ_NUM_ACTUATORS];	/* non splittable if true */
>  
> -	bool stably_merged;	/* non splittable if true */
>  	unsigned int requests;	/* Number of requests this process has in flight */
>  };
>  

-- 
Damien Le Moal
Western Digital Research

