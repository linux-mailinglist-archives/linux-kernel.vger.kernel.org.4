Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A90733D97
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 04:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjFQCS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 22:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFQCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 22:18:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F05F2D72
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:18:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56ffd7d7fedso16654147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686968333; x=1689560333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOFci3gQgrdX82h8XRvfgOYsHWhRE165e0Pr8Okwmz8=;
        b=t9IXKtZY7wkYqVnEj8GXmVcJ60w5Txwc1G1EVQ0UhJR7vcKJ3XtMO10HxoXXqYSRj3
         7k6bL0tiFPyW3pS5iDdkKGFuNS8isGisqJfFI5+gyWZkVs0Oa/re8vKXTVRCOeJpBYqv
         /TLyzN2f4w5XNKwQdDRjU3WY2B1VDANHGuFbj6UbUeyL9N0yKETQf1ct9HAoO8dz0yc8
         nC43kXVNqYiwUUpyM8b36fYBRoPI4Hz0LyOvlFL+uvQp/a4yBq0iafp82H7nIlYM0nrk
         2bkRjdbdbPkeKnGAKxuP/WIr64lJg+UMnNANd74WpseMcfS4pToNoKRxBdRvArxEDs3B
         P/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686968333; x=1689560333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOFci3gQgrdX82h8XRvfgOYsHWhRE165e0Pr8Okwmz8=;
        b=bWLJPx2RqWOKhqbtBGVm1XvoDnmvSNUTNMa/XAPl2TEdwaKitC+CBsTFVx8dHjN5iO
         s6DWOHPzsOkxTIMmA5J6Mh3IQlbia2I+7Yx84QoqFsC62gA6bAjgSZ5igrA8TtAPdp4f
         sxgE2RbHeFLcO8f02Q2nYQGu3QacCOzJ1e8WG5vz9IAY6J9ZA5b1hSoPcTvdacUoZBfw
         YOCn2NG3F8PWhSV7ctXYDyHnVj+u9444WhPnHAmPzuJhYjVnaQUVad1PVzb7PJA9+Hou
         YhUzObrasN4wRvyiUxLoqcqYCANxtOy5vCO2AoI5a3e5mnFskeGsROmkBEmU/E2IuJCu
         L46w==
X-Gm-Message-State: AC+VfDyC0GRCo2thW0zITp/A02IZcTsd7pTSxXdT7yKDCoI8JLWaKfQm
        QDwqoiSVX0MHq87Ca/2QkOEu0vp8P8ZhUMiSItSvDw==
X-Google-Smtp-Source: ACHHUZ5g+A6dpsh3e+eCHMA0DmE96nkTXFEWJUnZ7bnNSAVOmmQVPBS7jGrcdJiOx0/jkvIrDsZJIcyfoW6IZ2trPKE=
X-Received: by 2002:a0d:ca0d:0:b0:56d:770:c315 with SMTP id
 m13-20020a0dca0d000000b0056d0770c315mr3688060ywd.49.1686968333211; Fri, 16
 Jun 2023 19:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230517235314.GB10757@monkey> <CACw3F52zNguJ-MvXOAJuMK+JfreLxorvHDPwO8w_gQdOzWj7eA@mail.gmail.com>
 <20230519224214.GB3581@monkey> <20230522044557.GA845371@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp> <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp> <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey>
In-Reply-To: <20230616233447.GB7371@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 16 Jun 2023 19:18:41 -0700
Message-ID: <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
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

