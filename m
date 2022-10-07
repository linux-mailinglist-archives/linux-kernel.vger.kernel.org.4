Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031305F7453
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJGGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGGqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:46:35 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86982C1DB0;
        Thu,  6 Oct 2022 23:46:33 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.146.13])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 33DC223D5F4;
        Fri,  7 Oct 2022 06:46:32 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 7 Oct
 2022 08:46:31 +0200
Message-ID: <7ecb85d2-5e6b-b706-2ac2-3e56bf2b89aa@traphandler.com>
Date:   Fri, 7 Oct 2022 08:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v3 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Content-Language: en-US
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>, <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sha@pengutronix.de>
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-5-jjhiblot@traphandler.com>
 <6f8e986d-6835-ae9a-bba7-074e822c25f5@gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <6f8e986d-6835-ae9a-bba7-074e822c25f5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 14647957792190904599
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhhrgesphgvnhhguhhtrhhonhhigidruggvpdfovfetjfhoshhtpehmoheftddtge
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/09/2022 16:54, Jacek Anaszewski wrote:
> Hi Jean,
>
> General question to this driver: since it seems that it is allowed to
> have duplicate LEDs of the same color, then it will be impossible to
> distinguish which of the two same colors in multi_index file will refer
> to which physical LED. Are you aware of this shortcoming?

Hi Jacek,

yes I'm aware of this, but I don't think it can be a problem in a real 
environment. There will probably few cases were multiple leds of the 
same color are used and even fewer were those leds need to be controlled 
differently.

