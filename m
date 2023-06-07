Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9B725D09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbjFGL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjFGL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:27:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118810DE;
        Wed,  7 Jun 2023 04:27:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso4559133e87.2;
        Wed, 07 Jun 2023 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686137234; x=1688729234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ICfspkyZWca0LZOq13OEa6zDvWLKaRi+WMrSLj/rPo=;
        b=cccw+AWaGKsfh212sQorJjqLKwGtlvEV9mfHKZysy3qLQaiVWk+FOxfr9gNviBAtsx
         COYKsasVa1cVDvXtd2Z1jeRv9kDW+lNcPUUlVjgIpo4ZNvKcctIqGodSjE5+WH07kG6l
         e9mpkEm5oM8e8/Tu4QTcrgb6J05+y+wZ/ut78AVdeZoB5KVxo4a2XclQTPV5qsHigT7C
         Q14VIh64SmpInk3EEujuvCPP0AhEdpwJ+9NUjrx0UMP50zuvSfFfzOK93tyR//nl7K0b
         MR8/1XMoH1p7E2POSXd7eTq25Y2brN+bT9wxkm16xPEV4RU/c6hD50yotCo6td1m5Lyp
         4Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137234; x=1688729234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ICfspkyZWca0LZOq13OEa6zDvWLKaRi+WMrSLj/rPo=;
        b=QV2r1I4k+h5slczfefQ1xOOTbKbImfLVQdlO+rQZRnk2JrUrh/gfxCHeqbGM6+fHM4
         7ITcCO76dJRS/9IVw3NrSvtxyq9VwmD4EqVrUDGMuJVmQXFSWVIGVCCZbtzSsyCCwHCf
         SuPwB8oxxtPzKlOnmI31ZIqaaCxIjmOsHBClewCWu7/2rS56L6YlXbF0G2vaGYmvb2vC
         FRL+Ggojcp4Qm6p6xA/q05mqUawC4874ayo3Mx3Q8M4elE2DViGffRhqrb2xiZ7N+NA8
         NpUaynsuXzFncCiM3gJWydeav9P99KKaqhDbAL1MBohMQwQzmJyK8mm9o6LR9t7jJiYg
         IYIA==
X-Gm-Message-State: AC+VfDypGhiu2QEIf/H0qzg5XnhW4TGJLPxwjXPTUrxIP3l/u32h1Rrc
        ++XidxeP8chvSNpPCQc2ZPQ=
X-Google-Smtp-Source: ACHHUZ6jOqRNo0AYZRsY7E1fWfS6v5cTd/z3jkBALVmJK38yvVi+H/CSXrSDnLyr7MFUXH3Pb1nzBg==
X-Received: by 2002:ac2:491e:0:b0:4f6:25cb:5910 with SMTP id n30-20020ac2491e000000b004f625cb5910mr1763787lfi.42.1686137234045;
        Wed, 07 Jun 2023 04:27:14 -0700 (PDT)
Received: from mobilestation ([91.144.185.176])
        by smtp.gmail.com with ESMTPSA id u14-20020ac248ae000000b004f3bb9f1068sm1772729lfg.225.2023.06.07.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:27:13 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:27:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Abe Kohandel <abe.kohandel@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Message-ID: <20230607112711.alcspwuwpt7nqja7@mobilestation>
References: <20230606231844.726272-1-abe.kohandel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606231844.726272-1-abe.kohandel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:18:44PM -0700, Abe Kohandel wrote:
> Remove a misleading comment about the DMA operations of the Intel Mount
> Evans SoC's SPI Controller as requested by Serge.
> 

> Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> Link: https://lore.kernel.org/linux-spi/20230606191333.247ucbf7h3tlooxf@mobilestation/
> Fixes: 0760d5d0e9f0 ("spi: dw: Add compatible for Intel Mount Evans SoC")

Note Fixes tag normally goes first. In this case it seems redundant
though.

> ---
>  drivers/spi/spi-dw-mmio.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index c1d16157de61..a699ce496cc5 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -237,14 +237,7 @@ static int dw_spi_intel_init(struct platform_device *pdev,
>  }
>  
>  /*

> - * The Intel Mount Evans SoC's Integrated Management Complex uses the
> - * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> - * provide a mechanism to override the native chip select signal.

I had nothing against this part of the comment but only about the
second chunk of the text.

> - *
> - * This driver doesn't use DMA for memory operations when a chip select
> - * override is not provided due to the native chip select timing behavior.
> - * As a result no DMA configuration is done for the controller and this
> - * configuration is not tested.

> + * DMA-based mem ops are not configured for this device and are not tested.

* Note mem-ops is just a feature of the DW APB/AHB SSI controllers
* which provides a way to perform write-then-read and write-only
* transfers (see Transmit only and EEPROM read transfer modes in the
* hw manual). It works irrespective of whether your controller has a
* DMA-engine connected or doesn't have. Modern DW SSI controllers
* support Enhanced SPI modes with the extended SPI-bus width
* capability. But it's a whole another story and such modes aren't
* currently supported by the driver.

Just a question for the sake of the discussion history. Does your
platform have a DMA-engine synthesized to work with this DW SSI
controller? That is does your controller has the DMA Controller
Interface (handshake signals) connected to any DMA-engine on your
platform? I am asking because if there is no such DMA-engine then
the last part of your statement is just redundant since you can't test
something which isn't supported by design.

Anyway the change in this patch looks good. Thanks for submitting it.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>   */
>  static int dw_spi_mountevans_imc_init(struct platform_device *pdev,
>  				      struct dw_spi_mmio *dwsmmio)
> -- 
> 2.40.1
> 
