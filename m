Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62221663F13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjAJLMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbjAJLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:11:41 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988B5F90;
        Tue, 10 Jan 2023 03:10:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so17851951lfb.6;
        Tue, 10 Jan 2023 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGvqCEOPakewBuBmeyCn0TskhEMhIc1i+rfL7LvnWYM=;
        b=EbAAGRIxN2UDmfiyarRd3jUP9k9c9bZuu8JdbhYRmtyrQgMn694hhcmrEvn7VtUw9D
         IyogNRMQoEDbNYB5cab/+WCqcURYsWvPAFCqcxf2qVvXocJjvOaF0oXML/87Kz/YudrQ
         kwFe5fRVNiDSmOrmOHL1t/rcesRAgF+tgqMjddRBKe/FzLwYoQBr5oPUyW8Hlo9hgjOi
         4LgvSlClxm0+7rdIGBOcZnvCzqawxg4XoAEKJ/x91YtJqyl5O9VhTjnBu+f92mp2QGoF
         EWH79wvQxCjQZe7P37scjczRyYvVmsSN8m3+OULyXAR3lFSolExGavMeijfZqOQg2hYI
         43dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGvqCEOPakewBuBmeyCn0TskhEMhIc1i+rfL7LvnWYM=;
        b=Vyc7rU1z79LBzSYsQ2FW3eQpaKWyuHTkQhqpRQp7nHcdN0wHrj6GhekzsD299/R2NV
         SaMs5p4m/X8egYQGZdZyu8kFEbs4pWwnVpexwhCeiQ4yHUXMMgoD+E55AKmJxB0i83by
         ca9nyD34b/1m+Crm7r09GIEm7uA/vQKgVpoMd/X9b47NwrH4TeG1ma3WFmM5ThAmP1Mk
         PYFqYSneyZiX0N7QYDU3NqnUufxp77BzwaKXwoAUgEkdz49imObSJQfwdjG07f6mkMYC
         qa3uYoX43a1HHyFgLu7dhqeewjmN5HvskzdqNIkqxqYOwBf6aBkMuWk5nZNu1XfF8xcs
         G65A==
X-Gm-Message-State: AFqh2kpmKYXqxvk7bbVgy0JXyigjBoExhry8AYtmjYbRxFhtGzokf0k2
        Xk8rnqPoFXRvbzdqh8LijLI=
X-Google-Smtp-Source: AMrXdXuvW7VxKBzsyKsEACjOyrkXZyS0x3ay+QspKFGJyhC/ZycIFvMCpYCUAIvBHVTEpsmjCpkLxQ==
X-Received: by 2002:ac2:4bd3:0:b0:4b4:a460:c995 with SMTP id o19-20020ac24bd3000000b004b4a460c995mr26422455lfq.5.1673349058083;
        Tue, 10 Jan 2023 03:10:58 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bq32-20020a056512152000b004b5766f48d8sm2139438lfb.19.2023.01.10.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:10:57 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:10:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] spi: dw: Introduce enhanced mem_op
Message-ID: <20230110111055.ncleldwyqgcrnurq@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-6-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-6-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:22PM +0000, Sudip Mukherjee wrote:
> If the DW_SPI_CAP_EMODE capability is enabled then dw_spi_exec_enh_mem_op()
> will be used as the new enhanced mem_op. Lets initialize the buffer and
> get the pointers to receive and transmit data buffers.
> The DW_SPI_CAP_EMODE capability will be enabled in a later patch.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 53 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 49fad58ceb94a..89438ae2df17d 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -798,6 +798,51 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	return ret;
>  }
>  
> +static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
> +{
> +	unsigned int i, j;
> +	u8 *out;
> +

> +	out = dws->buf;
> +	for (i = 0; i < DW_SPI_BUF_SIZE; ++i)
> +		out[i] = 0;
> +
> +	for (i = 0, j = op->cmd.nbytes; i < op->cmd.nbytes; ++i, --j)
> +		out[i] = DW_SPI_GET_BYTE(op->cmd.opcode, op->cmd.nbytes - j);
> +
> +	for (j = op->addr.nbytes, i = dws->reg_io_width; j > 0; ++i, --j)
> +		out[i] = DW_SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j);

In case of the non-eSPI implementation the outbound data consolidation
was required to get the most optimal loop of data transfer. In this
case I don't see it was required since the clock stretching feature is
available and the IRQ-based xfer procedure is implemented. Do I miss
something?

-Serge(y)

> +
> +	dws->n_bytes = 1;
> +	if (op->data.dir == SPI_MEM_DATA_IN) {
> +		dws->rx = op->data.buf.in;
> +		dws->rx_len = op->data.nbytes;
> +		dws->tx = NULL;
> +		dws->tx_len = 0;
> +	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
> +		dws->tx_len = op->data.nbytes;
> +		dws->tx = (void *)op->data.buf.out;
> +		dws->rx = NULL;
> +		dws->rx_len = 0;
> +	} else {
> +		dws->rx = NULL;
> +		dws->rx_len = 0;
> +		dws->tx = NULL;
> +		dws->tx_len = 0;
> +	}
> +}
> +
> +static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct spi_controller *ctlr = mem->spi->controller;
> +	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> +
> +	/* Collect cmd and addr into a single buffer */
> +	dw_spi_init_enh_mem_buf(dws, op);
> +
> +	return 0;
> +}
> +
>  /*
>   * Initialize the default memory operations if a glue layer hasn't specified
>   * custom ones. Direct mapping operations will be preserved anyway since DW SPI
> @@ -812,11 +857,13 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
>  	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
>  	    !dws->set_cs) {
>  		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
> -		if (dws->caps & DW_SPI_CAP_EMODE)
> +		if (dws->caps & DW_SPI_CAP_EMODE) {
> +			dws->mem_ops.exec_op = dw_spi_exec_enh_mem_op;
>  			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
> -		else
> +		} else {
> +			dws->mem_ops.exec_op = dw_spi_exec_mem_op;
>  			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
> -		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
> +		}
>  		if (!dws->max_mem_freq)
>  			dws->max_mem_freq = dws->max_freq;
>  	}
> -- 
> 2.30.2
> 
