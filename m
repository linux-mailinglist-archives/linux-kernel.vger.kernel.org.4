Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B326317ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKUAwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKUAwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:52:21 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5321800
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668991940; x=1700527940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W4HKBPacyoxKuQG9ctGh8xw4Yk2MGcLQmneBYhliMsc=;
  b=biV8qoaoO5LbM1TO+5OAu1kKcdwG8mZRowlF3g8W3qohqKolQRJwI9Av
   pQADa/Jmohd1LDS2T+H1f35gvlvzRbKF0+cAmW3gFjMsRMNgsNPVcuNVs
   5FequohZ3vvJGtPxN4rYhnCnIxvpypSuhDUOArzkpssXuCNNl+JVY4LPO
   W5Ezl5W1ywraR5PXEuMZqlpB6OUYIKyfGH4KnDX01iDMV+DwDl1YDnjQO
   UwWduWfhAZA6Q/MrrFI4MCKWbt+OqhejzQinBSjoRGYWtfLNSodna1m3+
   NvxCJqnvarlH9XUzBAtNxeTt8vwxH6W5oTeOVDrlSNjvURMQQ92Yl/3uI
   w==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="214993045"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 08:52:19 +0800
IronPort-SDR: BedA2CdbBc1a3tZBnanUsdIsg1MJJmNbMnsLgz/7JrQy8YGs8Az/6cn6MhgGT+HY9yx7mHKnRS
 fA5qLvd+NPTt6v9UuFs6SpcnHVh9A1DlIWbC5GoUxqDPVJhUk6XPSRaFZ0Zw7KwGhiPRyeiTsu
 pyyCciDgSLZ74RfTs04y5QKAqgtFySSHmYshllWqKGxjhyMZaS56tXQHk9De49y1YEt3QsGJUb
 0MhrtrxtXhuf07XGPCZMJBz8lqgPibnRiY+XVd5iRs2y0T42cFaT9BErWtv8zgLldYFdWIEbX0
 X/w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:05:25 -0800
IronPort-SDR: Uc40HVGBZVrotEMg6WpeVOlI8CNILDS45r3hDX4nr6c2JXRUKHPT2bVHoH86VetIzfN3+6TOvj
 hzk1mHiILwiqHYQ8YIhmR3DDupfKlYW7lm/h4hhRyCcYsAqC+Fi8q8aoYOsvYA6sNQt5idtqiH
 0+T2yseHdkYuQzSU6EM3ED5MNuBmMlrh8xWV3lqdUOnWpbemncrRNEXnMCbmngELSSzaSAVOxh
 /XR8hc5RDXNi2j7tbP2YE5iSBx8nxZOwGJd0eIlhAdq1LsgRoP+agYicL6mAtvjCi9ZTaoMZs0
 BdQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:52:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFpkp3zzFz1Rwt8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:52:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668991937; x=1671583938; bh=W4HKBPacyoxKuQG9ctGh8xw4Yk2MGcLQmne
        BYhliMsc=; b=IC8BD2GERxJwYSGOgnoBT77yFibYp2sVratZDHlb1f/7C+oCqp/
        zzlpr+0MXT3/RuC6QZRhLz/sdcITJsJ8R2ycGInZZnKqOtoO5grmOZUx4jiyJHUa
        vLx4d+LwVO/aMS9z+rWf7vYDCifS1wpBw4XO9i9yOi5AVrYH9rcEs/NkXelE4+vm
        2AaQ/DiSgenu1KkQ5Z6Ie72HCwUIAZzoD9Hex1Md6xWVV2suto+fASRPdpHFJtWm
        0zhxpxYe7jk7zOk9TntoWn0/OwRq14al9oTiTItOoWMT7s+ZBXm0TIKbPcCOqydu
        1V/gECubbqu2oVGekmSIingkw8lvhfMZN5A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dHgxENFJ-yqp for <linux-kernel@vger.kernel.org>;
        Sun, 20 Nov 2022 16:52:17 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFpkm2Qf6z1RvLy;
        Sun, 20 Nov 2022 16:52:16 -0800 (PST)
