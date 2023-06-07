Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857FF726621
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjFGQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFGQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:39:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627B1BFE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:39:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b0201d9a9eso6447595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686155995; x=1688747995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haXOY3QmS0fTsttw/m0QvphvkCV0nGYqGozTlwd/PLA=;
        b=orm4BQQMfYCElS2J0K9B44CwqHOVtqq1UBdOIxiBGWU9Bv/G0xFghgAQ9ctWK68eTo
         GPf2TzN7C2H7Ia2L/Onx3ppykoBtnpejiks57TqHoXrkvvOM+SLhrsZqGPD37lYmr01j
         QdXpWfEM4eWE3RwiQzvKB1SL8t84Rkm8dq2owC7UGWtbcTK8qgr8eu/WnefjGJL/MzJ6
         5J8AW5SkizWArXgvhTTkO7oTZc8umAjZeA04yNmNWjuDjHqm4nqM/uiAOQ/iMYiX9rqD
         fNi4xLdEzXj+Krf8JbfmyXbzDQXzclVBSYeEBYE2FH7GYTxqWm7W3fezRqsTdFDZQ79q
         HgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686155995; x=1688747995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haXOY3QmS0fTsttw/m0QvphvkCV0nGYqGozTlwd/PLA=;
        b=jrqn/ZxeVbswGjyX5eiitJ1GcecIJupK5uA3ApKKZ+AP5ikIu/zQi5wHQ35wSlvfCo
         IDhfIduHFYNn1A819PIhBhbUY7oowzj8sEA3fJqQ3UravQcbjn5GwL7ipUILmiKjddNX
         iKALWq/5KKLBoYyttcclMOzZNDECTuHcRtna7yrX3/Qe0TaDqW3Q64sol97A46seqvNz
         fG6nmdsl48kIEaBICIzxIYCy5Azp02DdFA6z4i9z4iErdY2PTQ/iq4+pKKG0H2/595SG
         xuuCKqBodo0hO5dH9kGz47WTxFmMDTn6uBqRbeSCZKlHJgyNzs+fBl+WR0mCTtSdu4Wo
         dglQ==
X-Gm-Message-State: AC+VfDxhvML5KJBjw15gPPjGkd8XTMo+2tW8b2F2V0GAwJeJF7Po52zj
        AMtmOCkWGJqNzRKdKZAvc1q+Zpk/9EDwsHBLVEY=
X-Google-Smtp-Source: ACHHUZ5ZajRbcgvECTPIMkPVc+zO5SV97dXF0sN2J3j3b0jxb1yHOOEGLewn0/yqz5ZJD/OkPXfUSJQqHx+5MBndtvo=
X-Received: by 2002:a17:902:b18e:b0:1b0:7cc:982a with SMTP id
 s14-20020a170902b18e00b001b007cc982amr6156551plr.5.1686155995416; Wed, 07 Jun
 2023 09:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230602230552.350731-1-peterx@redhat.com> <ZICK3uqTeUxeIlc9@x1n>
 <97b5657d-e09d-b3a9-c09d-eaff9fb7929d@redhat.com> <ZICukdhrxcaA74Pp@x1n>
In-Reply-To: <ZICukdhrxcaA74Pp@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Jun 2023 09:39:44 -0700
Message-ID: <CAHbLzkoiSW3jOhFdEU5w567SyxhB05dBfTrJvKg4X59nPURz3Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: Fix pmd_trans_unstable() call sites on retry
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 9:21=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 07, 2023 at 05:45:28PM +0200, David Hildenbrand wrote:
> > On 07.06.23 15:49, Peter Xu wrote:
> > > On Fri, Jun 02, 2023 at 07:05:48PM -0400, Peter Xu wrote:
> > > > Please have a look, thanks.
> > >
> > > Hello, all,
> > >
> > > This one seems to have more or less conflict with Hugh's rework on pm=
d
> > > collapse.  Please hold off review or merging until I prepare another =
one
> > > (probably based on Hugh's, after I have a closer read).
> > >
> > > Sorry for the noise.
> > >
> >
> > [did not have time to look yet]
> >
> > Are there any fixes buried in there that we'd like to have in earlier? =
I
> > skimmed over the patches and all read like "cleanup" + "consistency",
> > correct?
>
> There are bug fixes when unluckily hitting unstable pmd I think, these on=
es
> worth mentioning:
>
>   - pagemap can be broken, causing read to be shifted over to the next
>     (wrong data read)

Yes, it may corrupt the pagemap data. But anyway it seems like nobody
was busted by this one as you said.

>
>   - memcg wrong accounting, e.g., moving one task from memcg1 to memcg2, =
we
>     can skip an unstable pmd while it could quickly contain something tha=
t
>     can belong to memcg1, I think.  This one needs some eyes from memcg
>     developers.

I don't think this is an important thing. There are plenty of other
conditions that could make the accounting inaccurate, for example,
isolating page from LRU fails, force charge, etc. And it seems like
nobody was bothered by this either.

>
> I don't rush on having them because these are all theoretical and no bug
> report I saw, no reproducer I wrote, only observed by my eyes.
>
> At least the pagemap issue should have been there for 10+ years without
> being noticed even if rightfully spot this time.  Meanwhile this seems to
> have conflict with Hugh's series which should have been posted earlier - =
I
> still need to check on how that will affect this series, but not yet.
>
> Said that, let me know if any of you hit any (potential) issue with above
> or think that we should to move this in earlier.
>
> Thanks,
>
> --
> Peter Xu
>
>
