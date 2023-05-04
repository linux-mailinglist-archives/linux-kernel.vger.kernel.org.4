Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7D6F64E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjEDGXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEDGXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:23:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0222D212B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:23:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4edc114c716so92354e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683181404; x=1685773404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rw+IDIOarKUAO5fsRYRnu60nZkjIV+GIcSxTSNaSis=;
        b=bsi1qEus+F/1+Desmkil2iihm3JzdFqNOBePrMFNM00fgHn6Q5MFcfa/LuNZA0Z7st
         rEtwZ9PGTxK6d/eAb5RUzTKo71LEvFnGb0zyYrvSbqVBh0Hzi50UWjTc/5x6HV6uJFsZ
         PD4EpP2o9rXKMg2OSkHh6j5hrhHelTlcpdESPxGjl3oDx+U7msjp6JczL+rtgheJGZbe
         +RPPoGcZ8+xSyx4na36hXx96ncCADs4H2AGbjiz7gkTHdC7AWCmCehTkGWfXO9pN4EIU
         l2zLXcA3ZXOyJbYJLDW7pniNUhIyQQtY5BlD5RPHJ8U29WH1tD8HVCvA1ONjtdFxRD2k
         J9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181404; x=1685773404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rw+IDIOarKUAO5fsRYRnu60nZkjIV+GIcSxTSNaSis=;
        b=AdU1s/xsZcDVdSVYID+BF9N/dl1hRNOkZ0nF1lt09NWWdSmv7Oyei5bcBfv9WsPRB7
         7zrneOA8+kQnOIgkKW+oZzSUWPlo/qeHg1aIt5JlZOcWWXl7dhwa3hd7/yIbZ4Qg8CxR
         87MJqx2Ruqq4T64x0sXd0vK+v2vBB3iy2Ii+546CwhGmaZTtUR/LkdlfcnZbIHY645Ve
         yEzMp0mMaD+66BskIMLL4vpAHK6r4En1Qtj/nksx+gGyzjNl3yvUj63yhM5D0vntLwvs
         sjqyPW39GRkfuKRMAw4Mz6JIBFluICLJzY5Ld85I1zNEI6STHAXtRMQHfpYWGjFcsp6P
         Kxcg==
X-Gm-Message-State: AC+VfDxZlv/BL2/EP5qdiHevWX8Kk9G6By8XoU7ipLqR82xo2DtU9yuh
        joupa8suxFOYON6fm0wqZTRlkZ/yLWNTTikownWGDvkEzuw=
X-Google-Smtp-Source: ACHHUZ6B6G8hbYCEVPQrXZA7sCKolbUnwLl2RQFpLdiQyqmHfGXTul/dSaZPAFeYol/zeakgO/sMcdaSv68bylZou3I=
X-Received: by 2002:a19:ac43:0:b0:4f1:43e7:47c4 with SMTP id
 r3-20020a19ac43000000b004f143e747c4mr175455lfc.36.1683181403815; Wed, 03 May
 2023 23:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZE/y5wMggipQrKvb@P9FQF9L96D> <e0bd4476c7854cbfafea0ced9569220c@BJMBX01.spreadtrum.com>
 <ZFGIN5Gnc2W7LhmK@P9FQF9L96D.corp.robot.car> <CAGWkznGpi7YKYeNcKrOr=58=4VApq285ocCPVh22HJCWwCU85Q@mail.gmail.com>
 <ZFKMCBWvOqMk3g1V@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZFKMCBWvOqMk3g1V@P9FQF9L96D.corp.robot.car>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 4 May 2023 14:23:01 +0800
Message-ID: <CAGWkznG5V+=onj9TsEhwh=Pxqt9+-KJAHLAoLJRMQ5-ysnwDgQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_mm=3A_optimization_on_page_allocat?=
        =?UTF-8?Q?ion_when_CMA_enabled?=
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        "fangzheng.zhang@unisoc.com" <fangzheng.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 12:30=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, May 03, 2023 at 03:58:21PM +0800, Zhaoyang Huang wrote:
> > On Wed, May 3, 2023 at 6:01=E2=80=AFAM Roman Gushchin <roman.gushchin@l=
inux.dev> wrote:
> > >
> > > On Tue, May 02, 2023 at 12:12:28PM +0000, =E9=BB=84=E6=9C=9D=E9=98=B3=
 (Zhaoyang Huang) wrote:
