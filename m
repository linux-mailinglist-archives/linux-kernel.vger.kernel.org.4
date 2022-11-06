Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED2661E27A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKFN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKFN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:58:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5837D630D;
        Sun,  6 Nov 2022 05:58:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a67so13838465edf.12;
        Sun, 06 Nov 2022 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTWv8Arpvhk+VLNvjiohfLLFMW1gdUFZvUNXxvts/P4=;
        b=fLZWYaPs3BvKAMSnliZpz8SCMlAxLVAt0qRaQFn7Veqy637jbTTimpKW+oeC9HnBMk
         4yk+vSLB3gRkM8Ap64ZiuHPfpAGwlMbRJRIQX9ve6HxlUJ9naOkJlemR39Zqco1Jy3DL
         5M3SzSpVWtan25TtB6tdBzb58kQh++5b8aDqnzLE7rsEGaqmnybF2SPzucmaOvD/PfzE
         qi4NarNKH64ebh6eDvaIvqcS7Wv4UmOsaZEOWiQhznE5HEqrSUnWIXWFRQZl+aM1pNDo
         ImPWOO0vfyPuO9/EfYAPmLZaZZL1q2Q3maMEW4sCwchj3RH2HZP4F0NkdsROZnSLQDre
         l7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTWv8Arpvhk+VLNvjiohfLLFMW1gdUFZvUNXxvts/P4=;
        b=wl7v1t4Bu1DSL2yytQKFPPQ47vFxtqgfFq/L9ahRyhLe8QBXkOiTYzMXsPsVHKNJDg
         07nih1wP9ci8ePlR19DVyVQa5Lt0F/ZmkdEYFEOf1sGbAcUINah9NmzYXuJ2nR1BmOZ4
         g5r3x0SM2Jwb+V7f8lg5wHYB7cuHE68GzXj0vJJCcMQ7OxVXpEQ6hRRr6AbdN38KHPV6
         OkB+49XJoFoAfRVUZ264d8XHBaW5QeNB4+U9F7wZZ5eEvBkihIjPe/y6vsO5Kut5JiiS
         DelFaqlM0TAHizyDz6duT1qjlCoSjNDwOHYbevpKlJAh1Qbi+thdnODUzXSetsoaAPId
         A64g==
X-Gm-Message-State: ACrzQf1ZwIb7YRksZoFwRmo4K6JIzVyCY8/P6ml3ATUHhbAnZIccnZnJ
        tjuFU3uv3hod56e9VS/bExQ=
X-Google-Smtp-Source: AMsMyM40H2rY3rMrCtAOedxUz5U7Vh/Tl/zMTEFk2kQG3BLvYaGYUyg4eNktKI/PH/bQRLkWkJ+Mkg==
X-Received: by 2002:aa7:d44b:0:b0:464:2fa2:3359 with SMTP id q11-20020aa7d44b000000b004642fa23359mr18272772edr.409.1667743081807;
        Sun, 06 Nov 2022 05:58:01 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm2169089eje.61.2022.11.06.05.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 05:58:00 -0800 (PST)
Message-ID: <1ca5fc04-f16b-f98a-0373-c61c258aa8bd@gmail.com>
Date:   Sun, 6 Nov 2022 14:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, marijn.suijten@somainline.org,
        bjorn.andersson@linaro.org, andy.shevchenko@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028170308.2676734-1-jjhiblot@traphandler.com>
 <20221028170308.2676734-7-jjhiblot@traphandler.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20221028170308.2676734-7-jjhiblot@traphandler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 10/28/22 19:03, Jean-Jacques Hiblot wrote:
> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>   drivers/leds/rgb/Kconfig                 |  10 ++
>   drivers/leds/rgb/Makefile                |   1 +
>   drivers/leds/rgb/leds-group-multicolor.c | 154 +++++++++++++++++++++++
>   3 files changed, 165 insertions(+)
>   create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 204cf470beae..1a87f53faa8a 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -2,6 +2,16 @@
>   
[...]
> +
> +	for (i = 0; i < count; i++) {
> +		struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +		/* Make the sysfs of the monochromatic LED read-only */
> +		led_cdev->flags |= LED_SYSFS_DISABLE;

Clearing these on remove is needed as well.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_led_mcg_match[] = {
> +	{ .compatible = "leds-group-multicolor" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_led_mcg_match);
> +
> +static struct platform_driver led_mcg_driver = {
> +	.probe		= led_mcg_probe,
> +	.driver		= {
> +		.name	= "leds_group_multicolor",
> +		.of_match_table = of_led_mcg_match,
> +	}
> +};
> +module_platform_driver(led_mcg_driver);
> +
> +MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
> +MODULE_DESCRIPTION("multi-color LED group driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:leds-group-multicolor");

-- 
Best regards,
Jacek Anaszewski