>
> Besides that I have two remarks below.
>
> On 9/17/22 10:13, Jean-Jacques Hiblot wrote:
>> By allowing to group multiple monochrome LED into multicolor LEDs,
>> all involved LEDs can be controlled in-sync. This enables using effects
>> using triggers, etc.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   drivers/leds/rgb/Kconfig                 |   6 +
>>   drivers/leds/rgb/Makefile                |   1 +
>>   drivers/leds/rgb/leds-group-multicolor.c | 153 +++++++++++++++++++++++
>>   3 files changed, 160 insertions(+)
>>   create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
>>
>> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
>> index 204cf470beae..c2610c47a82d 100644
>> --- a/drivers/leds/rgb/Kconfig
>> +++ b/drivers/leds/rgb/Kconfig
>> @@ -2,6 +2,12 @@
>>     if LEDS_CLASS_MULTICOLOR
>>   +config LEDS_GRP_MULTICOLOR
>> +    tristate "Multi-color LED grouping support"
>> +    help
>> +      This option enables support for monochrome LEDs that are
>> +      grouped into multicolor LEDs.
>> +
>>   config LEDS_PWM_MULTICOLOR
>>       tristate "PWM driven multi-color LED Support"
>>       depends on PWM
>> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
>> index 0675bc0f6e18..4de087ad79bc 100644
>> --- a/drivers/leds/rgb/Makefile
>> +++ b/drivers/leds/rgb/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   +obj-$(CONFIG_LEDS_GRP_MULTICOLOR)    += leds-group-multicolor.o
>>   obj-$(CONFIG_LEDS_PWM_MULTICOLOR)    += leds-pwm-multicolor.o
>>   obj-$(CONFIG_LEDS_QCOM_LPG)        += leds-qcom-lpg.o
>> diff --git a/drivers/leds/rgb/leds-group-multicolor.c 
>> b/drivers/leds/rgb/leds-group-multicolor.c
>> new file mode 100644
>> index 000000000000..61f9e1954fc4
>> --- /dev/null
>> +++ b/drivers/leds/rgb/leds-group-multicolor.c
>> @@ -0,0 +1,153 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * multi-color LED built with monochromatic LED devices
>> + *
>> + * Copyright 2022 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/leds.h>
>> +#include <linux/led-class-multicolor.h>
>> +#include <linux/math.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +
>> +struct led_mcg_priv {
>> +    struct led_classdev_mc mc_cdev;
>> +    struct led_classdev **monochromatics;
>> +};
>> +
>> +static int led_mcg_set(struct led_classdev *cdev,
>> +              enum led_brightness brightness)
>> +{
>> +    struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
>> +    struct led_mcg_priv *priv =
>> +        container_of(mc_cdev, struct led_mcg_priv, mc_cdev);
>> +    int i;
>> +
>> +    led_mc_calc_color_components(mc_cdev, brightness);
>> +
>> +    for (i = 0; i < mc_cdev->num_colors; i++) {
>> +        struct led_classdev *mono = priv->monochromatics[i];
>> +        int actual_led_brightness;
>> +
>> +        /*
>> +         * Scale the intensity according the max brightness of the
>> +         * monochromatic LED
> s/according the/according to the/
>
>> +         */
>> +        actual_led_brightness = DIV_ROUND_CLOSEST(
>> +            mono->max_brightness * mc_cdev->subled_info[i].brightness,
>> +            mc_cdev->led_cdev.max_brightness);
>
> How about dropping above usage of led_mc_calc_color_components()
> helper in favour of doing all required calculations here?
> It would be easier for the reader to grasp the idea then.

>
>> +
>> +        led_set_brightness(mono, actual_led_brightness);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int led_mcg_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct led_init_data init_data = {};
>> +    struct led_classdev *cdev;
>> +    struct mc_subled *subled;
>> +    struct led_mcg_priv *priv;
>> +    int i, count, ret;
>> +    unsigned int max_brightness;
>> +
>> +    priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    count = 0;
>> +    max_brightness = 0;
>> +    for (;;) {
>> +        struct led_classdev *led_cdev;
>> +
>> +        led_cdev = devm_of_led_get(dev, count);
>> +        if (IS_ERR(led_cdev)) {
>> +            /* Reached the end of the list ? */
>> +            if (PTR_ERR(led_cdev) == -ENOENT)
>> +                break;
>> +            return dev_err_probe(dev, PTR_ERR(led_cdev),
>> +                         "Unable to get led #%d", count);
>> +        }
>> +        count++;
>> +
>> +        priv->monochromatics = devm_krealloc(dev, priv->monochromatics,
>> +                    count * sizeof(*priv->monochromatics),
>> +                    GFP_KERNEL);
>> +        if (!priv->monochromatics)
>> +            return -ENOMEM;
>> +
>> +        priv->monochromatics[count - 1] = led_cdev;
>> +
>> +        max_brightness = max(max_brightness, led_cdev->max_brightness);
>> +    }
>> +
>> +    subled = devm_kzalloc(dev, count * sizeof(*subled), GFP_KERNEL);
>> +    if (!subled)
>> +        return -ENOMEM;
>> +    priv->mc_cdev.subled_info = subled;
>> +
>> +    for (i = 0; i < count; i++) {
>> +        struct led_classdev *led_cdev = priv->monochromatics[i];
>> +
>> +        subled[i].color_index = led_cdev->color;
>> +        /* configure the LED intensity to its maximum */
>> +        subled[i].intensity = max_brightness;
>> +    }
>> +
>> +    /* init the multicolor's LED class device */
>> +    cdev = &priv->mc_cdev.led_cdev;
>> +    cdev->flags = LED_CORE_SUSPENDRESUME;
>> +    cdev->brightness_set_blocking = led_mcg_set;
>> +    cdev->max_brightness = max_brightness;
>> +    cdev->color = LED_COLOR_ID_MULTI;
>> +    priv->mc_cdev.num_colors = count;
>> +
>> +    init_data.fwnode = dev_fwnode(dev);
>> +    ret = devm_led_classdev_multicolor_register_ext(dev, 
>> &priv->mc_cdev,
>> +                            &init_data);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret,
>> +            "failed to register multicolor led for %s.\n",
>> +            cdev->name);
>> +
>> +    ret = led_mcg_set(cdev, cdev->brightness);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret,
>> +                     "failed to set led value for %s.",
>> +                     cdev->name);
>> +
>> +    for (i = 0; i < count; i++) {
>> +        struct led_classdev *led_cdev = priv->monochromatics[i];
>> +
>> +        /* Make the sysfs of the monochromatic LED read-only */
>> +        led_cdev->flags |= LED_SYSFS_DISABLE;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id of_led_mcg_match[] = {
>> +    { .compatible = "leds-group-multicolor" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, of_led_mcg_match);
>> +
>> +static struct platform_driver led_mcg_driver = {
>> +    .probe        = led_mcg_probe,
>> +    .driver        = {
>> +        .name    = "leds_group_multicolor",
>> +        .of_match_table = of_led_mcg_match,
>> +    }
>> +};
>> +module_platform_driver(led_mcg_driver);
>> +
>> +MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
>> +MODULE_DESCRIPTION("multi-color LED group driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:leds-group-multicolor");
>
