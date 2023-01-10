Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4046D663F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjAJLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjAJLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:40:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D615FC6;
        Tue, 10 Jan 2023 03:40:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so17962964lfr.3;
        Tue, 10 Jan 2023 03:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8qIHMNO2s1UBLosBalnkXRDkilmbPNHsObMEKK0n7I=;
        b=bg0lxmUdGEI7jbzLJkVcT7QTNyzIGfCKVN9kCtEWnYtmWtxXDIJr+SGpqR+Y3oXyOh
         o52zHSRr3wl1Mm2VzjX2viW390JajcGoIMyebxQjpG79RGS9ir2j2W898mtqorEQtuuo
         9CL0C07wCX5qC6yMZpO+qA/Wgmj6XDDw0aaEJHZA9hK3x6NCGPEH11TMMp+pv9+kSYD8
         /IqIW7dpa+lavlm/CJ88qV1Ggzrrvx9lcHVpC/6/TjISZVwVWVAhKyne5bRs4rIlQ0bm
         O0P3LPKFXqNy/SrGeEyurCSsgQbvDwA6pMYr4EBvhDUPWmabBgkLL665O7U6hImH9KU2
         d93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8qIHMNO2s1UBLosBalnkXRDkilmbPNHsObMEKK0n7I=;
        b=QLJ3eD7+SEzGj2gExzXwd5xKw8+t4EdIwFt4b75UCUfn1LK5ZXCflUgYKBeC1RRbiQ
         m8FGFBbY6MuPXvJXOYrmmK+z5XkW+sxceUUnTtJettr2bwqAfBxO9YIQ4YSlvf/Y0BVd
         Q2JRe5J4/G6GbLbB24yuPVfzzXTBsQO37ddVy+erYx+iI5eP7C7svkXk+TWBN/n9aV3V
         9F4wj4an48hVFFRGERkRVTyel4WUuLeKgQoHlJMGRfPmoa4PSpLENwrx2q9nmG8EwXzC
         tTZk97TRFOiPTiSCPcvF8wzvuyB7nzbfm0E8ro8Ybs6Ob0qRleFj6ddujbMTAnyy0q25
         LW+Q==
X-Gm-Message-State: AFqh2kq6jEcy3aDDn3P+hjZDpE0fN6PLBzXkZzaWvOUwCPv84ECzOam7
        HrZc900LmZeRRwheGNQtzXU=
X-Google-Smtp-Source: AMrXdXtuH+xA3IMA2Oj1CQEJ3XtMeuSO3tj6Mv1uTxbMVCwbTvZ0a/Xo0G7JeTnVjGBAj4jFCHRcQw==
X-Received: by 2002:ac2:5bc5:0:b0:4ad:5fbb:a594 with SMTP id u5-20020ac25bc5000000b004ad5fbba594mr19772858lfn.58.1673350832790;
        Tue, 10 Jan 2023 03:40:32 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id z3-20020a0565120c0300b004cb03999979sm2139849lfu.40.2023.01.10.03.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:40:32 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:40:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] spi: dw: Introduce dual/quad/octal spi
Message-ID: <20230110114030.hz3hkou5owxaeopc@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-7-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-7-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:23PM +0000, Sudip Mukherjee wrote:
> If the spi transfer is using dual/quad/octal spi mode, then we need to
> update the SPI_CTRLR0 register. The SPI_CTRLR0 register will be updated
> in dw_spi_update_config() via the values in dw_spi_cfg.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
> 
> Note: DW_SPI_SPI_CTRLR0_INST_L_INST_L16 will not work yet as
> spi_mem_default_supports_op() checks for op->cmd.nbytes != 1.
> 
>  drivers/spi/spi-dw-core.c | 46 +++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-dw.h      |  9 ++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 89438ae2df17d..06169aa3f37bf 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -836,10 +836,56 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
>  	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> +	struct dw_spi_cfg cfg;
> +

> +	switch (op->data.buswidth) {
> +	case 2:
> +		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI;
> +		break;
> +	case 4:
> +		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI;
> +		break;
> +	case 8:
> +		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_OCT_SPI;
> +		break;
> +	default:
> +		return dw_spi_exec_mem_op(mem, op);

case 1:
	return dw_spi_exec_mem_op(mem, op);
case 2:
	cfg.enh_frf = DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI;
	break;
...
default:
	return -EINVAL;

> +	}
>  
>  	/* Collect cmd and addr into a single buffer */
>  	dw_spi_init_enh_mem_buf(dws, op);
>  
> +	cfg.dfs = 8;
> +	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
> +	cfg.ndf = op->data.nbytes;
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
> +	else
> +		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;

Newline, please.

> +	if (op->data.buswidth == op->addr.buswidth &&
> +	    op->data.buswidth == op->cmd.buswidth)
> +		cfg.trans_t = DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT2;
> +	else if (op->data.buswidth == op->addr.buswidth)
> +		cfg.trans_t = DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT1;
> +	else
> +		cfg.trans_t = DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT0;
> +

> +	cfg.addr_l = clamp(op->addr.nbytes * 2, 0, 0xf);

First the address length should be checked in the
spi_controller_mem_ops.supports_op method. Thus the clamping procedure
would be redundant. Second instead of using the multiplication
operator I would suggest to have the bitwise left-shift op utilized
here, (cfg.addr_l = op->addr.nbytes << 2). This shall look a bit more
coherent.


> +	if (op->cmd.nbytes > 1)
> +		cfg.inst_l = DW_SPI_SPI_CTRLR0_INST_L_INST_L16;

No. Firstly INST_L16 means 2-bytes length. Using greater-than op here
is incorrect. Secondly the command part length should be
checked in the spi_controller_mem_ops.supports_op callback.

> +	else if (op->cmd.nbytes == 1)
> +		cfg.inst_l = DW_SPI_SPI_CTRLR0_INST_L_INST_L8;
> +	else
> +		cfg.inst_l = DW_SPI_SPI_CTRLR0_INST_L_INST_L0;
> +

> +	cfg.wait_c = (op->dummy.nbytes * (BITS_PER_BYTE / op->dummy.buswidth));

Hm, what if buswidth is zero?

> +
> +	dw_spi_enable_chip(dws, 0);
> +
> +	dw_spi_update_config(dws, mem->spi, &cfg);
> +
> +	dw_spi_enable_chip(dws, 1);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 327d037bdb10e..494b830ad1026 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -101,6 +101,9 @@
>  #define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
>  #define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)

>  #define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0
> +#define DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI		0x1
> +#define DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI		0x2
> +#define DW_SPI_CTRLR0_SPI_FRF_OCT_SPI		0x3

Please replace SPI_FRF with ENH_FRF and drop _SPI suffix from the
macros.

>  
>  /* Bit fields in CTRLR1 */
>  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
> @@ -132,7 +135,13 @@
>  #define DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN	BIT(30)
>  #define DW_SPI_SPI_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
>  #define DW_SPI_SPI_CTRLR0_INST_L_MASK		GENMASK(9, 8)

> +#define DW_SPI_SPI_CTRLR0_INST_L_INST_L0	0x0
> +#define DW_SPI_SPI_CTRLR0_INST_L_INST_L8	0x2
> +#define DW_SPI_SPI_CTRLR0_INST_L_INST_L16	0x3
>  #define DW_SPI_SPI_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
> +#define DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT0	0x0
> +#define DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT1	0x1
> +#define DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT2	0x2

Please replace SPI_CTRLR0 with ENH_CTRLR0.

-Serge(y)

>  
>  /* Mem/DMA operations helpers */
>  #define DW_SPI_WAIT_RETRIES			5
> -- 
> 2.30.2
> 
