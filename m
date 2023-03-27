Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73316CA160
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjC0K1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjC0K1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:27:36 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712C4EFB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:27:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z83so9875004ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/AKk+iS25sywgJr8Lm0vRuzBq3QzMeKXOB/nF8L9lmU=;
        b=at0k2NZb1CCRsvhRDZ8Y6Ssn3yhBFVNIj7fetFkPc6JlOkQ0NA48s5IJr2ctgk/AjG
         JErzLxFtgCAE+nRrUpq2ZzTVhpYVpYoo0Saab2hcAw0dKJAxF3qmaBtv/e2CSAx5EjEN
         I0UggZRgw6KUumkE3l0sYZmDB7//NEe0XKZeXauMhNQJK9bMU1TENM6aX+4Q3+JA/+rr
         AxFfCglAITFTRoGtlYn3nu8hq960AK8FB07SKIdZF2+7u7JP4myApaEsarcL7v6fqpxB
         3+aX5KwckW3SbIaDYilbg9b6sIfybsOjmAhpZALlR4Y+MvcZ7EvxBW+KCHay/mZdWjSW
         CN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AKk+iS25sywgJr8Lm0vRuzBq3QzMeKXOB/nF8L9lmU=;
        b=5LpXFlwDg5fjoeeX7M2WxAIkqG6P9VXcQiV2awo6sBe4qQgNxAoWcfD1FG9oTnPbdC
         Xxo2ijK+Jyz0ytfjrTLMLny/OUcnJ5UAuMm/fr6LATghPk9+YW1OjDSY/PnB4Pobpave
         nwp2n78+Pr4D2TTNPe3yh48GJ6ke6Ueq2jf5qa8cBux2uzu/W7VK5KagycM+skUURSeo
         iyqfbMv+v025WOacWg4myuFTTF+tpeV3j23NNpRl+iGu/6CMCkyi7oGqIs3dXkJ511Zo
         5HGq5KH49KO5IJX7sJSTJUYG9N28MEC95fGlFudhj8W3ypVJcDiM/FXhj5UnbAyVbs+E
         HC2w==
X-Gm-Message-State: AAQBX9dEdb/g59efWBzyLUW4lYTNQ9WE6G2loyB/OP7nhqN5IqKi9hrC
        LwqHi3+jU3XTlNOzkCrg/CIhxnuCCqFbnryDygKFEg==
X-Google-Smtp-Source: AKy350bGJRe1FbSI2ye0OSLmmOYJRyLAiRf6B6fTziQxPmq5eQ+v3EhFMmsogRd38XF8AftUrM+qqarspefbkNqHUsY=
X-Received: by 2002:a05:6902:18c2:b0:b78:5662:d5bb with SMTP id
 ck2-20020a05690218c200b00b785662d5bbmr4402702ybb.3.1679912841227; Mon, 27 Mar
 2023 03:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230317064729.24407-1-yuzhe@nfschina.com> <CGME20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5@eucas1p2.samsung.com>
 <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com> <528343af-50be-45dd-b34f-c8bc641f984c@kili.mountain>
In-Reply-To: <528343af-50be-45dd-b34f-c8bc641f984c@kili.mountain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Mar 2023 12:26:45 +0200
Message-ID: <CAPDyKFq6NGUtpLYNe4xwKrni8U+9+xR13ztDasTMP-8DVQLLNA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
To:     Dan Carpenter <error27@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Yu Zhe <yuzhe@nfschina.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 at 17:39, Dan Carpenter <error27@gmail.com> wrote:
>
> On Fri, Mar 24, 2023 at 02:28:57PM +0100, Marek Szyprowski wrote:
> > On 17.03.2023 07:47, Yu Zhe wrote:
> > > Pointer variables of void * type do not require type cast.
> > >
> > > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > > ---
> > >   drivers/mmc/core/debugfs.c  | 2 +-
> > >   drivers/mmc/core/host.c     | 2 +-
> > >   drivers/mmc/core/mmc_test.c | 6 +++---
> > >   3 files changed, 5 insertions(+), 5 deletions(-)
> > ...
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index 096093f7be00..76900f67c782 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
> > >
> > >   static void devm_mmc_host_release(struct device *dev, void *res)
> > >   {
> > > -   mmc_free_host(*(struct mmc_host **)res);
> > > +   mmc_free_host(res);
> >
> > The above chunk is wrong and causes following regression on today's
> > Linux next-20230324:
>
> Ugh...
>
> Ok.  I have a script that I use to help review mechanical patches.  I
> have added an '-r cast' option to help review "remove unnecessary cast"
> patches.
>
> If you do `cat this_email.txt | rename_rev.pl -r cast` then the output
> looks like:
>
> ================
>  static void devm_mmc_host_release(struct device *dev, void *res)
>  {
> -       mmc_free_host(*res);
> +       mmc_free_host(res);
>  }
>
>  struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
> ================
>
> I have gone through all of Yu Zhe's patches and the rest are okay.
>
> I've attached my rename_rev.pl script.

Thanks for helping out Dan! I will use your script next time!

Kind regards
Uffe
