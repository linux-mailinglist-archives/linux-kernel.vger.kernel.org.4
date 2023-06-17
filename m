Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950797342C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjFQRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFQRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB5CCF;
        Sat, 17 Jun 2023 10:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 378126116C;
        Sat, 17 Jun 2023 17:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D29C433C0;
        Sat, 17 Jun 2023 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687023952;
        bh=NvqkckyTq/+5qM6veCJTPQdMzU7jUyjKPhKFnUIEIuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i2qDGBUKf8A/EYY6YGYC5Qnu61Siu35yExeXgyX07skOaJPbYoSXL+bjLLduQ4rJC
         fVsrnqlJSJvLmqNJiTt7Tp0pRxXGBGnFzvXV0VSyBTKPxu80jEyyxBoOgGBKAd7ytB
         i/D1ofMUxDgrW4G8dkECUWXAeXR0qQmqHj8k6bzkn3XUswtfgvZaE2C1MLFuVNT6QD
         PS/Glh/AYfn9z9q6qzXP5bQap049WvAOfZsdOvgDUJz03SjLEiD9I5tLrHzxHFAp/y
         O1754VfsU5GyIk8NyGpb4hYASZBOIVYj/HhFfe+u9dtwEIepVh9jqmvV0dxxBjbccn
         XaOj+3nmBFh1Q==
Date:   Sat, 17 Jun 2023 18:45:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 08/13] iio: inkern: Use max_array() to get the
 maximum value from an array
Message-ID: <20230617184542.36865dc2@jic23-huawei>
In-Reply-To: <20230615152631.224529-9-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-9-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 17:26:26 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Use max_array() to get the maximum value from an array instead of a
> custom local loop.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/inkern.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 71d0424383b6..8bfd91f74101 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/minmax.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> @@ -875,11 +876,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
>  			return -EINVAL;
>  		switch (*type) {
>  		case IIO_VAL_INT:
> -			*val = vals[--length];
> -			while (length) {
> -				if (vals[--length] > *val)
> -					*val = vals[length];
> -			}
> +			*val = max_array(vals, length);
>  			break;
>  		default:
>  			/* FIXME: learn about max for other iio values */

