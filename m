Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9045FCB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJLTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJLTU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:20:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47D5CBFC9;
        Wed, 12 Oct 2022 12:20:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i3so17393071pfk.9;
        Wed, 12 Oct 2022 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0rrEqvpdS6/A3qRrs8G1ifD0QqY6vlEf+AAA3SCDLo=;
        b=iBzv5RFIKLcFDEFE31IHe5x6LpZ6Ym8lDJNJeOhVbsP1RRe3jLwXPlZtKWBY3l+p+c
         tPANZJM2r0maEn4ei2n8BoT6KxZSzL7yfEd+GM64JY9f+dz4jw/evfMMx7f5xymfc4L9
         fBOGaAbreD8+EC1lKjn6AMUcelQ3GRPOOm8q1Z87N26wnX2ma+zFww+4/qKesnPsdq2l
         7Poe2kgZZA33gB5s3V/jHwHmrp9KxE55WifPvVMjz5U5uX3o/xoCn6j0UdpuJNx+vmAQ
         xPxZFqc/Yh7xQ6ItD/BfMV8hWNEXg1i/L7UXdMcOt0izsTw0RuAxSwmfBD8cYNPE+mb4
         s7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0rrEqvpdS6/A3qRrs8G1ifD0QqY6vlEf+AAA3SCDLo=;
        b=3q2oqbVQuvtx1fEYZLuxjr7xX6TvcQyAjx5+Nr0Ijb4lgVXwZDykWwkHAcd1k99Usu
         ro+STpnhI99WxpBhx3m74wkzoyLCYrNooUh0vyD0+8zI3oWsFbolEmUwnQPNDsZsxMhn
         vy5uIItBFKw9/mHZ0jF3lwiaEBHWJ8aPMGnUb2CW1pJLMjS8UDaEDF3tY9AM+FQ1C19a
         8F8LchdkHJ1tZKGPN27J/IfrFrHn0e5r/LznZ1/kBrqUWT0lvazCZAO4FhJnyDrLsktE
         o8ptmMyoa5pumh5k3V6ezP/JiwhFYujCAY2d77EkrSiGznRBwrCmDWk6LoKhA4J8yaOD
         Ux8A==
X-Gm-Message-State: ACrzQf3Ha1Tpm57qnWfNo2i4nJutG/s5+K7G7ou2JBBQCg0R5ipfi5Vc
        bxCK+XDQ6HViUWtuaz1lU0o=
X-Google-Smtp-Source: AMsMyM5LApyzMLt69cPOLbkpAgOB7rUw1DRn6jbML7+50wdhr0ZswZ9v/4yWajRa1tsPYbe6J0I/UQ==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr26962898pgc.512.1665602454084;
        Wed, 12 Oct 2022 12:20:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d4c1:686c:5489:5df9])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm11021027plg.205.2022.10.12.12.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:20:53 -0700 (PDT)
Date:   Wed, 12 Oct 2022 12:20:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/7] gpiolib: of: consolidate simple renames into a
 single quirk
Message-ID: <Y0cTkubAA4637o5y@google.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-2-e01d9d3e7b29@gmail.com>
 <Y0aS80PlA/T3mx2d@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0aS80PlA/T3mx2d@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:12:03AM +0100, Daniel Thompson wrote:
