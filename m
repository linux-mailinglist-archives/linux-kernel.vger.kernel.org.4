Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B6663FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjAJMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbjAJMLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:11:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3C2009;
        Tue, 10 Jan 2023 04:08:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bq39so18114965lfb.0;
        Tue, 10 Jan 2023 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CJci5KqQGpU6nxS4CAw5MZMI44xkNZEkWm4NgJAkZM=;
        b=OujkATZMDiNykq2g44d+ZXJ0qJTsXLlUCcO+xAkiS3W0TXEtlpMP5oYwd/B4mBosYs
         5T1csjrYF39pK7yvg0YeC3fEKowOHNLmablV8igvguhxYVMwb7IFszVXoZxmUMkGd28e
         /OebKXT8/AbJjYvocZS5tu4n2nu4Iy+KbUM6Z3HRDmam36zMc0hT3eSLIs7V4sFi/HUQ
         gHzaxPjaCYGF9WELV38TE18GCs4a6y73fxcg33AabqI3karT3uSZlYVrRdacnTUJwIMJ
         Z9zWc9A5DVGsV/OodfoV3J0wb6+K48NSXLuTvLKkpZ68gI3IQS81KGqhBFSCkKJwNdb2
         1PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CJci5KqQGpU6nxS4CAw5MZMI44xkNZEkWm4NgJAkZM=;
        b=gxA7dHxqN4dIzDUpNLueE2iePDk0YXXgu/YdcnE8Jb19/WI7UwvHvZNgs9o7HuFFsH
         2vIjUSQ3tcuR16WJvFJhUX2cyT1NGBA2qsig3Pz1JPCATS7pyyNU+HZbBRMe3SCy6nh9
         VXMjWeaPjuJ9fbjNVfXjyZlfMvFKAlku9QJlIOp2nLUKOmj8l/e8617KDCIVKL+aBn37
         zlJUcF9CRqRJG5c9deOEmfdVMk1gdr19PP1GNmBGak+MBmYB+6H6r8vwe4A5go8pWVSb
         K62EpS/axGWIOKKiXZixXa6fkeIKYoPZExpDgcxu0IxogOK/R1qbUGK86qIjr8WwPzDK
         hH6Q==
X-Gm-Message-State: AFqh2kqadB+51fpVIKPt7BAulVddqUQtUG9YsP/7LEOISHLihjsscGrl
        k/52jKIScuD3bP2tEMJNYVQ=
X-Google-Smtp-Source: AMrXdXsxhbAW5/WtZo2fkxUBe/3oaWhFvuggaypnX68IKzIThWxicfL9ubiUJJMw2ocsSx3d+XpzoA==
X-Received: by 2002:a05:6512:3c88:b0:4b4:e4a1:2fc6 with SMTP id h8-20020a0565123c8800b004b4e4a12fc6mr24307012lfv.68.1673352508510;
        Tue, 10 Jan 2023 04:08:28 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u15-20020a19790f000000b004cb344a8c77sm2146398lfc.54.2023.01.10.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:08:27 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:08:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] spi: dw: use irq handler for enhanced spi
Message-ID: <20230110120825.pykbn7ym3ml2rv7s@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-10-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-10-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:26PM +0000, Sudip Mukherjee wrote:
> Introduce the interrupt handler for enhanced spi to read or write based
> on the generated irq. Also, use the xfer_completion from spi_controller
> to wait for a timeout or completion from irq handler.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 62 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index f540165245a89..10d453228368f 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -251,6 +251,34 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
> +{
> +	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
> +
> +	if (dw_spi_check_status(dws, false)) {

> +		spi_finalize_current_transfer(dws->master);

As I suggested in the cover-letter please use the dw_spi_dma_wait()
function for that.

> +		return IRQ_HANDLED;
> +	}
> +
> +	if (irq_status & DW_SPI_INT_RXFI) {
> +		dw_reader(dws);
> +		if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR))
> +			dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
> +	}
> +
> +	if (irq_status & DW_SPI_INT_TXEI)
> +		dw_writer(dws);
> +

> +	if (!dws->tx_len && dws->rx_len) {
> +		dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
> +	} else if (!dws->rx_len && !dws->tx_len) {
> +		dw_spi_mask_intr(dws, 0xff);
> +		spi_finalize_current_transfer(dws->master);

Why so complicated? You have two types of the transfers: Tx-only and
Rx-only. Thus you can unmask only one type of the IRQs and terminate
the process upon both lengths are zero.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  {
>  	struct spi_controller *master = dev_id;
> @@ -265,6 +293,12 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  		dw_spi_mask_intr(dws, 0xff);
>  		return IRQ_HANDLED;
>  	}

> +	if ((dws->transfer_handler == dw_spi_enh_handler &&
> +	     !dws->rx_len && !dws->tx_len)) {
> +		dw_spi_mask_intr(dws, 0xff);
> +		spi_finalize_current_transfer(master);
> +		return IRQ_HANDLED;

Why? You already have this statement in the handler above.

> +	}
>  
>  	return dws->transfer_handler(dws);
>  }
> @@ -862,6 +896,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
>  	struct spi_controller *ctlr = mem->spi->controller;
>  	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
>  	struct dw_spi_cfg cfg;
> +	int ret = 0;
> +	unsigned long long ms;
>  
>  	switch (op->data.buswidth) {
>  	case 2:
> @@ -909,11 +945,35 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
>  
>  	dw_spi_update_config(dws, mem->spi, &cfg);
>  
> +	dw_spi_mask_intr(dws, 0xff);
> +	reinit_completion(&ctlr->xfer_completion);
>  	dw_spi_enable_chip(dws, 1);
>  
>  	dw_spi_enh_write_cmd_addr(dws, op);
> +	dw_spi_set_cs(mem->spi, false);
> +	dw_spi_irq_setup(dws, dw_spi_enh_handler);
>  
> -	return 0;

> +	/* Use timeout calculation from spi_transfer_wait() */
> +	ms = 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
> +	do_div(ms, dws->current_freq);
> +
> +	/*
> +	 * Increase it twice and add 200 ms tolerance, use
> +	 * predefined maximum in case of overflow.
> +	 */
> +	ms += ms + 200;
> +	if (ms > UINT_MAX)
> +		ms = UINT_MAX;
> +
> +	ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> +					 msecs_to_jiffies(ms));

All of that is already implemented in the dw_spi_dma_wait() method.
Moreover addr+cmd write procedure, IRQ setup and wait-for-completion
can be consolidate in the dw_spi_enh_write_then_read() function thus
having the dw_spi_enh_exec_mem_op method looking similar to the
standard dw_spi_exec_mem_op().

-Serge(y)

> +
> +	dw_spi_stop_mem_op(dws, mem->spi);
> +
> +	if (ms == 0)
> +		ret = -EIO;
> +
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.30.2
> 
