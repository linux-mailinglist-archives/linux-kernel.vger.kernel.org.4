Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91563177F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKUASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUASl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:18:41 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A61EEF6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668989919; x=1700525919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W2j9m/mXigfhsSdrIEEMzApqq4QozL53Xop1CKkJQ4U=;
  b=IZV/VSwKBb+TktJt31elzp1PnR9/nTFHlZjzf1ahzLyxqKsysKyjnzZh
   bFJsO2i96B0eA+RXB7KUAIYFUlAv6zg9kmRA8rhs4E4lAZCcAosupjG/N
   9tY1rkHaFcALhsgmuzsedc8RXH1s09QuMjIcTtA26jTi6Tc2H9/csAUTc
   DGRfJWT/9lq/tKwA18AukGBlj1NpqvfsrEOdYDeeAtCsOsjfog9VELqWP
   FaYUrm99mFvK1MngufMVzdFJClLJgGX8bMnkybGx5iVRyojI1k8Lh/pFy
   0JgqZBUNyathtb1c6PeOLKVo6nlIWd47m1TBq5422eULH0Qm2Gq0F16ch
   A==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="217050075"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 08:18:38 +0800
IronPort-SDR: 4xnoLlVThUH4/Da5Wfu3GABz/2PdgksZ4zxcrEXEm9+4UnL0LizzwrAGW5tPeokK8HQ3JqkoLn
 a2SbwwaG+eHQ5Sr0Vl3qKu78VsWQQuOk3Zn+gLUMboV1YLv7O7G+UVqohhkVQz2dfRXMKY6uPR
 KKEbxgFoLhEBxkZQ/POqKAD+QVhTh7XblwTHKhvFA2URAlziiXokcn379fwlqX3MNwa5IfwdWG
 BIVorXDuz6//hbdfELNwMAfhQo1FM+MCUmwoYBmIl74h2lFzhHnUHxYYPPGtnMqE9SzltGpC5B
 ud8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 15:37:28 -0800
IronPort-SDR: oFN012oJQVa8mdlzZW8oLZdhxbyYkJ+mAaDWEloOX35cSGaR995+qifWDtgkKZpDJXCNP8kgIQ
 oIbSYghY5NBzRTqwoiWcNSZ5HuzjfQ6kxWsyvaH6scXM4wRMp7zzVkQQNxpkHXHUK4m6XEIqUj
 ExMtAMVSb0YgpYySukUlE90HYEqgIZKKuKVBXtSlcyfWqsVcPwFeJ+byU985Ta7Dxro70VEEi0
 iiRvPqT+szfkijIGXlRCmxhJUyPB8VCDtxNCU6kxfRvBPQyigwac32Hh1zqUZr5HJclOm51LLf
 +Es=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:18:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFnzx1D9tz1Rwtl
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:18:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668989913; x=1671581914; bh=W2j9m/mXigfhsSdrIEEMzApqq4QozL53Xop
        1CKkJQ4U=; b=Jm4vokqDxOuvjCj9jhk8snifAW372LIxq9FO+LuID7aJd0O/und
        tFrTfcPBQ93LVsXlv0eqh7kD4vEN8WvPYzGFNC7Hxevvnv+Sh4CYVnna8f8X586U
        m//64nsZbMzz4JVnQLw2Lt3ENCQi5JMXEi04GSXmORVtzDVOu+RumoM7nIfLNx/w
        6M0lg2Jmmb5JsAFiC8N7ZEOwET0kWz/ljryYJgqNu0g8PsWB56TAAHYkavY24aA+
        hCPm3G5h+7hSZjsCuZR/ydh2p7DeKC1Rx3R/i2//DzG5cX6UdyjZnHlpiZ0XQPKE
        qPovkPq4X88UDAc+yBS7Sew5CSU1CUFLJIw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6UWSJ0ZWA3rk for <linux-kernel@vger.kernel.org>;
        Sun, 20 Nov 2022 16:18:33 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFnzq3dmSz1RvLy;
        Sun, 20 Nov 2022 16:18:31 -0800 (PST)
