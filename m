Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A6638E22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiKYQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKYQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:15:14 -0500
X-Greylist: delayed 966 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 08:15:11 PST
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504BC4D5DE;
        Fri, 25 Nov 2022 08:15:11 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkxjnptf9d2bpn7gcmbty-3.rev.dnainternet.fi [IPv6:2001:14ba:44ce:b640:9d1d:82c5:eca2:5060])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 3DFB31B00331;
        Fri, 25 Nov 2022 18:15:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1669392909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZJtr6042XdwoUWaKNJ1oXrlCIiVwbxeG+zpE7SS6nc=;
        b=dikvM0+I87bS8JOYDp7OPHcJuito7bNm8+UkK2tp7rWyHnI0VI4GY0TKlVEDBg1lR76uSS
        PcodVOq7bh7ERON/qFY49uC79MmY5COjuqjf/YB6tg+D+26xSAs2/xQaJd46Zeo4DDyh2l
        HnBSluu9WbDIGnC2RxGvmZismwlGrqHRdp3mwCq2aUIhjU6jDvRXWIaaT8zuzL45G4xIog
        Q2K8lUggsicu5y8wJAHexAhOj+7r7ldQb5Za+zkPT65aoLbrsPvymOIc8/D5t/4buCfiy/
        5P+Isyx+/xt49WSfVewpvrhbPGbLOWWbYvMRkNWmWj+NJYvnjL72utmT29lmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1669392909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZJtr6042XdwoUWaKNJ1oXrlCIiVwbxeG+zpE7SS6nc=;
        b=OSIAqWKT+Kj1ae/f51HK3KLglV4KuM5I266irjJZ/9eFGhyCUvOh9dkGOb6ij2o9e6zxpl
        wlqAN16UpuOYUkbhDMnlpd5VSLR5ETUaJs7hsLH1/PlJDGxrrSJ7CXfJ+0fO5OC0WCmT1F
        baZ8ko6YVSKnj5F6Y+zEVmNrzTPg7dpTC+Ledw2xUUJHKh1VpQK4z/AljvG6E+xZluSO0/
        lRHLFanfZ5iLOs4vcM+yobgc6C7Oqw+P9YDB7Jkqnec3Qp4fPgjWuEnWAiMpH0eXrqASF1
        WP6GVuNOWXcq3CTpy5lysUQ34qwFwGgjCX3JvyYDYMLCQkFF5jbf9kRSKEOyog==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1669392909; a=rsa-sha256;
        cv=none;
        b=FB4EeUWKGPp40xf5n7hqN4dnEqirb98KbumjtdK4Sb+oOK5LBcs2O5lBghmiZWFTeC9KhJ
        7EagrMQaqLB+vTEaCKRgucGd4hQIEb7q4RnUjfHB0LRMJlIPF+JxKzudWSAPsyKzXZV1IU
        +AXNc1mRxkM4IWeaARfZ9fgWLVD6fdXDPO2gCINdHj0CkByWY5zhTn8prbTuLaWcsdmHG1
        Pxc82lxoF3xMHnGGmGA6x6XZQ+KgjHNGz5QHdnk1yjxLTsRZnL7Zmnwbeq6JBILTyHkxMG
        QM4NqFc7W8eg/zLGKdJZN1mHIEg0tBqHiDyOnrbMC6Pcbj7OumIURIzBNKM90A==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id D01F3634C92;
        Fri, 25 Nov 2022 18:15:08 +0200 (EET)
