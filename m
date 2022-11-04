Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEEA61A115
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiKDTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKDTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:33:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879AF43ADA;
        Fri,  4 Nov 2022 12:33:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j12so5795623plj.5;
        Fri, 04 Nov 2022 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ARKR8qs/jkk+GFpNWkrKeKqZm5socR8AqhaHPqrkvU=;
        b=RKvUfVlwYgTVjQVxSKc3a3eKZ7UVXIU0OVNTlbdeLi/KDBD2h/dBYLucYmtYw2jOh/
         GmqCz1Sy7+5wGnjysBh3mQ6ExnCRPWcM4gBvpRh+U491NMHpVbeZxu9SmgI2qUvtolMK
         yjXvTgjBveQTmz4L8jb3toQPRhj3xWy4WAH053lbRHXXYoOD2i8DSZv1061Cw5GaQ5d9
         y36siwd4YYU2O3bv6t3K1wwe/f9wPeacM8JdVYB8BJK6tQ56EdmIclST7Puob5b+pF9/
         1uUqIAb9zzeYX3TiIYs1eq/caPOT+GgVdY/I4bab/IAr876rTvKI3uyyDk22vliLh2O8
         bU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ARKR8qs/jkk+GFpNWkrKeKqZm5socR8AqhaHPqrkvU=;
        b=4Jyxh1cO2OM2UOuUNxJl/3Td+aE0vo7TSj+NdSi7L4xDv2P5x8E2vZ8+VIV7of+BtF
         WH/D3xJbkQeK/vtStv8ZuL5UMQtq7eWdVf43poYeETCiz3dWvAaaDjKVNB9XMU2CIQHM
         F1qkp1xFiHCA6NJqrCBcn4wPLk9AtHzqOWoXGmJiRTPPnBd4e597y4bdGOlTRH3yVxp4
         HWFqnz0uyAXsxm43bm763n2D0xjkr7z1IY50ap63551h+CZWcy7bbR1nYQr3j+r64tvA
         TxWfil/0Vzh5sFydgUPmwpZhSkbn04uscwg9Si325+mh2H7VC3S2tTOhIhbZjzZLCjCJ
         peYQ==
X-Gm-Message-State: ACrzQf0Rw0u+qqd3RkjXtSZFaiDbC0I1CplVTbbkwWmkqcddX3UpxYBk
        IJCwAZQGGrbNVL+TyI6zlXQ=
X-Google-Smtp-Source: AMsMyM6PdczZPZ2GEcnVUo7FjOzGiaEu4H979n2XCvpvJYbMKBFUA51epdrDj9Mgjun9ZSVstlZY6A==
X-Received: by 2002:a17:90a:578c:b0:213:b509:9474 with SMTP id g12-20020a17090a578c00b00213b5099474mr35480972pji.45.1667590389817;
        Fri, 04 Nov 2022 12:33:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id y13-20020aa78f2d000000b0056babe4fb8asm9664pfr.49.2022.11.04.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:33:09 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:33:06 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2Vo8g5HfvSi7Bck@google.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 08:08:03PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:
> > Now that static device properties understand notion of child nodes and
> > references, let's teach gpiolib to handle them:
> > 
> > - GPIOs are represented as a references to software nodes representing
> >   gpiochip
> > - references must have 2 arguments - GPIO number within the chip and
> >   GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc).
> > - name of the software node representing gpiochip must match label of
> >   the gpiochip, as we use it to locate gpiochip structure at runtime.
> > 
> > const struct software_node gpio_bank_b_node = {
> > 	.name = "B",
> > };
> > 
> > const struct property_entry simone_key_enter_props[] __initconst = {
> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> 
> > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> 
> Okay, can we have an example for something like reset-gpios? Because from
> the above I can't easily get what label is and how in the `gpioinfo` tool
> the requested line will look like.

The label is something unrelated to gpio. The example was supposed to
match gpio-keys binding found in
Documentation/devicetree/bindings/input/gpio-keys.yaml

> 
> > 	{ }
> > };
> 
> ...
> 
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/gpio/consumer.h>
> 
> It seems you are using much more that these ones.

Yeah, you are right.

> 
> ...
> 
> > +	char prop_name[32]; /* 32 is max size of property name */
> 
> Why is it not defined then?

Not sure. 32 is the limit used throughout gpiolib (see the main
gpiolib.c, gpiolib-acpi.c and gpiolib-of.c). We could add a private
gpiolib define. Or we could dynamically allocate strings if we belive
this is an issue.

I'd like to do it as a followup if we decide this needs changing.


> 
> ...
> 
> > +	/*
> > +	 * Note we do not need to try both -gpios and -gpio suffixes,
> > +	 * as, unlike OF and ACPI, we can fix software nodes to conform
> > +	 * to the proper binding.
> > +	 */
> 
> True, but for the sake of consistency between providers perhaps it makes sense
> to check that as well. Dunno, up to Linus and Bart to decide.