On Fri, Jun 16, 2023 at 4:35=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 06/16/23 14:19, Jiaqi Yan wrote:
> > On Sun, Jun 11, 2023 at 9:19=E2=80=AFPM Naoya Horiguchi
> > <naoya.horiguchi@linux.dev> wrote:
> > >
> > > On Fri, Jun 09, 2023 at 10:48:47PM -0700, Jiaqi Yan wrote:
> > > > On Thu, May 25, 2023 at 5:28=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.=
com> wrote:
> > > > >
> > > > > On Mon, May 22, 2023 at 7:43=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=
=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > >
> > > > > > On Mon, May 22, 2023 at 11:22:49AM -0700, Jiaqi Yan wrote:
> > > > > > > On Sun, May 21, 2023 at 9:50=E2=80=AFPM HORIGUCHI NAOYA(=E5=
=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, May 19, 2023 at 03:42:14PM -0700, Mike Kravetz wrot=
e:
> > > > > > > > > On 05/19/23 13:54, Jiaqi Yan wrote:
> > > > > > > > > > On Wed, May 17, 2023 at 4:53=E2=80=AFPM Mike Kravetz <m=
ike.kravetz@oracle.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 05/17/23 16:09, Jiaqi Yan wrote:
> > > > > > > > > > > > Adds the functionality to search a subpage's corres=
ponding raw_hwp_page
> > > > > > > > > > > > in hugetlb page's HWPOISON list. This functionality=
 can also tell if a
> > > > > > > > > > > > subpage is a raw HWPOISON page.
> > > > > > > > > > > >
> > > > > > > > > > > > Exports this functionality to be immediately used i=
n the read operation
> > > > > > > > > > > > for hugetlbfs.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  include/linux/mm.h  | 23 +++++++++++++++++++++++
> > > > > > > > > > > >  mm/memory-failure.c | 26 ++++++++++++++++---------=
-
> > > > > > > > > > > >  2 files changed, 39 insertions(+), 10 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.=
h
> > > > > > > > > > > > index 27ce77080c79..f191a4119719 100644
> > > > > > > > > > > > --- a/include/linux/mm.h
> > > > > > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > > > >
> > > > > > > > > > > Any reason why you decided to add the following to li=
nux/mm.h instead of
> > > > > > > > > > > linux/hugetlb.h?  Since it is hugetlb specific I woul=
d have thought
> > > > > > > > > > > hugetlb.h was more appropriate.
> > > > > > > > > > >
> > > > > > > > > > > > @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
> > > > > > > > > > > >   */
> > > > > > > > > > > >  extern const struct attribute_group memory_failure=
_attr_group;
> > > > > > > > > > > >
> > > > > > > > > > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > > > > +/*
> > > > > > > > > > > > + * Struct raw_hwp_page represents information abou=
t "raw error page",
> > > > > > > > > > > > + * constructing singly linked list from ->_hugetlb=
_hwpoison field of folio.
> > > > > > > > > > > > + */
> > > > > > > > > > > > +struct raw_hwp_page {
> > > > > > > > > > > > +     struct llist_node node;
> > > > > > > > > > > > +     struct page *page;
> > > > > > > > > > > > +};
> > > > > > > > > > > > +
> > > > > > > > > > > > +static inline struct llist_head *raw_hwp_list_head=
(struct folio *folio)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     return (struct llist_head *)&folio->_hugetlb_=
hwpoison;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +/*
> > > > > > > > > > > > + * Given @subpage, a raw page in a hugepage, find =
its location in @folio's
> > > > > > > > > > > > + * _hugetlb_hwpoison list. Return NULL if @subpage=
 is not in the list.
> > > > > > > > > > > > + */
> > > > > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct foli=
o *folio,
> > > > > > > > > > > > +                                    struct page *s=
ubpage);
> > > > > > > > > > > > +#endif
> > > > > > > > > > > > +
> > > > > > > > > > > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || define=
d(CONFIG_HUGETLBFS)
> > > > > > > > > > > >  extern void clear_huge_page(struct page *page,
> > > > > > > > > > > >                           unsigned long addr_hint,
> > > > > > > > > > > > diff --git a/mm/memory-failure.c b/mm/memory-failur=
e.c
> > > > > > > > > > > > index 5b663eca1f29..c49e6c2d1f07 100644
> > > > > > > > > > > > --- a/mm/memory-failure.c
> > > > > > > > > > > > +++ b/mm/memory-failure.c
> > > > > > > > > > > > @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_ki=
ll_procs);
> > > > > > > > > > > >  #endif /* CONFIG_FS_DAX */
> > > > > > > > > > > >
> > > > > > > > > > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > > > > > > > > > > -/*
> > > > > > > > > > > > - * Struct raw_hwp_page represents information abou=
t "raw error page",
> > > > > > > > > > > > - * constructing singly linked list from ->_hugetlb=
_hwpoison field of folio.
> > > > > > > > > > > > - */
> > > > > > > > > > > > -struct raw_hwp_page {
> > > > > > > > > > > > -     struct llist_node node;
> > > > > > > > > > > > -     struct page *page;
> > > > > > > > > > > > -};
> > > > > > > > > > > >
> > > > > > > > > > > > -static inline struct llist_head *raw_hwp_list_head=
(struct folio *folio)
> > > > > > > > > > > > +struct raw_hwp_page *find_raw_hwp_page(struct foli=
o *folio,
> > > > > > > > > > > > +                                    struct page *s=
ubpage)
> > > > > > > > > > > >  {
> > > > > > > > > > > > -     return (struct llist_head *)&folio->_hugetlb_=
hwpoison;
> > > > > > > > > > > > +     struct llist_node *t, *tnode;
> > > > > > > > > > > > +     struct llist_head *raw_hwp_head =3D raw_hwp_l=
ist_head(folio);
> > > > > > > > > > > > +     struct raw_hwp_page *hwp_page =3D NULL;
> > > > > > > > > > > > +     struct raw_hwp_page *p;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     llist_for_each_safe(tnode, t, raw_hwp_head->f=
irst) {
> > > > > > > > > > >
> > > > > > > > > > > IIUC, in rare error cases a hugetlb page can be poiso=
ned WITHOUT a
> > > > > > > > > > > raw_hwp_list.  This is indicated by the hugetlb page =
specific flag
> > > > > > > > > > > RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreli=
able().
> > > > > > > > > > >
> > > > > > > > > > > Looks like this routine does not consider that case. =
 Seems like it should
> > > > > > > > > > > always return the passed subpage if folio_test_hugetl=
b_raw_hwp_unreliable()
> > > > > > > > > > > is true?
> > > > > > > > > >
> > > > > > > > > > Thanks for catching this. I wonder should this routine =
consider
> > > > > > > > > > RawHwpUnreliable or should the caller do.
> > > > > > > > > >
> > > > > > > > > > find_raw_hwp_page now returns raw_hwp_page* in the llis=
t entry to
> > > > > > > > > > caller (valid one at the moment), but once RawHwpUnreli=
able is set,
> > > > > > > > > > all the raw_hwp_page in the llist will be kfree(), and =
the returned
> > > > > > > > > > value becomes dangling pointer to caller (if the caller=
 holds that
> > > > > > > > > > caller long enough). Maybe returning a bool would be sa=
fer to the
> > > > > > > > > > caller? If the routine returns bool, then checking RawH=
wpUnreliable
> > > > > > > > > > can definitely be within the routine.
> > > > > > > > >
> > > > > > > > > I think the check for RawHwpUnreliable should be within t=
his routine.
> > > > > > > > > Looking closer at the code, I do not see any way to synch=
ronize this.
> > > > > > > > > It looks like manipulation in the memory-failure code wou=
ld be
> > > > > > > > > synchronized via the mf_mutex.  However, I do not see how=
 traversal and
> > > > > > > > > freeing of the raw_hwp_list  called from __update_and_fre=
e_hugetlb_folio
> > > > > > > > > is synchronized against memory-failure code modifying the=
 list.
> > > > > > > > >
> > > > > > > > > Naoya, can you provide some thoughts?
> >
> > Hi Mike,
> >
> > Now looking again this, I think concurrent adding and deleting are
> > fine with each other and with themselves, because raw_hwp_list is
> > lock-less llist.
>
> Correct.
>
> > As for synchronizing traversal with adding and deleting, I wonder is
> > it a good idea to make __update_and_free_hugetlb_folio hold
> > hugetlb_lock before it folio_clear_hugetlb_hwpoison(which traverse +
> > delete raw_hwp_list)? In hugetlb, get_huge_page_for_hwpoison already
> > takes hugetlb_lock; it seems to me __update_and_free_hugetlb_folio is
> > missing the lock.
>
> I do not think the lock is needed.  However, while looking more closely
> at this I think I discovered another issue.
> This is VERY subtle.
> Perhaps Naoya can help verify if my reasoning below is correct.
>
> In __update_and_free_hugetlb_folio we are not operating on a hugetlb page=
.
> Why is this?
> Before calling update_and_free_hugetlb_folio we call remove_hugetlb_folio=
.
> The purpose of remove_hugetlb_folio is to remove the huge page from the
> list AND compound page destructor indicating this is a hugetlb page is ch=
anged.
> This is all done while holding the hugetlb lock.  So, the test for
> folio_test_hugetlb(folio) is false.
>
> We have technically a compound non-hugetlb page with a non-null raw_hwp_l=
ist.
>
> Important note: at this time we have not reallocated vmemmap pages if
> hugetlb page was vmemmap optimized.  That is done later in
> __update_and_free_hugetlb_folio.


>
> The 'good news' is that after this point get_huge_page_for_hwpoison will
> not recognize this as a hugetlb page, so nothing will be added to the
> list.  There is no need to worry about entries being added to the list
> during traversal.
>
> The 'bad news' is that if we get a memory error at this time we will
> treat it as a memory error on a regular compound page.  So,
> TestSetPageHWPoison(p) in memory_failure() may try to write a read only
> struct page. :(

At least I think this is an issue.

Would it help if dissolve_free_huge_page doesn't unlock hugetlb_lock
until update_and_free_hugetlb_folio is done, or basically until
dissolve_free_huge_page is done?

TestSetPageHWPoison in memory_failure is called after
try_memory_failure_hugetlb, and folio_test_hugetlb is tested within
__get_huge_page_for_hwpoison, which is wrapped by the hugetlb_lock. So
by the time dissolve_free_huge_page returns, subpages already go
through hugetlb_vmemmap_restore and __destroy_compound_gigantic_folio
and become non-compound raw pages (folios). Now
folio_test_hugetlb(p)=3Dfalse will be correct for memory_failure, and it
can recover p as a dissolved non-hugetlb page.


> --
> Mike Kravetz
