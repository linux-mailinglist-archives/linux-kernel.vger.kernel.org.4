Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A55E5D91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIVIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:35:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062F3A145
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:35:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y8so12466331edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9k5XZsKEuVg+w97GW3NVqqtdvOIwwsJ0tLsuQ7fHq8E=;
        b=FJ6r/HguZTeXEn2iM6s0wY+O49nKDExlr9X65U39yFCpAszdozjll8AsP0HXCfOYfk
         3kNrRDSna3185ik/ihUdiYyEeZ/iiFE1/Zss4EfQEWuaJjbf74pQO4rJ6Ow8OH/tjdxb
         KRgwJTsDqowN2AJMYTv0a4BM3wF4t8Oo1iADeGRe54Iaq4yX1ZmIc6VcrAM90PL51vO3
         tXYU0mr/LyQnfoylMtgrdiTAJAqELB/GszHadpd6e75RlrPhA2meuSid8ckYg9i0dYTf
         WBTQp9OATvFv5ckTye7qGmBmz+usPaz8gSstzHin3+pQ5OisN/cFohZ0GSTYXOMrAbtc
         TRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9k5XZsKEuVg+w97GW3NVqqtdvOIwwsJ0tLsuQ7fHq8E=;
        b=S1F/lcvSABP4B4UHwtICAfeqIWh1W38a2k3ikVooROLmAHDKOYSNN7ChyxhZpi66X4
         qIA7D0WXWfCOnFN6Ow+LKguk/Ro/gBqUC09xXOBshbOsCVtdbcO8YvYG9Qmv/halETGh
         v49znmmiOIWRVYCNbZdHz/IazRZ3XlznVt7LV2oAg0+ymH4vBl10SlnMKggBZrhZ4eu7
         Gmmt4k2w3+b2eYNrlTSiGFqQjGCMZhDPK9rRA12AfWRV42TbIXuR9q46ElRv2XqoctSU
         N9YdlBVlv5BTKMAgXOsp7zo3pInc1vZyVshkAIp2OnUHHvci+WyWdbcI9jvsEYZB8ehK
         clGQ==
X-Gm-Message-State: ACrzQf1pAuYbOYwOVoIuO3KQEETB9lNqkGgRWmslruArxulYC90iG0GI
        M41an8+R0BqPE1rzWmHAwy6QKTj8uLTKmvGhj9k5lg==
X-Google-Smtp-Source: AMsMyM5Om/uY7TZ7Zkqo5JBiny2QBL7GKG4E5XX0XdXuPjTvM3Go95ggGcKvQj/ljg41n1A8wVB6KfT+jfAQZ2h1IK0=
X-Received: by 2002:aa7:dd02:0:b0:44e:f7af:b996 with SMTP id
 i2-20020aa7dd02000000b0044ef7afb996mr2116386edv.422.1663835701030; Thu, 22
 Sep 2022 01:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220831134516.78108-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdQiBHr3cDPWN_PRj2nGVoG-GJJyRNrHNwTaAUvz=35ew@mail.gmail.com>
 <2022090109473952058033@rock-chips.com> <CAMRc=McXoBqm-SBJTWdULZGep98V5-z3O9Dygkd07H=Z2k0-HA@mail.gmail.com>
 <2022090115251208267537@rock-chips.com>
In-Reply-To: <2022090115251208267537@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 22 Sep 2022 10:34:49 +0200
Message-ID: <CAMRc=MdZVG8PC3_SmRYn54zTx-x_UfUxnRzhsLEaYEzDS=VjRA@mail.gmail.com>
Subject: Re: Re: [PATCH v2 1/1] gpio: rockchip: Switch to use fwnode instead
 of of_node
