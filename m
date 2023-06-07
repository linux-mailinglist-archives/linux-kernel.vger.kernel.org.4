Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1397252A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjFGEEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFGEE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:04:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288AB19BA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:04:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so529679a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 21:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686110664; x=1688702664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzNnbIFGDmDkhEhmpSYKhx8HoFZP0+6TO7nVNkdhbGs=;
        b=DGorRqZwWzsyURJ0vJmgdsljto3aQ/liBDe0M0+XeQ32e0jF+iKKwSFavNF+/GzWdR
         AqPMHsti2uaQFhWvFJp/3A7DHw6zKW/wGqda1QLNqeWLYl131cQvA24YMiw6wFii3+ml
         TLqPDbOh8kbHRg4NiSxicWvTFt9h04PKEObAWNdK6Idh3stld0f/+u10FWXqvBrKUFxq
         LZCsTvtBypiyvL8BydDnRpYHZhar/uRCoeYA0j6bM6akxGIOPbBs3Jj9m9MJkUD44NqK
         /DBbL3tqDFNBskTR3mIPNJIFveEY9bdg7SlO0yL5teUJzaYI5p7FKHPDJ4AwiducYbDB
         NBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686110664; x=1688702664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzNnbIFGDmDkhEhmpSYKhx8HoFZP0+6TO7nVNkdhbGs=;
        b=WiFz9QsafuYgCImr9szvTEVXCoq/5vu8xgtuYZPEbzFsmbeTjprDEtNvLthjhUKWOK
         1UYK85/PneGcg9RqTCDIb1j6PNGqLfRvAmIyWqhEhr74KdzRuCbfuQKcC0ak0PgmmO6+
         ogfCFfXaX96EDG83MVUdShrRSLANnEwcER+Kr8ypLAbOyEnCGk+EuGTphonMGCT5j6NK
         +npChqdrclHXsPvHpu650694VB9yoirhPE7nNVqEZomV1qzB8qyaDdOehu611+2I39R0
         ytuzesdnlBkYeFIFDhwPqEyLmA1DZkBP9FFWPTKQ+W2CD1NmVCkCMdkf6x1meN3TqSSL
         makQ==
X-Gm-Message-State: AC+VfDzDW99HTF2K8Y8mixFSaa+xGrae9HqUmFy3Q5NTmE6LxlhVnfDT
        FqIx8JL3ug3PLdpq04yyFPqyH8Ov8g6F6TTN+rs=
X-Google-Smtp-Source: ACHHUZ6vreWIAaAgYHAXyFB8O1/sWMUX0O4JyRiZhdjKlVN+Bek4KcIjWsZYPa/DZNjrmvOt8kqk2o4kzBpGSlSKK2c=
X-Received: by 2002:a17:907:7e9e:b0:974:52e6:93cb with SMTP id
 qb30-20020a1709077e9e00b0097452e693cbmr5459688ejc.50.1686110664054; Tue, 06
 Jun 2023 21:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230606143247.433018-1-nunes.erico@gmail.com> <CA+E=qVcv4CrGki1cTYb53p5Ys0AgF=qfrK7XYB7X0gvu9knD-g@mail.gmail.com>
In-Reply-To: <CA+E=qVcv4CrGki1cTYb53p5Ys0AgF=qfrK7XYB7X0gvu9knD-g@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Wed, 7 Jun 2023 12:04:12 +0800
Message-ID: <CAKGbVbs2uwap-EuQkn00+rZqOB+Fohd9FmazMs051Yn+VSjmmA@mail.gmail.com>
Subject: Re: [Lima] [PATCH] drm/lima: fix sched context destroy
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luben.tuikov@amd.com,
        daniel@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com
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

Reviewed-by: Qiang Yu <yuq825@gmail.com>

Applied to drm-misc-fixes.

On Wed, Jun 7, 2023 at 9:18=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.co=
m> wrote:
>
> On Tue, Jun 6, 2023 at 7:33=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
> >
> > The drm sched entity must be flushed before finishing, to account for
> > jobs potentially still in flight at that time.
> > Lima did not do this flush until now, so switch the destroy call to the
> > drm_sched_entity_destroy() wrapper which will take care of that.
> >
> > This fixes a regression on lima which started since the rework in
> > commit 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini=
")
> > where some specific types of applications may hang indefinitely.
> >
> > Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini=
")
> > Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
>
> Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> > ---
> >  drivers/gpu/drm/lima/lima_sched.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/l=
ima_sched.c
> > index ff003403fbbc..ffd91a5ee299 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.c
> > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > @@ -165,7 +165,7 @@ int lima_sched_context_init(struct lima_sched_pipe =
*pipe,
> >  void lima_sched_context_fini(struct lima_sched_pipe *pipe,
> >                              struct lima_sched_context *context)
> >  {
> > -       drm_sched_entity_fini(&context->base);
> > +       drm_sched_entity_destroy(&context->base);
> >  }
> >
> >  struct dma_fence *lima_sched_context_queue_task(struct lima_sched_task=
 *task)
> > --
> > 2.40.1
> >
