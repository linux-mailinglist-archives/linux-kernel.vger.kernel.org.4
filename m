Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197666D2162
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjCaNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCaNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:19:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AE7DB2;
        Fri, 31 Mar 2023 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680268764; x=1711804764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxic0WeyAasMhMzpUzw3VNflVXphLY/Tnxv/avoryWE=;
  b=bRQRSBk4VO/FcOehCrEnPBQuayDjGUN0r+enLyVU6XlzH/Q1AembXjK+
   ArDksKPTLtovHPxc6FuK7E31OfTFwMCgprinP+AhT05l6n4SdbuvMEch8
   fqVKotGmjCZRocK/DadcACt+12xOi49DXaA3NNL0psb1ekhFWolfCbvZG
   wAzhorK6J8h+3qoPiMSs/XFUHDseogo52xDn+M4Rswu1I6g8Ft6iiPPIl
   LzGX/Pltb910R1d98tylfckDhwzz+VKvH0l3dN+n5JCTDdXNea4JJGT4W
   4x0iEHeAyAExmQ++XNmQ2KTUUzyF+l/Jjnp6xyVZ6Bv1yEAgwYZrmyWw6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="340172745"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="340172745"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 06:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717708084"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="717708084"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 06:19:16 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6480E11F931;
        Fri, 31 Mar 2023 16:19:13 +0300 (EEST)
Date:   Fri, 31 Mar 2023 16:19:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        mripard@kernel.org, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        linux-kernel@vger.kernel.org, bparrot@ti.com,
        niklas.soderlund+renesas@ragnatech.se, j-luthra@ti.com,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com, martyn.welch@collabora.com
Subject: Re: [PATCH v7 04/13] media: cadence: csi2rx: Add external DPHY
 support
Message-ID: <ZCbd0a9xkfSkNjgT@kekkonen.localdomain>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-5-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314115516.667-5-vaishnav.a@ti.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav,

