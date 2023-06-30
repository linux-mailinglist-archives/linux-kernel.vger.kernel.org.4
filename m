Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19277443B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjF3U7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF3U7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:59:36 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726553C32
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:59:35 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57725e1c24bso25623097b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688158774; x=1690750774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htaQAn0uld1gRzcRPOpYgkB/211lBPerbZN4rs35mJs=;
        b=XOy89UpZ3ktzJ2RHAFbO3jk29h41leDaxvLHRKDZhDZhGgq2bhSqHwliKtytlzcap1
         qk5qFq8MLFn+Kw948uWoIXHEY/VDGiiuLCM6At60qTx3FfskH+ZrUwV0ioM51zt6Q50L
         xUTZ42BEj9NjEgfaWDYqRexX7MlWix9NwNPX5kVrCy/RFCd7ZYzGRROj+iqgklQH2dcp
         8huGga/08rIoSSbjxMnSe5T+2PJo4c05o+IwfypFmUeEm5CJqcO71E69KrFoGX4OfCKF
         CrOXK7YV7aI5k8097KP27RbfrKEQfcm3lvqVqQFLa5ADz2PkLv4zjrdclleJpN817C4a
         GnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688158774; x=1690750774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htaQAn0uld1gRzcRPOpYgkB/211lBPerbZN4rs35mJs=;
        b=DPd1qCa56Ag+ljCvX+R+3Fwfw3kbT0YCTFPNWXeH3OZaUepwwzHOPPYEb10Cd5hWlz
         8+5x3MU2Otav8RngPBRSX7kryCgvOYtdLKUfZuKihfqPmF3GbPHZPXlI4iTd/AmDrezh
         W4NIbWAiDKOAXWWix9NJ6V8oWO0/07gwDL7uCOaYH1aaMIfm7DGBXUCE4xIsIpHTKPui
         KDuCLAfVPtm4ptq82F4wb/zj2qNHR61KLIzrLpBQ8AU1KJYDBsZj/WfRQR3BlKAhfWrE
         oE6y77jc5eoRfjbuu5l61HEAqc2JMGXEgV5G360QN3Qg5JAjhDwOSsmGkpqIgcrrls1y
         NAOg==
X-Gm-Message-State: ABy/qLbW9HG4kTO9V+3kZD0l/FDpwxMl3HxG5FVm8AeZxozUw79wayay
        Vp+tJxh/7NkB9NRvBvepCgpkpxHYJ6KABOf+FftC3A==
X-Google-Smtp-Source: APBJJlGWvQImsRpqU9abwLuPZ+Fv4ioP36u/BXqVT4sig4o5DeHL/HagtPVLJyENRM1nAyQEZg8Xk+jECQVTLh4Luoc=
X-Received: by 2002:a81:a149:0:b0:570:6654:68c8 with SMTP id
 y70-20020a81a149000000b00570665468c8mr3837105ywg.1.1688158774568; Fri, 30 Jun
 2023 13:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com> <20230623164015.3431990-2-jiaqiyan@google.com>
 <20230630145217.GA2213127@ik1-406-35019.vs.sakura.ne.jp>
In-Reply-To: <20230630145217.GA2213127@ik1-406-35019.vs.sakura.ne.jp>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 30 Jun 2023 13:59:23 -0700
Message-ID: <CACw3F52R8oUNP50dfy35m1KED82NKgKcHKk3ev4O+4nqhFVdzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/hwpoison: delete all entries before traversal
 in __folio_free_raw_hwp
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
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

On Fri, Jun 30, 2023 at 7:52=E2=80=AFAM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Fri, Jun 23, 2023 at 04:40:12PM +0000, Jiaqi Yan wrote:
> > Traversal on llist (e.g. llist_for_each_safe) is only safe AFTER entrie=
s
> > are deleted from the llist.
> >
> > llist_del_all are lock free with itself. folio_clear_hugetlb_hwpoison()=
s
> > from __update_and_free_hugetlb_folio and memory_failure won't need
> > explicit locking when freeing the raw_hwp_list.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> (Sorry if stupid question...) folio_set_hugetlb_hwpoison() also calls
> llist_for_each_safe() but it still traverses the list without calling
> llist_del_all().  This convention applies only when removing item(s)?

I think in our previous discussion, Mike and I agree as of today's
code in hugetlb.c and memory-failure.c, concurrent adding, deleting,
traversing are fine with each other and with themselves [1], but new
code need to be careful wrt ops on raw_hwp_list.

This patch is a low-hanging fruit to ensure any caller of
__folio_free_raw_hwp won't introduce any problem by correcting one
thing in __folio_free_raw_hwp: since it wants to delete raw_hwp_page
entries in the list, it should do it by first llist_del_all, and then
kfree with a llist_for_each_safe.

As for folio_set_hugetlb_hwpoison, I am not very comfortable fixing
it. I imagine a way to fix it is llist_del_all() =3D>
llist_for_each_safe{...} =3D> llist_add_batch(), or llist_add() within
llist_for_each_safe{...}. I haven't really thought through if this is
a correct fix.

[1] https://lore.kernel.org/lkml/CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=3DKn+aOQs0=
=3DqpfG-ZYDFKg@mail.gmail.com/#t


>
> Thanks,
> Naoya Horiguchi
>
> > ---
> >  mm/memory-failure.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 004a02f44271..c415c3c462a3 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1825,12 +1825,11 @@ static inline struct llist_head *raw_hwp_list_h=
ead(struct folio *folio)
> >
> >  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool mo=
ve_flag)
> >  {
> > -     struct llist_head *head;
> > -     struct llist_node *t, *tnode;
> > +     struct llist_node *t, *tnode, *head;
> >       unsigned long count =3D 0;
> >
> > -     head =3D raw_hwp_list_head(folio);
> > -     llist_for_each_safe(tnode, t, head->first) {
> > +     head =3D llist_del_all(raw_hwp_list_head(folio));
> > +     llist_for_each_safe(tnode, t, head) {
> >               struct raw_hwp_page *p =3D container_of(tnode, struct raw=
_hwp_page, node);
> >
> >               if (move_flag)
> > @@ -1840,7 +1839,6 @@ static unsigned long __folio_free_raw_hwp(struct =
folio *folio, bool move_flag)
> >               kfree(p);
> >               count++;
> >       }
> > -     llist_del_all(head);
> >       return count;
> >  }
> >
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
> >
> >
