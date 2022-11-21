Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA3631822
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 02:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKUBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 20:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiKUBR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:17:59 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAAE193E5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668993477; x=1700529477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d45LbNYgnOqZEhfJ/9Cje4Fr7AdmmjUeQVMJHsm7K5c=;
  b=SBCGHUllebvVH5m6nbdjk8IrlIR/eP6Nxt+Qf1u6w6EKgT+68/mAT/z0
   qVMYDnuMStfblG4p2AEqr6N6PUfc/gOtR7zWV4QxSMaxoc1s0HxDMeXLE
   3n6MJdqk75jN2W2s6Ixu2Dx5/ghWxaLwlG4NMEXhbckD3ZnWMhKP2mQQl
   Uh1F1YP7aU+vf/IVX3Qs9ErQfXGTT3zMp+hMIk+v5Zehl6FmBp8E60p3+
   CnRBSgXoZKm0nhXpbMruBoM9SkWhdyzLqSMky7L4LyiCIqKEsCzoHaVyD
   vEYOrjzN5HwA5IPmU4J84MaiGAKCQRIXWz3lPcHRUHpwOzZC9CU0ClRE1
   A==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="221899795"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 09:17:56 +0800
IronPort-SDR: Pk/0vwRo7MMM789EOvjTKWNsJ2oRXjNWBptu7Z+3mGvinEtPG1p7tZv8gx4feUSxS64iPEyrSE
 Z+PwDSC/JtJrpW0KM20IKeeQhtI5lB9WgmoUET5VADby5clmdpJTHsttp8CtwaS1C2H+w+PXt6
 sT7vgEDAGT6LaoJxUEo0wjYaFckrifPW+hCPM5MmIJqbQq2gEWbZKSAipEeAN/1UmzwIV/byOs
 RDNxa5YS1mkNNGqm1YoyDL/51uII5/bg0HydqgwVEhIAG6L0QwxZ+et0rj46UaQNER2nmJxTwE
 UEI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:36:46 -0800
IronPort-SDR: F1teavwhH+TgSpAd+N1Dpcd33hdBIm0sc69WYG+yWKXT7xxdQCzduQQgtTNUmlhUkYaAce+QJL
 4oRly8cv57MVrZNRfdAXwfPniOl+vd45JRBcbkLtACRg/SjctO6/YuhReBkb2s3ekKehLDJDQE
 P2oISi+PfRRu9LRatkgzHtteMMexUdaEJR/wjB9z3rC9VT0SFIY+MHMbx87KgRYOYuBWyGLpj4
 Pfokxkit1MqZWzMwkG2RLZyi38D2ZLw33Ff+XV32YDfLLh6nOoBqj2I1uevHKAzY1UF4JgM/8f
 e90=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 17:17:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFqJM3L3sz1RwtC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:17:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668993473; x=1671585474; bh=d45LbNYgnOqZEhfJ/9Cje4Fr7AdmmjUeQVM
        JHsm7K5c=; b=gd2aAs01sbFf/KevE7MlKYkXS2o336McbmBX5HscRQYTGk0WHnb
        MPzWs8E61Ywj3cw+Q1T6ePCrsUuiZduzfJjMqn23c0pEKbjD99CBpGgH2Cbwma4R
        /JcVsFNghIEmNZmt1eJaYybTGaUO3H+ro/2shbw5GMyPZP/P62xjq3V+Bi8FgTJt
        w86aysr54/yW/5JKe2DH6vyY0s4LT3XNY42AiQFeOhgqovWlnmdDL40aomQ1vlOD
        DUYJ+/xyFEpbI5m9cHuzfWHLnOPniUvUvpFIeswL1rLW9QX+g981CUHdqw0zZ6Oq
        bAYNDPUlFG2aE6pSwfF0jw4g1fW7B5cA0kA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RnBUzZfEp7gM for <linux-kernel@vger.kernel.org>;
        Sun, 20 Nov 2022 17:17:53 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFqJH33Bxz1RvLy;
        Sun, 20 Nov 2022 17:17:51 -0800 (PST)
