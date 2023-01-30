Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6ED680D25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbjA3MKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjA3MJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:09:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6F2ED76;
        Mon, 30 Jan 2023 04:09:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw12so15172776ejc.2;
        Mon, 30 Jan 2023 04:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+as/cFVge0lJVrdDwvrgX/iEPP8hvHeAoqRiQ2luvqw=;
        b=lXbASWkrHwlsiD9uw5IITnuKL50JIEJe4Ld4TV/D5s5bbMGUVaqHlnStjmu3W+Lhbp
         XZQVz4hO61nQ1QzPHPef4YZwOGT8VJfl8MryBxizWDZQAT2ciEJomDlyEkq1DP8LHU3b
         74KyqXy5JtNyyKKFHfkn3TXCB+74zw5BgSdCbkH820JL4Qck17/fOmPTCQpojocy1369
         KcJnDkQXncfvHiNazSd/9u14j8MisJP0kkKVIU+v0ubml/vT4kFZ8wfWGSh5oLrngHZR
         svxsKrS3rH7ex2Aj+aDWgU2w2gxxBACWUAtEq3/JGOgxPsQLEHEIL5RxCWxt6BmLugvF
         mTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+as/cFVge0lJVrdDwvrgX/iEPP8hvHeAoqRiQ2luvqw=;
        b=mNsneBDf5E3clsRBw91Cb7AdoQR6mAomkQEvl/Kj+DVzQdmfQCA2nydiO+Un1KoPwq
         IfH+uskDTJ0ED+mHpxOzHXEWOGJiRWppYjBWONJ5ZzG7CfT8nlvHfQhkFhRp+mT8wKdG
         Obf2fQF+LApd7bybPSZgBTNHyZsINpe93l9q+hlK2T0BeLggzoTNeBswjjndhSATAHJN
         xmq3wwWFvgpIgkLs6Xb34MfBE5JDWYJ/YpBYvZ7M9Voo2uOlzkq1raOiOnXCBTNWnmb6
         SUKwjAeoETR4eqOtmdU0n9yMblm6mRtAj8Lp/acWQPGGFccufHA9tluBomWLJSqHOA9c
         +wNw==
X-Gm-Message-State: AO0yUKU17NnoYcboI/zw37i9LkJM4cBuKjsVq7zdCQ8aGYB55J9ZGT1L
        f7QAcV+peDABECViKxiRjarDv8PIqEOykzAR0P4=
X-Google-Smtp-Source: AK7set/xCTH/vbtxcDVedmbu+GvEkhEjIPKNV3pppkvrTOnKrqxjz0H3YmENdtx4XbIc/2vKUX5PUwjXu7VZ2Zx5cmI=
X-Received: by 2002:a17:906:4e0e:b0:88a:9e08:330f with SMTP id
 z14-20020a1709064e0e00b0088a9e08330fmr270154eju.3.1675080538756; Mon, 30 Jan
 2023 04:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230130114839.379f08bd@xps-13>
In-Reply-To: <20230130114839.379f08bd@xps-13>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Mon, 30 Jan 2023 15:08:46 +0300
Message-ID: <CALHCpMimX63NC2P=mYdqOv339P06B4iAd10L2NpC5ALy_207vA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Saravana Kannan <saravanak@google.com>,
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
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana & Miquel.

Sorry for the long response. I finally got access to my test device
and tried this patch series.

And unfortunately it didn't solve my issue. I'm still getting a
hanging f1070000.ethernet dependency
from the nvmem-cell mac@6 subnode.

Here are related parts of my kernel log and device tree:


    [    2.713302] device: 'mtd-0': device_add
    [    2.719528] device: 'spi0': device_add
    [    2.724180] device: 'spi0.0': device_add
    [    2.728957] spi-nor spi0.0: mx66l51235f (65536 Kbytes)
    [    2.735338] 7 fixed-partitions partitions found on MTD device spi0.0
    [    2.741978] device:
'f1010600.spi:m25p80@0:partitions:partition@1': device_add
    [    2.749636] Creating 7 MTD partitions on "spi0.0":
    [    2.754564] 0x000000000000-0x000000080000 : "SPI.U_BOOT"
    [    2.759981] device: 'mtd0': device_add
    [    2.764323] device: 'mtd0': device_add
    [    2.768280] device: 'mtd0ro': device_add
    [    2.772624] 0x0000000a0000-0x0000000c0000 : "SPI.INV_INFO"
    [    2.778218] device: 'mtd1': device_add
    [    2.782549] device: 'mtd1': device_add
    [    2.786582] device: 'mtd1ro': device_add
    ...
    [    5.426625] mvneta_bm f10c0000.bm: Buffer Manager for network
controller enabled
    [    5.492867] platform f1070000.ethernet: error -EPROBE_DEFER:
wait for supplier mac@6
    [    5.528636] device: 'Fixed MDIO bus.0': device_add
    [    5.533726] device: 'fixed-0': device_add
    [    5.547564] device: 'f1072004.mdio-eth-mii': device_add
    [    5.616368] device: 'f1072004.mdio-eth-mii:00': device_add
    [    5.645127] device: 'f1072004.mdio-eth-mii:1e': device_add
    [    5.651530] devices_kset: Moving f1070000.ethernet to end of list
    [    5.657948] platform f1070000.ethernet: error -EPROBE_DEFER:
