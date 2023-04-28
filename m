Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F536F1E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbjD1TFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbjD1TFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:05:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE930D3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:05:13 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2D1D3F429
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682708710;
        bh=5xdGcBrePTmDfHc6Jzw3JTLHbSAztKlpGArx8vpNt2k=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=rU3GquilWoTt+E66nkoXnDUfQpugdh42eX9qLk43mWrbcLE23a4kXk4GhJjPtiE2+
         OaUZ70g0ZpTIMmqyWhOik/GpIpfGeHAEyDAu5Dbe8wxTtkBSXAX/o3y5DZblYSAfBO
         A/CDMv9FMuq4+Y7iDq94d5NxUWMyCEkHWEegxBArMhblt1+mZvnqUt+BP+HHp3nZyj
         14N4wGPAxCUy4Q5qpoWeVRSYzb1O7tGFaGXK+ys3blTZmTA32aEGC0fjVWdhjv6SBr
         SA7PNFM3OGGXr7zUtEL6wDa248WYURapdfzYEjWe2eNlxOHXFNV9XAHmrivQfeHnZ3
         vw4p1wAkH18JQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-506905b850cso60464a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708710; x=1685300710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xdGcBrePTmDfHc6Jzw3JTLHbSAztKlpGArx8vpNt2k=;
        b=QdiozboACtuB9Zh4hbPne1Wmna+Bp873ueRYLWnsI4YEVAT19cR55bmlnQEObe8RCF
         NTRPZmtIKnpnP2WDlczXu0SSnvLAAfLWed+Ja8KtS/KJC3I2e8JQLQOhAtdYGMeVJ2ep
         vusNg6U1ahFMF0hhM1Mk6DAfrWZIIx3d9Auk+bdgLFoVVXTGKnpe7x34j/ap0DUbSAu6
         dIDff+MZ4W44k+K3UiuZQWZ4dkGPpxIDWs2aBGQxXyPomW1I/I3MablFKY+On9pcU14w
         d6mcUavhQB3bB3EdDej/1VLTLWFOsBMBtcEGg0eYumE3GphjHrGS/6YARdIl/H3RcMrq
         dq0g==
X-Gm-Message-State: AC+VfDzYF5FpFhlgC/gi0BvtAyKs1d/FsMWelCWq3Fdnqu/6cmzXSk2/
        VBn2+AUs6Yi04x3IZRmZuUi8epO6jiQBfEzsx/rPRDBP5dPgDLppAUlBdPQiOBSLYsErlRAtwsj
        QR/3RicjLJbNkWmk+VfarmiA95+XTe7BgQmB9XFw6+KXT8BjnLnO2
X-Received: by 2002:a17:907:16aa:b0:94f:9f76:c74f with SMTP id hc42-20020a17090716aa00b0094f9f76c74fmr7738591ejc.52.1682708710276;
        Fri, 28 Apr 2023 12:05:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pi57scEQWERlmKMoLu2PGjbl7zecivIyoR8ReiRJEuRABO1ah119lQPAYBiWFcA3rwjRQeg==
X-Received: by 2002:a17:907:16aa:b0:94f:9f76:c74f with SMTP id hc42-20020a17090716aa00b0094f9f76c74fmr7738571ejc.52.1682708709893;
        Fri, 28 Apr 2023 12:05:09 -0700 (PDT)
Received: from localhost (host-87-1-129-21.retail.telecomitalia.it. [87.1.129.21])
        by smtp.gmail.com with ESMTPSA id wy12-20020a170906fe0c00b0095f07223918sm4265757ejb.138.2023.04.28.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:05:09 -0700 (PDT)
Date:   Fri, 28 Apr 2023 21:05:08 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: Fix io statistics for cgroup v1
Message-ID: <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401094708.77631-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
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
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Thanks for fixing this!

The code looks correct to me, but this seems to report io statistics
only if at least one throttling limit is defined. IIRC with cgroup v1 it
was possible to see the io statistics inside a cgroup also with no
throttling limits configured.

Basically to restore the old behavior we would need to drop the
cgroup_subsys_on_dfl() check, something like the following (on top of
your patch).

But I'm not sure if we're breaking other behaviors in this way...
opinions?

 block/blk-cgroup.c   |  3 ---
 block/blk-throttle.h | 12 +++++-------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 79138bfc6001..43af86db7cf3 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
-		return;
-
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(blkcg->css.cgroup))
 		return;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index d1ccbfe9f797..bcb40ee2eeba 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 	int rw = bio_data_dir(bio);
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
-			bio_set_flag(bio, BIO_CGROUP_ACCT);
-			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-					bio->bi_iter.bi_size);
-		}
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+		bio_set_flag(bio, BIO_CGROUP_ACCT);
+		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+				bio->bi_iter.bi_size);
 	}
+	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
 
 	/* iops limit is always counted */
 	if (tg->has_rules_iops[rw])

> ---
>  block/blk-cgroup.c   | 6 ++++--
>  block/blk-throttle.c | 6 ------
>  block/blk-throttle.h | 9 +++++++++
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bd50b55bdb61..33263d0d0e0f 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	struct blkg_iostat_set *bis;
>  	unsigned long flags;
>  
> +	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> +		return;
> +
>  	/* Root-level stats are sourced from system-wide IO stats */
>  	if (!cgroup_parent(blkcg->css.cgroup))
>  		return;
> @@ -2064,8 +2067,7 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	}
>  
>  	u64_stats_update_end_irqrestore(&bis->sync, flags);
> -	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
> +	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
>  	put_cpu();
>  }
>  
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 47e9d8be68f3..2be66e9430f7 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2174,12 +2174,6 @@ bool __blk_throtl_bio(struct bio *bio)
>  
>  	rcu_read_lock();
>  
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> -		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> -				bio->bi_iter.bi_size);
> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> -	}
> -
>  	spin_lock_irq(&q->queue_lock);
>  
>  	throtl_update_latency_buckets(td);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index ef4b7a4de987..d1ccbfe9f797 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
>  	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>  	int rw = bio_data_dir(bio);
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
>  	/* iops limit is always counted */
>  	if (tg->has_rules_iops[rw])
>  		return true;
> -- 
> 2.20.1
