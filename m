Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5A60581B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJTHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJTHNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF34160204;
        Thu, 20 Oct 2022 00:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 266A761A30;
        Thu, 20 Oct 2022 07:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6806C433D6;
        Thu, 20 Oct 2022 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666249983;
        bh=DWD/+a3tWspqd9R6eZBRIia+z4497qxbwbDyZj76oLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMsAEFVD9WkedPvZ+l9oQhe6aKnlJ5QLEE/RAQL9Hdcc42aiZpvKQTxC305JfTGC7
         HIiBFiyvAsNadm37u8Hfx9NL0Nj1ovVYawfZFWjT1jHyBqLcaoEzE81tld4QRTQcRq
         1sNrMwbOaEFU4cFBzyCu2yq8+QF/+T8uUuezBvAaVCLvMo+hQZNXbbrO5Bt1qnKPOA
         g4FpFI4xvJ0seaFCmivcPDcVBVicUidY1B3W/JQo0AkYB93UbthGLj9zxp5tjjv3bX
         WHNv0zjG+ItGUccu+GqbSLjLpERRSZOjraiWPPAD9FrnYnJaB7fbLDBRWdnEJDSzbh
         r1FvJA9rT3QGg==
Date:   Thu, 20 Oct 2022 08:12:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        stern@rowland.harvard.edu, alexandre.belloni@bootlin.com,
        brgl@bgdev.pl, damien.lemoal@opensource.wdc.com,
        dmitry.torokhov@gmail.com, linux@dominikbrodowski.net,
        balbi@kernel.org, gregkh@linuxfoundation.org, deller@gmx.de,
        perex@perex.cz, jingoohan1@gmail.com, kernel@wantstofly.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        marek.vasut@gmail.com, broonie@kernel.org,
        mkpetch@internode.on.net, miquel.raynal@bootlin.com,
        lost.distance@yahoo.com, philipp.zabel@gmail.com,
        linux@armlinux.org.uk, sre@kernel.org, slapin@ossfans.org,
        s.shtylyov@omp.ru, sudipm.mukherjee@gmail.com, tiwai@suse.com,
        ulf.hansson@linaro.org, vigneshr@ti.com, viresh.kumar@linaro.org,
        wsa+renesas@sang-engineering.com, linux-pm@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, patches@opensource.cirrus.com,
        linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/30] ARM: pxa: remove all unused boards&drivers
Message-ID: <Y1D08tpbdE52x7hN@google.com>
References: <20221019161831.3864786-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019161831.3864786-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most of the legacy PXA board files were marked as unused in linux-5.19 and
> can get removed in linux-6.2. There is support for pxa250/pxa270/pxa300
> using devicetree already, which supports a number of boards, but progress
> on converting the remaining ones has stalled over the past few years.
> 
> The two boards that are left in the tree for now are the three 'sharpsl'
> variants (spitz/akita/borzoi) and the 'gumstix' family of machines.
> Both of these are supported by qemu, which can be helpful for completing
> the DT conversion.
> 
> Only PXA25x and PXA27x are left with full boardfile support, so PXA300
> can get a lot simpler while still working with DT, and PXA310/320/93x
> can be removed entirely.
> 
> A good number of drivers become impossible to select after this, so
> each of these also get dropped. I'm including the driver patches in the
> series here and can either merge them through the soc tree, or they
> can get picked up by the individual subsystem maintainers. Since both
> the platform and the drivers get removed, the order should not matter.
> 
> Note that the patches here are generated with 'git format-patch -D'
> and don't contain the contents of removed files because of the
> significant size (the first patch is close to a megabyte).
> 
> Arnd Bergmann (30):
>   ARM: pxa: remove unused board files
>   ARM: pxa: remove irda leftover
>   ARM: pxa: remove unused pxa3xx-ulpi
>   ARM: pxa: drop pxa310/pxa320/pxa93x support
>   ARM: pxa: prune unused device support
>   power: remove z2_battery driver
>   power: remove tosa_battery driver
>   ata: remove palmld pata driver
>   backlight: remove pxa tosa support
>   input: remove pxa930_trkball driver
>   input: remove pxa930_rotary keyboard driver
>   input: remove zylonite touchscreen driver
>   pcmcia: remove unused pxa/sa1100 drivers
>   ASoC: pxa: remove unused board support
>   ALSA: remove ac97 bus support
>   mfd: remove wm97xx driver
>   input: remove wm97xx support
>   parport: remove ax88796 driver
>   power: remove pda_power supply driver
>   rtc: remove v3020 driver
>   mfd: remove toshiba tmio drivers
>   mfd: remove ucb1400 support
>   mtd: remove tmio_nand driver
>   mmc: remove tmio_mmc driver
>   fbdev: remove tmiofb driver
>   fbdev: remove w100fb driver
>   leds: remove asic3 driver
>   usb: remove ohci-tmio driver
>   w1: remove ds1wm driver
>   mfd: remove htc-pasic3 driver

Are you sure these went out?

They do not appear to be in my inbox, nor lore.

-- 
Lee Jones [李琼斯]
