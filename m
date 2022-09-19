Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB785BCECD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiISOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiISOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:31:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF6958D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:31:23 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220919143119euoutp028ab5df73dbe44271c8d6f7b804dcf43f~WSXUWjx100409504095euoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 14:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220919143119euoutp028ab5df73dbe44271c8d6f7b804dcf43f~WSXUWjx100409504095euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663597879;
        bh=fZdCIzgG41UdH6uSZoCggfFQize6TCzFRhqHY0cCi/g=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=o2+s2e3BH+ZnHFa3C6ZW3d5KnQ3FaG18FYmISgMZMNw6HEzX5msN4mOTyrzcp9Wyi
         FJaTlltxln5JmOqdTosOnxvfFRU5NZLdfce38kwV+CWK7ufFs4vQSpORopF+frrQjm
         6xpSIfaXFFcNZlMu7nADwaLgBS/r1BlbkBgQpVXQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220919143119eucas1p13a7388723ed19d15afd7f57304f7d71c~WSXUEw6XB2095820958eucas1p1g;
        Mon, 19 Sep 2022 14:31:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.2F.07817.73D78236; Mon, 19
        Sep 2022 15:31:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220919143118eucas1p2392c27fa14e8b20292a6df5ffd2edb9d~WSXTtEv430096800968eucas1p2D;
        Mon, 19 Sep 2022 14:31:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220919143118eusmtrp205ba37a59b63e4dd8a05a8847f4e6e03~WSXTsPLmy1469814698eusmtrp2z;
        Mon, 19 Sep 2022 14:31:18 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-06-63287d37c581
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.7B.10862.63D78236; Mon, 19
        Sep 2022 15:31:18 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220919143118eusmtip28440eeefea75d51d22be340086dfe286~WSXTKsRqp1420314203eusmtip2h;
        Mon, 19 Sep 2022 14:31:18 +0000 (GMT)
Message-ID: <4e60f9aa-b2ab-65bc-2c93-cd0324fccb3a@samsung.com>
Date:   Mon, 19 Sep 2022 16:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] media: i2c: s5k6a3: switch to using gpiod API
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220913164104.203957-2-dmitry.torokhov@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87rmtRrJBpNf8lg8mLeNzWL+kXOs
        FocXvWC06HvxkNliyp/lTBabHl9jtbi8aw6bRc+GrawWM87vY7JYtukPkwOXx85Zd9k9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlXH04DamghvSFf2/LrA3MC4S
        62Lk5JAQMJFonf6VuYuRi0NIYAWjxPIN89kgnC+MEvvmrWOHcD4DZVZ8Y4Rp6Z77GqplOaNE
        z6unUFUfGSXmv97JAlLFK2An0fG9D8jm4GARUJXovOELERaUODnzCViJqECyxKxjx8CGCgu4
        SXSfnsoKYjMLiEvcejKfCWSmiMBrRomLl/vBHGaBZUBnnLnDDlLFJmAo0fW2iw3E5hRwkOi8
        tYoNolteYvvbOWDnSQj855A4s38R1N0uEm/mXIOyhSVeHd/CDmHLSPzfCbFOQqCdUWLB7/tQ
        zgRGiYbnt6A6rCXunPvFBvIPs4CmxPpd+hBhR4kX336DhSUE+CRuvBWEOIJPYtK26cwQYV6J
        jjYhiGo1iVnH18GtPXjhEvMERqVZSAEzCykAZiF5ZxbC3gWMLKsYxVNLi3PTU4uN8lLL9YoT
        c4tL89L1kvNzNzEC09Xpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrxvEzWShXhTEiurUovy44tK
        c1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTA1/9JMOfzzcTVDxazssNdLJ+xr
        33HeXzPDv0BfgSO75EyJjHO2VfvfoxF/LuWFvT/a2TVl37H8gCCWsB/xMfpr39zuTLHzd71i
        buEwK3GSwo6HX5o0s+Sqw7wTJvXOz93HFfnir6zN6qjaM8W/cm/5e+hNO34r6IHywgvpbQ6v
        Z2eqTOdUm3Rgi9UNxqQ9yjJv01bO/saUc8OPRyEosEqlquOiQ4xZhlni2aOSNhU1uVY33/ht
        m2KhP1uR2VS1z7Da8enNssZ5XXe+VBpH8WlXhEqd0eE1vbH78cozu6oWLmlilNd84q+Q2Hgy
        c41t5feXf5fNUrdMjzxSXKgv6Wm/fftr/UcfNCerhIRKKLEUZyQaajEXFScCACUVb0LGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7pmtRrJBje6DC0ezNvGZjH/yDlW
        i8OLXjBa9L14yGwx5c9yJotNj6+xWlzeNYfNomfDVlaLGef3MVks2/SHyYHLY+esu+wem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQyzh6cBtTwQ3piv5fF9gbGBeJdTFyckgImEh0z33N3MXIxSEk
        sJRR4u2ih8wQCRmJk9MaWCFsYYk/17rYIIreM0o8aW9mA0nwCthJdHzvY+li5OBgEVCV6Lzh
        CxEWlDg58wkLiC0qkCyxpOE+2BxhATeJ7tNTwWxmAXGJW0/mM4HYIgJvGSXu7VIFmc8ssIxR
        Yt27DywQy04ySlw7PAWsg03AUKLrbRfYYk4BB4nOW6vYICaZSXRt7WKEsOUltr+dwzyBUWgW
        kkNmIVk4C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG57ZjP7fsYFz56qPe
        IUYmDsZDjBIczEoivG8TNZKFeFMSK6tSi/Lji0pzUosPMZoCA2Mis5Rocj4wPeSVxBuaGZga
        mphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTCxGAifmRTZynhdOlR/1gujE/qC
        82xrG3qUBU/mXry+N2eljnKT47cQDsmiQ73TXgd0986TuPjv5dEddbqGgZslDt/elxdjkHhh
        Y9iMqxJZjGZcp7MVjlff3dS5xm+mgo9uVX0R79bASexCLiZLp2+XFNp7KeWuyu9zUp+Z8p5W
        BGU0+i6rLNjck/dxltNZtzofe9clj2V/Sq/XnPZ+kuGbS/83fv2UaFdmntK78b1fxTaj388f
        H7oT9KzwgH0Lr7+E7s27cUJLy94Fv38R2PqkZd1vdtP46bP9WoJfzzPtalzTZh9odn7qa+UX
        kXkrq49sXpIWt6dnw5e8o1H2++c6vF6zRfz+fibW/CdxT+qVWIozEg21mIuKEwHZXp/BVwMA
        AA==
