Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075676F8E1B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjEFCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjEFCox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:44:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0A7AB2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:44:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13a72ff53so2806900e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683341091; x=1685933091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7UB2nW/Jj+U4yffAwPMogyKSJLrjsqdpipIiYsI+rw=;
        b=BdC8aAp7RX1CCo+JSpU8/7he3ffh2rtnXbhhKWzuiqVxu5gR2Zru/TPBHOBw3ZpPve
         YisP0v5BewuWDBsRyOLCLVkuJPQCop0ZhcETYAc++YrzZaiyUi/wiZ/YXQEF077B+A0H
         6ksKOzZ4SyAL/Qa7TkS2vw+Jkt9CGw24StbzkplEbQX3pOmOs+rg/DTA4uYDMV5oLjB3
         u4j125MjLwu7gnuLm8A/hVLTRlIU+0v0jbnwZz4NoOpYfl51Sda4E336XACMu981Or0l
         DMLKpaLZEEGL6MK2rN0MZG1BAHZn1eceEI7zyUNp3F/hoTHagtL+IFdeNbNBVwL9gb7v
         hOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683341091; x=1685933091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7UB2nW/Jj+U4yffAwPMogyKSJLrjsqdpipIiYsI+rw=;
        b=ehBYkYF8VpfS4FkzkPMBjYr4kHBTxfz/PMR7/SFB1BGCehgRISMnZE8bHPways2SRV
         srO6tD/PZEoJwuRmEie+d1q+XsS+TngqD2ALBUjx3Ula4rT7zGsMregbGTHpqqmE9UH0
         h4s/wIThA0cAmSOJMga3Wkoteforkrl2iVvS2/BtaXEMA7ytTOKaaGzB8yiblLbgAMhL
         Fo1gF7sLuHX7WBwx0pEHwwOgb0gOIQxBUz/Rk/a3yoiHYuMEzC4mrdtY5Gb2136/miIJ
         vek4SSADrEPLUENqm8/+o4A6Ot2Zjww8H1yKj5PRFmBTWv06CeYDvFCnqHrSOE3NPxAb
         3+3Q==
X-Gm-Message-State: AC+VfDwR9lWJPwTdzCDlIMDfECEYYFR0zY87wiFe7wkvjD6UysUJ+UgI
        5hXoHotrp0+ZNul/5XmSE+fhnDRyH3V4nXgKkW0=
X-Google-Smtp-Source: ACHHUZ5zg5zXHtMT2LQnYg3Mr3XsMKlJsai1xG1XWuHffg3dqgmpSSqTWYSHB6Lm33JMYkSqD53rGNgfDyE1NuKMzdA=
X-Received: by 2002:a19:f008:0:b0:4d5:a689:7f9d with SMTP id
 p8-20020a19f008000000b004d5a6897f9dmr989833lfc.57.1683341090737; Fri, 05 May
 2023 19:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com> <ZFWDKCJ5n55Y5eq4@P9FQF9L96D.lan>
In-Reply-To: <ZFWDKCJ5n55Y5eq4@P9FQF9L96D.lan>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 6 May 2023 10:44:28 +0800
Message-ID: <CAGWkznH+89v1cDn6PxE-cZ97jnn+QPkuCQHu1ujc-3=c0iVdKw@mail.gmail.com>
Subject: Re: [PATCHv2] mm: optimization on page allocation when CMA enabled
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
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

On Sat, May 6, 2023 at 6:29=E2=80=AFAM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> On Thu, May 04, 2023 at 06:09:54PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Let us look at the series of scenarios below with WMARK_LOW=3D25MB,WMAR=
K_MIN=3D5MB
> > (managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start=
 to use
> > CMA since C which actually has caused U&R lower than WMARK_LOW (this sh=
ould be
> > deemed as against current memory policy, that is, U&R should either sta=
y around
> > WATERMARK_LOW when no allocation or do reclaim via enter slowpath)
> >
> > free_cma/free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
> > fixed 1/2 ratio                 N             N           Y
> > this commit                     Y             Y           Y
> >
> > Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> I didn't suggest it in this form, please, drop this tag.
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: do proportion check when zone_watermark_ok, update commit message
> > ---
> > ---
> >  mm/page_alloc.c | 36 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0745aed..d0baeab 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3071,6 +3071,34 @@ static bool unreserve_highatomic_pageblock(const=
 struct alloc_context *ac,
> >
> >  }
> >
> > +#ifdef CONFIG_CMA
> > +static bool __if_use_cma_first(struct zone *zone, unsigned int order, =
unsigned int alloc_flags)
> > +{
> > +     unsigned long cma_proportion =3D 0;
> > +     unsigned long cma_free_proportion =3D 0;
> > +     unsigned long watermark =3D 0;
> > +     long count =3D 0;
> > +     bool cma_first =3D false;
> > +
> > +     watermark =3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> > +     /*check if GFP_MOVABLE pass previous watermark check via the help=
 of CMA*/
> > +     if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (=
~ALLOC_CMA)))
> > +             /* WMARK_LOW failed lead to using cma first, this helps U=
&R stay
> > +              * around low when being drained by GFP_MOVABLE
> > +              */
> > +             cma_first =3D true;
>
> This part looks reasonable to me.
>
> > +     else {
> > +             /*check proportion when zone_watermark_ok*/
> > +             count =3D atomic_long_read(&zone->managed_pages);
> > +             cma_proportion =3D zone->cma_pages * 100 / count;
> > +             cma_free_proportion =3D zone_page_state(zone, NR_FREE_CMA=
_PAGES) * 100
> > +                     /  zone_page_state(zone, NR_FREE_PAGES);
> > +             cma_first =3D (cma_free_proportion >=3D cma_proportion * =
2
>
> Why *2? Please, explain.
It is a magic number here which aims at avoiding late use of cma when
free pages near to WMARK_LOW by periodically using them in advance.
>
> > +                             || cma_free_proportion >=3D 50);
>
> It will heavily boost the use of cma at early stages of uptime, when ther=
e is a lot of !cma
> memory, making continuous (e.g. hugetlb) allocations fail more often. Not=
 a good idea.
Actually, it is equal to "zone_page_state(zone, NR_FREE_CMA_PAGES) >
zone_page_state(zone, NR_FREE_PAGES) / 2"
>
> Thanks!
