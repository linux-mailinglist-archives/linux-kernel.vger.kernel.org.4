Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9B6317CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKUAjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:39:40 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC813E9F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668991178; x=1700527178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xg7E4EpsLBR2i9ZgI4ocV4i9YQ9Z/cTktGJvtNKPaOw=;
  b=ijuOUs0N1tlrSOK6ZgJ6CwJElLJUt8HvNDevlEXAKZlMNgV+SQFy61MJ
   CPPiZauiKTA6ZJtE0btCsj4+SExcU5gZOZ7ajjgBfmZIxZmVmota+d55A
   Y3FN6nbR6YFXX5q2PIFlC/nsqu4wIJtDZ2gwB3j5BxicNhTitmYqP5AAs
   n767jSkJ8MLURSaXA1m8pz/vbrDRQEClB/Slt+Rzw5BlN8f4usarELfL4
   BSfytXpD1vK/vh/xb0ExQQnyoAtR1KlUhII/KaBlUFRrbycrUooHgeGea
   AnsGAMMwP/BUbHfWKyVgsyuCRedzipCEEeJA7FdrGiBxQH6J3JmYyI43m
   w==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="216739061"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 08:39:37 +0800
IronPort-SDR: 4MDmF0B51F03/8pXGHMqaLMLkpr0lbHKzILlcIXR/1E5fMO17cDu1Ns0Lb9wbRn7TxgpMLA5c7
 yNOPQFU6JipjG+CPc7JeEGf//m4hnPTu9hsBA20ZjtgvngKBJw5zF0dPp6Jk/8v8sLz5/JsK43
 kZ8OvFV9bqHH1Kil40OlKPUkcFMnNmJ7EJLDFiml70BB3hGLQTy4cS6ZyVAlyriQnU04iqfbyy
 6rbZ6SoZni41QJccIEvxpFY9cs1lUy/rDt9uTd+ey/1nAZw/JZ674RXRtgO0dsVWVFpjy785vm
 2Xo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 15:52:43 -0800
IronPort-SDR: Uo+9HNvLcPsD/Xd5W5GlkVTcezk+6xVzkdaV1Ks0D3aZrZRgEaphiiDmvFGdv6e2hkRx8hEUm1
 96jGd+rme9yJVDYRvFS1U6IVO8HNb9p3D3P+LQ38i5EMlCNYq8+vCvPEm3CIwSRCkQOL0CwNSW
 T7t/4IAHANaeEg5mDRJ/EiSN2oa7dJUuGGnnNmJBF9AZV71J+0LeTImFCeClLDCuDMUV5LBrG/
 TZErHEOTuxhnFjLQI2/Gq3A4FGgexrdemxexau+2T1oJKQhQYPxG4gI3Gj12hDbwZCC/+zm2mI
 veU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:39:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFpS824Crz1RwtC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:39:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668991174; x=1671583175; bh=xg7E4EpsLBR2i9ZgI4ocV4i9YQ9Z/cTktGJ
        vtNKPaOw=; b=gB3okPjkYc03sTL0HGmIdLZvXYE8q+t6GzcE4XIg/Y6HOxaqg/y
        2YlUVG0LnmJLGjqSggHg5w029V0kRRj2APo0xL3aLY9PABI5h1sVfa4PhfsG6sYQ
        9NMB9bb2MH46+9x/eFdddtiVydLi97UL3Z65HisEIvfPgaJc2Y+mCfAMuVD8+jud
        7xQqFgdJyR7COjWhfyFVS6QYAbCo6XjitN1UL8MqJPsXwXxjFP1xrvNFfdAasEiP
        0wDh1T4pFzeKOkF+w9DCMqonaBShZYCIEIYZyTazKZSAMLBPZcbahIKJVv/ZecA3
        2qA8GPcLuzZUXHXDIGLAc3YSf1MXvHlMx3A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e73YKDL3ZEkX for <linux-kernel@vger.kernel.org>;
        Sun, 20 Nov 2022 16:39:34 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFpS40yg2z1RvLy;
        Sun, 20 Nov 2022 16:39:31 -0800 (PST)
Message-ID: <3ec70cff-f1bc-1a45-a4db-10bb1d0e6266@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 09:39:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 4/8] block, bfq: turn bfqq_data into an array in
 bfq_io_cq
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-5-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-5-paolo.valente@linaro.org>
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
> When a bfq_queue Q is merged with another queue, several pieces of
> information are saved about Q. These pieces are stored in the
> bfqq_data field in the bfq_io_cq data structure of the process
> associated with Q.
> 
> Yet, with a multi-actuator drive, a process may get associated with
> multiple bfq_queues: one queue for each of the N actuators. Each of
> these queues may undergo a merge. So, the bfq_io_cq data structure
> must be able to accommodate the above information for N queues.
> 
> This commit solves this problem by turning the bfqq_data scalar field
> into an array of N elements (and by changing code so as to handle
> this array).
> 
> This solution is written under the assumption that bfq_queues
> associated with different actuators cannot be cross-merged. This
> assumption holds naturally with basic queue merging: the latter is
> triggered by spatial locality, and sectors for different actuators are
> not close to each other. As for stable cross-merging, the assumption

