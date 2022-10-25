Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC160D72F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiJYWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiJYWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:33:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116775244E;
        Tue, 25 Oct 2022 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666737187; x=1698273187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkMpR8UhouXSKr2UufQNVOYgkr4gvr3rdbAMwptbgJI=;
  b=SxU8Ud45IJ1cB+IIjMKe8EbkT38b0/BK9JYwKGebUXnrwv9RMEJiKv92
   cW9ktr6H8OsGNcs/tKuKQ+XP/XnOq/q+T69n8qL5i9z2RK5oZGDaw1t6X
   +4CQNedVmEa8tzzxPctUvXhonxlgCdGPV+c6WYxSXLYi9WkLIzsBucGem
   8a8O2fXj+j6CNhzhF3/e3XCIad/3pROuwr0VTrQf7wNO7JMFdzASZkOlT
   mvUnBhPaPc3bah+cftBzgtjuRYpK6TIfA1+paugvnOm6gUD1yIMu3+MqA
   gpxf0enXaHxpVGVX5410tx/u8H3C+ad/RNlVNE52c53+tl7UAGfezXgYM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309496360"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="309496360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:33:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="700709944"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="700709944"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 15:33:02 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D800420321;
        Wed, 26 Oct 2022 01:32:59 +0300 (EEST)
Date:   Tue, 25 Oct 2022 22:32:59 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <Y1hkG6NVFS08WTIg@paasikivi.fi.intel.com>
References: <20221004234343.54777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221004234343.54777-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004234343.54777-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

A few comments below... apologies for not reviewing this earlier. Looks
good in general but there are a few points that need some attention.

On Wed, Oct 05, 2022 at 12:43:43AM +0100, Prabhakar wrote:
...
> +static int rzg2l_cru_ip_pre_streamon(struct v4l2_subdev *sd, u32 flags)
> +{
> +	struct rzg2l_cru_dev *cru;
> +	int ret;
> +
> +	cru = v4l2_get_subdevdata(sd);
> +
> +	if (!cru->is_csi)
> +		return -EINVAL;
> +
> +	ret = v4l2_subdev_call(cru->ip.remote, video, pre_streamon, 0);

If you're calling pre_streamon successfully, you'll have to have an
equivalent number of post_streamoff calls.

...

> +static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
> +{
> +	struct media_pipeline *pipe;
> +	struct v4l2_subdev *sd;
> +	struct media_pad *pad;
> +	unsigned long flags;
> +	int ret;
> +
> +	pad = media_pad_remote_pad_first(&cru->pad);
> +	if (!pad)
> +		return -EPIPE;
> +
> +	sd = media_entity_to_v4l2_subdev(pad->entity);
> +
> +	if (!on) {
> +		media_pipeline_stop(&cru->vdev.entity);
> +		return v4l2_subdev_call(sd, video, s_stream, 0);

Ditto.

> +	}
> +
> +	ret = rzg2l_cru_mc_validate_format(cru, sd, pad);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l2_subdev_call(sd, video, pre_streamon, 0);
> +	if (ret == -ENOIOCTLCMD)
> +		ret = 0;
> +	if (ret)
> +		return ret;

For all cases below where streaming on doesn't succeed, you'll have to have
a call of post_streamoff.

> +
> +	spin_lock_irqsave(&cru->qlock, flags);
> +
> +	/* Select a video input */
> +	if (cru->is_csi)
> +		rzg2l_cru_write(cru, CRUnCTRL, CRUnCTRL_VINSEL(0));
> +
> +	/* Cancel the software reset for image processing block */
> +	rzg2l_cru_write(cru, CRUnRST, CRUnRST_VRESETN);
> +
> +	/* Disable and clear the interrupt before using */
> +	rzg2l_cru_write(cru, CRUnIE, 0);
> +	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
> +
> +	/* Initialize the AXI master */
> +	rzg2l_cru_initialize_axi(cru);
> +
> +	/* Initialize image convert */
> +	ret = rzg2l_cru_initialize_image_conv(cru);
> +	if (ret) {
> +		spin_unlock_irqrestore(&cru->qlock, flags);
> +		return ret;
> +	}
> +
> +	/* Enable interrupt */
> +	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
> +
> +	/* Enable image processing reception */
> +	rzg2l_cru_write(cru, ICnEN, ICnEN_ICEN);
> +
> +	spin_unlock_irqrestore(&cru->qlock, flags);
> +
> +	pipe = sd->entity.pipe ? sd->entity.pipe : &cru->vdev.pipe;
> +	ret = media_pipeline_start(&cru->vdev.entity, pipe);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(cru->vclk);
> +
> +	ret = v4l2_subdev_call(sd, video, s_stream, 1);
> +	if (ret == -ENOIOCTLCMD)
> +		ret = 0;
> +	if (ret) {
> +		/* enable back vclk so that release() disables it */
> +		clk_prepare_enable(cru->vclk);
> +		media_pipeline_stop(&cru->vdev.entity);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(cru->vclk);

What will happen if enabling vclk will fail here? (Or above?)

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

-- 
Kind regards,

Sakari Ailus
