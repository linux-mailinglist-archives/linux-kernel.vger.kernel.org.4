Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10597418E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjF1Tbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjF1TbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:31:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70910F0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:31:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a01so3762225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687980674; x=1690572674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2cD9nWDKqFEBglacIaBSQSC9LLpc/QEKjNb3hi7bLXI=;
        b=e5O2fp29bH+Q4XLcW49jbx/kd2WjPftE8K8LTFE85N4KzKnC6HAItFODdYDU2Up0zG
         6D1xWGhiPfrHRAwiW61l0xj84J8nSSLwdbyLULASCR8SYqcfbo31/rBi/OS7HgOdZyxf
         lPW2yOdUqqT/o1P6AK6IL4s/VGaxD+3Mk7aNWG5A/Ip9HKvOpAZsmkhzU++53iaK6Mx8
         i1u+/aDZJNfU/g4ldHdbqkfIH1r/6GjP5uZlf3EydcZqGAWVY+V58GpspZL8kJFDymIB
         IYDBn0j1M00qboiAByZpnNaxmAjJBsKqFdQTWwNx981QXFybd1pEGeBO6q4ZB1IuIKDa
         JVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980674; x=1690572674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cD9nWDKqFEBglacIaBSQSC9LLpc/QEKjNb3hi7bLXI=;
        b=TT05a/wVZdQ82zKLKAuqWoiuB0XJ3mbONzcMAa4BMgkv5BwG/oJLPV652VCV9PXBbP
         aMjQ50bsQumgbl3NqPUhgHEB/KJfK0Hd+Wr9LksQKIBvVFfEGL/LAXy+VZ0hulGYkSzX
         dRR8RrzBtyk+av3c6GdtB5zY66NDmwokgPcnU6sgqQwgo16FtP9YO1Pg2ROZ/9ZMI0c5
         pDx2KJOHeCfjZoShAEZCburtcpgQ8oMAMv/2zMdeNVo9QicBimJzYnilpNkenOJe3fXN
         TVeSXqKIzvWVYkTB4jYQ9TYfTYLmltosFDJ5nXsD+ZLPvlm8um7eQNV15USK9MrU95hL
         q/jQ==
X-Gm-Message-State: AC+VfDxW26uXPIhvN0hLbjOvm59ackK+dW4DeOe+RiqIQXXcFwPRhITS
        3Y/0/dloI8ejjg+eJv0OpUgJaQpxD9bgwUZa6PtOXQHOJmjOUPRP60k=
X-Google-Smtp-Source: ACHHUZ4hcyhmKJ3v60dhxsUbIZrTLohLwTXOAXWNKivCQTfG8O74AI7kC/vrcQ+ZSBrq5+aKbJenLOR35JHBptod29A=
X-Received: by 2002:a5d:4910:0:b0:314:144:adb2 with SMTP id
 x16-20020a5d4910000000b003140144adb2mr4728766wrq.5.1687980674560; Wed, 28 Jun
 2023 12:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230625123514.4069724-1-peng.fan@oss.nxp.com>
 <ZJtlF/tzh0ZMXji4@p14s> <DU0PR04MB94177CF1F7EEBD1EBF4B177A8824A@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94177CF1F7EEBD1EBF4B177A8824A@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 28 Jun 2023 13:31:03 -0600
Message-ID: <CANLsYkzZ=resYxStMDEkqEksWiVngH_hJ+wB=z94fqpTtU7PnQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx callback
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 18:55, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx
> > callback
> >
> > On Sun, Jun 25, 2023 at 08:35:14PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The current code has an assumption that there is one tx and one rx
> > > vring, but it is not always true. There maybe more vrings. So iterate
> > > all notifyids to not miss any vring events.
> >
> > Can you be more specific on the use case where more than 2 virqueues are
> > allocated?  The remoteproc core can handle more than 2 but right now the
> > only configuration I see doesn't support more than that.
>
> In downstream tree, we have below remoteproc node. It use
> vdev0 vring0/vring1 for vdev0, vdev1 vring0/vring1 for vdev1.
> vdev0 and vdev1 are for different services, saying vdev0 for gpio rpmsg,
> vdev1 for i2c rpmsg.

So you are talking about cases where more than one vdev are
instantiated and a single callback channel is available.  Please fix
your changelog description.  The way it is currently written one can
easily think you are referring to more than 2 virtqueues for each
vdev.

One more comment below.

>         cm33: imx93-cm33 {
>                 compatible = "fsl,imx93-cm33";
>                 mbox-names = "tx", "rx", "rxdb";
>                 mboxes = <&mu1 0 1
>                           &mu1 1 1
>                           &mu1 3 1>;
>                 memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
>                                 <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
>                 fsl,startup-delay-ms = <500>;
>         };
>
> Thanks,
> Peng.
>
> >
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index f9874fc5a80f..e3f40d0e9f3d
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -725,13 +725,23 @@ static int imx_rproc_addr_init(struct imx_rproc
> > *priv,
> > >     return 0;
> > >  }
> > >
> > > +static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data) {
> > > +   struct rproc *rproc = data;
> > > +
> > > +   if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
> > > +           dev_dbg(&rproc->dev, "no message in vqid: %d\n", id);
> > > +

A debug message is already displayed by vring_interrupt(), please remove.

Thanks,
Mathieu

> > > +   return 0;
> > > +}
> > > +
> > >  static void imx_rproc_vq_work(struct work_struct *work)  {
> > >     struct imx_rproc *priv = container_of(work, struct imx_rproc,
> > >                                           rproc_work);
> > > +   struct rproc *rproc = priv->rproc;
> > >
> > > -   rproc_vq_interrupt(priv->rproc, 0);
> > > -   rproc_vq_interrupt(priv->rproc, 1);
> > > +   idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
> > >  }
> > >
> > >  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
> > > --
> > > 2.37.1
> > >
