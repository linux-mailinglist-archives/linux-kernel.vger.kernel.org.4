Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D6618584
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiKCRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKCRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:00:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6AC1143
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:00:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q9so2186004pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYg+m5oLj8gc4kPsOwH3pQu6lmRCj0M+7nnvmSQAEtk=;
        b=ek0Tnf71xlL+BT9a8ZACJoSOdDzV2J9rf1Ooq0ml9b5EbDqxl048g53h5TgacjwdaP
         zsOwcUq2uVEFaWBGra1dV/rvd5Nw3JSSfJsezjJMKbm5TrSNVf/BUgH3/mEu8XQZ7obG
         pLHcgHeNhxJ7Vi6R1IhLq1FMJ9hA+HHrPEVBwYQkH1HszDmKU/7pZ5bd1UPiRxwRy8Wd
         +IiXtL1uUij+BveVQkFmhEzPNqu0SaAawTIkm6xcENDyNGYJJPly3TWiapjhgxldwLQs
         ikcsm1A96ge1R8rWBxdrGT8F0uctLpNc4yw5y5OHweeSwtAR0kQer2GS2yCVB2xzz2sQ
         DzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYg+m5oLj8gc4kPsOwH3pQu6lmRCj0M+7nnvmSQAEtk=;
        b=dnbbKHraxnh54Rfeo/CM0jizugwyy1T8a9dfVoJxLc3oCIIo9lPwuG1wE8e2yOsBxw
         wi/TnMatkzkbJxosOfc+Khb05a4uTyEq7LAqC0IaPpN4ZAmklW0DCKFcEkb/+sUdIN97
         1QMxIYRk1f311eIpbnbSrXTz1Ota10nTBBUS1xmn7jtVlNKvEhxhezigEGORTlKYXUt0
         kW+rhT8nPv3FXOqeT+FG8u6A7sppwp+CViM8tadXMlpD3icgkBz7kGG1lx2OEGvdxv5C
         LzaCuPDfAS4kn204zZm6sVMbwTBkUSdEkWM+b6+IWi7LM70azP2BvVV7nM4BsiFFou/Q
         ipHQ==
X-Gm-Message-State: ACrzQf04XTpxeHa+kAMRK5bajarG/4goVhVGoVFSgzjcz0rethoG63zB
        NSnYfZ95c2FoJIXQEhbHKPk=
X-Google-Smtp-Source: AMsMyM6Li/qF0VF08Jhehm/+qV40PSQ2spm6kzzjk6TZWN5wstVGu+YbrXpnEhkYxX/OI6nVD4nJlw==
X-Received: by 2002:a63:90c7:0:b0:442:87:3a38 with SMTP id a190-20020a6390c7000000b0044200873a38mr27164332pge.216.1667494835812;
        Thu, 03 Nov 2022 10:00:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b0016d72804664sm880085pln.205.2022.11.03.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:00:35 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 10:00:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2PzseskzPelrZum@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2M0t5etyJiUfeQi@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:25:43PM +0900, Sergey Senozhatsky wrote:
> On (22/11/02 14:06), Minchan Kim wrote:
> > On Tue, Oct 18, 2022 at 01:55:28PM +0900, Sergey Senozhatsky wrote:
> > > Allow zram to recompress (using secondary compression streams)
> > > pages. We support three modes:
> > > 
> > > 1) IDLE pages recompression is activated by `idle` mode
> > > 
> > > 	echo idle > /sys/block/zram0/recompress
> > > 
> > > 2) Since there may be many idle pages user-space may pass a size
> > > watermark value (in bytes) and we will recompress IDLE pages only
> > > of equal or greater size:
> > > 
> > > 	echo 888 > /sys/block/zram0/recompress
> > 
> > Hmm, how about having seperate knob for threshold?
> 
> Per-my understanding this threshold can change quite often,
> depending on memory pressure and so on. So we may force
> user-space to issues more syscalls, without any gain in
> simplicity.

Sorry, didn't understand your point. Let me clarify my idea.
If we have separate knob for recompress thresh hold, we could
work like this.

# recompress any compressed pages which is greater than 888 bytes.
echo 888 > /sys/block/zram0/recompress_threshold

# try to compress any pages greather than threshold with following
# algorithm.

echo "type=lzo priority=1" > /sys/block/zram0/recompress_algo
echo "type=zstd priority=2" > /sys/block/zram0/recompress_algo
echo "type=deflate priority=3" > /sys/block/zram0/recompress_algo

> 
> > recompress_threshold
> > 
> > With that, we could make rescompress 888 and idle/huge
> > as well as only 888.
> > 
> >   echo 888 > /sys/block/zram0/recompress_threshold
> >   echo 1 > /sys/block/zram0/recompress
> > 
> >   or
> > 
> >   echo 888 > /sys/block/zram0/recompress_threshold
> >   echo idle > /sys/block/zram0/recompress
> > 
> > or we can introduce the threshold with action item.
> >   
> >   echo "idle 888" > /sys/block/zram0/recompress
> >   echo "huge 888" > /sys/block/zram0/recompress
> >   echo "normal 888" > /sys/block/zram0/recompress
> 
> I like the latter one, when threshold is an optional argument.
> I probably would even go a bit further and add keywords:
> 
> 	type=STRING threshold=INT

Yeah, kerwords would be better. Let's discuss we need a threshold
optional argument for each algo or just have one threshold
for every secondary algorithm or both.