wait for supplier mac@6

    spi@10600 {
        m25p80@0 {
            compatible =3D "mx66l51235l";

            partitions {
                compatible =3D "fixed-partitions";

                partition@0 {
                    label =3D "SPI.U_BOOT";
                };
                partition@1 {
                    compatible =3D "nvmem-cells";
                    label =3D "SPI.INV_INFO";
                    macaddr: mac@6 {
                        reg =3D <0x6 0x6>;
                    };
                };
                ...
            };
        };
    };

    enet1: ethernet@70000 {
        nvmem-cells =3D <&macaddr>;
        nvmem-cell-names =3D "mac-address";
        phy-mode =3D "rgmii";
        phy =3D <&phy0>;
    };


Maybe I should provide some additional debug info?

=D0=BF=D0=BD, 30 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 13:48, Miquel Rayn=
al <miquel.raynal@bootlin.com>:
>
> Hi Maxim & Maxim,
>
> saravanak@google.com wrote on Thu, 26 Jan 2023 16:11:27 -0800:
>
> > This patch series improves fw_devlink in the following ways:
> >
> > 1. It no longer cares about a fwnode having a "compatible" property. It
> >    figures this our more dynamically. The only expectation is that
> >    fwnode that are converted to devices actually get probed by a driver
> >    for the dependencies to be enforced correctly.
> >
> > 2. Finer grained dependency tracking. fw_devlink will now create device
> >    links from the consumer to the actual resource's device (if it has o=
ne,
> >    Eg: gpio_device) instead of the parent supplier device. This improve=
s
> >    things like async suspend/resume ordering, potentially remove the ne=
ed
> >    for frameworks to create device links, more parallelized async probi=
ng,
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
> > Sorry it took a while to roll in the fixes I gave in the v1 series
> > thread[1] into a v2 series.
> >
> > Since I didn't make any additional changes on top of what I already gav=
e
> > in the v1 thread and Dmitry is very eager to get this series going, I'm
> > sending it out without testing locally. I already tested these patches =
a
> > few months ago as part of the v1 series. So I don't expect any major
> > issues. I'll test them again on my end in the next few days and will
> > report here if I actually find anything wrong.
> >
> > Tony, Naresh, Abel, Sudeep, Geert,
> >
> > I got the following reviewed by's and tested by's a few months back, bu=
t
> > it's been 5 months since I sent out v1. So I wasn't sure if it was okay
> > to include them in the v2 commits. Let me know if you are okay with thi=
s
> > being included in the commits and/or if you want to test this series
> > again.
> >
> > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Tested-by: Abel Vesa <abel.vesa@linaro.org>
> > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Dmitry, Maxim(s), Miquel, Luca, Doug, Colin, Martin, Jean-Philippe,
> >
> > I've Cc-ed you because I had pointed you to v1 of this series + the
> > patches in that thread at one point or another as a fix to some issue
> > you were facing. It'd appreciate it if you can test this series and
> > report any issues, or things it fixed and give Tested-bys.
>
> Maxim & Maxim I would really appreciate if you could validate that the
> original issue you had is solved with this version? I don't have any
> hardware suffering from this issue.
>
> > In addition, if you can also apply a revert of this series[2] and delet=
e
> > driver_deferred_probe_check_state() from your tree and see if you hit
> > any issues and report them, that'd be great too! I'm pretty sure some o=
f
> > you will hit issues with that. I want to fix those next and then
> > revert[2].
> >
> > Thanks,
> > Saravana
> >
> > [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@go=
ogle.com/
> > [2] - https://lore.kernel.org/lkml/20220819221616.2107893-1-saravanak@g=
oogle.com/
> > [3] - https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=3DMre5j_v=
kVmZojeiumUGG6QZQ@mail.gmail.com/
> >
> > v1 -> v2:
> > - Fixed Patch 1 to handle a corner case discussed in [3].
> > - New patch 10 to handle "fsl,imx8mq-gpc" being initialized by 2 driver=
s.
> > - New patch 11 to add fw_devlink support for SCMI devices.
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
> >
> > Saravana Kannan (11):
> >   driver core: fw_devlink: Don't purge child fwnode's consumer links
> >   driver core: fw_devlink: Improve check for fwnode with no
> >     device/driver
> >   soc: renesas: Move away from using OF_POPULATED for fw_devlink
> >   gpiolib: Clear the gpio_device's fwnode initialized flag before addin=
g
> >   driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
> >   driver core: fw_devlink: Allow marking a fwnode link as being part of
> >     a cycle
> >   driver core: fw_devlink: Consolidate device link flag computation
> >   driver core: fw_devlink: Make cycle detection more robust
> >   of: property: Simplify of_link_to_phandle()
> >   irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
> >   firmware: arm_scmi: Set fwnode for the scmi_device
> >
> >  drivers/base/core.c             | 443 +++++++++++++++++++++-----------
> >  drivers/firmware/arm_scmi/bus.c |   2 +
> >  drivers/gpio/gpiolib.c          |   6 +
> >  drivers/irqchip/irq-imx-gpcv2.c |   1 +
> >  drivers/of/property.c           |  84 +-----
> >  drivers/soc/imx/gpcv2.c         |   1 +
> >  drivers/soc/renesas/rcar-sysc.c |   2 +-
> >  include/linux/device.h          |   1 +
> >  include/linux/fwnode.h          |  12 +-
> >  9 files changed, 332 insertions(+), 220 deletions(-)
> >
>
>
> Thanks,
> Miqu=C3=A8l
