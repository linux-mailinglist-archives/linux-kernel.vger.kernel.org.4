Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ABD620D58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiKHKeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiKHKeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:34:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0AD1A393
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:34:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l11so21775437edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tsUmXbk4TNC/4MmU7uBNzHDSvmsd/gvHqvtl9XqOUAI=;
        b=VuPrjU6CgHEVr8cZWDLWiAtOQEiLw7eStVzErc7DE/HRQdxYO3MklKO/ZwYYZQjb+V
         btQbjcHQmnyOwzXBZCSS1Kb6FQ4FXDg0hM5AxhLa0U2NApXH3pxSHalBImKVQJ65GRZI
         F2dVnqxT/qMe+qAVKg0qs6Fg0sFsaz3JRNgXadcHkmz9OhQtsxb0NfuA5lzsG334Rv2V
         qF2K22EjqiUdSRYhNtVxcgU25u2EkLHSyG/EYZ4mJfoVNXEYor+cEZu59CFx6ZKNZuX1
         NqUJCcAPsPRCfyVXU0o4AFTFVCADk2WeWocIkoBerDoFEcxMFnJiXeJQVcc1jCbZq/sB
         iXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsUmXbk4TNC/4MmU7uBNzHDSvmsd/gvHqvtl9XqOUAI=;
        b=wgS3XlUua0XXNQ86sadrVQC8QxyR71Wev6hDOgPBsYrhwhI0FJpwnfFfEzjhC9M7U7
         d+d8JtEN4uIMqSJtB5w/VEJZY9dS2DpYIEf6TIX98qfIirEbOonSff2WU1hURgyGvFju
         6P8WRB/WKyZdZUqV9AVjMDMYnNYLc+zctaNHyfjDw9rXWi9XlYSU9zZkdK8+EoQ7FQQk
         aQSrRDPx0j4jzLZMS3Abcmw+qDhpcs8sVJfoZGdkRLN646bwm6a882uM9bkBUsQ4n/E6
         Rc0oKs3h3Qp7Kdatc1e/GkSkO7hCH6nbbfGL+3IYpptr4vCcSVWEinsO72EWi+yl0uvN
         mpPw==
X-Gm-Message-State: ACrzQf3maR+rrzQLYdKQEDYriDrlZj12Wcxj7a0H552ivSHIcUEW5Qqq
        xciWHoNpaX7Vo9dT20Y+GW+Ac6adNBSaSzHzChtnBQ==
X-Google-Smtp-Source: AMsMyM6CM9EB4GkMIn4TVZFQa4ELD7L1wq9h2NlxoAuEHedbK/6RBB+xRP+Enb0V9DWuVMOhrwtG9OysjNLjhV6w1/4=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr55160795edb.46.1667903648874; Tue, 08
 Nov 2022 02:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20221026034219.172880-1-chenweilong@huawei.com>
In-Reply-To: <20221026034219.172880-1-chenweilong@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:33:57 +0100
Message-ID: <CACRpkdbfZoBsKhH-fDHbuiBMz=LuWJ5kRfRT9JupycJQLFzJZw@mail.gmail.com>
Subject: Re: [PATCH next 1/2] gpio: hisi: Add initial device tree support
To:     Weilong Chen <chenweilong@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     f.fangjian@huawei.com, yangyicong@hisilicon.com, xuwei5@huawei.com,
        robh+dt@kernel.org, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weilong,

thanks for your patch!

On Wed, Oct 26, 2022 at 5:34 AM Weilong Chen <chenweilong@huawei.com> wrote:

> Add support for HiSilicon GPIO controller in embedded platform, which
> boot from devicetree.
>
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>

I will provide OF comments, I let Andy and other ACPI experts say
what is necessary for ACPI.

(...)
> +#include <linux/acpi.h>

I don't know if this is necessary, check it.

>  #include <linux/gpio/driver.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of.h>

This is unnecessary for what you are trying to do. Drop it.

> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id hisi_gpio_acpi_match[] = {
>         {"HISI0184", 0},
>         {}
>  };
>  MODULE_DEVICE_TABLE(acpi, hisi_gpio_acpi_match);
> +#endif

Don't know about this #ifdef, check if it is needed.

> +#ifdef CONFIG_OF
> +static const struct of_device_id hisi_gpio_dts_match[] = {
> +       { .compatible = "hisilicon,gpio-ascend910", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, hisi_gpio_dts_match);
> +#endif

Drop the ifdef, it is not needed.

>  static void hisi_gpio_get_pdata(struct device *dev,
>                                 struct hisi_gpio *hisi_gpio)
> @@ -310,7 +322,8 @@ static int hisi_gpio_probe(struct platform_device *pdev)
>  static struct platform_driver hisi_gpio_driver = {
>         .driver         = {
>                 .name   = HISI_GPIO_DRIVER_NAME,
> -               .acpi_match_table = hisi_gpio_acpi_match,
> +               .acpi_match_table = ACPI_PTR(hisi_gpio_acpi_match),
> +               .of_match_table = of_match_ptr(hisi_gpio_dts_match),

Drop of_match_ptr() just assign it.

The reason it works is because we put struct of_device_id into the generic
headers so we can avoid the ifdefing.

Yours,
Linus Walleij
