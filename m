Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E210602F10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJRPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:00:37 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381D80EB5;
        Tue, 18 Oct 2022 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1666105234; i=@motorola.com;
        bh=OQIR5JHt3RbsHgbFnrntOXnmw1XmfWgv1MaD2OIA/Vs=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=oW++jxUQNpdHpQa0DpwxforqJeCSdRRRO2T/wTvx9s/acY8YgLYAPelU3W7gbXUyf
         0dpG9fkjZF+fV3l7JWoYj2hgfMXB1hqQ11IO9pvcC78xsKw9i88gEDzpleDvszXhUZ
         shIqPhO6e1+5ZOwhAYxls4ttfOdJ6EnIHjZDZBDWfBM4bMe8yByEzEf7BXt00QRv/X
         RulNUBYAHW5kkBn2B52mUrpoFHIUo5+wps+fuk0yKiKFos5wnkAKLVgAS76kR0Ljly
         PiKG5UnS7gduedEYywE6Skx5OiXI0cDME+uqIL5+SUoZMJ67BUjh30EM1pAZLJUK8J
         UP/xkoc3FPSBA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsWS8eKJhO7E/X7
  JBs/2CVgca3vCbvHkQDujRe+yPWwWzYvXs1l0TlzCbrGwbQmLxeVdc9gsFi1rZbY4MTnW4sef
  PmaLVQsOsDtwe8zumMnqsWlVJ5vH/rlr2D0W901m9ej/a+CxZf9nRo/Pm+QC2KNYM/OS8isSW
  DOWPpnHXrDevuLQoulsDYw/TLoYuTiEBKYzSXxsn8YO4SxjkjjbuYO1i5GTg0VAVeL0nhZ2EJ
  tNQE1iwetVzCC2iICORPfNLYwgDcwCK5glXm5+zgSSEBYIlHj24CsjiM0roCyxYOciRoipTUw
  S56asZ4FICEqcnPkEzGYGmrRz6x22LkYOIFtaYvk/DoiwvETz1tlgyzgFXCRufetjn8DINwtJ
  9ywk3bMQumch6V7AyLKK0aw4tagstUjX0FIvqSgzPaMkNzEzRy+xSjdRr7RYNzWxuETXUC+xv
  FgvtbhYr7gyNzknRS8vtWQTIzB+UoqYD+xgnL3sj94hRkkOJiVR3oqdfslCfEn5KZUZicUZ8U
  WlOanFhxhlODiUJHjn7QXKCRalpqdWpGXmAGMZJi3BwaMkwvtlE1Cat7ggMbc4Mx0idYrRmGP
  q7H/7mTk693cdYBZiycvPS5US5123GahUAKQ0ozQPbhAsxVxilJUS5mVkYGAQ4ilILcrNLEGV
  f8UozsGoJMzbC3IPT2ZeCdy+V0CnMAGdYroF7JSSRISUVAOTrazo4R2ej6TLtTj2fPr/MdP/m
  vUnI4VbLNf9ludcDnsle1agI27GtamdLzrOqxzcFvT4af6C0pLuhCfWzCH/POf+T1381yWv/O
  nnnvRdc/bxZz247B/HnXgi8Pea2A2TOjz0XLS/z4ydnHn09K4d8W2lrTqp0x2rhI+WZ5lO+KP
  fXlRw/uPf5KmvHzAfnc16i5Xb4Z1Y+sZZm48LskZmnf+8J1+L6Zyk/vrGhie1TY0PWRNPxy6a
  wZO6cJPAhH89Z29a/8lz2BIowtvZu/R51JRl6x8ELUpmerD+unNl27wHIac2Ccy6dk10XfbCy
  an/A4OitV/XMvS8V/LekmO2Kna3fUrnVi3br38T6qeKKrEUZyQaajEXFScCAH454nSsAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-11.tower-706.messagelabs.com!1666105233!718799!1
X-Originating-IP: [104.232.228.24]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10333 invoked from network); 18 Oct 2022 15:00:33 -0000
Received: from unknown (HELO va32lpfpp04.lenovo.com) (104.232.228.24)
  by server-11.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Oct 2022 15:00:33 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp04.lenovo.com (Postfix) with ESMTPS id 4MsH9F00mTzgK7f;
        Tue, 18 Oct 2022 15:00:33 +0000 (UTC)
Received: from p1g3 (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4MsH9D55KVzf6WS;
        Tue, 18 Oct 2022 15:00:32 +0000 (UTC)
Date:   Tue, 18 Oct 2022 10:00:06 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     Dan Scally <dan.scally@ideasonboard.com>
Cc:     Michael Grzeschik <mgr@pengutronix.de>, linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 6/6] usb: gadget: uvc: add configfs option for sg
 support
