Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2D5EA854
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiIZOYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiIZOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:23:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E7E5F92;
        Mon, 26 Sep 2022 05:34:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A50F71F999;
        Mon, 26 Sep 2022 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664192847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/Dwa7jmGj4R9AMOKFQFRa0wpNExY5Nn0h5gzI93m5Q=;
        b=qpUt7z34ITetIRwyKjRs9ItYJlZ5CuZJUYoj+fPxex2RQGQPYBucgu7Q0uMqaqxM0MNnDA
        qzV0zpnugAhsZbgBa7NTTMNMhIwohEF0hyu0awNhPqIVz1CIihm3chmPDI5hUzYK3x5jv9
        HZYsTPW71JJc1hWqJg4g1/BF8lyjNoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664192847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/Dwa7jmGj4R9AMOKFQFRa0wpNExY5Nn0h5gzI93m5Q=;
        b=efS8a39K9ZrBkDeaHwnEtkzMBW3HQJWELC8Oj99kOjXxZwZjQV3l9IH+Gxsv9P5KFr19Mp
        jnv/XNkn+UHlWfAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B9B7139BD;
        Mon, 26 Sep 2022 11:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1xYLIk+RMWONPAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 11:47:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B363CA0685; Mon, 26 Sep 2022 13:47:26 +0200 (CEST)
Date:   Mon, 26 Sep 2022 13:47:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v3 1/5] wbt: don't show valid wbt_lat_usec in sysfs while
 wbt is disabled
Message-ID: <20220926114726.ta2w3vcbxgkh3sov@quack3>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-2-yukuai3@huawei.com>
 <20220926094434.jrl6gnlbjqkex3wa@quack3>
 <6736753f-b5ae-39f1-b0c4-508b7f45d701@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6736753f-b5ae-39f1-b0c4-508b7f45d701@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-09-22 18:25:18, Yu Kuai wrote:
> Hi, Jan
> 
> 在 2022/09/26 17:44, Jan Kara 写道:
> > On Thu 22-09-22 19:35:54, Yu Kuai wrote:
> > > Currently, if wbt is initialized and then disabled by
> > > wbt_disable_default(), sysfs will still show valid wbt_lat_usec, which
> > > will confuse users that wbt is still enabled.
> > > 
> > > This patch shows wbt_lat_usec as zero and forbid to set it while wbt
> > > is disabled.
> > 
> > So I agree we should show 0 in wbt_lat_usec if wbt is disabled by
> > wbt_disable_default(). But why do you forbid setting of wbt_lat_usec?
> > IMHO if wbt_lat_usec is set, admin wants to turn on wbt so we should just
> > update rwb->enable_state to WBT_STATE_ON_MANUAL.
> 
> I was thinking that don't enable wbt if elevator is bfq. Since we know
> that performance is bad, thus it doesn't make sense to me to do that,
> and user might doesn't aware of the problem.

Yeah, I don't think it is a good idea (that is the reason why it is
disabled by default) but in priciple I don't see a reason why we should
block admin from enabling it.

								Honza

> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > Reported-and-tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> > > ---
> > >   block/blk-sysfs.c | 9 ++++++++-
> > >   block/blk-wbt.c   | 7 +++++++
> > >   block/blk-wbt.h   | 5 +++++
> > >   3 files changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > index e1f009aba6fd..1955bb6a284d 100644
> > > --- a/block/blk-sysfs.c
> > > +++ b/block/blk-sysfs.c
> > > @@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
> > >   static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
> > >   {
> > > +	u64 lat;
> > > +
> > >   	if (!wbt_rq_qos(q))
> > >   		return -EINVAL;
> > > -	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
> > > +	lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
> > > +
> > > +	return sprintf(page, "%llu\n", lat);
> > >   }
> > >   static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
> > > @@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
> > >   			return ret;
> > >   	}
> > > +	if (wbt_disabled(q))
> > > +		return -EINVAL;
> > > +
> > >   	if (val == -1)
> > >   		val = wbt_default_latency_nsec(q);
> > >   	else if (val >= 0)
> > > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > > index a9982000b667..68851c2c02d2 100644
> > > --- a/block/blk-wbt.c
> > > +++ b/block/blk-wbt.c
> > > @@ -422,6 +422,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
> > >   	rwb_wake_all(rwb);
> > >   }
> > > +bool wbt_disabled(struct request_queue *q)
> > > +{
> > > +	struct rq_qos *rqos = wbt_rq_qos(q);
> > > +
> > > +	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT;
> > > +}
> > > +
> > >   u64 wbt_get_min_lat(struct request_queue *q)
> > >   {
> > >   	struct rq_qos *rqos = wbt_rq_qos(q);
> > > diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> > > index 7e44eccc676d..e42465ddcbb6 100644
> > > --- a/block/blk-wbt.h
> > > +++ b/block/blk-wbt.h
> > > @@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *);
> > >   u64 wbt_get_min_lat(struct request_queue *q);
> > >   void wbt_set_min_lat(struct request_queue *q, u64 val);
> > > +bool wbt_disabled(struct request_queue *);
> > >   void wbt_set_write_cache(struct request_queue *, bool);
> > > @@ -125,6 +126,10 @@ static inline u64 wbt_default_latency_nsec(struct request_queue *q)
> > >   {
> > >   	return 0;
> > >   }
> > > +static inline bool wbt_disabled(struct request_queue *q)
> > > +{
> > > +	return true;
> > > +}
> > >   #endif /* CONFIG_BLK_WBT */
> > > -- 
> > > 2.31.1
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
