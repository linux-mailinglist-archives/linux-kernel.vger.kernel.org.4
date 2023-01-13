Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C40666A3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjAMUTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjAMUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:18:59 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 12:18:50 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535C6537A;
        Fri, 13 Jan 2023 12:18:47 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQ8OG-1p3HGP32MC-00M5Ne; Fri, 13 Jan 2023 21:13:25 +0100
Message-ID: <916654ca-e70f-5663-f3a3-9b370c24aea9@i2se.com>
Date:   Fri, 13 Jan 2023 21:13:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] pinctrl: bcm: bcm2835: Switch to use
 ->add_pin_ranges()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yiDXUOatf5Gel6EC+Ze8dBtbvVUfNu8pAQoeT5SLNKthxqjmm0Z
 EB/rTIVwdV9ugtS9XV6YIm37R3ZaK3SGTp7OVGEbLeiJuJlzqmu+hCWZr/KDc6qgLNFD8Wd
 HA0iveSHUmnlXYZF9tsnug8awNZ9mcZdGhilzSLUBtZOpNJR+hkWBo1CqHmo9fMurOH7fk7
 7BCDSTqCmMbH2QeN/EqOg==
UI-OutboundReport: notjunk:1;M01:P0:AUkB9Elkla8=;4fAMlooaq1jdNCWRe32ofZjROZR
 NsM4Qz7njl85Vy5fyaVGQMr+TOan2h2c4BgSGwkICJQOQpirFotwqwv9nMko9S8RTR2pKItot
 3Szwu7725Ubpdd1x2TuJSMzTKo7PFWBPy2y66o43rEtejcDqxjtqW58MSu+czoFJSWSgPJvUP
 IavZHjlwlk5oJx82xErBHyhoriTHj0tJTgMVL6lifH/8gagHa06Xw7LsXa+GgEdme90yVf32W
 I9SS+UqFjGx9ZDxNaP48TQTzAWeHk3cuN2vrMk/j9AYpmLYsPfassmKNM3hK6ySxzCYfhQj2P
 9JG2nZctSL1u6NMPZSPoVQPTQRcIVX0UpaAXl8hH94Y3o+sL9Shcf9jN4MXAEnzI0Ove/aGuX
 YNGTewidrC3jwpDEfoI4bTnSghExQoZj8d8lFWUquSptuK0/CN96WJeF18gurDKwSbXE4i6Ee
 GdUYd3P0nzwzDxFvWwY3kqg5tVsLhRa6XQ73oR+kvL/D/yYe0B9s5jS3MQXp4r8LtFogeVhpi
 4Nv9luVfa5/3zd7sshDwYTUbgiVqt+/IBLfrCF8oJ6Fi9z5ePxw7tV3CYXWvEn64b+QYa47RA
 zoDUcfu+g5/RuQSOPfVluqdpHzSzS0sBcSm+McXN2zqcoTFWv2khhAeS4WqF0OdmOHVbR0qEx
 FN7WxIK1VARqyOiiFZm+nDYIxSW+xpDmlfvxlbCwwQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am 13.01.23 um 18:10 schrieb Andy Shevchenko:
> Yeah, while the ->add_pin_ranges() shouldn't be used by DT drivers,
> this one requires it to support quite old firmware descriptions that
> do not have gpio-ranges property.
>
> The change allows to clean up GPIO library from OF specifics.
> There is no functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed compilation issues (LKP), Cc'ed to the author of original code
>
> Btw, the commit d2b67744fd99 ("pinctrl: bcm2835: implement hook for
> missing gpio-ranges") seems problematic in the fist place due to
> odd of_node_put() call. I dunno how that part had been tested, or
> how it's supposed to work, i.e. where is the counterpart of_node_get().
> Anyway this change drops it for good.

The countpart is in of_pinctrl_get(). I was just following the pattern 
like in other drivers like gpio-rockchip. The original commit has been 
tested by Florian Fainelli and me. I'm not sure if it's safe to drop it 
completely.

Btw this is not the only platform affected by the gpio-ranges 
compatibility issue [1].

> Perhaps we can check gpio-ranges property presence inside the GPIO
> library, so this ->add_pin_ranges() won't be called at all.

I thought this could be very platform specific, so i implemented a hook. 
But yes my initial hack modified gpiolib-of [2].

[1] 
- https://patchwork.kernel.org/project/linux-arm-msm/patch/20180412190138.12372-1-chunkeey@gmail.com/

[2] - 
https://lore.kernel.org/linux-arm-kernel/75266ed1-666a-138b-80f1-ae9a06b7bdf3@i2se.com/

> Also I would like to understand the dance around checking for pin
> control device. The original commit lacks of comments in the non-trivial
> code.
>
>   drivers/pinctrl/bcm/pinctrl-bcm2835.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 7857e612a100..29f278c49103 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -358,16 +358,17 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
>   	return 0;
>   }
>   
> -static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
> -					   struct device_node *np)
> +static int bcm2835_add_pin_ranges_fallback(struct gpio_chip *gc)
>   {
> +	struct device_node *np = dev_of_node(gc->parent);
>   	struct pinctrl_dev *pctldev = of_pinctrl_get(np);
>   
> -	of_node_put(np);
> -
>   	if (!pctldev)
>   		return 0;
>   
> +	if (of_property_read_bool(np, "gpio-ranges"))
> +		return 0;
> +
>   	gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
>   			       gc->ngpio);
>   
> @@ -388,7 +389,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
>   	.base = -1,
>   	.ngpio = BCM2835_NUM_GPIOS,
>   	.can_sleep = false,
> -	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
> +	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
>   };
>   
>   static const struct gpio_chip bcm2711_gpio_chip = {
> @@ -405,7 +406,7 @@ static const struct gpio_chip bcm2711_gpio_chip = {
>   	.base = -1,
>   	.ngpio = BCM2711_NUM_GPIOS,
>   	.can_sleep = false,
> -	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
> +	.add_pin_ranges = bcm2835_add_pin_ranges_fallback,
>   };
>   
>   static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
