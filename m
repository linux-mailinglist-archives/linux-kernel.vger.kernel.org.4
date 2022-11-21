Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD98863180D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKUBBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 20:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKUBBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:01:15 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A3D218BA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668992474; x=1700528474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqZwB4mUx5KtpzA6T+C4d6z/dqxxnpNbzXCnsfbUA04=;
  b=j7PNdZbUFHxROliOm70wivB8xkjdGD7JXJIac5u8THPkYXadTuDtAVvg
   N7GhGzROxKgwwsnjaq8w107DJTnDEChnBPKNWAGPtUKFJUU1rtdsd8NYe
   DzmcKko7/7wMsvx8qM1ZjFOjRyNqH5ZMoskAnQ//xqEP7L8Ch7I/Rfec+
   YxoJu1ACxIEkqhmaTP1o9l4PVxeLebPyiTjuQen7ksr/lFf2fZBhdgez7
   1J2LatG3YXuU7dXbxuMmT5num5SbtKlAvrB3vVlSv34kPZpg1BY2PbvpZ
   gqsao/IK6x4QTxL54mOVZP+gzhYJcvAFi4JA9OvSB/D66lvMaY5OjllLK
   w==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="216740457"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 09:01:13 +0800
IronPort-SDR: ULsLp6ObLZvTv5Fs/pUuitQmyoOtBePJXBnxDsUxPTMuk66GJLpaZI7XHdhQQ7hH38oW3jcFEU
 S9sP5CwW/iIMqPMRMmFilIz3la/eyKQCx8ooT1xrWwpnYV+pNKigVZBgiCFHIzQ3zlMhuxNy1q
 BmJ3gBhF7JnV/4vGq4sHD9HVTo7rDBmaI52N4eAuKW8n6e4+W7oJ7ckHUi+j7YsshHmFzRyBnQ
 z1ioSg4mLju5fPUAzuWyCTLo6TrQXeSvKT5EqmGY7pTWpNX7JL0/ygP6w3cb3kVSZqk3YPClCE
 kIY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:14:19 -0800
IronPort-SDR: HHUUiyQPFnxQ95MmhFEQ3FSY1dHWNB0ZdNTP6RIawozNnFI78Ir3pENnBZg3AmhZrm/eqQN9qJ
 hZZVsXpholc9nVBa29G8V2sUijo5P7NFR8Bo8539UiH+IG1x37IjEm6LjDH50KOVCz59ZHMLb5
 BQfh6f5YcluQ1kPjGQJf7e7nrAXXdCCSzLw16hLDQ54xz3awN9AodFTplFWH4oe2fk77Z7U27q
 DEr+M6W0S40+F0XxJgljPbHWHCu4k/YwF39+kmppeZwu+5DJLjvIHYZ0r18EzcmRACx28VcinC
 jvk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 17:01:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFpx46F5Jz1Rwrq
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:01:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668992471; x=1671584472; bh=nqZwB4mUx5KtpzA6T+C4d6z/dqxxnpNbzXC
        nsfbUA04=; b=QRgGHXST91rVQRzoT0CMFD1RxF9sloXcoL2DuuMlEam6hYIbPMC
        hTZg+Y8k60Dv3VPhKkCUbBJitEzP+h0VIRkIJTja3ihtjjgyPTmWUr1PMgpVe2Vm
        D8Y1SrgUafCig8DxyhYjE3whmzRe8msWR9Q6LX77BnjfCOpWFhPRj8zwh60pFXcm
        G3hfN/ktvct1HvDlZUhwL+JjSALlAglXhR+1dhzV4HhAf/92GUDfb09wxYq/EKgS
        lk/3Img2NEDLoZDXkqIWP/XVU8DkdIZcEitJFgONzmPrdhu31hpPx58OaEsekrNd
        NhDVMXGOo2NDCuIAbZn2/60u0OKr3JGHAVg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8xPIcpLXXd6h for <linux-kernel@vger.kernel.org>;
        Sun, 20 Nov 2022 17:01:11 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFpx21vDGz1RvLy;
        Sun, 20 Nov 2022 17:01:10 -0800 (PST)
Message-ID: <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 10:01:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-7-paolo.valente@linaro.org>
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
> Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 54 ++++++++++++++++++++++++++++++++++++++-------
>  block/bfq-iosched.h |  5 +++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c94b80e3f685..106c8820cc5c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1831,10 +1831,26 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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
> +	/* no search needed if one or zero ranges present */
> +	if (bfqd->num_actuators < 2)
> +		return 0;
> +
> +	/* bio_end_sector(bio) gives the sector after the last one */
> +	end = bio_end_sector(bio) - 1;
> +
> +	for (i = 0; i < bfqd->num_actuators; i++) {
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
> @@ -2479,7 +2495,6 @@ static void bfq_remove_request(struct request_queue *q,
>  
>  	if (rq->cmd_flags & REQ_META)
>  		bfqq->meta_pending--;
> -

whiteline change

>  }
>  
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  {
>  	struct bfq_data *bfqd;
>  	struct elevator_queue *eq;
> +	unsigned int i;
> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>  
>  	eq = elevator_alloc(q, e);
>  	if (!eq)
> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  	bfqd->queue = q;
>  
>  	/*
> -	 * Multi-actuator support not complete yet, default to single
> -	 * actuator for the moment.
> +	 * If the disk supports multiple actuators, we copy the independent
> +	 * access ranges from the request queue structure.
>  	 */
> -	bfqd->num_actuators = 1;
> +	spin_lock_irq(&q->queue_lock);
> +	if (ia_ranges) {
> +		/*
> +		 * Check if the disk ia_ranges size exceeds the current bfq
> +		 * actuator limit.
> +		 */
> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
> +				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
> +			pr_crit("Falling back to single actuator mode.\n");
> +			bfqd->num_actuators = 0;
> +		} else {
> +			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
> +
> +			for (i = 0; i < bfqd->num_actuators; i++)
> +				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
> +		}
> +	} else {
> +		bfqd->num_actuators = 0;

That is very weird. The default should be 1 actuator.
ia_ranges->nr_ia_ranges is 0 when the disk does not provide any range
information, meaning it is a regular disk with a single actuator.

> +	}
> +
> +	spin_unlock_irq(&q->queue_lock);
>  
>  	INIT_LIST_HEAD(&bfqd->dispatch);
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index f1c2e77cbf9a..90130a893c8f 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -811,6 +811,11 @@ struct bfq_data {
>  	 */
>  	unsigned int num_actuators;
>  
> +	/*
> +	 * Disk independent access ranges for each actuator
> +	 * in this device.
> +	 */
> +	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];

I fail to see how keeping this information is useful, especially given
that this struct contains a kobj. Why not just copy the sector &
nr_sectors fields into struct bfq_queue ? That would also work for the
single actuator case as then sector will be 0 and nr_sectors will be the
disk total capacity.

I think this patch should be first in the series. That will avoid having
the empty bfq_actuator_index() function.

>  };
>  
>  enum bfqq_state_flags {

-- 
Damien Le Moal
Western Digital Research

