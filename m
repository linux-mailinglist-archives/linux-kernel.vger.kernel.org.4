Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF8717D73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjEaKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjEaKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:54:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA4123;
        Wed, 31 May 2023 03:54:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b02e0ec7d5so4509475ad.1;
        Wed, 31 May 2023 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685530487; x=1688122487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW1b1ccAWN4g+utpYsd/EKLY8pCRgvbm0rstGDwBDSU=;
        b=EKcuDnKmwPD117tH/GwwZWVjGgwRlWmNDDSwzZCPJHnmMbbDbi88XW7atFxnH+K5k2
         zc9VDCeYx5zo0zp1XbC9WmmcFzlucpPHOpc/9MAWBNFvIaHH4mFKDp2thmrcAHxoSp3C
         GfRhl2uH0J7Vl6OJFM24WgsV1osBETWIb3srvZ/LGDEiNs9+PZtIyk2sgDO+5MH1fhf+
         Cj81WiOizy3KS+SygfcL5IhTMCWHonqJmQ6FSmEODyRVis4NRXZr6+rCzYw4nNErvCGv
         gvVsy2+DGnILZALoejASkTaBUwcSl9nNHAYZjDTTX110ewqrb3JXNAh4W5ewOqn6DZuP
         mvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685530487; x=1688122487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW1b1ccAWN4g+utpYsd/EKLY8pCRgvbm0rstGDwBDSU=;
        b=dAdyq5espzg3UPXsYVcbGEacXWQCZBrpG7PZhMxo0DbqFD1qjIvMJAte+YXnC5D3mA
         me323wP8iUNNP7uDkV6kQC3IhF9cN9FPFBpsqCeQbmD8mRia7MyQX/na0G5xMYNNFAsT
         IiSePT8y57ghbbRjx2kRjiSJIQSH6Yknd5U2YBMiaUMan0Na9AJKqb/DW2uPLI/E1p6v
         Esnsz7CPDIqjYSWjq5ZpnuCDpTgHbnKxRcy2P5elCRPL8moFKaON3t4xZ68kOIKdR6vF
         fiw3s3lFJqggwYZpf7tif9td9zQby9v86DC7v4R54E1J1M6r7j0WebcQILqs7Er9hhEB
         ugyg==
X-Gm-Message-State: AC+VfDxEfg76M0sffWzSdSI9ynSBRv1WkWXFFIPZ/NJ9i7ukx2j/eEYt
        rjSAcek6Ziy5QbbZ5aAK7h3+09HclY4gPBA0woS4wvMAY+u+suSH
X-Google-Smtp-Source: ACHHUZ6Pk/b50QlriP6fmYh21EsZlRkoEXx2f4SkiI3WgSLoGLCoajx5TP+OOXzXRcAbrFO52OXXYS5rFksm4EKd1fQ=
X-Received: by 2002:a17:902:e852:b0:1b0:3cda:6351 with SMTP id
 t18-20020a170902e85200b001b03cda6351mr5360668plg.0.1685530487124; Wed, 31 May
 2023 03:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230526130131.16521-1-lm0963hack@gmail.com> <20230530222150.24oogloda6wtvpvm@intel.intel>
 <CAAgLYK7FNrAYFRp7C3LDtqevFENQLw8YYAFR2Pk9wdfQ5RKVeg@mail.gmail.com> <20230531081917.grx3qqqm7usaqoa5@intel.intel>
In-Reply-To: <20230531081917.grx3qqqm7usaqoa5@intel.intel>
From:   lm0963 <lm0963hack@gmail.com>
Date:   Wed, 31 May 2023 18:54:34 +0800
Message-ID: <CAAgLYK4KzuKMTkBwzCJj4wa+W+=9fR+A1J=XR-n1E-W7EjexuA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Andi,

On Wed, May 31, 2023 at 4:19=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Min,
>
> > > > If it is async, runqueue_node is freed in g2d_runqueue_worker on an=
other
> > > > worker thread. So in extreme cases, if g2d_runqueue_worker runs fir=
st, and
> > > > then executes the following if statement, there will be use-after-f=
ree.
> > > >
> > > > Signed-off-by: Min Li <lm0963hack@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/=
drm/exynos/exynos_drm_g2d.c
> > > > index ec784e58da5c..414e585ec7dd 100644
> > > > --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > > > +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > > > @@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *=
drm_dev, void *data,
> > > >       /* Let the runqueue know that there is work to do. */
> > > >       queue_work(g2d->g2d_workq, &g2d->runqueue_work);
> > > >
> > > > -     if (runqueue_node->async)
> > > > +     if (req->async)
> > >
> > > did you actually hit this? If you did, then the fix is not OK.
> >
> > No, I didn't actually hit this. I found it through code review. This
> > is only a theoretical issue that can only be triggered in extreme
> > cases.
>
> first of all runqueue is used again two lines below this, which
> means that if you don't hit the uaf here you will hit it
> immediately after.

No, if async is true, then it will goto out, which will directly return.

if (runqueue_node->async)
    goto out;   // here, go to out, will directly return

wait_for_completion(&runqueue_node->complete);      // not hit
g2d_free_runqueue_node(g2d, runqueue_node);

out:
return 0;

>
> Second, if runqueue is freed, than we need to remove the part
> where it's freed because it doesn't make sense to free runqueue
> at this stage.

It is freed by g2d_free_runqueue_node in g2d_runqueue_worker

static void g2d_runqueue_worker(struct work_struct *work)
{
    ......
    if (runqueue_node) {
        pm_runtime_mark_last_busy(g2d->dev);
        pm_runtime_put_autosuspend(g2d->dev);

        complete(&runqueue_node->complete);
        if (runqueue_node->async)
            g2d_free_runqueue_node(g2d, runqueue_node);        // freed her=
e
    }

>
> Finally, can you elaborate on the code review that you did so
> that we all understand it?

queue_work(g2d->g2d_workq, &g2d->runqueue_work);
msleep(100);        // add sleep here to let g2d_runqueue_worker run first
if (runqueue_node->async)
    goto out;


>
> Andi



--
Min Li
