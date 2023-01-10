Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22406663F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjAJLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjAJLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:46:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E0517F0;
        Tue, 10 Jan 2023 03:46:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v25so17937934lfe.12;
        Tue, 10 Jan 2023 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLjxpJGNpLvyG9yHhgQJ1yjZMPsSmtr+fpz3920L3uo=;
        b=WJYkrieonm2ZPiY9uT0qyAUC+gKBMZW/6J2IjwIX1Uq4JZYAnCFTpyhyyyeXALPPTI
         FXoI8dIvp6UyvDmeSgvBEdIiaEyV1vp5Dd9cJHoPs37MzR6nSDA3kzXVQFQFNKcSnx5b
         zdl/UqDbdMWoXyGOOpuVJfKneihc0zhInqVULk7E1OtyuPwDhDNV2Bn+hvvKSqwQIcnf
         YwUtfbweOtYLH2D5izD70HT13tctuUhiw4don0YumWduZ0Fv9j0j1weZEWyvGwusLUuf
         wuNuMVJCY0vU/liK9H9+BsXV/ocj41fnn5xjVnbJFZzu6tuQ2a10lW4XgWJHag+om9wf
         pONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLjxpJGNpLvyG9yHhgQJ1yjZMPsSmtr+fpz3920L3uo=;
        b=FJnfxDtCuxI0thcN2IqhbLjuzYL3NOJYkFuVD96xA3rPiP4SJbapjGMC5mcFq8jkoZ
         Aoz6ZzhVfTaXWyihfhkdYY9TOeqigVULFbFkbof6erSd4YeKF3PsINS3K3UNLjEOY5HQ
         6zxlvE7V84cbsP4eUikNOzRZnVK9TdnYkrTTi5tPfwR6ItRrTCrG4fiP9ReuEAdZAPP7
         nSbsYQv4bJA8rAFvhCy440m7BfHaaHMiN4v6qz6hlNL7WPpn9XqzmI80j/ZeMR52QbBr
         HQ8FOqyaBbwY08mWz8c9sqdodoN2jfzT5nJDUl01nqARnqiM5LWVlTHwMq0IgLdIaZbd
         Mf7g==
X-Gm-Message-State: AFqh2krsaw4CqgFY3+RYvrPnnYq4t8jV1batqP9DapBg6wF3mfXp/n5f
        20+TBPmL5tzveGDGNEUqsgqtNwaZ8p4=
X-Google-Smtp-Source: AMrXdXtqRfxhWoTdncqRUwyPzHxTOMK6ldZKL7yA+m67RT6V3O/PmdBCKjZzj0pFHl68TovDjne0ig==
X-Received: by 2002:a05:6512:261a:b0:4ca:f432:3e45 with SMTP id bt26-20020a056512261a00b004caf4323e45mr19718725lfb.33.1673351199357;
        Tue, 10 Jan 2023 03:46:39 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id f7-20020a056512360700b004cc8698c3f4sm687212lfs.156.2023.01.10.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:46:38 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:46:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] spi: dw: update irq setup to use multiple
 handler
Message-ID: <20230110114636.x7rhpzcevqjqepkh@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-9-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-9-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:25PM +0000, Sudip Mukherjee wrote:
> The current mem_ops is not using interrupt based transfer so
> dw_spi_irq_setup() only has one interrput handler to handle the non
> mem_ops transfers. We will use interrupt based transfers in enhanced
> spi and so we need a way to specify which irq handler to use.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index ecab0fbc847c7..f540165245a89 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -260,7 +260,8 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  	if (!irq_status)
>  		return IRQ_NONE;
>  

> -	if (!master->cur_msg) {
> +	if (!master->cur_msg && dws->transfer_handler ==
> +	    dw_spi_transfer_handler) {

What about replacing this with the (!dws->rx_len && !dws->tx_len)
statement?

>  		dw_spi_mask_intr(dws, 0xff);
>  		return IRQ_HANDLED;
>  	}
> @@ -380,7 +381,8 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  }
>  EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, SPI_DW_CORE);
>  
> -static void dw_spi_irq_setup(struct dw_spi *dws)
> +static void dw_spi_irq_setup(struct dw_spi *dws,
> +			     irqreturn_t (*t_handler)(struct dw_spi *))
>  {
>  	u16 level;
>  	u8 imask;
> @@ -394,7 +396,7 @@ static void dw_spi_irq_setup(struct dw_spi *dws)

>  	dw_writel(dws, DW_SPI_TXFTLR, level);
>  	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
>  
> -	dws->transfer_handler = dw_spi_transfer_handler;
> +	dws->transfer_handler = t_handler;
>  
>  	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
>  		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;

I'd suggest to create a separate dw_spi_enh_irq_setup() method which
would unmask only the required IRQs, initialize the threshold level
depending on the transfer type and set the
dw_spi_enh_transfer_handler() handler.

-Serge(y)

> @@ -486,7 +488,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  	else if (dws->irq == IRQ_NOTCONNECTED)
>  		return dw_spi_poll_transfer(dws, transfer);
>  
> -	dw_spi_irq_setup(dws);
> +	dw_spi_irq_setup(dws, dw_spi_transfer_handler);
>  
>  	return 1;
>  }
> -- 
> 2.30.2
> 
