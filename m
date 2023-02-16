Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0B698B07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBPDMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBPDMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:12:23 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C9410B6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:12:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id s203so670016ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6Qh8gzOowZwynkUDIeTrWbdl9HaKmQIH+IY+oQdDQU=;
        b=GxTRfbOsOkLv43UR0CUz7x1DiDyiTVJvIdGXeffaF8FFQkvbj9D0x+wQE5kOHkRmSa
         o5Ze293BSs4uqy1H1gqCW5XGhgDkX37RsbQ7x0aWqWlmMcdaJUs+BGyiplS9rxwrqXiv
         K6bKMbWPfIUUmKofh3l39j9SUiIfd1cXN9dxpgAsz4qKncGv3ycwCt+kUEETE074rAuo
         D+c72FaIo9XCNvkZw7tPOlfU/eTZJCgkzA/o8HErGsataZ/yZEuoJeygab6+mNSkonm7
         I9+PbCjImVYosZjQsUHQKITYEhXY1hO5y3dKwogaHLW6tVRgprrNxpzAG070BcL/9jFJ
         kkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6Qh8gzOowZwynkUDIeTrWbdl9HaKmQIH+IY+oQdDQU=;
        b=vMbC8t52s3IdzeJaiv6T6aNb3hNU94hWcUJ0JLmaVHaMj07N/gpiieBGJ2upY8Gop0
         o1vEjYeCuOusKTTd5JkiN7hvZYU4Xe5fhrEejOWjlI5UezKVqjHCDmUbIWGEZ8pTesc5
         BhE6bXqkHba/G/OSPS3GgwqFkEM8uuF4dDb+cuCTMzjd3U3o9pr298AlId3HdHR/HlkA
         fImRwp/Z/f/bRbp+k2VPXfAOjAGecTJ1aEtMZ124neVw1jC8ZlIIyDTXJj0rZ4ZY/+kF
         H+sZxjnUxV73atoTyXQWLcXUHWtsMECh+jmltxBL63lbigjji8o8Nln6/fMvA1OFy27v
         DgKQ==
X-Gm-Message-State: AO0yUKUMog/vT63UCy0E4+7yhql2skiITOTJYJgFPdbKhmNxM4CopzDG
        QNsYPhWV+3OxxKTDHoZ2gViLfiF1MztZ3xM4VjpVbA==
X-Google-Smtp-Source: AK7set+6eIj7MPs4FgpkrHNNRtmcV0fLlWPPAZXRVRf0yyJfRs4rZclaJlYKoRf3mhlsfkcIPq9+D/6ElO/HE/qRcIw=
X-Received: by 2002:a25:f50c:0:b0:90a:8ba9:3ac3 with SMTP id
 a12-20020a25f50c000000b0090a8ba93ac3mr511192ybe.333.1676517140908; Wed, 15
 Feb 2023 19:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Feb 2023 05:12:09 +0200
Message-ID: <CAA8EJprMMh3udsKKwtGJW9kBLfMv=_OXFnnPGobK=dK-raX5ew@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 03:41, Saravana Kannan wrote:
> Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> Jean-Philippe,
>
> Can I get your Tested-by's for this v3 series please?
>
> Vladimir,
>
> Ccing you because DSA's and fw_devlink have known/existing problems
> (still in my TODOs to fix). But I want to make sure this series doesn't
> cause additional problems for DSA.
>
> All,
>
> This patch series improves fw_devlink in the following ways:
>
> 1. It no longer cares about a fwnode having a "compatible" property. It
>     figures this out more dynamically. The only expectation is that
>     fwnodes that are converted to devices actually get probed by a driver
>     for the dependencies to be enforced correctly.
>
> 2. Finer grained dependency tracking. fw_devlink will now create device
>     links from the consumer to the actual resource's device (if it has one,
>     Eg: gpio_device) instead of the parent supplier device. This improves
>     things like async suspend/resume ordering, potentially remove the need
>     for frameworks to create device links, more parallelized async probing,
>     and better sync_state() tracking.
>
> 3. Handle hardware/software quirks where a child firmware node gets
>     populated as a device before its parent firmware node AND actually
>     supplies a non-optional resource to the parent firmware node's
>     device.
>
> 4. Way more robust at cycle handling (see patch for the insane cases).
>
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
>
> 6. Simplifies the work that needs to be done by the firmware specific
>     code.
>
> The v3 series has gone through my usual testing on my end and looks good
> to me.

