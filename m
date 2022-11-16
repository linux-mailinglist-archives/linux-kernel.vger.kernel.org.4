Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60062C059
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiKPOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiKPOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB70209AE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:57:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8944E61E1C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0582C433C1;
        Wed, 16 Nov 2022 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668607029;
        bh=icU4I7RIgRLNY1cWYT1aruWSL+8MqM+CeYHqkxj7G4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfcdaHIoG5bad1XTgqtegKoMoni3gJ7rGv0tAdPMtGnmpeFXcdmD95qMfH0WVHlIv
         2dL/Yn+4DdsISc9XdDN8loUYubDD4IYeHGwvB/gOoGgEW+8FYaOwAf4m8kFFsrNWoq
         lib7U6lPDPNE+YkVP2EJJs7dpT++WsUSD9WXJsfU//6Eijw5SIoKjrXtPxI+BOnwAh
         +u2UP1CrpYQsM+iNXtOgvfO9Y4NCP06dR20DqflU49xk0LpmqOSX2RD4LCkILfTonu
         Ju7zqNJbta95pi4ejC+XhnmPESECVhFZ7VKy93eD+Vd1dWvQRQ5X7lHqydydBCMNPu
         tj2RHppy2+jHA==
Date:   Wed, 16 Nov 2022 13:57:04 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
Message-ID: <Y3TsMDpphLYAIrf1@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
 <Y1/sUfeVy1a6EKZQ@google.com>
 <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
 <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
 <Y2jKRQ8VyauSfXmH@google.com>
 <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
 <CAL_JsqKoJimmbk5KoAs2yetrW4ONDy6-QMvvFdNdHH+HP6rk=w@mail.gmail.com>
 <c4ae5530acef6b737c2a6a12e4c25aa91b47d077.camel@nxp.com>
 <CAL_JsqKiKgQ31gjihWs5HR_Bc7j=D7-QDn=jhoy6E5mnMSk-kA@mail.gmail.com>
 <de9c49d33e4a90863e309190a27cd46bef47df07.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de9c49d33e4a90863e309190a27cd46bef47df07.camel@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022, Liu Ying wrote:

> On Tue, 2022-11-15 at 07:33 -0600, Rob Herring wrote:
> > On Mon, Nov 14, 2022 at 11:22 PM Liu Ying <victor.liu@nxp.com> wrote:
> > > On Mon, 2022-11-14 at 14:54 -0600, Rob Herring wrote:
> > > > On Mon, Nov 7, 2022 at 9:58 PM Liu Ying <victor.liu@nxp.com> wrote:
> > > > > Hi Lee,
> > > > > 
> > > > > On Mon, 2022-11-07 at 09:05 +0000, Lee Jones wrote:
> > > > > > On Wed, 02 Nov 2022, Liu Ying wrote:
> > > > > > 
> > > > > > > Hi Lee,
> > > > > > > 
> > > > > > > On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > > > > > > > Hi Lee,
> > > > > > > > 
> > > > > > > > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > > > > > > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > > > > > > > 
> > 
> > [...]
> > 
> > > > > > > > > > +     ret = devm_of_platform_populate(&pdev->dev);
> > > > > > > > > 
> > > > > > > > > The use of this API does not constitute a MFD.
> > > > > > > > > 
> > > > > > > > > Please use "simple-mfd" instead.
> > > > > > > > 
> > > > > > > > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > > > > > > > simple-pm-bus driver would not populate child devices of simple-mfd
> > > > > > > > devices.
> > > > > > 
> > > > > > Right, simple-pm-bus will not populate child devices, because:
> > > > > 
> > > > > simple-pm-bus.c may populate child devices of simple-pm-bus devices
> > > > > because "ONLY_BUS" is _not_ set for simple-pm-bus devices.
> > > > > 
> > > > > simple-pm-bus.c would _not_ populate child devices of simple-mfd
> > > > > devices because "ONLY_BUS" is set for simple-mfd devices.
> > > > > 
> > > > > >   /*
> > > > > >    * These are transparent bus devices (not simple-pm-bus matches) that
> > > > > >    * have their child nodes populated automatically.  So, don't need to
> > > > > >    * do anything more. We only match with the device if this driver is
> > > > > >    * the most specific match because we don't want to incorrectly bind to
> > > > > >    * a device that has a more specific driver.
> > > > > >    */
> > > > > > 
> > > > > > So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.
> > > > > 
> > > > > If simple-mfd device is a child device of one device listed in
> > > > > of_default_bus_match_table[], then it may be populated by
> > > > > drivers/of/platform.c.  But, in my case, simple-mfd device is a child
> > > > > device of simple-pm-bus device(not listed in that table), so it will
> > > > > not be populated by drivers/of/platform.c.  Instead,
> > > > > drivers/bus/simple-pm-bus.c would populate the simple-mfd device.
> > > > > 
> > > > > > > > Also, the simple-pm-bus driver would not enable runtime
> > > > > > > > power management for simple-mfd devices due to "ONLY_BUS", which
> > > > > > > > means it would not propagate power management operations from child
> > > > > > > > devices of simple-mfd devices to parent devices of simple-mfd
> > > > > > > > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed.
> > > > > > 
> > > > > > This is more of an issue.
> > > > > > 
> > > > > > Why can't this device use "simple-pm-bus" to have support for both
> > > > > > auto-registration AND Runtime PM?
> > > > > 
> > > > > If I change the compatible string of the CSR module from
> > > > > "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd"
> > > > > to
> > > > > "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-pm-bus",
> > > > > all devices I'm interested in are populated and all relevant drivers
> > > > > can probe.  But, this change makes 'make dt_binding_check' for the
> > > > > existing fsl,imx8qxp-csr.yaml fail:
> > > > 
> > > > As 'simple-bus' is for MMIO devices, so is 'simple-pm-bus' with the
> > > > addition of PM capabilities. That means you have registers defined
> > > > (reg), but you don't.
> > > > 
> > > > Either you have a block with mixed functions or you have separate
> > > > blocks. If the register space is all mixed together, then it is the
> > > > former and an MFD. Don't be designing your binding based on Linux
> > > > behavior.
> > > 
> > > Thanks for clarifying how to differetiate MFD and 'simple-bus'/'simple-
> > > pm-bus'.  I would say the register space of the CSR module is mixed
> > > together, e.g., LVDS PHY child device has a register offset 0x00,
> > > PXL2DPI child device has a register offset 0x40 and LDB child device
> > > has register offsets 0x20 and 0xe0 in i.MX8qxp MIPI DSI/LVDS combo
> > > subsystem CSR module register space.  So, it appears to be a MFD.
> > > 
> > > Lee, what do you think?  If it is indeed an MFD, a new MFD driver for
> > > the CSR module is needed then.
> > 
> > There already exists a driver which does what you need, so why create
> > a 2nd one? Just add the "fsl,imx8qxp-mipi-lvds-csr" compatible to the
> > simple-pm-bus match table and don't set ONLY_BUS. Isn't that enough?
> 
> Adding "fsl,imx8qxp-mipi-lvds-csr" and "fsl,imx8qm-lvds-csr" compatible
> strings to the simple-pm-bus match table does work, but it tends to
> make people think the CSR module is a bus instead of a MFD.

MFDs don't exist.  They're a figment of our imagination.

If you want PM enabled and wish for your child devices to be
auto-magically registered for you, simple-pm-bus is what you need.

> It's kinka
> straightforward if a MFD device driver lives in drivers/mfd directory.
> However, since "simple-mfd" compatible is also in that match table, I
> would add the CSR module's compatible strings to that match table if no
> objections.

Fine by me if it saves authoring a pointless driver.

-- 
Lee Jones [李琼斯]
