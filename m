Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2162A67F970
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjA1QI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjA1QIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:08:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF982ED76;
        Sat, 28 Jan 2023 08:08:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED5DB60C0D;
        Sat, 28 Jan 2023 16:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E6C433D2;
        Sat, 28 Jan 2023 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674922103;
        bh=3SIU5LamQSuLAW7qaqOZ1h2Kp6PiCS4jBVA3gKuwDCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ax937NgKUPNJ36rqxjvORgEndDnVBv+Hmza22DDTjaew9naJoUFomXLHJIe74fPeb
         Y3goHct2Q19b+LRrVqWWSJ2tok1gCqvTd0BvZMZnSNA6V5fDLgZQe3fVy9QwKzt36z
         A5T7oJEKCxLzVL1UtGhIgC0Mey9qJqvQ1YTeM+AgFk2hLUIOt8Rr93vpjQ6K4GcPPN
         0QFBt7nptaFSaq9YqbhMkT6/SWjcWqO9gPRJ7DuyJzSnVeS9+PStlnfzqXnUJt4N/q
         viWhfHkBw/s9QJAL7Z6GU3at+yeVLaABpJyzjCmekujefmDXC4t5NnYTO9e/ZIwXCc
         FQnIUUAWkaHZQ==
Date:   Sat, 28 Jan 2023 16:22:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: imx93: Fix spelling mistake "geting" ->
 "getting"
Message-ID: <20230128162215.41bb70cb@jic23-huawei>
In-Reply-To: <20230124100413.684416-1-colin.i.king@gmail.com>
References: <20230124100413.684416-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 10:04:13 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> Thrre is a spelling mistake in a dev_err_probe message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx93_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index d8de8284e13d..a775d2e40567 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -315,7 +315,7 @@ static int imx93_adc_probe(struct platform_device *pdev)
>  	adc->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(adc->regs))
>  		return dev_err_probe(dev, PTR_ERR(adc->regs),
> -				     "Failed geting ioremap resource\n");
> +				     "Failed getting ioremap resource\n");
>  
>  	/* The third irq is for ADC conversion usage */
>  	adc->irq = platform_get_irq(pdev, 2);

