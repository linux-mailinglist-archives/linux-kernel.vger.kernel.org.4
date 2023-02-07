Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B668DFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBGSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjBGSQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:16:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5833C2BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:16:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y132so444633pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSunKu0hLdrmmtMcDNirilKAS0IN5i8wmev5sy3ww80=;
        b=nvNPBcDWqczrDtDdaJnqEcy2bXszbCVB+iZ0wLX8oaRwsf3sXbqfSUOu97NQd2q7zW
         MDNljr0XVnF2+uZvx3f4KsnMy2mBE22lT81PLIrrCrPw6pf9IxRWBGNIM+7ZPUDenS37
         r3yNOS833xnbCFK+fNJdp+omgjAV/pkWLlnB36P67UzHo+YH2BC2V6V7kSyhhmoQwyHw
         X4t6mt5O/DvFIxDy6rqqKU5+ejg45CNxD5Boi2nvCvkR0/hQC4FmoyOMKs1ktH7Linsg
         dNdiMLGSRe9bvte8NReis1E6hbme5BErHRptgoOljcu38q/j0LNmIdZ+uwakmYRdohE2
         sIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSunKu0hLdrmmtMcDNirilKAS0IN5i8wmev5sy3ww80=;
        b=mPujvj5RbWne1auHfTrHsy813qyTkMXqPT4UsquryLhzcKEHaOiZ7IClvZij0tm5IJ
         LYmKP7Wf5WH/1Z8GWp5BFXBCyJxRWGRR9hVXhpAhEVyJfx58Ro+GgfpEijd5nBoBT/mk
         CRV4B23sd8LP47ODtNEYAWgB/DXZ8UxVa3acWbQ7nBqnsctvd7JB3SkviEmQsPoBVD1C
         FTU7pP93yeN8tOsmF5vSzMWYS4hYOY6V2eHT1GP8KSMSmTHWZRlGj4MZbZE4Qxiu20OJ
         yUiag9EbueeYr3uszr9VeEH7JZd0b5sb/vKP2khGCzgz2Q2W0TsqQP92/0BaO8N8SvAy
         1u3g==
X-Gm-Message-State: AO0yUKWtxBecFKobHojHrJB9Ou/uGjGs5HQquDsqUKigI37XhgUGeYPD
        29VrLqAlrfx4eQ8WkJszAi88OdNY5Wwl+HD2B94Uig==
X-Google-Smtp-Source: AK7set/f6jDh9v+hpyOrJmlr/KCCnwgwcKVGWTVlFNv1/9ietkEewF439YsxUFJFF9c2MR40I0uXbhZpovcGBYrSnRQ=
X-Received: by 2002:a63:7f12:0:b0:479:45df:425e with SMTP id
 a18-20020a637f12000000b0047945df425emr772888pgd.116.1675793769045; Tue, 07
 Feb 2023 10:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com> <CAD=FV=UZxz-nHNsPO1P_W0MHFD8UDTvKXpFm1dSB+53NJaP2=w@mail.gmail.com>
In-Reply-To: <CAD=FV=UZxz-nHNsPO1P_W0MHFD8UDTvKXpFm1dSB+53NJaP2=w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Feb 2023 10:15:32 -0800
Message-ID: <CAGETcx86PsZ96CGwvzx7-jvsv=jOFkuPz-K-zjkUXQ3M=yc4zA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
To:     Doug Anderson <dianders@chromium.org>
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
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