Saravana,

Please excuse me, I was completely overwhelmed with my regular work and
had no time to properly test the series, while doing just the light
test would defeat the purpose of testing.

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # Qualcomm RB3

Thanks a lot for going through all the troubles and hunting all the issues!

Just a note: on an RB3 device (arm64 qcom/sdm845-db845c.dtsi) extended
with the patch at [3] I got the following messages in dmesg:

[    1.051325] platform ae00000.mdss: Failed to create device link
with ae00000.mdss
[    1.059368] platform ae00000.mdss: Failed to create device link
with ae00000.mdss
[    1.067174] platform ae00000.mdss: Failed to create device link
with ae00000.mdss
[    1.088322] platform c440000.spmi: Failed to create device link
with c440000.spmi
[    1.096019] platform c440000.spmi: Failed to create device link
with c440000.spmi
[    1.103707] platform c440000.spmi: Failed to create device link
with c440000.spmi
[    1.111400] platform c440000.spmi: Failed to create device link
with c440000.spmi
[    1.119141] platform c440000.spmi: Failed to create device link
with c440000.spmi
[    1.126825] platform c440000.spmi: Failed to create device link
with c440000.spmi
[    2.024763] qcom-lab-ibb-regulator c440000.spmi:pmic@3:labibb:
Failed to create device link with c440000.spmi
[    2.035026] qcom-lab-ibb-regulator c440000.spmi:pmic@3:labibb:
Failed to create device link with c440000.spmi

They look to be harmless, but it might be good to filter some of them
out? Especially the ones which tell about creating a device link
pointing back to the same device.

[3] https://lore.kernel.org/linux-arm-msm/20230118082048.2198715-1-dmitry.baryshkov@linaro.org/

>
> Thanks,
> Saravana
>
> [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
> [2] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com/
>
> v1 -> v2:
> - Fixed Patch 1 to handle a corner case discussed in [2].
> - New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
> - New patch 11 to add fw_devlink support for SCMI devices.
>
> v2 -> v3:
> - Addressed most of Andy's comments in v2
> - Added Colin and Sudeep's Tested-by for the series (except the imx and
>    renesas patches)
> - Added Sudeep's Acked-by for the scmi patch.
> - Added Geert's Reviewed-by for the renesas patch.
> - Fixed gpiolib crash reported by Naresh.
> - Patch 6: Fix __fwnode_links_move_consumers() to preserve fwnode link flags.
> - New Patch 12 to fix nvmem-cells issue reported by Maxim(s)/Miquel.
> - Deleted some stale function doc in Patch 8
>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Maxim Kiselev <bigunclemax@gmail.com>
> Cc: Maxim Kochetkov <fido_max@inbox.ru>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: Colin Foster <colin.foster@in-advantage.com>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Cc: Jean-Philippe Brucker <jpb@kernel.org>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Saravana Kannan (12):
>    driver core: fw_devlink: Don't purge child fwnode's consumer links
>    driver core: fw_devlink: Improve check for fwnode with no
>      device/driver
>    soc: renesas: Move away from using OF_POPULATED for fw_devlink
>    gpiolib: Clear the gpio_device's fwnode initialized flag before adding
>    driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
>    driver core: fw_devlink: Allow marking a fwnode link as being part of
>      a cycle
>    driver core: fw_devlink: Consolidate device link flag computation
>    driver core: fw_devlink: Make cycle detection more robust
>    of: property: Simplify of_link_to_phandle()
>    irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
>    firmware: arm_scmi: Set fwnode for the scmi_device
>    mtd: mtdpart: Don't create platform device that'll never probe
>
>   drivers/base/core.c             | 449 +++++++++++++++++++++-----------
>   drivers/firmware/arm_scmi/bus.c |   3 +-
>   drivers/gpio/gpiolib.c          |   7 +
>   drivers/irqchip/irq-imx-gpcv2.c |   1 +
>   drivers/mtd/mtdpart.c           |  10 +
>   drivers/of/property.c           |  84 +-----
>   drivers/soc/imx/gpcv2.c         |   2 +-
>   drivers/soc/renesas/rcar-sysc.c |   2 +-
>   include/linux/device.h          |   1 +
>   include/linux/fwnode.h          |  12 +-
>   10 files changed, 344 insertions(+), 227 deletions(-)
>

--
With best wishes

Dmitry
