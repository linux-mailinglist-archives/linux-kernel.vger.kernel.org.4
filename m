Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC92618617
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKCRYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKCRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:24:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB300101EE;
        Thu,  3 Nov 2022 10:24:41 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n186so2684266oih.7;
        Thu, 03 Nov 2022 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWlICvHzlBeg9LCOWbqv/i9LeL6eNtuUwG5sGXxa/tc=;
        b=Tjzq0kR84QK4CodlhPHCbWifcSpM7bHkR7UJTxAHYzWYL+7cR80cSMeaiqadhE2jhH
         O5L5kpA/D/iHAXVffzjtofjwpdKpe0F+6j89aNXf+9AmWLSr424pPC8FFXZJmzHr0rOw
         7psZZBLLgbVKeRseKgDg5PBdwI5XyVs97GW6rB+mDfKZQEdTX/Ts+2BjjqBdamGPkuyr
         e/1pwfc5b09YaOyupAQnWm1XqwCMHgcxP6X2oMRIcCCf8HYJJOZqYtchNVMauAXsUtyH
         d7DNR4RWdtHibU4FV4gQDKfgQTq8XfOu99buoHPzH1upE+fzS0b9aBUDqRUQsUiOyBFj
         tz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWlICvHzlBeg9LCOWbqv/i9LeL6eNtuUwG5sGXxa/tc=;
        b=NyhOOw4qS9AncGlTUZgIpK0a4UF1q1zkEzx8NDwOGPYcdZws6gK0mtWkq0+oMMfdzn
         4ZUCs68d9ThDNA8MN5oTCCVpwwz4s//pJGTfMFBsuZEJeqo90X5Cy3lQw9oIq0Ol9fan
         fKQ4JrWopY84AiOGZGGvuhqHEAuYhtcQcm6oWLUVvfk0cO9fhyBBeE8gxBinGgyqdkAy
         QnXWHmO1QKdlYDEGq01p9ewlrI4QtwZM2cUSdRLp1xnu4hj7cRLo9y9OhBfFO4AomOfX
         yG8n7HT1qTnKikCP+Wfsw8OxCOUKWwIYU3HobeJzVG++z8y4FJVlajck07MJ9v9VDhvZ
         I9Jg==
X-Gm-Message-State: ACrzQf2oS+jkbBxtbVIbzGLEnL6hsW7Xsd56HkeRRMqIUBNwnEOC/GVE
        mTCWsRpDKHDGmrHDahycAXk=
X-Google-Smtp-Source: AMsMyM5gNo0BpbepAuiZBx2MhxO/EKHQ39ozh3IZx28uKl17yF7qrNR66UFbojm0/fl4Wcpb4e9+XQ==
X-Received: by 2002:aca:d0b:0:b0:359:cb6e:809b with SMTP id 11-20020aca0d0b000000b00359cb6e809bmr20062609oin.137.1667496281019;
        Thu, 03 Nov 2022 10:24:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l21-20020a05687040d500b0013d9bd4ad2esm655487oal.12.2022.11.03.10.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:24:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Nov 2022 10:24:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Message-ID: <20221103172432.GB177861@roeck-us.net>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
 <20221002162528.GA2900147@roeck-us.net>
 <BY5PR12MB403335B81FB6DF09D65A08B593239@BY5PR12MB4033.namprd12.prod.outlook.com>
 <BY5PR12MB403330D43906BD6D617DB0DC93389@BY5PR12MB4033.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB403330D43906BD6D617DB0DC93389@BY5PR12MB4033.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:51:14PM +0000, Neeli, Srinivas wrote:
> HI Guenter,
> 
> > -----Original Message-----
> > From: Neeli, Srinivas <srinivas.neeli@amd.com>
> > Sent: Tuesday, October 11, 2022 11:57 AM
> > To: Guenter Roeck <linux@roeck-us.net>
> > Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> > <shubhrajyoti.datta@amd.com>; Simek, Michal <michal.simek@amd.com>;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> > kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> > <git@amd.com>
> > Subject: RE: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> > watchdog support
> > 
> > Hi,
> > 
> > > -----Original Message-----
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > Sent: Sunday, October 2, 2022 9:55 PM
> > > To: Neeli, Srinivas <srinivas.neeli@amd.com>
> > > Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> > > <shubhrajyoti.datta@amd.com>; Simek, Michal
> > <michal.simek@amd.com>;
> > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> > > kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; devicetree@vger.kernel.org; git
> > > (AMD-Xilinx) <git@amd.com>
> > > Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> > > watchdog support
> > >
> > > On Tue, Sep 27, 2022 at 04:32:56PM +0530, Srinivas Neeli wrote:
> > > > Versal watchdog driver uses window watchdog mode. Window watchdog
> > > > timer(WWDT) contains closed(first) and open(second) window with
> > > > 32 bit width. Write to the watchdog timer within predefined window
> > > > periods of time. This means a period that is not too soon and a
> > > > period that is not too late. The WWDT has to be restarted within the
> > > > open window time. If software tries to restart WWDT outside of the
> > > > open window time period, it generates a reset.
> > > >
> > > > Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> > > > ---
> > > >  drivers/watchdog/Kconfig       |  17 ++
> > > >  drivers/watchdog/Makefile      |   1 +
> > > >  drivers/watchdog/xilinx_wwdt.c | 286
> > > > +++++++++++++++++++++++++++++++++
> > > >  3 files changed, 304 insertions(+)
> > > >  create mode 100644 drivers/watchdog/xilinx_wwdt.c
> > > >
> > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > index
> > > > 688922fc4edb..9822e471b9f0 100644
> > > > --- a/drivers/watchdog/Kconfig
> > > > +++ b/drivers/watchdog/Kconfig
> > > > @@ -304,6 +304,23 @@ config XILINX_WATCHDOG
> > > >  	  To compile this driver as a module, choose M here: the
> > > >  	  module will be called of_xilinx_wdt.
> > > >
> > > > +config XILINX_WINDOW_WATCHDOG
> > > > +	tristate "Xilinx window watchdog timer"
> > > > +	depends on HAS_IOMEM
> > > > +	select WATCHDOG_CORE
> > > > +	help
> > > > +	  Window watchdog driver for the versal_wwdt ip core.
> > > > +	  Window watchdog timer(WWDT) contains closed(first) and
> > > > +	  open(second) window with 32 bit width. Write to the watchdog
> > > > +	  timer within predefined window periods of time. This means
> > > > +	  a period that is not too soon and a period that is not too
> > > > +	  late. The WWDT has to be restarted within the open window time.
> > > > +	  If software tries to restart WWDT outside of the open window
> > > > +	  time period, it generates a reset.
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the
> > > > +	  module will be called xilinx_wwdt.
> > > > +
> > > >  config ZIIRAVE_WATCHDOG
> > > >  	tristate "Zodiac RAVE Watchdog Timer"
> > > >  	depends on I2C
> > > > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > > > index cdeb119e6e61..4ff96c517407 100644
> > > > --- a/drivers/watchdog/Makefile
> > > > +++ b/drivers/watchdog/Makefile
> > > > @@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) +=
> > > m54xx_wdt.o
> > > >
> > > >  # MicroBlaze Architecture
> > > >  obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
> > > > +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
> > > >
> > > >  # MIPS Architecture
> > > >  obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o diff --git
> > > > a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> > > > new file mode 100644 index 000000000000..2594a01c2764
> > > > --- /dev/null
> > > > +++ b/drivers/watchdog/xilinx_wwdt.c
> > > > @@ -0,0 +1,286 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Window watchdog device driver for Xilinx Versal WWDT
> > > > + *
> > > > + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/ioport.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/watchdog.h>
> > > > +
> > > > +#define XWWDT_DEFAULT_TIMEOUT	40
> > > > +#define XWWDT_MIN_TIMEOUT	1
> > > > +#define XWWDT_MAX_TIMEOUT	42
> > > > +
> > > > +/* Register offsets for the WWDT device */
> > > > +#define XWWDT_MWR_OFFSET	0x00
> > > > +#define XWWDT_ESR_OFFSET	0x04
> > > > +#define XWWDT_FCR_OFFSET	0x08
> > > > +#define XWWDT_FWR_OFFSET	0x0c
> > > > +#define XWWDT_SWR_OFFSET	0x10
> > > > +
> > > > +/* Master Write Control Register Masks */
> > > > +#define XWWDT_MWR_MASK		BIT(0)
> > > > +
> > > > +/* Enable and Status Register Masks */
> > > > +#define XWWDT_ESR_WINT_MASK	BIT(16)
> > > > +#define XWWDT_ESR_WSW_MASK	BIT(8)
> > > > +#define XWWDT_ESR_WEN_MASK	BIT(0)
> > > > +
> > > > +#define XWWDT_PERCENT		50
> > > > +
> > > > +static int xwwdt_timeout;
> > > > +static int xclosed_window_percent;
> > > > +
> > > > +module_param(xwwdt_timeout, int, 0644);
> > > > +MODULE_PARM_DESC(xwwdt_timeout,
> > > > +		 "Watchdog time in seconds. (default="
> > > > +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
> > >
> > > There is no reason to make this writeable. There are means to set the
> > > timeout in runtime. Those should be used.
> > 
> > Accepted and will update in V2.
> > >
> > > > +module_param(xclosed_window_percent, int, 0644);
> > > > +MODULE_PARM_DESC(xclosed_window_percent,
> > > > +		 "Watchdog closed window percentage. (default="
> > > > +		 __MODULE_STRING(XWWDT_PERCENT) ")");
> > >
> > > The above is problematic. This should really not be set during
> > > runtime, and the behavior is pretty much undefined if it is changed
> > > while the watchdog is running. It should really be set using
> > > devicetree and not be changed in the running system.
> > 
> > Accepted and will update in V2.
> > >
> > > > +
> > > > +/**
> > > > + * struct xwwdt_device - Watchdog device structure
> > > > + * @base: base io address of WDT device
> > > > + * @spinlock: spinlock for IO register access
> > > > + * @xilinx_wwdt_wdd: watchdog device structure
> > > > + * @clk: struct clk * of a clock source
> > > > + * @freq: source clock frequency of WWDT  */ struct xwwdt_device {
> > > > +	void __iomem *base;
> > > > +	spinlock_t spinlock; /* spinlock for register handling */
> > > > +	struct watchdog_device xilinx_wwdt_wdd;
> > > > +	struct clk *clk;
> > > > +	unsigned long	freq;
> > > > +};
> > > > +
> > > > +static bool is_wwdt_in_closed_window(struct watchdog_device *wdd) {
> > > > +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> > > > +	u32 csr, ret;
> > > > +
> > > > +	csr = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > > +
> > > > +	ret = (csr & XWWDT_ESR_WEN_MASK) ? !(csr &
> > > XWWDT_ESR_WSW_MASK) ? 0 :
> > > > +1 : 1;
> > >
> > > This is confusing.
> > >
> > > 	return !(csr & XWWDT_ESR_WEN_MASK) || ((csr &
> > XWWDT_ESR_WSW_MASK);
> > >
> > > should do the same and would be easier to understand, though I am not
> > > sure if it is correct (making the point that the expression is confusing).
> > >
> > Accepted and will update in V2.
> > 
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int xilinx_wwdt_start(struct watchdog_device *wdd) {
> > > > +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> > > > +	struct watchdog_device *xilinx_wwdt_wdd = &xdev-
> > > >xilinx_wwdt_wdd;
> > > > +	u64 time_out, closed_timeout, open_timeout;
> > > > +	u32 control_status_reg;
> > > > +
> > > > +	/* Calculate timeout count */
> > > > +	time_out = xdev->freq * wdd->timeout;
> > > > +
> > > > +	if (xclosed_window_percent) {
> > > > +		closed_timeout = (time_out * xclosed_window_percent) /
> > > 100;
> > > > +		open_timeout = time_out - closed_timeout;
> > > > +		wdd->min_hw_heartbeat_ms = xclosed_window_percent *
> > > 10 * wdd->timeout;
> > > > +	} else {
> > > > +		/* Calculate 50% of timeout */
> > >
> > > Isn't that a bit random ?
> > 
> > Versal Window watchdog IP supports below features.
> >  1)Start
> >  2)Stop
> >  3)Configure Timeout
> >  4)Refresh
> > 
> > Planning to take closed window percentage from device tree parameter.
> > If the user hasn't passed the closed window percentage from the device tree,
> > by default, taking XWWDT_PERCENT value which is 50.
> > 
> > >
> > > > +		time_out *= XWWDT_PERCENT;
> > > > +		time_out /= 100;
> > > > +		wdd->min_hw_heartbeat_ms = XWWDT_PERCENT * 10 *
> > > wdd->timeout;
> > >
> > > min_hw_heartbeat_ms is supposed to be fixed after probe. Behavior of
> > > changing it when starting the watchdog is undefined. This will likely
> > > fail under some conditions.
> > 
> > As I said in above comments versal watchdog IP supports reconfiguration of
> > timeout, so every restart we are updating min_hw_heartbeat_ms based on
> > timeout.
> > 
> > >
> > > > +	}
> > > > +
> > > > +	spin_lock(&xdev->spinlock);
> > > > +
> > > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > > XWWDT_MWR_OFFSET);
> > > > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> > > XWWDT_ESR_OFFSET);
> > > > +
> > > > +	if (xclosed_window_percent) {
> > > > +		iowrite32((u32)closed_timeout, xdev->base +
> > > XWWDT_FWR_OFFSET);
> > > > +		iowrite32((u32)open_timeout, xdev->base +
> > > XWWDT_SWR_OFFSET);
> > > > +	} else {
> > > > +		/* Configure closed and open windows with 50% of timeout
> > > */
> > > > +		iowrite32((u32)time_out, xdev->base +
> > > XWWDT_FWR_OFFSET);
> > > > +		iowrite32((u32)time_out, xdev->base +
> > > XWWDT_SWR_OFFSET);
> > > > +	}
> > >
> > > This if/else should not be necessary by using appropriate calculations
> > above.
> > > Anyway, this is moot - as said above, changing min_hw_heartbeat_ms
> > > after probe is unexpected, and the code will have to be changed to use
> > > a fixed value for the window size. With that, all calculations can and
> > > should be done in the probe function.
> > >
> > > > +
> > > > +	/* Enable the window watchdog timer */
> > > > +	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > > +	control_status_reg |= XWWDT_ESR_WEN_MASK;
> > > > +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> > >
> > > Why is this enabled unconditionally ? I would assume that a user
> > > specifying a 0-percentage window size doesn't want it enabled.
> > 
> > Plan to add a check for closed window percentage. If user tries to configure
> > 100% of closed window, driver configures XWWDT_PERCENT value.
> > Configuring 100% of closed window not suggestible.
> > 
> > >
> > > > +
> > > > +	spin_unlock(&xdev->spinlock);
> > > > +
> > > > +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd) {
> > > > +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> > > > +	u32 control_status_reg;
> > > > +
> > > > +	spin_lock(&xdev->spinlock);
> > > > +
> > > > +	/* Enable write access control bit for the window watchdog */
> > > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > > XWWDT_MWR_OFFSET);
> > > > +
> > > > +	/* Trigger restart kick to watchdog */
> > > > +	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > > +	control_status_reg |= XWWDT_ESR_WSW_MASK;
> > > > +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> > > > +
> > > > +	spin_unlock(&xdev->spinlock);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
> > > > +				   unsigned int new_time)
> > > > +{
> > > > +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> > > > +	struct watchdog_device *xilinx_wwdt_wdd = &xdev-
> > > >xilinx_wwdt_wdd;
> > > > +
> > > > +	if (watchdog_active(xilinx_wwdt_wdd))
> > > > +		return -EPERM;
> > >
> > > Why ? This will be the most common case and means to change the
> > timeout.
> > 
> > Versal Watchdog supports reconfiguration of timeout. If we try to
> > reconfigure timeout without stopping the watchdog, driver returns error
> > immediately. Reconfiguration of timeout, Stop and Refresh not allowed in
> > closed window.
> > User can trigger set timeout any point of time, So avoiding reconfiguring the
> > timeout feature using driver API if the watchdog is active.
> > 
> > >
> > > > +
> > > > +	wdd->timeout = new_time;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xilinx_wwdt_stop(struct watchdog_device *wdd) {
> > > > +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
> > > > +	struct watchdog_device *xilinx_wwdt_wdd = &xdev-
> > > >xilinx_wwdt_wdd;
> > > > +
> > > > +	if (watchdog_active(xilinx_wwdt_wdd)) {
> > > > +		if (!is_wwdt_in_closed_window(wdd)) {
> > > > +			dev_warn(xilinx_wwdt_wdd->parent, "timer in
> > > closed window");
> > > > +			return -EPERM;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	spin_lock(&xdev->spinlock);
> > > > +
> > > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > > XWWDT_MWR_OFFSET);
> > > > +
> > > > +	/* Disable the Window watchdog timer */
> > > > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> > > XWWDT_ESR_OFFSET);
> > > > +
> > > > +	spin_unlock(&xdev->spinlock);
> > > > +
> > > > +	clk_disable(xdev->clk);
> > >
> > > This doesn't work. The start function doesn't enable the clock; it is
> > > enabled in the probe function. If you want to enable the clock
> > > dynamically, you'll have to enable it in the start function and make
> > > sure that it is stopped when unloading the driver (you can't use the
> > > devm function in this case). You'll also need to make sure that the
> > > unprepare function is called when unloading the driver.
> > >
> > 
> > Accepted and will update in V2.
> > 
> > Thanks
> > Neeli Srinivas
> 
> Could you please let me know your thoughts on "one line comment summary".
> 

Sorry, I have no idea what you refer to. Searching for any of the words in
"one line comment summary" in this patch doesn't give me a hint either.

Guenter
