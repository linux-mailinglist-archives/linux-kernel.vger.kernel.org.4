Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D086C9DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjC0Ibw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjC0IbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:31:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0146B4;
        Mon, 27 Mar 2023 01:28:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32R8Qt39030043;
        Mon, 27 Mar 2023 03:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679905615;
        bh=8yfDEjBLPfAKUoGrvIcicI0FVRLc+jf9sHpjdvWg9i4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fYkaOBEOkCvAz2Xq1PguQFX75riaFCEyjwDBZaPiH4O2zmdm4FJiAI6Ncv7NclUdl
         Rjkz41cKTvPNRkq2iNB1Slp6VLfJ/eto527a2gV9Afv6W95OuOnF0CN0jOpvvMx+5Y
         5nZp/eKl+v5mZ8fH878elwhjGPD2cPHKiVjgD/YU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32R8QtnD014041
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 03:26:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 03:26:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 03:26:55 -0500
Received: from [10.249.132.105] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32R8QqnU024899;
        Mon, 27 Mar 2023 03:26:53 -0500
Message-ID: <12626f35-6b7c-bb24-606a-00d0b8e7f375@ti.com>
Date:   Mon, 27 Mar 2023 13:56:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next 1/3] spi: omap2-mcspi: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/23 11:23, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
For the series,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  drivers/spi/spi-omap2-mcspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index d95f0ae033ca..8331e247bf5c 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1477,8 +1477,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  		master->max_transfer_size = omap2_mcspi_max_xfer_size;
>  	}
>  
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
> +	mcspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
>  	if (IS_ERR(mcspi->base)) {
>  		status = PTR_ERR(mcspi->base);
>  		goto free_master;

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

