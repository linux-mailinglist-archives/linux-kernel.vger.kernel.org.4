Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F2653A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiLVBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLVBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:25:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183EF2180B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:25:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso235355wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EpNT/fZq6auLKHZyFjmmvXixN7/oo6fjlHo3Pj9m8o=;
        b=kq961VpyGUztjBGi0fCdkrV545N02jULWGj1RdHYXBYGN46N+Qs4IzsGMWyDNLJxDU
         buNxYVlSmta+HsUs0Ki8CXsQRPvckp6LMLUBweLH0Pt9It1hk2/FgvT/G8Gc9Ho0Jl36
         Cy3J6VPOUfTcCzMZGm1nsr1im5CCYDzWZMN3ycsJfgit99EzbDMx6a2p6K3tFsTaToHY
         3GtNp3NqHBcDmTKcpuIu1pQi6c3mFVA4aqIO8sugI3VjTcdHzlpdH7mMPMtLg5K4gFD9
         nfGWqlBznwiCoBGFkslVosfUfB0LQ9sj0DQ/fCVjYwtZS9OqIws4k57d1mB119CB/KMl
         s3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EpNT/fZq6auLKHZyFjmmvXixN7/oo6fjlHo3Pj9m8o=;
        b=vZBLmg4I6KmrhY+RaLEfVlKNIpmiFlJz1Y7sHDjvjhZrZGtvoSV0/BhncQIYSbYvI/
         35q4pH4dW3WrqdO2KKb2Pf71vHsZiOVqggUyxr8bouR7ge9T/ctddFTyMLDDQZN9EyXa
         p2HGqpuXGueg0Lw+DjtzfDbddQz3090VnLUzQ5UiBjjBW2foinRMAXLK1Jv+3GdY39XO
         ebjd1ptDjuBnTfsfHYu/d5NTdSaptI7TTx4ixdHgZgmvVwFwvX4+fYCC3LXe8+vAWraR
         R3q3cXUNYm3WpjFpMtf8JyQYDGcFHGuFY3H/H42adPuBC+7ANjurKl4g0mYzhCHt7VR6
         hf+g==
X-Gm-Message-State: AFqh2krNJulK+EGLyl3tDyEhA2GpbOzo92w0L4021ttewjjEdAZ2ND3K
        R4yjd2UulVrrkssVvHkNHct7BuhIm26AyvSrjp/Apg==
X-Google-Smtp-Source: AMrXdXv5bVPhh5ksL4kdNuJMFZpAK4ASsWlJclZAuMAKm5ROMN0PS8xVFZ9BltcK3Ho2ctuBt4Gk7QNpQYIIeZLNows=
X-Received: by 2002:a05:600c:4b95:b0:3d1:da8c:7869 with SMTP id
 e21-20020a05600c4b9500b003d1da8c7869mr234485wmp.26.1671672298509; Wed, 21 Dec
 2022 17:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com> <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n> <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey> <Y6OEQB3dLSa083F6@x1n> <Y6OJUtVkvdptEgW7@monkey>
 <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com> <Y6Om/dvlt1Wl2uZw@monkey>
In-Reply-To: <Y6Om/dvlt1Wl2uZw@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 21 Dec 2022 20:24:45 -0500
Message-ID: <CADrL8HU_4ymb4XMBpujyFECwONKpWP0fgZgy7odb+M23QUx6pQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So considering two API choices:
> >
> > 1. What we have now: UFFD_FEATURE_MINOR_HUGETLBFS_HGM for
> > UFFDIO_CONTINUE, and later UFFD_FEATURE_WP_HUGETLBFS_HGM for
> > UFFDIO_WRITEPROTECT. For MADV_DONTNEED, we could just suddenly start
> > allowing high-granularity choices (not sure if this is bad; we started
> > allowing it for HugeTLB recently with no other API change, AFAIA).
>
> I don't think we can just start allowing HGM for MADV_DONTNEED without
> some type of user interaction/request.  Otherwise, a user that passes
> in non-hugetlb page size requests may get unexpected results.  And, one
> of the threads about MADV_DONTNEED points out a valid use cases where
> the caller may not know the mapping is hugetlb or not and is likely to
> pass in non-hugetlb page size requests.
>
> > 2. MADV_ENABLE_HGM or something similar. The changes to
> > UFFDIO_CONTINUE/UFFDIO_WRITEPROTECT/MADV_DONTNEED come automatically,
> > provided they are implemented.
> >
> > I don't mind one way or the other. Peter, I assume you prefer #2.
> > Mike, what about you? If we decide on something other than #1, I'll
> > make the change before sending v1 out.
>
> Since I do not believe 1) is an option, MADV_ENABLE_HGM might be the way
> to go.  Any thoughts about MADV_ENABLE_HGM?  I'm thinking:
> - Make it have same restrictions as other madvise hugetlb calls,
>   . addr must be huge page aligned
>   . length is rounded down to a multiple of huge page size
> - We split the vma as required
I agree with these.
> - Flags carrying HGM state reside in the hugetlb_shared_vma_data struct
I actually changed this in v1 to storing HGM state as a VMA flag to
avoid problems with splitting VMAs (like, when we split a VMA, it's
possible the VMA data/lock struct doesn't get allocated). It seems
better to me; I can change it back if you disagree.

Not sure what the best name for this flag is either. MADV_ENABLE_HGM
sounds ok. MADV_HUGETLB_HGM or MADV_HUGETLB_SMALL_PAGES could work
too. No need to figure it out now.

Thanks Mike and Peter :) I'll make this change for v1 and send it out
sometime soon.

- James