> 
> > > 3) HUGE pages recompression is activated by `huge` mode
> > > 
> > > 	echo huge > /sys/block/zram0/recompress
> > > 
> > > 4) HUGE_IDLE pages recompression is activated by `huge_idle` mode
> > > 
> > > 	echo huge_idle > /sys/block/zram0/recompress
> > > 
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  drivers/block/zram/Kconfig    |  15 +++
> > >  drivers/block/zram/zram_drv.c | 196 +++++++++++++++++++++++++++++++++-
> > >  drivers/block/zram/zram_drv.h |   2 +
> > >  3 files changed, 210 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> > > index d4100b0c083e..3e00656a6f8a 100644
> > > --- a/drivers/block/zram/Kconfig
> > > +++ b/drivers/block/zram/Kconfig
> > > @@ -78,3 +78,18 @@ config ZRAM_MEMORY_TRACKING
> > >  	  /sys/kernel/debug/zram/zramX/block_state.
> > >  
> > >  	  See Documentation/admin-guide/blockdev/zram.rst for more information.
> > > +
> > > +config ZRAM_MULTI_COMP
> > > +	bool "Enable multiple per-CPU compression streams"
> > 
> > per-CPU is implementation detail. Let's do not mention it.
> 
> OK.
> 
> > > +	depends on ZRAM
> > > +	help
> > > +	This will enable per-CPU multi-compression streams, so that ZRAM
> > 
> >       indentation
> 
> OK. A question: does this matter? I don't see any problems in menuconfig.
> 
> > > +	can re-compress IDLE/huge pages, using a potentially slower but
> > > +	more effective compression algorithm. Note, that IDLE page support
> > > +	requires ZRAM_MEMORY_TRACKING.
> > > +
> > > +          echo TIMEOUT > /sys/block/zramX/idle
> > > +          echo SIZE > /sys/block/zramX/recompress
> > > +
> > > +	SIZE (in bytes) parameter sets the object size watermark: idle
> > > +	objects that are of a smaller size will not get recompressed.
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index 94c62d7ea818..da11560ecf70 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -1282,6 +1282,12 @@ static void zram_free_page(struct zram *zram, size_t index)
> > >  		atomic64_dec(&zram->stats.huge_pages);
> > >  	}
> > >  
> > > +	if (zram_test_flag(zram, index, ZRAM_RECOMP))
> > > +		zram_clear_flag(zram, index, ZRAM_RECOMP);
> > > +
> > > +	if (zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
> > > +		zram_clear_flag(zram, index, ZRAM_RECOMP_SKIP);
> > 
> > Let's squeeze the comp algo index into meta area since we have
> > some rooms for the bits. Then can we could remove the specific
> > recomp two flags?
> 
> What is meta area?

zram->table[index].flags

If we squeeze the algorithm index, we could work like this
without ZRAM_RECOMP_SKIP.

read_block_state
    zram_algo_idx(zram, index) > 0 ? 'r' : '.');

zram_read_from_zpool
    if (zram_algo_idx(zram, idx) != 0)
        idx = 1;

zram_recompress
    ..
    we don't need to set ZRAM_RECOMP since every meta will have the algo
    idx.

zram_free_page
    zram_clear_algo(zram, index);

recompress_store
    int algo_idx = zram_algo_idx(zram, index);

    if (algo_idx == max_algo_idx)
        goto next

> 
> > I am thinking the feature to work incoming pages on the fly,
> > not only for recompress manual knob so it would be good
> > if we could make the interface abstract to work something
> > like this(I may miss something why we couldn't. I need more
> > time to look into then)
> >
> > zram_bvec_write:
> > 
> >     for (i = 0; i < MAX_COMP_ALGO; i++) {
> >         zstrm = zcomp_stream_get(i);
> >         zcomp_compress(src, &comp_len);
> >         if (comp_len > threshold) {
> >             zcomp_stream_put(i);
> >             continue;
> >         }
> >         break;
> >     }
> > 
> > zram_bvec_read:
> >     algo_idx = zram_get_algo_idx(zram, index);
> >     zstrm = zcomp_stream_get(zram, algo_idx);
> >     zcomp_decompress(zstrm);
> >     zcomp_stream_put(zram, algo_idx);
> 
> Hmm. This is something that should not be enabled by default.

Exactly. I don't mean to enable by default, either.

> N compressions per every stored page is very very CPU and
> power intensive. We definitely want a way to have recompression
> as a user-space event, which gives all sorts of flexibility and
> extensibility. ZRAM doesn't (and should not) know about too many
> things, so ZRAM can't make good decisions (and probably should not
> try). User-space can make good decisions on the other hand.
> 
> So recompression for us is not something that happens all the time,
> unconditionally. It's something that happens sometimes, depending on
> the situation on the host.

Totally agree. I am not saying we should enable the feature by default
but at lesat consider it for the future. I have something in mind to
be useful later.

> 
> [..]
> > > +static int zram_recompress(struct zram *zram, u32 index, struct page *page,
> > > +			   int size_watermark)
> > > +{
> > > +	unsigned long handle_prev;
> > > +	unsigned long handle_next;
> > > +	unsigned int comp_len_next;
> > > +	unsigned int comp_len_prev;
> > 
> > How about orig_handle and new_nandle with orig_comp_len and new_comp_len?
> 
> No opinion. Can we have prev and next? :)

prev and next gives the impression position something like list.
orig and new gives the impression stale and fresh.

We are doing latter here.