Message-ID: <Y06/dr1SWiwEdo9p@p1g3>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-7-w36195@motorola.com>
 <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
 <20221018140432.GE5651@pengutronix.de>
 <7df3432a-c725-73f1-a5c7-914849e826e6@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7df3432a-c725-73f1-a5c7-914849e826e6@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Michael,

On Tue, Oct 18, 2022 at 03:10:38PM +0100, Dan Scally wrote:
> Hi Michael - again!
> 
> On 18/10/2022 15:04, Michael Grzeschik wrote:
> > Hi Dan!
> > Hi Dan!
> > 
> > On Tue, Oct 18, 2022 at 02:27:13PM +0100, Dan Scally wrote:
> > > Hi Dan
> > > 
> > > On 17/10/2022 21:54, Dan Vacura wrote:
> > > > The scatter gather support doesn't appear to work well with some
> > > > UDC hw.
> > > > Add the ability to turn on the feature depending on the controller in
> > > > use.
> > > > 
> > > > Signed-off-by: Dan Vacura <w36195@motorola.com>
> > > 
> > > 
> > > Nitpick: I would call it use_sg everywhere, but either way:
> > 
> > Or even only "scatter_gather". How does that sound?
> 
> 
> I think I prefer use_sg actually, but I don't have a strong feeling either
> way.

I went with sg_supported since use_sg and scatter_gather may imply that
the feature will be guaranteed to be used if set to 1. I thought that
sg_supported conveyed that the driver supports sg ability and expressed
that it'll be used if the UDC driver supports it. Also, that name is
used in struct usb_gadget, with the similar wording: "true if we can
handle scatter-gather".

> 
> > 
> > > 
> > > Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> > > 
> > > Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
> > > 
> > > > ---
> > > > V1 -> V2:
> > > > - no change, new patch in serie
> > > > V2 -> V3:
> > > > - default on, same as baseline
> > > > 
> > > >  Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
> > > >  Documentation/usb/gadget-testing.rst              | 2 ++
> > > >  drivers/usb/gadget/function/f_uvc.c               | 2 ++
> > > >  drivers/usb/gadget/function/u_uvc.h               | 1 +
> > > >  drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
> > > >  drivers/usb/gadget/function/uvc_queue.c           | 4 ++--
> > > >  6 files changed, 10 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > > > b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > > > index 5dfaa3f7f6a4..839a75fc28ee 100644
> > > > --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > > > +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> > > > @@ -9,6 +9,7 @@ Description:    UVC function directory
> > > >          streaming_interval    1..16
> > > >          function_name        string [32]
> > > >          req_int_skip_div    unsigned int
> > > > +        sg_supported        0..1
> > > >          ===================    =============================
> > > >  What: /config/usb-gadget/gadget/functions/uvc.name/control
> > > > diff --git a/Documentation/usb/gadget-testing.rst
> > > > b/Documentation/usb/gadget-testing.rst
> > > > index f9b5a09be1f4..8e3072d6a590 100644
> > > > --- a/Documentation/usb/gadget-testing.rst
> > > > +++ b/Documentation/usb/gadget-testing.rst
> > > > @@ -796,6 +796,8 @@ The uvc function provides these attributes
> > > > in its function directory:
> > > >      function_name       name of the interface
> > > >      req_int_skip_div    divisor of total requests to aid in
> > > > calculating
> > > >                  interrupt frequency, 0 indicates all interrupt
> > > > +    sg_supported        allow for scatter gather to be used if the UDC
> > > > +                hw supports it
> > > >      ===================
> > > > ================================================
> > > >  There are also "control" and "streaming" subdirectories, each
> > > > of which contain
> > > > diff --git a/drivers/usb/gadget/function/f_uvc.c
> > > > b/drivers/usb/gadget/function/f_uvc.c
> > > > index e40ca26b9c55..d08ebe3ffeb2 100644
> > > > --- a/drivers/usb/gadget/function/f_uvc.c
> > > > +++ b/drivers/usb/gadget/function/f_uvc.c
> > > > @@ -656,6 +656,7 @@ uvc_function_bind(struct usb_configuration
> > > > *c, struct usb_function *f)
> > > >                  (opts->streaming_maxburst + 1));
> > > >      uvc->config_skip_int_div = opts->req_int_skip_div;
> > > > +    uvc->video.queue.use_sg = opts->sg_supported;
> > 
> > Why do you set this here?

This is set here to enable or disable the support. I wasn't aware of
direct access to opts in uvcg_queue_init(). I'll update to use it
directly as that'll be more clear.

