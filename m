Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256768E8F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBHHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBHHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:32:41 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297083525A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:32:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 24so904651pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXFBBCpPncdgrztOsnJ7GVqNFxe6Ymd6tDDGSXOm3gU=;
        b=lyl6jJi4bJVDF01bl+567UbV2PQvho6F9xu/dI3DhQ6aNRku5SzyVKG/C1gqj0rmLs
         hfX5wGLnYlXcEm80vkzxzc47CHjo29m5cSK7g3AhmSmdk3SUO85mOy8DLSmcjUpXRCHV
         wZTafRcPVI/eB7Mg9xIO9O+F93vpSDz9ZU3ymeRdCEmxEnhniXQokjwbPpo+879O+GUK
         xGO+suct1uNbRnU3WA5A+P3r75009KfT9g5KOF5g+2JkCf0cAKrm+9pA6rfUBl5htwtA
         2BIsNJET2ksEYXM6WbP4X/5aJSHMbn0ms52LHt0iTwoWtbh0cvogVXGwQtZN9FtG8A7L
         WKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXFBBCpPncdgrztOsnJ7GVqNFxe6Ymd6tDDGSXOm3gU=;
        b=JQOZ8Lc+zMFN6G8GC3F41LoiISfIoyCKtePuwl4jZBL2lQOaUzRLbx0CKaCoLxv4HR
         x5bC68TCihhkqk/K8bRSPZRgj2VYCdrBhTaKhMughwdatbcRGq3yycrFUM3yoE6Wz27e
         DbwdtkfuEhm5pjt1vWyb5YsWrHyq64mntb5R8RP9vLyn6z+wG2Pws/C5Jdt9vYblZ1rs
         RQFueYQ9YMmay+sBg2QUD1DJfCwEKCj0GDAWJwqp/fXkWH6sHzRbRH/NUm/AQRObX3RO
         qOW6BXzKb84h+gEMOhBO9FSA0RWg9ta+J9M/VZImKuB6LmWBb7pH+/qIFhHmk60ppkh9
         4Sog==
X-Gm-Message-State: AO0yUKVQPGilKtPsvOjsaT5GKdhiNJ9x2lfnDEzozSPVZGJx7KXA9VLW
        UUk/t53sCOtXgpynLNdiCaiN+rTOoIBiE1vbYcBGcA==
X-Google-Smtp-Source: AK7set9JnoiY5b8vOKTuYDUotvS5i9rPX8uOwUdBEk0NOw6qAHea0dRzQ1Np5Ig9Ri5wH/EIdR0/zbWH7NAVw7rsSxo=
X-Received: by 2002:a62:403:0:b0:57e:78ee:9ed8 with SMTP id
 3-20020a620403000000b0057e78ee9ed8mr1538300pfe.47.1675841553922; Tue, 07 Feb
 2023 23:32:33 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230207014207.1678715-10-saravanak@google.com> <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
 <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com>
