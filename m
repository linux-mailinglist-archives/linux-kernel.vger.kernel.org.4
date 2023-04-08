Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724466DBA09
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDHKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDHKSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE689FF37;
        Sat,  8 Apr 2023 03:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6666D60B2C;
        Sat,  8 Apr 2023 10:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5091C433EF;
        Sat,  8 Apr 2023 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680949062;
        bh=OS7M6JsgPcLSen82d+Ovfck6eKq2zAt8J1ftQXEqbWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FkGEXPTV+Rr6JPZUGqxWFt4BBeJfZjs3X1y0XKPFtqvJxhwtwi8lL4AoIs+BNfP6O
         2tqWiclqYrdZaN5y0or8mPVxoIdqRmus7zk8xchyi0mTCQCGk1rRrb8C+L6ZCvB+Qt
         ai51HNu5RTcK4xr6v/2KawCx7PkB1sMYnolnv8rM9LNLYUV97vNIGGG6OWaFbYWoJ+
         wnnWfCl3ByueNfZsA+OPNE6kOOtomRtcrMEV8wNNES4e0PjS+80MYGsRuRlFiYRnwx
         pTxicKU9FDINBQWuZykzIcPFLfzcfIlXPEEkaFdlyaPLhdtfdwf5ttv5lN1poK0hzI
         ZmxDk07C4kKtA==
Date:   Sat, 8 Apr 2023 11:32:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] doc: Make sysfs-bus-iio doc more exact
Message-ID: <20230408113258.15a39576@jic23-huawei>
In-Reply-To: <41eafb0caa510cddf650cf5ff940639a184f3005.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
        <41eafb0caa510cddf650cf5ff940639a184f3005.1677331779.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 15:56:16 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> A few IIC channel descriptions explained used units as:
IIO?
> data is in foo "that can be processed into an" [unit] value. The "can be
> processed into" is quite broad statement as it does not really explain
> what this processing means. This makes units pretty much useless.
> 
> After discussion with Jonathan, it seems the units for these channels
> should also be well-defined as for all other channels. The processing
> means the standard scale and offset application that is used throughout
> the IIO. Let's make it more obvious by stating that the units are [unit]
> after scale ane offset are applied.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Excellent. Thanks for doing this. I'll pick this patch up now.

Applied to the togreg branch of iio.git and pushed out as testing
(in this case to be mostly ignored by 0-day ;)

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6ba34c0d9789..b435c6f065ae 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1807,8 +1807,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
>  KernelVersion:	4.3
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Raw (unscaled no offset etc.) resistance reading that can be processed
> -		into an ohm value.
> +		Raw (unscaled no offset etc.) resistance reading.
> +		Units after application of scale and offset are ohms.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/heater_enable
>  KernelVersion:	4.1.0
> @@ -1894,8 +1894,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_electricalconductivity_raw
>  KernelVersion:	4.8
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Raw (unscaled no offset etc.) electric conductivity reading that
> -		can be processed to siemens per meter.
> +		Raw (unscaled no offset etc.) electric conductivity reading.
> +		Units after application of scale and offset are siemens per
> +		meter.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
>  KernelVersion:	4.10
> @@ -1952,7 +1953,7 @@ KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) phase difference reading from channel Y
> -		that can be processed to radians.
> +		Units after application of scale and offset are radians.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
>  What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input