Date:   Fri, 25 Nov 2022 18:15:08 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Prakash Battu <Prakash.Battu@microchip.com>
Subject: Re: [PATCH v5 5/6] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y4DqDJV1JPJtzKCk@valkosipuli.retiisi.eu>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-6-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125050807.1857479-6-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Fri, Nov 25, 2022 at 10:38:06AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Some platforms may not be capable of supporting the bandwidth
> required for 12 bit or 3840x2160@60 resolutions.
> 
> Add support for dynamically selecting 10 bit and 1920x1080@30
> resolutions while leaving the existing configuration as default
> 
> CC: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Prakash Battu <Prakash.Battu@microchip.com>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 302 +++++++++++++++++++++++++++++++++----
>  1 file changed, 276 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index cd41df56ab7d..0e5575604d87 100644
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
> @@ -147,6 +147,169 @@ static const s64 link_freq[] = {
>  	IMX334_LINK_FREQ,
>  };
>  
> +/* Sensor mode registers */
> +static const struct imx334_reg mode_1920x1080_regs[] = {
> +	{0x3000, 0x01},
> +	{0x3018, 0x04},
> +	{0x3030, 0xCA},
> +	{0x3031, 0x08},
> +	{0x3032, 0x00},
> +	{0x3034, 0x4C},
> +	{0x3035, 0x04},
> +	{0x302C, 0xF0},
> +	{0x302D, 0x03},
> +	{0x302E, 0x80},
> +	{0x302F, 0x07},
> +	{0x3074, 0xCC},
> +	{0x3075, 0x02},
> +	{0x308E, 0xCD},
> +	{0x308F, 0x02},
> +	{0x3076, 0x38},
> +	{0x3077, 0x04},
> +	{0x3090, 0x38},
> +	{0x3091, 0x04},
> +	{0x3308, 0x38},
> +	{0x3309, 0x04},
> +	{0x30C6, 0x00},
> +	{0x30C7, 0x00},
> +	{0x30CE, 0x00},
> +	{0x30CF, 0x00},
> +	{0x30D8, 0x18},
> +	{0x30D9, 0x0A},
> +	{0x304C, 0x00},
> +	{0x304E, 0x00},
> +	{0x304F, 0x00},
> +	{0x3050, 0x00},
> +	{0x30B6, 0x00},
> +	{0x30B7, 0x00},
> +	{0x3116, 0x08},
> +	{0x3117, 0x00},
> +	{0x31A0, 0x20},
> +	{0x31A1, 0x0F},
> +	{0x300C, 0x3B},
> +	{0x300D, 0x29},
> +	{0x314C, 0x29},
> +	{0x314D, 0x01},
> +	{0x315A, 0x06},
> +	{0x3168, 0xA0},
> +	{0x316A, 0x7E},
> +	{0x319E, 0x02},
> +	{0x3199, 0x00},
> +	{0x319D, 0x00},
> +	{0x31DD, 0x03},
> +	{0x3300, 0x00},
> +	{0x341C, 0xFF},
> +	{0x341D, 0x01},
> +	{0x3A01, 0x03},
> +	{0x3A18, 0x7F},
> +	{0x3A19, 0x00},
> +	{0x3A1A, 0x37},
> +	{0x3A1B, 0x00},
> +	{0x3A1C, 0x37},
> +	{0x3A1D, 0x00},
> +	{0x3A1E, 0xF7},
> +	{0x3A1F, 0x00},
> +	{0x3A20, 0x3F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x6F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x3F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x5F},
> +	{0x3A21, 0x00},
> +	{0x3A20, 0x2F},
> +	{0x3A21, 0x00},
> +	{0x3078, 0x02},
> +	{0x3079, 0x00},
> +	{0x307A, 0x00},
> +	{0x307B, 0x00},
> +	{0x3080, 0x02},
> +	{0x3081, 0x00},
> +	{0x3082, 0x00},
> +	{0x3083, 0x00},
> +	{0x3088, 0x02},
> +	{0x3094, 0x00},
> +	{0x3095, 0x00},
> +	{0x3096, 0x00},
> +	{0x309B, 0x02},
> +	{0x309C, 0x00},
> +	{0x309D, 0x00},
> +	{0x309E, 0x00},
> +	{0x30A4, 0x00},
> +	{0x30A5, 0x00},
> +	{0x3288, 0x21},
> +	{0x328A, 0x02},
> +	{0x3414, 0x05},
> +	{0x3416, 0x18},
> +	{0x35AC, 0x0E},
> +	{0x3648, 0x01},
> +	{0x364A, 0x04},
> +	{0x364C, 0x04},
> +	{0x3678, 0x01},
> +	{0x367C, 0x31},
> +	{0x367E, 0x31},
> +	{0x3708, 0x02},
> +	{0x3714, 0x01},
> +	{0x3715, 0x02},
> +	{0x3716, 0x02},
> +	{0x3717, 0x02},
> +	{0x371C, 0x3D},
> +	{0x371D, 0x3F},
> +	{0x372C, 0x00},
> +	{0x372D, 0x00},
> +	{0x372E, 0x46},
> +	{0x372F, 0x00},
> +	{0x3730, 0x89},
> +	{0x3731, 0x00},
> +	{0x3732, 0x08},
> +	{0x3733, 0x01},
> +	{0x3734, 0xFE},
> +	{0x3735, 0x05},
> +	{0x375D, 0x00},
> +	{0x375E, 0x00},
> +	{0x375F, 0x61},
> +	{0x3760, 0x06},
> +	{0x3768, 0x1B},
> +	{0x3769, 0x1B},
> +	{0x376A, 0x1A},
> +	{0x376B, 0x19},
> +	{0x376C, 0x18},
> +	{0x376D, 0x14},
> +	{0x376E, 0x0F},
> +	{0x3776, 0x00},
> +	{0x3777, 0x00},
> +	{0x3778, 0x46},
> +	{0x3779, 0x00},
> +	{0x377A, 0x08},
> +	{0x377B, 0x01},
> +	{0x377C, 0x45},
> +	{0x377D, 0x01},
> +	{0x377E, 0x23},
> +	{0x377F, 0x02},
> +	{0x3780, 0xD9},
> +	{0x3781, 0x03},
> +	{0x3782, 0xF5},
> +	{0x3783, 0x06},
> +	{0x3784, 0xA5},
> +	{0x3788, 0x0F},
> +	{0x378A, 0xD9},
> +	{0x378B, 0x03},
> +	{0x378C, 0xEB},
> +	{0x378D, 0x05},
> +	{0x378E, 0x87},
> +	{0x378F, 0x06},
> +	{0x3790, 0xF5},
> +	{0x3792, 0x43},
> +	{0x3794, 0x7A},
> +	{0x3796, 0xA1},
> +	{0x37B0, 0x37},
> +	{0x3E04, 0x0E},
> +	{0x30E8, 0x50},
> +	{0x30E9, 0x00},
> +	{0x3E04, 0x0E},
> +	{0x3002, 0x00},
> +};
> +
>  /* Sensor mode registers */
>  static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3000, 0x01},
> @@ -263,20 +426,56 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3A29, 0x00},
>  };
>  
> +static const struct imx334_reg raw10_framefmt_regs[] = {
> +	{0x3050, 0x00},
> +	{0x319D, 0x00},
> +	{0x341C, 0xFF},
> +	{0x341D, 0x01},
> +};
> +
> +static const struct imx334_reg raw12_framefmt_regs[] = {
> +	{0x3050, 0x01},
> +	{0x319D, 0x01},
> +	{0x341C, 0x47},
> +	{0x341D, 0x00},
> +};
> +
> +/*
> + * The supported BUS formats.
> + */

