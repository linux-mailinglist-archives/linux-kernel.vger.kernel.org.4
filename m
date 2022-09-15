Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F05B9368
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIOD4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIOD4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:56:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB376F257
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:56:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb3so9576516ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AATR5Vi84utBn0tLSt7uf9CLWfaKHdrblcotY/Zmy9A=;
        b=ND/txL1/+xjMLDu0aIdccxW60RK8u7870i1GIIuyQKxphQzcP0TfddcsLd1MzrgnLT
         GKtjVX1JQbAqGRhp5jha+MaVq07U85m+h+xVUvNcloa2GVDXilU51Br/KvH/g1MucqRh
         bZh03gEbldXqVsaaxQNmcdckzW99ZtHgNkLl+DmUH48fx+vkDz7A2a7Sf1wHbJVj2cTx
         ub0MgXAmYuWslGh2/YvLHDH7rko4xDKo6S3UixZuSF5PXpNwlZYSjAx3oXY3+et1mPLq
         ORyvaTe8yaasLjnGnR0OeAQipCE4tc2n0aVp3T5wJqWjXSQdafKujm9YNk8Gse7TYmUb
         w2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AATR5Vi84utBn0tLSt7uf9CLWfaKHdrblcotY/Zmy9A=;
        b=d+ACzdAvez1IIPcx3+CVdYvww5pxpzEPFVKpsm9WPiqmJGCJ/JmYrZwvXB5sm6Suri
         pehLLg4mpRjcYzgdK7GUvB9XY96TpVaYJ5h6tbHRZUnD1cSrWJ9aOinZwM533NcHgUiJ
         rNf2aeRM7dQXUNiiqfAPQZce+vN5gbh8WgXVqNp+f3Oq3Nmoesx6gvF9nkzbzVlHV9Gm
         wt89/rCBbNJGm2Le7PBXKOebApO+LhAr21H1OSJMUmtxgqq9xcRPs3+99rLQNP7zauft
         DAPOZKBl9n0XT1J+8QySYpN94gF/uospKkKvAL3/UXkmX6N0RqMQJH06SoBYSKpaacZU
         ToMA==
X-Gm-Message-State: ACgBeo1yuUOXkpgPRc6M15K4Sgq8iNoClikJU+u5+Nw/JASLUhd8XOQU
        /d1xJtYo0BvyuHML+J1FV7yNQozmTYiO2SpIwRYm7Q==
X-Google-Smtp-Source: AA6agR4osRYEVoTdOQ8rBO9HBExukcN1jUj15ovpiQwllRhupuOoXzzWoWRJ7k5rooxb3ZPVIefxFl2GpMlNu4Sbpus=
X-Received: by 2002:a17:907:2da6:b0:73d:d587:6213 with SMTP id
 gt38-20020a1709072da600b0073dd5876213mr28200738ejc.5.1663214176661; Wed, 14
 Sep 2022 20:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <YuqDMLF2AQyj4+N1@kroah.com> <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
 <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com>
 <YyCequVJnV3p0Cpw@kroah.com> <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
 <YyHehZ5hT8mXKoTX@kroah.com> <CAOesGMid4_pDeUQFwhfSwrBRGhGocA-73V83h5qOsmYg7gAWTA@mail.gmail.com>
 <CAGETcx9Ha+akkuqzanGH9vrCnFQT_zTmezAHwtMhpxsQa=mwjg@mail.gmail.com>