Message-ID: <e79d9c54-8724-0088-85e7-023f9bbc4170@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 10:17:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 7/8] block, bfq: inject I/O to underutilized actuators
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-8-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-8-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 01:26, Paolo Valente wrote:
> From: Davide Zini <davidezini2@gmail.com>
> 
> The main service scheme of BFQ for sync I/O is serving one sync
> bfq_queue at a time, for a while. In particular, BFQ enforces this
> scheme when it deems the latter necessary to boost throughput or
> to preserve service guarantees. Unfortunately, when BFQ enforces
> this policy, only one actuator at a time gets served for a while,
> because each bfq_queue contains I/O only for one actuator. The
> other actuators may remain underutilized.
> 
> Actually, BFQ may serve (inject) extra I/O, taken from other
> bfq_queues, in parallel with that of the in-service queue. This
> injection mechanism may provide the ground for dealing also with
> the above actuator-underutilization problem. Yet BFQ does not take
> the actuator load into account when choosing which queue to pick
> extra I/O from. In addition, BFQ may happen to inject extra I/O
> only when the in-service queue is temporarily empty.
> 
> In view of these facts, this commit extends the
> injection mechanism in such a way that the latter:
> (1) takes into account also the actuator load;
> (2) checks such a load on each dispatch, and injects I/O for an
>     underutilized actuator, if there is one and there is I/O for it.
> 
> To perform the check in (2), this commit introduces a load
> threshold, currently set to 4.  A linear scan of each actuator is
> performed, until an actuator is found for which the following two
> conditions hold: the load of the actuator is below the threshold,
> and there is at least one non-in-service queue that contains I/O
> for that actuator. If such a pair (actuator, queue) is found, then
> the head request of that queue is returned for dispatch, instead
> of the head request of the in-service queue.
> 
> We have set the threshold, empirically, to the minimum possible
> value for which an actuator is fully utilized, or close to be
> fully utilized. By doing so, injected I/O 'steals' as few
> drive-queue slots as possibile to the in-service queue. This
> reduces as much as possible the probability that the service of
> I/O from the in-service bfq_queue gets delayed because of slot
> exhaustion, i.e., because all the slots of the drive queue are
> filled with I/O injected from other queues (NCQ provides for 32
> slots).
> 
> This new mechanism also counters actuator underutilization in the
> case of asymmetric configurations of bfq_queues. Namely if there
> are few bfq_queues containing I/O for some actuators and many
> bfq_queues containing I/O for other actuators. Or if the
> bfq_queues containing I/O for some actuators have lower weights
> than the other bfq_queues.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Davide Zini <davidezini2@gmail.com>

A few nits below. Otherwise, looks ok.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/bfq-cgroup.c  |   2 +-
>  block/bfq-iosched.c | 139 +++++++++++++++++++++++++++++++++-----------
>  block/bfq-iosched.h |  39 ++++++++++++-
>  block/bfq-wf2q.c    |   2 +-
>  4 files changed, 143 insertions(+), 39 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index d243c429d9c0..38ccfe55ad46 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -694,7 +694,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		bfq_activate_bfqq(bfqd, bfqq);
>  	}
>  
> -	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
> +	if (!bfqd->in_service_queue && !bfqd->tot_rq_in_driver)
>  		bfq_schedule_dispatch(bfqd);
>  	/* release extra ref taken above, bfqq may happen to be freed now */
>  	bfq_put_queue(bfqq);
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 106c8820cc5c..db91f1a651d3 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2252,6 +2252,7 @@ static void bfq_add_request(struct request *rq)
>  
>  	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
>  	bfqq->queued[rq_is_sync(rq)]++;
> +

whiteline change

