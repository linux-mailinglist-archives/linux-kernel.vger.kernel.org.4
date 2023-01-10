Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A54664062
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjAJMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjAJMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:23:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C10195BE;
        Tue, 10 Jan 2023 04:20:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bu8so18111285lfb.4;
        Tue, 10 Jan 2023 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSwSP02DsncYfTHjeowyTlULcu2EadZct6T7+26J7KA=;
        b=TQ4l32d0a7OZO3VatnkrsEzt1PogUEHk7PMLOGQWEL54RgJsERym7RyzGAaRb1e/G0
         TkeidMtZQPqDF6BZa/rLccuNBUPVEIYWW4Uh6ukstSbkBz2gE5EC4icfNqOEgPQG2sFe
         gkU4CM7gpLTqcVBAt3uTNXLaeXselVZOuG3XBTcM2oJqEjCELheiwT8g9zoSQIduqSx7
         inx1N408sx7LWWWyYMAqmj8vyo98gProAjEArWfDc7W0kQbeBBtZPQWRu4Er1Dmj2Ykb
         Kd3QkLVMphpBKcibhA+sD0fNxUbbQIboWnWON9lIfGdi6fQ0VTO6AeX66MfD1+BDnwnY
         pNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSwSP02DsncYfTHjeowyTlULcu2EadZct6T7+26J7KA=;
        b=AqJv+dJPnm3VBvuMj2C+jmZlv3tGg3RqqWOZVm8HYZJkYWYn0Fx+p6Z05NL2G08fzz
         3yXrMQul1bnGfhAxXGWS05YJ/WBQL0ArMyw22zMfU76hWismsJTGbnie5uj4oBmSc4MN
         77LT5pD5bXKXij2Y6Za6FAY/DSvSon0IK97ngPHQpcqKpzBhvYP04t1wC6A2o8oG5AhV
         YW2BmeW/L3QYxI0YRDQJBSFIZ19zH+YRE8sj0+X8aeX7IJQ6MVjwDlV9o//9CE+YqVr/
         PYTLQlJ4dVxHA9JY7qWn2QX84Ye/r8pbnGflEDdh6PY2AojrDvxPuwFQboLdPpDb+nO9
         i0Ag==
X-Gm-Message-State: AFqh2kpJnYnclQG9giaA5hhHHJdZ4lZEVmFH1kQeHfuKOWfTS214NWa8
        I2vatw4rTg2Og3ysKXSOS8I=
X-Google-Smtp-Source: AMrXdXssxMYBOYzjchYz4a3IjpXoI490Q76A60dsnVeGegwgKAI4mgwnE3cBiEsMT2p6z4Zpak9e4w==
X-Received: by 2002:a05:6512:3d2a:b0:4b4:b8fc:4aba with SMTP id d42-20020a0565123d2a00b004b4b8fc4abamr23046544lfv.25.1673353255481;
        Tue, 10 Jan 2023 04:20:55 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id 12-20020ac25f0c000000b004cb3aced3f9sm2164501lfq.226.2023.01.10.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:20:55 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:20:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/15] spi: dw: detect enhanced spi mode
Message-ID: <20230110122053.a4x2oyb5fbjoenia@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-14-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-14-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:30PM +0000, Sudip Mukherjee wrote:
> All the SSI controllers supporting enhanced spi modes might not support
> all the three dual or quad or octal modes. Detect the modes that are
> supported and finally enable the DW_SPI_CAP_EMODE capability which will
> start using all the enhanced spi functions that has been added.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 68 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index cef56acd8d8fd..9e806d5878beb 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -1143,6 +1143,69 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>  		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
>  }
>  
> +static u16 detect_enh_mode(struct dw_spi *dws)
> +{

> +	u16 mode = 0;
> +	u32 tmp_spi_ctrlr0, tmp_ctrlr0, tmpdual, tmpquad, tmpoct;
> +
> +	if (dw_spi_ver_is_ge(dws, HSSI, 103A)) {
> +		tmpdual = FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
> +				     DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI);
> +		tmpquad = FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
> +				     DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI);
> +		tmpoct = FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
> +				    DW_SPI_CTRLR0_SPI_FRF_OCT_SPI);
> +	} else if (dw_spi_ver_is_ge(dws, PSSI, 400A)) {
> +		tmpdual = FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
> +				     DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI);
> +		tmpquad = FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
> +				     DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI);
> +		tmpoct = FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
> +				    DW_SPI_CTRLR0_SPI_FRF_OCT_SPI);

Seems too complicated. What about calculating the IP-core specific
offset and mask here and use them afterwards to create the test CTRLR0
CSR data?

> +	} else {
> +		return DW_SPI_CTRLR0_SPI_FRF_STD_SPI;
> +	}
> +
> +	tmp_ctrlr0 = dw_readl(dws, DW_SPI_CTRLR0);
> +	tmp_spi_ctrlr0 = dw_readl(dws, DW_SPI_SPI_CTRLR0);
> +	dw_spi_enable_chip(dws, 0);
> +

> +	/* test clock stretching */
> +	dw_writel(dws, DW_SPI_SPI_CTRLR0, DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN);
> +	if ((DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN & dw_readl(dws, DW_SPI_SPI_CTRLR0)) !=
> +	    DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN)
> +		/*
> +		 * If clock stretching is not enabled then do not use
> +		 * enhanced mode.
> +		 */
> +		goto disable_enh;
> +

Clock stretching is eSPI-specific feature. So it should be checked
after making sure that the eSPI is available.

> +	/* test dual mode */
> +	dw_writel(dws, DW_SPI_CTRLR0, tmpdual);
> +	if ((tmpdual & dw_readl(dws, DW_SPI_CTRLR0)) == tmpdual)
> +		mode |= SPI_TX_DUAL | SPI_RX_DUAL;
> +
> +	/* test quad mode */
> +	dw_writel(dws, DW_SPI_CTRLR0, tmpquad);
> +	if ((tmpquad & dw_readl(dws, DW_SPI_CTRLR0)) == tmpquad)
> +		mode |= SPI_TX_QUAD | SPI_RX_QUAD;
> +
> +	/* test octal mode */
> +	dw_writel(dws, DW_SPI_CTRLR0, tmpoct);
> +	if ((tmpoct & dw_readl(dws, DW_SPI_CTRLR0)) == tmpoct)
> +		mode |= SPI_TX_OCTAL | SPI_RX_OCTAL;

Are you sure that writing a non-supported mode causes having the
CTRLR0.SPI_FRF field unupdated? What eSPI-modes do your hardware
support?

> +
> +	if (mode)
> +		dws->caps |= DW_SPI_CAP_EMODE;
> +
> +disable_enh:
> +	dw_writel(dws, DW_SPI_CTRLR0, tmp_ctrlr0);
> +	dw_writel(dws, DW_SPI_SPI_CTRLR0, tmp_spi_ctrlr0);
> +	dw_spi_enable_chip(dws, 1);
> +
> +	return mode;

Move all the above to the dw_spi_hw_init() method where all the
auto-detections is implemented.

-Serge(y)

> +}
> +
>  int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  {
>  	struct spi_controller *master;
> @@ -1172,10 +1235,11 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  		goto err_free_master;
>  	}
>  
> -	dw_spi_init_mem_ops(dws);
> -
>  	master->use_gpio_descriptors = true;
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> +	master->mode_bits |= detect_enh_mode(dws);
> +	dw_spi_init_mem_ops(dws);
> +
>  	if (dws->caps & DW_SPI_CAP_DFS32)
>  		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>  	else
> -- 
> 2.30.2
> 
