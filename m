Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB86470C513
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjEVSXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEVSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:23:03 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFFF1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:23:01 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561a41db2c0so84548207b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684779781; x=1687371781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXtB3oHldSeARfmO9Kb5DTV3MtiHTcwqap7Kh6oNPas=;
        b=v4Bf3Zt/0dA6dX7QYk5te/8rKJqO2bXZjU8emhfM4C85TyIk2GZYN07dJ4TR71KefF
         l8bpYeuW7eApLH8K56CAyNXV39HOcUSv3L6IzMToFDZPDYEt4+AHl0dGN8bdhxr44N2Q
         fcDKB3WNhRjMgtX5sWG3Ix+YmApsizsNdTi6truSAwa1otHCVFidCSp2a3dOkGRWZlfk
         RNO9LKG2KadH7zDsXz28Scc9T6wczUzCsCaVjaR299M5yy1+88QK6KQ6PA+T2eQL8stY
         qgfodg7odRxDDEzNIdw3/vQr+8Y9nuCtkxSnfohA8Wgt4nMcRgY3z78aedhTLL6js3XI
         CqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779781; x=1687371781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXtB3oHldSeARfmO9Kb5DTV3MtiHTcwqap7Kh6oNPas=;
        b=ZJCwCkUMznkcRR85NTqE3nGhjVS6NCNfia/J1P9pchrgwjr9QRN0lAJfQcHJqNLmqw
         1thrO1ujPAn12YlsbqlQM3G/JsfUTXIPLime/6had5Re/l9Bp02LeHVLMqdgqL1xEZRc
         DbULM/NgB4+Mmu5omez8da3oH9Oj9CKxS2Ae32zCVg6m0LySsuOurmW3Ehizy0PzmDtq
         +vwlwCyGiXrSs3cwWPvuTK0364atUxvJOdYEWtGDihF4X/l4EpPgLZFNEgK4+VmABTeH
         I/yenMHj577eQM6sovnHdTHS7Xo1TmJtg7tmviPtAXB70dTRZ6NIyJqV4Om1nUH7v1pL
         cbuw==
X-Gm-Message-State: AC+VfDxcToGJ0hHiRxQNJw5DQQq5eiCEIfP8oyRzJ0IPDsLEzFWI2BOx
        K12HuSxn1T/x8sdbjeNtJpxgsIT47AIGjKaNyMboGw==
X-Google-Smtp-Source: ACHHUZ7brytdvrneMs3kt9SEg7c2NiHeHYJ6QQ+HaR3rOxCwDtd/21JuOoaCi5SzA30JUBilcXsYn8ZH56CsnxWGmk0=
X-Received: by 2002:a81:6ad5:0:b0:55a:380b:552d with SMTP id
 f204-20020a816ad5000000b0055a380b552dmr11643260ywc.29.1684779780603; Mon, 22
 May 2023 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160948.811355-1-jiaqiyan@google.com> <20230517160948.811355-2-jiaqiyan@google.com>
 <20230517235314.GB10757@monkey> <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey> <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Mon, 22 May 2023 11:22:49 -0700
Message-ID: <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 9:50=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=
=E3=80=80=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Fri, May 19, 2023 at 03:42:14PM -0700, Mike Kravetz wrote:
> > On 05/19/23 13:54, Jiaqi Yan wrote:
> > > On Wed, May 17, 2023 at 4:53=E2=80=AFPM Mike Kravetz <mike.kravetz@or=
acle.com> wrote:
> > > >
> > > > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > > > Adds the functionality to search a subpage's corresponding raw_hw=
p_page
> > > > > in hugetlb page's HWPOISON list. This functionality can also tell=
 if a
