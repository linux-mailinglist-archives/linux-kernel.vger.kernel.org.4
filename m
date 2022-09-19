Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990FE5BCC09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiISMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiISMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:42:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D59B4BB;
        Mon, 19 Sep 2022 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663591344; x=1695127344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=78m/ZtNBxty6ZCWez+ym/8Iox/VkCfiqx0653WxUgLU=;
  b=eGo2Z7Q8auLk7Gu6bmFavpzBBD5rJ2HrdFOUO8ml9KbwgLr99XHYNOop
   xiXjoyGXsW/0DMQCwQojsTe/luE4EaZEeYypai76ApJOmM37pkl6+0RQ3
   NwFXrkOLBPzDpUpX3NjnAXPxSXDjzuBdyeu6Qmw7JBnHXxSGORG/yu2E9
   pR5oZqgfp74uGpLzV+UJc64555Oac9cxoy6Qw4vrS446b0qlETe3DFPZH
   G2OV3c4LHcrfnWU7F3ccxpn/wAhry5VSmkJeA2sEp973o8cQ+AIUJrQZs
   uka7G/4zPmDhPdpkuMGllu6Hv37Re5FLX3D18Tu7pP1TRzwO5/aTQeLXB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385677876"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="385677876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 05:42:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="613984785"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 05:42:17 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D1B89202D2;
        Mon, 19 Sep 2022 15:42:15 +0300 (EEST)
Date:   Mon, 19 Sep 2022 12:42:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135713.143890-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Sep 16, 2022 at 03:57:11PM +0200, Marco Felsch wrote:
> Add support to report the link frequency.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> The v1 of this small series can be found here:
> https://lore.kernel.org/all/20220818144712.997477-1-m.felsch@pengutronix.de/
> 
> Thanks a lot to Jacopo for the review feedback on my v1.
> 
> Changelog:
> 
> v2:
> - use V4L2_CID_LINK_FREQ instead of V4L2_CID_PIXEL_RATE
> ---
>  drivers/media/i2c/mt9m111.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> index afc86efa9e3e..52be1c310455 100644
> --- a/drivers/media/i2c/mt9m111.c
> +++ b/drivers/media/i2c/mt9m111.c
> @@ -1249,6 +1249,8 @@ static int mt9m111_probe(struct i2c_client *client)
>  {
>  	struct mt9m111 *mt9m111;
>  	struct i2c_adapter *adapter = client->adapter;
> +	static s64 extclk_rate;
> +	struct v4l2_ctrl *ctrl;
>  	int ret;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> @@ -1271,6 +1273,13 @@ static int mt9m111_probe(struct i2c_client *client)
>  	if (IS_ERR(mt9m111->clk))
>  		return PTR_ERR(mt9m111->clk);
>  
> +	ret = clk_prepare_enable(mt9m111->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	extclk_rate = clk_get_rate(mt9m111->clk);
> +	clk_disable_unprepare(mt9m111->clk);

I don't think you'll need to enable a clock to just get its frequency.

> +
>  	mt9m111->regulator = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(mt9m111->regulator)) {
>  		dev_err(&client->dev, "regulator not found: %ld\n",
> @@ -1285,7 +1294,7 @@ static int mt9m111_probe(struct i2c_client *client)
>  	mt9m111->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
>  				 V4L2_SUBDEV_FL_HAS_EVENTS;
>  
> -	v4l2_ctrl_handler_init(&mt9m111->hdl, 7);
> +	v4l2_ctrl_handler_init(&mt9m111->hdl, 8);
>  	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
>  			V4L2_CID_VFLIP, 0, 1, 1, 0);
>  	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
> @@ -1309,6 +1318,16 @@ static int mt9m111_probe(struct i2c_client *client)
>  				BIT(V4L2_COLORFX_NEGATIVE) |
>  				BIT(V4L2_COLORFX_SOLARIZATION)),
>  			V4L2_COLORFX_NONE);
> +	/*
> +	 * The extclk rate equals the link freq. if reg default values are used,
> +	 * which is the case. This must be adapted as soon as we don't use the
> +	 * default values anymore.
> +	 */
> +	ctrl = v4l2_ctrl_new_int_menu(&mt9m111->hdl, &mt9m111_ctrl_ops,
> +				      V4L2_CID_LINK_FREQ, 0, 0, &extclk_rate);
> +	if (ctrl)
> +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +
>  	mt9m111->subdev.ctrl_handler = &mt9m111->hdl;
>  	if (mt9m111->hdl.error) {
>  		ret = mt9m111->hdl.error;

-- 
Regards,

Sakari Ailus