In-Reply-To: <CAGETcx9Ha+akkuqzanGH9vrCnFQT_zTmezAHwtMhpxsQa=mwjg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 14 Sep 2022 20:56:04 -0700
Message-ID: <CAOesGMgpJQjMvo6m7on+27F8REiHaVSRL6HBjiRPVDM9Jscnrg@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:36 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Sep 14, 2022 at 9:24 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > On Wed, Sep 14, 2022 at 7:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 09:28:27AM -0700, Olof Johansson wrote:
> > > > On Tue, Sep 13, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Sep 12, 2022 at 10:24:43AM -0700, Olof Johansson wrote:
> > > > > > On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > > Saravana Kannan (11):
> > > > > > > >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > > > > > >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > > > > > >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > > > > > >       driver core: Add wait_for_init_devices_probe helper function
> > > > > > > >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> > > > > > > >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > > > > > >       driver core: Set fw_devlink.strict=1 by default
> > > > > > > >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> > > > > > > >       driver core: Delete driver_deferred_probe_check_state()
> > > > > > > >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> > > > > > > >       of: base: Avoid console probe delay when fw_devlink.strict=1
> > > > > > >
> > > > > > > The last patch in this list regresses my HoneyComb LX2K (ironically
> > > > > > > the machine I do maintainer work on). It stops PCIe from probing, but
> > > > > > > without a single message indicating why.
> > > > > > >
> > > > > > > The reason seems to be that the iommu-maps property doesn't get
> > > > > > > patched up by my (older) u-boot, and thus isn't a valid reference.
> > > > > > > System works fine without IOMMU, which is how I've ran it for a couple
> > > > > > > of years.
> > > > > > >
> > > > > > > It's also extremely hard to diagnose out of the box because there are
> > > > > > > *no error messages*. And there were no warnings leading up to this
> > > > > > > strict enforcement.
> > > > > > >
> > > > > > > This "feature" seems to have been done backwards. The checks should
> > > > > > > have been running (and not skipped due to the "optional" flag), but
> > > > > > > also not causing errors, just warnings. That would have given users a
> > > > > > > chance to know that this is something that needs to be fixed.
> > > > > > >
> > > > > > > And when you flip the switch, at least report what failed so that
> > > > > > > people don't need to spend a whole night bisecting kernels, please.
> > > > > > >
> > > > > > > Greg, mind reverting just the last one? If I hit this, I presume
> > > > > > > others would too.
> > > > > >
> > > > > > Apologies, wrong patch pointed out. The culprit is "driver core: Set
> > > > > > fw_devlink.strict=1 by default", 71066545b48e42.
> > > > >
> > > > > Is this still an issue in -rc5?  A number of patches in the above series
> > > > > was just reverted and hopefully should have resolved the issue you are
> > > > > seeing.
> > > >
> > > > Unfortunately, I discovered this regression with -rc5 in the first
> > > > place, so it's still there.
> > >
> > > Ick, ok, Saravana, any thoughts?  I know you're at the conference this
> > > week with me, maybe you can give Olof a hint as to what to look for
> > > here?
> >
> > I'm not sure what you want me to look for. The patch turns on
> > enforcement of DT contents that never used to be enforced, so now my
> > computer no longer boots. And it does it in a way that makes it
> > impossible for someone not rebuilding kernels to debug to figure out
> > what happened.
>
> Hi Olof,
>
> Sorry for the trouble. It doesn't print any error messages because
> there are cases where it's block the probe where it wouldn't be an
> error. If I printed it every time fw_devlink blocked a probe, it'd be
> a ton of messages.
>
> Btw, when I enabled fw_devlink.strict=1, it was AFTER making changes
> that'll stop indefinitely blocking probes. So what you are seeing
> shouldn't be happening. After about 10 seconds (configurable), it
> should stop blocking the probes.

"Shouldn't be happening" is a pretty bold statement. It's not actually
stuck on timeout in my case, and doesn't recover.

Instead, what seems to be happening is that the PCIe driver, which
registers as a platform_driver here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c#n255

ends up registering, and the driver core now refuses to try to probe
the device matches, since they no longer have their suppliers
fulfilled (the smmu suppliers would not be tracked since they are
optional here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/property.c#n1449

So what happens is that the driver registration succeeds, but there
have been no devices matched to it. So when it returns to the platform
core, it thinks there are no devices bound to this driver, so it
should be unregistered:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c#n951

That explains why the pcie core doesn't retry and just disappears, and
stops retrying.

This is what it looks like with CONFIG_DEBUG_DRIVER and CONFIG_DEBUG_DEVRES:
[    5.178538] bus: 'platform': add driver layerscape-pcie-gen4
[    5.184301] bus: 'platform': __driver_probe_device: matched device
3600000.pcie with driver layerscape-pcie-gen4
[    5.194498] platform 3600000.pcie: error -EPROBE_DEFER: supplier
5000000.iommu not ready
[    5.202607] platform 3600000.pcie: Added to deferred list
[    5.208024] bus: 'platform': __driver_probe_device: matched device
3800000.pcie with driver layerscape-pcie-gen4
[    5.218227] platform 3800000.pcie: error -EPROBE_DEFER: supplier
5000000.iommu not ready
[    5.226333] platform 3800000.pcie: Added to deferred list
[    5.231814] bus: 'platform': remove driver layerscape-pcie-gen4
[    5.237761] driver: 'layerscape-pcie-gen4': driver_release

Note that the platform driver registration sets flags to disable async
probing, supposedly so it can assume that any matching devices would
be found by the time registration returns:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c#n917
:

/*
* We have to run our probes synchronously because we check if
* we find any devices to bind to and exit with error if there
* are any.
*/
drv->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;

/*
* Prevent driver from requesting probe deferral to avoid further
* futile probe attempts.
*/
drv->prevent_deferred_probe = true;




Bottom line: How was this code tested? This seems far from mature,
this doesn't seem like that of an obscure condition to occur and it
could create minefields for others down the road if it's fragile.


-Olof


>
> If you actually want to see the reasons the probe is being blocked,
> you can enable the existing dbg messages in drivers/base/core.c.
>
> Would you mind pointing me to the dts (not dtsi) file that corresponds
> to this board please? And which specific PCI device is being blocked
> from probing? I'll can try to debug it further. Also, can you try to
> see why it doesn't get unblocked when driver_deferred_probe_timeout
> expires? Or why that's not helping here?
>
> In the meantime, if you want this patch reverted, I'm not opposed to
> that. But if you can use fw_devlinks.strict=0 in your commandline for
> now and give me time to debug, that'd be nicer.
>
> Thanks,
> Saravana
