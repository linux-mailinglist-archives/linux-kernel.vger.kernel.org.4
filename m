Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7C724A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjFFR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjFFR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:28:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AFA10F7;
        Tue,  6 Jun 2023 10:28:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f6148f9679so5760832e87.3;
        Tue, 06 Jun 2023 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686072520; x=1688664520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEabg9HgVWmltF9fIzKhes2UlXbdxP/4XpV2nsMxZBc=;
        b=CGlMpx9SxVrVWxnTHIvfX7jN/3RNNOgGuwsvMIgkSusNQva8kNlgwXoKz5ez4dio6a
         nnpidwt66YuEN8H6Qe8eyjesUqg2xnYCL+58EEx0t3wqmZNqNJJFtVw2SHDOXDQRodnG
         K5HWAuTs884ANthJS9HH8X/O+7ILwEpMtV8iRptgelhXgOVx/HfoSCSpH6nylbChDtBT
         GXZ4vekxh3Ixsp9fgeTUIeCTnBnwENaQWOq5k9heJpBG/3tNCxc6wsraekRIpaGjNjhR
         J+xyaHeaoh5at74uU45m4oEX59L0RcXNT8AbQa9ZVvpCcTiV9u6lDhMv5oJS0Ut49HfX
         oTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686072520; x=1688664520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEabg9HgVWmltF9fIzKhes2UlXbdxP/4XpV2nsMxZBc=;
        b=OVYF1mLdk2BnWfL6q+HkmJKUjZ4fTVArRe+3jf8/HF5ZIzW63dZdjFcv9S94QU6rIE
         6KzQgZSWiFhkam8hf8KOUTeoKbWNm0eCy+1L4qdiguh11t4eJqEKvm9OvLwzrcjwE+g/
         KAPwyHRVv9KZiz5Bp2yJxbE3eJbweNMw7YTyZDiX7h2ZVcsp/z9JLAt99qT5/B626E/z
         phLReN5sYVY9J3HfdRI7hijTxQCD1oEqLoXP0dYDATsNfGjaQKYTrjxtBh4IgQ5kRGUL
         oSeqpNo369KpYk1ngiDp21UwFMsRUsYWJAMoOvtPVqhXwLHMetiE/hCBGR76XDT32a2I
         nB6Q==
X-Gm-Message-State: AC+VfDxKZ5uWfbb5ZuJnPx5Hwq+iEYBS91i3oOiByK7DLVRMouEu4UQY
        0lwAdGopysFyB7YyyUm2mAo=
X-Google-Smtp-Source: ACHHUZ7dQfYI9ag9V5qcsU2vP1qMV0off2/QgwkS+wWXu4V8QwTr9piaN5mnvxyOmbe3pIkug49pUg==
X-Received: by 2002:a2e:b0c6:0:b0:2ad:f8d:dea with SMTP id g6-20020a2eb0c6000000b002ad0f8d0deamr1426140ljl.11.1686072519604;
        Tue, 06 Jun 2023 10:28:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e80ca000000b002adb8c028dcsm1946380ljg.75.2023.06.06.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:28:39 -0700 (PDT)
Date:   Tue, 6 Jun 2023 20:28:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Abe Kohandel <abe.kohandel@intel.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <20230606172836.rbvhaxala2voaany@mobilestation>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <20230606145402.474866-2-abe.kohandel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145402.474866-2-abe.kohandel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abe

On Tue, Jun 06, 2023 at 07:54:01AM -0700, Abe Kohandel wrote:
> The Intel Mount Evans SoC's Integrated Management Complex uses the SPI
> controller for access to a NOR SPI FLASH. However, the SoC doesn't
> provide a mechanism to override the native chip select signal.
> 
> This driver doesn't use DMA for memory operations when a chip select
> override is not provided due to the native chip select timing behavior.
> As a result no DMA configuration is done for the controller and this
> configuration is not tested.
> 
> The controller also has an errata where a full TX FIFO can result in
> data corruption. The suggested workaround is to never completely fill
> the FIFO. The TX FIFO has a size of 32 so the fifo_len is set to 31.
> 
> Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 5f2aee69c1c1..c1d16157de61 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -236,6 +236,31 @@ static int dw_spi_intel_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +/*
> + * The Intel Mount Evans SoC's Integrated Management Complex uses the
> + * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> + * provide a mechanism to override the native chip select signal.
> + *

> + * This driver doesn't use DMA for memory operations when a chip select
> + * override is not provided due to the native chip select timing behavior.
> + * As a result no DMA configuration is done for the controller and this
> + * configuration is not tested.

Based on what is written you didn't test the DMA-based memory
operations on your hardware. Well, this driver doesn't use DMA for
memory operations on the platforms with the native CS just because
nobody has implemented that feature so far. AFAICS if DMA-based memory
operations were supported by the driver I don't think that the native
CS auto de-assertion would have been an issue except when there is no
hw-accelerated LLPs list handling in the DMA controller (in the later
case we could have fallen back to the IRQ-less implementation though).
Moreover having the DMA-based memory ops implemented would have been
even better than what the driver provides at the moment since it would
have eliminated the mem-op transfers in the atomic context. So the
comment seems misleading. Another problem is that it refers to a
feature which may be added in future. So the comment will be wrong
then. So I would suggest to either drop the comment or change to
something that just states that the DMA-based mem ops weren't tested
for this hardware.

Am I wrong in some aspects of understanding your comment? Did you mean
something else than what I inferred from it?

-Serge(y)

> + */
> +static int dw_spi_mountevans_imc_init(struct platform_device *pdev,
> +				      struct dw_spi_mmio *dwsmmio)
> +{
> +	/*
> +	 * The Intel Mount Evans SoC's Integrated Management Complex DW
> +	 * apb_ssi_v4.02a controller has an errata where a full TX FIFO can
> +	 * result in data corruption. The suggested workaround is to never
> +	 * completely fill the FIFO. The TX FIFO has a size of 32 so the
> +	 * fifo_len is set to 31.
> +	 */
> +	dwsmmio->dws.fifo_len = 31;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  				   struct dw_spi_mmio *dwsmmio)
>  {
> @@ -405,6 +430,10 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
>  	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
> +	{
> +		.compatible = "intel,mountevans-imc-ssi",
> +		.data = dw_spi_mountevans_imc_init,
> +	},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>  	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
> -- 
> 2.40.1
> 