> > > > > Hi Zhaoyang!
> > > > >
> > > > > On Fri, Apr 28, 2023 at 07:00:41PM +0800, zhaoyang.huang wrote:
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > Please be notice bellowing typical scenario that commit 1686766=
49
> > > > > > introduce, that is, 12MB free cma pages 'help' GFP_MOVABLE to k=
eep
> > > > > > draining/fragmenting U&R page blocks until they shrink to 12MB =
without
> > > > > > enter slowpath which against current reclaiming policy. This co=
mmit change
> > > > > the criteria from hard coded '1/2'
> > > > > > to watermark check which leave U&R free pages stay around WMARK=
_LOW
> > > > > > when being fallback.
> > > > >
> > > > > Can you, please, explain the problem you're solving in more detai=
ls?
> > > > I am trying to solve a OOM problem caused by slab allocation fail a=
s all free pages are MIGRATE_CMA by applying 168676649, which could help to=
 reduce the fault ration from 12/20 to 2/20. I noticed it introduce the phe=
nomenon which I describe above.
> > > > >
> > > > > If I understand your code correctly, you're effectively reducing =
the use of cma
> > > > > areas for movable allocations. Why it's good?
> > > > Not exactly. In fact, this commit lead to the use of cma early than=
 it is now, which could help to protect U&R be 'stolen' by GFP_MOVABLE. Ima=
gine this scenario, 30MB total free pages composed of 10MB CMA and 20MB U&R=
, while zone's watermark low is 25MB. An GFP_MOVABLE allocation can keep st=
ealing U&R pages(don't meet 1/2 criteria) without enter slowpath(zone_water=
mark_ok(WMARK_LOW) is true) until they shrink to 15MB. In my opinion, it ma=
kes more sense to have CMA take its duty to help movable allocation when U&=
R lower to certain zone's watermark instead of when their size become small=
er than CMA.
> > > > > Also, this is a hot path, please, make sure you're not adding muc=
h overhead.
> > > > I would like to take more thought.
> > >
> > > Got it, thank you for the explanation!
> > >
> > > How about the following approach (completely untested)?
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 6da423ec356f..4b50f497c09d 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2279,12 +2279,13 @@ __rmqueue(struct zone *zone, unsigned int ord=
er, int migratetype,
> > >         if (IS_ENABLED(CONFIG_CMA)) {
> > >                 /*
> > >                  * Balance movable allocations between regular and CM=
A areas by
> > > -                * allocating from CMA when over half of the zone's f=
ree memory
> > > -                * is in the CMA area.
> > > +                * allocating from CMA when over half of the zone's e=
asily
> > > +                * available free memory is in the CMA area.
> > >                  */
> > >                 if (alloc_flags & ALLOC_CMA &&
> > >                     zone_page_state(zone, NR_FREE_CMA_PAGES) >
> > > -                   zone_page_state(zone, NR_FREE_PAGES) / 2) {
> > > +                   (zone_page_state(zone, NR_FREE_PAGES) -
> > > +                    zone->_watermark[WMARK_LOW]) / 2) {
> > IMO, we should focus on non-cma area which trigger use of cma when
> > they are lower than corresponding watermark(there is still
> > WMARK_MIN/HIGH to deal with within slowpath)
> > >                         page =3D __rmqueue_cma_fallback(zone, order);
> > >                         if (page)
> > >                                 return page;
> > >
> > > Basically the idea is to keep free space equally split between cma an=
d non-cma areas.
> > > Will it work for you?
> > I don't think it makes sense to 'equally split' cma and non-cma areas
> > over free space while cma could occupy various proportions in a single
> > zone. This fixed 1/2 could lead to different situation on 20% or 50%
> > cma occupation.
>
> Can you then, please, explain in details what you're proposing instead
> and why it's better (not only in your case, but generally as well)?
> For the context, my original usecase was cma size under 10G and
> the total memory size between 32G and 128G.

Let us look at the series of scenarios below with
WMARK_LOW=3D25MB,WMARK_MIN=3D5MB(managed pages 1.9GB). We can know that
1. optimized 1/2 method start to use CMA since D which actually has
caused U&R lower than WMARK_LOW (this could be deemed as against
current memory policy, that is, U&R should either keeping stay  around
WATERMARK_LOW or enter slowpath to do reclaiming)
2. it keep using CMA as long as free pages keep shrinking (this is
against the original desire of balance cma & none-cma area)

free_cma/free_pages(MB)        A(12/30)     B(10/25)     C(8/25)
D(8/20)     E(8/16)     F(5/12)     F(5/10)   G(4/8)
optimized 1/2                                N                 N
         N             Y               Y                Y
Y            Y
!zone_watermark_ok                    Y                  Y
   Y             N               N                N            Y
     Y

>
> Looking at your original patch, I see that __if_use_cma_first() always re=
turns
> false if zone_watermark_ok() returns true. It worries me.
ok. we could deal with the scenario here when free pages is higher
than WMARK_HIGH
>
> Thanks!
