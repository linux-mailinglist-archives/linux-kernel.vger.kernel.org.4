Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2F73CE77
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjFYEus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYEuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:50:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3837BE5F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:50:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b71cdb47e1so2034607a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687668641; x=1690260641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAXKmRxn/lGVEXnXeDsvJ+fu3YmCBSEAvX8M4/5L5VA=;
        b=bMuj7cwDdoXKISTDkzptBDyzYxrmMPhttiVwFLmhishVLlAo/0wcnWwOOKc5KaDNXp
         0k1HqVrE8Hx7iR7I7S4xdgjAcc5RhvCF5AELHTGX1kf+O9BpKUzHAOBQSa1iEErhttPG
         3b8+RInnKIdo158WvXe5DmpQDrKtM/VZ8zy1c1yjNq1BiAywsa7z+uXaapI0WPiNEIN2
         xYurTWq7Vuo8HrBQaeEzXCMEGA27/vW97vRYC2U9pTOkepUYpTbHjrTJjbKUb4nmrFuu
         bKGTE90OMX8RqnCmlESML1SKSVkVZ1RzSxXEdsvuOjJYEyq854vI3FsIqHl2KEiBEsFI
         y2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687668641; x=1690260641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAXKmRxn/lGVEXnXeDsvJ+fu3YmCBSEAvX8M4/5L5VA=;
        b=Lnuc7976fANKCCuEsS3tSJ1AdWmv9h33XvbxkV9CRwYJGH5Eubor2CUNQtel3dgisp
         ENJGUbCcouYGgvZGCECjFUPRANvTrE99G4iHT/PCmS9ftEDPTlOQiRvxvwyp+35EkeDN
         A/D95c1umrYY2wkIZ9TCLy9qR/7vMf3nl95PrF6udnB2yITe2cb4GwTaBKE+aaR9B50w
         3PLCgyZoLf/RhCqFL79IbXDCehorDGFmhm0GqJn6Ju5ZOyQMLh/QdTklvkRJc+q94K2x
         UVchlCZ0t89x3HCF01nLAS0WAVEyCbAkf9aftWG+I9aqMCtLfcIg3ZeyHBLdOdrD1AgU
         Ikww==
X-Gm-Message-State: AC+VfDwiKGozdhbrA1NmJhw4Z2WtQVC9TYTFTzcskZn0qkybq+mv3GJL
        t4kUvhlEN7YPM3P9y+gVont3hqQ/jyhOl4MEF7U=
X-Google-Smtp-Source: ACHHUZ5krj7H+JI/eDq82uf9J7X5Pm708dBg2kBu8l29Vrj5oetxbAmav2MRNxB9fkkFEETINthtPQ==
X-Received: by 2002:a9d:7f89:0:b0:6b7:2420:7b52 with SMTP id t9-20020a9d7f89000000b006b724207b52mr7750977otp.24.1687668641460;
        Sat, 24 Jun 2023 21:50:41 -0700 (PDT)
Received: from ?IPV6:2409:8949:3a13:39f5:bd89:ebd9:ff00:5efd? ([2409:8949:3a13:39f5:bd89:ebd9:ff00:5efd])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79255000000b00665a76a8cfasm1707206pfp.194.2023.06.24.21.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 21:50:40 -0700 (PDT)
Message-ID: <a82fd11d-d346-4cba-fdbb-982359fb9faa@bytedance.com>
Date:   Sun, 25 Jun 2023 12:50:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3] blk-throttle: Fix io statistics for cgroup v1
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        andrea.righi@canonical.com
References: <20230507170631.89607-1-hanjinke.666@bytedance.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230507170631.89607-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Jens

Can you consider merging this patch？I think this is a fix. It also
Acked-by Tejun, Muchun Song and Tested-by Andrea Righi.

在 2023/5/8 上午1:06, Jinke Han 写道:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1, and these statistics
> are done in the blk-throttle code. But the current code only counts the
> bios that are actually throttled. When the user does not add the throttle
> limit, the io stats for cgroup v1 has nothing. I fix it according to the
> statistical method of v2, and made it count all ios accurately.
> 
> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> ---
>   block/blk-cgroup.c   | 6 ++++--
>   block/blk-throttle.c | 6 ------
>   block/blk-throttle.h | 9 +++++++++
>   3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 0ce64dd73cfe..5b29912a0ee2 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2048,6 +2048,9 @@ void blk_cgroup_bio_start(struct bio *bio)
>   	struct blkg_iostat_set *bis;
>   	unsigned long flags;
>   
> +	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> +		return;
> +
>   	/* Root-level stats are sourced from system-wide IO stats */
>   	if (!cgroup_parent(blkcg->css.cgroup))
>   		return;
> @@ -2079,8 +2082,7 @@ void blk_cgroup_bio_start(struct bio *bio)
>   	}
>   
>   	u64_stats_update_end_irqrestore(&bis->sync, flags);
> -	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
> +	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
>   	put_cpu();
>   }
>   
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 9d010d867fbf..7397ff199d66 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2178,12 +2178,6 @@ bool __blk_throtl_bio(struct bio *bio)
>   
>   	rcu_read_lock();
>   
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> -		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> -				bio->bi_iter.bi_size);
> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> -	}
> -
>   	spin_lock_irq(&q->queue_lock);
>   
>   	throtl_update_latency_buckets(td);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index ef4b7a4de987..d1ccbfe9f797 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
>   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>   	int rw = bio_data_dir(bio);
>   
> +	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> +		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> +			bio_set_flag(bio, BIO_CGROUP_ACCT);
> +			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> +					bio->bi_iter.bi_size);
> +		}
> +		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> +	}
> +
>   	/* iops limit is always counted */
>   	if (tg->has_rules_iops[rw])
>   		return true;
