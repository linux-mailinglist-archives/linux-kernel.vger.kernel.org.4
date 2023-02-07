Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B95068D2AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBGJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjBGJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:23:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF236684
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:23:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gr7so41497886ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I70HhxHLsI2HHGcZI04fStNVNeSuevhKRqsln0/FI/A=;
        b=yrMGmfrMG5RKmVutlzGybx2TOoPNybxgeoFTGv81EX+SrqeMxTBh6j1swNcISVyw+p
         AgxQ+dFKkqs4M+u7dP5WPvcw6t/6BiMCzK+bOyEBzFiotz/5L2G3eEMdJFEYX4+4bwpJ
         Z0MRw+rSaCVL7tO3EKomyzEQp/H7CkFnKCW7+mzsAR0ABkwjVvW9n6FRXkKWS8OtlSVW
         0GnttzP+aRl1UBX6dKSXSyf58HWn/JgZXGprVJzROGcIll13KS+KQKtI+car/sh4sQk3
         i7b90CA7JynTrQkutLlEKl4SxpFEHmuY9HM0fTBVmDHIJUDDQFwDmwPsvnJidHbLmfFO
         CVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I70HhxHLsI2HHGcZI04fStNVNeSuevhKRqsln0/FI/A=;
        b=nd38aduuO84xRSamxtI00AxAshO5QUbaThIMZ+atIMEvApdG6JBeElaJ4YFkOYuI3e
         QN9oxHOc599QfU4+nLnO6pP/C7Auq5h5AmeQzgC07MuZJSgfSQYYmQ3LrWhWBsdzIn+f
         2bdsYY2kBZaS4sfh8yhe+1BTU+7YF5V5qCvGPD8uubxFfol93aFU3aqA9ZJFQV5DWkNf
         SpXeIqYz6jVRNDVllCv42nTFjcOsHDg5kptUXbvmvZl88LbVXjJfJg1Iv/N93Jyd2Y43
         eTy8hrLPRf7LnyzXFGbD9sNd+HBStgBj1cd/Okse20I57umZDGLy6urPayBIu1lGb3tL
         SX2Q==
X-Gm-Message-State: AO0yUKUygIlz7qYIUW2X60B3OUXJibLpFtB4Jmd48LplXCOixnWOj9h6
        R8/bUy4+Hm8SmSc1gBYUk0gB2g==
X-Google-Smtp-Source: AK7set/4jc5ZZLArDJD4G8kQ0dT4ezIRyv/eZI/G0ee7KmVpY7u9jRJrKjLsy6MxGRs020d764r0jA==
X-Received: by 2002:a17:906:448c:b0:88a:4a22:dd5 with SMTP id y12-20020a170906448c00b0088a4a220dd5mr2585928ejo.23.1675761787520;
        Tue, 07 Feb 2023 01:23:07 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b00882f9130eafsm6599467ejb.26.2023.02.07.01.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 01:23:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Feb 2023 10:23:06 +0100
Message-Id: <CQC7Z4ZMDRKJ.3UUSZY1495PEQ@otso>
Cc:     "Abel Vesa" <abel.vesa@linaro.org>,
        "Alexander Stein" <alexander.stein@ew.tq-group.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "John Stultz" <jstultz@google.com>,
        "Doug Anderson" <dianders@chromium.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Maxim Kiselev" <bigunclemax@gmail.com>,
        "Maxim Kochetkov" <fido_max@inbox.ru>,
        "Colin Foster" <colin.foster@in-advantage.com>,
        "Martin Kepplinger" <martin.kepplinger@puri.sm>,
        "Jean-Philippe Brucker" <jpb@kernel.org>,
        "Vladimir Oltean" <vladimir.oltean@nxp.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Saravana Kannan" <saravanak@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Cristian Marussi" <cristian.marussi@arm.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Daniel Scally" <djrscally@gmail.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Len Brown" <lenb@kernel.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
X-Mailer: aerc 0.14.0
References: <20230207014207.1678715-1-saravanak@google.com>
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 7, 2023 at 2:41 AM CET, Saravana Kannan wrote:
> Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> Jean-Philippe,
>
> Can I get your Tested-by's for this v3 series please?

Hi Saravana,

Seems to be alright on the same platform where it broke previously.

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcom/sm7225-fairphone-fp=
4

Regards
Luca

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
>    figures this out more dynamically. The only expectation is that
>    fwnodes that are converted to devices actually get probed by a driver
>    for the dependencies to be enforced correctly.
>
> 2. Finer grained dependency tracking. fw_devlink will now create device
>    links from the consumer to the actual resource's device (if it has one=
,
>    Eg: gpio_device) instead of the parent supplier device. This improves
>    things like async suspend/resume ordering, potentially remove the need
>    for frameworks to create device links, more parallelized async probing=
,
>    and better sync_state() tracking.
>
> 3. Handle hardware/software quirks where a child firmware node gets
>    populated as a device before its parent firmware node AND actually
>    supplies a non-optional resource to the parent firmware node's
>    device.
>
> 4. Way more robust at cycle handling (see patch for the insane cases).
>
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
>
> 6. Simplifies the work that needs to be done by the firmware specific
>    code.
>
> The v3 series has gone through my usual testing on my end and looks good
> to me.
>
> Thanks,
> Saravana
>
> [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@goog=
le.com/
> [2] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=3DMre5j_vkV=
mZojeiumUGG6QZQ@mail.gmail.com/
>
> v1 -> v2:
> - Fixed Patch 1 to handle a corner case discussed in [2].
> - New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 drivers.
> - New patch 11 to add fw_devlink support for SCMI devices.
>
> v2 -> v3:
> - Addressed most of Andy's comments in v2
> - Added Colin and Sudeep's Tested-by for the series (except the imx and
>   renesas patches)
> - Added Sudeep's Acked-by for the scmi patch.
> - Added Geert's Reviewed-by for the renesas patch.
> - Fixed gpiolib crash reported by Naresh.
> - Patch 6: Fix __fwnode_links_move_consumers() to preserve fwnode link fl=
ags.
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
>   driver core: fw_devlink: Don't purge child fwnode's consumer links
>   driver core: fw_devlink: Improve check for fwnode with no
>     device/driver
>   soc: renesas: Move away from using OF_POPULATED for fw_devlink
>   gpiolib: Clear the gpio_device's fwnode initialized flag before adding
>   driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
>   driver core: fw_devlink: Allow marking a fwnode link as being part of
>     a cycle
>   driver core: fw_devlink: Consolidate device link flag computation
>   driver core: fw_devlink: Make cycle detection more robust
>   of: property: Simplify of_link_to_phandle()
>   irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
>   firmware: arm_scmi: Set fwnode for the scmi_device
>   mtd: mtdpart: Don't create platform device that'll never probe
>
>  drivers/base/core.c             | 449 +++++++++++++++++++++-----------
>  drivers/firmware/arm_scmi/bus.c |   3 +-
>  drivers/gpio/gpiolib.c          |   7 +
>  drivers/irqchip/irq-imx-gpcv2.c |   1 +
>  drivers/mtd/mtdpart.c           |  10 +
>  drivers/of/property.c           |  84 +-----
>  drivers/soc/imx/gpcv2.c         |   2 +-
>  drivers/soc/renesas/rcar-sysc.c |   2 +-
>  include/linux/device.h          |   1 +
>  include/linux/fwnode.h          |  12 +-
>  10 files changed, 344 insertions(+), 227 deletions(-)
>
> --=20
> 2.39.1.519.gcb327c4b5f-goog

