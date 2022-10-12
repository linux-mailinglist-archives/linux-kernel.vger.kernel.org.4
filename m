Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C25FC394
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJLKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJLKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:13:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57576BEF84
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:12:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso912236wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tI7PHfOLhCMDky4RFaRr7XN7h/vhLHywitQ65xQxnf4=;
        b=jDN6aNOQF63xHDfgl/I+pcb8pIDncqDL92OU2QwG5x0xwjP6ya9EaE6e2g8FGRKNNJ
         EQj4rYIoTeav/6I19wn6vMm34avu9+q90pOc4S2nZg+H4VtgwONb3a5cD7f+bSFqcPJJ
         /ED/qjQeCg9OXGa5zbCTmq0nYt4+Bd+xxYc2uAMGLFcuCUCPeaQx7YWHvmEgobDv4TDE
         ytHpDyOee8PyyNlO5/crICK1Qppi7A/pZKBjKeV+/9Cc2wmGY+9/o8nzgIeUJG8P5h/N
         oYrWg+KPejhMNOzXdSa8j8Xw8+2R8ATvmFNa/CvBPeylbqWObW4RDLpB6MM3bxV5v+6A
         w0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI7PHfOLhCMDky4RFaRr7XN7h/vhLHywitQ65xQxnf4=;
        b=c69I6hvfvM2Xk5r06JaksjD3VPImFJ3xdzPKx3Ixa0K8kiDaTZ0D8JoCLm5fT85TR1
         mtNdSIvhrtw+RYCfyXccgOl6/TKx1tZJMUuOTdqwRLIORsbfiQ7Nm3CMjWOWrFvrdno3
         LGB+HkPMQb0oxUiWWYS3QQEiwKJn/bs+HHCncc2jEel1JfxB5U4m9k16FwFjGmBryFxi
         SJAQTkBlUl7jPVIpKQD8d88BlaGH0+Bvjrj1/ubnK0E+SR0alX6Y388Cr6F3JOkHcpcm
         QLolGE8vxSsPTjUeA0++jzvBjOGqRbqMIfAHTVLDfMpBxp/1M98h3IkbViCGJc17t/ks
         9mDw==
X-Gm-Message-State: ACrzQf3Y13AlcY6uF3KPxoq9mQGc/4jSeCnL/hU3Lr+VDm/vcFM9Ic1s
        Jted6bskxnf9oZpOLLaPn9GCEA==
X-Google-Smtp-Source: AMsMyM59Kx/pKJsX0EBYR+W2gL9kth140yo0oBjBBh/p1IQe4wPr6eHbwUWALfwFZCGl5TO57rgPAg==
X-Received: by 2002:a05:600c:d5:b0:3c0:fba1:d2b9 with SMTP id u21-20020a05600c00d500b003c0fba1d2b9mr2192182wmm.108.1665569525703;
        Wed, 12 Oct 2022 03:12:05 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b4fe03c881sm1390163wmq.48.2022.10.12.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:12:05 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:12:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/7] gpiolib: of: consolidate simple renames into a
 single quirk
Message-ID: <Y0aS80PlA/T3mx2d@maple.lan>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-2-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v1-2-e01d9d3e7b29@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:19:30PM -0700, Dmitry Torokhov wrote:
> This consolidates all quirks doing simple renames (either allowing
> suffix-less names or trivial renames, when index changes are not
> required) into a single quirk.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 176 +++++++++++++++++-----------------------------
>  1 file changed, 64 insertions(+), 112 deletions(-)

Nice diffstat, almost a shame that the diff algo itself has latched onto
spurious anchor points to generate something that is so hard to read
;-) .

I've reviewed this pretty closely and AFAICT it does exactly what the
preivous code does. Thus the comments below are all related to things
that the new table makes obvious that the previous code handled in a
rather inconsistent way. Maybe that means these could/should be fixed
in an extra patch within this patch set.