Message-ID: <ea23e4d6-bdf8-ed2a-afbc-04a39f360a32@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 09:52:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 5/8] block, bfq: split also async bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-6-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-6-paolo.valente@linaro.org>
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
> Similarly to sync bfq_queues, also async bfq_queues need to be split
> on a per-actuator basis.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Davide Zini <davidezini2@gmail.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/bfq-iosched.c | 41 +++++++++++++++++++++++------------------
>  block/bfq-iosched.h |  8 ++++----
>  2 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index f44bac054aaf..c94b80e3f685 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2673,14 +2673,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
>  void bfq_end_wr_async_queues(struct bfq_data *bfqd,
>  			     struct bfq_group *bfqg)
>  {
> -	int i, j;
> -
> -	for (i = 0; i < 2; i++)
> -		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
> -			if (bfqg->async_bfqq[i][j])
> -				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
> -	if (bfqg->async_idle_bfqq)
> -		bfq_bfqq_end_wr(bfqg->async_idle_bfqq);
> +	int i, j, k;
> +
> +	for (k = 0; k < bfqd->num_actuators; k++) {
> +		for (i = 0; i < 2; i++)
> +			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
> +				if (bfqg->async_bfqq[i][j][k])
> +					bfq_bfqq_end_wr(bfqg->async_bfqq[i][j][k]);
> +		if (bfqg->async_idle_bfqq[k])
> +			bfq_bfqq_end_wr(bfqg->async_idle_bfqq[k]);
> +	}
>  }
>  
>  static void bfq_end_wr(struct bfq_data *bfqd)
> @@ -5620,18 +5622,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  
>  static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
>  					       struct bfq_group *bfqg,
> -					       int ioprio_class, int ioprio)
> +					       int ioprio_class, int ioprio, int act_idx)
>  {
>  	switch (ioprio_class) {
>  	case IOPRIO_CLASS_RT:
> -		return &bfqg->async_bfqq[0][ioprio];
> +		return &bfqg->async_bfqq[0][ioprio][act_idx];
>  	case IOPRIO_CLASS_NONE:
>  		ioprio = IOPRIO_BE_NORM;
>  		fallthrough;
>  	case IOPRIO_CLASS_BE:
> -		return &bfqg->async_bfqq[1][ioprio];
> +		return &bfqg->async_bfqq[1][ioprio][act_idx];
>  	case IOPRIO_CLASS_IDLE:
> -		return &bfqg->async_idle_bfqq;
> +		return &bfqg->async_idle_bfqq[act_idx];
>  	default:
>  		return NULL;
>  	}
> @@ -5805,7 +5807,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
>  
>  	if (!is_sync) {
>  		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
> -						  ioprio);
> +						  ioprio,
> +						  bfq_actuator_index(bfqd, bio));
>  		bfqq = *async_bfqq;
>  		if (bfqq)
>  			goto out;
> @@ -7022,13 +7025,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
>   */
>  void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>  {
> -	int i, j;
> +	int i, j, k;
>  
> -	for (i = 0; i < 2; i++)
> -		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
> -			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
> +	for (k = 0; k < bfqd->num_actuators; k++) {
> +		for (i = 0; i < 2; i++)
> +			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
> +				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
>  
> -	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
> +		__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq[k]);
> +	}
>  }
>  
>  /*
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index e27897d66a0f..f1c2e77cbf9a 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -976,8 +976,8 @@ struct bfq_group {
>  
>  	void *bfqd;
>  
> -	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
> -	struct bfq_queue *async_idle_bfqq;
> +	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
> +	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
>  
>  	struct bfq_entity *my_entity;
>  
> @@ -993,8 +993,8 @@ struct bfq_group {
>  	struct bfq_entity entity;
>  	struct bfq_sched_data sched_data;
>  
> -	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
> -	struct bfq_queue *async_idle_bfqq;
> +	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
> +	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
>  
>  	struct rb_root rq_pos_tree;
>  };

-- 
Damien Le Moal
Western Digital Research

