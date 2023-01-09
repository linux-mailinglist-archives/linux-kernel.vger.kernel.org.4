Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8720662B75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjAIQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjAIQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:43:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C01AA04;
        Mon,  9 Jan 2023 08:43:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m6so13870997lfj.11;
        Mon, 09 Jan 2023 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFMr2KsHgMM8LL+ZSBA8Rs+9+c78FfOw9aaVi/TXD0E=;
        b=UtuUPwsQqEU70yYxUDBMt5uyoyE59X8ptix+7PR9Gc/3iU/3xq/JrCxwJpvOmC7UEH
         DesVbm9CpgPlS26pdxjbyjOaQZpO6Ef8XGeTpSvFKFPedprL4lX+bSVKcF/R8EdRreIR
         Aw2NbMb5m40+Q2XM0j/6igzii1m7JrgvkDYTeFszR9xRh+080eqOm7u8VxL8KXEfZpAs
         qLa9ynhYabXMI9G6u+bCDDq+m5TVOAefulkDnpHNdlp7FeMnJjdIOEUZxEzCcA2Q6DoE
         IkDmBOswmdbvjbSOrEv0ijgBZDTUjY3gXBBix1M70pEyslGSJnC+jzsIGiLi4jFJ/QqP
         KZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFMr2KsHgMM8LL+ZSBA8Rs+9+c78FfOw9aaVi/TXD0E=;
        b=XQFYphLZyJOJDzUweg7W+JHX3vXgz1LOKS01XWpPpMOi5NBd57DcY8UHyLTvfLzeTB
         5XMD8MBwCgoQF/beim5xAPaC7QLfxZLesleYu5r/eTkXrxraFMg9We2PhuoTZZqA0ccP
         Q2GHZdk6gGf/UhPF4m4LPs16UtNCPebm3n1fqcsItnispE4tl/6woEkJHSAkenR4dKeg
         3m0lCiLWEOO2LHjUo5w2wrKrNTKHsaQ/5ZMIqd0jHeFF0Hjl2l+T6YHOO2giyQNrTeHw
         Y/iLsa7j0PW98u1inQ7sV1FLGutxkk5UKyV05gSILsEh9o/jmaDve/10ctKuBclm5qXS
         byxw==
X-Gm-Message-State: AFqh2kqno5zIQWh8zWS3eteLrvHgfaZ6bYDWidFxhvhjI47XJQSd05pN
        wOCfwdct8CRlEklm/hZ22Ps=
X-Google-Smtp-Source: AMrXdXtys4yX5LNTFJFfHJ/IXCU4em4xorjae9DoopKXny/OkIbjdRjT2GFIwkj8+uUgVIFdnb1yQQ==
X-Received: by 2002:ac2:5b41:0:b0:4a4:68b8:9c5b with SMTP id i1-20020ac25b41000000b004a468b89c5bmr17938324lfp.67.1673282597990;
        Mon, 09 Jan 2023 08:43:17 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bq32-20020a056512152000b004b5766f48d8sm1710765lfb.19.2023.01.09.08.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:43:17 -0800 (PST)
Date:   Mon, 9 Jan 2023 19:43:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] spi: dw: Introduce spi_frf and STD_SPI
Message-ID: <20230109164315.au3nkqny7bh3bnr7@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-2-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-2-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:18PM +0000, Sudip Mukherjee wrote:
> The DW APB SSI controllers of v4.x and newer and DW AHB SSI controllers
> supports enhanced SPI modes which can be defined from SPI_FRF of
> DW_SPI_CTRLR0 register. Without enhanced mode, these controllers will
> work in the standard spi mode.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 13 ++++++++++++-
>  drivers/spi/spi-dw.h      |  6 ++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 99edddf9958b9..77c23772bb3d9 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -333,6 +333,16 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  		/* CTRLR0[11:10] Transfer Mode */
>  		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
>  

> +	if (dw_spi_ver_is_ge(dws, HSSI, 103A)) {

eSPI has been available most likely since 1.00a (at least 1.01a
has that feature).

> +		cr0 &= ~DW_HSSI_CTRLR0_SPI_FRF_MASK;

No need in masking that field because the cr0 variable is
pre-initialized with the device-specific value anyway.

> +		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,

> +				  cfg->spi_frf);

The HW-manual defines that field as SPI_FRF, but the SPI_ prefix looks
vague because it doesn't differentiate it from just "frf" field. I'd
suggest to use the "enh_frf" name instead.

> +	} else if (dw_spi_ver_is_ge(dws, PSSI, 400A)) {

> +		cr0 &= ~DW_PSSI_CTRLR0_SPI_FRF_MASK;
> +		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
> +				  cfg->spi_frf);

The same comments as above.

> +	}
> +
>  	dw_writel(dws, DW_SPI_CTRLR0, cr0);
>  
>  	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
> @@ -422,6 +432,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
                                                 <--------+
>  		.tmode = DW_SPI_CTRLR0_TMOD_TR,           |
>  		.dfs = transfer->bits_per_word,           |
>  		.freq = transfer->speed_hz,               |
                                                          |
> +		.spi_frf = DW_SPI_CTRLR0_SPI_FRF_STD_SPI, +

You also forgot to update the spi-dw-bt1.c driver.

>  	};
>  	int ret;
>  
> @@ -664,7 +675,7 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
>  static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);

> -	struct dw_spi_cfg cfg;
> +	struct dw_spi_cfg cfg = {0};

Please explicitly initialize the enh_frf field in the method below in
the same way as it's done for the rest of the fields.

>  	unsigned long flags;
>  	int ret;
>  
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 9e8eb2b52d5c7..414a415deb42a 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -17,6 +17,8 @@
>  
>  /* Synopsys DW SSI component versions (FourCC sequence) */
                                                  <-+
>  #define DW_HSSI_102A			0x3130322a  |
> +#define DW_HSSI_103A			0x3130332a  |
                                                    |
> +#define DW_PSSI_400A			0x3430302a -+

Please define the PSSI-macros above the HSSI ones.

>  
>  /* DW SSI IP-core ID and version check helpers */
>  #define dw_spi_ip_is(_dws, _ip) \
> @@ -94,6 +96,9 @@
>  #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
>  #define DW_HSSI_CTRLR0_SRL			BIT(13)
                                                       <---------+
>  #define DW_HSSI_CTRLR0_MST			BIT(31)          |
                                                                 |
> +#define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22) -+

This macro should be placed above the DW_HSSI_CTRLR0_MST one. Also
rename SPI_FRF to ENH_FRF.

> +#define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
> +#define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0

1. Move these macros to the DW APB SSI group of the CSR fields macros.
2. Drop the SPI suffix from the DW_SPI_CTRLR0_SPI_FRF_STD_SPI macro.
3. Replace SPI_FRF with ENH_FRF name.

>  
>  /* Bit fields in CTRLR1 */
>  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
> @@ -135,6 +140,7 @@ struct dw_spi_cfg {
>  	u8 dfs;
>  	u32 ndf;
>  	u32 freq;

> +	u8 spi_frf;

Please move it to the head of the structure and rename to "enh_frf".

-Serge(y)

>  };
>  
>  struct dw_spi;
> -- 
> 2.30.2
> 