>  	/*
>  	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
>  	 * may be read without holding the lock in bfq_has_work().
> @@ -2297,9 +2298,9 @@ static void bfq_add_request(struct request *rq)
>  		 *   elapsed.
>  		 */
>  		if (bfqq == bfqd->in_service_queue &&
> -		    (bfqd->rq_in_driver == 0 ||
> +		    (bfqd->tot_rq_in_driver == 0 ||
>  		     (bfqq->last_serv_time_ns > 0 &&
> -		      bfqd->rqs_injected && bfqd->rq_in_driver > 0)) &&
> +		      bfqd->rqs_injected && bfqd->tot_rq_in_driver > 0)) &&
>  		    time_is_before_eq_jiffies(bfqq->decrease_time_jif +
>  					      msecs_to_jiffies(10))) {
>  			bfqd->last_empty_occupied_ns = ktime_get_ns();
> @@ -2323,7 +2324,7 @@ static void bfq_add_request(struct request *rq)
>  			 * will be set in case injection is performed
>  			 * on bfqq before rq is completed).
>  			 */
> -			if (bfqd->rq_in_driver == 0)
> +			if (bfqd->tot_rq_in_driver == 0)
>  				bfqd->rqs_injected = false;
>  		}
>  	}
> @@ -2421,15 +2422,18 @@ static sector_t get_sdist(sector_t last_pos, struct request *rq)
>  static void bfq_activate_request(struct request_queue *q, struct request *rq)
>  {
>  	struct bfq_data *bfqd = q->elevator->elevator_data;
> +	unsigned int act_idx = bfq_actuator_index(bfqd, rq->bio);
>  
> -	bfqd->rq_in_driver++;
> +	bfqd->tot_rq_in_driver++;
> +	bfqd->rq_in_driver[act_idx]++;
>  }
>  
>  static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
>  {
>  	struct bfq_data *bfqd = q->elevator->elevator_data;
>  
> -	bfqd->rq_in_driver--;
> +	bfqd->tot_rq_in_driver--;
> +	bfqd->rq_in_driver[bfq_actuator_index(bfqd, rq->bio)]--;
>  }
>  #endif
>  
> @@ -2703,11 +2707,14 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
>  static void bfq_end_wr(struct bfq_data *bfqd)
>  {
>  	struct bfq_queue *bfqq;
> +	int i;
>  
>  	spin_lock_irq(&bfqd->lock);
>  
> -	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
> -		bfq_bfqq_end_wr(bfqq);
> +	for (i = 0; i < bfqd->num_actuators; i++) {
> +		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
> +			bfq_bfqq_end_wr(bfqq);
> +	}
>  	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
>  		bfq_bfqq_end_wr(bfqq);
>  	bfq_end_wr_async(bfqd);
> @@ -3651,13 +3658,13 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
>  	 * - start a new observation interval with this dispatch
>  	 */
>  	if (now_ns - bfqd->last_dispatch > 100*NSEC_PER_MSEC &&
> -	    bfqd->rq_in_driver == 0)
> +	    bfqd->tot_rq_in_driver == 0)
>  		goto update_rate_and_reset;
>  
>  	/* Update sampling information */
>  	bfqd->peak_rate_samples++;
>  
> -	if ((bfqd->rq_in_driver > 0 ||
> +	if ((bfqd->tot_rq_in_driver > 0 ||
>  		now_ns - bfqd->last_completion < BFQ_MIN_TT)
>  	    && !BFQ_RQ_SEEKY(bfqd, bfqd->last_position, rq))
>  		bfqd->sequential_samples++;
> @@ -3924,7 +3931,7 @@ static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
>  	return (bfqq->wr_coeff > 1 &&
>  		(bfqd->wr_busy_queues <
>  		 tot_busy_queues ||
> -		 bfqd->rq_in_driver >=
> +		 bfqd->tot_rq_in_driver >=
>  		 bfqq->dispatched + 4)) ||
>  		bfq_asymmetric_scenario(bfqd, bfqq) ||

Nit: with all the line splits, this is really hard to read... Use the full
80 chars available please.

>  		tot_busy_queues == 1;
> @@ -4696,6 +4703,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  {
>  	struct bfq_queue *bfqq, *in_serv_bfqq = bfqd->in_service_queue;
>  	unsigned int limit = in_serv_bfqq->inject_limit;
> +	int i;

Missing blank line after this declaration.

>  	/*
>  	 * If
>  	 * - bfqq is not weight-raised and therefore does not carry
> @@ -4727,7 +4735,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  		)
>  		limit = 1;
>  
> -	if (bfqd->rq_in_driver >= limit)
> +	if (bfqd->tot_rq_in_driver >= limit)
>  		return NULL;
>  
>  	/*
> @@ -4742,11 +4750,12 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  	 *   (and re-added only if it gets new requests, but then it
>  	 *   is assigned again enough budget for its new backlog).
>  	 */
> -	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
> -		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
> -		    (in_serv_always_inject || bfqq->wr_coeff > 1) &&
> -		    bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
> -		    bfq_bfqq_budget_left(bfqq)) {
> +	for (i = 0; i < bfqd->num_actuators; i++) {
> +		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
> +			if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
> +				(in_serv_always_inject || bfqq->wr_coeff > 1) &&
> +				bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
> +				bfq_bfqq_budget_left(bfqq)) {
>  			/*
>  			 * Allow for only one large in-flight request
>  			 * on non-rotational devices, for the
> @@ -4771,22 +4780,69 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  			else
>  				limit = in_serv_bfqq->inject_limit;
>  
> -			if (bfqd->rq_in_driver < limit) {
> +			if (bfqd->tot_rq_in_driver < limit) {
>  				bfqd->rqs_injected = true;
>  				return bfqq;
>  			}
>  		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct bfq_queue *
> +bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
> +						    int idx)

Why the line split ?

> +{
> +	struct bfq_queue *bfqq = NULL;
> +
> +	if (bfqd->in_service_queue &&
> +	    bfqd->in_service_queue->actuator_idx == idx)
> +		return bfqd->in_service_queue;
> +
> +	list_for_each_entry(bfqq, &bfqd->active_list[idx], bfqq_list) {
> +		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
> +			bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
> +				bfq_bfqq_budget_left(bfqq)) {
> +			return bfqq;
> +		}
> +	}
>  
>  	return NULL;
>  }
>  
> +/*
> + * Perform a linear scan of each actuator, until an actuator is found
> + * for which the following two conditions hold: the load of the
> + * actuator is below the threshold (see comments on actuator_load_threshold
> + * for details), and there is a queue that contains I/O for that
> + * actuator. On success, return that queue.
> + */
> +static struct bfq_queue *
> +bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
> +{
> +	int i;
> +
> +	for (i = 0 ; i < bfqd->num_actuators; i++)
> +		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
> +			struct bfq_queue *bfqq =
> +				bfq_find_active_bfqq_for_actuator(bfqd, i);
> +
> +			if (bfqq)
> +				return bfqq;
> +		}

Given that the statement inside the for loop is multi-line, adding curly
brackets would be nice.

> +
> +	return NULL;
> +}
> +
> +
>  /*
>   * Select a queue for service.  If we have a current queue in service,
>   * check whether to continue servicing it, or retrieve and set a new one.
>   */
>  static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
>  {
> -	struct bfq_queue *bfqq;
> +	struct bfq_queue *bfqq, *inject_bfqq;
>  	struct request *next_rq;
>  	enum bfqq_expiration reason = BFQQE_BUDGET_TIMEOUT;
>  
> @@ -4808,6 +4864,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
>  		goto expire;
>  
>  check_queue:
> +	/*
> +	 *  If some actuator is underutilized, but the in-service
> +	 *  queue does not contain I/O for that actuator, then try to
> +	 *  inject I/O for that actuator.
> +	 */
> +	inject_bfqq = bfq_find_bfqq_for_underused_actuator(bfqd);
> +	if (inject_bfqq && inject_bfqq != bfqq)
> +		return inject_bfqq;
> +
>  	/*
>  	 * This loop is rarely executed more than once. Even when it
>  	 * happens, it is much more convenient to re-execute this loop
> @@ -5163,11 +5228,11 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  
>  		/*
>  		 * We exploit the bfq_finish_requeue_request hook to
> -		 * decrement rq_in_driver, but
> +		 * decrement tot_rq_in_driver, but
>  		 * bfq_finish_requeue_request will not be invoked on
>  		 * this request. So, to avoid unbalance, just start
> -		 * this request, without incrementing rq_in_driver. As
> -		 * a negative consequence, rq_in_driver is deceptively
> +		 * this request, without incrementing tot_rq_in_driver. As
> +		 * a negative consequence, tot_rq_in_driver is deceptively
>  		 * lower than it should be while this request is in
>  		 * service. This may cause bfq_schedule_dispatch to be
>  		 * invoked uselessly.
> @@ -5176,7 +5241,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  		 * bfq_finish_requeue_request hook, if defined, is
>  		 * probably invoked also on this request. So, by
>  		 * exploiting this hook, we could 1) increment
> -		 * rq_in_driver here, and 2) decrement it in
> +		 * tot_rq_in_driver here, and 2) decrement it in
>  		 * bfq_finish_requeue_request. Such a solution would
>  		 * let the value of the counter be always accurate,
>  		 * but it would entail using an extra interface
> @@ -5205,7 +5270,7 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	 * Of course, serving one request at a time may cause loss of
>  	 * throughput.
>  	 */
> -	if (bfqd->strict_guarantees && bfqd->rq_in_driver > 0)
> +	if (bfqd->strict_guarantees && bfqd->tot_rq_in_driver > 0)
>  		goto exit;
>  
>  	bfqq = bfq_select_queue(bfqd);
> @@ -5216,7 +5281,8 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  
>  	if (rq) {
>  inc_in_driver_start_rq:
> -		bfqd->rq_in_driver++;
> +		bfqd->rq_in_driver[bfqq->actuator_idx]++;
> +		bfqd->tot_rq_in_driver++;
>  start_rq:
>  		rq->rq_flags |= RQF_STARTED;
>  	}
> @@ -6289,7 +6355,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
>  	struct bfq_queue *bfqq = bfqd->in_service_queue;
>  
>  	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
> -				       bfqd->rq_in_driver);
> +				       bfqd->tot_rq_in_driver);
>  
>  	if (bfqd->hw_tag == 1)
>  		return;
> @@ -6300,7 +6366,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
>  	 * sum is not exact, as it's not taking into account deactivated
>  	 * requests.
>  	 */
> -	if (bfqd->rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
> +	if (bfqd->tot_rq_in_driver + bfqd->queued <= BFQ_HW_QUEUE_THRESHOLD)
>  		return;
>  
>  	/*
> @@ -6311,7 +6377,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
>  	if (bfqq && bfq_bfqq_has_short_ttime(bfqq) &&
>  	    bfqq->dispatched + bfqq->queued[0] + bfqq->queued[1] <
>  	    BFQ_HW_QUEUE_THRESHOLD &&
> -	    bfqd->rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
> +	    bfqd->tot_rq_in_driver < BFQ_HW_QUEUE_THRESHOLD)
>  		return;
>  
>  	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
> @@ -6332,7 +6398,8 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>  
>  	bfq_update_hw_tag(bfqd);
>  
> -	bfqd->rq_in_driver--;
> +	bfqd->rq_in_driver[bfqq->actuator_idx]--;
> +	bfqd->tot_rq_in_driver--;
>  	bfqq->dispatched--;
>  
>  	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
> @@ -6451,7 +6518,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>  					BFQQE_NO_MORE_REQUESTS);
>  	}
>  
> -	if (!bfqd->rq_in_driver)
> +	if (!bfqd->tot_rq_in_driver)
>  		bfq_schedule_dispatch(bfqd);
>  }
>  
> @@ -6582,13 +6649,13 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
>  	 * conditions to do it, or we can lower the last base value
>  	 * computed.
>  	 *
> -	 * NOTE: (bfqd->rq_in_driver == 1) means that there is no I/O
> +	 * NOTE: (bfqd->tot_rq_in_driver == 1) means that there is no I/O
>  	 * request in flight, because this function is in the code
>  	 * path that handles the completion of a request of bfqq, and,
>  	 * in particular, this function is executed before
> -	 * bfqd->rq_in_driver is decremented in such a code path.
> +	 * bfqd->tot_rq_in_driver is decremented in such a code path.
>  	 */
> -	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
> +	if ((bfqq->last_serv_time_ns == 0 && bfqd->tot_rq_in_driver == 1) ||
>  	    tot_time_ns < bfqq->last_serv_time_ns) {
>  		if (bfqq->last_serv_time_ns == 0) {
>  			/*
> @@ -6598,7 +6665,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
>  			bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
>  		}
>  		bfqq->last_serv_time_ns = tot_time_ns;
> -	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
> +	} else if (!bfqd->rqs_injected && bfqd->tot_rq_in_driver == 1)
>  		/*
>  		 * No I/O injected and no request still in service in
>  		 * the drive: these are the exact conditions for
> @@ -7239,7 +7306,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  	bfqd->queue_weights_tree = RB_ROOT_CACHED;
>  	bfqd->num_groups_with_pending_reqs = 0;
>  
> -	INIT_LIST_HEAD(&bfqd->active_list);
> +	INIT_LIST_HEAD(&bfqd->active_list[0]);
> +	INIT_LIST_HEAD(&bfqd->active_list[1]);
>  	INIT_LIST_HEAD(&bfqd->idle_list);
>  	INIT_HLIST_HEAD(&bfqd->burst_list);
>  
> @@ -7284,6 +7352,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  		ref_wr_duration[blk_queue_nonrot(bfqd->queue)];
>  	bfqd->peak_rate = ref_rate[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
>  
> +	/* see comments on the definition of next field inside bfq_data */
> +	bfqd->actuator_load_threshold = 4;
> +
>  	spin_lock_init(&bfqd->lock);
>  
>  	/*
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 90130a893c8f..adb3ba6a9d90 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -586,7 +586,12 @@ struct bfq_data {
>  	/* number of queued requests */
>  	int queued;
>  	/* number of requests dispatched and waiting for completion */
> -	int rq_in_driver;
> +	int tot_rq_in_driver;
> +	/*
> +	 * number of requests dispatched and waiting for completion
> +	 * for each actuator
> +	 */
> +	int rq_in_driver[BFQ_MAX_ACTUATORS];
>  
>  	/* true if the device is non rotational and performs queueing */
>  	bool nonrot_with_queueing;
> @@ -680,8 +685,13 @@ struct bfq_data {
>  	/* maximum budget allotted to a bfq_queue before rescheduling */
>  	int bfq_max_budget;
>  
> -	/* list of all the bfq_queues active on the device */
> -	struct list_head active_list;
> +	/*
> +	 * List of all the bfq_queues active for a specific actuator
> +	 * on the device. Keeping active queues separate on a
> +	 * per-actuator basis helps implementing per-actuator
> +	 * injection more efficiently.
> +	 */
> +	struct list_head active_list[BFQ_MAX_ACTUATORS];
>  	/* list of all the bfq_queues idle on the device */
>  	struct list_head idle_list;
>  
> @@ -816,6 +826,29 @@ struct bfq_data {
>  	 * in this device.
>  	 */
>  	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
> +
> +	/*
> +	 * If the number of I/O requests queued in the device for a
> +	 * given actuator is below next threshold, then the actuator
> +	 * is deemed as underutilized. If this condition is found to
> +	 * hold for some actuator upon a dispatch, but (i) the
> +	 * in-service queue does not contain I/O for that actuator,
> +	 * while (ii) some other queue does contain I/O for that
> +	 * actuator, then the head I/O request of the latter queue is
> +	 * returned (injected), instead of the head request of the
> +	 * currently in-service queue.
> +	 *
> +	 * We set the threshold, empirically, to the minimum possible
> +	 * value for which an actuator is fully utilized, or close to
> +	 * be fully utilized. By doing so, injected I/O 'steals' as
> +	 * few drive-queue slots as possibile to the in-service
> +	 * queue. This reduces as much as possible the probability
> +	 * that the service of I/O from the in-service bfq_queue gets
> +	 * delayed because of slot exhaustion, i.e., because all the
> +	 * slots of the drive queue are filled with I/O injected from
> +	 * other queues (NCQ provides for 32 slots).
> +	 */
> +	unsigned int actuator_load_threshold;
>  };
>  
>  enum bfqq_state_flags {
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 8fc3da4c23bb..ec0273e2cd07 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -477,7 +477,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
>  	bfqd = (struct bfq_data *)bfqg->bfqd;
>  #endif
>  	if (bfqq)
> -		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
> +		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list[bfqq->actuator_idx]);
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>  	if (bfqg != bfqd->root_group)
>  		bfqg->active_entities++;

-- 
Damien Le Moal
Western Digital Research

