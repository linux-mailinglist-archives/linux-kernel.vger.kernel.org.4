Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F2652A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiLUAqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiLUAqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:46:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE7DF53
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671583591; x=1703119591;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oc2JeDyWdv/qnllUnuU5FtLaqnCPSuRejhDnLfkmZok=;
  b=Ba/R/NwnNCal1FRYFJU9qLyNd+ROfESd1CBzY37hkgZXlxNVTwTGzYpx
   iiIvhP8nZdpxOn9tvfKMiW/5SYhs0CzF6geiyC5q4xUQgCuiGjC5m3MtK
   iyN9MiEhhBt7uf3MDDmS19JAd0Sv4sC7uSUz6IYg0oqqVg4tuuaf4h4Q7
   6SUbCQHkkKFHi3Yk7Agq3TZw/c7tZFa3jZx3Btk+boI+LedPmxjTM4Bu8
   tkiqd9SC16QfijwkrpujhtM6T3yN67Q9VB1FJo+Dvump+KC2lFgG4dvs8
   EZlRBQRyc3VfQzRBpBp1w4MIAwL1pkeGWI3+7WfI+C4SGi5O0t2yVVVTg
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,261,1665417600"; 
   d="scan'208";a="219103190"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 08:46:31 +0800
IronPort-SDR: +SzI0SELn1+QDBCW423drI5tbkuoClzyMtWIWS/gqBhBbm19IoIi8BJUEa/7rfFZbc1dBqbzAP
 Hp5hN1Ytk4F21RZQYc97A8hZzwzHiRJHbHCCkXx3ZPfdam7OgkY71XvFHJEoxTSp5H7EbdtiDi
 IPMc6/hGMFJ/P83L0EhuzqNbOZULEsyC2fI7uSwqhAqAp8Wrs6KNAjgPZvDsgscnFyOB8Vo2/w
 n7YHWKaACu+rCOGu3K3TXcSTFefLUxUryV+RSQSrsIrdzvw/dFIJD+i4AtD0oasKGZ5In4Z87r
 GXA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 15:59:00 -0800
IronPort-SDR: 49ctD9LgspjC9rn7RJgd43C35hllIKHGHRMXjLvG47gtwhIoN2eXuwcgv+X7+wCvAktEtjGqwN
 bycpc++DI7j8HwRc8KhIu2R7wtJavVaJEWMYK671BoE33YT/E4uoPkS4lxYhLm9MsSf+IvMnee
 nDw6ObKVJttazDgJYADRLJ02vqrYbscJpL8aQRxucSA6Exp0eJSRu2jEqCum6yPRS0vd8bK51R
 sh367oPy9QhsCAJSf5Z/F3ypbaWz/B6/i1OLqh2JA2XRJph+fvnL5ovoS8xUqwEds3h+xCjloy
 S/k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 16:46:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcFBG37KNz1RvTp
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:46:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671583588; x=1674175589; bh=Oc2JeDyWdv/qnllUnuU5FtLaqnCPSuRejhD
        nLfkmZok=; b=fLvU7ZAfLJkDKJ2wqakGyfWHUPf6154R2zB3blmHNQ+yb5wmu5N
        HLaBdwmrftZalPRKzIgnbtdEl4basALxFDeQg1l1y+2WZG1+jabssmQev6D5PBIj
        prtM/5fqrv0mpjo91iikxqb0VdW92MaIqnGMLS7Z/epI7qJI0GLEfF5vM5DF11rn
        eh1qBmyKE6gcHEdUrfUNV46tSHG1tw8MOv++YbBkNaVZZ5+NFcf+x0EBXbWcj00r
        FdYzHYuKvlIolMKWnaRgz79BXzjISDAsllvmOuVR0/LbLZcrTpKwqErS/fWvkTga
        DOyu/hOjX49mfsFBRIX9tnpnt7MaAHfpfcg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LBeCwygXbUAP for <linux-kernel@vger.kernel.org>;
        Tue, 20 Dec 2022 16:46:28 -0800 (PST)
Received: from [10.89.80.120] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcFBC3Sglz1RvLy;
        Tue, 20 Dec 2022 16:46:27 -0800 (PST)
Message-ID: <8a49432d-642f-cd58-8e4d-2b320aef5edd@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 09:46:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH V11 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
 <20221220095013.55803-2-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221220095013.55803-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/20 18:50, Paolo Valente wrote:
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

[...]

If you want me to review, can you please add me to the CC list of this se=
ries ?
I am only getting the patches that I already reviewed, which is not very =
useful...

> @@ -672,9 +682,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct b=
lk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
>  	struct bfq_io_cq *bic =3D bfq_bic_lookup(data->q);
> -	struct bfq_queue *bfqq =3D bic ? bic_to_bfqq(bic, op_is_sync(opf)) : =
NULL;
>  	int depth;
>  	unsigned limit =3D data->q->nr_requests;
> +	unsigned int act_idx;
> =20
>  	/* Sync reads have full depth available */
>  	if (op_is_sync(opf) && !op_is_write(opf)) {
> @@ -684,14 +694,21 @@ static void bfq_limit_depth(blk_opf_t opf, struct=
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

Ignored my comment again... Oh well. If you prefer the code this way... I=
 do not
find it pretty nor solid as is though.

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

[...]

> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
> +			      unsigned int actuator_idx)
>  {
> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, actuator_idx);
>  	struct bfq_data *bfqd;
> =20
>  	if (bfqq)

With your current bic_to_bfqq() implementation, you will *never* get NULL=
 as a
return value. So why is this if necessary ?

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
> +	/*
> +	 * If bfqd and thus bfqd->num_actuators is not available any
> +	 * longer, then cycle over all possible per-actuator bfqqs in
> +	 * next loop. We rely on bic being zeroed on creation, and
> +	 * therefore on its unused per-actuator fields being NULL.
> +	 */
> +	unsigned int num_actuators =3D BFQ_MAX_ACTUATORS;
> =20
> -	if (bic->stable_merge_bfqq) {
> -		struct bfq_data *bfqd =3D bic->stable_merge_bfqq->bfqd;
> +	/*
> +	 * bfqd is NULL if scheduler already exited, and in that case
> +	 * this is the last time these queues are accessed.
> +	 */
> +	if (bfqd) {

Same here. bfqd can never be NULL. Or I am really missing something... Lo=
ts of
other places like this where checking bic_to_bfqd() seems unnecessary.

> +		spin_lock_irqsave(&bfqd->lock, flags);
> +		num_actuators =3D bfqd->num_actuators;
> +	}
> =20
> -		/*
> -		 * bfqd is NULL if scheduler already exited, and in
> -		 * that case this is the last time bfqq is accessed.
> -		 */
> -		if (bfqd) {
> -			unsigned long flags;
> +	if (bic->stable_merge_bfqq)
> +		bfq_put_stable_ref(bic->stable_merge_bfqq);
> =20
> -			spin_lock_irqsave(&bfqd->lock, flags);
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> -			spin_unlock_irqrestore(&bfqd->lock, flags);
> -		} else {
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> -		}
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


--=20
Damien Le Moal
Western Digital Research

