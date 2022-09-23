Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5615E837B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiIWUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIWURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:17:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A229C7D1FA;
        Fri, 23 Sep 2022 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663964099; x=1695500099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4Ap7/60tpjYs9kb1z44MtzSE1l13TDa4jGX5dZVwRg=;
  b=kU3WeIa1UdfDlb4cc9Hs5UE5ILJbpjWMtfRCg4L9GF6B0xh/mC6bHfhY
   n9RmSKR7Es7j4X48ovtokLrSD4PnL8TnuQZrZp/Hh0DiAoPNT0Jv8z14S
   2amO+xMQhjnTAvdWK0p/jME0LfSWNgYfQIOIm28ICBj2jBDuptfi1/DPO
   3gpk8qpZ2AVjlw87K3pQwIXTCYnS6XRz0bokbkrQaiSoY54kS7rCI0/SB
   oynIahcPu2WI5EPP2DFd35NHldiyI6l3ERCLOm1zkZcUVhRJ2PVQIWd5M
   3chNIFfG870YZV4D7WTPDSJIcapNKpRw+jKFSS7b7hY4yxubk4bNMtNi6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="281051925"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="281051925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 13:14:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="724272569"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 13:14:50 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id CBA192030E;
        Fri, 23 Sep 2022 23:14:47 +0300 (EEST)
Date:   Fri, 23 Sep 2022 20:14:47 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <Yy4TtzPtSN9qiiQS@paasikivi.fi.intel.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905230406.30801-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Sep 06, 2022 at 12:04:06AM +0100, Lad Prabhakar wrote:
...

> +#define to_buf_list(vb2_buffer) (&container_of(vb2_buffer, \
> +						struct rzg2l_cru_buffer, \
> +						vb)->list)

#define to_buf_list(vb2_buffer) \
	(&container_of(vb2_buffer, struct rzg2l_cru_buffer, vb)->list)


...

> +static int rzg2l_cru_open(struct file *file)
> +{
> +	struct rzg2l_cru_dev *cru = video_drvdata(file);
> +	int ret;
> +
> +	ret = clk_prepare_enable(cru->pclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(cru->vclk);
> +	if (ret)
> +		goto disable_pclk;
> +
> +	ret = clk_prepare_enable(cru->aclk);
> +	if (ret)
> +		goto disable_vclk;
> +
> +	ret = mutex_lock_interruptible(&cru->lock);
> +	if (ret)
> +		goto disable_aclk;
> +
> +	file->private_data = cru;
> +	ret = v4l2_fh_open(file);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = v4l2_pipeline_pm_get(&cru->vdev.entity);

Please use runtime PM instead in sensor drivers, we're trying to get rid of
this function.

It'd be nice to have it in this one as well.

> +	if (ret < 0)
> +		goto err_open;
> +
> +	mutex_unlock(&cru->lock);
> +
> +	return 0;
> +err_open:
> +	v4l2_fh_release(file);
> +err_unlock:
> +	mutex_unlock(&cru->lock);
> +disable_aclk:
> +	clk_disable_unprepare(cru->aclk);
> +disable_vclk:
> +	clk_disable_unprepare(cru->vclk);
> +disable_pclk:
> +	clk_disable_unprepare(cru->pclk);
> +
> +	return ret;
> +}

...

> +void rzg2l_cru_v4l2_unregister(struct rzg2l_cru_dev *cru)
> +{
> +	if (!video_is_registered(&cru->vdev))
> +		return;
> +
> +	v4l2_info(&cru->v4l2_dev, "Removed %s\n",
> +		  video_device_node_name(&cru->vdev));

I'd just leave this out. Same for the similar message on registration.

-- 
Kind regards,

Sakari Ailus
