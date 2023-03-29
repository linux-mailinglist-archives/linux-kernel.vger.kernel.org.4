Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC016CEFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjC2QqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjC2QqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:46:11 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F4C527D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:46:07 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54606036bb3so138235487b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680108366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyYGJHwbzUCXb4y32Pa60ou/Hi+y+ZvE44Fz2eCrQLQ=;
        b=iDGYs//gI2i/1fvcvqQRE2YI543Sc2+B+2QnklKYVuLUjtRJMt2o3Y00AZCjgFWTZM
         56FWZS7UyGDgHbcKVXF5qvX6xgXmqXLrx+5QMvI92ckqXs8Lnk29jBJNkc0UOw1TRTsm
         eXTl45FH6e0rDDgoYKFk1I9b0GPTl/dRfb1XzhLt0AqKD2UnqHawwxmiY9EV5eQQFeCC
         tl0YKv99LFnb9DPRve4MVjIc8yzLTu115MSGmhGjiV0Sqxj7hcvcuEzZYCCoTOb58Ht4
         q6JyyvonRntR578MnkzpMvGWTCIexQ1kRWjfjAUitjyrw/eOLtxrguF64o6Q/ZHJ8B6e
         ZYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyYGJHwbzUCXb4y32Pa60ou/Hi+y+ZvE44Fz2eCrQLQ=;
        b=oUqgzifrCZgLfwseSekkGvRaxE4ClSfI4DP34PR6uwKmUZRi0c5twKvDFnhGj7xeSm
         1ne8sUSXu4+jHHfueVDHKbk1REomr6T0c180k6HKWhb4SjtogvIRS6+S4C2sbA3R+5Y6
         +erc68QyjB1gcKkuGArxScmMteJe3/C6Ideo4162+Q02GijelAMq2KzD+zNF5f6ldG44
         6TFqoH/73sBwglE9ktI9kSETLhYcXbleN64l5venACfUfrnEzMIvxJFssxEEnR02OIlj
         1EyItuXlrDoB9pSMhKRpCNQLKycP3MCoRIdLXnDr9w4cHITjF0e/hhq26FGhYi4MPLCj
         2YrQ==
X-Gm-Message-State: AAQBX9fETJ0ewqxQKo9+PCv417soNlWTWGoLgWTh7itbBgN8Ym9tQHpM
        U7u4fJSHDXlekr3HjDRPWNs72BwnGDh2kQD/ZIEvnQ==
X-Google-Smtp-Source: AKy350aIj9rMEyRSpwht5dqjJJGGj34ioNUDhMROVb71O9JE5qD2Kdevyi040wyXqyVUlTqEGIXnQigg1Ugi71u5cdU=
X-Received: by 2002:a0d:ec48:0:b0:545:f7cc:f30 with SMTP id
 r8-20020a0dec48000000b00545f7cc0f30mr5126792ywn.0.1680108366530; Wed, 29 Mar
 2023 09:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230328125818.5574-1-jaewon31.kim@samsung.com>
 <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcms1p6>
 <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com> <20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc@epcms1p6>
In-Reply-To: <20230329031302epcms1p6afc9d9d8e92db6a39c29044606d21afc@epcms1p6>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 29 Mar 2023 09:45:55 -0700
Message-ID: <CABdmKX3c+qK6ekhujkH9fo8bNagmd-M=a=ZWF3HOq1C0EzHs8g@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
To:     jaewon31.kim@samsung.com
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 8:13=E2=80=AFPM Jaewon Kim <jaewon31.kim@samsung.co=
m> wrote:
>
> >On Tue, Mar 28, 2023 at 5:58?AM Jaewon Kim <jaewon31.kim@samsung.com> wr=
ote:
> >>
> >> Normal free:212600kB min:7664kB low:57100kB high:106536kB
> >>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
> >>   active_file:1200kB inactive_file:0kB unevictable:2932kB
> >>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
> >>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
> >>   free_cma:200844kB
> >> Out of memory and no killable processes...
> >> Kernel panic - not syncing: System is deadlocked on memory
> >>
> >> An OoM panic was reported, there were only native processes which are
> >> non-killable as OOM_SCORE_ADJ_MIN.
> >>
> >> After looking into the dump, I've found the dma-buf system heap was
> >> trying to allocate a huge size. It seems to be a signed negative value=
.
> >>
> >> dma_heap_ioctl_allocate(inline)
> >>     |  heap_allocation =3D 0xFFFFFFC02247BD38 -> (
> >>     |    len =3D 0xFFFFFFFFE7225100,
> >>
> >> Actually the old ion system heap had policy which does not allow that
> >> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and li=
st
> >> bugs in system heap"). We need this change again. Single allocation
> >> should not be bigger than half of all memory.
> >>
> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> >> ---
> >>  drivers/dma-buf/heaps/system_heap.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/hea=
ps/system_heap.c
> >> index e8bd10e60998..4c1ef2ecfb0f 100644
> >> --- a/drivers/dma-buf/heaps/system_heap.c
> >> +++ b/drivers/dma-buf/heaps/system_heap.c
> >> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct=
 dma_heap *heap,
> >>         struct page *page, *tmp_page;
> >>         int i, ret =3D -ENOMEM;
> >>
> >> +       if (len / PAGE_SIZE > totalram_pages() / 2)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >
> >Instead of policy like that, would __GFP_RETRY_MAYFAIL on the system
> >heap's LOW_ORDER_GFP flags also avoid the panic, and eventually fail
> >the allocation request?
>
> Hello T.J.
>
> Thank you for your opinion.
> The __GFP_RETRY_MAYFAIL on LOW_ORDER_GFP seems to work.
>
> page allocation failure: order:0, mode:0x144dc2(GFP_HIGHUSER|__GFP_RETRY_=
MAYFAIL|__GFP_COMP|__GFP_ZERO)
> Node 0 active_anon:120kB inactive_anon:43012kB active_file:36kB inactive_=
file:788kB
>
> I tried to test it, and the allocation stopped at very low file cache sit=
uation without OoM panic
> as we expected. The phone device was freezing for few seconds though.
>
> We can avoid OoM panic through either totalram_pages() / 2 check or __GFP=
_RETRY_MAYFAIL.
>
> But I think we still need the totalram_pages() / 2 check so that we don't=
 have to suffer
> the freezing in UX perspective. We may kill some critical processes or us=
ers' recent apps.
>
> Regarding __GFP_RETRY_MAYFAIL, I think it will help us avoid OoM panic. B=
ut I'm worried
> about low memory devices which still need OoM kill to get memory like in =
camera scenarios.
>
> So what do you think?
>
Hey Jaewon, thanks for checking! The totalram_pages() / 2 just feels
somewhat arbitrary. On the lowest memory devices I'm aware of that use
the system heap it would take a single buffer on the order of several
hundred megabytes to exceed that, so I guess the simple check is fine
here until someone says they just can't live without a buffer that
big!

Reviewed-by: T.J. Mercier <tjmercier@google.com>
