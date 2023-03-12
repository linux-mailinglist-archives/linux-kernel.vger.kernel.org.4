Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5526B6BBD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCLVQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjCLVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:16:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F72A158;
        Sun, 12 Mar 2023 14:16:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b10so10724009ljr.0;
        Sun, 12 Mar 2023 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvfL5LA+JxDsCD8VVb6BVbqdfgMrfiE/5AuTtyrJsUg=;
        b=XOe05FDdER8j6fWyWmjhrccSgTXO2w6gqsqtvL6yZk5yIsbqPHFOU+dfDMo0p41Qrd
         z2hD7v5+OdaUrKzomdbcUtrpc4SLialkEywWzGHRwTn/7otDB1Qs9Es56A3ARDIAaAZx
         +Z7lVpi2WR2hfR4w3tHC6lVvLhOoFlt1Mqt0kAHjn247/8OdkMNNosQqYmkGEcpzha80
         QeejozUnbl9BDDqZJ9zKrYVbyGATQL2ahyeyjwb4TCYAI0sIQC/lfT2pzW+DMlyac1BB
         fygT9BTgEfmWkzOn69H/Gi1LGO7h8ZHu3SZHD4vv7bmUvxUpaQP9yPuMV1hLYnLxzuE+
         JzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvfL5LA+JxDsCD8VVb6BVbqdfgMrfiE/5AuTtyrJsUg=;
        b=u8lp5q7D/yzl6C7IXDBws2W9YtbtS5nJxWmxkqh6DiyO1Ts5+SgsAXn8SO4LrqIT9L
         MCw0SPDeGSRRCg/ppLfNncc1sl8Yu5dxmFuqzMhES5YWxljY+568FYu3h/5s2NbibKfx
         T6H6m4l3DPS40rHal+AH0hYpe5ivTpQxblL2F79rmo8FXpNNO2uZ2ZNsV3BhU3ZZfFue
         BsLER24vXL6IdYtaTTW8TS59KrXrZNEdaXBM5y2AImEHO1ml5aWWPMX39Rbc7vw6C/qa
         CEHt2vodDC5FlpVv+KhLCR/BMnLXjZ8xMxXLw+EKK8zDfDb5x3W/7W6jSQBG+PxFM6Yd
         HOXg==
X-Gm-Message-State: AO0yUKXO2qauofqVxzIdUxP6Jj7oraJv2LaCRm52oirvnENewtVOR1Q3
        DhNfsAD9ZTRl/pZGTsm0QMU=
X-Google-Smtp-Source: AK7set8AZ5yW15J55R3C8ci16efEg+FH7c7955xy/u7fX2ifb9NPdfEbIxmxsmL4MbVMXpB0gNZpFw==
X-Received: by 2002:a2e:a984:0:b0:295:a5a6:ee4d with SMTP id x4-20020a2ea984000000b00295a5a6ee4dmr14600642ljq.8.1678655789714;
        Sun, 12 Mar 2023 14:16:29 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a20-20020a05651c031400b00295a96a0f6csm746936ljp.102.2023.03.12.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:16:28 -0700 (PDT)
Date:   Mon, 13 Mar 2023 00:16:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Message-ID: <20230312211626.pxhkypodrdwnbozr@mobilestation>
References: <20230312004445.15913-1-blarson@amd.com>
 <20230312004445.15913-11-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312004445.15913-11-blarson@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 04:44:40PM -0800, Brad Larson wrote:
> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.  The Elba DW_SPI instance has two native
> CS signals that are always overridden.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v11 changes:
> - Simplify dw_spi_elb_init by using syscon_regmap_lookup_by_phandle()
> 
> v10 changes:
> - Delete struct dw_spi_elba, use regmap directly in priv
> 
> v9 changes:
> - Add use of macros GENMASK() and BIT()
> - Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()
> 
> ---
>  drivers/spi/spi-dw-mmio.c | 57 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 26c40ea6dd12..5851ecc6e1e9 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -53,6 +53,20 @@ struct dw_spi_mscc {
>  	void __iomem        *spi_mst; /* Not sparx5 */
>  };
>  
> +/*
> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> + * gpios for cs 2,3 as defined in the device tree.
> + *
> + * cs:  |       1               0
> + * bit: |---3-------2-------1-------0
> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> + */
> +#define ELBA_SPICS_REG			0x2468
> +#define ELBA_SPICS_OFFSET(cs)		((cs) << 1)
> +#define ELBA_SPICS_MASK(cs)		(GENMASK(1, 0) << ELBA_SPICS_OFFSET(cs))
> +#define ELBA_SPICS_SET(cs, val)		\
> +		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
> +
>  /*
>   * The Designware SPI controller (referred to as master in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
> @@ -237,6 +251,48 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void dw_spi_elba_override_cs(struct regmap *syscon, int cs, int enable)
> +{
> +	regmap_update_bits(syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
> +			   ELBA_SPICS_SET(cs, enable));
> +}
> +
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> +	struct regmap *syscon = dwsmmio->priv;
> +	u8 cs;
> +
> +	cs = spi->chip_select;
> +	if (cs < 2)
> +		dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
> +
> +	/*
> +	 * The DW SPI controller needs a native CS bit selected to start
> +	 * the serial engine.
> +	 */
> +	spi->chip_select = 0;
> +	dw_spi_set_cs(spi, enable);
> +	spi->chip_select = cs;
> +}
> +
> +static int dw_spi_elba_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	struct regmap *syscon;
> +
> +	syscon = syscon_regmap_lookup_by_phandle(dev_of_node(&pdev->dev),
> +						 "amd,pensando-elba-syscon");
> +	if (IS_ERR(syscon))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
> +				     "syscon regmap lookup failed\n");
                                              <----+
> +	dwsmmio->priv = syscon;                    |
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;  |
             +-------------------------------------+
             |
Newline here + would be nice. Other than that looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -352,6 +408,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> +	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.17.1
> 