I hear you, however we had to have this fallback for OF and ACPI because
of concerns of separate DT/firmware and keeping compatibility. Here we
do not have this problem, so I think we should require properly named
properties.

> 
> ...
> 
> > +	/*
> > +	 * We expect all swnode-described GPIOs have GPIO number and
> > +	 * polarity arguments, hence nargs is set to 2.
> > +	 */
> 
> Maybe instead you can provide a custom macro wrapper that will check the number
> of arguments at compile time?

We could have PROPERTY_ENTRY_GPIO() built on top of PROPERTY_ENTRY_REF()
that enforces needed arguments.


> 
> ...
> 
> > +		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
> > +			__func__, prop_name, fwnode, idx);
> 
> __func__ is not needed. Dynamic Debug can automatically add it.
> Since you have an fwnode, use that as a marker.

I was mimicking gpiolib-of.c::of_get_named_gpiod_flags(). I guess we can
guess the function from other log messages we emit, but does it hurt
having it?

> 
> ...
> 
> > +	chip = gpiochip_find((void *)chip_node->name,
> > +			     swnode_gpiochip_match_name);
> 
> One line?
> 
> ...
> 
> > +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> > +		 __func__, prop_name, fwnode, idx, PTR_ERR_OR_ZERO(desc));
> 
> Same as above.
> 
> ...
> 
> > +	char prop_name[32];
> 
> > +	if (con_id)
> > +		snprintf(prop_name, sizeof(prop_name), "%s-gpios", con_id);
> > +	else
> > +		strscpy(prop_name, "gpios", sizeof(prop_name));
> 
> I saw this code, please deduplicate.

OK.

> 
> ...
> 
> > +	/*
> > +	 * This is not very efficient, but GPIO lists usually have only
> > +	 * 1 or 2 entries.
> > +	 */
> > +	count = 0;
> > +	while (fwnode_property_get_reference_args(fwnode, prop_name, NULL,
> > +						  0, count, &args) == 0)
> 
> I would put it into for loop (and looking into property.h I think propname
> is fine variable name):
> 
> 	for (count = 0; ; count++) {
> 		if (fwnode_property_get_reference_args(fwnode, propname, NULL, 0, count, &args))
> 			break;
> 	}

OK on name, but I like explicit counting with the "while" loop as it
shows the purpose of the code.

> 
> Btw, what about reference counting? Do we need to care about it?

Yes, indeed, we need to drop the reference, thank you for noticing!
> 
> > +	return count ? count : -ENOENT;
> 
> Elvis would work as well.
> 
> 	return count ?: -ENOENT;

OK, I like Elvis.

> 
> 
> ...
> 
> > +struct fwnode_handle;
> 
> struct gpio_desc;
> 
> > +
> > +struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
> > +				   const char *con_id, unsigned int idx,
> > +				   unsigned long *flags);
> > +int swnode_gpio_count(struct fwnode_handle *fwnode, const char *con_id);
> 
> ...
> 
> > +	/*
> > +	 * First look up GPIO in the secondary software node in case
> > +	 * it was used to store updated properties.
> 
> Why this is done first? We don't try secondary before we have checked primary.

I believe we should check secondary first, so that secondaries can be
used not only to add missing properties, but also to override existing
ones in case they are incorrect.

> 
> > +	 */
> 
> > +	if (is_software_node(fwnode->secondary)) {
> 
> With the previous comments it would become
> 
> 	if (fwnode && is_...)

Right, I prefer if we could trust that fwnode passed here is not NULL.

> 
> > +		dev_dbg(consumer,
> > +			"using secondary software node for GPIO lookup\n");
> > +		desc = swnode_find_gpio(fwnode->secondary,
> > +					con_id, idx, lookupflags);
> > +		if (!gpiod_not_found(desc))
> > +			return desc;
> > +	}
> 
> ...
> 
> >  int gpiod_count(struct device *dev, const char *con_id)
> >  {
> > +	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
> > +	int count;
> > +
> > +	/*
> > +	 * First look up GPIO in the secondary software node in case
> > +	 * it was used to store updated properties.
> > +	 */
> 
> Same question as above.
> 
> > +	if (!IS_ERR_OR_NULL(fwnode) && is_software_node(fwnode->secondary)) {
> > +		count = swnode_gpio_count(fwnode->secondary, con_id);
> > +		if (count > 0)
> > +			return count;
> > +	}
> >  
> >  	if (is_of_node(fwnode))
> >  		count = of_gpio_get_count(dev, con_id);
> >  	else if (is_acpi_node(fwnode))
> >  		count = acpi_gpio_count(dev, con_id);
> > +	else if (is_software_node(fwnode))
> > +		count = swnode_gpio_count(fwnode, con_id);
> > +	else
> > +		count = -ENOENT;
> >  
> >  	if (count < 0)
> >  		count = platform_gpio_count(dev, con_id);
> 

Thanks for the review!

-- 
Dmitry
