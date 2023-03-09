Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953426B23CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCIMO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCIMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:14:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40693E9CEB;
        Thu,  9 Mar 2023 04:14:19 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id i20so1572484lja.11;
        Thu, 09 Mar 2023 04:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678364057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRXggi04xWYcHaVC0FAY4i7eTSbEWaqGbUlV8GQrxI4=;
        b=bxBUebwN1xXJ09HJTDv0z93xzMLucpoMFhXNI+YUQIVAP2r7PEpV1Xf5xzZLwmKQgB
         d0XUPU7ok6Kokt5OEFLypMLwC0/aU7RIYfZ+Gux/weU9N9swKdkkUeC6IQgIXeGBsaSQ
         vlt+QYyWhSPDp4E4O6odvBZ3BZ4AooMhCVA5LUn89zi3LhISB50/wQKHD95VVcn1C3vi
         zriqcDD7xWeXQpb/UYVkj1RvsfGW/GFO9e3izMihHvE5m8u7Sze31uNwUqKb31xCxu2l
         B6If0L18dmMroxcDmaANwfYijq9e8OgwTodXbsZ6THXf4ub8K3mL16pOqI50WdSxSmTV
         0ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678364057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRXggi04xWYcHaVC0FAY4i7eTSbEWaqGbUlV8GQrxI4=;
        b=MUrLH+EuI/LEWhY2xqB+3tZVVPTzBlfvO2I3PH1PcEbXEQJVYl+tq6FqhUtB/9+xxN
         xF4Da8iTCej1tv8t8bfCzHDmv3X/E0z2ayGo4pKt/ju0eoT0mLooSIp6EMtbNk01Si2K
         CZNb9/09O+NvG0nONjSnVea5zQfbFlbVSNWRQDiTfAty56MtJmDQBmgya8G5Xw9dyXWx
         lbGPJIHF6uBTjl7Ov/j0Gju0ttyfNRdqEzFX5OGo18XceFLQUkvFKHmcMMxepBr8xPBB
         zo0RtB8Lb1n3uwdIqBNFv9aCNc2e1XsBnsAvDn+TK76ULEdV4E8IMf2GzOUFkILDGIZP
         DGFg==
X-Gm-Message-State: AO0yUKWiBtflbNNE/s5zdlY8VYJnRK04ccYSQK+4yg6BUviCgxKf6wBg
        uzwwf0Vmh+KiEBMPo236+6c=
X-Google-Smtp-Source: AK7set+Wn2YaPYZxCfuLq20impmYZwOoNM9/3S/XAhSmjPQfeIyuFw/PnT2wNQerWfyd7hGv/3meMw==
X-Received: by 2002:a05:651c:105c:b0:295:a3a0:ea95 with SMTP id x28-20020a05651c105c00b00295a3a0ea95mr5812836ljm.42.1678364057335;
        Thu, 09 Mar 2023 04:14:17 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id z4-20020a2eb524000000b002934e1407desm2940222ljm.43.2023.03.09.04.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:14:16 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:14:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <blarson@amd.com>
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, davidgow@google.com,
        devicetree@vger.kernel.org, gerg@linux-m68k.org, gsomlo@gmail.com,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, lee@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        p.yadav@ti.com, p.zabel@pengutronix.de, piotrs@cadence.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v10 10/15] spi: dw: Add support for AMD Pensando Elba SoC
Message-ID: <20230309121414.6ay47dn57f2p26nh@mobilestation>
References: <20230306160017.ptd3ogundxvus5zm@mobilestation>
 <20230307022002.28874-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307022002.28874-1-blarson@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 06:20:02PM -0800, Brad Larson wrote:
> On Mon, Mar 06, 2023 at 16:00, Serge Semin wrote:
> > On Sun, Mar 05, 2023 at 08:07:34PM -0800, Brad Larson wrote:
> >> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> >> with device specific chip-select control.  The Elba SoC
> >> provides four chip-selects where the native DW IP supports
> >> two chip-selects.  The Elba DW_SPI instance has two native
> >> CS signals that are always overridden.
> >> 
> >> Signed-off-by: Brad Larson <blarson@amd.com>
> >> ---
> >> 
> >> v10 changes:
> >> - Delete struct dw_spi_elba, use regmap directly in priv
> >> 
> >> v9 changes:
> >> - Add use of macros GENMASK() and BIT()
> >> - Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()
> >> 
> >> ---
> >>  drivers/spi/spi-dw-mmio.c | 65 +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 65 insertions(+)
> >> 
> >> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> >> index 26c40ea6dd12..2076cb83a11b 100644
> >> --- a/drivers/spi/spi-dw-mmio.c
> >> +++ b/drivers/spi/spi-dw-mmio.c
> >> @@ -53,6 +53,20 @@ struct dw_spi_mscc {
> >>  	void __iomem        *spi_mst; /* Not sparx5 */
> >>  };
> >>  
> >> +/*
> >> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> >> + * gpios for cs 2,3 as defined in the device tree.
> >> + *
> >> + * cs:  |       1               0
> >> + * bit: |---3-------2-------1-------0
> >> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> >> + */
> >> +#define ELBA_SPICS_REG			0x2468
> >> +#define ELBA_SPICS_OFFSET(cs)		((cs) << 1)
> >> +#define ELBA_SPICS_MASK(cs)		(GENMASK(1, 0) << ELBA_SPICS_OFFSET(cs))
> >> +#define ELBA_SPICS_SET(cs, val)		\
> >> +		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
> >> +
> >>  /*
> >>   * The Designware SPI controller (referred to as master in the documentation)
> >>   * automatically deasserts chip select when the tx fifo is empty. The chip
> >> @@ -237,6 +251,56 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
> >>  	return 0;
> >>  }
> >>  
> >> +static void dw_spi_elba_override_cs(struct regmap *syscon, int cs, int enable)
> >> +{
> >> +	regmap_update_bits(syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
> >> +			   ELBA_SPICS_SET(cs, enable));
> >> +}
> >> +
> >> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> >> +{
> >> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> >> +	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> >> +	struct regmap *syscon = dwsmmio->priv;
> >> +	u8 cs;
> >> +
> >> +	cs = spi->chip_select;
> >> +	if (cs < 2)
> >> +		dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
> >> +
> >> +	/*
> >> +	 * The DW SPI controller needs a native CS bit selected to start
> >> +	 * the serial engine.
> >> +	 */
> >> +	spi->chip_select = 0;
> >> +	dw_spi_set_cs(spi, enable);
> >> +	spi->chip_select = cs;
> >> +}
> >> +
> >> +static int dw_spi_elba_init(struct platform_device *pdev,
> >> +			    struct dw_spi_mmio *dwsmmio)
> >> +{
> >> +	const char *syscon_name = "amd,pensando-elba-syscon";
> >
> >> +	struct device_node *np = pdev->dev.of_node;
> >
> > Drop this since it's used only once below. 
> >
> 
> Removed
> 
> >> +	struct device_node *node;                                         
> 
> Renamed *node to *np
> 
> >> +	struct regmap *syscon;                                            
> >> +                                                                       
> >> -	node = of_parse_phandle(np, syscon_name, 0);                      
> >
> >	node = of_parse_phandle(dev_of_node(pdev->dev), syscon_name, 0);
> >
> > +	if (!node)
> >
> >> +		return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
> >> +				     syscon_name);
> >
> > Hm, using dev_err_probe() with known error value seems overkill.
> 
> Changed to: return -ENODEV
> 
> >> +
> >
> >> +	syscon = syscon_node_to_regmap(node);
> >> +	if (IS_ERR(syscon))
> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
> >> +				     "syscon regmap lookup failed\n");
> >
> > of_node_put() is missing in the error and success paths.
> 
> Result of the above changes are:
> 
> +       const char *syscon_name = "amd,pensando-elba-syscon";
> +       struct device_node *np;
> +       struct regmap *syscon;
> +

> +       np = of_parse_phandle(pdev->dev.of_node, syscon_name, 0);
> +       if (!np)
> +               return -ENODEV;
> +
> +       syscon = syscon_node_to_regmap(np);
> +       of_node_put(np);
> +       if (IS_ERR(syscon))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
> +                                    "syscon regmap lookup failed\n");

As Andy correctly noted this can be fully converted to just a single call:
syscon_regmap_lookup_by_phandle().

and replace pdev->dev.of_node with dev_of_node(pdev->dev).

-Serge(y)

> 
> Regards,
> Brad
