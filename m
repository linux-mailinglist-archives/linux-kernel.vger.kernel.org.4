Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC46C3A65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUT1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:27:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6075C532BC;
        Tue, 21 Mar 2023 12:27:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y14so16664727ljq.4;
        Tue, 21 Mar 2023 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679426851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc48Nt4j3TlkKrOXlZlJxBTrQ5rVvGqrZ56sMNYRQwM=;
        b=KcqDN8LnRGeX7IOgz7+EGJoE9/1fBQavh2Dz/VLxNqF9vU4yeYZHwuR6W255yscZjm
         KxsY9+tE25NHu+J9JEt84leRELmttAJL0WE02NC2kL8yJyd9S0p42KdeAexbPOoIg5HV
         vXecs+dfthg2M7Y7q/ApXXi6ifm4jfazceRd/RwGb3gd0m+5nDLmkXKkzdR253uRAl+5
         XM7OakirU3igWVDz8oZ/rqep/s30X2dzy2FOL+CtvxxF+NejWpgnQyg3UUUMc47oZUh7
         1W0UquGZMjg4Gf0rgw/axApSoqBnE0NmCQnqxeAqPSoehd8PCvoGr+zMYSLgQvJMPwvF
         XGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc48Nt4j3TlkKrOXlZlJxBTrQ5rVvGqrZ56sMNYRQwM=;
        b=aNDWUrfbN0WKvX4PbnJdhTephqbeavbcjFJFP3TUjUFBdYCTDUJxUun0/Q0qw4BWP8
         DREfOTaq7gNe+39aKImNej8pUWkuwWiINAYQVzYuwTWfLyZJuKPCu/18w3tZ20JjyRme
         PNp8+R6iU+OztwozLU5/GeA/raLS1qKetoHrII56oHeksq9R1z/NqMk+O0kwpS1IUSt9
         0meLh1rzyA7dLLHNShP9O3NJZ+HQa4NG1/SRp9HdyKgsOqBF3LW3juNc/ERKK5D55dyi
         J4PoMmljnED6nzsG44K1ZrWRUM6yhLZSMEYNMXK2vi1NDXZVFymMqCy8y05V3t5BBLAE
         RmwQ==
X-Gm-Message-State: AO0yUKW/PRJb1XJtasvVX1QCZgAuHGQScCQoMmDFVjr2pyuB8+Sv1/Y6
        /Cdmv+6Hv+TEWEJ5B6Bvb6A=
X-Google-Smtp-Source: AK7set81nJ8mHh1EA7HUTwFAYASAIV9oh70F5QhpkNyyiBr3gOy6wvvuenkXsA5gRR+deNkyf59ong==
X-Received: by 2002:a2e:9c55:0:b0:29f:390:6647 with SMTP id t21-20020a2e9c55000000b0029f03906647mr1107590ljj.18.1679426851221;
        Tue, 21 Mar 2023 12:27:31 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e99d2000000b00297dad1a2b0sm2296295ljj.103.2023.03.21.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:27:30 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:27:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230321192727.2ts4oabwiktblis3@mobilestation>
References: <20230321115843.2688472-1-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321115843.2688472-1-joychakr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:58:43AM +0000, Joy Chakraborty wrote:
> If DW Controller is capable of a maximum of 32 bits per word then SW or
> DMA controller has to write up to 32bit or 4byte data to the FIFO at a
> time.
> 

> This Patch adds support for AxSize = 4 bytes configuration from dw dma

* sorry for referring to the newbie-doc, but please note:
https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/process/submitting-patches.rst#L77
and
https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/process/submitting-patches.rst#L94

> driver if n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> It also checks to see if the dma controller is capable of satisfying the
> width requirement to achieve a particular bits/word requirement per
> transfer.
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/spi/spi-dw-dma.c | 37 ++++++++++++++++++++++++++++++++-----
>  drivers/spi/spi-dw.h     |  1 +
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index ababb910b391..9ac3a1c25e2d 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -23,6 +23,8 @@
>  #define DW_SPI_TX_BUSY		1
>  #define DW_SPI_TX_BURST_LEVEL	16
>  
> +static inline enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> +
>  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
>  {
>  	struct dw_dma_slave *s = param;
> @@ -89,6 +91,16 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
>  		dws->dma_sg_burst = 0;
>  }
>  
> +static void dw_spi_dma_addr_widths_init(struct dw_spi *dws)
> +{
> +	struct dma_slave_caps tx = {0}, rx = {0};
> +

> +	dma_get_slave_caps(dws->txchan, &tx);
> +	dma_get_slave_caps(dws->rxchan, &rx);

Even though in this case any dma_get_slave_caps() failure will
effectively disable the DMA-based transfers, in general it would be
useful to have the dma_get_slave_caps() return value checked and halt
further DMA-init in case if it's not zero. In addition to that if the
Tx/Rx DMA device doesn't have the DMA_SLAVE capability or DEV2MEM and
MEM2DEV direction specified the DMA device won't be suitable for
SPI-ing. So further DMA-initialization are pointless in that case too.
It's just a general note not obligating or requesting anything since
the respective update should have been done in a separate patch
anyway.

> +

> +	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;

Hm, in general the addr-width capabilities can mismatch. But it's very
much unlikely since both DMA channels normally belong to the same
controller. So I guess we can live with the suggested approach for now
but please add a comment above that line about the
assumption/limitation it implies.

> +}
> +
>  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  {
>  	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> @@ -128,6 +140,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  
>  	dw_spi_dma_sg_burst_init(dws);
>  
> +	dw_spi_dma_addr_widths_init(dws);
> +
>  	pci_dev_put(dma_dev);
>  
>  	return 0;
> @@ -167,6 +181,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  
>  	dw_spi_dma_sg_burst_init(dws);
>  
> +	dw_spi_dma_addr_widths_init(dws);
> +
>  	return 0;
>  
>  free_rxchan:
> @@ -202,18 +218,29 @@ static bool dw_spi_can_dma(struct spi_controller *master,
>  			   struct spi_device *spi, struct spi_transfer *xfer)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(master);

> +	enum dma_slave_buswidth dma_bus_width;
>  
> -	return xfer->len > dws->fifo_len;
> +	if (xfer->len > dws->fifo_len) {
> +		dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
> +		if (dws->dma_addr_widths & BIT(dma_bus_width))
> +			return true;
> +	}
< newline would have been nice, but...
> +	return false;

on the other hand a level of indentation could be decreased like this:

+	enum dma_slave_buswidth width;
+
+	if (xfer->len <= dws->fifo_len)
+		return false;
+
+	width = dw_spi_dma_convert_width(dws->n_bytes);
+
+	return !!(dws->dma_addr_widths & BIT(width));

-Serge(y)

>  }
>  
>  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
>  {
> -	if (n_bytes == 1)
> +	switch (n_bytes) {
> +	case 1:
>  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> -	else if (n_bytes == 2)
> +	case 2:
>  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
> -
> -	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +	case 3:
> +	case 4:
> +		return DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	default:
> +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +	}
>  }
>  
>  static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
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
> 2.40.0.rc1.284.g88254d51c5-goog
> 