On Tue, Feb 7, 2023 at 7:28 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 6, 2023 at 5:42 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> > Jean-Philippe,
> >
> > Can I get your Tested-by's for this v3 series please?
> >
> > Vladimir,
> >
> > Ccing you because DSA's and fw_devlink have known/existing problems
> > (still in my TODOs to fix). But I want to make sure this series doesn't
> > cause additional problems for DSA.
> >
> > All,
> >
> > This patch series improves fw_devlink in the following ways:
> >
> > 1. It no longer cares about a fwnode having a "compatible" property. It
> >    figures this out more dynamically. The only expectation is that
> >    fwnodes that are converted to devices actually get probed by a driver
> >    for the dependencies to be enforced correctly.
> >
> > 2. Finer grained dependency tracking. fw_devlink will now create device
> >    links from the consumer to the actual resource's device (if it has one,
> >    Eg: gpio_device) instead of the parent supplier device. This improves
> >    things like async suspend/resume ordering, potentially remove the need
> >    for frameworks to create device links, more parallelized async probing,
> >    and better sync_state() tracking.
> >
> > 3. Handle hardware/software quirks where a child firmware node gets
> >    populated as a device before its parent firmware node AND actually
> >    supplies a non-optional resource to the parent firmware node's
> >    device.
> >
> > 4. Way more robust at cycle handling (see patch for the insane cases).
> >
> > 5. Stops depending on OF_POPULATED to figure out some corner cases.
> >
> > 6. Simplifies the work that needs to be done by the firmware specific
> >    code.
> >
> > The v3 series has gone through my usual testing on my end and looks good
> > to me.
> >
> > Thanks,
> > Saravana
> >
> > [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
> > [2] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com/
> >
> > v1 -> v2:
> > - Fixed Patch 1 to handle a corner case discussed in [2].
> > - New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
> > - New patch 11 to add fw_devlink support for SCMI devices.
> >
> > v2 -> v3:
> > - Addressed most of Andy's comments in v2
> > - Added Colin and Sudeep's Tested-by for the series (except the imx and
> >   renesas patches)
> > - Added Sudeep's Acked-by for the scmi patch.
> > - Added Geert's Reviewed-by for the renesas patch.
> > - Fixed gpiolib crash reported by Naresh.
> > - Patch 6: Fix __fwnode_links_move_consumers() to preserve fwnode link flags.
> > - New Patch 12 to fix nvmem-cells issue reported by Maxim(s)/Miquel.
> > - Deleted some stale function doc in Patch 8
> >
> > Cc: Abel Vesa <abel.vesa@linaro.org>
> > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Cc: Maxim Kiselev <bigunclemax@gmail.com>
> > Cc: Maxim Kochetkov <fido_max@inbox.ru>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Luca Weiss <luca.weiss@fairphone.com>
> > Cc: Colin Foster <colin.foster@in-advantage.com>
> > Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Cc: Jean-Philippe Brucker <jpb@kernel.org>
> > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > Saravana Kannan (12):
> >   driver core: fw_devlink: Don't purge child fwnode's consumer links
> >   driver core: fw_devlink: Improve check for fwnode with no
> >     device/driver
> >   soc: renesas: Move away from using OF_POPULATED for fw_devlink
> >   gpiolib: Clear the gpio_device's fwnode initialized flag before adding
> >   driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
> >   driver core: fw_devlink: Allow marking a fwnode link as being part of
> >     a cycle
> >   driver core: fw_devlink: Consolidate device link flag computation
> >   driver core: fw_devlink: Make cycle detection more robust
> >   of: property: Simplify of_link_to_phandle()
> >   irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
> >   firmware: arm_scmi: Set fwnode for the scmi_device
> >   mtd: mtdpart: Don't create platform device that'll never probe
>
> I tested the whole series together on several devices. I tried to test
> on a wide variety since previous versions had broken due to all the
> dependency cycles in the display and some of these devices used
> different components in their display pipeline. I didn't do massive
> testing but did confirm that basic devices came up, including display.
>
> Devices tested with your v3 applied atop v6.2-rc7-11-g05ecb680708a:
>
> * sc7180-trogdor-lazor (with ps8640 bridge), which had failed to bring
> up the display on v2.
>
> * sc7180-trogdor-lazor (with sn65dsi86 bridge)
>
> * sc7180-trogdor-pazquel (with sn65dsi86 bridge)
>
> * sc7180-trogdor-homestar (with ps8640 bridge)
>
> * sc7180-trogdor-wormdingler
>
> * sc7280-herobrine-villager
>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Thanks a lot for all this testing and helping me debug the ps8640 issue Doug!

-Saravana
