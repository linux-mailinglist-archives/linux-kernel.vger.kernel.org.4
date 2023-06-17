Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7D73417C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjFQNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFQNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA7E4F;
        Sat, 17 Jun 2023 06:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7CC6122E;
        Sat, 17 Jun 2023 13:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A19BC433C8;
        Sat, 17 Jun 2023 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687009750;
        bh=504yc8iPPjU8NVzPNBErG7ipfm0t5oxlemyrrJViFX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjon9VrmDrWjBjdgLGkvf/8Fb+HKIMLZwjsReYzLHRZ8QGRpVntYczSD/rl+YMHHA
         Xjwx8Sgg8hmJjCMaC1wi+IgUQRXM0f0anVkTYddzchDDiV68bFQn+H27ye03DP9q2e
         UUL037fuM7skmcPqT56XRBVi9fzNfIdlyBT/b4LDwD6g+1Hjyr+BA4FA6HDnCupdYw
         Gkf9895nfE8jlylfQ0Xcop5SqbJDIKJIJOcubgWUe1U9lnaGwGr9mwM7Eo9/vzpMKA
         btKbwrIEWqNHfwEdpdjr0JjLNTqQ64y1Vtre6qzAtAKmRldzmXGLcMhLLYcPxUE5Fb
         E5l/44Ln30euQ==
Date:   Sat, 17 Jun 2023 14:48:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs
 GPADC
Message-ID: <20230617144855.0388c4ff@jic23-huawei>
In-Reply-To: <20230615205540.1803975-2-bigunclemax@gmail.com>
References: <20230615205540.1803975-1-bigunclemax@gmail.com>
        <20230615205540.1803975-2-bigunclemax@gmail.com>
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

On Thu, 15 Jun 2023 23:55:20 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> The General Purpose ADC (GPADC) can convert the external signal into
> a certain proportion of digital value, to realize the measurement of
> analog signal, which can be applied to power detection and key detection.
> 
> Theoretically, this ADC can support up to 16 channels. All SoCs below
> contain this GPADC IP. The only difference between them is the number
> of available channels:
> 
>  T113 - 1 channel
>  D1   - 2 channels
>  R329 - 4 channels
>  T507 - 4 channels
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/iio/adc/Kconfig            |  10 ++
>  drivers/iio/adc/Makefile           |   1 +
>  drivers/iio/adc/sun20i-gpadc-iio.c | 276 +++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index eb2b09ef5d5b..deff7ae704ce 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1123,6 +1123,16 @@ config SUN4I_GPADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called sun4i-gpadc-iio.
>  
> +config SUN20I_GPADC
> +	tristate "Support for the Allwinner SoCs GPADC"
I applied this and started a build test before noticing that this Kconfig description
is very vague and matches the one for the existing 4i driver...

The 'Support for the' bit also isn't appropriate for what you see in make menuconfig
menu etc.   Please come up with something descriptive. Maybe
"sun20i and similar SoC GPADC"?

Bonus points if you change the text for the 4i at the same time to be
more meaningful. I clearly missed that in review a long time ago!

It's now too late anyway for the 6.5 cycle, so no particular rush though
I can queue this up for build testing whilst waiting for 6.5-rc1 to come
along (I'll rebase my tree on that once available) and it will then end up
in next etc.

Jonathan

> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	help
> +	  Say yes here to build support for Allwinner (D1, T113, T507 and R329)
> +	  SoCs GPADC. This ADC provides up to 16 channels.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sun20i-gpadc-iio.
> +