X-CMS-MailID: 20220919143118eucas1p2392c27fa14e8b20292a6df5ffd2edb9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220913174544eucas1p19b228eb6206bb058e8817848c3f8a9b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220913174544eucas1p19b228eb6206bb058e8817848c3f8a9b5
References: <20220913164104.203957-1-dmitry.torokhov@gmail.com>
        <CGME20220913174544eucas1p19b228eb6206bb058e8817848c3f8a9b5@eucas1p1.samsung.com>
        <20220913164104.203957-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.09.2022 18:41, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes one of the last uses of of_get_gpio_flags().
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

> ---
>   drivers/media/i2c/s5k6a3.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/media/i2c/s5k6a3.c b/drivers/media/i2c/s5k6a3.c
> index a4efd6d10b43..ef6673b10580 100644
> --- a/drivers/media/i2c/s5k6a3.c
> +++ b/drivers/media/i2c/s5k6a3.c
> @@ -9,12 +9,12 @@
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
> +#include <linux/err.h>
>   #include <linux/errno.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/i2c.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> -#include <linux/of_gpio.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
> @@ -59,7 +59,7 @@ struct s5k6a3 {
>   	struct v4l2_subdev subdev;
>   	struct media_pad pad;
>   	struct regulator_bulk_data supplies[S5K6A3_NUM_SUPPLIES];
> -	int gpio_reset;
> +	struct gpio_desc *gpio_reset;
>   	struct mutex lock;
>   	struct v4l2_mbus_framefmt format;
>   	struct clk *clock;
> @@ -216,11 +216,11 @@ static int __s5k6a3_power_on(struct s5k6a3 *sensor)
>   			goto error_clk;
>   	}
>   
> -	gpio_set_value(sensor->gpio_reset, 1);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
>   	usleep_range(600, 800);
> -	gpio_set_value(sensor->gpio_reset, 0);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
>   	usleep_range(600, 800);
> -	gpio_set_value(sensor->gpio_reset, 1);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
>   
>   	/* Delay needed for the sensor initialization */
>   	msleep(20);
> @@ -240,7 +240,7 @@ static int __s5k6a3_power_off(struct s5k6a3 *sensor)
>   {
>   	int i;
>   
> -	gpio_set_value(sensor->gpio_reset, 0);
> +	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
>   
>   	for (i = S5K6A3_NUM_SUPPLIES - 1; i >= 0; i--)
>   		regulator_disable(sensor->supplies[i].consumer);
> @@ -285,32 +285,24 @@ static int s5k6a3_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct s5k6a3 *sensor;
>   	struct v4l2_subdev *sd;
> -	int gpio, i, ret;
> +	int i, ret;
>   
>   	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
>   	if (!sensor)
>   		return -ENOMEM;
>   
>   	mutex_init(&sensor->lock);
> -	sensor->gpio_reset = -EINVAL;
> -	sensor->clock = ERR_PTR(-EINVAL);
>   	sensor->dev = dev;
>   
>   	sensor->clock = devm_clk_get(sensor->dev, S5K6A3_CLK_NAME);
>   	if (IS_ERR(sensor->clock))
>   		return PTR_ERR(sensor->clock);
>   
> -	gpio = of_get_gpio_flags(dev->of_node, 0, NULL);
> -	if (!gpio_is_valid(gpio))
> -		return gpio;
> -
> -	ret = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_LOW,
> -						S5K6A3_DRV_NAME);
> -	if (ret < 0)
> +	sensor->gpio_reset = devm_gpiod_get(dev, NULL, GPIOD_OUT_HIGH);
> +	ret = PTR_ERR_OR_ZERO(sensor->gpio_reset);
> +	if (ret)
>   		return ret;
>   
> -	sensor->gpio_reset = gpio;
> -
>   	if (of_property_read_u32(dev->of_node, "clock-frequency",
>   				 &sensor->clock_frequency)) {
>   		sensor->clock_frequency = S5K6A3_DEFAULT_CLK_FREQ;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