I guess that means, despite the feedback below, *this* patch is:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index cef4f6634125..619aae0c5476 100644
> @@ -365,127 +365,83 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
> +static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
>  					     const char *con_id,
>  					     unsigned int idx,
>  					     enum of_gpio_flags *of_flags)
>  {
> +	static const struct of_rename_gpio {
> +		const char *con_id;
> +		const char *legacy_id;	/* NULL - same as con_id */
> +		const char *compatible; /* NULL - don't check */

"don't check" doesn't seem desirable. It's not too big a deal here
because everything affected has a vendor prefix (meaning incorrect
matching is unlikely). Should there be a comment about the general care
needed for a NULL compatible?


> +	} gpios[] = {
> +#if IS_ENABLED(CONFIG_MFD_ARIZONA)
> +		{ "wlf,reset",	NULL,		NULL },

CONFIG_REGULATOR_ARIZONA_LDO1 is better guard for this con id.


> +#endif
> +#if IS_ENABLED(CONFIG_REGULATOR)
> +		/*
> +		 * Some regulator bindings happened before we managed to
> +		 * establish that GPIO properties should be named
> +		 * "foo-gpios" so we have this special kludge for them.
> +		 */
> +		{ "wlf,ldoena",  NULL,		NULL }, /* Arizona */

CONFIG_REGULATOR_ARIZONA_LDO1 is better for this one too.


> +		{ "wlf,ldo1ena", NULL,		NULL }, /* WM8994 */
> +		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */

CONFIG_REGULATOR_WM8994 is a better guard for these.


> +#endif
> +#if IS_ENABLED(CONFIG_SPI_MASTER)
> +		/*
> +		 * The SPI GPIO bindings happened before we managed to
> +		 * establish that GPIO properties should be named
> +		 * "foo-gpios" so we have this special kludge for them.
> +		 */
> +		{ "miso",	"gpio-miso",	"spi-gpio" },
> +		{ "mosi",	"gpio-mosi",	"spi-gpio" },
> +		{ "sck",	"gpio-sck",	"spi-gpio" },

CONFIG_SPI_GPIO is a better guard for these.


>
> +		/*
> +		 * The old Freescale bindings use simply "gpios" as name
> +		 * for the chip select lines rather than "cs-gpios" like
> +		 * all other SPI hardware. Allow this specifically for
> +		 * Freescale and PPC devices.
> +		 */
> +		{ "cs",		"gpios",	"fsl,spi" },
> +		{ "cs",		"gpios",	"aeroflexgaisler,spictrl" },

CONFIG_SPI_FSL_SPI for these.

> +		{ "cs",		"gpios",	"ibm,ppc4xx-spi" },

CONFIG_SPI_PPC4xx for this.


> +#endif
> +#if IS_ENABLED(CONFIG_TYPEC_FUSB302)
> +		/*
> +		 * Fairchild FUSB302 host is using undocumented "fcs,int_n"
> +		 * property without the compulsory "-gpios" suffix.
> +		 */
> +		{ "fcs,int_n",	NULL,		"fcs,fusb302" },
> +#endif
>  	};
> +	struct gpio_desc *desc;
> +	const char *legacy_id;
> +	unsigned int i;
>
>  	if (!con_id)
>  		return ERR_PTR(-ENOENT);
>
> +	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> +		if (strcmp(con_id, gpios[i].con_id))
> +			continue;
>
> +		if (gpios[i].compatible &&
> +		    !of_device_is_compatible(np, gpios[i].compatible))
> +			continue;
>
> +		legacy_id = gpios[i].legacy_id ?: gpios[i].con_id;
> +		desc = of_get_named_gpiod_flags(np, legacy_id, idx, of_flags);
> +		if (!gpiod_not_found(desc)) {
> +			pr_info("%s uses legacy gpio name '%s' instead of '%s-gpios'\n",
> +				of_node_full_name(np), legacy_id, con_id);
> +			return desc;
> +		}
> +	}
>
> +	return ERR_PTR(-ENOENT);
>  }

I would normally trim last but this but given what git did to this particular
patch I left it as a public service ;-)  (it has the - parts of the
patch removed).


Daniel.
