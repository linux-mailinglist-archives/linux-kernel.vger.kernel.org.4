Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDCF678BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjAWXDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjAWXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:03:21 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC75CF;
        Mon, 23 Jan 2023 15:02:56 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 6B3441B001B6;
        Tue, 24 Jan 2023 01:02:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1674514972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SdBaEzr7j1gDVD9iWeHG1WuRGZa27boW/e/GLhdfJ/Y=;
        b=hNnpjGda4cF0MQHO16dyWg1YS7ztRoH++B5lUJEApTpAL717Zv4eYVvRrntGB3+nEEaIXt
        6LFGFIc0bgCnESFL08TMZG6TAPokij/MNvg2Fs15goxSJQbfYXVoDsZw7KUoh1jjmMg7SA
        z7i7yb4xaOVJFuvuUweCdf3qWc8rFcpnj7X9g/9nnODQLc2D8ecVhfBrRceIhMCmwa9PTz
        3hkCrd+jTpZFp2B9cz/y/vgwcFIVcIzzxAeMziJjd6QJ3cj8kE+owAZAnZrxxejfvEAmYz
        kTMokF+stu/NoBx9S/iSxGygK3jWv+TshNdev3PFyxcCdKWCergG2TdmFJaQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1674514972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SdBaEzr7j1gDVD9iWeHG1WuRGZa27boW/e/GLhdfJ/Y=;
        b=SBdnssJgwx/+gWpmxyjwZPXSiBqtXzJrw0aWDf9VDPF029aJc33VaYyg7FDSi9PF91i3ef
        4sHvmw8ucUC60fPrGPpdFqmpEC0DY/A1DqNMVWoeNZkARqHuqgneg/Txy5/o4VO4eyYZte
        6ik7ykclLNznyoXKDXZMZ/5y7F38EcrTwSWTVJLjwo1S7lnyN164hr2+tMbiVXbVm024TL
        t1Dt1EdMlG7V2Dy+LWrJxuGtXUj/nN5DOM4gSKzRA+bOl+Y50guz/DmW59iKx7o8b8BAnu
        gG3BZSF23XLt0ioNez7fihMbdLZkGoXOjpi4zL+VXEvTkqUE9CiRWH7BvL+AgA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1674514972; a=rsa-sha256;
        cv=none;
        b=KQROd3yXYLpKjCPiFME6s30HhTgl8+qKg8GZlg4DmpCLOmn2UwQ/k2SJkDRGLGtm1yNeiV
        YGsnfD/U9hR270yfi/LmEJcfI4Agewv6KMltZz18PHocUDahw3Yb2fG9ZD0eoQNrXfNEAB
        gW/rDqgyHi+2kYwUjAdlGVCJL4un4fqMImbV5kr3VpnrpY7s2JoKBSMrQ+DEDHzq2EhhGR
        UmD1pufX6rD2IR8I3k6FIe/YcWOH/W15UOALHBkQPOGpL60JOLbcfA7plezHz7rue+QW3c
        lCQZFexuu9A9qt/LIdyArtVaLrN/2BxqAVcQKiPuBgUZGsIZUHDT2C1k0QZ8Tw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 6FCB7634C91;
        Tue, 24 Jan 2023 01:02:51 +0200 (EET)
Date:   Tue, 24 Jan 2023 01:02:51 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v10 5/5] media: i2c: imx334: update pixel and link
 frequency
