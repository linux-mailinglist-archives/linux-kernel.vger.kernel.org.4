Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA76CC9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC1SDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjC1SDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:03:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BADE1A7;
        Tue, 28 Mar 2023 11:03:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id br6so16883531lfb.11;
        Tue, 28 Mar 2023 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680026621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhrmRhUT97cAmw/OsHOrx7HWOGCRH6VWH9Ccd4IUdfc=;
        b=k3cKBec0g8sl6JG6QqzpalAv0Y5tKLp7B+DofzqdQYIVaoiAR7fFLbe7LFaGjP+MNk
         7Sk9e2taqH8mpy5mpASgct/dI+8nnzmAozVl1rj8JVFQ42P8DSzcmyYigK/Myb/pWiAr
         ITMwsP13ZQ92cfgOiUzTcwsYfQL5RGmk3sMHMrxSAJ0shP7MjLkWQqLtd2IGTyUnc0CX
         0G7+92QI7n2Eb4EQlDypW6SzNbVcocyXJu1LEnyiBjjtJIKxutD/z09Yv6CYgcvs0XCP
         uk4KZlDVzPYsEKUI5C6KSoHmry32FfBa7qEpbi9JJS7rRsLSZ8uKuujpAz9EiT4bN50t
         JuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhrmRhUT97cAmw/OsHOrx7HWOGCRH6VWH9Ccd4IUdfc=;
        b=2MWGwqsqymJR2Nn1SWzGPbJS+4R2K/+fhoh9ShneQ+O92YcprlG9dza0ipkcFv0GMB
         dzStMmiIsfub5b0EccxTS9SQ7Zk+oW23dfYkhTkTH0sxbo2rjkqui0iaJF82z3JpofAe
         IyHBu86aE17iKkD8R7I7LBzn5xqUlQMmXrXTeWsLoU/QHpWa1GcuVYcC+QqVE6edlUTZ
         bmQkRppbinkGhiOPF3jGHBoH/VCqNmpQjVFr8hKgMA4Bpp0ftvVtswALyvAveLxc24Ig
         Sf54dl+SWGs5n0XekxC5z8WGPzhdw6B3a7fby2IsYUaO8Fsm25Q23gqJoMVf5CnPEqQo
         IS1g==
X-Gm-Message-State: AAQBX9eGZ0zs8Uy8rmNt+NkORHl2m7lwEdVCn0SP3o4AVSqGfh2c0trq
        jn/o7KejtmKGUFqvXlWsV/xTAZZgKnc=
X-Google-Smtp-Source: AKy350YLxKeirxVk+prkC1FGKLeAA2m9nP/H+KGrjpD9LZMVicZeB3X/aCRrnKUrOrPaaA++EZBLJA==
X-Received: by 2002:a05:6512:20f:b0:4db:1e4a:74a1 with SMTP id a15-20020a056512020f00b004db1e4a74a1mr4393420lfo.0.1680026621069;
        Tue, 28 Mar 2023 11:03:41 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id c3-20020a05651221a300b004e9608517cesm5164298lft.280.2023.03.28.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:03:40 -0700 (PDT)
Date:   Tue, 28 Mar 2023 21:03:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v4 2/2] spi: dw: Add dma controller capability checks
Message-ID: <20230328180338.bpxvjwx4tn4ter3f@mobilestation>
References: <20230327043405.881645-1-joychakr@google.com>
 <20230327043405.881645-3-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327043405.881645-3-joychakr@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:34:05AM +0000, Joy Chakraborty wrote:
> Check capabilities of DMA controller during init to make sure it is
> capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> and store addr_width capabilities to check per transfer to make sure the
> bits/word requirement can be met for that transfer.
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/spi/spi-dw-dma.c | 54 ++++++++++++++++++++++++++++++++--------
>  drivers/spi/spi-dw.h     |  1 +
>  2 files changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index b3a88bb75907..f47483ec369f 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -23,6 +23,8 @@
>  #define DW_SPI_TX_BUSY		1
>  #define DW_SPI_TX_BURST_LEVEL	16
>  
> +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> +
>  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
>  {
>  	struct dw_dma_slave *s = param;
> @@ -72,12 +74,15 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
>  	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
>  }
>  
> -static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
> +static int dw_spi_dma_caps_init(struct dw_spi *dws)
>  {

> +	int ret;
>  	struct dma_slave_caps tx = {0}, rx = {0};

1. Preserve the reverse xmas tree order please (driver local convention).
2. The zero-initialization can be dropped since the function will halt
on further procedures if any of the dma_get_slave_caps() calls fail.
Meanwhile if all of them are successfully executed the capability
structures will be sanely initialized.

>  
> -	dma_get_slave_caps(dws->txchan, &tx);
> -	dma_get_slave_caps(dws->rxchan, &rx);

> +	ret = dma_get_slave_caps(dws->txchan, &tx);
	if (ret)
		return ret;
< newline
> +	ret |= dma_get_slave_caps(dws->rxchan, &rx);
> +	if (ret)
> +		return ret;

No OR-ing the errnos please. They aren't bitfields.

>  
>  	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
>  		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
> @@ -87,6 +92,18 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
>  		dws->dma_sg_burst = rx.max_sg_burst;
>  	else
>  		dws->dma_sg_burst = 0;
> +
> +	/*
> +	 * Assuming both channels belong to the same DMA controller hence the
> +	 * address width capabilities most likely would be the same.
> +	 */
> +	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
> +

> +	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> +	      rx.directions & BIT(DMA_DEV_TO_MEM)))
> +		return -ENXIO;

Please move this to be right after the capabilities are retrieved.
There is no point in the SG-burst and addr-width data initializations
if a DMA-controller isn't suitable for the Tx/Rx DMAs.

-Serge(y)

> +
> +	return 0;
>  }
>  
>  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> @@ -95,6 +112,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
>  	struct pci_dev *dma_dev;
>  	dma_cap_mask_t mask;
> +	int ret = -EBUSY;
>  
>  	/*
>  	 * Get pci device for DMA controller, currently it could only
> @@ -124,20 +142,24 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  
>  	init_completion(&dws->dma_completion);
>  
> -	dw_spi_dma_maxburst_init(dws);
> +	ret = dw_spi_dma_caps_init(dws);
> +	if (ret)
> +		goto free_txchan;
>  
> -	dw_spi_dma_sg_burst_init(dws);
> +	dw_spi_dma_maxburst_init(dws);
>  
>  	pci_dev_put(dma_dev);
>  
>  	return 0;
> -
> +free_txchan:
> +	dma_release_channel(dws->txchan);
> +	dws->txchan = NULL;
>  free_rxchan:
>  	dma_release_channel(dws->rxchan);
>  	dws->rxchan = NULL;
>  err_exit:
>  	pci_dev_put(dma_dev);
> -	return -EBUSY;
> +	return ret;
>  }
>  
>  static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
> @@ -163,12 +185,16 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  
>  	init_completion(&dws->dma_completion);
>  
> -	dw_spi_dma_maxburst_init(dws);
> +	ret = dw_spi_dma_caps_init(dws);
> +	if (ret)
> +		goto free_txchan;
>  
> -	dw_spi_dma_sg_burst_init(dws);
> +	dw_spi_dma_maxburst_init(dws);
>  
>  	return 0;
> -
> +free_txchan:
> +	dma_release_channel(dws->txchan);
> +	dws->txchan = NULL;
>  free_rxchan:
>  	dma_release_channel(dws->rxchan);
>  	dws->rxchan = NULL;
> @@ -202,8 +228,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
>  			   struct spi_device *spi, struct spi_transfer *xfer)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(master);
> +	enum dma_slave_buswidth dma_bus_width;
> +
> +	if (xfer->len <= dws->fifo_len)
> +		return false;
> +
> +	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
>  
> -	return xfer->len > dws->fifo_len;
> +	return dws->dma_addr_widths & BIT(dma_bus_width);
>  }
>  
>  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 9e8eb2b52d5c..3962e6dcf880 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -190,6 +190,7 @@ struct dw_spi {
>  	struct dma_chan		*rxchan;
>  	u32			rxburst;
>  	u32			dma_sg_burst;
> +	u32			dma_addr_widths;
>  	unsigned long		dma_chan_busy;
>  	dma_addr_t		dma_addr; /* phy address of the Data register */
>  	const struct dw_spi_dma_ops *dma_ops;
> -- 
> 2.40.0.348.gf938b09366-goog
> 
