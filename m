Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535E5672547
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjARRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjARRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:30 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EF439291
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:41:52 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p188so39063710yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ggn1Gn4xsGfWkGoz3fdeEx12ls41kiX+Bcgea51Xy0=;
        b=Ea4CJI0TSp0VpR3KYCvzeCipTBJjBVuqbyf4rfd+Jv1neOPo9p/t/BduqEOInn0y3C
         ofgrWDbDQgEP2g8l1MvXXGn/QX4fbJhNvQffDX/t+trziL1O5MKSR5kfDMjyLWGQG3EA
         vJQ1epz0AZ7pySAVPAR4XXXKslbRKDY9rkCVemC3yTtudRIBFHB5aYgnxkMTfX+a315y
         +MCEhYZQkWH78CcxuVrSGlmVx3JBTtYjrsCR/65yYqhEc8iYg6n/Mrymr9pNuAmPcW8Y
         0VNTZ6B+ZwgCycamWGYsxLS5X/qCdfxOOX3rFQTg4BAZq6XeZYwYYTJPt8RKmXpMgxru
         ZHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ggn1Gn4xsGfWkGoz3fdeEx12ls41kiX+Bcgea51Xy0=;
        b=jAgK4IwUqR5BenqV0EN7YhOM2BxhTtu8igsge1hh13a6KKHahhyCi0jdmOrR4e8uSX
         SgwqiUyCScwEUh4vAn8LLNpt7bFOK3k+aOkb2/ixH58FLGVYunBv5LLY4ZykuPhap7cb
         UOMLEe952GSCtfi32p+7YbxiyxyjVV0xI2effIXxOff826eVNung8zYOX+9CeH3fdDgd
         S0RjQRRNjmyXekG/LsTpG1uRb78UY4HGDWrr8UMZXjtezn4UIx0VA4BLQEwwcmUnk/lr
         8mqMujaFBra0gHwG94B3ZtNMrAPJ7NSJ7Eo4YwGji/E5TuQ+dRuUtNIXJ3I7SQ9O8oR6
         xF8g==
X-Gm-Message-State: AFqh2krD+d4U0osWKOy+fIgPizmWrTj5GMnF023rql5KXd902X2+NaFw
        9m7anX5/pzHCFCbm/Fla7wmN+a/tzN0q0yq9DfFGLw==
X-Google-Smtp-Source: AMrXdXumY8p2sU8BkGgo7Lctu1jBI5wsBXEgb6BSMszQ1CFMqwRFSLoQ/TGhweY0s84T2kXVvFhuWQ3VSTGzwjugGTw=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr745969ybo.380.1674063711547; Wed, 18 Jan
 2023 09:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-19-surenb@google.com>
 <Y8a9+ywh65fmuKvv@dhcp22.suse.cz> <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
 <Y8e+efbJ4rw9goF0@dhcp22.suse.cz>
In-Reply-To: <Y8e+efbJ4rw9goF0@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 09:41:38 -0800
Message-ID: <CAJuCfpHbMJV3Mo3tkFU4zbDWSTOBoMpBVJZ4-NePGF_Yv+VUGg@mail.gmail.com>
Subject: Re: [PATCH 18/41] mm/khugepaged: write-lock VMA while collapsing a
 huge page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Wed, Jan 18, 2023 at 1:40 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 17-01-23 21:28:06, Jann Horn wrote:
> > On Tue, Jan 17, 2023 at 4:25 PM Michal Hocko <mhocko@suse.com> wrote:
> > > On Mon 09-01-23 12:53:13, Suren Baghdasaryan wrote:
> > > > Protect VMA from concurrent page fault handler while collapsing a huge
> > > > page. Page fault handler needs a stable PMD to use PTL and relies on
> > > > per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
> > > > set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
> > > > not be detected by a page fault handler without proper locking.
> > >
> > > I am struggling with this changelog. Maybe because my recollection of
> > > the THP collapsing subtleties is weak. But aren't you just trying to say
> > > that the current #PF handling and THP collapsing need to be mutually
> > > exclusive currently so in order to keep that assumption you have mark
> > > the vma write locked?
> > >
> > > Also it is not really clear to me how that handles other vmas which can
> > > share the same thp?
> >
> > It's not about the hugepage itself, it's about how the THP collapse
> > operation frees page tables.
> >
> > Before this series, page tables can be walked under any one of the
> > mmap lock, the mapping lock, and the anon_vma lock; so when khugepaged
> > unlinks and frees page tables, it must ensure that all of those either
> > are locked or don't exist. This series adds a fourth lock under which
> > page tables can be traversed, and so khugepaged must also lock out that one.
> >
> > There is a codepath in khugepaged that iterates through all mappings
> > of a file to zap page tables (retract_page_tables()), which locks each
> > visited mm with mmap_write_trylock() and now also does
> > vma_write_lock().
>
> OK, I see. This would be a great addendum to the changelog.

I'll add Jann's description in the changelog. Thanks Jann!

>
> > I think one aspect of this patch that might cause trouble later on, if
> > support for non-anonymous VMAs is added, is that retract_page_tables()
> > now does vma_write_lock() while holding the mapping lock; the page
> > fault handling path would probably take the locks the other way
> > around, leading to a deadlock? So the vma_write_lock() in
> > retract_page_tables() might have to become a trylock later on.
>
> This, right?
> #PF                     retract_page_tables
> vma_read_lock
>                         i_mmap_lock_write
> i_mmap_lock_read
>                         vma_write_lock
>
>
> I might be missing something but I have only found huge_pmd_share to be
> called from the #PF path. That one should be safe as it cannot be a
> target for THP. Not that it would matter much because such a dependency
> chain would be really subtle.
> --
> Michal Hocko
> SUSE Labs
