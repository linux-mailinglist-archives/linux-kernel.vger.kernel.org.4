Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DECF68E5D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBHCIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBHCIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:08:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA49836452
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:08:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n2so9143802pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 18:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IvovDvydwtbWeac/PH7UfSyXwAMSyNiyFbqoOtJrtSo=;
        b=WWQxHI+zVjB3sxN2VS2B69gLrKIkQgRtwbALikURfje+mgHB872p8xbeWLvH+p4IFZ
         X8+gzwTrp4f8Iqv+GOVcMboqkGmpV6XCzVLsKb9tI8vHAtFYOS65xE0nK8FBo0FvHUS5
         kLCUDHNKjZU2PG9fwT6xT2AwoqJ15mXjo0mYl13Pu+SA1WyKavCbdHx6PD5lqKGJ3wgC
         7D6vVEqjeNTVTG6hQTP9QF8j56x8iWlfej2t9hwMElA86EjAiIpjOpRcB/lD6PasKIrh
         kmZBeQKHwLAIUuLiEJoB0YPmfi5gj6Y7jc62lRAFUchW6NHbfHNbRvovubDoqex0T+1v
         lH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvovDvydwtbWeac/PH7UfSyXwAMSyNiyFbqoOtJrtSo=;
        b=DKMWoP8gOmdn9hRcbQyr3dhYVZApVCdBY3g96V7TAA75/dTBLpm8FHxbzpTzlcuNrA
         doJr2MVf8vE/BvTSO7sAlGvz37WMa8Nd0H4QLnvJVjS96UPUbxvVFJeHodI2eRvZjqeg
         DwtXNeSnsP/gt47t9qJP7dK3AcLYbh8Y1WtYvIesm3d6IVjGW5UsEwGYQqldPm1/qUTA
         lmUBK7mdzidyHLEHgKt13c7ACnMGn5bg8oIasJ9R3gG15/VMNH/qa+j6zH02Xca8OlTw
         0vr+XinjDCFXXFSjaJDDrfjvjKggDKn6CMIAP3kiriRcP/0cwMhCmb+1riybS25xcy6S
         g4wQ==
X-Gm-Message-State: AO0yUKWjoJQiRYqD+eSHfEt+J2/7qpPv9/itX9mHwhgjqWmNjN+4YpOu
        F/E29NaavbDr8bokdQyPUB4ATSsHQ5FKYFMMgWz4/w==
X-Google-Smtp-Source: AK7set/Bb7BMdpe4sUnoHifR4lQMHdn9y6L/o7MBzyuPCkiBgdepa4Ke551WLY6JkSSLbKcR1vDbHA3Fx/XWThsP5c0=
X-Received: by 2002:a63:7f1d:0:b0:4de:7028:d2fc with SMTP id
 a29-20020a637f1d000000b004de7028d2fcmr1133917pgd.122.1675822116756; Tue, 07
 Feb 2023 18:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
 <20230207014207.1678715-10-saravanak@google.com> <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
In-Reply-To: <CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Feb 2023 18:08:00 -0800
Message-ID: <CAGETcx8DaZqS7+47PhX4hQOfSk7AzPcTu=2i+4gAgXr6wyDNgg@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 12:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > The driver core now:
> > - Has the parent device of a supplier pick up the consumers if the
> >   supplier never has a device created for it.
> > - Ignores a supplier if the supplier has no parent device and will never
> >   be probed by a driver
> >
> > And already prevents creating a device link with the consumer as a
> > supplier of a parent.
> >
> > So, we no longer need to find the "compatible" node of the supplier or
> > do any other checks in of_link_to_phandle(). We simply need to make sure
> > that the supplier is available in DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> This patch introduces a regression when dynamically loading DT overlays.
> Unfortunately this happens when using the out-of-tree OF configfs,
> which is not supported upstream.  Still, there may be (obscure)
> in-tree users.
>
> When loading a DT overlay[1] to enable an SPI controller, and
> instantiate a connected SPI EEPROM:
>
>     $ overlay add 25lc040
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /keys/status
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/pinctrl-0
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/pinctrl-names
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/cs-gpios
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/status
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /__symbols__/msiof0_pins
>
> The SPI controller and the SPI EEPROM are no longer instantiated.
>
>     # cat /sys/kernel/debug/devices_deferred
>     e6e90000.spi    platform: wait for supplier msiof0
>
> Let's remove the overlay again:
>
>     $ overlay rm 25lc040
>     input: keys as /devices/platform/keys/input/input1
>
> And retry:
>
>     $ overlay add 25lc040
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /keys/status
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/pinctrl-0
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/pinctrl-names
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/cs-gpios
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/status
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /__symbols__/msiof0_pins
>     spi_sh_msiof e6e90000.spi: DMA available
>     spi_sh_msiof e6e90000.spi: registered master spi0
>     spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
>     at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
>     spi_sh_msiof e6e90000.spi: registered child spi0.0
>
> Now it succeeds, and the SPI EEPROM is available, and works.
>
> Without this patch, or with this patch reverted after applying the
> full series:
>
>     $ overlay add 25lc040
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /keys/status
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/pinctrl-0
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/pinctrl-names
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/cs-gpios
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /soc/spi@e6e90000/status
>     OF: overlay: WARNING: memory leak will occur if overlay removed,
> property: /__symbols__/msiof0_pins
>     OF: Not linking spi@e6e90000 to interrupt-controller@f1010000 - No
> struct device
>     spi_sh_msiof e6e90000.spi: DMA available
>     spi_sh_msiof e6e90000.spi: registered master spi0
>     spi spi0.0: setup mode 0, 8 bits/w, 100000 Hz max --> 0
>     at25 spi0.0: 444 bps (2 bytes in 9 ticks)
>     at25 spi0.0: 512 Byte at25 eeprom, pagesize 16
>     spi_sh_msiof e6e90000.spi: registered child spi0.0
>
> The SPI EEPROM is available on the first try after boot.

Sigh... I spent way too long trying to figure out if I caused a memory
leak. I should have scrolled down further! Doesn't look like that part
is related to anything I did.

There are some flags set to avoid re-parsing fwnodes multiple times.
My guess is that the issue you are seeing has to do with how many of
the in memory structs are reused vs not when an overlay is
applied/removed and some of these flags might not be getting cleared
and this is having a bigger impact with this patch (because the fwnode
links are no longer anchored on "compatible" nodes).

With/without this patch (let's keep the series) can you look at how
the following things change between each step you do above (add,
remove, retry):
1) List of directories under /sys/class/devlink
2) Enable the debug logs inside __fwnode_link_add(),
__fwnode_link_del(), device_link_add()

My guess is that the final solution would entail clearing
FWNODE_FLAG_LINKS_ADDED for some fwnodes.

Thanks,
Saravana
