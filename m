Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C515F82ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 06:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJHEVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 00:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHEVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 00:21:38 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C81D77D7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 21:21:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 78so6187106pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsvYzD8csLN9IeUNf2gCwuuY/70zke74chneBqizKgo=;
        b=lp4jNDBitdbT9aePSHmYfAaSqV3KlCf7y2QCVnKCc3jJerXBN5vwCB4ybkFwT8xVNF
         195yOEGEjaBCegUejYUOprOMEC3Nz6NoD8FrLgVQuWyuKruzZs70Yvgx+Fo0Jlx8HwsS
         zXH/mZigE04VRmcW27jGTz2zyYaDWtrjZj2Lfaa/Z7xUGK4iGV69Mom/oqywJAPCb/HE
         tr7KHt0Wzq8EXqBBp47oaksmPJoJgcPVSl0vzmeRyBhloD6clHwSAlM9/UgXMsRPit2V
         nRwoh8Kk7rIt5u02TgIeNmF14jfANYioXcOur/RMC9WjWl7bEa/03YBabDQyxiRYdChl
         4+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsvYzD8csLN9IeUNf2gCwuuY/70zke74chneBqizKgo=;
        b=uY1P7ZakgxLabcEXEHGiFAmN/uxNFrvYF07ewIIAbybQbjxmhirico/d0L6NzbTqyL
         71vLZRClGC/+ChJSM/7St6nsy57HjGsjknR73y6YcLdT4AOI1Dxd+zNt1HuljFtPnPx6
         J8XLV9vPaSQCN6dkf2YzWnEqwdhA/av7MfyCBnB2WATrzM9WFLjx/QbpnnFhoLqcaOHe
         VboPPyGYvmF/V6Va9j2oMUCewYnY7xBTay09bhYdGka+iLw0vmfGpsi5mElJ8xq2XbjT
         1ZiRg0iJ9ec3XxWYU/cMAq81UxOh8X1dRlIkh5xOn4vE0EhCs+7kYoYC8XWp6QA3gvHQ
         C0GQ==
X-Gm-Message-State: ACrzQf3MbyvtZXua/CIbnYytg34tt1J3FroHPn2tJHVmuzGVgDPFL2zH
        K4oZAF1l8qaDoywyNTqdcitsni4F41H3TADm
X-Google-Smtp-Source: AMsMyM792XUEFcT/zqSQkc6cMxM+d6PeGOQAzMh/85CMbv96hC9zRkzrqumLaO7VTDZsVvb8oiep2Q==
X-Received: by 2002:a65:6e9a:0:b0:44c:2476:12e0 with SMTP id bm26-20020a656e9a000000b0044c247612e0mr7583515pgb.159.1665202894812;
        Fri, 07 Oct 2022 21:21:34 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id b24-20020aa79518000000b00560bb4a57f7sm2533696pfp.179.2022.10.07.21.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 21:21:33 -0700 (PDT)
Date:   Sat, 8 Oct 2022 13:21:26 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: move PG_slab flag to page_type
Message-ID: <Y0D6xi0HBqfLBvvK@hyeyoo>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
 <Yy+NCJ525S+HzP4k@casper.infradead.org>
 <Y0AreJczk6FdiKxr@hyeyoo>
 <Y0BpuxUb+Y8BKHIM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0BpuxUb+Y8BKHIM@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 07:02:35PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 07, 2022 at 10:36:56PM +0900, Hyeonggon Yoo wrote:
> > > First, you say that folio_mapped() returns false for slab pages.  That's
> > > only true for order-0 slab pages.  For larger pages,
> > > 
> > >         if (!folio_test_large(folio))
> > >                 return atomic_read(&folio->_mapcount) >= 0;
> > >         if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
> > >                 return true;
> > > 
> > > so that's going to depend what folio_mapcount_ptr() aliases with.
> > 
> > IIUC it's true for order > 0 slab too.
> > 
> > As slab pages are not mapped to userspace at all,
> > entire compound page nor base pages are not mapped to userspace.
> > 
> > AFAIK followings are true for order > 0 slab:
> >         - (first tail page)->compound_mapcount is -1
> 
> That's the part I wasn't sure of.  I think we do, in
> prep_compound_head().

Right, exactly!

> 
> >         - _mapcount of base pages are -1
> > 
> > So:
> >         folio_mapped() and page_mapped() (if applied to head page)
> >         returns false for larger pages with this patch.
> > 
> > I wrote simple testcase and did check that folio_mapped() and page_mapped()
> > returns false for both order-0 page and larger pages. (and SLAB
> > returned true for them before)

FYI, This is still true even after fixing my mistaken test case (see below)

> > 
> > > Second, this patch changes the behaviour of PageSlab() when applied to
> > > tail pages.
> > 
> > Altough it changes the way it checks the flag,
> > 
> > it does not change behavior when applied to tail pages - PageSlab() on tail
> > page returns false with or without this patch.
> 
> Really?  It seems to me that it returns true at the moment.  Look:
> 
> __PAGEFLAG(Slab, slab, PF_NO_TAIL)
> 
> #define PF_NO_TAIL(page, enforce) ({                                    \
>                 VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
>                 PF_POISONED_CHECK(compound_head(page)); })
> 
> so AFAICS, PageSlab checks the Slab bit on the head page, not the
> tail page.

You are right. I misunderstood it due to my mistakenly written test case
(without passing __GFP_COMP... how silly of me :D)

Hmm okay, then I will implement PF_NO_TAIL policy that works on page_type.

> 
> > If PageSlab() need to return true for tail pages too,
> > we may make it check page_type at head page.
> > 
> > But I'm not sure when it the behavior is needed.
> > Can you please share your insight on this?
> 
> There are tools like tools/vm/page-types.c which expect PageSlab to
> return true for tail pages.
>
> > > Which raises the further question of what PageBuddy(),
> > > PageTable(), PageGuard() and PageIsolated() should do for multi-page
> > > folios, if that is even possible.
> > 
> > For users that uses real compound page like slab, we can make it check
> > page_type of head page. (if needed)
> > 
> > But for cases David described, there isn't much thing we can do
> > except making them to use real compound pages.
> > 
> > > Third, can we do this without that awkward __u16 thing?  Perhaps
> > > 
> > > -#define PG_buddy        0x00000080
> > > -#define PG_offline      0x00000100
> > > -#define PG_table        0x00000200
> > > -#define PG_guard        0x00000400
> > > +#define PG_buddy        0x00010000
> > > +#define PG_offline      0x00020000
> > > +#define PG_table        0x00040000
> > > +#define PG_guard        0x00080000
> > > +#define PG_slab         0x00100000
> > > 
> > > ... and then use wrappers in slab.c to access the bottom 16 bits?
> > 
> > Definitely! I prefer that way and will adjust in RFC v2.
> > 
> > Thank you for precious feedback.
> 
> No problem.  I suggested (in an off-list email) that you consider counting
> 'active' by subtraction rather than addition because I have a feeling that
> 
> int active(struct slab *slab)
> {
> 	return ~(slab->page_type | PG_slab);
> }
> 
> would be better than
> 
> int active(struct slab *slab)
> {
> 	return slab->page_type & 0xffff;
> }
> 
> at least in part because you don't have to clear the bottom 16 bits of
> page_type when you clear PG_slab, and you don't have to re-set them
> when you set PG_slab.

Yeah, I was wondering what is the benefit of the that approach. 
After implementing both approach, your suggestion seems better to me too.

Many thanks, Matthew!

-- 
Hyeonggon
