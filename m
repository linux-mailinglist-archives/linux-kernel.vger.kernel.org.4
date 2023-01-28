Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A067FA21
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjA1R4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjA1R4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AED28869;
        Sat, 28 Jan 2023 09:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62FF160ADB;
        Sat, 28 Jan 2023 17:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39935C433EF;
        Sat, 28 Jan 2023 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674928577;
        bh=5ByUKK7E6XLgrRaxzWVpEc5sdKEonH+MAYYKoZGUUWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nPyEbKr7SQMOn3VVJyUuSkZGzdBdlpayDqROXhtjqbnUciD5568NHGkCAsbhef5km
         h4xrq2XwchsfaCZUI/MFS1jANohbWbDzmZzxu0u3ffjaPiNInplyd2oX53td+vKhSE
         ubR/SzJAY4fFCXkBY6dTVDQ8ziz15BWQUEfDmTjokQ5A3Efi/7dsiQEW/pevxtrh0F
         00WTzqnoxuw2Z2n40IfulHtTX3xIZAz7EruosPhyjHc++rMBsNVIjdCXGaqWCmi04w
         4rbvJb+qb83T0LzwbbNwZkFcX9iTN2cDouqGV1BkmXeEMo0eqao8xh81ICk9HiBTJo
         7eAIyQ5ziefAw==
Date:   Sat, 28 Jan 2023 18:10:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, broonie@kernel.org,
        lgirdwood@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix indentation error by adding extra spaces
Message-ID: <20230128181010.0f22fc15@jic23-huawei>
In-Reply-To: <Y9Vf4Tp8JKvy+y0u@yoga>
References: <Y9Vf4Tp8JKvy+y0u@yoga>
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

On Sat, 28 Jan 2023 23:18:17 +0530
Anup Sharma <anupnewsmail@gmail.com> wrote:

Tweaked patch name to be more specific.  There are a lot of ADC
drivers.
iio: adc: ad7291: Fix...

> Added extra spaces before statements to fix
> following indentation warnings reported by checkpatch.pl.
> 
> WARNING: Statements should start on a tabstop
> +           return 0;
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Huh. This one has been there over 9 years without anyone noticing.
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7291.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index e9129dac762f..fa5807ebe6d2 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -179,7 +179,7 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
>  		offset = AD7291_VOLTAGE_OFFSET;
>  		break;
>  	default:
> -	    return 0;
> +		return 0;
>  	}
>  
>  	switch (info) {

