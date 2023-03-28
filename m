Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7506CC633
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjC1P1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjC1P0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:26:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FE10252
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:25:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so12654867wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680017116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbTGN4AmHnIHsx21UwKF1mcC0glvE7lkzW1Nfz99yWw=;
        b=MHUZOeLXGOV7LXvnYEiNrrODlRDpNM21xPxy5cKPf2PteIGaDuQKEWCwHxrWHxOGz2
         Bmb02PWAcdS1KBv2nygk5V1+U/rxsiGSN44rAxmRs9+RxGHdsqQ4P9akZHkp6fFaYO6K
         3zoZ/MYIiLRXrxp+HpgItn9LkMR8JW6RiA9wJdYtKUBib7LrxflKfkI0HZpVyDcyoGg+
         iO4zzn0bc/In/hxDslvhQGbL5FY45rGz5ttEVV5Qh2LQe2dmENUFFQdsQ6CRPfRswswH
         paVcEf0TA55Iv/VBabedNkB26OmwSUEOijustAQtvTYAYPtj9HQOecZyuvQjMZdMV7ms
         AmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbTGN4AmHnIHsx21UwKF1mcC0glvE7lkzW1Nfz99yWw=;
        b=4hqkjCv3LeOEWeZ33NdkvWhcSyzuQQYysl3yT3EsDjwLU0MllXfCO8KyXKNMw5qECX
         +6pvj25K0d/m9dUT5M19dgEftosb59YPQLxG4p7I2/DLR8dJuHSwBpf2AeXNM0DyGw6n
         13ECxDfhvWP2avM1q+lsXFbWj3BI/bdcNj3BSIsdZXuXtunD1HqD5BVzaIw9EeA2m2ko
         4VpE8XZUa63B5emj8mxt3piIFpUfXVzGLj5aqCwjLiM/NIvX9CBMH8WVwBTzCSVHTJxw
         dfsSGogh4oSRlMBa6L8mAY34G+fxx/6lGQ1yZh3mtl+iV1Us1balVi8SvCwGzxVBzQPI
         9kWA==
X-Gm-Message-State: AAQBX9cpRsPHNi/hM43teTs9ztcqztSxRzvfIbqGrZbrkZ7ZvOLaXYOi
        huCDEc8nHz06qgE30qreI9yAsg==
X-Google-Smtp-Source: AKy350YtNWIBuEbC2fJEJX4l8eZXgP1XMfWr6m4PEqfYoF7qyluW6LBaS9dnskEctqJNDZL9veDYCw==
X-Received: by 2002:a5d:6645:0:b0:2d1:481d:5863 with SMTP id f5-20020a5d6645000000b002d1481d5863mr11107093wrw.11.1680017116682;
        Tue, 28 Mar 2023 08:25:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b002c55de1c72bsm27838248wrw.62.2023.03.28.08.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:25:16 -0700 (PDT)
Message-ID: <b8a14527-b95b-3366-d2b9-f87399d49779@linaro.org>
Date:   Tue, 28 Mar 2023 16:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] spi: xilinx: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     michal.simek@xilinx.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 07:15, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/spi/spi-xilinx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 5dd3d1901412..8e6e3876aa9a 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -440,8 +440,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>  	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
>  	init_completion(&xspi->done);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	xspi->regs = devm_ioremap_resource(&pdev->dev, res);
> +	xspi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(xspi->regs))
>  		return PTR_ERR(xspi->regs);
>  

So we keep the local var res just to print its value? Wouldn't have been
better to have something like:

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 1411548f4255..693be1eacaca 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -391,7 +391,6 @@ static int xilinx_spi_probe(struct platform_device
*pdev)
 {
        struct xilinx_spi *xspi;
        struct xspi_platform_data *pdata;
-       struct resource *res;
        int ret, num_cs = 0, bits_per_word;
        struct spi_master *master;
        bool force_irq = false;
@@ -440,8 +439,7 @@ static int xilinx_spi_probe(struct platform_device
*pdev)
        xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
        init_completion(&xspi->done);

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       xspi->regs = devm_ioremap_resource(&pdev->dev, res);
+       xspi->regs = devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(xspi->regs))
                return PTR_ERR(xspi->regs);

@@ -493,7 +491,7 @@ static int xilinx_spi_probe(struct platform_device
*pdev)
                return ret;
        }

-       dev_info(&pdev->dev, "at %pR, irq=%d\n", res, xspi->irq);
+       dev_info(&pdev->dev, "irq=%d\n", xspi->irq);

        if (pdata) {
                for (i = 0; i < pdata->num_devices; i++)

---

I would get rid of printing xspi->irq too, as I don't see any benefit in
printing it, but that would be for another patch, as it is a different
logical change.
