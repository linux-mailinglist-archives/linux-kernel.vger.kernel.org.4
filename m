Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA66B656698
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 02:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiL0BhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 20:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0BhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 20:37:07 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD5139
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672105025; x=1703641025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SqLpW+jHAaITXxfrrH832WRmIxdCVo+x/q43YJ040es=;
  b=BQBL7dYz5n9SU1iS3HohmHKH5aC/XJQ2m41xeJfjJHVVd37Gr6XFcjay
   2JSnB+djIL23Ag5vVK5XljB6EYPe5VPYkTR3GXpBpUnlV19ZWA6/r/jwB
   35FQE2AdUHYmXKX4cixCOGRVd7f9xDO88bU8MYEpZsKXTXtUMr7gWnrAF
   Zzt4u1A1EbPnV1+7e/eugLTR9c54oo+NRCkE33Jk9i1Knt8FpTXPU5kuW
   u3cZ62EvKW0E9zfcUa+YdNu6Zu83AHWdgnM0uLTzp7TJhTgIkCPZywax5
   RQhr99JIauf0I4qwHZfRX5yBiWxhsYFykkmaa5II1Lb/XdaSaXAmXT7pg
   w==;
X-IronPort-AV: E=Sophos;i="5.96,277,1665417600"; 
   d="scan'208";a="331552681"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2022 09:37:05 +0800
IronPort-SDR: wOY7gN1+AQoQtuJO826e7hx4VlvmPiRreWyIp+S9zu4JOGAgB2d10xKocwZcb8daODwgOFpCVA
 8rsL4d2wZGpLTpPsCZBaxEon+U/h1vheyJ9pA71HW85QIcHo79wsE+NVb+Ag49y0UHVRvwAax6
 Ris+tpycf3rwQOaQ20Xeq5r0BeOUE4GpQAEPrCRFnTlIckKr5PnAqePYaSMXjy9rRVox0ko7FY
 EoBOPxrEeKlf2lE7GzjHVcZsmOyesnnSgSxsOcCA70wZCRm4oIwzz2pPdpOWVXxHAoPafuJXU1
 7NI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Dec 2022 16:49:27 -0800
IronPort-SDR: 4bzRM923lAqP2thN7usQZJA1W49oAEEbsr7kTPMEeFY8tHy+qZru5VDCKXqqqnRLI1Id9+0i9R
 hIZfzBYueGviij3LEvnmOyWW4qywZ/xb1s00/kTzRFG2Fwv254zxngoQP1RXD12N8TZRLyoE+s
 0PyUMMEfUfU8BAx54h8NaN37eE/FZQpBezaO1Xn+Vb5D/rRFuHsfs9tzkL9UCueWe4GHHFOxwi
 OmBs+hr3NJau4q3QxQz15+5m+NEs7IHXFh6VIgmEhn0y5kaqIB+beMLXAB3aus2Jj74ok1A74B
 IbY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Dec 2022 17:37:06 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ngy1s09YCz1RvTp
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:37:05 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672105023; x=1674697024; bh=SqLpW+jHAaITXxfrrH832WRmIxdCVo+x/q4
        3YJ040es=; b=YYTI4+E4PA8bPQCGYmP8GGdMKTot0anNpZcNYbC5H7D0PqPPQh9
        svoZn1J6GDGSaBcbqOe5BavacyYh2Q8kcD/onp07NydcK1Zld6K24xfFrl67GgZE
        pLJfJu0z4a2isrvGo1VoMgMVdu6FiL4olTNn7v7ETDtP5MR1DtefTI24UH0lk1OT
        QQO1PB2XzkTaSbsUUJ40sNQA9p/wzYLKGdyrIzUAYKpaFTaEjs66I5zfUrh6x8Zx
        CDQkcxpe5vW2y9x5jgRrFGMqdjfoDXaTsLPieKZoYZ5etZ9Iyg2ilzizUjmSjZSA
        bJ5GKuR+J+EGcUq44Abkkdpn3tZyynQtGVw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4OrO3NjBIFux for <linux-kernel@vger.kernel.org>;
        Mon, 26 Dec 2022 17:37:03 -0800 (PST)
Received: from [10.225.163.117] (unknown [10.225.163.117])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ngy1p14wXz1RvLy;
        Mon, 26 Dec 2022 17:37:02 -0800 (PST)
Message-ID: <71738b57-ecd0-f95c-9c42-b7686c3232b6@opensource.wdc.com>
Date:   Tue, 27 Dec 2022 10:37:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V12 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221222152157.61789-1-paolo.valente@linaro.org>
 <20221222152157.61789-2-paolo.valente@linaro.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221222152157.61789-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/22 00:21, Paolo Valente wrote:
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

One styles nit below.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> @@ -690,14 +700,25 @@ static void bfq_limit_depth(blk_opf_t opf, struct=
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
> +		struct bfq_queue *bfqq;
> +
> +		if (bic)
> +			bfqq =3D bic_to_bfqq(bic, op_is_sync(opf), act_idx);
> +		else
> +			break;
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

You could reverse the if condition to make this cleaner, or even better,
include the bic test in the for loop:

for (act_idx =3D 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
	struct bfq_queue *bfqq;

	/*
	 * Does queue (or any parent entity) exceed number of
	 * requests that should be available to it? Heavily
	 * limit depth so that it cannot consume more
	 * available requests and thus starve other entities.
	 */
	bfqq =3D bic_to_bfqq(bic, op_is_sync(opf), act_idx);
	if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
		depth =3D 1;
		break;
	}
}


--=20
Damien Le Moal
Western Digital Research

