Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290A8696E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBNUZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBNUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:25:11 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27456976F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:25:10 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z3so4890619pfw.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6owkNXIzp1vvBsxZwQmk2daqoSOZH7CsTkxkBz81Dk=;
        b=pdA6JyYQHNErVqK8LINqlRGMqxtADvlL90ZJrL6mWqZ91n/eHY3Caw74nZvN0P/HBe
         JQ5RYHrGTVqtuOgV2wOy3SLUkT3Ou378ZeWaifGUkROZMmfC0/jWnct97FqY7eMln/SC
         S6causZK3rl4RecLSW/4yIm09/4sHLwskojjipik7emxeZaxvSmVXE4KuI3MTxrP6JtI
         U5ORDIM50hiPc7R2f+nURu/EC3pzXoLENgPp+d/WqzG4ydCGUH5w/WBWo2onlmK66a0r
         e/0NPx1ilq8omftTipz3Yw924m1DVSIyCtcjTZTLan5ZLngCDPfBGkpeffuALosRElc2
         TTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6owkNXIzp1vvBsxZwQmk2daqoSOZH7CsTkxkBz81Dk=;
        b=Ao6L0ZCaJhSDWsE0R3yS26B7R5QNq8xZM5LRa5N/W8PwN5AS1aGRKGXdy475dhAta0
         ngK7vW0ZF+9Yjuydca1lEfvlVGwkkQjP1Y9+QoyjcFgyy5xXSvFAHPWRTvKgkT7RJqUu
         KR36Q0nByg6seTYEym2+Nz4HleCMhSpuXx4JpFs/3oUXqS66Lg9+Xp4PJmLKyGScIb4R
         QuX8lzEvDG2M80SOOt5O9bnRoKqG0P6BuCZbhepNz7zYHvGMAMDSweDZki1rF0BLjPiq
         KwJyAcuyQXHqe6UGmw7bXFuUctsuqj71KPhMYrWcv3nnZXU4pE/NL555qB96LHED5XYT
         UCpQ==
X-Gm-Message-State: AO0yUKV/SAUiBlyxqm/uN7LDPgmOcTC67fMS/VPVJ0INALL2RI7zELKp
        21SRUkPXZpml8fM+DkvCZbrUFQ==
X-Google-Smtp-Source: AK7set9j8KXiZRlMz3+V5fLFfRnJMFs/x9O9jvoz8VDtOyZT2uChw1vlI384CedfCzm6km2vc0VA9Q==
X-Received: by 2002:a05:6a00:4108:b0:5a6:cbdc:2a1a with SMTP id bu8-20020a056a00410800b005a6cbdc2a1amr916874pfb.2.1676406309569;
        Tue, 14 Feb 2023 12:25:09 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:21f5:b54f:9213:bd83])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b0058e264958b7sm5326691pff.91.2023.02.14.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 12:25:09 -0800 (PST)
Date:   Tue, 14 Feb 2023 13:25:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [RESEND PATCH v4] remoteproc: imx_dsp_rproc: add module
 parameter to ignore ready flag from remote processor
Message-ID: <20230214202506.GA384054@p14s>
References: <20230214163744.16377-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214163744.16377-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 06:37:44PM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> There are cases when we want to test a simple "hello world"
> application on the DSP and we don't have IPC between the cores.
> Therefore, do not wait for a confirmation from the remote processor
> at start.
> 
> Added "ignore_dsp_ready" flag while inserting the module to ignore
> remote processor reply after start.
> By default, this is off - do not ignore reply from rproc.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

This patch is on my review list, as indicated in February 8th's patchset review
order email.  That said, I haven't seen Daniel's RB on the mailing list.

> ---
> Changes since v3
> - do not instantiate static var to 0, this is done by default
> - do not initialize mailbox if not IPC between the core
> 
> Changes since v2
> - s/ignoreready/ignore_dsp_ready
> 
> Changes since v1
> - change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
> 
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..fb69f4e8ee96 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -26,9 +26,18 @@
>  #include "remoteproc_elf_helpers.h"
>  #include "remoteproc_internal.h"
>  
> +/*
> + * Module parameters
> + */
> +static unsigned int imx_dsp_rproc_ignore_ready;
> +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
> +MODULE_PARM_DESC(ignore_dsp_ready,
> +		 "Ignore remote proc reply after start, default is 0 (off).");
> +
>  #define DSP_RPROC_CLK_MAX			5
>  
>  #define REMOTE_IS_READY				BIT(0)
> +#define REMOTE_SKIP_WAIT			BIT(1)
>  #define REMOTE_READY_WAIT_MAX_RETRIES		500
>  
>  /* att flags */
> @@ -282,6 +291,10 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>  	struct imx_dsp_rproc *priv = rproc->priv;
>  	int i;
>  
> +	/* No IPC between the cores */
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return 0;
> +
>  	if (!priv->rxdb_ch)
>  		return 0;
>  
> @@ -503,6 +516,13 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
>  	struct mbox_client *cl;
>  	int ret;
>  
> +	/*
> +	 * If there is no IPC between the cores,
> +	 * then no need to initialize mailbox.
> +	 */
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return 0;
> +
>  	if (!of_get_property(dev->of_node, "mbox-names", NULL))
>  		return 0;
>  
> @@ -562,6 +582,10 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
>  
>  static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
>  {
> +	/* No IPC between the cores */
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return;
> +
>  	mbox_free_channel(priv->tx_ch);
>  	mbox_free_channel(priv->rx_ch);
>  	mbox_free_channel(priv->rxdb_ch);
> @@ -903,6 +927,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>  	priv->rproc = rproc;
>  	priv->dsp_dcfg = dsp_dcfg;
>  
> +	if (imx_dsp_rproc_ignore_ready)
> +		priv->flags |= REMOTE_SKIP_WAIT;
> +
>  	dev_set_drvdata(dev, rproc);
>  
>  	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> -- 
> 2.17.1
> 
