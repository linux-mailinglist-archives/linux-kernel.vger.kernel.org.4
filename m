Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A105FBBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJKUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:16:27 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B81D313;
        Tue, 11 Oct 2022 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1665519384; i=@motorola.com;
        bh=LvpIoHarulDOtJ2juM4grLAbVlSPFXJgCsOsi75DjF4=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=d/mi4skmkhP30RaX0UO+SartcV3V69BxactEkl1bmwN4n214Z7Lqc3AlbXIR2HXTG
         OVw1IgGNXza+Q3HKyLkcvLbCfVOFdzmB6TQBshcXrz6fDS2mcgstQ0/T/R89zSVsIa
         RBhGWIfyMIkRedNxD61bl6T1PUIhSdqeERZkkrTzPRX8zfubka/XHUedvuskHZl6q2
         7m6IrhxpaIOx1C9NP2Zjb+Bl8LVLGlBzz6Q0gV6diFCL86Ppz4MoSJocvDKrV9GlfF
         3KdaNAFm2tr4Uk1QO8r1nLCFDtAvbwiEQSWwdUlEKpOhelmeRAvjDfTDTUpV0+4SdO
         kN1WddvfW/E7w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRWlGSWpSXmKPExsWS8eKJmK74edd
  kg+nrFSyOtT1ht3hyoJ3RonfZHjaL5sXr2Sw6Jy5ht1jYtoTF4vKuOWwWi5a1MlucmBxr8eNP
  H7PFqgUH2B24PWZ3zGT12LSqk81j/9w17B6L+yazevT/NfDYsv8zo8fnTXIB7FGsmXlJ+RUJr
  BldjzpZCxYYVExp+8fSwLhXtYuRi0NIYCqTxI32O+wQzlImiecHJwA5HBwsAqoSl+b5dTFycr
  AJqEkseL2KGcQWEdCSOPblK1g9s0AHs8Sie42sIAlhAUuJeb8+sYHYvALKEtfe3GUBsYUEkiR
  6T9xkhYgLSpyc+QQsziygI7Fz6x02kF3MAtISy/9xQITlJZq3zmYGCXMKmEhcus02gZFvFpLm
  WUiaZyE0z0LSvICRZRWjVVJRZnpGSW5iZo6uoYGBrqGhia6ZJRDpJVbpJuqVFuumJhaX6BrpJ
  ZYX66UWF+sVV+Ym56To5aWWbGIERlBKkavrDsa1q37qHWKU5GBSEuVV6XFNFuJLyk+pzEgszo
  gvKs1JLT7EKMPBoSTBO+ssUE6wKDU9tSItMwcYzTBpCQ4eJRHe95uB0rzFBYm5xZnpEKlTjJY
  cf7f+3s/MMXX2PyDZub/rALMQS15+XqqUOG8AyDwBkIaM0jy4cbCEc4lRVkqYl5GBgUGIpyC1
  KDezBFX+FaM4B6OSMG/IGaApPJl5JXBbXwEdxAR00MmrTiAHlSQipKQamARWmkq8nnn2xuuGi
  2dcWaq1bfs0MudEHH+8p1N8U+MSP8MZfX1Mmv1990XcjYP5A57yKHF8Ce85nbNfQTCUtyPAlb
  G8/nyns0db5/UDl27Erni/89S1H7MVI6RsqrdmNGa0anaJqDDyn9rte7ZaaPGJlRLrDhcfYpr
  9lselYGqr9rVLyTsYes6JHQ1azZLB+fP90Zw1zHHu1a31U/hUTXfseiLy7alkmuYdrZ5mLWNN
  A26Rp9ttl05KuOrIdn9G6pYdDT6Sd/MWnhF5GXPSTzXk41u34E0s99/IvyqqZ7jgGq5lyycp8
  0hor9Kvyv7d2xN6d3glfRBY2id7PviX7bqDMhu+Bi9f3ZhVnBCgxFKckWioxVxUnAgAiZr5hr
  MDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-18.tower-635.messagelabs.com!1665519383!41889!1
X-Originating-IP: [104.232.228.22]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27661 invoked from network); 11 Oct 2022 20:16:23 -0000
Received: from unknown (HELO va32lpfpp02.lenovo.com) (104.232.228.22)
  by server-18.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Oct 2022 20:16:23 -0000
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4Mn6Vv117Cz50GH4;
        Tue, 11 Oct 2022 20:16:23 +0000 (UTC)
Received: from p1g3 (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Mn6Vt6rN3zbxPg;
        Tue, 11 Oct 2022 20:16:22 +0000 (UTC)
Date:   Tue, 11 Oct 2022 15:16:04 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] uvc gadget performance issues
Message-ID: <Y0XPBAn12Cr2KHU4@p1g3>
References: <20221011183437.298437-1-w36195@motorola.com>
 <20221011194808.GH27626@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221011194808.GH27626@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Appreciate the support!

