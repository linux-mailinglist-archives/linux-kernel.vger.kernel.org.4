Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE66D6D28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjDDT3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjDDT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:29:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D32713
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:29:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-947a47eb908so43896766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680636586;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDcTKrSrAsaj76X8vZNhTOKwZlbAEf+GAzZ3pjuCyAQ=;
        b=Ol0ruIFnZEpOldPCfGXZ2Eh69uloYVAw/FuSGVLaFXPWzhtEdjV/vTYpvc2/tlusAN
         Esw5Ypb9zST5aKRpSwbYRWgepey+rYqxBlQs4VJwgQkO5imOOMJrHsikSI82uqJau6ld
         n8EhpL85qWu8+SjnrNM1FveFWCANo5waYyRgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680636586;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDcTKrSrAsaj76X8vZNhTOKwZlbAEf+GAzZ3pjuCyAQ=;
        b=lrya0StNLB38kUYHacnHvwP4D9O0vZkPTRgdOfGGYeC+uUU/Red3T2l8iuELSGe4kH
         Ylrnub8I0YbDQAUiYB2xmjMOBBcBCjp663I1LhOBMYWT6FccRbFjcyye6U1PJc50A9IS
         6AedVp+s0wBv9arq5C0+ZFJobH62NQZU9msPG+gddbECW5ZlqolOoLa+TvMafiyzmpov
         mFBDqs3Ua9GfHhpbfxBe4+XLCi+qcvQ7e7V0vmL04AHOfagHNOfXTrVmKmELts3bnDnt
         GMV8ZZHH74L5mhnGLfT6Q0Q25HT9iAr1RUORTuLaUGx2fFMPeLJVwYDxzZsQjPBCZ8mh
         h2Hw==
X-Gm-Message-State: AAQBX9e3D70tkbrZuG8eMeFSKy429uR9OFsmFj8E1AfQjP4ODJLN0OqB
        pkQf/A7/LUpT8A0L2MprXA+scw==
X-Google-Smtp-Source: AKy350atpPkCeg8shFO6LeLPLzLvxHIcMiua2klFWE3sYLdfZXfh4Wl4O0CiLXC2ZxC5k/umZYmeHg==
X-Received: by 2002:a17:906:114:b0:947:f415:db23 with SMTP id 20-20020a170906011400b00947f415db23mr728899eje.1.1680636586708;
        Tue, 04 Apr 2023 12:29:46 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id xc2-20020a170907074200b00947a6d84fefsm6123349ejb.75.2023.04.04.12.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:29:46 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:29:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     yq882255@163.com
Cc:     dri-devel@lists.freedesktop.org,
        Erico Nunes <nunes.erico@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH 1/3] Revert "drm/lima: add show_fdinfo for drm usage
 stats"
Message-ID: <ZCx6qMqA9znAHGyS@phenom.ffwll.local>
Mail-Followup-To: yq882255@163.com, dri-devel@lists.freedesktop.org,
        Erico Nunes <nunes.erico@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@gmail.com>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>
References: <20230404002601.24136-1-yq882255@163.com>
 <20230404002601.24136-2-yq882255@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404002601.24136-2-yq882255@163.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 08:25:59AM +0800, yq882255@163.com wrote:
> From: Qiang Yu <yuq825@gmail.com>
> 
> This reverts commit 4a66f3da99dcb4dcbd28544110636b50adfb0f0d.
> 
> This is due to the depend commit has been reverted on upstream:
> baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"")
> 
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

A bit an aside, but it feels like a lot more of the fdinfo scheduler code
should be common, and not just the minimal timekeeping? Just a thought for
the next round.
-Daniel

> ---
>  drivers/gpu/drm/lima/lima_drv.c | 31 +------------------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> index 3420875d6fc6..f456a471216b 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -261,36 +261,7 @@ static const struct drm_ioctl_desc lima_drm_driver_ioctls[] = {
>  	DRM_IOCTL_DEF_DRV(LIMA_CTX_FREE, lima_ioctl_ctx_free, DRM_RENDER_ALLOW),
>  };
>  
> -static void lima_drm_driver_show_fdinfo(struct seq_file *m, struct file *filp)
> -{
> -	struct drm_file *file = filp->private_data;
> -	struct drm_device *dev = file->minor->dev;
> -	struct lima_device *ldev = to_lima_dev(dev);
> -	struct lima_drm_priv *priv = file->driver_priv;
> -	struct lima_ctx_mgr *ctx_mgr = &priv->ctx_mgr;
> -	u64 usage[lima_pipe_num];
> -
> -	lima_ctx_mgr_usage(ctx_mgr, usage);
> -
> -	/*
> -	 * For a description of the text output format used here, see
> -	 * Documentation/gpu/drm-usage-stats.rst.
> -	 */
> -	seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
> -	seq_printf(m, "drm-client-id:\t%u\n", priv->id);
> -	for (int i = 0; i < lima_pipe_num; i++) {
> -		struct lima_sched_pipe *pipe = &ldev->pipe[i];
> -		struct drm_gpu_scheduler *sched = &pipe->base;
> -
> -		seq_printf(m, "drm-engine-%s:\t%llu ns\n", sched->name, usage[i]);
> -	}
> -}
> -
> -static const struct file_operations lima_drm_driver_fops = {
> -	.owner = THIS_MODULE,
> -	DRM_GEM_FOPS,
> -	.show_fdinfo = lima_drm_driver_show_fdinfo,
> -};
> +DEFINE_DRM_GEM_FOPS(lima_drm_driver_fops);
>  
>  /*
>   * Changelog:
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
