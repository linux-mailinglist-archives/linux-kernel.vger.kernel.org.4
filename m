Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434C0677756
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjAWJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjAWJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:24:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1915547
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:24:23 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pJt3f-0000OC-Dl; Mon, 23 Jan 2023 10:24:07 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pJt3d-0000se-BA; Mon, 23 Jan 2023 10:24:05 +0100
Date:   Mon, 23 Jan 2023 10:24:05 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH v2] staging: media: imx: change
 imx_media_fim_set_stream() to return void
Message-ID: <20230123092405.lwaosnsnlj7tvnmt@pengutronix.de>
References: <Y7RoDHnyHNnlPV71@qemulion>
 <Y82VVFFdUbww+BuS@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y82VVFFdUbww+BuS@ubun2204.myguest.virtualbox.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch lgtm.

On 23-01-23, Deepak R Varma wrote:
> On Tue, Jan 03, 2023 at 11:08:20PM +0530, Deepak R Varma wrote:
> > At present, the function imx_media_fim_set_stream() always returns 0.
> > So, convert it to be a function returning void instead. Issue identified
> > using the returnvar.cocci Coccinelle semantic patch.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> > ---
> > Changes in v2:
> >    1. Convert the function return type from int to void. Suggested by
> >       Fabio Estevam <festevam@gmail.com>
> >    2. Update patch subject and log accordingly.
> 
> Hello,
> May I request a review and feedback comment on this patch proposal please?
> 
> Thank you,
> ./drv
> 
> > 
> > 
> >  drivers/staging/media/imx/imx-media-csi.c | 7 ++-----
> >  drivers/staging/media/imx/imx-media-fim.c | 8 +++-----
> >  drivers/staging/media/imx/imx-media.h     | 6 +++---
> >  3 files changed, 8 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> > index 5c3cc7de209d..44d87fe30d52 100644
> > --- a/drivers/staging/media/imx/imx-media-csi.c
> > +++ b/drivers/staging/media/imx/imx-media-csi.c
> > @@ -779,11 +779,8 @@ static int csi_start(struct csi_priv *priv)
> >  		goto idmac_stop;
> > 
> >  	/* start the frame interval monitor */
> > -	if (priv->fim && priv->dest == IPU_CSI_DEST_IDMAC) {
> > -		ret = imx_media_fim_set_stream(priv->fim, output_fi, true);
> > -		if (ret)
> > -			goto idmac_stop;
> > -	}
> > +	if (priv->fim && priv->dest == IPU_CSI_DEST_IDMAC)
> > +		imx_media_fim_set_stream(priv->fim, output_fi, true);
> > 
> >  	ret = ipu_csi_enable(priv->csi);
> >  	if (ret) {
> > diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> > index fb6590dcfc36..f456751f100a 100644
> > --- a/drivers/staging/media/imx/imx-media-fim.c
> > +++ b/drivers/staging/media/imx/imx-media-fim.c
> > @@ -368,12 +368,11 @@ void imx_media_fim_eof_monitor(struct imx_media_fim *fim, ktime_t timestamp)
> >  }
> > 
> >  /* Called by the subdev in its s_stream callback */
> > -int imx_media_fim_set_stream(struct imx_media_fim *fim,
> > -			     const struct v4l2_fract *fi,
> > -			     bool on)
> > +void imx_media_fim_set_stream(struct imx_media_fim *fim,
> > +			      const struct v4l2_fract *fi,
> > +			      bool on)
> >  {
> >  	unsigned long flags;
> > -	int ret = 0;
> > 
> >  	v4l2_ctrl_lock(fim->ctrl[FIM_CL_ENABLE]);
> > 
> > @@ -393,7 +392,6 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
> >  	fim->stream_on = on;
> >  out:
> >  	v4l2_ctrl_unlock(fim->ctrl[FIM_CL_ENABLE]);
> > -	return ret;
> >  }
> > 
> >  int imx_media_fim_add_controls(struct imx_media_fim *fim)
> > diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> > index f679249d82e4..6f9a46573edd 100644
> > --- a/drivers/staging/media/imx/imx-media.h
> > +++ b/drivers/staging/media/imx/imx-media.h
> > @@ -246,9 +246,9 @@ int imx_media_dev_notifier_register(struct imx_media_dev *imxmd,
> >  /* imx-media-fim.c */
> >  struct imx_media_fim;
> >  void imx_media_fim_eof_monitor(struct imx_media_fim *fim, ktime_t timestamp);
> > -int imx_media_fim_set_stream(struct imx_media_fim *fim,
> > -			     const struct v4l2_fract *frame_interval,
> > -			     bool on);
> > +void imx_media_fim_set_stream(struct imx_media_fim *fim,
> > +			      const struct v4l2_fract *frame_interval,
> > +			      bool on);
> >  int imx_media_fim_add_controls(struct imx_media_fim *fim);
> >  struct imx_media_fim *imx_media_fim_init(struct v4l2_subdev *sd);
> >  void imx_media_fim_free(struct imx_media_fim *fim);
> > --
> > 2.34.1
> > 
> 
> 
> 
> 
