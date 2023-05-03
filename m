Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111106F5269
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjECH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:58:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8762198E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:58:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4efec123b28so6117359e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683100724; x=1685692724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDGY0xJAU8Y7HztZyvyAB9vXE6wA5gbSmqoQkXQgFnQ=;
        b=cRzgV70idcY5OAcFkQkiInku3fp47uJpyuCvW43e2jvEY4bWMytUpe4/XzzBnuuNhT
         7UK4oHej1MljNCDtoEeAIS5I/2nNcpwiM5PcLun0Lz/XYJdp+f19I7qXVsk07N068FDm
         FfehpoWMrFFt3f/ZzL6XvwMRrJ0ZpjYOnEkiCWRHpeMd1AVDePGM8tv65rY/skpwNvx2
         GjQimojkZRjgZ5/4NB9xrXYwG1aehpDTpY525Dncvv2fTOx6JY76OxIoc+QvzXDmwR8M
         EnMYXG5WjIc0xN3e5yBem1On7A4iWxgHHt6KB5IgCyzW40MSx30mBZfrYFQRnJE43VKn
         j0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683100724; x=1685692724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDGY0xJAU8Y7HztZyvyAB9vXE6wA5gbSmqoQkXQgFnQ=;
        b=ULCcn4z0YjtrMCuGEGgOxCWi6q3CvTcOj73f5muieMAw1yjcWicNagcF1qkK+9lMHg
         38ZCfEkTgjxy8P9tNKEMWYPa/kri2t5NC3t4OFRB3mDQG8+mSn/Ims2s2wm8rhIgw1mN
         n8VZXR+7AgT9/vvSqZ0TRZklFDYs4kvWRd4aO4jVwYp8G33kxuJemWZc6VRep9evhfl0
         UMa7H1Pgqytei4+ft3p2rody7mhCOE6hTEA4WQmaEC56M4MjTvoGgOlZ1kYy6tFhRp7v
         iRBd1/AMpQGdrhGrp05+Rkz99RGCco7puWUGhvziaZ9vJD7FlyF/Jn7x1RBm7mRgyr+d
         acHw==
X-Gm-Message-State: AC+VfDxZY5arcr5yE33qDfjl7tzaz5JZCWcGuCbaCsHJXRUrdvzoaFWs
        IgDM7VxppSYqj3A8VS+tJ4T9p3ZdHYCFhEtnYaI=
X-Google-Smtp-Source: ACHHUZ7AfPl333sQFEZoS8+XsAzLyGa/fd7n5K3R9wLSWEu6GHHgvfqFP4ULp2rIo9kyKf8Tigto8Lpn7RTncK5Glew=
X-Received: by 2002:ac2:5dc5:0:b0:4ef:bcb6:a74c with SMTP id
 x5-20020ac25dc5000000b004efbcb6a74cmr742094lfq.61.1683100724016; Wed, 03 May
 2023 00:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZE/y5wMggipQrKvb@P9FQF9L96D> <e0bd4476c7854cbfafea0ced9569220c@BJMBX01.spreadtrum.com>
 <ZFGIN5Gnc2W7LhmK@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZFGIN5Gnc2W7LhmK@P9FQF9L96D.corp.robot.car>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 3 May 2023 15:58:21 +0800
Message-ID: <CAGWkznGpi7YKYeNcKrOr=58=4VApq285ocCPVh22HJCWwCU85Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_mm=3A_optimization_on_page_allocat?=
        =?UTF-8?Q?ion_when_CMA_enabled?=
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
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

On Wed, May 3, 2023 at 6:01=E2=80=AFAM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> On Tue, May 02, 2023 at 12:12:28PM +0000, =E9=BB=84=E6=9C=9D=E9=98=B3 (Zh=
aoyang Huang) wrote:
> > > Hi Zhaoyang!
> > >
> > > On Fri, Apr 28, 2023 at 07:00:41PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Please be notice bellowing typical scenario that commit 168676649
> > > > introduce, that is, 12MB free cma pages 'help' GFP_MOVABLE to keep
> > > > draining/fragmenting U&R page blocks until they shrink to 12MB with=
out
> > > > enter slowpath which against current reclaiming policy. This commit=
 change
> > > the criteria from hard coded '1/2'
> > > > to watermark check which leave U&R free pages stay around WMARK_LOW
> > > > when being fallback.
> > >
> > > Can you, please, explain the problem you're solving in more details?
> > I am trying to solve a OOM problem caused by slab allocation fail as al=
l free pages are MIGRATE_CMA by applying 168676649, which could help to red=
uce the fault ration from 12/20 to 2/20. I noticed it introduce the phenome=
non which I describe above.
> > >
> > > If I understand your code correctly, you're effectively reducing the =
use of cma
> > > areas for movable allocations. Why it's good?
> > Not exactly. In fact, this commit lead to the use of cma early than it =
is now, which could help to protect U&R be 'stolen' by GFP_MOVABLE. Imagine=
 this scenario, 30MB total free pages composed of 10MB CMA and 20MB U&R, wh=
ile zone's watermark low is 25MB. An GFP_MOVABLE allocation can keep steali=
ng U&R pages(don't meet 1/2 criteria) without enter slowpath(zone_watermark=
_ok(WMARK_LOW) is true) until they shrink to 15MB. In my opinion, it makes =
more sense to have CMA take its duty to help movable allocation when U&R lo=
wer to certain zone's watermark instead of when their size become smaller t=
han CMA.
> > > Also, this is a hot path, please, make sure you're not adding much ov=
erhead.
> > I would like to take more thought.
>
> Got it, thank you for the explanation!
>
> How about the following approach (completely untested)?
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6da423ec356f..4b50f497c09d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2279,12 +2279,13 @@ __rmqueue(struct zone *zone, unsigned int order, =
int migratetype,
>         if (IS_ENABLED(CONFIG_CMA)) {
>                 /*
>                  * Balance movable allocations between regular and CMA ar=
eas by
> -                * allocating from CMA when over half of the zone's free =
memory
> -                * is in the CMA area.
> +                * allocating from CMA when over half of the zone's easil=
y
> +                * available free memory is in the CMA area.
>                  */
>                 if (alloc_flags & ALLOC_CMA &&
>                     zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -                   zone_page_state(zone, NR_FREE_PAGES) / 2) {
> +                   (zone_page_state(zone, NR_FREE_PAGES) -
> +                    zone->_watermark[WMARK_LOW]) / 2) {
IMO, we should focus on non-cma area which trigger use of cma when
they are lower than corresponding watermark(there is still
WMARK_MIN/HIGH to deal with within slowpath)
>                         page =3D __rmqueue_cma_fallback(zone, order);
>                         if (page)
>                                 return page;
>
> Basically the idea is to keep free space equally split between cma and no=
n-cma areas.
> Will it work for you?
I don't think it makes sense to 'equally split' cma and non-cma areas
over free space while cma could occupy various proportions in a single
zone. This fixed 1/2 could lead to different situation on 20% or 50%
cma occupation.
>
> Thanks!
