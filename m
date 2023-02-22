Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAE69F116
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBVJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjBVJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:14:52 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E847F36FFB;
        Wed, 22 Feb 2023 01:14:49 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id C8D981B001D8;
        Wed, 22 Feb 2023 11:14:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677057282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mfy4GLp+pOJy+L1t0FmWeGDNXAkju1WEFLRV+v5wLaU=;
        b=E8LrAqR8AK5qFVtMGBGBngD91NOj+MdVEfWODcRLfubYzqYjesdLKAkVM1/XJiPHZ7B/5e
        YTF3UGcbbKWCSfJlloIQ+hpqXrF8jcKHgHS92tJS/PCMKNpr0NX5f8pVQV0xSDpgFUkTUq
        UZ5Nd0hG2y3Qq995PI3T1jBhYt3fGgVVF/15jq8bt9BkwENvDRX5cveDIuLms6zdprlGMo
        Ug3S77H/WLsyCd9RXsOxB8IyhRucDivHgx8HRPRwEckweggJLc2wc1+QGST8+7GAwsFnyH
        1f+u1n2XXfcBJMdElarNP9JLdT6bi7alYB/JiEysn2Qsn1P24h/Gwg7c/QAeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1677057282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mfy4GLp+pOJy+L1t0FmWeGDNXAkju1WEFLRV+v5wLaU=;
        b=jK38TV1lQd0bxKLIhWnDYgci1Z6q3xV1jA7msgOOIklOGICbJofBlRDiUS8Xdk5X9yrNQg
        xbVy+hvBUPzwyFKx4J1xoxDOJ0g/8u+n3M4gVMtD9IT7RtWA+sOkcq6tvMrm3AABl9u0m7
        Fyn32r1XHqQucW+SJTBsLh+EBliuA1PmhIhkTJPsjfbCZ4pQZe6TAaradaFG8q/4FLSmvp
        P2OnumpNGhVE6yXw/zUnOgyYhgt8ejMYUhLsN9psO5BU6xL2H+k4p7n930F8GS3Y6xd01r
        DQq8eHubvwxixWXX4r96zhH9Ym84a5fQLQ5V+Dv4UlA7gDS7eEdADkQ/jh709w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1677057282; a=rsa-sha256;
        cv=none;
        b=Lio0Vy8WDyIjy6V6aBumumyw6PaoFnFw1LznXXRklyfA/SaETm0Vo/XzIFeJOJpGLE4T9C
        rev+KMrW+6t6xLU+0MpWofslm4PV74u2+t1vAulO14tLHRPMWd7rxOxRRIRC1n3Yac03gX
        PMvoEAAONNSTGRSBW9OSqM1Wv66JXCmFHbKPMZ4OZ9yXkGG44I6vePgoruySCHirXR+bYC
        rv2MrosUB6qkMdb+p2PioyyFBISPRgDg/Pz/33cd0pFt3pbq+jZVcf43bwgv4KFLrkU95t
        XOEhgrJ4IGthygUwCweT3M3+gM8RBJQrnGIOWcVdR6m1yNPykMzehYxcXE2EZw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2ECEA634C91;
        Wed, 22 Feb 2023 11:14:29 +0200 (EET)