Message-ID: <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 09:18:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-2-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 01:26, Paolo Valente wrote:
> Single-LUN multi-actuator SCSI drives, as well as all multi-actuator
> SATA drives appear as a single device to the I/O subsystem [1].  Yet
> they address commands to different actuators internally, as a function
> of Logical Block Addressing (LBAs). A given sector is reachable by
> only one of the actuators. For example, Seagate=E2=80=99s Serial Advanc=
ed
> Technology Attachment (SATA) version contains two actuators and maps
> the lower half of the SATA LBA space to the lower actuator and the
> upper half to the upper actuator.
>=20
> Evidently, to fully utilize actuators, no actuator must be left idle
> or underutilized while there is pending I/O for it. The block layer
> must somehow control the load of each actuator individually. This
> commit lays the ground for allowing BFQ to provide such a per-actuator
> control.
>=20
> BFQ associates an I/O-request sync bfq_queue with each process doing
> synchronous I/O, or with a group of processes, in case of queue
> merging. Then BFQ serves one bfq_queue at a time. While in service, a
> bfq_queue is emptied in request-position order. Yet the same process,
> or group of processes, may generate I/O for different actuators. In
> this case, different streams of I/O (each for a different actuator)
> get all inserted into the same sync bfq_queue. So there is basically
> no individual control on when each stream is served, i.e., on when the
> I/O requests of the stream are picked from the bfq_queue and
> dispatched to the drive.
>=20
> This commit enables BFQ to control the service of each actuator
> individually for synchronous I/O, by simply splitting each sync
> bfq_queue into N queues, one for each actuator. In other words, a sync
> bfq_queue is now associated to a pair (process, actuator). As a
> consequence of this split, the per-queue proportional-share policy
> implemented by BFQ will guarantee that the sync I/O generated for each
> actuator, by each process, receives its fair share of service.
>=20
> This is just a preparatory patch. If the I/O of the same process
> happens to be sent to different queues, then each of these queues may
> undergo queue merging. To handle this event, the bfq_io_cq data
> structure must be properly extended. In addition, stable merging must
> be disabled to avoid loss of control on individual actuators. Finally,
> also async queues must be split. These issues are described in detail
> and addressed in next commits. As for this commit, although multiple
> per-process bfq_queues are provided, the I/O of each process or group
> of processes is still sent to only one queue, regardless of the
> actuator the I/O is for. The forwarding to distinct bfq_queues will be
> enabled after addressing the above issues.
>=20
> [1] https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-sched=
uler-optimizations-for-multi-actuator-sata-hard-drives/
>=20
> Signed-off-by: Gabriele Felici <felicigb@gmail.com>
> Signed-off-by: Carmine Zaccagnino <carmine@carminezacc.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-cgroup.c  |  95 ++++++++++++++++------------
>  block/bfq-iosched.c | 151 +++++++++++++++++++++++++++++---------------
>  block/bfq-iosched.h |  51 ++++++++++++---
>  3 files changed, 194 insertions(+), 103 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 144bca006463..d243c429d9c0 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -700,6 +700,48 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct b=
fq_queue *bfqq,
>  	bfq_put_queue(bfqq);
>  }
> =20
> +static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
> +			       struct bfq_queue *sync_bfqq,
> +			       struct bfq_io_cq *bic,
> +			       struct bfq_group *bfqg,
> +			       unsigned int act_idx)
> +{
> +	if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
> +		/* We are the only user of this bfqq, just move it */
> +		if (sync_bfqq->entity.sched_data !=3D &bfqg->sched_data)
> +			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);

Nit: add a return here to avoid the "else" and save one tab indent level
for the code below. That will be more pleasant to the eyes :)

