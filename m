Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF66B6D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCMCiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMCiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:38:08 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0109EFB0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:38:06 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id by13so9764533vsb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678675086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItO7YZcw91qclj5TgBZ8dONhPvN6hNcxURKzfoOudJI=;
        b=SkwE3WijmSzjjVAfmaZTT/RLNtOpmJ+nRbYGzClk8o7QspVFMJ4Tqy9WwKKIRyhCiv
         zAGB6bs/kHNuE4qz8QVLUABoyK3lnp7+DgzRZau0nkRSAbHfMQFi7oNOlfyUZ1UR5Beo
         y06EcTA9dikYNUROfQotumnXwUokrOsjOj/WV5gE8ZmBl4GMH73mO47r6+YPFuMugfDM
         ZPeDKhHy4uiDBc8y8tZchKVoBh0cFT8AY7tfnGpHeI3vKpEQvK7+2vjQqTvo3ImruH9X
         Gk8zW0j4nYzNoPo9hB9SZkU/RNM1aJsVdGUT0BtSjKfd7NwFpdUyWzaoRe5CH2qoGOPu
         jkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678675086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItO7YZcw91qclj5TgBZ8dONhPvN6hNcxURKzfoOudJI=;
        b=vjqmrrIILWgnFxrLcMHqHqgJXUwfmqqN1W9rQeni2YSvTa8aYqnGxZU/Jvjk/k9tcs
         +x4qr+6k6kLTgFdhd8wHejYmkIvmeepypo0VxXN/GOlBBxHk9QXcEGbGfLOR9XUngtLc
         cpShomDmjXgrEaje7FVFRAUqsPy1aTk2mPtc7t+pTjYOS85/Dq2oRtZrJ7F3J2fNyGbu
         2nTNvr7tsToQHQLu3XclUABHeYF5KWB/q3yFtwYFqJfLqPRFsWTkda4nldX9XA9d4nR/
         Vjar4mDWdEri3TJeTBda9W0BReRt21MVE0YJgpyM9w2oqZzXAYbAZCvn5D/uNQaQFp66
         +ECg==
X-Gm-Message-State: AO0yUKWiYzeQikqaUn9ebI/n/cpFpXAta8K8TctSAAj9XX9RLfB/s80X
        beyDuVBxmGYIvqXAuK7AEFhzUHySLKgwfitcAJtWXxtr/hs=
X-Google-Smtp-Source: AK7set/IVrNDCwih10B5QFRnZKwFuL2MbzU/rp6zZVMIxU/OsmV2ZGmnWQn5XHisyhYTAKKrCRnFcjgf5ljNYICwQqk=
X-Received: by 2002:a05:6102:318b:b0:423:e694:7a7d with SMTP id
 c11-20020a056102318b00b00423e6947a7dmr2321119vsh.4.1678675085954; Sun, 12 Mar
 2023 19:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230312233052.21095-1-nunes.erico@gmail.com> <20230312233052.21095-4-nunes.erico@gmail.com>
In-Reply-To: <20230312233052.21095-4-nunes.erico@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 13 Mar 2023 10:37:54 +0800
Message-ID: <CAKGbVbtMW0xUX2sCRnEzBMMu2WRuin9QsW1D45jFHu2d==nbrw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/lima: add show_fdinfo for drm usage stats
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 7:31=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> This exposes an accumulated active time per client via the fdinfo
> infrastructure per execution engine, following
> Documentation/gpu/drm-usage-stats.rst.
> In lima, the exposed execution engines are gp and pp.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_drv.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_=
drv.c
> index d23c0b77a252..c044a31493a4 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -261,7 +261,36 @@ static const struct drm_ioctl_desc lima_drm_driver_i=
octls[] =3D {
>         DRM_IOCTL_DEF_DRV(LIMA_CTX_FREE, lima_ioctl_ctx_free, DRM_RENDER_=
ALLOW),
>  };
>
> -DEFINE_DRM_GEM_FOPS(lima_drm_driver_fops);
> +static void lima_drm_driver_show_fdinfo(struct seq_file *m, struct file =
*filp)
> +{
> +       struct drm_file *file =3D filp->private_data;
> +       struct drm_device *dev =3D file->minor->dev;
> +       struct lima_device *ldev =3D dev->dev_private;
Can use to_lima_dev().

> +       struct lima_drm_priv *priv =3D file->driver_priv;
> +       struct lima_ctx_mgr *ctx_mgr =3D &priv->ctx_mgr;
> +       u64 usage[lima_pipe_num];
> +
> +       lima_ctx_mgr_usage(ctx_mgr, usage);
> +
> +       /*
> +        * For a description of the text output format used here, see
> +        * Documentation/gpu/drm-usage-stats.rst.
> +        */
> +       seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
> +       seq_printf(m, "drm-client-id:\t%u\n", priv->id);
> +       for (int i =3D 0; i < lima_pipe_num; i++) {
> +               struct lima_sched_pipe *pipe =3D &ldev->pipe[i];
> +               struct drm_gpu_scheduler *sched =3D &pipe->base;
> +
> +               seq_printf(m, "drm-engine-%s:\t%llu ns\n", sched->name, u=
sage[i]);
> +       }
> +}
> +
> +static const struct file_operations lima_drm_driver_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       DRM_GEM_FOPS,
> +       .show_fdinfo =3D lima_drm_driver_show_fdinfo,
> +};
>
>  /*
>   * Changelog:
> --
> 2.39.2
>
