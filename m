Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3A729024
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbjFIGkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbjFIGkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:40:19 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71CE46;
        Thu,  8 Jun 2023 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686292817; x=1717828817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXkXMddf/L10BB2XF000eUm5tEjAoMZu0QK1VuQ3Lww=;
  b=BVFSJqrfuF4HbEphYpxXxOzqUvXivmBPWgahwZjRTSOCa7VeI4FMWMpl
   6YE+9eHo/KgvAMIwgmyxicUHmrIyLPvDIpXBCS3r7XfQI/GF/J41tWPvy
   Pcma9z1T/lqUjM9zmxlqakEdpvkR13oXx9tQCb+vrStDYH4OJOFrDq51C
   C5qRoAXg+A1TI+rdbq2V+Cz0jeLftDNWk1IRl8RZKN4X+AO+3kXZfzS+P
   wdf+CVb2ux6yXn2MPNfzamI9HrWwJF/MoHPXFE17A/6fcZ4iHFNTkvPmc
   FeOUs/EcoMaNSE+9/2TmuM8rZ23v9Zhcc7bxLqUfeZminE9KShcg69L4i
   g==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31355999"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 08:40:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 08:40:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 08:40:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686292815; x=1717828815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXkXMddf/L10BB2XF000eUm5tEjAoMZu0QK1VuQ3Lww=;
  b=Y52mNv7CfvUbCZ2xevSc0vwet0MqhsPeqgEJoZY/SqBRE9bGuiwfgO/I
   H5aIUb+cfQyztaqXGPusm/JM2huGCzaVwqFP9XG1/dQ0jgKJGlkg7SPP4
   RSBJ55uGZhniAGUHXFVU5tJ4akwxNxsrsFT6R+YCLilIWVpw3rCPDqorl
   QqfOVjtsKnC3e+CcIIGzVy4+Z6NyJNqfP7n6vnKH/gp+0X3Jtss4aoj9v
   CqyuDltDJdKCMpf4vCM83ON/UL6ZejMjgREvnPtnW0WHktjU5joJwnhnb
   lfJHQJv9zJFWM+sbV6vdLZFApYHl+xG0coKrlH/jBkg7Hunyv1pQWKbGf
   w==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31355998"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 08:40:15 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4CF5C280087;
        Fri,  9 Jun 2023 08:40:15 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        "linux@ew.tq-group.com" <linux@ew.tq-group.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay support for individual output pins
Date:   Fri, 09 Jun 2023 08:40:15 +0200
Message-ID: <4808746.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 8. Juni 2023, 18:23:08 CEST schrieb Andy Shevchenko:
> The aggregator mode can also handle properties of the platform, that
> do not belong to the GPIO controller itself. One of such a property
> is signal delay line. Intdoduce support of it.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> I don't like the idea of gpio-delay or similar. We have already GPIO
> aggregator that incorporates the GPIO proxy / forwarder functionality.
>=20
> This one is RFC because:
> 1) just compile tested;
> 2) has obvious issues with CONFIG_OF_GPIO;
> 3) contains ~5 patches in a single change for now;
> 4) requires additional work with blocking sysfs for this;
> 5) requires some DT bindings work;
> 6) ...whatever I forgot...
>=20
> Any comments are appreciated, and tests are esp. welcome!

=46WIW: Replacing CONFIG_GPIO_DELAY=3Dm with CONFIG_GPIO_AGGREGATOR=3Dm wor=
ks as=20
well on my platform.
But I'm not sure if it's worth the additional complexity for gpio-aggregato=
r=20
to replace gpio-delay.

Regards,
Alexander

