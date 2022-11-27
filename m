Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE19B6398FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKZXpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZXpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:45:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A823F11C14;
        Sat, 26 Nov 2022 15:45:14 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j4so12148479lfk.0;
        Sat, 26 Nov 2022 15:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKIsNJ5wqQ+4oOPiBGrGjoZIkdw8QUPVUMhFIHmSI2U=;
        b=icr23wzPVGbWt4k+qnSFOqzwdYUe6XwJg24UAXubv/CyL7WZ4rRgnyjMw8O65851Yn
         smSq7lXnXGQSWNyIt9cz3GY5gdke6+Ge7nF0zFg8wCTLIqKxpU7+7q/yIq4nOSNdIPWw
         Ch9e/f2Lum+0WFPzbkTJr6Rgklkzxwn9KgmJ6MhtFbPCmWdVBhoezdrlHQvlmi1CH24p
         ZXB6X3ObC7fyEgN44QZ8R2SK0O7YZODC8+WAc0vzOOXmbWHeWJuMxVe2EgvZ7exl9BXw
         c967lrd+R05yQVSRlZn70qzQjwur3ulT3lpy+vGJMefClXL/QZQFPgNPmM2s0RJPuKoV
         t3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKIsNJ5wqQ+4oOPiBGrGjoZIkdw8QUPVUMhFIHmSI2U=;
        b=7AUMonQI87nGA18BlE+smFXq6nhq/WrOOy+inD6LiiIzvphsv4eGb0ucY3Cn50iDaA
         1zVDYkB/Pbb/vYtAgoOVGDOZda0qrGieHZvBT6flcO343QThKB9PCT/IbD2wTgTecjGu
         LmtcylhH2H5miRlSzwpZgPz8Qzxx8DfMowMohqJwFgt85VvEvoBd7FNNKd0KexORYkTH
         BdMJuWniujFSAPH7pXt2EreEfcbMUIRWeQ+C0NS+80H49EfA0lENu4pCsyl8R3+Y9oDF
         MieY4sjeaoW9kHk1TALME/8zSzgz/4oMGVINq22t3RbvqHIWWBi1wg8W9p2mj8dN5OsX
         s+zw==
X-Gm-Message-State: ANoB5pm/Ptv24cDi3DWyqt9/hrEhdDZlY/xra/HkMigXEOaLBzP74f9N
        QU0JGgnyC1ZVjHPrCrrba6U=
X-Google-Smtp-Source: AA0mqf7tXQAiMFMobD+RgXjPWRlAasawAhQ9ApGjY+8HCb1FmU7eT37Sgzgz2AXFsY+YA/qLIpUnhQ==
X-Received: by 2002:ac2:4e07:0:b0:4a2:2a60:ecf5 with SMTP id e7-20020ac24e07000000b004a22a60ecf5mr16055151lfr.57.1669506312823;
        Sat, 26 Nov 2022 15:45:12 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512074a00b004b1907d85e9sm1075254lfs.161.2022.11.26.15.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 15:45:12 -0800 (PST)
Date:   Sun, 27 Nov 2022 02:45:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Message-ID: <20221126234509.ezn6vuefnj2f7pyk@mobilestation>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
 <20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru>
 <20221107211134.wxaqi2sew6aejxne@mobilestation>
 <8b7ce195-27b7-a27f-bf4e-fd5f20f2a83b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7ce195-27b7-a27f-bf4e-fd5f20f2a83b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 03:32:23PM +0000, Robin Murphy wrote:
> On 2022-11-07 21:11, Serge Semin wrote:
> > On Tue, Nov 08, 2022 at 12:04:36AM +0300, Serge Semin wrote:
> > > DW eDMA doesn't perform any translation of the traffic generated on the
> > > CPU/Application side. It just generates read/write AXI-bus requests with
> > > the specified addresses. But in case if the dma-ranges DT-property is
> > > specified for a platform device node, Linux will use it to create a
> > > mapping the PCIe-bus regions into the CPU memory ranges. This isn't what
> > > we want for the eDMA embedded into the locally accessed DW PCIe Root Port
> > > and End-point. In order to work that around let's set the chan_dma_dev
> > > flag for each DW eDMA channel thus forcing the client drivers to getting a
> > > custom dma-ranges-less parental device for the mappings.
> > > 
> > > Note it will only work for the client drivers using the
> > > dmaengine_get_dma_device() method to get the parental DMA device.
> > 
> > @Robin, we particularly need you opinion on this patch. I did as you
> > said: call *_dma_configure() method to initialize the child device and
> > set the DMA-mask here instead of the platform driver.
> 

> Apologies, I've been busy and this series got buried in my inbox before I'd
> clocked it as something I was supposed to be looking at.

No worries. I'm glad you responded.

