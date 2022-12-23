Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B992655124
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiLWN72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:59:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370401D0E3;
        Fri, 23 Dec 2022 05:59:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBE71B820DE;
        Fri, 23 Dec 2022 13:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1FBC433D2;
        Fri, 23 Dec 2022 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671803963;
        bh=WPtNm1cTst+I617Sj6ukNNMQUAzdhQ/FmsPYjUxXZlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p1tFthkoFcQXl0H0K0HFxtpdqbQnGM+8Uh/9YPlJ3yi/MpWhXmo97Amk57v8e49+C
         qkAIIBXCrF9Wa2soLC80y9C63bBetwgBBXt+G/ktlitIvHDMbzn2TuqlLdW8/U4rZf
         yIDiwVHh+SILxUgWKK0J617kEfmjAWmq7q9mlebv31HGz7gxbAArUhj4RvctzISS4D
         v2dFCtkq/ZJ00HxsQWL1FBuAospZjPsbMhZXm7BsZyskPM5RfcXV/w9HE+u8jnRgzp
         0BJ12g5WPwzRI5HMcu+iXdA/7bs+Js8um4k/K6PTea0Sg8Cbw4E9MQ7+aalon2JUlu
         ECJISIhpJXFjA==
Date:   Fri, 23 Dec 2022 14:12:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] iio: adc: Kconfig: add SPI interface mention to
 AD7924 description
Message-ID: <20221223141232.0f570f33@jic23-huawei>
In-Reply-To: <20221222203610.2571287-2-hugo@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-2-hugo@hugovil.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Thu, 22 Dec 2022 15:36:08 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The Analog Devices AD7924 uses an SPI interface. There is also a Texas
> Instruments ADS7924 which uses an I2C interface.
> 
> Adding the SPI mention to the AD7924 will help to avoid confusion
> between the two chips.
Hi Hugo,

Welcome to IIO.

I don't really mind this, but given they have different part numbers
and the similarly named TI part could just have easily been SPI
I'm not sure the clarification is really useful.

Also, under all the circumstances I can think of, if you can see the
help text you can also see the SPI dependence clearly listed.

Hence I think is just noise, though I'm guessing it reflects a
confusion you ran into!

Jonathan


> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 46c4fc2fc534..235319546974 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -243,7 +243,7 @@ config AD7923
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices
> -	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
> +	  AD7904, AD7914, AD7923, AD7924 4 Channel SPI ADCs.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7923.

