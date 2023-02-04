Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47E68ACE9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjBDWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBDWcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:32:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262392387C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 14:32:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bx22so5446499pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 14:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCubKHsyMQJF8LMl1XgSOrfeBF7lBTY/RGmJLycWlaU=;
        b=G2+vuASwFpuwWTpilhz1IvtVsiUT9WhCHPg3bHDt/5F+ZoUeYQwXI0GHaH/YaKtytT
         o1acMo5Mlm9cllOyD5PirVkDAsyvv3CP6uyWR+LaTPS1ROgZi0SnUgG8oPPxwGDdvf2H
         Luf92Ex8l5lVs6qa9X7drp1/LtoiKUv6uQViswIbJn67mpOnBEQ7U8Nir6vHJjl4A/oJ
         +5ukHAB+inYG8Le10OO2jEj7EmNeHwW7lkjz8nuxXrYC+JIa5v+c8qtK+v9w+HDq7apx
         KU2y4mG6YSECFfteheftSjttr13wzYo3LIzXiFwWhQHZEs641AvyDiOb9vOPwrpjxbKw
         BE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCubKHsyMQJF8LMl1XgSOrfeBF7lBTY/RGmJLycWlaU=;
        b=uDU2UzFwoyETGV9zI0rVNn2i3NNEVj8wxSNmO0zXDVPzXndQ0ucmN6zDXNiD4orOYQ
         kCH5lCZNCWULeOYqeqwlVngkWjMgkQrTqb7L084wwFT0n1n0kObm77p5IGS7aoN+25tJ
         l6SZEmuHNv9l4fiG8XzWFOZoP0I1T65lboLj71Bt59ko8Jkax86cmMS+5NZGTFgM0sWa
         r8iuMw2+yYwNMjLyGC2oNKtzuw0i9pFUBUotn0l4wnatpdZImF/VpNTrvmMLzaLOmoL2
         vwdcqOLuVduZpDuGMQKGnRERVsVX5bmDRfhq+XHB+WfKVhNTxYyGOoEHQaBWFs3/XVb+
         b8aw==
X-Gm-Message-State: AO0yUKWwae84R+ak/DHtrnfDtVKeNOwkYvBPiuZ+lyjsKi1+KCMyeYuU
        qHWgV9Bl0i1tKyRGWHiME+OpWCUaOdImDJw2+hk6rg==
X-Google-Smtp-Source: AK7set+WTHxq5oO63yGH1Y9Xnzv5N1lAd2jXSDL3AuczoyplN2Tu7uL6IRfi3QFZwCS/cMVnCxbzD3B8jbvtM9uZpe8=
X-Received: by 2002:a17:90a:656:b0:226:cff8:6472 with SMTP id
 q22-20020a17090a065600b00226cff86472mr2232226pje.73.1675549962139; Sat, 04
 Feb 2023 14:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-5-saravanak@google.com>
 <20230130143153.67dsxn4lugfetfwb@bogus> <Y9fe2arI8afeURWn@smile.fi.intel.com>
 <CAGETcx9aPp+JU-hO+fGyGps6jaoKoFzZd2zzy5YZBKoU8G=OhA@mail.gmail.com> <20230131101337.376mnrvhltbsychd@bogus>
