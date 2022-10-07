Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692A25F7918
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJGNhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJGNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:37:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DAFA5988
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:37:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 204so4894031pfx.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfzoSLkcHG9LxhIC2H734DevtfkcO6HZr+TJXAPvmGk=;
        b=qUb1WBEen0IFaBR9zTn1HDyMj4phtCAgJuAI40CPrxUlU3/zNLqoyUFIyh7ELug1wx
         nyJMPwmRpwtgw3iWk+pWNKGEYxVxf6lyjNBNMYzy/poT9C92afc91s8mI+IFxVPKizBt
         vQ+H4F2XHAA+AVd+YacaqaGAzYkMx/fcKzCK7Ffi+DtNvdirYDO/puKqCRfwZPrHTcUX
         4MU29UWhx9RNoIvgFD66R9idAscwie0/Gc7y9OIXe2cqjHIgAe0+BfYNMbdp/omhnGO9
         DBRWVoeW+6xoZ+EnDZA+Supp4abp2puEC2LVRs/smwVGP/R/zn6CkrUfkJpqDwNfRfGj
         yO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfzoSLkcHG9LxhIC2H734DevtfkcO6HZr+TJXAPvmGk=;
        b=EiPPBBeg40/E/rIf+ytS3jK4dlCE8cITvl8ikXhaXllU94fVHPQxv9MG+e+nNHTLrv
         1wt5idps0BW0WfA9lgPveioycaQNWX6gk1/zXa8ZAuDj4/LhKfl5v5G7Utny1PvMmWpv
         nE4DM/iarOTArpZ66NwkogCGbTrIFAVTo9bYmpKq/HxDA1LzXRP615dQCZ5Jd1j5uPhs
         Nuz8hrlTEddCXr1RMDBEgUkpWUuigRBrhRzBlYCNphyQyP1y6eqLPdUuucjJckEJ+liA
         nBtuBrF+H+pu/ysxZAYrisrovkBPizv2ZjFQsB5oTdxggA8X0L04rp/OydIJU0bAUn4d
         ZlJA==
X-Gm-Message-State: ACrzQf1nBEA14aXnD7LnZNNzuRNdb0KkCCTBW3EjVTy3syeJ/SHBPkV/
        KOxqNXk8Ggrpi0eGHW7kkNY=
X-Google-Smtp-Source: AMsMyM5GBGDJNZNzlcj466Gh/G4aXMY7ytb7E7CFnygImq45porGxQNgcdfzAv6nWyPfK9FxrISKlQ==
X-Received: by 2002:a05:6a00:1ace:b0:546:94a3:b235 with SMTP id f14-20020a056a001ace00b0054694a3b235mr5459442pfv.50.1665149824567;
        Fri, 07 Oct 2022 06:37:04 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b0017f7819732dsm1041459plf.77.2022.10.07.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:37:03 -0700 (PDT)
Date:   Fri, 7 Oct 2022 22:36:56 +0900
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
Message-ID: <Y0AreJczk6FdiKxr@hyeyoo>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
 <Yy+NCJ525S+HzP4k@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy+NCJ525S+HzP4k@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 12:04:40AM +0100, Matthew Wilcox wrote:
> On Mon, Sep 19, 2022 at 09:57:08PM +0900, Hyeonggon Yoo wrote:
> > For now, only SLAB uses _mapcount field as a number of active objects in
> > a slab, and other slab allocators do not use it. As 16 bits are enough
> > for that, use remaining 16 bits of _mapcount as page_type even when
> > SLAB is used. And then move PG_slab flag to page_type!
> > 
> > Note that page_type is always placed in upper 16 bits of _mapcount to
> > avoid confusing normal _mapcount as page_type. As underflow (actually
> > I mean, yeah, overflow) is not a concern anymore, use more lower bits
> > except bit zero.
> > 
> > Add more folio helpers for PAGE_TYPE_OPS() not to break existing
> > slab implementations.
> > 
> > Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
> > check if _mapcount is properly set at free.
> > 
> > Exclude PG_slab from hwpoison and show_page_flags() for now.
> > 
> > Note that with this patch, page_mapped() and folio_mapped() always return
> > false for slab page.
> 
> This is an interesting approach.  It raises some questions.

Hello Matthew, sorry for late reply and I didn't mean to ignore your
feedback. I realized compound pages and folio stuffs are my weak side and
needed some time to learn :)

> First, you say that folio_mapped() returns false for slab pages.  That's
> only true for order-0 slab pages.  For larger pages,
> 
>         if (!folio_test_large(folio))
>                 return atomic_read(&folio->_mapcount) >= 0;
>         if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
>                 return true;
> 
> so that's going to depend what folio_mapcount_ptr() aliases with.

IIUC it's true for order > 0 slab too.

As slab pages are not mapped to userspace at all,
entire compound page nor base pages are not mapped to userspace.

AFAIK followings are true for order > 0 slab:
        - (first tail page)->compound_mapcount is -1
        - _mapcount of base pages are -1

So:
        folio_mapped() and page_mapped() (if applied to head page)
        returns false for larger pages with this patch.

I wrote simple testcase and did check that folio_mapped() and page_mapped()
returns false for both order-0 page and larger pages. (and SLAB
returned true for them before)

> Second, this patch changes the behaviour of PageSlab() when applied to
> tail pages.

Altough it changes the way it checks the flag,

it does not change behavior when applied to tail pages - PageSlab() on tail
page returns false with or without this patch.

If PageSlab() need to return true for tail pages too,
we may make it check page_type at head page.

But I'm not sure when it the behavior is needed.
Can you please share your insight on this?

> Which raises the further question of what PageBuddy(),
> PageTable(), PageGuard() and PageIsolated() should do for multi-page
> folios, if that is even possible.

For users that uses real compound page like slab, we can make it check
page_type of head page. (if needed)

But for cases David described, there isn't much thing we can do
except making them to use real compound pages.

> Third, can we do this without that awkward __u16 thing?  Perhaps
> 
> -#define PG_buddy        0x00000080
> -#define PG_offline      0x00000100
> -#define PG_table        0x00000200
> -#define PG_guard        0x00000400
> +#define PG_buddy        0x00010000
> +#define PG_offline      0x00020000
> +#define PG_table        0x00040000
> +#define PG_guard        0x00080000
> +#define PG_slab         0x00100000
> 
> ... and then use wrappers in slab.c to access the bottom 16 bits?

Definitely! I prefer that way and will adjust in RFC v2.

Thank you for precious feedback.

-- 
Hyeonggon
