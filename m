Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52D741D76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjF2BCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2BCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:02:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5662728
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:02:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666683eb028so120101b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1688000551; x=1690592551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2Qe9k1wI4NImJPimcE18OoLTXPGy2kmsiDzrgzIU0o=;
        b=J9tin5TAWI6Bgtay2dLaEy44IRQA3vhqvyU+2EoptZC8ahj7cwaWWPEuofaZoRdb1L
         Ln+kLqFTIG8TETXYx0275C8HLM7BNq+hiek1hmjXkjGlwk1Fh/awidoFpUP39JlhTfqI
         XMUtdCGTn6hGybZ2a9kRZufwbNW4VZXvenqxeA1a330V+3x/yz0MFolEvZqsQo4RGr3R
         hjaeFmuPbA6Qw5xVG9aJ4PJ9JX/aUzMO85m5YIG4wdRCsGLTjW+BBBsYKumeGXenujmF
         aNvbaniIn25eUCcm4CWktgsiwfzMd8gomlhIpN5WEvFXOzsPB3nDb8FfTPHTBjvI9Qld
         PvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688000551; x=1690592551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2Qe9k1wI4NImJPimcE18OoLTXPGy2kmsiDzrgzIU0o=;
        b=QVEvYuZKkaElimNAaEBXOo6MPns+5dr8eYtOWwwgrNsv1zPueyiCemVY1PVnMhz+HQ
         nrHvJywiXnEGaSgfvUrQ5IrNjjyeAAVgV98LVwA2OpNHmyHQ0D3a3RwaR9tcN98ORK2+
         zGUSUl+xnCq0MVfyVvBYF6ZIjRwb9rnC3ozCBVLvsL63UzFtpqcYsLaVaYqCp0WAMUQF
         KBq8H6WbkuptC/Xaqg8Wxm7NBzHBRFkdlc4jDclKxtAPZQ2xnVWzPcFC2nGNTfL2igjp
         OwDrgq5MEcx/wa+QCWlJgMRceby4oyaDwXtv1HH+pp0q4mF6oWn9J2F0mn6CTMtr9Ot0
         oe0A==
X-Gm-Message-State: AC+VfDyePZyfHc8yUFuiFxx2F5x2qfWCeu79I4xgnykyZNeFN0hrtkZ5
        BM0G0er7z//gctwq07/JVcAkKg==
X-Google-Smtp-Source: ACHHUZ6+/87qKROJEzGsaCEegkUINIJxHr91lwvVXGaDx8yj/qGTlZI7YYxGc8Bj+5xHIEvscdyZ9g==
X-Received: by 2002:a05:6a00:3996:b0:67e:bf65:ae61 with SMTP id fi22-20020a056a00399600b0067ebf65ae61mr5430342pfb.28.1688000551024;
        Wed, 28 Jun 2023 18:02:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id d14-20020aa78e4e000000b0067acbc74977sm4282819pfr.96.2023.06.28.18.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 18:02:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEg3I-00HRAH-0N;
        Thu, 29 Jun 2023 11:02:28 +1000
Date:   Thu, 29 Jun 2023 11:02:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-ID: <ZJzYJEVJlymbLxco@dread.disaster.area>
References: <20230628185548.981888-1-willy@infradead.org>
 <ZJyr6GyVyvHxOpNB@dread.disaster.area>
 <ZJzJ9/HhKup+FKey@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJzJ9/HhKup+FKey@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:01:59AM +0100, Matthew Wilcox wrote:
> On Thu, Jun 29, 2023 at 07:53:44AM +1000, Dave Chinner wrote:
> > On Wed, Jun 28, 2023 at 07:55:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > > nr_to_write is a count of pages, so we need to decrease it by the number
> > > of pages in the folio we just wrote, not by 1.  Most callers specify
> > > either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> > > might end up writing 512x as many pages as it asked for.
> > > 
> > > Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  mm/page-writeback.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > index 1d17fb1ec863..d3f42009bb70 100644
> > > --- a/mm/page-writeback.c
> > > +++ b/mm/page-writeback.c
> > > @@ -2434,6 +2434,7 @@ int write_cache_pages(struct address_space *mapping,
> > >  
> > >  		for (i = 0; i < nr_folios; i++) {
> > >  			struct folio *folio = fbatch.folios[i];
> > > +			unsigned long nr;
> > >  
> > >  			done_index = folio->index;
> > >  
> > > @@ -2471,6 +2472,7 @@ int write_cache_pages(struct address_space *mapping,
> > >  
> > >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > >  			error = writepage(folio, wbc, data);
> > > +			nr = folio_nr_pages(folio);
> > 
> > This should really be done before writepage() is called, right? By
> > the time the writepage() returns, the folio can be unlocked, the
> > entire write completed and the folio partially invalidated which may
> > try to split the folio...
> > 
> > Even if this can't happen (folio refcount is elevated, right?), it
> > makes much more sense to me to sample the size of the folio while it
> > is obviously locked and not going to change...
> 
> It can't change because of the refcount we hold (that's put in the call
> to folio_batch_release()).  I didn't want to call it before the call to
> writepage() because that makes the compiler stick it on the stack instead
> of a local variable.

I don't care for micro-optimisations when the result is code
that looks dodgy and suspect and requires lots of additional
thinking about to determine that it is safe.

> Also, when we transform this into an iterator (see
> patches posted yesterday), we'd have to stash it away in the iterator.

That's no big deal, either.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
