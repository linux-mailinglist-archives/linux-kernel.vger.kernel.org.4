Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE362580C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiKKKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiKKKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:19:20 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F17130
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:18:22 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 11BFD1B000E5;
        Fri, 11 Nov 2022 12:18:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1668161895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nViUIP5mZmGtAcBV7snG5srmqkB1zpkdDW7/29no2No=;
        b=jNt6JfEZ5aGzSsR7mmdsv5dbmu+34iOoULra6wXXpxwvTUgYZxTCEi4RmgxXdceKaExMAR
        LveyiuEpjX3xULjpvftOr5EeKHRae+xeteUabY81dpevQ/Prn7jjNUffWUN7lGYRkmYVWJ
        W15h/T+b2eKF6xplIQlKa23TcfCoaSgsoR824q9qVptC7YhUVK6bml992XEdU6+d7tKZ7o
        VI/veBgmEQUn+jlX7U3eTwBQD44TSsUfd7FKQlBVDTOLv+y4f3IQKbNLmzK6I+JdMKAec/
        9Bg1x2JsJmU+gVmAs5WF1eWArQMKc8XKwO5H2CLm4gqLlMebmIQfGYGKFPLuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1668161895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nViUIP5mZmGtAcBV7snG5srmqkB1zpkdDW7/29no2No=;
        b=VBkOEh0DSaUX6ByzycgXH+uFHGNLlvIzRON3c501iKDTdcny9QDNC2vbT8ZaB2R04rzkQ+
        FeTrys/6GMqYM0pu86BCVK+Isfh1KPetVmJbvOBqN9Kbv+BhD6etFo8yt5rpU11Y61UZno
        KisVCGr7h/4mGznD3bJvNJ/ZRhxqo5pixzBzjc8ZD2WVstwFxnpAuwmXcPsHE+WkIdWHKl
        sz/9bvNDP0xylhBh2cvYs86IdnMtqpMP3DPlFpaQNhjtCywnQi9Yr+jHrBh6UhklbwO2xJ
        TpJJ2e7yYtDo94K8dsBDLIXd+1KFwr/eNvAhlft1BqkjEVF1Vc6zndHxMzwqGg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1668161895; a=rsa-sha256;
        cv=none;
        b=WBujtx9mQT5kPGfDvr+V/dHH6kUlxJGdIcrC021JEft8XFiI3wROMPYufZm5nWVcZtTt5p
        +TAJuYBP594nLyxxaCEoQXsQxhy7rgzBvmYlcCe4XR8us43oYc2NmNRT6pWoHTIN16uvma
        GUQ5kwD29S9X7m5IJoejXiMqeTn0KSRvlB9T+EpLj3vN6LUKC1hiGFXvN8Zod30moB4/Yt
        NHdjPgAw+sKqra5M56h4cks7qwQ4cAMZHT4TB/iR1OizmF147vr9CJDIxujmqU0d2xymuI
        5ObuQ1Kv9sctkYgGXmCigTIgvqjiNtJPhZSO/DCunzy8yN67nzzoTuwHBIFL5g==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B05A7634C98;
        Fri, 11 Nov 2022 12:18:14 +0200 (EET)
Date:   Fri, 11 Nov 2022 12:18:14 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 18/28] media: sun6i-csi: Introduce format match
 structure, list and helper
Message-ID: <Y24hZjkRp0rBpzTZ@valkosipuli.retiisi.eu>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
 <20221103163113.245462-19-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103163113.245462-19-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Nov 03, 2022 at 05:31:03PM +0100, Paul Kocialkowski wrote:
> Introduce a list of mbus/pixel format combinations that need an exact
> match between the two sides. This is the case when using raw input
> configuration. The list will be used to replace the
> sun6i_csi_is_format_supported combinatory helper.

This patch introduces an unused function which generates a compiler warning
that is now treated as an error.

I'll squash this to the following patch that uses the function. I think the
commit message will do as-is.

> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 117 ++++++++++++++++++
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   5 +
>  2 files changed, 122 insertions(+)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> index 99b821d79357..7958419d3c6e 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -227,6 +227,123 @@ struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat)
>  	return NULL;
>  }
>  
> +/* RAW formats need an exact match between pixel and mbus formats. */
> +static const
> +struct sun6i_csi_capture_format_match sun6i_csi_capture_format_matches[] = {
> +	/* YUV420 */
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_YUYV,
> +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_YUYV,
> +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1X16,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_YVYU,
> +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_YVYU,
> +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_1X16,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_UYVY,
> +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_UYVY,
> +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_1X16,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_VYUY,
> +		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_VYUY,
> +		.mbus_code	= MEDIA_BUS_FMT_VYUY8_1X16,
> +	},
> +	/* RGB */
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_RGB565,
> +		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_LE,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_RGB565X,
> +		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_BE,
> +	},
> +	/* Bayer */
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SBGGR8,
> +		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SGBRG8,
> +		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SGRBG8,
> +		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SRGGB8,
> +		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SBGGR10,
> +		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SGBRG10,
> +		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SGRBG10,
> +		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SRGGB10,
> +		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SBGGR12,
> +		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SGBRG12,
> +		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SGRBG12,
> +		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
> +	},
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_SRGGB12,
> +		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
> +	},
> +	/* Compressed */
> +	{
> +		.pixelformat	= V4L2_PIX_FMT_JPEG,
> +		.mbus_code	= MEDIA_BUS_FMT_JPEG_1X8,
> +	},
> +};
> +
> +static bool sun6i_csi_capture_format_match(u32 pixelformat, u32 mbus_code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_format_matches); i++) {
> +		const struct sun6i_csi_capture_format_match *match =
> +			&sun6i_csi_capture_format_matches[i];
> +
> +		if (match->pixelformat == pixelformat &&
> +		    match->mbus_code == mbus_code)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Capture */
>  
>  static void sun6i_csi_capture_irq_enable(struct sun6i_csi_device *csi_dev)
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> index 4b1ff19edc2f..2605b16f091c 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> @@ -27,6 +27,11 @@ struct sun6i_csi_capture_format {
>  	u32	hsize_len_factor;
>  };
>  
> +struct sun6i_csi_capture_format_match {
> +	u32	pixelformat;
> +	u32	mbus_code;
> +};
> +
>  #undef current
>  struct sun6i_csi_capture_state {
>  	struct list_head		queue;

-- 
Kind regards,

Sakari Ailus
