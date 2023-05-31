Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C6718E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjEaWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjEaWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:24:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D29F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:24:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b14b4fa3a9so1183751fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685571885; x=1688163885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xEEVCf9dWgZm8ga2rYAVAw+sj18gzp6C7EL5xxgl/c=;
        b=Mij63zDEVeiloiLm+hqaRfi0f/u88rpzdjgQ727fVBY70XGvqoQgfV8CY62xhiGNyn
         KBr3y2Gzy/jIQDQke5SlUohDzW/yze8drT6rjkQtH5WOig0GCT78zwprf9b3ZxyMGf4J
         f+9PBDd+gwlDC3Blg1HPLz3enpJKhiEybsFa0/9e5KvCEoDJEB2jQofI1MK9sCDnsO0a
         AMNu7rsNrCPYsb/BEGu53jNuftbJubdk3HtPFPA0b3ma5UlFxXODCQsllP9FV67HLPyu
         GX6rWWsdN3MLvYMUmZ/JyMwfKv1bXa721iWcacQZN8Uqzkpu226CvyzK+65bNJiIrDe3
         sxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571885; x=1688163885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xEEVCf9dWgZm8ga2rYAVAw+sj18gzp6C7EL5xxgl/c=;
        b=IBzT3WZg1xKoo8T45eNqtWzVZkx9uplAvXPhNOOJ8K47mO83ymZ3N6jd8QJxLcIn9p
         lwx9tV1V7AqgDyoTMOFEP/ONgTECTgw2wonlaRgawx+Rlh71PAiz8OYS6Q70gRLkUnTC
         fMmrDfOTV/+qcCE+vJrhh6S7oceMKCJEbXbTqd4YUT9ddylhIxvmn4pipjGmyR6kFp/+
         CCvxlle+n+WzWmH8vdFgd4EFvJU5bRwYZ5TQGKvdzcu1WF6MPYn2iMG+IKGcWoP/9SG2
         k53GgsD9P6n+DgzbBdzup5zzntqFXzC7UJEQRcTabi+fPySSXDQiB2RHKgdtEc5YjNs6
         So1Q==
X-Gm-Message-State: AC+VfDxCx3crwXkKOJ+zTFnCMnfqm/EF16WWFTb0mBWBqdJ8ug4qw3Fv
        Pe9xwE9ZG0tbUFKD+J9FJfq8MAKxs9LoNAIQi3nULQ==
X-Google-Smtp-Source: ACHHUZ7Y3olHmhuujQ8aRt//y5QdoouXFKt3tQlwxylniNkns6cFS2bipCj/vr6O9cy+XlldeiDM4vB1POcgg+jrwmQ=
X-Received: by 2002:a2e:8ec6:0:b0:2a8:b286:826e with SMTP id
 e6-20020a2e8ec6000000b002a8b286826emr3600402ljl.33.1685571885077; Wed, 31 May
 2023 15:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230531221302.1664613-1-yosryahmed@google.com> <CAOUHufYydC9vSAMjCajvAr4Ka2qESAtOi5ZX-iaWtHPPgD_dPQ@mail.gmail.com>
In-Reply-To: <CAOUHufYydC9vSAMjCajvAr4Ka2qESAtOi5ZX-iaWtHPPgD_dPQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 31 May 2023 15:24:08 -0700
Message-ID: <CAJD7tkYW0dByrebxb-LPxuqa=wjJTRoP8X-z8Y+ch=-jKQnTyQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: multiple zpools support
To:     Yu Zhao <yuzhao@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, May 31, 2023 at 3:21=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, May 31, 2023 at 4:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > Support using multiple zpools of the same type in zswap, for concurrenc=
y
> > purposes. Add CONFIG_ZSWAP_NR_ZPOOLS_ORDER to control the number of
> > zpools. The order is specific by the config rather than the absolute
> > number to guarantee a power of 2. This is useful so that we can use
> > deterministically link each entry to a zpool by hashing the zswap_entry
> > pointer.
> >
> > On a setup with zswap and zsmalloc, comparing a single zpool (current
> > default) to 32 zpools (by setting CONFIG_ZSWAP_NR_ZPOOLS_ORDER=3D32) sh=
ows
> > improvements in the zsmalloc lock contention, especially on the swap ou=
t
> > path.
> >
> > The following shows the perf analysis of the swapout path when 10
> > workloads are simulatenously reclaiming and refaulting tmpfs pages.
>
> simultaneously
>
> > There are some improvements on the swap in path as well, but much less
> > significant.
>
> ...
>
> > ---
> >  mm/Kconfig | 12 +++++++
> >  mm/zswap.c | 91 ++++++++++++++++++++++++++++++++++++------------------
> >  2 files changed, 73 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 92c30879bf67..de1da56d2c07 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -59,6 +59,18 @@ config ZSWAP_EXCLUSIVE_LOADS
> >           The cost is that if the page was never dirtied and needs to b=
e
> >           swapped out again, it will be re-compressed.
> >
> > +config ZSWAP_NR_ZPOOLS_ORDER
> > +       int "Number of zpools in zswap, as power of 2"
> > +       default 0
> > +       depends on ZSWAP
> > +       help
> > +         This options determines the number of zpools to use for zswap=
, it
>
> option

Thanks for taking a look. Will correct both in v3 (if any). Otherwise,
I hope Andrew will fix them in-place :)
