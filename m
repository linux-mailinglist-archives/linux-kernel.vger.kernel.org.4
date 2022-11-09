Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CC62332C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiKITIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKITIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:08:12 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED21FCC5;
        Wed,  9 Nov 2022 11:08:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so17025176pgh.4;
        Wed, 09 Nov 2022 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixfMcchiZgw52kZAq8ga65voe0N75jQ7G01vjlReHtw=;
        b=J/+RhxHOVRnHo2cW9J/fW/00kA1VNvYlO3MPK5zbjGeFavLt8jHNQQZcKMAAPDo/vB
         5niKiyQ0prVYRK8Z1c0Tjo5B5StfRp8RvEqsQVSG+K8HmoFK0CooPayLiE07Lb9PomRS
         oTVpww2+t4t/S5vKLoqYoGApvgSaWwghLLB8zqEcTrWfnbDo+5eIoZe1sfRjUT3ZlY8M
         k5myO3xBKQff4jOFgZN8Bu+FLWh+n1UaM4ykwE30dCtQ3IudOIdIrckXsqZ/qXfkciFS
         xRLVxWg04Z51ckYUywiX89gbFic5yradMxY4CFgxdh7x2k6tVSVoM6dkPWTSnU0yk8Zy
         IfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixfMcchiZgw52kZAq8ga65voe0N75jQ7G01vjlReHtw=;
        b=JNqIs7PBrb0taizPT9fY+f314GCRsmq2SSeODhgYX7p7MNeF/w/VIY9CGjOavdmuTf
         7MK+PqDvN883jffsSOzTEzDdcBq9dPYhWOivM3BMDpmzD5uXVwcM18QGM4e4j92x5Lr4
         Vl+IpM3SOXY4hSLv4g8tdWV0WxmLkdGFRIXEYmYgzW/58T6S4ockwDIzVcPBdhGFR9EE
         E/by1nFQ1Xrk/0F7LJ28JQzLf05g9sQRptwHl2EyfY3RLVXbortA9WZaGJ/c4sVs89qL
         E58Di6XWw6D/6Cuts6Q28DtOlhS7xhdQZpGWjofHh6nr0p3yfMbHW5EWbCyIOXrq9OUG
         kL3g==
X-Gm-Message-State: ACrzQf0D+ereVykovt9+Z7uL1Kp9rc0KVDq6TAZ6FpQQiiOYSiqFe5m+
        OZmAICH+bjNnv5JJDgZNWw4=
X-Google-Smtp-Source: AMsMyM7L1U5iSr2d5sdp4D0eMoUrTrHfNR/1WqTYzSBGkWkUihtHBxnhBdsz1mnd6hzvLeVO0kFMQw==
X-Received: by 2002:a05:6a00:230f:b0:53e:2c2c:5c03 with SMTP id h15-20020a056a00230f00b0053e2c2c5c03mr61834786pfh.11.1668020890576;
        Wed, 09 Nov 2022 11:08:10 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0017f74cab9eesm9348139plk.128.2022.11.09.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:08:09 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:08:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] gpiolib: add support for software nodes
Message-ID: <Y2v6lxoCQvlRdr8q@google.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-6-81f55af5fa0e@gmail.com>
 <Y2uNDmRefzPvUu3P@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2uNDmRefzPvUu3P@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:20:46PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 08, 2022 at 04:26:51PM -0800, Dmitry Torokhov wrote:
