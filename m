Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3096279F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiKNKFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiKNKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:04:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9B1260C;
        Mon, 14 Nov 2022 02:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2100B80DA2;
        Mon, 14 Nov 2022 10:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6D0C433D6;
        Mon, 14 Nov 2022 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668420113;
        bh=0AWDgj8YRiMgi+RCQmhjPkOW5dw2tU+daCdk+KQy8U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uiw0du2Mn3DKr94KgOc6lFzKfMp0U0UJWL9mUM2a89p4q+S8FvSsFFihv+vNk+RFl
         ADaK7pe4lGb0pD9+FOqBNtQPwWL54XYGppMM6lsBEYvtQul0FGn9xf7+u12Cydh6aQ
         xas6VneccrgIZlzJ7mZRDAH+NV/d+WnxMlQQyjkO9spZFjtAg445WC6ZM4IB7fWP4J
         5pFXgmm4MkFnkdhtriiNxNUWVfrbg5iC812Ly7flrLFNcz436eNQaSDGJLORpwlnZl
         hHeHRQ3IZqgu1p6U/zyZJD3AkFphUDVmaO0HCghcgUoR0sBhOjKnW6xKvWNC2KBOb/
         8fonfWtvLMKWQ==
Date:   Mon, 14 Nov 2022 10:01:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
Message-ID: <Y3ISCzNvFjA4UkNW@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
 <Y1/sUfeVy1a6EKZQ@google.com>
 <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
 <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
 <Y2jKRQ8VyauSfXmH@google.com>
 <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022, Liu Ying wrote:

> Hi Lee,
> 
> On Mon, 2022-11-07 at 09:05 +0000, Lee Jones wrote:
> > On Wed, 02 Nov 2022, Liu Ying wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > > > Hi Lee,
> > > > 
> > > > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > > > 
> > > > > > Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> > > > > > system
> > > > > > controller. It represents a set of miscellaneous registers of a
> > > > > > specific
> > > > > > subsystem. It may provide control and/or status report interfaces
> > > > > > to a
> > > > > > mix of standalone hardware devices within that subsystem.
> > > > > > 
> > > > > > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple
> > > > > > power-managed
> > > > > > bus(i.MX8qxp pixel link MSI bus). To propagate power management
> > > > > > operations
> > > > > > of the CSR module's child devices to that simple power-managed
> > > > > > bus, add a
> > > > > > dedicated driver for the CSR module. Also, the driver would
> > > > > > populate the CSR
> > > > > > module's child devices.
> > > > > > 
> > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > ---
> > > > > > The Freescale i.MX8qxp CSR DT bindings is at
> > > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > > > 
> > > > > > Resend the patch based on v6.1-rc1.
> > > > > > 
> > > > > >  drivers/mfd/Kconfig           | 10 +++++++
> > > > > >  drivers/mfd/Makefile          |  1 +
> > > > > >  drivers/mfd/fsl-imx8qxp-csr.c | 53
> > > > > > +++++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 64 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> > > > 
> > > > [...]
> > > > 
> > > > > > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-
> > > > > > imx8qxp-csr.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..3915d3d6ca65
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > > > > > @@ -0,0 +1,53 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +
> > > > > > +/*
> > > > > > + * Copyright 2022 NXP
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/of_platform.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/pm_runtime.h>
> > > > > > +
> > > > > > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	pm_runtime_enable(&pdev->dev);
> > > > > > +
> > > > > > +	ret = devm_of_platform_populate(&pdev->dev);
> > > > > 
> > > > > The use of this API does not constitute a MFD.
> > > > > 
> > > > > Please use "simple-mfd" instead.
> > > > 
> > > > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > > > simple-pm-bus driver would not populate child devices of simple-mfd
> > > > devices.
> > 
> > Right, simple-pm-bus will not populate child devices, because:
> 
> simple-pm-bus.c may populate child devices of simple-pm-bus devices
> because "ONLY_BUS" is _not_ set for simple-pm-bus devices.
> 
> simple-pm-bus.c would _not_ populate child devices of simple-mfd
> devices because "ONLY_BUS" is set for simple-mfd devices.
> 
> > 
> >   /*                                                                     
> >    * These are transparent bus devices (not simple-pm-bus matches) that  
> >    * have their child nodes populated automatically.  So, don't need to  
> >    * do anything more. We only match with the device if this driver is   
> >    * the most specific match because we don't want to incorrectly bind to
> >    * a device that has a more specific driver.                           
> >    */                                                                    
> > 
> > So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.
> 
> If simple-mfd device is a child device of one device listed in
> of_default_bus_match_table[], then it may be populated by
> drivers/of/platform.c.  But, in my case, simple-mfd device is a child
> device of simple-pm-bus device(not listed in that table), so it will
> not be populated by drivers/of/platform.c.  Instead,
> drivers/bus/simple-pm-bus.c would populate the simple-mfd device.
> 
> > 
> > > > Also, the simple-pm-bus driver would not enable runtime
> > > > power management for simple-mfd devices due to "ONLY_BUS", which
> > > > means it would not propagate power management operations from child
> > > > devices of simple-mfd devices to parent devices of simple-mfd
> > > > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed. 
> > 
> > This is more of an issue.
> > 
> > Why can't this device use "simple-pm-bus" to have support for both
> > auto-registration AND Runtime PM?
> 
> If I change the compatible string of the CSR module from
> "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd"
> to
> "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-pm-bus",
> all devices I'm interested in are populated and all relevant drivers
> can probe.