> > 
> > > >      /* Allocate endpoints. */
> > > >      ep = usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
> > > > @@ -875,6 +876,7 @@ static struct usb_function_instance
> > > > *uvc_alloc_inst(void)
> > > >      opts->streaming_interval = 1;
> > > >      opts->streaming_maxpacket = 1024;
> > > >      opts->req_int_skip_div = 4;
> > > > +    opts->sg_supported = 1;
> > > >      snprintf(opts->function_name, sizeof(opts->function_name),
> > > > "UVC Camera");
> > > >      ret = uvcg_attach_configfs(opts);
> > > > diff --git a/drivers/usb/gadget/function/u_uvc.h
> > > > b/drivers/usb/gadget/function/u_uvc.h
> > > > index 6f73bd5638ed..5ccced629925 100644
> > > > --- a/drivers/usb/gadget/function/u_uvc.h
> > > > +++ b/drivers/usb/gadget/function/u_uvc.h
> > > > @@ -25,6 +25,7 @@ struct f_uvc_opts {
> > > >      unsigned int                    streaming_maxpacket;
> > > >      unsigned int                    streaming_maxburst;
> > > >      unsigned int                    req_int_skip_div;
> > > > +    unsigned int                    sg_supported;
> > > >      unsigned int                    control_interface;
> > > >      unsigned int                    streaming_interface;
> > > > diff --git a/drivers/usb/gadget/function/uvc_configfs.c
> > > > b/drivers/usb/gadget/function/uvc_configfs.c
> > > > index 419e926ab57e..3784c0e02d01 100644
> > > > --- a/drivers/usb/gadget/function/uvc_configfs.c
> > > > +++ b/drivers/usb/gadget/function/uvc_configfs.c
> > > > @@ -2351,6 +2351,7 @@ UVCG_OPTS_ATTR(streaming_interval,
> > > > streaming_interval, 16);
> > > >  UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 3072);
> > > >  UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
> > > >  UVCG_OPTS_ATTR(req_int_skip_div, req_int_skip_div, UINT_MAX);
> > > > +UVCG_OPTS_ATTR(sg_supported, sg_supported, 1);
> > > >  #undef UVCG_OPTS_ATTR
> > > > @@ -2401,6 +2402,7 @@ static struct configfs_attribute *uvc_attrs[] = {
> > > >      &f_uvc_opts_attr_streaming_maxpacket,
> > > >      &f_uvc_opts_attr_streaming_maxburst,
> > > >      &f_uvc_opts_attr_req_int_skip_div,
> > > > +    &f_uvc_opts_attr_sg_supported,
> > > >      &f_uvc_opts_string_attr_function_name,
> > > >      NULL,
> > > >  };
> > > > diff --git a/drivers/usb/gadget/function/uvc_queue.c
> > > > b/drivers/usb/gadget/function/uvc_queue.c
> > > > index 02559906a55a..3c7aa5c4bba2 100644
> > > > --- a/drivers/usb/gadget/function/uvc_queue.c
> > > > +++ b/drivers/usb/gadget/function/uvc_queue.c
> > > > @@ -149,11 +149,11 @@ int uvcg_queue_init(struct uvc_video_queue
> > > > *queue, struct device *dev, enum v4l2
> > > >      queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
> > > >      queue->queue.ops = &uvc_queue_qops;
> > > >      queue->queue.lock = lock;
> > > > -    if (cdev->gadget->sg_supported) {
> > > > +    if (queue->use_sg && cdev->gadget->sg_supported) {
> > > >          queue->queue.mem_ops = &vb2_dma_sg_memops;
> > > > -        queue->use_sg = 1;
> > > >      } else {
> > > >          queue->queue.mem_ops = &vb2_vmalloc_memops;
> > > > +        queue->use_sg = false;
> > 
> > I am unsure, but can you actually not always use vb2_dma_sg_memops.
> > 
> > With my last patch we always set buf->mem to vb2_plane_vaddr(vb, 0);
> > 
> > https://lore.kernel.org/linux-usb/20221017221141.3134818-1-m.grzeschik@pengutronix.de/T/#u
> > 
> > 
> > 
> > The condition to decide if encode_isoc_sg or encode_isoc should then
> > remain the last place to switch between sg or not. I would hook the
> > userspace decision in here.
> > 
> > You can also directly get to opts->scatter_gather by using
> > 
> >     struct f_uvc_opts *opts = fi_to_f_uvc_opts(uvc->func.fi);
> > 
> > in the function uvcg_video_enable.
> > 
> > > >      }
> > > >      queue->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY
> > > 
> > 
> > Thanks,
> > Michael
> > 
