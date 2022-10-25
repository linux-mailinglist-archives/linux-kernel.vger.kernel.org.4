Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437E60C2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJYFCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJYFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:01:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB77AB39;
        Mon, 24 Oct 2022 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2RpF6v7jb3J8a21THqvWGqERHWXHNn7kIyc4VmrIpDk=;
  b=Y8f5U39imdcBre/bcuSCHN6VcfZ7BHURtK+YcMjJZJcWLqh+F9oJuZvz
   Jb+1Y/ON5am8w7SGHXfYjFMl7j2RoH3irDodGjf8UpQRgikKmfsChWMfu
   4v+fzyTDGn+OhUsaPdLTUtMy0dwaXeGhcAQjK1U6CuGblFcGeIwCKunkc
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,211,1661810400"; 
   d="scan'208";a="33948386"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 07:01:48 +0200
Date:   Tue, 25 Oct 2022 07:01:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
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
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: media: imx: imx7-media-csi: Fix parenthesis
 alignment
In-Reply-To: <20221025001239.16345-1-lima.gabriel.luz@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210250659440.3214@hadrien>
References: <20221025001239.16345-1-lima.gabriel.luz@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Oct 2022, Gabriel Lima Luz wrote:

> Adhere to Linux kernel coding style.
>
> Reported by checkpatch:
>
> CHECK: Alignment should match open parenthesis

Here you have made a decision that is quite reasonable, but that does not
actually "Fix parenthesis alignment".  This highlights an overall problem
with your log message.  You say what you are "fixing", but you don't give
any explanation about why you have done what you have done.  Actually the
most helpful comment was below the ---, but that will disappear when the
patch is applied.

julia

>
> Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> ---
> Altered changes acording to feedback for a more readable code
>
>  drivers/staging/media/imx/imx7-media-csi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index cbc66ef0eda8..b241b68f456c 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1704,7 +1704,8 @@ static int imx7_csi_init_cfg(struct v4l2_subdev *sd,
>  		mf->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(mf->colorspace);
>  		mf->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(mf->colorspace);
>  		mf->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(!cc->yuv,
> -					mf->colorspace, mf->ycbcr_enc);
> +							mf->colorspace,
> +							mf->ycbcr_enc);
>
>  		csi->cc[i] = cc;
>  	}
> --
> 2.34.1
>
>
>