Redundant comment.

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
> +		.hblank = 280,
> +		.vblank = 1170,
> +		.vblank_min = 90,
> +		.vblank_max = 132840,
> +		.pclk = 74250000,
> +		.link_freq_idx = 0,
> +		.reg_list = {
> +			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
> +			.regs = mode_1920x1080_regs,
> +		},
>  	},
>  };
>  
> @@ -527,10 +726,10 @@ static int imx334_enum_mbus_code(struct v4l2_subdev *sd,
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
> @@ -547,15 +746,22 @@ static int imx334_enum_frame_size(struct v4l2_subdev *sd,
>  				  struct v4l2_subdev_state *sd_state,
>  				  struct v4l2_subdev_frame_size_enum *fsize)
>  {
> -	if (fsize->index > 0)
> +	unsigned int i;
> +
> +	if (fsize->index >= ARRAY_SIZE(supported_modes))
>  		return -EINVAL;
>  
> -	if (fsize->code != supported_mode.code)
> +	for (i = 0; i < ARRAY_SIZE(imx334_mbus_codes); ++i) {
> +		if (imx334_mbus_codes[i] == fsize->code)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(imx334_mbus_codes))

You could use >= instead, as you do below. You could also refactor this a
little to avoid duplicating the these lines.

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
> @@ -574,7 +780,6 @@ static void imx334_fill_pad_format(struct imx334 *imx334,
>  {
>  	fmt->format.width = mode->width;
>  	fmt->format.height = mode->height;
> -	fmt->format.code = mode->code;
>  	fmt->format.field = V4L2_FIELD_NONE;
>  	fmt->format.colorspace = V4L2_COLORSPACE_RAW;
>  	fmt->format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> @@ -612,6 +817,21 @@ static int imx334_get_pad_format(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> +static int imx334_get_format_code(struct imx334 *imx334, struct v4l2_subdev_format *fmt)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(imx334_mbus_codes); i++) {
> +		if (imx334_mbus_codes[i] == fmt->format.code)
> +			break;
> +	}
> +
> +	if (i >= ARRAY_SIZE(imx334_mbus_codes))
> +		i = 0;
> +
> +	return imx334_mbus_codes[i];
> +}
> +
>  /**
>   * imx334_set_pad_format() - Set subdevice pad format
>   * @sd: pointer to imx334 V4L2 sub-device structure
> @@ -630,7 +850,13 @@ static int imx334_set_pad_format(struct v4l2_subdev *sd,
>  
>  	mutex_lock(&imx334->mutex);
>  
> -	mode = &supported_mode;
> +	fmt->format.code = imx334_get_format_code(imx334, fmt);
> +
> +	mode = v4l2_find_nearest_size(supported_modes,
> +				      ARRAY_SIZE(supported_modes),
> +				      width, height,
> +				      fmt->format.width, fmt->format.height);
> +
>  	imx334_fill_pad_format(imx334, mode, fmt);
>  
>  	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
> @@ -638,7 +864,8 @@ static int imx334_set_pad_format(struct v4l2_subdev *sd,
>  
>  		framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
>  		*framefmt = fmt->format;
> -	} else {
> +	} else if (imx334->cur_mode != mode || imx334->cur_code != fmt->format.code) {
> +		imx334->cur_code = fmt->format.code;
>  		ret = imx334_update_controls(imx334, mode);
>  		if (!ret)
>  			imx334->cur_mode = mode;
> @@ -663,11 +890,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
>  	struct v4l2_subdev_format fmt = { 0 };
>  
>  	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> -	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> +	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
>  
>  	return imx334_set_pad_format(sd, sd_state, &fmt);
>  }
>  
> +static int imx334_set_framefmt(struct imx334 *imx334)
> +{
> +	switch (imx334->cur_code) {
> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> +		return imx334_write_regs(imx334, raw10_framefmt_regs,
> +					ARRAY_SIZE(raw10_framefmt_regs));
> +
> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> +		return imx334_write_regs(imx334, raw12_framefmt_regs,
> +					ARRAY_SIZE(raw12_framefmt_regs));

Please align just right of the opening parenthesis. The same above.

> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /**
>   * imx334_start_streaming() - Start sensor stream
>   * @imx334: pointer to imx334 device
> @@ -688,6 +930,13 @@ static int imx334_start_streaming(struct imx334 *imx334)
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
> @@ -1058,7 +1307,8 @@ static int imx334_probe(struct i2c_client *client)
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
Kind regards,

Sakari Ailus