> > Now that static device properties understand notion of child nodes and
> > references, let's teach gpiolib to handle them:
> > 
> > - GPIOs are represented as a references to software nodes representing
> >   gpiochip
> > - references must have 2 arguments - GPIO number within the chip and
> >   GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc)
> > - a new PROPERTY_ENTRY_GPIO() macro is supplied to ensure the above
> > - name of the software node representing gpiochip must match label of
> >   the gpiochip, as we use it to locate gpiochip structure at runtime
> > 
> > The following illustrates use of software nodes to describe a "System"
> > button that is currently specified via use of gpio_keys_platform_data
> > in arch/mips/alchemy/board-mtx1.c. It follows bindings specified in
> > Documentation/devicetree/bindings/input/gpio-keys.yaml.
> > 
> > static const struct software_node mxt1_gpiochip2_node = {
> > 	.name = "alchemy-gpio2",
> > };
> > 
> > static const struct property_entry mtx1_gpio_button_props[] = {
> > 	PROPERTY_ENTRY_U32("linux,code", BTN_0),
> > 	PROPERTY_ENTRY_STRING("label", "System button"),
> > 	PROPERTY_ENTRY_GPIO("gpios", &mxt1_gpiochip2_node, 7, GPIO_ACTIVE_LOW),
> > 	{ }
> > };
> > 
> > Similarly, arch/arm/mach-tegra/board-paz00.c can be converted to:
> > 
> > static const struct software_node tegra_gpiochip_node = {
> > 	.name = "tegra-gpio",
> > };
> > 
> > static struct property_entry wifi_rfkill_prop[] __initdata = {
> > 	PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
> > 	PROPERTY_ENTRY_STRING("type", "wlan"),
> > 	PROPERTY_ENTRY_GPIO("reset-gpios",
> > 			    &tegra_gpiochip_node, 25, GPIO_ACTIVE_HIGH);
> > 	PROPERTY_ENTRY_GPIO("shutdown-gpios",
> > 			    &tegra_gpiochip_node, 85, GPIO_ACTIVE_HIGH);
> > 	{ },
> > };
> > 
> > static struct platform_device wifi_rfkill_device = {
> > 	.name	= "rfkill_gpio",
> > 	.id	= -1,
> > };
> > 
> > ...
> > 
> > 	software_node_register(&tegra_gpiochip_node);
> > 	device_create_managed_software_node(&wifi_rfkill_device.dev,
> > 					    wifi_rfkill_prop, NULL);
> 
> ...
> 
> > +static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
> > +{
> > +	const struct software_node *chip_node;
> > +	struct gpio_chip *chip;
> > +
> > +	chip_node = to_software_node(fwnode);
> > +	if (!chip_node || !chip_node->name)
> > +		return ERR_PTR(-EINVAL);
> 
> > +	chip = gpiochip_find((void *)chip_node->name,
> > +			     swnode_gpiochip_match_name);
> 
> One line?

OK.

> 
> > +	if (!chip)
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> > +	return chip;
> 
> As below you can use Elvis here as well, up to you.
> 
> 	return chip ?: ERR_PTR(...);

OK.

> 
> > +}
> 
> ...
> 
> > +	desc = gpiochip_get_desc(chip, args.args[0]);
> > +	*flags = args.args[1]; /* We expect native GPIO flags */
> > +
> > +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> > +		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));
> 
> %pe ?

"/* %pe with a non-ERR_PTR gets treated as plain %p */".

I do not think users are interested in the address on success.


> 
> > +	return desc;
> 
> ...
> 
> > +	while (fwnode_property_get_reference_args(fwnode, propname, NULL,
> > +						  0, count, &args) == 0) {
> 
> I would move 0 to the previous line.

OK.

> 
> > +		fwnode_handle_put(args.fwnode);
> > +		count++;
> > +	}
> 
> ...
> 
> >  int gpiod_count(struct device *dev, const char *con_id)
> >  {
> > -	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
> > -	int count = -ENOENT;
> > +	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
> 
> Why dropping const?

Restored.

> 
> > +	int count;
> 
> Why this change is needed?

Restored.

> 
> >  	if (is_of_node(fwnode))
> >  		count = of_gpio_get_count(dev, con_id);
> >  	else if (is_acpi_node(fwnode))
> >  		count = acpi_gpio_count(dev, con_id);
> > +	else if (is_software_node(fwnode))
> > +		count = swnode_gpio_count(fwnode, con_id);
> > +	else
> > +		count = -ENOENT;
> 
> ...
> 
> > +#include <dt-bindings/gpio/gpio.h>
> 
> Not sure why we have this here.

For convenience - so that users have access to GPIO_ACTIVE_HIGH/
GPIO_ACTIVE_LOW and other flags.

> 
> > +#include <linux/property.h>
> > +
> > +#define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
> > +	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
> 

Thanks.

-- 
Dmitry