In-Reply-To: <20230131101337.376mnrvhltbsychd@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 4 Feb 2023 14:32:05 -0800
Message-ID: <CAGETcx9Jc1YAV49+gJWo0gFh1rxJ3nwBCw_CKYhAREBwvq5Kcw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] gpiolib: Clear the gpio_device's fwnode
 initialized flag before adding
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 2:13 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jan 30, 2023 at 08:01:17PM -0800, Saravana Kannan wrote:
> > On Mon, Jan 30, 2023 at 7:14 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Jan 30, 2023 at 02:31:53PM +0000, Sudeep Holla wrote:
> > > > On Thu, Jan 26, 2023 at 04:11:31PM -0800, Saravana Kannan wrote:
> > > > > Registering an irqdomain sets the flag for the fwnode. But having the
> > > > > flag set when a device is added is interpreted by fw_devlink to mean the
> > > > > device has already been initialized and will never probe. This prevents
> > > > > fw_devlink from creating device links with the gpio_device as a
> > > > > supplier. So, clear the flag before adding the device.
> > >
> > > ...
> > >
> > > > > +   /*
> > > > > +    * If fwnode doesn't belong to another device, it's safe to clear its
> > > > > +    * initialized flag.
> > > > > +    */
> > > > > +   if (!gdev->dev.fwnode->dev)
> > > > > +           fwnode_dev_initialized(gdev->dev.fwnode, false);
> > > >
> > > > This is the one causing the kernel crash during the boot on FVP which
> > > > Naresh has reported. Just reverted this and was able to boot, confirming
> > > > the issue with this patch.
> > >
> > > I'm wondering if
> > >
> > >         if (!dev_fwnode(&gdev->dev)->dev)
> > >                 fwnode_dev_initialized(&dev_fwnode(gdev->dev), false);
> > >
> > > works.
> >
> > No, that won't help. The problem was that with arm32, we have gpio
> > devices created without any of_node or fwnode. So I can't assume
> > fwnode will always be present.
> >
>
> Correct, and this one is not even arm32. But it is just reusing a driver
> that needs to be supported even on arm32.
>
> Not sure on how to proceed. As a simple way to check, I added a NULL check
> for fwnode building on top of Andy's suggestion[1]. That works.
>
> Also the driver in question on arm64 FVP model is drivers/mfd/vexpress-sysreg.c
> mfd_add_device() in drivers/mfd/mfd-core.c allows addition of devices without
> of_node/fwnode. I am sure returning error like[2] will break many platforms
> but I just wanted to confirm the root cause and [2] fixes the boot without
> NULL check for fwnode in gpiochip_setup_dev().
>
> Hope this helps.

Thanks for debugging it for me Sudeep. Incorporated into my v3.

-Saravana

>
> --
> Regards,
> Sudeep
>
> [1]
>
> -->8
> diff --git i/drivers/gpio/gpiolib.c w/drivers/gpio/gpiolib.c
> index b23140c6485f..e162f13aa2c9 100644
> --- i/drivers/gpio/gpiolib.c
> +++ w/drivers/gpio/gpiolib.c
> @@ -577,13 +577,15 @@ static void gpiodevice_release(struct device *dev)
>  static int gpiochip_setup_dev(struct gpio_device *gdev)
>  {
>         int ret;
> +       struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
>
>         /*
>          * If fwnode doesn't belong to another device, it's safe to clear its
>          * initialized flag.
>          */
> -       if (!gdev->dev.fwnode->dev)
> -               fwnode_dev_initialized(gdev->dev.fwnode, false);
> +       if (fwnode && !fwnode->dev)
> +               fwnode_dev_initialized(fwnode, false);
> +
>         ret = gcdev_register(gdev, gpio_devt);
>         if (ret)
>                 return ret;
>
> [2]
>
> -->8
>
> diff --git i/drivers/mfd/mfd-core.c w/drivers/mfd/mfd-core.c
> index 16d1861e9682..3b2c4b0e9a2a 100644
> --- i/drivers/mfd/mfd-core.c
> +++ w/drivers/mfd/mfd-core.c
> @@ -231,9 +231,11 @@ static int mfd_add_device(struct device *parent, int id,
>                         }
>                 }
>
> -               if (!pdev->dev.of_node)
> +               if (!pdev->dev.of_node) {
>                         pr_warn("%s: Failed to locate of_node [id: %d]\n",
>                                 cell->name, platform_id);
> +                       goto fail_alias;
> +               }
>         }
>
>         mfd_acpi_add_device(cell, pdev);
>