On Tue, Oct 11, 2022 at 09:48:08PM +0200, Michael Grzeschik wrote:
> Hi Dan!
> 
> Thanks for the patches.
> 
> On Tue, Oct 11, 2022 at 01:34:32PM -0500, Dan Vacura wrote:
> > Hello uvc gadget developers,
> > 
> > Please find my V2 series with added patches to disable these performance
> > features at the userspace level for devices that don't work well with
> > the UDC hw, i.e. dwc3 in this case. Also included are updates to
> > comments for the v1 patch.
> > 
> > Original note:
> > 
> > I'm working on a 5.15.41 based kernel on a qcom chipset with the dwc3
> > controller and I'm encountering two problems related to the recent performance
> > improvement changes:
> > 
> > https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16762-5-m.grzeschik@pengutronix.de/  and
> > https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16762-6-m.grzeschik@pengutronix.de/
> > 
> > If I revert these two changes, then I have much improved stability and a
> > transmission problem I'm seeing is gone. Has there been any success from
> > others on 5.15 with this uvc improvement and any recommendations for my
> > current problems?  Those being:
> > 
> > 1) a smmu panic, snippet here: 
> > 
> >    <3>[  718.314900][  T803] arm-smmu 15000000.apps-smmu: Unhandled arm-smmu context fault from a600000.dwc3!
> >    <3>[  718.314994][  T803] arm-smmu 15000000.apps-smmu: FAR    = 0x00000000efe60800
> >    <3>[  718.315023][  T803] arm-smmu 15000000.apps-smmu: PAR    = 0x0000000000000000
> >    <3>[  718.315048][  T803] arm-smmu 15000000.apps-smmu: FSR    = 0x40000402 [TF R SS ]
> >    <3>[  718.315074][  T803] arm-smmu 15000000.apps-smmu: FSYNR0    = 0x5f0003
> >    <3>[  718.315096][  T803] arm-smmu 15000000.apps-smmu: FSYNR1    = 0xaa02
> >    <3>[  718.315117][  T803] arm-smmu 15000000.apps-smmu: context bank#    = 0x1b
> >    <3>[  718.315141][  T803] arm-smmu 15000000.apps-smmu: TTBR0  = 0x001b0000c2a92000
> >    <3>[  718.315165][  T803] arm-smmu 15000000.apps-smmu: TTBR1  = 0x001b000000000000
> >    <3>[  718.315192][  T803] arm-smmu 15000000.apps-smmu: SCTLR  = 0x0a5f00e7 ACTLR  = 0x00000003
> >    <3>[  718.315245][  T803] arm-smmu 15000000.apps-smmu: CBAR  = 0x0001f300
> >    <3>[  718.315274][  T803] arm-smmu 15000000.apps-smmu: MAIR0   = 0xf404ff44 MAIR1   = 0x0000efe4
> >    <3>[  718.315297][  T803] arm-smmu 15000000.apps-smmu: SID = 0x40
> >    <3>[  718.315318][  T803] arm-smmu 15000000.apps-smmu: Client info: BID=0x5, PID=0xa, MID=0x2
> >    <3>[  718.315377][  T803] arm-smmu 15000000.apps-smmu: soft iova-to-phys=0x0000000000000000
> > 
> >    I can reduce this panic with the proposed patch, but it still happens until I
> >    disable the "req->no_interrupt = 1" logic.
> 
> This actually smells very much like an race between hardware and
> software, that is probably working on the same memory. I would guess
> that the hardware in the non interrupt case is currently processing
> queued memory, while at the same time the software stack will update
> that same memory with new data.
> 
> In my opinion this should be fixed, rather then making the interrupt
> load optional. Also we could discuss if an option to adjust the load
> adds some extra value, but out of this issue scope you describe here.

Yes, I agree this should be fixed and it could just be an issue with the
dwc3 driver. I'd need help on this as an understanding of what the hw is
doing is needed to timely rootcause the issue.

As for giving the option to reduce the load to userspace, I thought it'd
be helpful for others since it seems this is the only gadget driver that
uses this option and the amount that is hardcoded may be desired to be
adjusted, like in my case to always interrupt. Although, if the bug
didn't exist, I'd be fine with the existing hardcode.

As for reproducing, did you try this with the sg functionality disabled?
The crash seems to occur sooner in that setup.

> 
> Also, is this issue also being more likely to happen when streaming YUYV?
> 
> > 2) The frame is not fully transmitted in dwc3 with sg support enabled.
> > 
> >    There seems to be a mapping limit I'm seeing where only the roughly first
> >    70% of the total frame is sent. Interestingly, if I allocate a larger
> >    size for the buffer upfront, in uvc_queue_setup(), like sizes[0] =
> >    video->imagesize * 3. Then the issue rarely happens. For example, when I
> >    do YUYV I see green, uninitialized data, at the bottom part of the
> >    frame. If I do MJPG with smaller filled sizes, the transmission is fine.
> > 
> >    +-------------------------+
> >    |                         |
> >    |                         |
> >    |                         |
> >    |      Good data          |
> >    |                         |
> >    |                         |
> >    |                         |
> >    +-------------------------+
> >    |xxxxxxxxxxxxxxxxxxxxxxxxx|
> >    |xxxx  Bad data  xxxxxxxxx|
> >    |xxxxxxxxxxxxxxxxxxxxxxxxx|
> >    +-------------------------+
> > 
> 
> I did not stream with YUYV for some time. I will do that and try to
> reproduce the issues you describe.
> 
> I also have an patch in the queue that will limit the sg support for
> devices with speed > HIGH_SPEED. Because of the overhead of the limited
> transfer payload of 1024*3 Bytes, it is possible that a simple memcpy
> will actually be fast enough. But for that patch I still have to make
> proper measurements. Btw. which USB speed are you transferring with?

This happens with both super speed and high speed setups. Another
developer also mentioned problems with sg support and had to disable it
https://lore.kernel.org/linux-usb/0de496bf-fbc6-a2a1-a967-9a0580a7b1eb@ideasonboard.com/T/#mf06aa48ec53ed4c174601f03f397bd296f09efe5
but didn't have problems with dwc2.

> 
> Regards,
> Michael
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