The last sector served by actuator N is very close to the first sector
served by actuator N+1 :)

So I am not sure this argument is valid. Better explanation required here
I think.

> here is that it is disabled.
> 
> Signed-off-by: Gabriele Felici <felicigb@gmail.com>
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
> Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 72 ++++++++++++++++++++++++---------------------
>  block/bfq-iosched.h | 12 +++++---
>  2 files changed, 47 insertions(+), 37 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 01528182c0c5..f44bac054aaf 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -404,7 +404,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  	 * we cancel the stable merge if
>  	 * bic->stable_merge_bfqq == bfqq.
>  	 */
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[actuator_idx];
>  	bic->bfqq[is_sync][actuator_idx] = bfqq;
>  
>  	if (bfqq && bfqq_data->stable_merge_bfqq == bfqq) {
> @@ -1175,9 +1175,10 @@ static void
>  bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>  		      struct bfq_io_cq *bic, bool bfq_already_existing)
>  {
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  	unsigned int old_wr_coeff = 1;
>  	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
> +	unsigned int a_idx = bfqq->actuator_idx;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
>  
>  	if (bfqq_data->saved_has_short_ttime)
>  		bfq_mark_bfqq_has_short_ttime(bfqq);
> @@ -1827,6 +1828,16 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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

??? This was added in patch 1. Why again here ?

> +
>  static bool bfq_better_to_idle(struct bfq_queue *bfqq);
>  
>  static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
> @@ -1881,7 +1892,9 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	wr_or_deserves_wr = bfqd->low_latency &&
>  		(bfqq->wr_coeff > 1 ||
>  		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
> +		  (bfqq->bic ||
> +		   RQ_BIC(rq)->bfqq_data[bfq_actuator_index(bfqd, rq->bio)]
> +		   .stably_merged) &&
>  		   (*interactive || soft_rt)));
>  
>  	/*
> @@ -2469,16 +2482,6 @@ static void bfq_remove_request(struct request_queue *q,
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

ah. You moved it... May be add it in the right place in patch 1 then to
avoid that ? That may be due to some git/diff artifacts though.

>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -2905,7 +2908,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		     void *io_struct, bool request, struct bfq_io_cq *bic)
>  {
>  	struct bfq_queue *in_service_bfqq, *new_bfqq;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
> +	unsigned int a_idx = bfqq->actuator_idx;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
>  
>  	/* if a merge has already been setup, then proceed with that first */
>  	if (bfqq->new_bfqq)
> @@ -2952,8 +2956,9 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  				if (new_bfqq) {
>  					bfqq_data->stably_merged = true;
>  					if (new_bfqq->bic)
> -						new_bfqq->bic->bfqq_data.stably_merged =
> -							true;
> +						new_bfqq->bic->bfqq_data
> +							[new_bfqq->actuator_idx]
> +							.stably_merged = true;

Aouch. This is really hard to read as that is really not supposed to be
split like this.

>  				}
>  				return new_bfqq;
>  			} else
> @@ -3052,7 +3057,9 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
> +	/* State must be saved for the right queue index. */

Drop this comment. It serves no purpose in my opinion.