To:     "jay.xu@rock-chips.com" <jay.xu@rock-chips.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:25 AM jay.xu@rock-chips.com
<jay.xu@rock-chips.com> wrote:
>
> Hi Bart
>
> --------------
> jay.xu@rock-chips.com
> >On Thu, Sep 1, 2022 at 3:47 AM jay.xu@rock-chips.com
> ><jay.xu@rock-chips.com> wrote:
> >>
> >> Hi
> >>
> >> --------------
> >> jay.xu@rock-chips.com
> >> >On Wed, Aug 31, 2022 at 3:45 PM Andy Shevchenko
> >> ><andriy.shevchenko@linux.intel.com> wrote:
> >> >>
> >> >> GPIO library now accepts fwnode as a firmware node, so
> >> >> switch the driver to use it.
> >> >>
> >> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> >> ---
> >> >> v2: fixed compilation errors (LKP), replace some OF calls (Bart)
> >> >>  drivers/gpio/gpio-rockchip.c       | 38 +++++++++++-------------------
> >> >>  drivers/pinctrl/pinctrl-rockchip.h |  2 --
> >> >>  2 files changed, 14 insertions(+), 26 deletions(-)
> >> >>
> >> >> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> >> >> index bb50335239ac..e8fa99fd4c80 100644
> >> >> --- a/drivers/gpio/gpio-rockchip.c
> >> >> +++ b/drivers/gpio/gpio-rockchip.c
> >> >> @@ -14,12 +14,11 @@
> >> >>  #include <linux/init.h>
> >> >>  #include <linux/interrupt.h>
> >> >>  #include <linux/io.h>
> >> >> +#include <linux/mod_devicetable.h>
> >> >>  #include <linux/module.h>
> >> >>  #include <linux/of.h>
> >> >> -#include <linux/of_address.h>
> >> >> -#include <linux/of_device.h>
> >> >> -#include <linux/of_irq.h>
> >> >>  #include <linux/pinctrl/pinconf-generic.h>
> >> >> +#include <linux/property.h>
> >> >>  #include <linux/regmap.h>
> >> >>
> >> >>  #include "../pinctrl/core.h"
> >> >> @@ -518,7 +517,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
> >> >>         struct irq_chip_generic *gc;
> >> >>         int ret;
> >> >>
> >> >> -       bank->domain = irq_domain_add_linear(bank->of_node, 32,
> >> >> +       bank->domain = irq_domain_create_linear(dev_fwnode(bank->dev), 32,
> >> >>                                         &irq_generic_chip_ops, NULL);
> >> >>         if (!bank->domain) {
> >> >>                 dev_warn(bank->dev, "could not init irq domain for bank %s\n",
> >> >> @@ -606,14 +605,10 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
> >> >>          * files which don't set the "gpio-ranges" property or systems that
> >> >>          * utilize ACPI the driver has to call gpiochip_add_pin_range().
> >> >>          */
> >> >> -       if (!of_property_read_bool(bank->of_node, "gpio-ranges")) {
> >> >> -               struct device_node *pctlnp = of_get_parent(bank->of_node);
> >> >> +       if (!device_property_read_bool(bank->dev, "gpio-ranges")) {
> >> >>                 struct pinctrl_dev *pctldev = NULL;
> >> >>
> >> >> -               if (!pctlnp)
> >> >> -                       return -ENODATA;
> >> >> -
> >> >> -               pctldev = of_pinctrl_get(pctlnp);
> >> >> +               pctldev = pinctrl_get(bank->dev->parent);
> >> >>                 if (!pctldev)
> >> >>                         return -ENODEV;
> >> >>
> >> >> @@ -641,23 +636,20 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
> >> >>
> >> >>  static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
> >> >>  {
> >> >> +       struct platform_device *pdev = to_platform_device(bank->dev);
> >> >> +       struct device_node *np = bank->dev->of_node;
> >> >>         struct resource res;
> >> >>         int id = 0;
> >> >>
> >> >> -       if (of_address_to_resource(bank->of_node, 0, &res)) {
> >> >> -               dev_err(bank->dev, "cannot find IO resource for bank\n");
> >> >> -               return -ENOENT;
> >> >> -       }
> >> >> -
> >> >> -       bank->reg_base = devm_ioremap_resource(bank->dev, &res);
> >> >> +       bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
> >> >>         if (IS_ERR(bank->reg_base))
> >> >>                 return PTR_ERR(bank->reg_base);
> >> >>
> >> >> -       bank->irq = irq_of_parse_and_map(bank->of_node, 0);
> >> >> +       bank->irq = platform_get_irq(pdev, 0);
> >> >>         if (!bank->irq)
> >> >>                 return -EINVAL;
> >> >>
> >> >> -       bank->clk = of_clk_get(bank->of_node, 0);
> >> >> +       bank->clk = of_clk_get(np, 0);
> >> >
> >> >Why did you stop above? Why not regular clk_get here?
> >> >
> >> >>         if (IS_ERR(bank->clk))
> >> >>                 return PTR_ERR(bank->clk);
> >> >>
> >> >> @@ -668,7 +660,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
> >> >>         if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
> >> >>                 bank->gpio_regs = &gpio_regs_v2;
> >> >>                 bank->gpio_type = GPIO_TYPE_V2;
> >> >> -               bank->db_clk = of_clk_get(bank->of_node, 1);
> >> >> +               bank->db_clk = of_clk_get(np, 1);
> >> >
> >> >Ah, the clocks don't have names in DT? That's unfortunate...
> >>
> >> The patch add 'clock-names' property for gpio dt node, after that, the driver can change to
> >> devm_clk_get(dev, "bus");
> >> devm_clk_get(dev, "db");
> >>
> >
> >We can't unfortunately, we need to remain compatible with existing DTs.
> >
> As said in the patch comment, the 'clock-names' is not 'required' since existing DTs
> Do the driver can try get by id first and then do a second try with legency way without id ?
>
> or other suggestion ?
>

No, it sounds good to me.

Bart