Message-ID: <Y88SG5ndXjQ9AjZg@valkosipuli.retiisi.eu>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-6-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121033713.3535351-6-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Sat, Jan 21, 2023 at 09:07:13AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Update pixel_rate and link frequency for 1920x1080@30
> while changing mode.
> 
> Add dummy ctrl cases for pixel_rate and link frequency
> to avoid error while changing the modes dynamically.
> 
> Add support to handle multiple link frequencies.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 41 ++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index 309c706114d2..62b104eaa437 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -49,7 +49,8 @@
>  #define IMX334_INCLK_RATE	24000000
>  
>  /* CSI2 HW configuration */
> -#define IMX334_LINK_FREQ	891000000
> +#define IMX334_LINK_FREQ_891M	891000000
> +#define IMX334_LINK_FREQ_445M	445500000
>  #define IMX334_NUM_DATA_LANES	4
>  
>  #define IMX334_REG_MIN		0x00
> @@ -139,12 +140,14 @@ struct imx334 {
>  	u32 vblank;
>  	const struct imx334_mode *cur_mode;
>  	struct mutex mutex;
> +	unsigned long menu_skip_mask;
>  	u32 cur_code;
>  	bool streaming;
>  };
>  
>  static const s64 link_freq[] = {
> -	IMX334_LINK_FREQ,
> +	IMX334_LINK_FREQ_891M,
> +	IMX334_LINK_FREQ_445M,
>  };
>  
>  /* Sensor mode registers for 1920x1080@30fps */
> @@ -468,7 +471,7 @@ static const struct imx334_mode supported_modes[] = {
>  		.vblank_min = 45,
>  		.vblank_max = 132840,
>  		.pclk = 297000000,
> -		.link_freq_idx = 0,
> +		.link_freq_idx = 1,
>  		.reg_list = {
>  			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
>  			.regs = mode_1920x1080_regs,
> @@ -598,6 +601,11 @@ static int imx334_update_controls(struct imx334 *imx334,
>  	if (ret)
>  		return ret;
>  
> +	ret = __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pclk,
> +				       mode->pclk, 1, mode->pclk);
> +	if (ret)
> +		return ret;
> +
>  	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblank,
>  				       mode->hblank, 1, mode->hblank);
>  	if (ret)
> @@ -698,6 +706,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
>  		pm_runtime_put(imx334->dev);
>  
>  		break;
> +	case V4L2_CID_PIXEL_RATE:
> +	case V4L2_CID_LINK_FREQ:
>  	case V4L2_CID_HBLANK:
>  		ret = 0;
>  		break;
> @@ -1047,7 +1057,7 @@ static int imx334_parse_hw_config(struct imx334 *imx334)
>  	struct fwnode_handle *ep;
>  	unsigned long rate;
>  	int ret;
> -	int i;
> +	int i, j;

unsigned int would be nicer.

>  
>  	if (!fwnode)
>  		return -ENXIO;
> @@ -1097,11 +1107,20 @@ static int imx334_parse_hw_config(struct imx334 *imx334)
>  		goto done_endpoint_free;
>  	}
>  
> -	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
> -		if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ)
> +	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
> +		for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
> +			if (bus_cfg.link_frequencies[i] == link_freq[j]) {
> +				set_bit(j, &imx334->menu_skip_mask);

Is there a guarantee that you'll only be using the modes with the listed
frequencies? I don't see one but I might have missed it.

> +				break;
> +			}
> +		}
> +
> +		if (j == ARRAY_SIZE(link_freq)) {
> +			ret = dev_err_probe(imx334->dev, -EINVAL,
> +					    "no supported link freq found\n");
>  			goto done_endpoint_free;
> -
> -	ret = -EINVAL;
> +		}
> +	}
>  
>  done_endpoint_free:
>  	v4l2_fwnode_endpoint_free(&bus_cfg);
> @@ -1232,10 +1251,10 @@ static int imx334_init_controls(struct imx334 *imx334)
>  	imx334->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
>  							&imx334_ctrl_ops,
>  							V4L2_CID_LINK_FREQ,
> -							ARRAY_SIZE(link_freq) -
> -							1,
> -							mode->link_freq_idx,
> +							__fls(imx334->menu_skip_mask),
> +							__ffs(imx334->menu_skip_mask),
>  							link_freq);
> +
>  	if (imx334->link_freq_ctrl)
>  		imx334->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>  

-- 
Kind regards,

Sakari Ailus
