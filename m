Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7871702E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbjEONgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbjEONf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:35:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A8619A6;
        Mon, 15 May 2023 06:35:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f22908a082so11617415e87.1;
        Mon, 15 May 2023 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684157756; x=1686749756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQCCyMXdzQtQ4wEmAdLT3od28AFpa/gXxFf5yRoLH9M=;
        b=iNdOWmWupwp49Ma2zWvlKHqbkl/nMO4PlU+SbQYapxsH7oFBjl5uWYxVjXGzwAb4ZV
         9MuHWHZa6Ujnf+Mo1evVDhTJ17AUYTaEAOPOIkrMmAw4IeNPdqeNYl45F792/QlYcwvW
         v6NpG9PO/MuzrPYAXusQ1JS5empHkBCDsv2lL30m2hb1j69D7/a+b/0KEQFREv2Q1Php
         3q6mmRoeBqpNPfriPA2pT1//X8cuAYOE4UqT+H9wI5o+zxiOij0KR/xRsGmHQhkmM0fM
         8IwUPCG8z2cDr5U/uO1OlzzJPo0VvwnMUO4UiPG9lr1lMnPCysuSuv979Gb80pv4GIrC
         fp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157756; x=1686749756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQCCyMXdzQtQ4wEmAdLT3od28AFpa/gXxFf5yRoLH9M=;
        b=L/w7BSq8KxQCjflFJYBxKRecKSkLsLLBcCXx7A80jHELW5xxxRzAKOdF51TJU/ZTCB
         RVPZnx3aKzB1NcNe+fWuv6BLuI6zvkH3nvcIcV3tpEGNUIh4coOTP1SHpu/YKW68lnFZ
         L7sgrln1oZGWxWMWq+sptPDur81mPJYTvaKrZp0uTyg/3neHK/bfk0anqoHFeemrWQW+
         tbL+OTPqf9STbatQ+FMWukOQCMaRiyzxgikHRBdLmosuSnl4Eyp7TTDfeaZMQeW3zdaK
         D/vayYjo8ym0HYWb+aZ+DeWlzKH+Jqk5o1oTy0TJ+02xLmX6AuZyWcDEq3n4qt1BXu0+
         nHXg==
X-Gm-Message-State: AC+VfDyWgYeb84VMB4PrF7SgRD1xzmr8Gk/wZYVSKj2uAukJl1TJPzls
        x7xtRS2AUlbmNhzfI+b0nYE=
X-Google-Smtp-Source: ACHHUZ6nWiNoW9czsM9ur3iCv+EYo4rPnggXC33kVq4oFCIvd7N/3JsstGkMYTQDZXOWwR0LFtW3wQ==
X-Received: by 2002:ac2:5399:0:b0:4f3:7c24:1029 with SMTP id g25-20020ac25399000000b004f37c241029mr1844212lfh.60.1684157756212;
        Mon, 15 May 2023 06:35:56 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o24-20020ac24358000000b004eefdd8b37fsm2615699lfl.194.2023.05.15.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:35:55 -0700 (PDT)
Date:   Mon, 15 May 2023 16:35:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     broonie@kernel.org, blarson@amd.com, git@amd.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
Subject: Re: [PATCH] spi: dw: Replace spi->chip_select references with
 function calls
Message-ID: <20230515133553.46mownenmclcauec@mobilestation>
References: <20230515130343.63770-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515130343.63770-1-amit.kumar-mahapatra@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 06:33:43PM +0530, Amit Kumar Mahapatra wrote:
> New set/get APIs for accessing spi->chip_select were introduced by
> 'commit 9e264f3f85a5 ("spi: Replace all spi->chip_select and spi->cs_gpiod
> references with function call")', but the 'commit 2c8606040a80 ("spi: dw:
> Add support for AMD Pensando Elba SoC")' uses the old interface by directly
> accessing spi->chip_select. So, replace all spi->chip_select references
> in the driver with new get/set APIs.

Indeed. I've absolutely missed that part. Thanks for the patch.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> BRANCH: for-next
> ---
>  drivers/spi/spi-dw-mmio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 5e6faa98aa85..5f2aee69c1c1 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -264,17 +264,17 @@ static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
>  	struct regmap *syscon = dwsmmio->priv;
>  	u8 cs;
>  
> -	cs = spi->chip_select;
> +	cs = spi_get_chipselect(spi, 0);
>  	if (cs < 2)
> -		dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
> +		dw_spi_elba_override_cs(syscon, spi_get_chipselect(spi, 0), enable);
>  
>  	/*
>  	 * The DW SPI controller needs a native CS bit selected to start
>  	 * the serial engine.
>  	 */
> -	spi->chip_select = 0;
> +	spi_set_chipselect(spi, 0, 0);
>  	dw_spi_set_cs(spi, enable);
> -	spi->chip_select = cs;
> +	spi_get_chipselect(spi, cs);
>  }
>  
>  static int dw_spi_elba_init(struct platform_device *pdev,
> -- 
> 2.17.1
> 