> 
> > @Vinoud, @Manivannan I had to drop your tags from this patch since its
> > content had been significantly changed.
> > 
> > -Sergey
> > 
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v2:
> > > - Fix the comment a bit to being clearer. (@Manivannan)
> > > 
> > > Changelog v3:
> > > - Conditionally set dchan->dev->device.dma_coherent field since it can
> > >    be missing on some platforms. (@Manivannan)
> > > - Remove Manivannan' rb and tb tags since the patch content has been
> > >    changed.
> > > 
> > > Changelog v6:
> > > - Directly call *_dma_configure() method on the child device used for
> > >    the DMA buffers mapping. (@Robin)
> > > - Explicitly set the DMA-mask of the child device in the channel
> > >    allocation proecedure. (@Robin)
> > > - Drop @Manivannan and @Vinod rb- and ab-tags due to significant patch
> > >    content change.
> > > ---
> > >   drivers/dma/dw-edma/dw-edma-core.c | 44 ++++++++++++++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index e3671bfbe186..846518509753 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -6,9 +6,11 @@
> > >    * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > >    */
> > > +#include <linux/acpi.h>
> > >   #include <linux/module.h>
> > >   #include <linux/device.h>
> > >   #include <linux/kernel.h>
> > > +#include <linux/of_device.h>
> > >   #include <linux/dmaengine.h>
> > >   #include <linux/err.h>
> > >   #include <linux/interrupt.h>
> > > @@ -711,10 +713,52 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
> > >   static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> > >   {
> > >   	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +	struct device *dev = chan->dw->chip->dev;
> > > +	int ret;
> > >   	if (chan->status != EDMA_ST_IDLE)
> > >   		return -EBUSY;
> > > +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> > > +	 * controlled from the CPU/Application side since in that case
> > > +	 * the local memory address is left untranslated.
> > > +	 */
> > > +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {


> > > +		ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
> > > +						   DMA_BIT_MASK(64));
> > > +		if (ret) {
> 
> Setting a 64-bit mask should never fail, especially on any platform that
> will actually run this code.
> 
> > > +			ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
> > > +							   DMA_BIT_MASK(32));

Indeed. I can just drop the 32-bit mask test then. (But I'd retain the
error check anyway.)

The problem is that actual device DMA-addressing capability is
determined by the MASTER_BUS_ADDR_WIDTH IP-core synthesize parameter.
I can't predict its value from this generic code since it isn't
auto-detectable and is platform-specific. That's why back then in
our discussion I was insisting on setting the mask in the low-level
device drivers. But after the commit 423511ec23e2 ("PCI: dwc: Drop
dependency on ZONE_DMA32") it turned to be pointless now since the
DMA-mask would be overwritten by the generic DW PCIe driver code anyway.
What do you suggest then in this regard? Just keep setting the 64-bit
mask only? This will work for my platform, but will fail for the
devices with AXI-bus address of only 32-bits width.

> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > > +		if (dev_of_node(dev)) {
> > > +			struct device_node *node = dev_of_node(dev);
> > > +
> > > +			ret = of_dma_configure(&dchan->dev->device, node, true);
> > > +		} else if (has_acpi_companion(dev)) {
> 

> Can this can ever happen? AFAICS there's no ACPI binding to match and probe
> the DWC driver, at best it could only probe as a standard PNP0A08 host
> bridge which wouldn't know anything about eDMA anyway.

There are several ACPI-based platforms with DW PCIe controllers:
pcie-tegra194-acpi.c, pcie-al.c, pcie-hisi.c. All of them are fully
ECAM-based so no DW eDMA probing from the Linux kernel implied. But
these are still DW PCIe controllers and they or some other ones can
have eDMA embedded. Do you think it won't be ever possible to either
directly handle these controllers (bypassing the ECAM interface) or
have a DW PCIe device accessed via the ACPI bindings?

Note basically what I've implemented here was based on the
platform_dma_configure() DMA-configuration code pattern. I thought it
was a reasonable choice since this code path is executed for the
platform devices only (implied by the DW_EDMA_CHIP_LOCAL flag
semantic).

On the second thought if the problem in subject is only specific to
the DT-based platforms, then I could just skip channel device
initialization here for the platform devices with no OF-node detected.
So the question is is it specific to the DT-based platforms only?

(Before answering to the question above please read the last comment
in this message.)

> 
> > > +			struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> > > +
> > > +			ret = acpi_dma_configure(&dchan->dev->device,
> > > +						 acpi_get_dma_attr(adev));
> > > +		} else {
> > > +			ret = -EINVAL;
> > > +		}
> > > +
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		if (dchan->dev->device.dma_range_map) {
> > > +			kfree(dchan->dev->device.dma_range_map);
> > > +			dchan->dev->device.dma_range_map = NULL;
> > > +		}
> 

> Ugh, I guess this is still here because now you're passing the channel
> device to of_dma_configure() such that it looks like a PCI child :(

No. It's still here because I successfully missed your email in my
work inbox so I thought you didn't fix that dma-ranges peculiarity of
the PCIe-host nodes.(

> 
> Can we just set "chan->dev->device.of_node = dev->of_node;" beforehand so it
> works as expected (with f1ad5338a4d5 in place) and we don't need to be
> messing with the dma_range_map details at all? Note that that isn't as hacky
> as it might sound - it's a relatively well-established practice in places
> like I2C and SPI, and in this case it seems perfectly appropriate
> semantically as well.

Of course we can. But now, thanks to your commit f1ad5338a4d5 ("of:
Fix "dma-ranges" handling for bus controllers"), there is no point in
any dma-ranges hack here because the dma-ranges property is no longer
parsed for the PCIe-host platform device. I can and will just drop the
custom DMA-channel device initialization from the patch. The only
issue left to solve is about setting the DMA-mask. Please see my notes
above regarding that problem.

-Serge(y)

> 
> (And there should be no need to bother with of_node refcounting, since the
> lifetime of the eDMA driver is bounded by the lifetime of the PCIe driver,
> thus the lifetime of the DMA channel devices is bounded by the lifetime of
> the PCIe platform device, which already holds a reference from
> of_device_alloc().)
> 
> Thanks,
> Robin.
> 
> > > +
> > > +		dchan->dev->chan_dma_dev = true;
> > > +	} else {
> > > +		dchan->dev->chan_dma_dev = false;
> > > +	}
> > > +
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.38.0
> > > 
> > > 
