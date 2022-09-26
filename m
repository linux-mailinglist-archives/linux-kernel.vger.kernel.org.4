Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF75EB2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIZUvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiIZUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:51:50 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D256CAB4D5;
        Mon, 26 Sep 2022 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1664225506; i=@motorola.com;
        bh=RzoZZDuJ7nr+5dDl9bJzdwf8D/UD7w2f1YBxjHoqDUE=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=CNge8zQLZfl2Tpe53VdIPkB+KFm7M/pDUTYYU6TQGmfkQm1367GJIOnmxE0HXA8Ec
         dOlZZ+Bbc6RWpAvrBXTW4i8+6rjtf1FmnjomkJC+NKbt1fILLr9kjrGsPzf2pz8vPY
         KTvuh858N8DLiTDPuZxng1a8UdpwVMy7+mddBiRWhx1OQ6frRig5jDix0WftQQsmNU
         U1uDHuom5gzvyueHIDEGwdmQ8vdeeQVCbtuayshEDKc27azeQbQOJjw4tKDByBjMVC
         wNZuuW+WDTfBSXZVuMcHU5YNPiDYV1QfLJdxhRJvp0KLA52outgLZ04HCWdfh8jwEn
         Y6Oo86IRSwD3Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42KZsKfBWfehgFG
  ywfsNShbH2p6wWzQvXs9m0TlxCbvF5V1z2CwWLWtltjgxOdZi1YID7A7sHrM7ZrJ6bFrVyeax
  f+4ado/+vwYeW/Z/ZvT4vEkugC2KNTMvKb8igTVj/ZT1LAWdOhXL1xxibmDcqdTFyMUhJDCNS
  eLhn5msEM5iJolnE54COZwcLAKqEpu2v2IHsdkE1CQWvF7FDGKLCGhJHPvylR2kgVngI6PE14
  MHwIqEBSwleg7vZwKxeQWUJS782whmCwkkSRzb0McGEReUODnzCQuIzSygI7Fz6x2gOAeQLS2
  x/B8HRFheonnrbLBdnAImEq8adjJOYOSbhaR7FpLuWQjds5B0L2BkWcVolVSUmZ5RkpuYmaNr
  aGCga2hoomuoa2RqpJdYpZuoV1qsm5pYXKJrqJdYXqyXWlysV1yZm5yTopeXWrKJERgTKUWMf
  3Ywdvb81DvEKMnBpCTKK77PMFmILyk/pTIjsTgjvqg0J7X4EKMMB4eSBK8ln1GykGBRanpqRV
  pmDjA+YdISHDxKIrzNf4BaeYsLEnOLM9MhUqcYLTn+bv29n5lj6ux/QLJzf9cBZiGWvPy8VCl
  x3icg8wRAGjJK8+DGwVLIJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvGUgU3gy80rgtr4C
  OogJ6CA7Pn2Qg0oSEVJSDUyiGgnCSec2hSqq7VIznnt+6QoeVdH2kzmOJbM+fD/UGn/45v9VH
  +YHfWo5u+X7ei8pfQeuC38Ff6pJxdToVFUYPUnRC/3vN+tMvzjnZQtZieznj5OVfEqPrTqreP
  jkWtcjXbKFDx+bG/0/nl1z8v/7P6midw5cWDH7hrlo5AWTSts78ocbzwf4HD2yqDJcof9sUdr
  qMyHOq7gfMnHfXvb/xurCk2s/GIY2ZE0Nn154eO7UZZkn+Vi94lZ9fP6u8u1f8QlvzuptetO8
  3cwsN+VUrXWn1Z/dj6fdvfJvxdqj63leneubunyHgJB48rLJK35Zzzl5LijCuFhZaJodi1BXW
  Gyur8aVZ67bkicfaXI9qcRSnJFoqMVcVJwIAF7M2hOcAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-4.tower-706.messagelabs.com!1664225505!212377!1
X-Originating-IP: [144.188.128.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5560 invoked from network); 26 Sep 2022 20:51:45 -0000
Received: from unknown (HELO ilclpfpp01.lenovo.com) (144.188.128.67)
  by server-4.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Sep 2022 20:51:45 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4Mbw0d0hgQzbqZG;
        Mon, 26 Sep 2022 20:51:45 +0000 (UTC)
Received: from p1g3 (unknown [10.45.6.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Mbw0c4G5vzftPJ;
        Mon, 26 Sep 2022 20:51:44 +0000 (UTC)
Date:   Mon, 26 Sep 2022 15:51:31 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] uvc gadget sg performance issues
Message-ID: <YzIQ07475qkpoI2p@p1g3>
References: <20220926195307.110121-1-w36195@motorola.com>
 <20220926201541.GH20022@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926201541.GH20022@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, thanks for the prompt reply!

On Mon, Sep 26, 2022 at 10:15:41PM +0200, Michael Grzeschik wrote:
> Hi Dan!
> 
> On Mon, Sep 26, 2022 at 02:53:06PM -0500, Dan Vacura wrote:
> > 
> > Hello uvc gadget developers,
> > 
> > I'm working on a 5.15.41 based kernel on a qcom chipset with the dwc3
> > controller and I'm encountering two problems related to the recent performance
> > improvement changes:
> 
> What's about that odd kernel number. UVC is under heavy development, if
> you plan to work with this code, you should probably test top of tree.

Yes, it's a bit behind and it looks like some of the initial work you
did for scatter/gather got pulled into the 5.15 tree, but subsequent
changes didn't. I don't have much control over the kernel versioning as
we're part of the GKI Android initiative:
https://source.android.com/docs/core/architecture/kernel/generic-kernel-image
and we can only work off of what is provided, like this release line:
https://android.googlesource.com/kernel/common/+log/refs/heads/android13-5.15

Perhaps we can revert these changes for the 5.15 kernel (and other
versions) they were not intended for?

> 
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
> > 
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
> > 
> > Appreciate any thoughts or feedback related to these issues.
> 
> Anyway, this is probably due to the frames being given back to early to
> the frameproducer. We have the following patches mainline now to fix this issue:
> 
> aef11279888c00e1841a3533a35d279285af3a51 usb: gadget: uvc: improve sg exit condition
> 9b969f93bcef9b3d9e92f1810e22bbd6c344a0e5 usb: gadget: uvc: giveback vb2 buffer on req complete

Yes, I did grab those in addition to some other necessary changes, noted
in my patch here:
https://patchwork.kernel.org/project/linux-usb/patch/20220926195307.110121-2-w36195@motorola.com/ 
I also pulled a lot of patches from the dwc3 to be almost at parity with
top of tree for the core.c/h, ep0.c/h, and gadget.c/h files, but these
issues persisted.

Out of curiosity, have you tested these changes with dwc3 and if so,
have you tried "usb: gadget: uvc: decrease the interrupt load to a
quarter" with scatter/gather disabled? For me the crash occurs more
often.

Thanks,

Dan

> 
> You might need some patches beforehand to get them applied on your
> stack.
> 
> Regards,
> Michael
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


