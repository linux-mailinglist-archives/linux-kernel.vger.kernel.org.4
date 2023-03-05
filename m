Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9616AAF03
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCEKYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCEKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:24:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5135DE3A8;
        Sun,  5 Mar 2023 02:24:43 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c3so7615690qtc.8;
        Sun, 05 Mar 2023 02:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678011882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqMINr6iQSeskbEpBS6bkpmue99yioMBFhLHh7sxvHs=;
        b=NHHME9OYNe5qcDM7ezj/qgLYaateTVLfjHc0wFx7pHAn58Ixrtyw4RJ3pfnWlhov6P
         +4L082borw06qmOc9/qfCNhmQORt1+phuwHStY3VxL9ECAE5zIkX2LI/nipPYActtZFC
         ZW9sThVZJ0MdHpR5EPqxqQPY7KkW+u5tThtSeZoteiahhRRIkVywiGeNwOYMQoeLozn3
         dyDf56mqCDxPG9dS7J0tk++jeYaYL6jO0e19e4EIZlUC467VsPFwZqlFcqB+RoqSQWD3
         9EvTVENGSqeis7wTglZSA38fA3EihOwVgDoYrCYvybakxOqIUmi+Kf0dG9aR+oQEL29l
         bW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678011882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqMINr6iQSeskbEpBS6bkpmue99yioMBFhLHh7sxvHs=;
        b=LAjNqQARWXtmBt52dN5qPAzrOcAkIJ48qs7u3mBrLqKh3kU3RxHpHKr9V0rsQWgKkZ
         cypkJ++KlUsFwCPrLJ7tt2s1v/L1U+57DozNsTSu4KEdVtww1S274x52JBsMj3GPwe/B
         Gxqx0igN/8f1x6RZvvgcPk+dCvpuuHa7o6DTG1m+GQHR0nC66x53cybMbTmhfjznsOXM
         jHXnd8QDeK7nkg3HsPtz81lx5rZRw+4aQsPnzuPe/Hfw2iLRzDnRh/LGZ6Athx1mKbTz
         dP3zCqAYWj0kbtdTW2xb5V/6O5BZUC5U0cw7mnxJnqkUmEvvhE74KgD2wyqvyp9LL8rM
         191A==
X-Gm-Message-State: AO0yUKV0D+VClE3i1VXVg+CalrDEgpfXsK9DRCV5Do/a9GzsTGrFVZja
        3sTzMFfg68bnHphv87nunsS/H+fnuoudeJewdDI=
X-Google-Smtp-Source: AK7set+dBxXSlIEGi6EDukdzbUkI+kB8AePqzhPv7tgQhbrKr02somGK3IPoQy8PAOjVOz8rniLhFAoZuKRl1uB7VKg=
X-Received: by 2002:ac8:56f6:0:b0:3bf:d993:f353 with SMTP id
 22-20020ac856f6000000b003bfd993f353mr2249036qtu.7.1678011882326; Sun, 05 Mar
 2023 02:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20230219073318.366189-1-nphamcs@gmail.com> <20230219073318.366189-3-nphamcs@gmail.com>
 <Y/IUTiL03C9OOSFx@casper.infradead.org> <CAKEwX=M7HSzSF6GZ_Nv26FQv_j+5UD9FQ_v3CL4=a1q5epyvPA@mail.gmail.com>
 <ZAGbyM8xnLKC/2uX@casper.infradead.org>
In-Reply-To: <ZAGbyM8xnLKC/2uX@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sun, 5 Mar 2023 02:24:31 -0800
Message-ID: <CAKEwX=M3VveHstbwxFdmWjPA_ruSBufEYD5Pn_awFD38WF_AqQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 11:03=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 02, 2023 at 10:55:48PM -0800, Nhat Pham wrote:
> > On Sun, Feb 19, 2023 at 4:21=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > > +/**
> > > > + * filemap_cachestat() - compute the page cache statistics of a ma=
pping
> > > > + * @mapping: The mapping to compute the statistics for.
> > > > + * @first_index:     The starting page cache index.
> > > > + * @last_index:      The final page index (inclusive).
> > > > + * @cs:      the cachestat struct to write the result to.
> > > > + *
> > > > + * This will query the page cache statistics of a mapping in the
> > > > + * page range of [first_index, last_index] (inclusive). The statis=
tics
> > > > + * queried include: number of dirty pages, number of pages marked =
for
> > > > + * writeback, and the number of (recently) evicted pages.
> > > > + */
> > >
> > > Do we care that this isn't going to work for hugetlbfs?
> >
> > I ran a quick test using hugetlbfs. It looks like the current
> > implementation is treating it in accordance to the multi-page
> > folio case we discussed earlier, i.e:
> >
> > - Returned number of "pages" is in terms of the number of
> > base/small pages (i.e 512 dirty pages instead of 1 dirty
> > huge page etc.)
> > - If we touch one byte in the huge page, it would report the
> > entire huge page as dirty, but again in terms of the underlying
> > pages.
> >
> > Is this what you have in mind, or is there another edge
> > case that I'm missing...?
>
> Hugetlbfs indexes its pages by hugepage number rather than by smallpage
> number.  Imagine you have a 2MB folio at offset 4MB into the file.
> Filesystems other than hugetlbfs store it at indices 1024-1535.
> hugetlbfs stores it at index 2.
>
> So your report probably seems to work, but if you ask it about a
> range, you might be surprised by how wide that range will cover for
> hugetlbfs.
>
> I know Sidhartha is working on fixing that, but I'm not sure if what he
> has is working yet.

Oh I see! Thanks for letting us know about this, Matthew.

In that case, I think we should just drop support for hugetlbfs for now.
It's also an odd ball - not swappable, no backing files, not fully
under user management, etc., so it's less interesting with respect to
cachestat as well.

In the future, we can always lift this restriction with a follow-up patch
or with Sidhartha's fix.