On Tue, Mar 14, 2023 at 05:25:07PM +0530, Vaishnav Achath wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> Some platforms like TI's J721E can have the CSI2RX paired with an
> external DPHY. Add support to enable and configure the DPHY using the
> generic PHY framework.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> 
> Changes in v7:
> - Fix multiplier and divider in v4l2_get_link_freq() which caused
>   failures during streaming.
> 
> Changes in v6:
> - Drop variable bpp and use fmt->bpp directly.
> - Drop variable got_pm. Call phy_pm_runtime_put() unconditionally since
>   it will just return an error if runtime PM is not enabled.
> - Add Laurent's R-by.
> 
> Changes in v5:
> - Only error out when phy_pm_runtime_get_sync() returns a negative
>   value. A positive value can be returned if the phy was already
>   resumed.
> - Do not query the source subdev for format. Use the newly added
>   internal format instead.
> 
> Changes in v4:
> - Drop the call to set PHY submode. It is now being done via compatible
>   on the DPHY side.
> 
> Changes in v3:
> - Use v4l2_get_link_freq() to calculate pixel clock.
> 
> Changes in v2:
> - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
>   calls to set PHY mode, etc. to make sure it is ready.
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 90 +++++++++++++++++---
>  1 file changed, 80 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index ae3ebdb3890d..6933626adfc8 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -30,6 +30,12 @@
>  #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
>  #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
>  
> +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
> +#define CSI2RX_DPHY_CL_RST			BIT(16)
> +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
> +#define CSI2RX_DPHY_CL_EN			BIT(4)
> +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
> +
>  #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
>  
>  #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> @@ -137,6 +143,49 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>  	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
>  }
>  
> +static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
> +{
> +	union phy_configure_opts opts = { };
> +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> +	const struct csi2rx_fmt *fmt;
> +	s64 pixel_clock;
> +	int ret;
> +
> +	fmt = csi2rx_get_fmt_by_code(csi2rx->fmt.code);
> +
> +	/*
> +	 * Do not divide by the number of lanes here. That will be done by
> +	 * phy_mipi_dphy_get_default_config().
> +	 */
> +	pixel_clock = v4l2_get_link_freq(csi2rx->source_subdev->ctrl_handler,
> +					 fmt->bpp, 2 * csi2rx->num_lanes);
> +	if (pixel_clock < 0)
> +		return pixel_clock;
> +
> +	ret = phy_mipi_dphy_get_default_config(pixel_clock, 1, 1, cfg);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_pm_runtime_get_sync(csi2rx->dphy);
> +	if (ret < 0 && ret != -ENOTSUPP)
> +		return ret;
> +
> +	ret = phy_power_on(csi2rx->dphy);
> +	if (ret)
> +		goto out;

You shouldn't need both phy_pm_runtime_get_sync() and phy_power_on(). It
would seem like that phy_power_on() is what drivers are intended to use.

> +
> +	ret = phy_configure(csi2rx->dphy, &opts);
> +	if (ret) {
> +		/* Can't do anything if it fails. Ignore the return value. */
> +		phy_power_off(csi2rx->dphy);
> +		goto out;
> +	}
> +
> +out:
> +	phy_pm_runtime_put(csi2rx->dphy);
> +	return ret;
> +}
> +
>  static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  {
>  	unsigned int i;
> @@ -175,6 +224,17 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pclk;
>  
> +	/* Enable DPHY clk and data lanes. */
> +	if (csi2rx->dphy) {
> +		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
> +		for (i = 0; i < csi2rx->num_lanes; i++) {
> +			reg |= CSI2RX_DPHY_DL_EN(csi2rx->lanes[i] - 1);
> +			reg |= CSI2RX_DPHY_DL_RST(csi2rx->lanes[i] - 1);
> +		}
> +
> +		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +	}
> +
>  	/*
>  	 * Create a static mapping between the CSI virtual channels
>  	 * and the output stream.
> @@ -205,10 +265,21 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  	if (ret)
>  		goto err_disable_pixclk;
>  
> +	if (csi2rx->dphy) {
> +		ret = csi2rx_configure_external_dphy(csi2rx);
> +		if (ret) {
> +			dev_err(csi2rx->dev,
> +				"Failed to configure external DPHY: %d\n", ret);
> +			goto err_disable_sysclk;
> +		}
> +	}
> +
>  	clk_disable_unprepare(csi2rx->p_clk);
>  
>  	return 0;
>  
> +err_disable_sysclk:
> +	clk_disable_unprepare(csi2rx->sys_clk);
>  err_disable_pixclk:
>  	for (; i > 0; i--)
>  		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
> @@ -236,6 +307,13 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
>  
>  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
>  		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
> +
> +	if (csi2rx->dphy) {
> +		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> +
> +		if (phy_power_off(csi2rx->dphy))
> +			dev_warn(csi2rx->dev, "Couldn't power off DPHY\n");
> +	}
>  }
>  
>  static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
> @@ -432,15 +510,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  		return PTR_ERR(csi2rx->dphy);
>  	}
>  
> -	/*
> -	 * FIXME: Once we'll have external D-PHY support, the check
> -	 * will need to be removed.
> -	 */
> -	if (csi2rx->dphy) {
> -		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = clk_prepare_enable(csi2rx->p_clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Couldn't prepare and enable P clock\n");
> @@ -470,7 +539,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
>  	 * FIXME: Once we'll have internal D-PHY support, the check
>  	 * will need to be removed.
>  	 */
> -	if (csi2rx->has_internal_dphy) {
> +	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
>  		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
>  		return -EINVAL;
>  	}
> @@ -595,6 +664,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev,
>  		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
>  		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
> +		 csi2rx->dphy ? "external" :
>  		 csi2rx->has_internal_dphy ? "internal" : "no");
>  
>  	return 0;

-- 
Kind regards,

Sakari Ailus
