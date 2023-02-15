Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D7697BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjBOMfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjBOMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:34:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AB038641;
        Wed, 15 Feb 2023 04:34:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6377161B9F;
        Wed, 15 Feb 2023 12:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EADC433EF;
        Wed, 15 Feb 2023 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676464478;
        bh=UdB5gcZ1ipRdvMF/VYd7e+V0Gy9qLJujvD96WZvS0NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCpoOc8iHx3XcRwBSD1ZDGP40QOJqNIxZTP+CRuJvEBLFgtOvJHb1BxmmVQVfcWPz
         DPq298F9sCKiTeahJyumwLmhzWr9yLHuVSt/Mq5h78veRLGCdNRsAQHf5/jlKiUChd
         8no4Zb0DtNaYMe8Larvl6+gOzcfXADoQV3n31OpI37s4NQZPPzZ76+mFaeI75IShx0
         fBSKmCTTMHdUu/uG4tD/KLRby5vMvJ7nwVoO2+s1CTjifo3P032eI5Pd6K3fCrMyho
         +7hgd9oQhxO2zo08wGaCj5FxGS2syXQflakHSPJ4CtIOHS5c3xxNQmN6SuEQblgliV
         KrB2+yr/wTnhQ==
Date:   Wed, 15 Feb 2023 12:34:30 +0000
From:   Jean-Philippe Brucker <jpb@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
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
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
Message-ID: <Y+zRVsyZ2iJlrM8u@myrica>
References: <20230207014207.1678715-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Mon, Feb 06, 2023 at 05:41:52PM -0800, Saravana Kannan wrote:
> Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> Jean-Philippe,
> 
> Can I get your Tested-by's for this v3 series please?

Sorry for the delay (I misconfigured my inbox). I tested virtio-iommu with
these changes, no regression:

Tested-by: Jean-Philippe Brucker <jpb@kernel.org>


Removing driver_deferred_probe_check_state() by reverting [1] breaks
loading virtio-iommu as a module, as the dependency between PCI devices
and PCI IOMMU is ignored, and the device probed too early [2]. I'll try to
figure out how to make that work.

Thanks,
Jean

[1] https://lore.kernel.org/lkml/20220819221616.2107893-5-saravanak@google.com/
[2] https://lore.kernel.org/lkml/Yv+dpeIPvde7oDHi@myrica/
