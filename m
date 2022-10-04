Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7039A5F47D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJDQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJDQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:43:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC55FF76;
        Tue,  4 Oct 2022 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664901827; x=1696437827;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QZfggRb9uSwOEUg4ZGsFnWBpArk+VTuihHlwDl2Fei8=;
  b=dtMvnc57LErl66uJnqATfprpD7ya4wua1/wuReAtrZCKUt2Z34lmBLZy
   GG5Ruu0ydnPqB3/TmYk7+uFn4gnzoMOwlyiK+pmtzAq8NDLeKAAFOGaq7
   inLcjRCOYQ+1DBaTyd2wy4C08Vh008UAEruUKjYvr4E4glMwzSIeDKI+e
   ATymFy+dx2sX6HpPQFy6ZUT2Eaf9XFJHcZAnoOL9Ev/1woQ64anO+Unj3
   nY5BsPzwa+ujzQEf8MeE5g7QX7gsjiu/SUjBC23MAdQcVvBFg0EMKzCp2
   C9nd5DKvhRIYi1BwkMmbYoOtQAiS+iDyQXjxZf4aNDr4zV6wAGqcN9B30
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="283330531"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="283330531"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:43:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869070239"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="869070239"
Received: from kmreisi-mobl.ger.corp.intel.com ([10.252.39.196])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:43:38 -0700
Date:   Tue, 4 Oct 2022 19:43:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, trix@redhat.com,
        tumic@gpxsee.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com
Subject: Re: [PATCH V5 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
In-Reply-To: <56f971da-5116-58dc-2df6-53ed465c8ec4@amd.com>
Message-ID: <c86fb070-9d46-9558-f7ee-216fc657cf1a@linux.intel.com>
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com> <1664409507-64079-2-git-send-email-lizhi.hou@amd.com> <6ba2221c-bbc9-a33c-7e62-85c2d87ceeed@linux.intel.com> <56f971da-5116-58dc-2df6-53ed465c8ec4@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-236487039-1664901822=:1585"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-236487039-1664901822=:1585
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Oct 2022, Lizhi Hou wrote:

> 
> On 10/4/22 01:18, Ilpo Järvinen wrote:
> > On Wed, 28 Sep 2022, Lizhi Hou wrote:
> > 
> > > Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
> > > for PCI Express). For example, Xilinx Alveo PCIe devices.
> > >      https://www.xilinx.com/products/boards-and-kits/alveo.html
> > > 
> > > The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host
> > > (C2H)
> > > channels. Memory transfers are specified on a per-channel basis in
> > > descriptor linked lists, which the DMA fetches from host memory and
> > > processes. Events such as descriptor completion and errors are signaled
> > > using interrupts. The hardware detail is provided by
> > >      https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
> > > 
> > > This driver implements dmaengine APIs.
> > >      - probe the available DMA channels
> > >      - use dma_slave_map for channel lookup
> > >      - use virtual channel to manage dmaengine tx descriptors
> > >      - implement device_prep_slave_sg callback to handle host scatter
> > > gather
> > >        list
> > >      - implement device_config to config device address for DMA transfer
> > > 
> > > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > > Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> > > Signed-off-by: Max Zhen <max.zhen@amd.com>
> > > Signed-off-by: Brian Xu <brian.xu@amd.com>
> > > ---

> > > +	*chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) * (*chan_num),
> > > +			      GFP_KERNEL);
> > > +	if (!*chans)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
> > > +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
> > > +				    XDMA_CHAN_IDENTIFIER, &identifier);
> > > +		if (ret) {
> > > +			xdma_err(xdev, "failed to read channel id: %d", ret);
> > > +			return ret;
> > > +		}
> > Is it ok to not rollback the allocation in case of an error occurs?
> 
> In this loop, the failures are returned by read/write registers. The
> read/write register failure indicates serious hardware issue and the hardware
> may not be rollback in this situation.

What I meant is that you allocated memory above (to *chans, see above). 
Shouldn't that memory be free in case the hw is not working before you 
return the error from this function?

Check also the other returns below for the same problemx.

> > > +
> > > +		if (j == *chan_num) {
> > > +			xdma_err(xdev, "invalid channel number");
> > > +			return -EIO;
> > > +		}
> > Same here?
> > 
> > > +
> > > +		/* init channel structure and hardware */
> > > +		(*chans)[j].xdev_hdl = xdev;
> > > +		(*chans)[j].base = base + i * XDMA_CHAN_STRIDE;
> > > +		(*chans)[j].dir = dir;
> > > +
> > > +		ret = xdma_channel_init(&(*chans)[j]);
> > > +		if (ret)
> > > +			return ret;
> > And here.
> > 
> > > +		(*chans)[j].vchan.desc_free = xdma_free_desc;
> > > +		vchan_init(&(*chans)[j].vchan, &xdev->dma_dev);
> > > +
> > > +		j++;
> > > +	}
> > > +
> > > +	dev_info(&xdev->pdev->dev, "configured %d %s channels", j,
> > > +		 (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H");
> > > +
> > > +	return 0;
> > > +}


-- 
 i.

--8323329-236487039-1664901822=:1585--
