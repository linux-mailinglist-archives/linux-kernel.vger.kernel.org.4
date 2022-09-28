Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45C5EE2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiI1RU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiI1RUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:20:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D65603D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:20:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b5so12796039pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9bN9My5ZbeHYHa+eCYmZ+EExYTqNfYOXwgsyfJBXZEE=;
        b=lIcfhWxf/X2WYZb63vELVJjIY3gExm8RBaLCUYE4GSCgPjwFSlU/Ml6fHaC0ZJj3Bn
         xkkQwKw108Nn8tp+fl66fVLDrUFymGhiarsw+vVbXLOqa0lhAxFg0MASxbUFSjtQ6jxV
         +NNEMB1kpHyBVAqfcvaiCRbO7aqKvEfmZ3kBO1UIaRoBXTmXS4Zms9Px4cmQv6eFgIqj
         99aB1eKsLA0iseQYp4uYeZCnLszRbs8jcC+5N1GpsN2QTY/4V6LwR5ImG3CoD51lxqzZ
         HH/tILkrIhQOQj7r7cf7hyOUjeAOUYPGVEDlmjMhpL20aWYsXFrNVC0yp2+K2iNn/aZ6
         ObmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9bN9My5ZbeHYHa+eCYmZ+EExYTqNfYOXwgsyfJBXZEE=;
        b=5Nx6AhtKKmsmUI5pRIQxXnoOsYisd+YzJBOBgGpzfNt312XfHWpzCpj9QUdaJmb5D0
         IWHWfwxR5JOQj5309wpXukmLBEy+k0KdBHcy6aNDlAOhZJaMyScdsj+4TOEnhIfK/kct
         yGVA7ph9ljCLD3ZGY+Zq7c3lRZ2q6w5GKAEA3eG2NQAv8Ykd4vXdgj2c+4pkd1v8mwKo
         iMZik4ZrK4CxCDrAgDQQeuU1KSg4uYnH/+gUFdzBjBvp+EwsUUF6kefotvYefYZEkH0c
         1fUjaDBJpRAF9li9T3mFX5gWpiA5i+bvZeteGznJn3kL+LQiicMMc6JEjV8qv/TH+1z/
         JlFw==
X-Gm-Message-State: ACrzQf2SG4928CqlqJRhZ27zb5x7wwp/BxU/5ZwBtULgrdSTPaHu29Aa
        pkNjt0mm+XNgDATVUCEK2Q68Pc451O3+oA==
X-Google-Smtp-Source: AMsMyM5rDZE9lmdRZgTb8Kd897hQYYOoyyhWPiPshBDFwdCMNfgjTZZjvapXUc1p9NZiGqKPW4C8lg==
X-Received: by 2002:a63:90c4:0:b0:43c:bc86:8ae7 with SMTP id a187-20020a6390c4000000b0043cbc868ae7mr13622186pge.398.1664385646157;
        Wed, 28 Sep 2022 10:20:46 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903120a00b001780a528540sm4118002plh.93.2022.09.28.10.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:20:45 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:20:42 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     andersson@kernel.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: Add mutex protection for
 workqueue
Message-ID: <20220928172042.GB2990524@p14s>
References: <1664192893-14487-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664192893-14487-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 07:48:13PM +0800, Shengjiu Wang wrote:
> The workqueue may execute late even after remoteproc is stopped or
> stopping, some resources (rpmsg device and endpoint) have been
> released in rproc_stop_subdevices(), then rproc_vq_interrupt()
> access these resources will cause kennel dump.
> 
> Call trace:
>  virtqueue_add_split+0x1ac/0x560
>  virtqueue_add_inbuf+0x4c/0x60
>  rpmsg_recv_done+0x15c/0x294
>  vring_interrupt+0x6c/0xa4
>  rproc_vq_interrupt+0x30/0x50
>  imx_dsp_rproc_vq_work+0x24/0x40 [imx_dsp_rproc]
>  process_one_work+0x1d0/0x354
>  worker_thread+0x13c/0x470
>  kthread+0x154/0x160
>  ret_from_fork+0x10/0x20
> 
> Add mutex protection in imx_dsp_rproc_vq_work(), if the state is
> not running, then just skip calling rproc_vq_interrupt().
> 
> Also the flush workqueue operation can't be added in rproc stop
> for same reason.
> 
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 899aa8dd12f0..95da1cbefacf 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -347,9 +347,6 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
>  	struct device *dev = rproc->dev.parent;
>  	int ret = 0;
>  
> -	/* Make sure work is finished */
> -	flush_work(&priv->rproc_work);
> -

The kernel documentation for this function [1] indicate that once it returns
there will no more jobs to process in that queue, _unless_ another job has been
queued _after_ the flush has started.  What I suspect is happening here is that
a new job is queued between the time flush_work() returns and the remote processor
is switched off, something that should not be happening since all the
subdevices have been stopped in rproc_stop_subdevices().  

[1]. https://elixir.bootlin.com/linux/v6.0-rc7/source/kernel/workqueue.c#L3092


>  	if (rproc->state == RPROC_CRASHED) {
>  		priv->flags &= ~REMOTE_IS_READY;
>  		return 0;
> @@ -432,9 +429,18 @@ static void imx_dsp_rproc_vq_work(struct work_struct *work)
>  {
>  	struct imx_dsp_rproc *priv = container_of(work, struct imx_dsp_rproc,
>  						  rproc_work);
> +	struct rproc *rproc = priv->rproc;
> +
> +	mutex_lock(&rproc->lock);
> +
> +	if (rproc->state != RPROC_RUNNING)
> +		goto unlock_mutex;
>  
>  	rproc_vq_interrupt(priv->rproc, 0);
>  	rproc_vq_interrupt(priv->rproc, 1);

These are not guaranteed to be atomic and sleeping with the mutex held is
guaranteed to deadlock the system.

Thanks,
Mathieu

> +
> +unlock_mutex:
> +	mutex_unlock(&rproc->lock);
>  }
>  
>  /**
> -- 
> 2.34.1
> 
