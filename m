Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3186B2E07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCIT7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCIT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:59:15 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5196FCCEB6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:59:14 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id o199so1303461ybc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678391953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFCNC/vYq94itAnDGpHNmbJxauP9MDrM1R5OhIvk1z4=;
        b=GFvoS4a+KU4C5zL5l2DiI8whruPL/E4xmsQFgvVnXDAWFx8l1HpKOHIEV9LG209me7
         eVKn6rW9wzmvAmbN6yawN385xakFtbzOb6GdUPj/utHXy5jZnZ6E7IBjvQvuxH2X01uB
         E7CDvcoiL+Lc8k5mxtBi97oiwav4sUzNC9+ePXZRo9tAdrVO5Rs2w0I032a8Vnw8seBf
         zW3rbNeLOUO/aCupFvziq03hjmJ0rFg1UV/fAW74kA/DtMf1dnuM8ftshPdrxhG93zJ9
         S6NJjgqez+t3FuZDpQFyW0Cd4eTqjcAf6kJyPVEJClpoJB6y3FxH0It0w/8kiHHjFgzv
         2O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678391953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFCNC/vYq94itAnDGpHNmbJxauP9MDrM1R5OhIvk1z4=;
        b=qHRFzIvVj9iJRA/93gJV8NPdRk2i+1NXfmg3oTWpNn/P1zojGYlkE4IHkUq7dGH6vY
         1H/TZ80DZPMPeycMXIKKy2yNcPP5vUjq7Zz+qCHRHBAixlSclKqA+i5ZVQ5cmIXPb2Mi
         kL6QMNhTY2crZbScIT9vqJxtDeD7JJveqIgkeu7KFJEt78eq+CrQzIS44MJn+ariZ+hi
         S5Zcp1DricjDMdEkAyJIGNFWGbhJFYmjTdC9/DTR3nLgDJTKHg0SRXg/+UYmeK8NT9Pb
         iuupHl5tBQtKsDydwUtzMucgzzDSwYEcaSCgxI6ZG+myO2JbBv9ZKHO5c1Co4A5zIbRv
         WH8g==
X-Gm-Message-State: AO0yUKWz1nmh27W6pamWFplHJcqOL6QVaMan/QtiwaGQ5yucG9fG1dz1
        GaZDI4z1KaiVO2iW+G7HZ/+EjB4MfHRynLimdy6+Ww==
X-Google-Smtp-Source: AK7set/wWc7mwdGSf47sts1b6uAdfX2X95Pk6naGMsMYvcMW9zYO/9EgJXe2P2wXjghWqhKOV0OxTgyMRafpQudLJ4E=
X-Received: by 2002:a5b:a0c:0:b0:a24:1001:1fd2 with SMTP id
 k12-20020a5b0a0c000000b00a2410011fd2mr13996848ybq.0.1678391953431; Thu, 09
 Mar 2023 11:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20230306230004.1387007-1-jthoughton@google.com>
 <20230306230004.1387007-2-jthoughton@google.com> <20230307215420.GA59222@monkey>
 <CADrL8HVa3vzmrfFJD5hx_GuXVnsWhSo9hzJFb4TTzzjMhWG+sQ@mail.gmail.com> <ZAkEecMShUAGwZ62@x1n>
In-Reply-To: <ZAkEecMShUAGwZ62@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 9 Mar 2023 11:58:37 -0800
Message-ID: <CADrL8HWT8-MZeL-G+Qj4vQHVrrMxd8EWkPWO9eDfwvvZvoh69A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: rmap: make hugetlb pages participate in _nr_pages_mapped
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 8, 2023 at 1:56=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Mar 07, 2023 at 04:36:51PM -0800, James Houghton wrote:
> > > >       if (likely(!compound)) {
> > > > +             if (unlikely(folio_test_hugetlb(folio)))
> > > > +                     VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->=
page),
> > > > +                                    page);
>
> How about moving folio_test_hugetlb() into the BUG_ON()?
>
>                 VM_BUG_ON_PAGE(folio_test_hugetlb(folio) &&
>                                HPageVmemmapOptimized(&folio->page),
>                                page);
>
> Note that BUG_ON() already contains an "unlikely".

Ok I can do that. It's a little cleaner.

> > > >               first =3D atomic_inc_and_test(&page->_mapcount);
> > > >               nr =3D first;
> > > >               if (first && folio_test_large(folio)) {
> > > >                       nr =3D atomic_inc_return_relaxed(mapped);
> > > >                       nr =3D (nr < COMPOUND_MAPPED);
> > > >               }
> > > > -     } else if (folio_test_pmd_mappable(folio)) {
> > > > -             /* That test is redundant: it's for safety or to opti=
mize out */
> > >
> > > I 'think' removing this check is OK.  It would seem that the caller
> > > knows if the folio is mappable.  If we want a similar test, we might =
be
> > > able to use something like:
> > >
> > >         arch_hugetlb_valid_size(folio_size(folio))
> > >
> >
> > Ack. I think leaving the check(s) removed is fine.
>
> Would it still be good to keep that as another BUG_ON()?

Sure, that sounds reasonable to me. I'll add it unless someone disagrees.

As you suggested in your other email, I'll also add a BUG_ON() if we
attempt to do a non-compound mapping of a folio that is larger than
COMPOUND_MAPPED / 2. (Maybe a BUG_ON() in alloc_hugetlb_folio() to
check that the size of the folio we're allocating is less than
COMPOUND_MAPPED / 2 makes sense instead. Just an idea.)

- James