> +	unsigned int a_idx = bfqq->actuator_idx;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
>  
>  	/*
>  	 * If !bfqq->bic, the queue is already shared or its requests
> @@ -3063,7 +3070,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  		return;
>  
>  	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> -	bfqq_data->saved_inject_limit = bfqq->inject_limit;
> +	bfqq_data->saved_inject_limit =	bfqq->inject_limit;
>  	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
>  
>  	bfqq_data->saved_weight = bfqq->entity.orig_weight;
> @@ -5425,7 +5432,7 @@ static void bfq_exit_icq(struct io_cq *icq)
>  	unsigned long flags;
>  	unsigned int act_idx;
>  	unsigned int num_actuators;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
> +	struct bfq_iocq_bfqq_data *bfqq_data = bic->bfqq_data;
>  
>  	/*
>  	 * bfqd is NULL if scheduler already exited, and in that case
> @@ -5445,10 +5452,10 @@ static void bfq_exit_icq(struct io_cq *icq)
>  		num_actuators = BFQ_MAX_ACTUATORS;
>  	}
>  
> -	if (bfqq_data->stable_merge_bfqq)
> -		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
> -
>  	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
> +		if (bfqq_data[act_idx].stable_merge_bfqq)
> +			bfq_put_stable_ref(bfqq_data[act_idx].stable_merge_bfqq);
> +
>  		bfq_exit_icq_bfqq(bic, true, act_idx);
>  		bfq_exit_icq_bfqq(bic, false, act_idx);
>  	}
> @@ -5635,16 +5642,16 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  			  struct bfq_io_cq *bic,
>  			  struct bfq_queue *last_bfqq_created)
>  {
> +	unsigned int a_idx = last_bfqq_created->actuator_idx;
>  	struct bfq_queue *new_bfqq =
>  		bfq_setup_merge(bfqq, last_bfqq_created);
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	if (!new_bfqq)
>  		return bfqq;
>  
>  	if (new_bfqq->bic)
> -		new_bfqq->bic->bfqq_data.stably_merged = true;
> -	bfqq_data->stably_merged = true;
> +		new_bfqq->bic->bfqq_data[a_idx].stably_merged = true;
> +	bic->bfqq_data[a_idx].stably_merged = true;
>  
>  	/*
>  	 * Reusing merge functions. This implies that
> @@ -5713,7 +5720,6 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  		&bfqd->last_bfqq_created;
>  
>  	struct bfq_queue *last_bfqq_created = *source_bfqq;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	/*
>  	 * If last_bfqq_created has not been set yet, then init it. If
> @@ -5775,7 +5781,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  			/*
>  			 * Record the bfqq to merge to.
>  			 */
> -			bfqq_data->stable_merge_bfqq = last_bfqq_created;
> +			bic->bfqq_data[last_bfqq_created->actuator_idx].stable_merge_bfqq =
> +				last_bfqq_created;
>  		}
>  	}
>  
> @@ -6696,7 +6703,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  {
>  	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
>  	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[act_idx];
>  
>  	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
>  		return bfqq;
> @@ -6804,7 +6811,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	struct bfq_queue *bfqq;
>  	bool new_queue = false;
>  	bool bfqq_already_existing = false, split = false;
> -	struct bfq_iocq_bfqq_data *bfqq_data;
> +	unsigned int a_idx = bfq_actuator_index(bfqd, bio);
>  
>  	if (unlikely(!rq->elv.icq))
>  		return NULL;
> @@ -6828,17 +6835,16 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
>  					 &new_queue);
>  
> -	bfqq_data = &bic->bfqq_data;
> -
>  	if (likely(!new_queue)) {
>  		/* If the queue was seeky for too long, break it apart. */
>  		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
> -			!bfqq_data->stably_merged) {
> +			!bic->bfqq_data[a_idx].stably_merged) {
>  			struct bfq_queue *old_bfqq = bfqq;
>  
>  			/* Update bic before losing reference to bfqq */
>  			if (bfq_bfqq_in_large_burst(bfqq))
> -				bfqq_data->saved_in_large_burst = true;
> +				bic->bfqq_data[a_idx].saved_in_large_burst =
> +					true;
>  
>  			bfqq = bfq_split_bfqq(bic, bfqq);
>  			split = true;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index f2e8ab91951c..e27897d66a0f 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -416,7 +416,7 @@ struct bfq_queue {
>  struct bfq_iocq_bfqq_data {
>  	/*
>  	 * Snapshot of the has_short_time flag before merging; taken
> -	 * to remember its value while the queue is merged, so as to
> +	 * to remember its values while the queue is merged, so as to
>  	 * be able to restore it in case of split.
>  	 */
>  	bool saved_has_short_ttime;
> @@ -430,7 +430,7 @@ struct bfq_iocq_bfqq_data {
>  	u64 saved_tot_idle_time;
>  
>  	/*
> -	 * Same purpose as the previous fields for the value of the
> +	 * Same purpose as the previous fields for the values of the
>  	 * field keeping the queue's belonging to a large burst
>  	 */
>  	bool saved_in_large_burst;
> @@ -493,8 +493,12 @@ struct bfq_io_cq {
>  	uint64_t blkcg_serial_nr; /* the current blkcg serial */
>  #endif
>  
> -	/* persistent data for associated synchronous process queue */
> -	struct bfq_iocq_bfqq_data bfqq_data;
> +	/*
> +	 * Persistent data for associated synchronous process queues
> +	 * (one queue per actuator, see field bfqq above). In
> +	 * particular, each of these queues may undergo a merge.
> +	 */
> +	struct bfq_iocq_bfqq_data bfqq_data[BFQ_MAX_ACTUATORS];

I wonder if packing this together with struct bfq_queue would be cleaner.
That would avoid the 2 arrays you have in this struct. Something like this:

struct bfq_queue_data {
	struct bfq_queue 	*bfqq[2];
	struct bfq_iocq_bfqq_data iocq_data;
}

struct bfq_io_cq {
	...
	struct bfq_queue_data bfqqd[BFQ_MAX_ACTUATORS];
	...
}

Thinking aloud here. That may actually make the code more complicated.

>  
>  	unsigned int requests;	/* Number of requests this process has in flight */
>  };

-- 
Damien Le Moal
Western Digital Research

