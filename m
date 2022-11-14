Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945E62896C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiKNTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:33:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B110EC;
        Mon, 14 Nov 2022 11:33:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50673613E9;
        Mon, 14 Nov 2022 19:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78593C433D6;
        Mon, 14 Nov 2022 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454432;
        bh=FW8Jj9JH9Jd467uFU0bxIUZ1OoAUS5aRIHrE+8N9T50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pguEXQcf+qSPwxpR1US2OXLx3DCrK5sMp3JIOng6RJ/Yfn18sOJr0982uaWfrbtpv
         aL7x9+Y+fmp4Mm1ryVPkK/LOdm7hzW7ZSAvg3sfz3GevoYis7mGLpunmryCAupr6q8
         7wz6XOWErcI/QnZhzeHpGHNvJJ41NNzvekeryODOG06SOCPDe1rZRq5SSBEcYeusXi
         2ZUfa9lNPBB85g/jRi9xQ6aPkykpScPCG+rkTR0iX7qWDYMBqPdaU+AEd/eQmXsv6s
         v+bvqi+Nw4Mng9jH8dB4vjc+sUrnRGZYZHVP5KAd+wTQIt88FoUYSEOJGpQcLDhkle
         EcA3r2nU7g43Q==
Date:   Mon, 14 Nov 2022 19:46:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ad4130: depend on GPIOLIB
Message-ID: <20221114194608.3127e7ba@jic23-huawei>
In-Reply-To: <20221114133649.1737027-1-cosmin.tanislav@analog.com>
References: <20221114133649.1737027-1-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 14 Nov 2022 15:36:49 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> Fixes undefined references to 'gpiochip_get_data' and
> 'devm_gpiochip_add_data_with_key'.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 5bdef39c5c6e ("iio: adc: ad4130: add AD4130 driver")
Applied.

Thanks for handling this so quickly.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8d719fbb6acc..63f80d747cbd 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -24,6 +24,7 @@ config AD_SIGMA_DELTA
>  config AD4130
>  	tristate "Analog Device AD4130 ADC Driver"
>  	depends on SPI
> +	depends on GPIOLIB
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	select REGMAP_SPI