> > > > > subpage is a raw HWPOISON page.
> > > > >
> > > > > Exports this functionality to be immediately used in the read ope=
ration
> > > > > for hugetlbfs.
> > > > >
> > > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > > ---
> > > > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > > > >  mm/memory-failure.c | 26 ++++++++++++++++----------
> > > > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index 27ce77080c79..f191a4119719 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > >
> > > > Any reason why you decided to add the following to linux/mm.h inste=
ad of
> > > > linux/hugetlb.h?  Since it is hugetlb specific I would have thought
> > > > hugetlb.h was more appropriate.
> > > >
> > > > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > > > >   */
> > > > >  extern const struct attribute_group memory_failure_attr_group;
> > > > >
> > > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > > +/*
> > > > > + * Struct raw_hwp_page represents information about "raw error p=
age",
> > > > > + * constructing singly linked list from ->_hugetlb_hwpoison fiel=
d of folio.
> > > > > + */
> > > > > +struct raw_hwp_page {
> > > > > +     struct llist_node node;
> > > > > +     struct page *page;
> > > > > +};
> > > > > +
> > > > > +static inline struct llist_head *raw_hwp_list_head(struct folio =
*folio)
> > > > > +{
> > > > > +     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Given @subpage, a raw page in a hugepage, find its location i=
n @folio's
> > > > > + * _hugetlb_hwpoison list. Return NULL if @subpage is not in the=
 list.
> > > > > + */
> > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > > > +                                    struct page *subpage);
> > > > > +#endif
> > > > > +
> > > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGET=
LBFS)
> > > > >  extern void clear_huge_page(struct page *page,
> > > > >                           unsigned long addr_hint,
> > > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > > > --- a/mm/memory-failure.c
> > > > > +++ b/mm/memory-failure.c
> > > > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> > > > >  #endif /* CONFIG_FS_DAX */
> > > > >
> > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > -/*
> > > > > - * Struct raw_hwp_page represents information about "raw error p=
age",
> > > > > - * constructing singly linked list from ->_hugetlb_hwpoison fiel=
d of folio.
> > > > > - */
> > > > > -struct raw_hwp_page {
> > > > > -     struct llist_node node;
> > > > > -     struct page *page;
> > > > > -};
> > > > >
> > > > > -static inline struct llist_head *raw_hwp_list_head(struct folio =
*folio)
> > > > > +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> > > > > +                                    struct page *subpage)
> > > > >  {
> > > > > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > > > > +     struct llist_node *t, *tnode;
> > > > > +     struct llist_head *raw_hwp_head =3D raw_hwp_list_head(folio=
);
> > > > > +     struct raw_hwp_page *hwp_page =3D NULL;
> > > > > +     struct raw_hwp_page *p;
> > > > > +
> > > > > +     llist_for_each_safe(tnode, t, raw_hwp_head->first) {
> > > >
> > > > IIUC, in rare error cases a hugetlb page can be poisoned WITHOUT a
> > > > raw_hwp_list.  This is indicated by the hugetlb page specific flag
> > > > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().
> > > >
> > > > Looks like this routine does not consider that case.  Seems like it=
 should
> > > > always return the passed subpage if folio_test_hugetlb_raw_hwp_unre=
liable()
> > > > is true?
> > >
> > > Thanks for catching this. I wonder should this routine consider
> > > RawHwpUnreliable or should the caller do.
> > >
> > > find_raw_hwp_page now returns raw_hwp_page* in the llist entry to
> > > caller (valid one at the moment), but once RawHwpUnreliable is set,
> > > all the raw_hwp_page in the llist will be kfree(), and the returned
> > > value becomes dangling pointer to caller (if the caller holds that
> > > caller long enough). Maybe returning a bool would be safer to the
> > > caller? If the routine returns bool, then checking RawHwpUnreliable
> > > can definitely be within the routine.
> >
> > I think the check for RawHwpUnreliable should be within this routine.
> > Looking closer at the code, I do not see any way to synchronize this.
> > It looks like manipulation in the memory-failure code would be
> > synchronized via the mf_mutex.  However, I do not see how traversal and
> > freeing of the raw_hwp_list  called from __update_and_free_hugetlb_foli=
o
> > is synchronized against memory-failure code modifying the list.
> >
> > Naoya, can you provide some thoughts?
>
> Thanks for elaborating the issue.  I think that making find_raw_hwp_page(=
) and
> folio_clear_hugetlb_hwpoison() do their works within mf_mutex can be one =
solution.
> try_memory_failure_hugetlb(), one of the callers of folio_clear_hugetlb_h=
wpoison(),
> already calls it within mf_mutex, so some wrapper might be needed to impl=
ement
> calling path from __update_and_free_hugetlb_folio() to take mf_mutex.
>
> It might be a concern that mf_mutex is a big lock to cover overall hwpois=
on
> subsystem, but I think that the impact is not so big if the changed code =
paths
> take mf_mutex only after checking hwpoisoned hugepage.  Maybe using folio=
_lock
> to synchronize accesses to the raw_hwp_list could be possible, but curren=
tly
> __get_huge_page_for_hwpoison() calls folio_set_hugetlb_hwpoison() without
> folio_lock, so this approach needs update on locking rule and it sounds m=
ore
> error-prone to me.

Thanks Naoya, since memory_failure is the main user of raw_hwp_list, I
agree mf_mutex could help to sync its two del_all operations (one from
try_memory_failure_hugetlb and one from
__update_and_free_hugetlb_folio).

I still want to ask a perhaps stupid question, somewhat related to how
to implement find_raw_hwp_page() correctly. It seems
llist_for_each_safe should only be used to traverse after list entries
already *deleted* via llist_del_all. But the llist_for_each_safe calls
in memory_failure today is used *directly* on the raw_hwp_list. This
is quite different from other users of llist_for_each_safe (for
example, kernel/bpf/memalloc.c). Why is it correct? I guess mostly
because they are sync-ed under mf_mutex (except the missing coverage
on __update_and_free_hugetlb_folio)?

>
> Thanks,
> Naoya Horiguchi
>
> >
> > >
> > > Another option is, this routine simply doesn one thing: find a
> > > raw_hwp_page in raw_hwp_list for a subpage. But the caller needs to 1=
)
> > > test RawHwpUnreliable before calls into the routine, and 2) test
> > > RawHwpUnreliable before access returned raw_hwp_page*. I think 2nd
> > > option will be error-prone and the 1st option is a better one.
> > >
> > > Maybe I am over-thinking. What do you think?
> >
> > I think racing code accessing the raw_hwp_list is very unlikely.
> > However, it is possible and should be considered.
> > --
> > Mike Kravetz
> >
> > >
> > > > --
> > > > Mike Kravetz
> > > >
> > > > > +             p =3D container_of(tnode, struct raw_hwp_page, node=
);
> > > > > +             if (subpage =3D=3D p->page) {
> > > > > +                     hwp_page =3D p;
> > > > > +                     break;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     return hwp_page;
> > > > >  }
> > > > >
> > > > >  static unsigned long __folio_free_raw_hwp(struct folio *folio, b=
ool move_flag)
> > > > > --
> > > > > 2.40.1.606.ga4b1b128d6-goog
> > > > >