In-Reply-To: <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Feb 2023 23:31:57 -0800
Message-ID: <CAGETcx_bkuFaLCiPrAWCPQz+w79ccDp6=9e881qmK=vx3hBMyg@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] of: property: Simplify of_link_to_phandle()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:08 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Feb 7, 2023 at 12:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Saravana,
> >
> > On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > > The driver core now:
> > > - Has the parent device of a supplier pick up the consumers if the
> > >   supplier never has a device created for it.
> > > - Ignores a supplier if the supplier has no parent device and will never
> > >   be probed by a driver
> > >
> > > And already prevents creating a device link with the consumer as a
> > > supplier of a parent.
> > >
> > > So, we no longer need to find the "compatible" node of the supplier or
> > > do any other checks in of_link_to_phandle(). We simply need to make sure
> > > that the supplier is available in DT.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch!
> >
> > This patch introduces a regression when dynamically loading DT overlays.
> > Unfortunately this happens when using the out-of-tree OF configfs,
> > which is not supported upstream.  Still, there may be (obscure)
> > in-tree users.
> >
> > When loading a DT overlay[1] to enable an SPI controller, and
> > instantiate a connected SPI EEPROM:
> >
> >     $ overlay add 25lc040
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /keys/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-0
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-names
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/cs-gpios
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /__symbols__/msiof0_pins
> >
> > The SPI controller and the SPI EEPROM are no longer instantiated.
> >
> >     # cat /sys/kernel/debug/devices_deferred
> >     e6e90000.spi    platform: wait for supplier msiof0
> >
> > Let's remove the overlay again:
> >
> >     $ overlay rm 25lc040
> >     input: keys as /devices/platform/keys/input/input1
> >
> > And retry:
> >
> >     $ overlay add 25lc040
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /keys/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-0
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-names
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/cs-gpios
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /__symbols__/msiof0_pins
> >     spi_sh_msiof e6e90000.spi: DMA available
> >     spi_sh_msiof e6e90000.spi: registered master spi0
> >     spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
> >     at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
> >     spi_sh_msiof e6e90000.spi: registered child spi0.0
> >
> > Now it succeeds, and the SPI EEPROM is available, and works.
> >
> > Without this patch, or with this patch reverted after applying the
> > full series:
> >
> >     $ overlay add 25lc040
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /keys/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-0
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/pinctrl-names
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/cs-gpios
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /soc/spi@e6e90000/status
> >     OF: overlay: WARNING: memory leak will occur if overlay removed,
> > property: /__symbols__/msiof0_pins
> >     OF: Not linking spi@e6e90000 to interrupt-controller@f1010000 - No
> > struct device
> >     spi_sh_msiof e6e90000.spi: DMA available
> >     spi_sh_msiof e6e90000.spi: registered master spi0
> >     spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
> >     at25 spi0.0: 444 bps (2 bytes in 9 ticks)
> >     at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
> >     spi_sh_msiof e6e90000.spi: registered child spi0.0
> >
> > The SPI EEPROM is available on the first try after boot.
>
> Sigh... I spent way too long trying to figure out if I caused a memory
> leak. I should have scrolled down further! Doesn't look like that part
> is related to anything I did.
>
> There are some flags set to avoid re-parsing fwnodes multiple times.
> My guess is that the issue you are seeing has to do with how many of
> the in memory structs are reused vs not when an overlay is
> applied/removed and some of these flags might not be getting cleared
> and this is having a bigger impact with this patch (because the fwnode
> links are no longer anchored on "compatible" nodes).
>
> With/without this patch (let's keep the series) can you look at how
> the following things change between each step you do above (add,
> remove, retry):
> 1) List of directories under /sys/class/devlink
> 2) Enable the debug logs inside __fwnode_link_add(),
> __fwnode_link_del(), device_link_add()
>
> My guess is that the final solution would entail clearing
> FWNODE_FLAG_LINKS_ADDED for some fwnodes.

You replied just as I was about to hit send. So sending this anyway...

Ok, I took a closer look and I think it's a bit of a mess. The fact
that it even worked for you without this patch is a bit of a
coincidence.

Let's just take platform devices that are created by
driver/of/platform.c as an example.

The main problem is that when you add/remove properties to a DT node
of an existing platform device, nothing is really done about it at the
device level. We don't even unbind and rebind the driver so the driver
could make use of the new properties. We don't remove and add back the
device so whoever might use the new property will use it. And if you
are adding a new node, it'll only trigger any platform device level
impact if it's a new node of a "simple-bus" (or similar bus) device.

Problem 1:
So if you add a new child node to an existing probed device that adds
its children explicitly (as in, the parent is not a "simple-bus" like
device), nothing will happen. The newly added child device node will
get converted into a platform device, not will the parent device
notice it. So in your case of adding msiof0_pins, it's just that when
the consumer gets the pins, the driver doesn't get involved much and
it's the pinctrl framework that reads the DT and figures it out.

With this patch, the fwnode links point to the actual resource and the
actual parent device inherits them if they don't get converted to a
struct device. But since we are adding this msiof0_pins after the
parent device has probed, the fwnode link isn't inherited by the
parent pinctrl device.

Problem 2:
So if you add a property to an already bound device, nothing is done
by the driver. In your overlay example, if you move the status="okay"
line to be the first property you change in the msiof0 spi device,
you'll probably see that fw_devlink is no longer the one blocking the
probe. This is because the platform device will get added as soon as
the status flips from disabled to enabled and at that point fw_devlink
will think it has no suppliers and won't do any probe deferring. And
then as the new properties get added nothing will happen at the device
or fw_devlink level. If the msiof0's spi driver fails immediately with
NOT -EPROBE_DEFER when platform device is added because it couldn't
find any pinctrl property, then msiof0 will never probe (unless you
remove and add the driver). If it had failed with -EPROBE_DEFER, then
it might probe again if something else triggers a deferred probe
attempt. Clearly, things working/not working based on the order of
properties in DT is not a good implementation.

Problem 3:
What if you enable a previously disabled supplier. There's no way to
handle that from a fw_devlink level without re-parsing the entire
device tree because existing devices might be consumers now.

Anyway, long story short, it's sorta worked due to coincidence and
it's quite messy to get it to work correctly.

Another way to get this to work is to:
1) unload pinctrl driver, unload spi driver.
2) apply overlay
3) reload pinctrl driver, reload spi driver.

This is assuming unloading those 2 drivers doesn't crash your system.

In terms of difficult + inefficiency of solving the problems, the
easiest/efficient to hardest/inefficient would be problem 1, 2 and
then 3. I'll think about them, but it's broken anyway without the
series/patch. The only real guarantee as of today is that we aren't
leaking any memory or corrupting anything.

-Saravana
