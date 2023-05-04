Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963A96F77D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEDVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEDVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:13:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AFC4EC8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:13:05 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D10653F12F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 21:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683234782;
        bh=8/IuvB7q0MpadpI+BtBqI9cgeVSD1cWHWWl6VaVHMkI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=WEXQ81HvjSxQFkLOc/oIs8XXHteowDdp/+558iHFsRkT56hUEVNsl38n6j3t0ds3E
         57zl70/Z2M+AEQTDDej0C57ikM3WtAYlrSXSOztdT88yRvG7XtOGt3Mg/duA9pWIJz
         Txg0dzXPfW8MRzomRzskdHqElqZaswONkzXUqYf7wHy5GkD0LGPBW8tP+tHWyONsHW
         LoOTvBhEqXybLSgAiNjBGQ4suWfkLVOm/7HdR1+qxsiede/JfY71ihSttecGmckTcv
         TjEUwNXDcpIUDZ1v7T7nVo2oqH95m7vk3fXFzV43n33gBwhqRoPjfHxYpw107NQH0J
         GJsaH+iJMli9Q==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94ec76d7a26so94770866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 14:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683234782; x=1685826782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/IuvB7q0MpadpI+BtBqI9cgeVSD1cWHWWl6VaVHMkI=;
        b=NcFz8pz+hQQF6MZ1N4Q2OvpMTcTWWT5k669AVjLXv4BO4Fzd+OXPa/r3HcupLEnNNR
         5lME4lUOT5z26n1BQV0FKFnkBr+GXOB4Z8krbSIyHKSkzdag7ijDcZwso3+dHpiU14ZG
         ts447nxrjjUKch8jdlJ1FBf2LgpjLj2i9DpLvO/guuwbNj8OBChqAgZ+xAQVAxFhPBsu
         M4v6vWr7V40Jke1dSCV2P6DVr/H7DUCOuLi9Nkd/0N3S/MQdd6HGxRRgzHSmE2xNBE1D
         NIJ8poSIsXR/twxvMijTh8L8HdGlKg+QVtqOJGUa6sdrUa+tGIdLdOqJGGMHkAqoHPGv
         wHJQ==
X-Gm-Message-State: AC+VfDyPQ6nhm61zLgiLIAXfD4ZR0fcl0xmK0YANcmnjQ5z0dfa7cZd4
        JMAlntWjUnfB87QJkK29pHKfd8s5RQGOHVb47g2ZYVp7M/iJIhIjAQhoczM+p/5Lv8t6EA8G+qt
        kdDfORlERr2G/HpzOV7/nSWMda17soH4iTJiRPw9BCg==
X-Received: by 2002:a17:907:846:b0:94e:f738:514f with SMTP id ww6-20020a170907084600b0094ef738514fmr162681ejb.13.1683234782536;
        Thu, 04 May 2023 14:13:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ANyGyXAGB71H/AEoG1ZDXxwhyovwMjLeaMQ9fUMZjmJ05dtMIpeeSciNh8ivLL2x5tUC2rQ==
X-Received: by 2002:a17:907:846:b0:94e:f738:514f with SMTP id ww6-20020a170907084600b0094ef738514fmr162673ejb.13.1683234782206;
        Thu, 04 May 2023 14:13:02 -0700 (PDT)
Received: from localhost ([62.168.35.125])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090670c800b0095fbb1b72c2sm39879ejk.63.2023.05.04.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:13:01 -0700 (PDT)
Date:   Thu, 4 May 2023 23:13:01 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] blk-throttle: Fix io statistics for
 cgroup v1
Message-ID: <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
 <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
 <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:08:53PM +0800, hanjinke wrote:
> Hi
> 
> Sorry for delay（Chinese Labor Day holiday).

No problem, it was also Labor Day in Italy. :)

> 
> 在 2023/4/29 上午3:05, Andrea Righi 写道:
> > On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
> > > From: Jinke Han <hanjinke.666@bytedance.com>
> > > 
> > > After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> > > blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> > > the only stable io stats interface of cgroup v1, and these statistics
> > > are done in the blk-throttle code. But the current code only counts the
> > > bios that are actually throttled. When the user does not add the throttle
> > > limit, the io stats for cgroup v1 has nothing. I fix it according to the
> > > statistical method of v2, and made it count all ios accurately.
> > > 
> > > Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> > > Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> > 
> > Thanks for fixing this!
> > 
> > The code looks correct to me, but this seems to report io statistics
> > only if at least one throttling limit is defined. IIRC with cgroup v1 it
> > was possible to see the io statistics inside a cgroup also with no
> > throttling limits configured.
> > 
> > Basically to restore the old behavior we would need to drop the
> > cgroup_subsys_on_dfl() check, something like the following (on top of
> > your patch).
> > 
> > But I'm not sure if we're breaking other behaviors in this way...
> > opinions?
> > 
> >   block/blk-cgroup.c   |  3 ---
> >   block/blk-throttle.h | 12 +++++-------
> >   2 files changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 79138bfc6001..43af86db7cf3 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
> >   	struct blkg_iostat_set *bis;
> >   	unsigned long flags;
> > -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> > -		return;
> > -
> >   	/* Root-level stats are sourced from system-wide IO stats */
> >   	if (!cgroup_parent(blkcg->css.cgroup))
> >   		return;
> > diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> > index d1ccbfe9f797..bcb40ee2eeba 100644
> > --- a/block/blk-throttle.h
> > +++ b/block/blk-throttle.h
> > @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
> >   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> >   	int rw = bio_data_dir(bio);
> > -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> > -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> > -			bio_set_flag(bio, BIO_CGROUP_ACCT);
> > -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> > -					bio->bi_iter.bi_size);
> > -		}
> > -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> > +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> > +		bio_set_flag(bio, BIO_CGROUP_ACCT);
> > +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> > +				bio->bi_iter.bi_size);
> >   	}
> > +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> 
> It seems that statistics have been carried out in both v1 and v2，we can get
> the statistics of v2 from io.stat, is it necessary to count v2 here?
> 

I think this code is affecting (and should affect) only v1, stats for v2
are accounted via blk_cgroup_bio_start() in a different way. And the
behavior in v2 is the same as with this patch applied, that means io
stats are always reported even if we don't set any io limit.

Thanks,
-Andrea