Date:   Wed, 22 Feb 2023 11:14:29 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Prakash Battu <Prakash.Battu@microchip.com>
Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208050915.1958183-4-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Some platforms may not be capable of supporting the bandwidth
> required for 12 bit or 3840x2160@60 resolutions.
> 
> Add support for dynamically selecting 10 bit and 1920x1080@30
> resolutions while leaving the existing configuration as default.
> 
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Prakash Battu <Prakash.Battu@microchip.com>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 296 +++++++++++++++++++++++++++++++++----
>  1 file changed, 269 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index 40ece08f20f5..309c706114d2 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -79,7 +79,6 @@ struct imx334_reg_list {
>   * struct imx334_mode - imx334 sensor mode structure
>   * @width: Frame width
>   * @height: Frame height
> - * @code: Format code
>   * @hblank: Horizontal blanking in lines
>   * @vblank: Vertical blanking in lines
>   * @vblank_min: Minimal vertical blanking in lines
> @@ -91,7 +90,6 @@ struct imx334_reg_list {
>  struct imx334_mode {
>  	u32 width;
>  	u32 height;
> -	u32 code;
>  	u32 hblank;
>  	u32 vblank;
>  	u32 vblank_min;
> @@ -119,6 +117,7 @@ struct imx334_mode {
>   * @vblank: Vertical blanking in lines
>   * @cur_mode: Pointer to current selected sensor mode
>   * @mutex: Mutex for serializing sensor controls
> + * @cur_code: current selected format code
>   * @streaming: Flag indicating streaming state
>   */
>  struct imx334 {
> @@ -140,6 +139,7 @@ struct imx334 {
>  	u32 vblank;
>  	const struct imx334_mode *cur_mode;
>  	struct mutex mutex;
> +	u32 cur_code;
>  	bool streaming;
>  };
>  
> @@ -147,7 +147,170 @@ static const s64 link_freq[] = {
>  	IMX334_LINK_FREQ,
>  };
>  
> -/* Sensor mode registers */
> +/* Sensor mode registers for 1920x1080@30fps */
> +static const struct imx334_reg mode_1920x1080_regs[] = {
> +	{0x3000, 0x01},
> +	{0x3018, 0x04},
> +	{0x3030, 0xca},
> +	{0x3031, 0x08},
> +	{0x3032, 0x00},
> +	{0x3034, 0x4c},
> +	{0x3035, 0x04},
> +	{0x302c, 0xf0},
> +	{0x302d, 0x03},
> +	{0x302e, 0x80},
> +	{0x302f, 0x07},
> +	{0x3074, 0xcc},
> +	{0x3075, 0x02},
> +	{0x308e, 0xcd},
> +	{0x308f, 0x02},
> +	{0x3076, 0x38},
> +	{0x3077, 0x04},
> +	{0x3090, 0x38},
> +	{0x3091, 0x04},
> +	{0x3308, 0x38},
> +	{0x3309, 0x04},
> +	{0x30C6, 0x00},
> +	{0x30c7, 0x00},
> +	{0x30ce, 0x00},
> +	{0x30cf, 0x00},
> +	{0x30d8, 0x18},
> +	{0x30d9, 0x0a},
> +	{0x304c, 0x00},
> +	{0x304e, 0x00},
> +	{0x304f, 0x00},
> +	{0x3050, 0x00},
> +	{0x30b6, 0x00},
> +	{0x30b7, 0x00},
> +	{0x3116, 0x08},
> +	{0x3117, 0x00},
> +	{0x31a0, 0x20},
> +	{0x31a1, 0x0f},
> +	{0x300c, 0x3b},
> +	{0x300d, 0x29},
> +	{0x314c, 0x29},
> +	{0x314d, 0x01},
> +	{0x315a, 0x06},
> +	{0x3168, 0xa0},
> +	{0x316a, 0x7e},
> +	{0x319e, 0x02},
> +	{0x3199, 0x00},
> +	{0x319d, 0x00},
> +	{0x31dd, 0x03},
> +	{0x3300, 0x00},
> +	{0x341c, 0xff},
> +	{0x341d, 0x01},
> +	{0x3a01, 0x03},
> +	{0x3a18, 0x7f},
> +	{0x3a19, 0x00},
> +	{0x3a1a, 0x37},
> +	{0x3a1b, 0x00},
> +	{0x3a1c, 0x37},
> +	{0x3a1d, 0x00},
> +	{0x3a1e, 0xf7},
> +	{0x3a1f, 0x00},
> +	{0x3a20, 0x3f},
> +	{0x3a21, 0x00},
> +	{0x3a20, 0x6f},
> +	{0x3a21, 0x00},
> +	{0x3a20, 0x3f},
> +	{0x3a21, 0x00},
> +	{0x3a20, 0x5f},
> +	{0x3a21, 0x00},
> +	{0x3a20, 0x2f},
> +	{0x3a21, 0x00},
> +	{0x3078, 0x02},
> +	{0x3079, 0x00},
> +	{0x307a, 0x00},
> +	{0x307b, 0x00},
> +	{0x3080, 0x02},
> +	{0x3081, 0x00},
> +	{0x3082, 0x00},
> +	{0x3083, 0x00},
> +	{0x3088, 0x02},
> +	{0x3094, 0x00},
> +	{0x3095, 0x00},
> +	{0x3096, 0x00},
> +	{0x309b, 0x02},
> +	{0x309c, 0x00},
> +	{0x309d, 0x00},
> +	{0x309e, 0x00},
> +	{0x30a4, 0x00},
> +	{0x30a5, 0x00},
> +	{0x3288, 0x21},
> +	{0x328a, 0x02},
> +	{0x3414, 0x05},
> +	{0x3416, 0x18},
> +	{0x35Ac, 0x0e},
> +	{0x3648, 0x01},
> +	{0x364a, 0x04},
> +	{0x364c, 0x04},
> +	{0x3678, 0x01},
> +	{0x367c, 0x31},
> +	{0x367e, 0x31},
> +	{0x3708, 0x02},
> +	{0x3714, 0x01},
> +	{0x3715, 0x02},
> +	{0x3716, 0x02},
> +	{0x3717, 0x02},
> +	{0x371c, 0x3d},
> +	{0x371d, 0x3f},
> +	{0x372c, 0x00},
> +	{0x372d, 0x00},
> +	{0x372e, 0x46},
> +	{0x372f, 0x00},
> +	{0x3730, 0x89},
> +	{0x3731, 0x00},
> +	{0x3732, 0x08},
> +	{0x3733, 0x01},
> +	{0x3734, 0xfe},
> +	{0x3735, 0x05},
> +	{0x375d, 0x00},
> +	{0x375e, 0x00},
> +	{0x375f, 0x61},
> +	{0x3760, 0x06},
> +	{0x3768, 0x1b},
> +	{0x3769, 0x1b},
> +	{0x376a, 0x1a},
> +	{0x376b, 0x19},
> +	{0x376c, 0x18},
> +	{0x376d, 0x14},
> +	{0x376e, 0x0f},
> +	{0x3776, 0x00},
> +	{0x3777, 0x00},
> +	{0x3778, 0x46},
> +	{0x3779, 0x00},
> +	{0x377a, 0x08},
> +	{0x377b, 0x01},
> +	{0x377c, 0x45},
> +	{0x377d, 0x01},
> +	{0x377e, 0x23},
> +	{0x377f, 0x02},
> +	{0x3780, 0xd9},
> +	{0x3781, 0x03},
> +	{0x3782, 0xf5},
> +	{0x3783, 0x06},
> +	{0x3784, 0xa5},
> +	{0x3788, 0x0f},
> +	{0x378a, 0xd9},
> +	{0x378b, 0x03},
> +	{0x378c, 0xeb},
> +	{0x378d, 0x05},
> +	{0x378e, 0x87},
> +	{0x378f, 0x06},
> +	{0x3790, 0xf5},
> +	{0x3792, 0x43},
> +	{0x3794, 0x7a},
> +	{0x3796, 0xa1},
> +	{0x37b0, 0x37},
> +	{0x3e04, 0x0e},
> +	{0x30e8, 0x50},
> +	{0x30e9, 0x00},
> +	{0x3e04, 0x0e},
> +	{0x3002, 0x00},
> +};
> +
> +/* Sensor mode registers for 3840x2160@30fps */
>  static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3000, 0x01},
>  	{0x3002, 0x00},
> @@ -263,20 +426,53 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3a29, 0x00},
>  };
>  
> +static const struct imx334_reg raw10_framefmt_regs[] = {
> +	{0x3050, 0x00},
> +	{0x319d, 0x00},
> +	{0x341c, 0xff},
> +	{0x341d, 0x01},
> +};
> +
> +static const struct imx334_reg raw12_framefmt_regs[] = {
> +	{0x3050, 0x01},
> +	{0x319d, 0x01},
> +	{0x341c, 0x47},
> +	{0x341d, 0x00},
> +};
> +
> +static const u32 imx334_mbus_codes[] = {
> +	MEDIA_BUS_FMT_SRGGB12_1X12,
> +	MEDIA_BUS_FMT_SRGGB10_1X10,
> +};
> +
>  /* Supported sensor mode configurations */
> -static const struct imx334_mode supported_mode = {
> -	.width = 3840,
> -	.height = 2160,
> -	.hblank = 560,
> -	.vblank = 2340,
> -	.vblank_min = 90,
> -	.vblank_max = 132840,
> -	.pclk = 594000000,
> -	.link_freq_idx = 0,
> -	.code = MEDIA_BUS_FMT_SRGGB12_1X12,
> -	.reg_list = {
> -		.num_of_regs = ARRAY_SIZE(mode_3840x2160_regs),
> -		.regs = mode_3840x2160_regs,
> +static const struct imx334_mode supported_modes[] = {
> +	{
> +		.width = 3840,
> +		.height = 2160,
> +		.hblank = 560,
> +		.vblank = 2340,
> +		.vblank_min = 90,
> +		.vblank_max = 132840,
> +		.pclk = 594000000,
> +		.link_freq_idx = 0,
> +		.reg_list = {
> +			.num_of_regs = ARRAY_SIZE(mode_3840x2160_regs),
> +			.regs = mode_3840x2160_regs,
> +		},
> +	}, {
> +		.width = 1920,
> +		.height = 1080,
> +		.hblank = 2480,
> +		.vblank = 1170,
> +		.vblank_min = 45,
> +		.vblank_max = 132840,
> +		.pclk = 297000000,
> +		.link_freq_idx = 0,
> +		.reg_list = {
> +			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
> +			.regs = mode_1920x1080_regs,
> +		},
>  	},
>  };
>  
> @@ -518,6 +714,18 @@ static const struct v4l2_ctrl_ops imx334_ctrl_ops = {
>  	.s_ctrl = imx334_set_ctrl,
>  };
>  
> +static int imx334_get_format_code(struct imx334 *imx334, u32 code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(imx334_mbus_codes); i++) {
> +		if (imx334_mbus_codes[i] == code)
> +			return imx334_mbus_codes[i];
> +	}
> +
> +	return imx334_mbus_codes[0];
> +}
> +
>  /**
>   * imx334_enum_mbus_code() - Enumerate V4L2 sub-device mbus codes
>   * @sd: pointer to imx334 V4L2 sub-device structure
> @@ -530,10 +738,10 @@ static int imx334_enum_mbus_code(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *sd_state,
>  				 struct v4l2_subdev_mbus_code_enum *code)
>  {
> -	if (code->index > 0)
> +	if (code->index >= ARRAY_SIZE(imx334_mbus_codes))
>  		return -EINVAL;
>  
> -	code->code = supported_mode.code;
> +	code->code = imx334_mbus_codes[code->index];
>  
>  	return 0;
>  }
> @@ -550,15 +758,20 @@ static int imx334_enum_frame_size(struct v4l2_subdev *sd,
>  				  struct v4l2_subdev_state *sd_state,
>  				  struct v4l2_subdev_frame_size_enum *fsize)
>  {
> -	if (fsize->index > 0)
> +	struct imx334 *imx334 = to_imx334(sd);
> +	u32 code;
> +
> +	if (fsize->index >= ARRAY_SIZE(supported_modes))
>  		return -EINVAL;
>  
> -	if (fsize->code != supported_mode.code)
> +	code = imx334_get_format_code(imx334, fsize->code);
> +
> +	if (fsize->code != code)
>  		return -EINVAL;
>  
> -	fsize->min_width = supported_mode.width;
> +	fsize->min_width = supported_modes[fsize->index].width;
>  	fsize->max_width = fsize->min_width;
> -	fsize->min_height = supported_mode.height;
> +	fsize->min_height = supported_modes[fsize->index].height;
>  	fsize->max_height = fsize->min_height;
>  
>  	return 0;
> @@ -577,7 +790,6 @@ static void imx334_fill_pad_format(struct imx334 *imx334,
>  {
>  	fmt->format.width = mode->width;
>  	fmt->format.height = mode->height;
> -	fmt->format.code = mode->code;
>  	fmt->format.field = V4L2_FIELD_NONE;
>  	fmt->format.colorspace = V4L2_COLORSPACE_RAW;
>  	fmt->format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> @@ -607,6 +819,7 @@ static int imx334_get_pad_format(struct v4l2_subdev *sd,
>  		framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
>  		fmt->format = *framefmt;
>  	} else {
> +		fmt->format.code = imx334->cur_code;
>  		imx334_fill_pad_format(imx334, imx334->cur_mode, fmt);
>  	}
>  
> @@ -633,15 +846,21 @@ static int imx334_set_pad_format(struct v4l2_subdev *sd,
>  
>  	mutex_lock(&imx334->mutex);
>  
> -	mode = &supported_mode;
> +	mode = v4l2_find_nearest_size(supported_modes,
> +				      ARRAY_SIZE(supported_modes),
> +				      width, height,
> +				      fmt->format.width, fmt->format.height);
> +
>  	imx334_fill_pad_format(imx334, mode, fmt);
> +	fmt->format.code = imx334_get_format_code(imx334, fmt->format.code);
>  
>  	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
>  		struct v4l2_mbus_framefmt *framefmt;
>  
>  		framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
>  		*framefmt = fmt->format;
> -	} else {
> +	} else if (imx334->cur_mode != mode || imx334->cur_code != fmt->format.code) {
> +		imx334->cur_code = fmt->format.code;
>  		ret = imx334_update_controls(imx334, mode);
>  		if (!ret)
>  			imx334->cur_mode = mode;
> @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
>  	struct v4l2_subdev_format fmt = { 0 };
>  
>  	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> -	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> +	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);

Now that there are multiple modes supported, this would appear to get the
width, height as well as the other fields (apart from mbus code) from the
first mode.

>  
>  	return imx334_set_pad_format(sd, sd_state, &fmt);
>  }
>  
> +static int imx334_set_framefmt(struct imx334 *imx334)
> +{
> +	switch (imx334->cur_code) {
> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +		return imx334_write_regs(imx334, raw10_framefmt_regs,
> +					 ARRAY_SIZE(raw10_framefmt_regs));
> +
> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +		return imx334_write_regs(imx334, raw12_framefmt_regs,
> +					 ARRAY_SIZE(raw12_framefmt_regs));
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /**
>   * imx334_start_streaming() - Start sensor stream
>   * @imx334: pointer to imx334 device
> @@ -691,6 +925,13 @@ static int imx334_start_streaming(struct imx334 *imx334)
>  		return ret;
>  	}
>  
> +	ret = imx334_set_framefmt(imx334);
> +	if (ret) {
> +		dev_err(imx334->dev, "%s failed to set frame format: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
>  	/* Setup handler will write actual exposure and gain */
>  	ret =  __v4l2_ctrl_handler_setup(imx334->sd.ctrl_handler);
>  	if (ret) {
> @@ -1061,7 +1302,8 @@ static int imx334_probe(struct i2c_client *client)
>  	}
>  
>  	/* Set default mode to max resolution */
> -	imx334->cur_mode = &supported_mode;
> +	imx334->cur_mode = &supported_modes[0];
> +	imx334->cur_code = imx334_mbus_codes[0];
>  	imx334->vblank = imx334->cur_mode->vblank;
>  
>  	ret = imx334_init_controls(imx334);

-- 
Regards,

Sakari Ailus