Okay, that's good.

> But, this change makes 'make dt_binding_check' for the
> existing fsl,imx8qxp-csr.yaml fail:
> 
> --------------------------------8<------------------------------------
> /kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> csr.example.dtb: syscon@56221000: $nodename:0: 'syscon@56221000' does
> not match '^bus(@[0-9a-f]+)?$'
> 	From schema:
> /kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> /kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> csr.example.dtb: syscon@56221000: '#address-cells' is a required
> property
> 	From schema:
> /kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> /kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> csr.example.dtb: syscon@56221000: '#size-cells' is a required property
> 	From schema:
> /kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> /kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> csr.example.dtb: syscon@56221000: 'ranges' is a required property
> 	From schema:
> /kernel/linux/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
> --------------------------------8<------------------------------------
> 
> The error log basically complains two things:
> 1) The example nodename 'syscon@56221000' should match
> '^bus(@[0-9a-f]+)?$'.
> 2) Missing '#address-cells', '#size-cells' and 'ranges' properties as
> required by simple-pm-bus.
> 
> Regarding 1), if I change 'syscon@56221000' to 'bus@56221000', then the
> below error comes along:
> --------------------------------8<------------------------------------
> /kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> csr.example.dtb: bus@56221000: $nodename:0: 'bus@56221000' does not
> match '^syscon@[0-9a-f]+$'
> 	From schema:
> /kernel/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-
> csr.yaml
> --------------------------------8<------------------------------------
> So, it looks like "syscon" and "simple-pm-bus" can not be in compatbile
> string at the same time.  Note that "syscon" is needed because other
> device nodes may reference the CSR module through a phandle, like the
> "fsl,imx8qxp-mipi-dphy" device.
> 
> Regarding 2), I may try to add those required properties, but it would
> break the existing schemas of the child devices of the CSR module, like
> the "fsl,imx8qxp-ldb" device, because "reg" property is not allowed.
> 
> So, it looks like the CSR module still should be simple-mfd device but
> not simple-pm-bus device, right?

It sounds like the generic auto-probing functionality provided by the
kernel works well to give you with a fully self-registering mechanism.
All you need to do now is figure out why the DT checker is not happy
with your solution.

Please work with the Device Tree maintainers on this.

> > > One more point which might be overlooked - as mentioned in commit
> > > message, the CSR module is a child node of a simple power-managed
> > > bus(i.MX8qxp pixel link MSI bus), which means the child devices of the
> > > CSR module(as a simple-mfd device) won't be populated by
> > > of_platform_default_populate() from of_platform_default_populate_init()
> > > because "simple-pm-bus" is not listed in of_default_bus_match_table[]
> > > and hence recursion of of_platform_bus_create() will stop at the
> > > simple-pm-bus. This is also a reason why a dedicated fsl-imx8qxp-csr
> > > driver is needed to populated those child devices of the CSR module.
> > 
> > Not sure I know the semantics well enough (anymore) to get a
> > meaningful picture of what you're trying to explain, and I do not have
> > any suitable H/W here to mock-up a real-world test-bed / concept
> > demonstrator to debug this for you.
> 
> I understand you have no hardware to debug this directly.  But, the
> example in dt-binding doc for the i.MX8qxp pixel link MSI bus(a simple-
> pm-bus) may give you a kinda full picture of what the relevant devices
> look like.  I mentioned the patch set to add the MSI bus previously,
> however, you may find the binding doc directly here -
> https://lore.kernel.org/lkml/20221017074039.4181843-3-victor.liu@nxp.com/
> 
> > 
> > The long and the short of it is; we have a bunch of automatic
> > child-device-registering helpers in the kernel.  One of the mechanisms
> > is bound to work for you if you structure your code appropriately.
> > 
> > Introducing an empty, meaningless driver, simply to call a single
> > function it not acceptable.  Please make the infrastructure already
> > offered specifically to solve this category of issue work for your
> > use-case.
> 
> Yeah, I tried to not to introduce a new driver for the CSR module, but
> it seems that it is needed.

It's not. :)

-- 
Lee Jones [李琼斯]