> +	} else {
> +		struct bfq_queue *bfqq;
> +
> +		/*
> +		 * The queue was merged to a different queue. Check
> +		 * that the merge chain still belongs to the same
> +		 * cgroup.
> +		 */
> +		for (bfqq =3D sync_bfqq; bfqq; bfqq =3D bfqq->new_bfqq)
> +			if (bfqq->entity.sched_data !=3D
> +			    &bfqg->sched_data)
> +				break;
> +		if (bfqq) {
> +			/*
> +			 * Some queue changed cgroup so the merge is
> +			 * not valid anymore. We cannot easily just
> +			 * cancel the merge (by clearing new_bfqq) as
> +			 * there may be other processes using this
> +			 * queue and holding refs to all queues below
> +			 * sync_bfqq->new_bfqq. Similarly if the merge
> +			 * already happened, we need to detach from
> +			 * bfqq now so that we cannot merge bio to a
> +			 * request from the old cgroup.
> +			 */
> +			bfq_put_cooperator(sync_bfqq);
> +			bfq_release_process_ref(bfqd, sync_bfqq);
> +			bic_set_bfqq(bic, NULL, 1, act_idx);
> +		}
> +	}
> +}
> +
> +

Double blank line.

>  /**
>   * __bfq_bic_change_cgroup - move @bic to @bfqg.
>   * @bfqd: the queue descriptor.
> @@ -714,53 +756,24 @@ static void *__bfq_bic_change_cgroup(struct bfq_d=
ata *bfqd,
>  				     struct bfq_io_cq *bic,
>  				     struct bfq_group *bfqg)
>  {
> -	struct bfq_queue *async_bfqq =3D bic_to_bfqq(bic, 0);
> -	struct bfq_queue *sync_bfqq =3D bic_to_bfqq(bic, 1);
>  	struct bfq_entity *entity;
> +	unsigned int act_idx;
> =20
> -	if (async_bfqq) {
> -		entity =3D &async_bfqq->entity;
> -
> -		if (entity->sched_data !=3D &bfqg->sched_data) {
> -			bic_set_bfqq(bic, NULL, 0);
> -			bfq_release_process_ref(bfqd, async_bfqq);
> -		}
> -	}
> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
> +		struct bfq_queue *async_bfqq =3D bic_to_bfqq(bic, 0, act_idx);
> +		struct bfq_queue *sync_bfqq =3D bic_to_bfqq(bic, 1, act_idx);

The second argument of bic_to_bfqq() is a bool. So it would make more
sense to use false/true instead of 0/1. That said, creating 2 helpers
bic_to_async_bfqq() and bic_to_sync_bfqq() without that second argument
would make the code more readable and less error prone I think.

> =20
> -	if (sync_bfqq) {
> -		if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
> -			/* We are the only user of this bfqq, just move it */
> -			if (sync_bfqq->entity.sched_data !=3D &bfqg->sched_data)
> -				bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
> -		} else {
> -			struct bfq_queue *bfqq;
> +		if (async_bfqq) {
> +			entity =3D &async_bfqq->entity;
> =20
> -			/*
> -			 * The queue was merged to a different queue. Check
> -			 * that the merge chain still belongs to the same
> -			 * cgroup.
> -			 */
> -			for (bfqq =3D sync_bfqq; bfqq; bfqq =3D bfqq->new_bfqq)
> -				if (bfqq->entity.sched_data !=3D
> -				    &bfqg->sched_data)
> -					break;
> -			if (bfqq) {
> -				/*
> -				 * Some queue changed cgroup so the merge is
> -				 * not valid anymore. We cannot easily just
> -				 * cancel the merge (by clearing new_bfqq) as
> -				 * there may be other processes using this
> -				 * queue and holding refs to all queues below
> -				 * sync_bfqq->new_bfqq. Similarly if the merge
> -				 * already happened, we need to detach from
> -				 * bfqq now so that we cannot merge bio to a
> -				 * request from the old cgroup.
> -				 */
> -				bfq_put_cooperator(sync_bfqq);
> -				bfq_release_process_ref(bfqd, sync_bfqq);
> -				bic_set_bfqq(bic, NULL, 1);
> +			if (entity->sched_data !=3D &bfqg->sched_data) {

You are referencing the entity variable once here only. So is it really
needed ?

> +				bic_set_bfqq(bic, NULL, 0, act_idx);
> +				bfq_release_process_ref(bfqd, async_bfqq);
>  			}
>  		}
> +
> +		if (sync_bfqq)
> +			bfq_sync_bfqq_move(bfqd, sync_bfqq, bic, bfqg, act_idx);
>  	}
> =20
>  	return bfqg;
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7ea427817f7f..5c69394bbb65 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -377,14 +377,19 @@ static const unsigned long bfq_late_stable_mergin=
g =3D 600;
>  #define RQ_BIC(rq)		((struct bfq_io_cq *)((rq)->elv.priv[0]))
>  #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
> =20
> -struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
> +struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic,
> +			      bool is_sync,
> +			      unsigned int actuator_idx)

