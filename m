Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF93E711A31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjEYWdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:33:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6E95
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:33:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2561e5fcdffso194210a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685054021; x=1687646021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it1+6Jg22xuuOE9SYPAN/iwlzZWUeu8495FiEy3sBB4=;
        b=LPvC+uHpAP0av52DhugHetYXjt4cMNNYKSwV2HzaHLIBMRWuQ4Pja4It29dCkjjjxo
         0X1A+e+/EkNNd4XcWvNZ4WMzmbrNTNS2UibgKnA+QMW1rrtnIrptgVvvDeEzekwu6wkI
         6D/Nk09iPiFSMp2k0OHcc+NPZZBu5iPJmbne15OaEcNMz1T34sAZFmfNXTLi0kI7mbpb
         ER9wzYIh93XU+DyxZhOu//36NsgCHgJBdJzHqhp6pFO+2IpqufododvHGaxrnFqMh5+5
         +/ETeTOCeCsYvcKkG0vRzyLyXFOHb3JrGU2n7UYG480gjBnP78CbOZ5WeQmwZJ8Bx82b
         IHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685054021; x=1687646021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it1+6Jg22xuuOE9SYPAN/iwlzZWUeu8495FiEy3sBB4=;
        b=TZQrzWY7YCprDMcVbsjcPIh4zrBFL5bP0H5Qx1qFF501f8ApbcXv+LFV+IRzLx171q
         yWVm4kxflwJhPs+MR1h3QsJ3ySBAK2BdfGhmAaurslEJRCneXGDSgMct7g6W1PgcXrUG
         REhk3pcKYdeCqdEHQL7LdndwgkH0M2JFDYQj15CxTbBcsfmbWybXbb/XNDxwVKNb1piC
         mqjb921xBgBMw6w/ouOX8U8Hfn1UU36ZRd89SNo0rubJ/pio4Agz6Z/iUFVGWTjYgAgj
         9K7kCMgm9hbxOwVpSXx60g9o22WF76HvlrsoVJzt7BABd+vd38ToOUhrHLfg26xioOQo
         Z2Ng==
X-Gm-Message-State: AC+VfDy4vn4V2nJx51q+0byZQkJHPWwnuv64s5TViLUkud0lbvxz8fVt
        oXSvdaFlY4g47U85knQgnfuAsTxlGpNYDqLh4Ykw9g7v3+k=
X-Google-Smtp-Source: ACHHUZ6t0QJ7YQpCpJi+CO5H2M5VDiG9VJSR4X8q/Jyc6UBpQX/qJ2MAhwjTgB1kJZ3tLOpIxEDkLnnFNffIaExm6Jo=
X-Received: by 2002:a17:90a:3189:b0:253:8c39:642 with SMTP id
 j9-20020a17090a318900b002538c390642mr271989pjb.5.1685054021219; Thu, 25 May
 2023 15:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com> <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com>
 <CAHbLzkpOs4fz5NuAzQDdMRQYDLn6HzR1CHQoU5OYZyPW1GQmHg@mail.gmail.com>
 <3d548f45-9ff9-d73a-83e0-bdd312f524@google.com> <CAHbLzkrkGx-+OVLexWAx0THeOsD1C1DHt2VjgnkYJe-MqeW3Zw@mail.gmail.com>
 <7538c751-9bee-75f9-50a5-1bc12f919e8e@google.com>
In-Reply-To: <7538c751-9bee-75f9-50a5-1bc12f919e8e@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 25 May 2023 15:33:29 -0700
Message-ID: <CAHbLzkobBuHGKdEXh02e54Vzd_1yyvuShKUYMxTGWtqGXrrVYQ@mail.gmail.com>
Subject: Re: [PATCH 25/31] mm/gup: remove FOLL_SPLIT_PMD use of pmd_trans_unstable()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Thu, May 25, 2023 at 2:16=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Wed, 24 May 2023, Yang Shi wrote:
> > On Tue, May 23, 2023 at 9:26=E2=80=AFPM Hugh Dickins <hughd@google.com>=
 wrote:
> > > On Mon, 22 May 2023, Yang Shi wrote:
> > >
> > > > For other unstable cases, it will return -ENOMEM instead of -EBUSY.
> > >
> > > I don't think so: the possibly-failing __pte_alloc() only gets called
> > > in the pmd_none() case.
> >
> > I mean what if pmd is not none for huge zero page. If it is not
> > pmd_none pte_alloc() just returns 0,
>
> Yes, I agree with you on that.
>
> > then returns -ENOMEM instead of -EBUSY.
>
> But disagree with you on that.
>
>                 return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
>                         follow_page_pte(vma, address, pmd, flags, &ctx->p=
gmap);
>
> Doesn't that say that if pte_alloc() returns 0, then follow_page_mask()
> will call follow_page_pte() and return whatever that returns?

Err... you are right. I misread the code. Anyway it returns -ENOMEM
instead of -EBUSY when pmd is none and pte alloc fails. Returning
-ENOMEM does make sense for this case. Is it worth some words in the
commit log for the slight behavior change?

>
> > Or it is impossible that pmd end up being pmd_huge_trans or
> > !pmd_present? It should be very unlikely, for example, migration does
> > skip huge zero page, but I'm not sure whether there is any corner case
> > that I missed.
>
> I'm assuming both are possible there (but not asserting that they are).
>
> Hugh