>  drivers/gpio/gpio-aggregator.c | 84 ++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregato=
r.c
> index 20a686f12df7..802d123f0188 100644
> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -10,12 +10,14 @@
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
>  #include <linux/ctype.h>
> +#include <linux/delay.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/overflow.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> @@ -239,6 +241,11 @@ static void __exit gpio_aggregator_remove_all(void)
>   *  GPIO Forwarder
>   */
>=20
> +struct gpiochip_fwd_timing {
> +	unsigned long ramp_up_us;
> +	unsigned long ramp_down_us;
> +};
> +
>  struct gpiochip_fwd {
>  	struct gpio_chip chip;
>  	struct gpio_desc **descs;
> @@ -246,6 +253,7 @@ struct gpiochip_fwd {
>  		struct mutex mlock;	/* protects tmp[] if can_sleep */
>  		spinlock_t slock;	/* protects tmp[] if !can_sleep */
>  	};
> +	struct gpiochip_fwd_timing *delay_timings;
>  	unsigned long tmp[];		/* values and descs for multiple ops=20
*/
>  };
>=20
> @@ -333,11 +341,28 @@ static int gpio_fwd_get_multiple_locked(struct
> gpio_chip *chip, static void gpio_fwd_set(struct gpio_chip *chip, unsigned
> int offset, int value) {
>  	struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
> +	const struct gpiochip_fwd_timing *delay_timings;
> +	struct gpio_desc *desc =3D fwd->descs[offset];
> +	bool is_active_low =3D gpiod_is_active_low(desc);
> +	bool ramp_up;
>=20
> -	if (chip->can_sleep)
> -		gpiod_set_value_cansleep(fwd->descs[offset], value);
> -	else
> -		gpiod_set_value(fwd->descs[offset], value);
> +	delay_timings =3D &fwd->delay_timings[offset];
> +	ramp_up =3D (!is_active_low && value) || (is_active_low && !value);
> +	if (chip->can_sleep) {
> +		gpiod_set_value_cansleep(desc, value);
> +
> +		if (ramp_up && delay_timings->ramp_up_us)
> +			fsleep(delay_timings->ramp_up_us);
> +		if (!ramp_up && delay_timings->ramp_down_us)
> +			fsleep(delay_timings->ramp_down_us);
> +	} else {
> +		gpiod_set_value(desc, value);
> +
> +		if (ramp_up && delay_timings->ramp_up_us)
> +			udelay(delay_timings->ramp_up_us);
> +		if (!ramp_up && delay_timings->ramp_down_us)
> +			udelay(delay_timings->ramp_down_us);
> +	}
>  }
>=20
>  static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long
> *mask, @@ -390,6 +415,28 @@ static int gpio_fwd_to_irq(struct gpio_chip
> *chip, unsigned int offset) return gpiod_to_irq(fwd->descs[offset]);
>  }
>=20
> +static int gpiochip_fwd_delay_of_xlate(struct gpio_chip *chip,
> +				       const struct of_phandle_args=20
*gpiospec,
> +				       u32 *flags)
> +{
> +	struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
> +	struct gpiochip_fwd_timing *timings;
> +	u32 line;
> +
> +	if (gpiospec->args_count !=3D chip->of_gpio_n_cells)
> +		return -EINVAL;
> +
> +	line =3D gpiospec->args[0];
> +	if (line >=3D chip->ngpio)
> +		return -EINVAL;
> +
> +	timings =3D &fwd->delay_timings[line];
> +	timings->ramp_up_us =3D gpiospec->args[1];
> +	timings->ramp_down_us =3D gpiospec->args[2];
> +
> +	return line;
> +}
> +
>  /**
>   * gpiochip_fwd_create() - Create a new GPIO forwarder
>   * @dev: Parent device pointer
> @@ -397,6 +444,7 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip,
> unsigned int offset) * @descs: Array containing the GPIO descriptors to
> forward to.
>   *         This array must contain @ngpios entries, and must not be
> deallocated *         before the forwarder has been destroyed again.
> + * @delay: True if the pins have an external delay line.
>   *
>   * This function creates a new gpiochip, which forwards all GPIO operati=
ons
> to * the passed GPIO descriptors.
> @@ -406,7 +454,8 @@ static int gpio_fwd_to_irq(struct gpio_chip *chip,
> unsigned int offset) */
>  static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
>  						unsigned int=20
ngpios,
> -						struct gpio_desc=20
*descs[])
> +						struct gpio_desc=20
*descs[],
> +						bool delay)
>  {
>  	const char *label =3D dev_name(dev);
>  	struct gpiochip_fwd *fwd;
> @@ -459,6 +508,17 @@ static struct gpiochip_fwd *gpiochip_fwd_create(stru=
ct
> device *dev, else
>  		spin_lock_init(&fwd->slock);
>=20
> +	if (delay) {
> +		fwd->delay_timings =3D devm_kcalloc(dev, ngpios,
> +						  sizeof(*fwd-
>delay_timings),
> +						  GFP_KERNEL);
> +		if (!fwd->delay_timings)
> +			return ERR_PTR(-ENOMEM);
> +
> +		chip->of_xlate =3D gpiochip_fwd_delay_of_xlate;
> +		chip->of_gpio_n_cells =3D 3;
> +	}
> +
>  	error =3D devm_gpiochip_add_data(dev, chip, fwd);
>  	if (error)
>  		return ERR_PTR(error);
> @@ -476,6 +536,7 @@ static int gpio_aggregator_probe(struct platform_devi=
ce
> *pdev) struct device *dev =3D &pdev->dev;
>  	struct gpio_desc **descs;
>  	struct gpiochip_fwd *fwd;
> +	bool delay;
>  	int i, n;
>=20
>  	n =3D gpiod_count(dev, NULL);
> @@ -492,7 +553,9 @@ static int gpio_aggregator_probe(struct platform_devi=
ce
> *pdev) return PTR_ERR(descs[i]);
>  	}
>=20
> -	fwd =3D gpiochip_fwd_create(dev, n, descs);
> +	delay =3D fwnode_device_is_compatible(dev_fwnode(dev), "gpio-delay");
> +
> +	fwd =3D gpiochip_fwd_create(dev, n, descs, delay);
>  	if (IS_ERR(fwd))
>  		return PTR_ERR(fwd);
>=20
> @@ -500,23 +563,24 @@ static int gpio_aggregator_probe(struct
> platform_device *pdev) return 0;
>  }
>=20
> -#ifdef CONFIG_OF
>  static const struct of_device_id gpio_aggregator_dt_ids[] =3D {
>  	/*
>  	 * Add GPIO-operated devices controlled from userspace below,
> -	 * or use "driver_override" in sysfs
> +	 * or use "driver_override" in sysfs.
>  	 */
> +	{
> +		.compatible =3D "gpio-delay",
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, gpio_aggregator_dt_ids);
> -#endif
>=20
>  static struct platform_driver gpio_aggregator_driver =3D {
>  	.probe =3D gpio_aggregator_probe,
>  	.driver =3D {
>  		.name =3D DRV_NAME,
>  		.groups =3D gpio_aggregator_groups,
> -		.of_match_table =3D of_match_ptr(gpio_aggregator_dt_ids),
> +		.of_match_table =3D gpio_aggregator_dt_ids,
>  	},
>  };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


