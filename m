Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990626A13D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBWXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBWXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:33:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CF11666
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:33:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq23so48057817edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yS8ghRAP/szNpGyxrUGvkFjZni2XaHwZq/ZPVhFbsns=;
        b=m0AxbduZIgXjo+gbxvxHvgIW7ZKmEfLXNXpEY3Rydyi26wIMEFtadQdoJ/JLKa9a3n
         ueBEf0FPStdKl4dO0nBNiq9BSfgy+IdFhsdmY85mcD9hR8AJnC5bdJA4QrQKfQDtXcX6
         UITuA/t5z1lX6V/loatPRpNb/hTOKsjIFgPSj1nQBtiTKrGNaizfCXg3RZIVNURWxit0
         tnpzz9F2RTlQ0ymBChWwnbrSniYM4HJEpXnbKhgyJ3iUIzrhXfhsAi6RzWOSxVDqfJ4B
         LdFiFYPyRdLGJS7IqHMrm1DnUVWwuZvXRBjIusILTHvMVrDScOQKzF20Zw8jIBtVeIBR
         I5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS8ghRAP/szNpGyxrUGvkFjZni2XaHwZq/ZPVhFbsns=;
        b=SFtYOzdktSyI5FLnV0lRdAGEYBN6EMYaId/SZX6VXCFAmlWwUwwnm9c+ir/XeP80Eu
         QdB2ac25c5+Mg/7QtC3FKGWgAy/5riCaoYsf2iqi33RaL3pOTFstlpP6tF6baiD04gd0
         NQqTRturPVkO+Zsie7GiWSx83Tj5fKAORDJU8FpDYL4rkeNjnZKPLu7eO3jaH4E3MQ1e
         k5WE+8TElM113HhhA1SZQHqncmELmEzKCE0+1nWM8XzSWxhmfXK2xo+AVTOx1vo6lSsb
         odxTGHo2FCp/13/SbuCdSx9xyPvlfoRhYZOIgsB+yl869mCYYvgpDnLfFra1VI0TUGxQ
         mQrw==
X-Gm-Message-State: AO0yUKVdKYTX8eXzWQl4OVmnOQJC1odA6sn+vl+k624GXG1ZO16Lzv/E
        Gku8gW4EHBOJoRpGDHJVsqKwV5qhHqEWXiFpJgFjWC2H1CLTSha3
X-Google-Smtp-Source: AK7set/x3vcMQPHodvKb7G8weM1nvqIt06E+UU5MJOA4YK3o9AofMV8p8NEh2mQ1vp5H/HeBVXN9BkM2GnMsnPbLinE=
X-Received: by 2002:a05:6402:35ca:b0:4af:62ad:60b1 with SMTP id
 z10-20020a05640235ca00b004af62ad60b1mr4841890edc.3.1677195202306; Thu, 23 Feb
 2023 15:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-3-senozhatsky@chromium.org> <Y/fyn1u5RhDwgG1J@google.com>
In-Reply-To: <Y/fyn1u5RhDwgG1J@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Feb 2023 15:32:45 -0800
Message-ID: <CAJD7tkbezM+pNJkkjhei5EKuXwLnECqfo1m7_aaf-EmPGE9kVQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/6] zsmalloc: remove stat and fullness enums
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 3:11 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Feb 23, 2023 at 12:04:47PM +0900, Sergey Senozhatsky wrote:
> > The fullness_group enum is nested (sub-enum) within the
> > class_stat_type enum. zsmalloc requires the values in both
> > enums to match, because zsmalloc passes these values to
> > generic functions, e.g. class_stat_inc() and class_stat_dec(),
> > after casting them to integers.
> >
> > Replace these enums (and enum nesting) and use simple defines
> > instead. Also rename some of zsmalloc stats defines, as they
> > sort of clash with zspage object tags.
> >
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  mm/zsmalloc.c | 104 ++++++++++++++++++++++----------------------------
> >  1 file changed, 45 insertions(+), 59 deletions(-)
> >
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index b57a89ed6f30..38ae8963c0eb 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -159,26 +159,18 @@
> >  #define ZS_SIZE_CLASSES      (DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
> >                                     ZS_SIZE_CLASS_DELTA) + 1)
> >
> > -enum fullness_group {
> > -     ZS_EMPTY,
> > -     ZS_ALMOST_EMPTY,
> > -     ZS_ALMOST_FULL,
> > -     ZS_FULL,
> > -     NR_ZS_FULLNESS,
> > -};
> > +#define ZS_EMPTY             0
> > +#define ZS_ALMOST_EMPTY              1
> > +#define ZS_ALMOST_FULL               2
> > +#define ZS_FULL                      3
> > +#define ZS_OBJS_ALLOCATED    4
> > +#define ZS_OBJS_INUSE                5
> >
> > -enum class_stat_type {
> > -     CLASS_EMPTY,
> > -     CLASS_ALMOST_EMPTY,
> > -     CLASS_ALMOST_FULL,
> > -     CLASS_FULL,
> > -     OBJ_ALLOCATED,
> > -     OBJ_USED,
> > -     NR_ZS_STAT_TYPE,
> > -};
> > +#define NR_ZS_STAT           6
> > +#define NR_ZS_FULLNESS               4
>
> Using define list instead of enum list looks like going backward. :)
>
> Why can't we do this?
>
> enum class_stat_type {
>     ZS_EMPTY,
>     ZS_ALMOST_EMPTY,
>     ZS_ALMOST_FULL,
>     ZS_FULL,
>     NR_ZS_FULLNESS,
>     ZS_OBJ_ALLOCATED = NR_ZS_FULLNESS,
>     ZS_OBJ_USED,
>     NR_ZS_STAT,
> }

Right, I suggested getting rid of the extra enums, so merging them
into 1 is great.

>
>
> };
> >
> >  struct zs_size_stat {
> > -     unsigned long objs[NR_ZS_STAT_TYPE];
> > +     unsigned long objs[NR_ZS_STAT];
> >  };
> >