Why the line split for the last argument ?

>  {
> -	return bic->bfqq[is_sync];
> +	return bic->bfqq[is_sync][actuator_idx];

See comment above. This is really broken I think. You should not use a
bool as an array index. Write it as:

	if (is_sync)
		return bic->bfqq[1][actuator_idx];
	return bic->bfqq[0][actuator_idx];

Or as suggested, create 2 helpers.

>  }
> =20
>  static void bfq_put_stable_ref(struct bfq_queue *bfqq);
> =20
> -void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool =
is_sync)
> +void bic_set_bfqq(struct bfq_io_cq *bic,
> +		  struct bfq_queue *bfqq,
> +		  bool is_sync,
> +		  unsigned int actuator_idx)
>  {
>  	/*
>  	 * If bfqq !=3D NULL, then a non-stable queue merge between
> @@ -399,7 +404,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq=
_queue *bfqq, bool is_sync)
>  	 * we cancel the stable merge if
>  	 * bic->stable_merge_bfqq =3D=3D bfqq.
>  	 */
> -	bic->bfqq[is_sync] =3D bfqq;
> +	bic->bfqq[is_sync][actuator_idx] =3D bfqq;

Same comment as above. Using a bool as an index array feels very wrong to
me. This seems very fragile/dependent on waht the compiler does with bool
type.

> =20
>  	if (bfqq && bic->stable_merge_bfqq =3D=3D bfqq) {
>  		/*
> @@ -672,9 +677,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct b=
lk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
>  	struct bfq_io_cq *bic =3D bfq_bic_lookup(data->q);
> -	struct bfq_queue *bfqq =3D bic ? bic_to_bfqq(bic, op_is_sync(opf)) : =
NULL;

Given that you are repeating this same pattern many times, the test for
bic !=3D NULL should go into the bic_to_bfqq() helper.

>  	int depth;
>  	unsigned limit =3D data->q->nr_requests;
> +	unsigned int act_idx;
> =20
>  	/* Sync reads have full depth available */
>  	if (op_is_sync(opf) && !op_is_write(opf)) {
> @@ -684,14 +689,21 @@ static void bfq_limit_depth(blk_opf_t opf, struct=
 blk_mq_alloc_data *data)
>  		limit =3D (limit * depth) >> bfqd->full_depth_shift;
>  	}
> =20
> -	/*
> -	 * Does queue (or any parent entity) exceed number of requests that
> -	 * should be available to it? Heavily limit depth so that it cannot
> -	 * consume more available requests and thus starve other entities.
> -	 */
> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
> -		depth =3D 1;
> +	for (act_idx =3D 0; act_idx < bfqd->num_actuators; act_idx++) {
> +		struct bfq_queue *bfqq =3D
> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
> =20
> +		/*
> +		 * Does queue (or any parent entity) exceed number of
> +		 * requests that should be available to it? Heavily
> +		 * limit depth so that it cannot consume more
> +		 * available requests and thus starve other entities.
> +		 */
> +		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
> +			depth =3D 1;
> +			break;
> +		}
> +	}
>  	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
>  		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
>  	if (depth)
> @@ -2142,7 +2154,7 @@ static void bfq_check_waker(struct bfq_data *bfqd=
, struct bfq_queue *bfqq,
>  	 * We reset waker detection logic also if too much time has passed
>   	 * since the first detection. If wakeups are rare, pointless idling
>  	 * doesn't hurt throughput that much. The condition below makes sure
> -	 * we do not uselessly idle blocking waker in more than 1/64 cases.=20
> +	 * we do not uselessly idle blocking waker in more than 1/64 cases.
>  	 */
>  	if (bfqd->last_completed_rq_bfqq !=3D
>  	    bfqq->tentative_waker_bfqq ||
> @@ -2454,6 +2466,16 @@ static void bfq_remove_request(struct request_qu=
eue *q,
> =20
>  }
> =20
> +/* get the index of the actuator that will serve bio */

Generally, function comments use the multi-line comment style...

/*
 * Get the index of the actuator that will serve @bio.
 */

> +static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct b=
io *bio)
> +{
> +	/*
> +	 * Multi-actuator support not complete yet, so always return 0
> +	 * for the moment.
> +	 */

Nit: You did comment about this in the commit message. So I do not think
having this comment here helps.

Note that you could have a prep patch before this patch that gather the
actuator information for the device, and only does that. So this function
here could actually have meat instead of being empty. But that may make
the entire series more complicated, so not a big deal.

> +	return 0;
> +}
> +
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -2478,7 +2500,8 @@ static bool bfq_bio_merge(struct request_queue *q=
, struct bio *bio,
>  		 */
>  		bfq_bic_update_cgroup(bic, bio);
> =20
> -		bfqd->bio_bfqq =3D bic_to_bfqq(bic, op_is_sync(bio->bi_opf));
> +		bfqd->bio_bfqq =3D bic_to_bfqq(bic, op_is_sync(bio->bi_opf),
> +					     bfq_actuator_index(bfqd, bio));
>  	} else {
>  		bfqd->bio_bfqq =3D NULL;
>  	}
> @@ -3174,7 +3197,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq=
_io_cq *bic,
>  	/*
>  	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
>  	 */
> -	bic_set_bfqq(bic, new_bfqq, 1);
> +	bic_set_bfqq(bic, new_bfqq, 1, bfqq->actuator_idx);
>  	bfq_mark_bfqq_coop(new_bfqq);
>  	/*
>  	 * new_bfqq now belongs to at least two bics (it is a shared queue):
> @@ -4808,11 +4831,12 @@ static struct bfq_queue *bfq_select_queue(struc=
t bfq_data *bfqd)
>  	 */
>  	if (bfq_bfqq_wait_request(bfqq) ||
>  	    (bfqq->dispatched !=3D 0 && bfq_better_to_idle(bfqq))) {
> +		unsigned int act_idx =3D bfqq->actuator_idx;
>  		struct bfq_queue *async_bfqq =3D
> -			bfqq->bic && bfqq->bic->bfqq[0] &&
> -			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
> -			bfqq->bic->bfqq[0]->next_rq ?
> -			bfqq->bic->bfqq[0] : NULL;
> +			bfqq->bic && bfqq->bic->bfqq[0][act_idx] &&
> +			bfq_bfqq_busy(bfqq->bic->bfqq[0][act_idx]) &&
> +			bfqq->bic->bfqq[0][act_idx]->next_rq ?
> +			bfqq->bic->bfqq[0][act_idx] : NULL;

Missing a blank line before this hunk, after the declaration. And I
personally think that this is totally unreadable. Using a plain if/else
would improve that.

>  		struct bfq_queue *blocked_bfqq =3D
>  			!hlist_empty(&bfqq->woken_list) ?
>  			container_of(bfqq->woken_list.first,
> @@ -4904,7 +4928,7 @@ static struct bfq_queue *bfq_select_queue(struct =
bfq_data *bfqd)
>  		    icq_to_bic(async_bfqq->next_rq->elv.icq) =3D=3D bfqq->bic &&
>  		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=3D
>  		    bfq_bfqq_budget_left(async_bfqq))
> -			bfqq =3D bfqq->bic->bfqq[0];
> +			bfqq =3D bfqq->bic->bfqq[0][act_idx];
>  		else if (bfqq->waker_bfqq &&
>  			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
>  			   bfqq->waker_bfqq->next_rq &&
> @@ -5365,49 +5389,59 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd=
, struct bfq_queue *bfqq)
>  	bfq_release_process_ref(bfqd, bfqq);
>  }
> =20
> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic,
> +			      bool is_sync,
> +			      unsigned int actuator_idx)

Why the line split here ?

>  {
> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, actuator_idx);
>  	struct bfq_data *bfqd;
> =20
>  	if (bfqq)
>  		bfqd =3D bfqq->bfqd; /* NULL if scheduler already exited */
> =20
>  	if (bfqq && bfqd) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&bfqd->lock, flags);
>  		bfqq->bic =3D NULL;
>  		bfq_exit_bfqq(bfqd, bfqq);
> -		bic_set_bfqq(bic, NULL, is_sync);
> -		spin_unlock_irqrestore(&bfqd->lock, flags);
> +		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
>  	}
>  }
> =20
>  static void bfq_exit_icq(struct io_cq *icq)
>  {
>  	struct bfq_io_cq *bic =3D icq_to_bic(icq);
> +	struct bfq_data *bfqd =3D bic_to_bfqd(bic);
> +	unsigned long flags;
> +	unsigned int act_idx;
> +	unsigned int num_actuators;
> =20
> -	if (bic->stable_merge_bfqq) {
> -		struct bfq_data *bfqd =3D bic->stable_merge_bfqq->bfqd;
> -
> +	/*
> +	 * bfqd is NULL if scheduler already exited, and in that case
> +	 * this is the last time these queues are accessed.
> +	 */
> +	if (bfqd) {
> +		spin_lock_irqsave(&bfqd->lock, flags);
> +		num_actuators =3D bfqd->num_actuators;
> +	} else {
>  		/*
> -		 * bfqd is NULL if scheduler already exited, and in
> -		 * that case this is the last time bfqq is accessed.
> +		 * bfqd->num_actuators not available any longer, cycle
> +		 * over all possible per-actuator bfqqs in next
> +		 * loop. We rely on bic being zeroed on creation, and
> +		 * therefore on its unused per-actuator fields being
> +		 * NULL.
>  		 */
> -		if (bfqd) {
> -			unsigned long flags;
> +		num_actuators =3D BFQ_MAX_ACTUATORS;
> +	}

Why not simply initialize num_actuators to BFQ_MAX_ACTUATORS when it is
declared and drop that "else" above ?

> =20
> -			spin_lock_irqsave(&bfqd->lock, flags);
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> -			spin_unlock_irqrestore(&bfqd->lock, flags);
> -		} else {
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> -		}
> +	if (bic->stable_merge_bfqq)
> +		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +
> +	for (act_idx =3D 0; act_idx < num_actuators; act_idx++) {
> +		bfq_exit_icq_bfqq(bic, true, act_idx);
> +		bfq_exit_icq_bfqq(bic, false, act_idx);
>  	}
> =20
> -	bfq_exit_icq_bfqq(bic, true);
> -	bfq_exit_icq_bfqq(bic, false);
> +	if (bfqd)
> +		spin_unlock_irqrestore(&bfqd->lock, flags);
>  }
> =20
>  /*
> @@ -5484,23 +5518,25 @@ static void bfq_check_ioprio_change(struct bfq_=
io_cq *bic, struct bio *bio)
> =20
>  	bic->ioprio =3D ioprio;
> =20
> -	bfqq =3D bic_to_bfqq(bic, false);
> +	bfqq =3D bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
>  	if (bfqq) {
>  		bfq_release_process_ref(bfqd, bfqq);
>  		bfqq =3D bfq_get_queue(bfqd, bio, false, bic, true);
> -		bic_set_bfqq(bic, bfqq, false);
> +		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
>  	}
> =20
> -	bfqq =3D bic_to_bfqq(bic, true);
> +	bfqq =3D bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
>  	if (bfqq)
>  		bfq_set_next_ioprio_data(bfqq, bic);
>  }
> =20
>  static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfq=
q,
> -			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
> +			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
> +			  unsigned int act_idx)
>  {
>  	u64 now_ns =3D ktime_get_ns();
> =20
> +	bfqq->actuator_idx =3D act_idx;
>  	RB_CLEAR_NODE(&bfqq->entity.rb_node);
>  	INIT_LIST_HEAD(&bfqq->fifo);
>  	INIT_HLIST_NODE(&bfqq->burst_list_node);
> @@ -5739,6 +5775,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq=
_data *bfqd,
>  	struct bfq_group *bfqg;
> =20
>  	bfqg =3D bfq_bio_bfqg(bfqd, bio);
> +

whiteline change.

>  	if (!is_sync) {
>  		async_bfqq =3D bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
>  						  ioprio);
> @@ -5753,7 +5790,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq=
_data *bfqd,
> =20
>  	if (bfqq) {
>  		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
> -			      is_sync);
> +			      is_sync, bfq_actuator_index(bfqd, bio));
>  		bfq_init_entity(&bfqq->entity, bfqg);
>  		bfq_log_bfqq(bfqd, bfqq, "allocated");
>  	} else {
> @@ -6068,7 +6105,8 @@ static bool __bfq_insert_request(struct bfq_data =
*bfqd, struct request *rq)
>  		 * then complete the merge and redirect it to
>  		 * new_bfqq.
>  		 */
> -		if (bic_to_bfqq(RQ_BIC(rq), 1) =3D=3D bfqq)
> +		if (bic_to_bfqq(RQ_BIC(rq), 1,
> +				bfq_actuator_index(bfqd, rq->bio)) =3D=3D bfqq)
>  			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
>  					bfqq, new_bfqq);
> =20
> @@ -6622,7 +6660,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_=
queue *bfqq)
>  		return bfqq;
>  	}
> =20
> -	bic_set_bfqq(bic, NULL, 1);
> +	bic_set_bfqq(bic, NULL, 1, bfqq->actuator_idx);
> =20
>  	bfq_put_cooperator(bfqq);
> =20
> @@ -6636,7 +6674,8 @@ static struct bfq_queue *bfq_get_bfqq_handle_spli=
t(struct bfq_data *bfqd,
>  						   bool split, bool is_sync,
>  						   bool *new_queue)
>  {
> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
> +	unsigned int act_idx =3D bfq_actuator_index(bfqd, bio);
> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, act_idx);
> =20
>  	if (likely(bfqq && bfqq !=3D &bfqd->oom_bfqq))
>  		return bfqq;
> @@ -6648,7 +6687,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_spli=
t(struct bfq_data *bfqd,
>  		bfq_put_queue(bfqq);
>  	bfqq =3D bfq_get_queue(bfqd, bio, is_sync, bic, split);
> =20
> -	bic_set_bfqq(bic, bfqq, is_sync);
> +	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>  	if (split && is_sync) {
>  		if ((bic->was_in_burst_list && bfqd->large_burst) ||
>  		    bic->saved_in_large_burst)
> @@ -7090,8 +7129,10 @@ static int bfq_init_queue(struct request_queue *=
q, struct elevator_type *e)
>  	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
>  	 * Grab a permanent reference to it, so that the normal code flow
>  	 * will not attempt to free it.
> +	 * Set zero as actuator index: we will pretend that
> +	 * all I/O requests are for the same actuator.
>  	 */
> -	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
> +	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0, 0);
>  	bfqd->oom_bfqq.ref++;
>  	bfqd->oom_bfqq.new_ioprio =3D BFQ_DEFAULT_QUEUE_IOPRIO;
>  	bfqd->oom_bfqq.new_ioprio_class =3D IOPRIO_CLASS_BE;
> @@ -7110,6 +7151,12 @@ static int bfq_init_queue(struct request_queue *=
q, struct elevator_type *e)
> =20
>  	bfqd->queue =3D q;
> =20
> +	/*
> +	 * Multi-actuator support not complete yet, default to single
> +	 * actuator for the moment.
> +	 */
> +	bfqd->num_actuators =3D 1;

This should be the default anyway, so is that comment really necessary ?

> +
>  	INIT_LIST_HEAD(&bfqd->dispatch);
> =20
>  	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 71f721670ab6..bfcbd8ea9000 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -33,6 +33,14 @@
>   */
>  #define BFQ_SOFTRT_WEIGHT_FACTOR	100
> =20
> +/*
> + * Maximum number of actuators supported. This constant is used simply
> + * to define the size of the static array that will contain
> + * per-actuator data. The current value is hopefully a good upper
> + * bound to the possible number of actuators of any actual drive.
> + */
> +#define BFQ_MAX_ACTUATORS 32

That seems really excessive... What about 4 or 8 ?

> +
>  struct bfq_entity;
> =20
>  /**
> @@ -225,12 +233,14 @@ struct bfq_ttime {
>   * struct bfq_queue - leaf schedulable entity.
>   *
>   * A bfq_queue is a leaf request queue; it can be associated with an
> - * io_context or more, if it  is  async or shared  between  cooperatin=
g
> - * processes. @cgroup holds a reference to the cgroup, to be sure that=
 it
> - * does not disappear while a bfqq still references it (mostly to avoi=
d
> - * races between request issuing and task migration followed by cgroup
> - * destruction).
> - * All the fields are protected by the queue lock of the containing bf=
qd.
> + * io_context or more, if it is async or shared between cooperating
> + * processes. Besides, it contains I/O requests for only one actuator
> + * (an io_context is associated with a different bfq_queue for each
> + * actuator it generates I/O for). @cgroup holds a reference to the
> + * cgroup, to be sure that it does not disappear while a bfqq still
> + * references it (mostly to avoid races between request issuing and
> + * task migration followed by cgroup destruction).  All the fields are
> + * protected by the queue lock of the containing bfqd.
>   */
>  struct bfq_queue {
>  	/* reference counter */
> @@ -395,6 +405,9 @@ struct bfq_queue {
>  	 * the woken queues when this queue exits.
>  	 */
>  	struct hlist_head woken_list;
> +
> +	/* index of the actuator this queue is associated with */
> +	unsigned int actuator_idx;
>  };
> =20
>  /**
> @@ -403,8 +416,17 @@ struct bfq_queue {
>  struct bfq_io_cq {
>  	/* associated io_cq structure */
>  	struct io_cq icq; /* must be the first member */
> -	/* array of two process queues, the sync and the async */
> -	struct bfq_queue *bfqq[2];
> +	/*
> +	 * Matrix of associated process queues: first row for async
> +	 * queues, second row sync queues. Each row contains one
> +	 * column for each actuator. An I/O request generated by the
> +	 * process is inserted into the queue pointed by bfqq[i][j] if
> +	 * the request is to be served by the j-th actuator of the
> +	 * drive, where i=3D=3D0 or i=3D=3D1, depending on whether the reques=
t
> +	 * is async or sync. So there is a distinct queue for each
> +	 * actuator.
> +	 */
> +	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
>  	/* per (request_queue, blkcg) ioprio */
>  	int ioprio;
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> @@ -768,6 +790,13 @@ struct bfq_data {
>  	 */
>  	unsigned int word_depths[2][2];
>  	unsigned int full_depth_shift;
> +
> +	/*
> +	 * Number of independent actuators. This is equal to 1 in
> +	 * case of single-actuator drives.
> +	 */
> +	unsigned int num_actuators;
> +
>  };
> =20
>  enum bfqq_state_flags {
> @@ -964,8 +993,10 @@ struct bfq_group {
> =20
>  extern const int bfq_timeout;
> =20
> -struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
> -void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool =
is_sync);
> +struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
> +				unsigned int actuator_idx);
> +void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool =
is_sync,
> +				unsigned int actuator_idx);
>  struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
>  void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bf=
qq);
>  void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfq=
q,

--=20
Damien Le Moal
Western Digital Research

