Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09956AC618
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCFQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCFQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077925E09;
        Mon,  6 Mar 2023 08:00:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id i28so13483874lfv.0;
        Mon, 06 Mar 2023 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678118421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpbO5ncGnDzpZr6YC052o6uN32ao407Zw1CpSvpKERU=;
        b=F30/sL+RqJKTB+NaaNd06xAIo+sfskWfMomf4CK+edpMovUhLDm9saSLVISHpaND5Z
         ww4AtebTagU+wP79yKTHM6SDVSxEoKJoT5cRMYyCjlRE7w6cYF+gH1KC4nLQui4xZZlG
         s0sKxaoTXoYGp8wqDQaayeaUYuzf6JYhr8LZL43B9ElPtWMn8xKR2YPJDBO3zbNavFx2
         eIiH3ZNd7dQKBaeluh1xp1vpkTLoT2AX0y2CFfA3IfLO7QpxrrfeKU29G8n5Z7kFS4lp
         +49MLbar1Ma/0inQO8f578TyZ68ziDRxMJd8JSMQxuCo0I318Yb0OWbpE9K9ly7ANMA6
         3h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpbO5ncGnDzpZr6YC052o6uN32ao407Zw1CpSvpKERU=;
        b=LA6N+78uzrrxPc4wt3wblTB6SPa1K5bpcJInhD3SV0phyPpYC+8fz2mIt/zSegQm/H
         CnjK4k3Z0TLWeJTFIs5fwsmQgCKUoensg88lrDw/73pHi5y4n1Ljbv1iTJvEtmDyPqaz
         ueTro2i5JayHSUqddlVnIMwdR+vyr2rUwvJKFsILK0rzUA6rIJhEaOQu6sXOuZlK7Lgs
         Mch5qsH4qbX7/5U5/AdzlqJ09zE/VJFmmZsbv6sCxo8rr05tlIlLfWLmD+l0756ozZ5z
         kanJS9Ar7bnFhaDEuKEAbW81AoaritTa1bEhIdEUFRctccppJOtAJ23MMow7ay5/oNZH
         UmVg==
X-Gm-Message-State: AO0yUKUVp02TkFgr64ik0cI6IBtGTzL/atGnouJjK49OrkyXZREE767d
        Q0gelt+OIzhWKUJs5kvZihE=
X-Google-Smtp-Source: AK7set+1yYqL+fKPD8QU3g1uNsKWPgVaZhQ8+wRLThgWDAfaf3a8UpA8DcyN0jfp6kMd2J2kjjbWeg==
X-Received: by 2002:ac2:53a2:0:b0:4b5:7096:23ff with SMTP id j2-20020ac253a2000000b004b5709623ffmr2895396lfh.66.1678118420857;
        Mon, 06 Mar 2023 08:00:20 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w13-20020a19c50d000000b004e8017a2510sm890868lfe.183.2023.03.06.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:00:20 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:00:17 +0300
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
Subject: Re: [PATCH v10 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Message-ID: <20230306160017.ptd3ogundxvus5zm@mobilestation>
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-11-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306040739.51488-11-blarson@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 08:07:34PM -0800, Brad Larson wrote:
> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.  The Elba DW_SPI instance has two native
> CS signals that are always overridden.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v10 changes:
> - Delete struct dw_spi_elba, use regmap directly in priv
> 
> v9 changes:
> - Add use of macros GENMASK() and BIT()
> - Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()
> 
> ---
>  drivers/spi/spi-dw-mmio.c | 65 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 26c40ea6dd12..2076cb83a11b 100644
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
> @@ -237,6 +251,56 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
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
> +	const char *syscon_name = "amd,pensando-elba-syscon";

> +	struct device_node *np = pdev->dev.of_node;

Drop this since it's used only once below. 
                                                                          
> +	struct device_node *node;                                         
> +	struct regmap *syscon;                                            
> +                                                                       
> -	node = of_parse_phandle(np, syscon_name, 0);                      

	node = of_parse_phandle(dev_of_node(pdev->dev), syscon_name, 0);

> +	if (!node)

> +		return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
> +				     syscon_name);

Hm, using dev_err_probe() with known error value seems overkill.

> +

> +	syscon = syscon_node_to_regmap(node);
> +	if (IS_ERR(syscon))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
> +				     "syscon regmap lookup failed\n");

of_node_put() is missing in the error and success paths.

-Serge(y)

> +
> +	dwsmmio->priv = syscon;
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -352,6 +416,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
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