> On Tue, Oct 11, 2022 at 03:19:30PM -0700, Dmitry Torokhov wrote:
> > This consolidates all quirks doing simple renames (either allowing
> > suffix-less names or trivial renames, when index changes are not
> > required) into a single quirk.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/gpio/gpiolib-of.c | 176 +++++++++++++++++-----------------------------
> >  1 file changed, 64 insertions(+), 112 deletions(-)
> 
> Nice diffstat, almost a shame that the diff algo itself has latched onto
> spurious anchor points to generate something that is so hard to read
> ;-) .
> 
> I've reviewed this pretty closely and AFAICT it does exactly what the
> preivous code does. Thus the comments below are all related to things
> that the new table makes obvious that the previous code handled in a
> rather inconsistent way. Maybe that means these could/should be fixed
> in an extra patch within this patch set.
> 
> I guess that means, despite the feedback below, *this* patch is:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index cef4f6634125..619aae0c5476 100644
> > @@ -365,127 +365,83 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
> > +static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
> >  					     const char *con_id,
> >  					     unsigned int idx,
> >  					     enum of_gpio_flags *of_flags)
> >  {
> > +	static const struct of_rename_gpio {
> > +		const char *con_id;
> > +		const char *legacy_id;	/* NULL - same as con_id */
> > +		const char *compatible; /* NULL - don't check */
> 
> "don't check" doesn't seem desirable. It's not too big a deal here
> because everything affected has a vendor prefix (meaning incorrect
> matching is unlikely). Should there be a comment about the general care
> needed for a NULL compatible?

I'll add the wording that NULL is only acceptable if property has a
vendor prefi, Will that be OK? Otherwise I'll have to add a lot of
entries for Arizona and Madera.

> 
> 
> > +	} gpios[] = {
> > +#if IS_ENABLED(CONFIG_MFD_ARIZONA)
> > +		{ "wlf,reset",	NULL,		NULL },
> 
> CONFIG_REGULATOR_ARIZONA_LDO1 is better guard for this con id.

Are you sure? I see reset handling happening in
drivers/mfd/arizona-core.c independently of regulator code...

> 
> 
> > +#endif
> > +#if IS_ENABLED(CONFIG_REGULATOR)
> > +		/*
> > +		 * Some regulator bindings happened before we managed to
> > +		 * establish that GPIO properties should be named
> > +		 * "foo-gpios" so we have this special kludge for them.
> > +		 */
> > +		{ "wlf,ldoena",  NULL,		NULL }, /* Arizona */
> 
> CONFIG_REGULATOR_ARIZONA_LDO1 is better for this one too.

Good idea.

> 
> 
> > +		{ "wlf,ldo1ena", NULL,		NULL }, /* WM8994 */
> > +		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
> 
> CONFIG_REGULATOR_WM8994 is a better guard for these.

Yep.

> 
> 
> > +#endif
> > +#if IS_ENABLED(CONFIG_SPI_MASTER)
> > +		/*
> > +		 * The SPI GPIO bindings happened before we managed to
> > +		 * establish that GPIO properties should be named
> > +		 * "foo-gpios" so we have this special kludge for them.
> > +		 */
> > +		{ "miso",	"gpio-miso",	"spi-gpio" },
> > +		{ "mosi",	"gpio-mosi",	"spi-gpio" },
> > +		{ "sck",	"gpio-sck",	"spi-gpio" },
> 
> CONFIG_SPI_GPIO is a better guard for these.

OK.

> 
> 
> >
> > +		/*
> > +		 * The old Freescale bindings use simply "gpios" as name
> > +		 * for the chip select lines rather than "cs-gpios" like
> > +		 * all other SPI hardware. Allow this specifically for
> > +		 * Freescale and PPC devices.
> > +		 */
> > +		{ "cs",		"gpios",	"fsl,spi" },
> > +		{ "cs",		"gpios",	"aeroflexgaisler,spictrl" },
> 
> CONFIG_SPI_FSL_SPI for these.

OK.

> 
> > +		{ "cs",		"gpios",	"ibm,ppc4xx-spi" },
> 
> CONFIG_SPI_PPC4xx for this.

OK.

> 
> 
> > +#endif
> > +#if IS_ENABLED(CONFIG_TYPEC_FUSB302)
> > +		/*
> > +		 * Fairchild FUSB302 host is using undocumented "fcs,int_n"
> > +		 * property without the compulsory "-gpios" suffix.
> > +		 */
> > +		{ "fcs,int_n",	NULL,		"fcs,fusb302" },
> > +#endif
> >  	};
> > +	struct gpio_desc *desc;
> > +	const char *legacy_id;
> > +	unsigned int i;
> >
> >  	if (!con_id)
> >  		return ERR_PTR(-ENOENT);
> >
> > +	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> > +		if (strcmp(con_id, gpios[i].con_id))
> > +			continue;
> >
> > +		if (gpios[i].compatible &&
> > +		    !of_device_is_compatible(np, gpios[i].compatible))
> > +			continue;
> >
> > +		legacy_id = gpios[i].legacy_id ?: gpios[i].con_id;
> > +		desc = of_get_named_gpiod_flags(np, legacy_id, idx, of_flags);
> > +		if (!gpiod_not_found(desc)) {
> > +			pr_info("%s uses legacy gpio name '%s' instead of '%s-gpios'\n",
> > +				of_node_full_name(np), legacy_id, con_id);
> > +			return desc;
> > +		}
> > +	}
> >
> > +	return ERR_PTR(-ENOENT);
> >  }
> 
> I would normally trim last but this but given what git did to this particular
> patch I left it as a public service ;-)  (it has the - parts of the
> patch removed).
> 
> 
> Daniel.

Thanks.

-- 
Dmitry
