Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985269BA1B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBRM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBRM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:58:06 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6212F3C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 04:58:05 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id l5-20020a4a8545000000b005200828499dso189526ooh.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112; t=1676725085;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=heB0LSPERxtNOuR2XXO/S13lArXamWKUpciLIk5RPJQ=;
        b=FMZjJIh2uILxt3mdEAV2y56p6GbGQZL5CT+raq4rSjrhYunspFS4t80uEzwgnh1YLh
         1uH0hu/M/g/RCraP6ENjSimA36idXoKpLf1QEll/LepVq9iYoJDLbHpr+fDZcmwG0gg/
         JaDwBGJxLMXdkGT4DLpnupxoDPicKzJtfL20aQWvR9z6hNLoUQi7Nix7bSG//51lwxUG
         63NYAaU6a127r6s4FJ01BVqUR4wX3LzvXdAkRdMnI9fCO2YZEWl5bzfZT0jCn48eiFVN
         j8+pr0GHBKaaaTKoEzTCTVqxBgRG8HJoBB+7u+FWOuydB1FOifOY5DODqRv5ezeg9YJC
         7qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676725085;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heB0LSPERxtNOuR2XXO/S13lArXamWKUpciLIk5RPJQ=;
        b=0ddIrTJawjDZYnW4xtg/HSoSbaUpyB7QvNzyZicFRh3yPW6IhPqvUPBMmwcD2pWJ0/
         1x0BrIzXd8GeWGSMjtWo5pM8ShVDeA66jQy6WVROQGCJOl7Jq8TNSI7SZpBsZUmnk+8O
         x2fJ76FJWoZNHcffR7PQJVSBqJtMsXzi+EI0sistvCQvtE9maOg3e2IlMEZtGlhA8Dkl
         Q/39WKV8y1CwWPb6ZG9nDCWSh3mfRJJLdPsR/YJFo0PpJVw+5V9pmCOhLuhu8Ha2y7jx
         FxhkNL3BFKjkS4/Q3R9gXzwhG8rOjfL14U/hlEygfC30gpC8E9bCP8qnRBzxjYimGq6r
         bLUw==
X-Gm-Message-State: AO0yUKXUyKdM/cmgiKPrMvz69Q0LCmGaAdPgEtQ5r0ngYuYQSN9aGyi+
        hlCsfgedhuFr2ARUm8GKUPVYkQ==
X-Google-Smtp-Source: AK7set8XPnUmsRlxZBklZLpDgfpIOdRVMYbHg18Hiw7ix7n3RpdMa2n0YRWdO3VzWN+jrHShf1eG1Q==
X-Received: by 2002:a4a:3559:0:b0:51f:b89d:7c22 with SMTP id w25-20020a4a3559000000b0051fb89d7c22mr2092600oog.1.1676725085062;
        Sat, 18 Feb 2023 04:58:05 -0800 (PST)
Received: from [192.168.10.175] ([190.11.59.127])
        by smtp.gmail.com with ESMTPSA id y2-20020a4ad642000000b0051ff746e2b2sm2535402oos.8.2023.02.18.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 04:58:04 -0800 (PST)
Date:   Sat, 18 Feb 2023 09:57:52 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v8 5/6] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <GC1AQR.P5N43DMFQK0D1@vanguardiasur.com.ar>
In-Reply-To: <20230203091622.127279-6-benjamin.gaignard@collabora.com>
References: <20230203091622.127279-1-benjamin.gaignard@collabora.com>
        <20230203091622.127279-6-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, Feb 3 2023 at 10:16:21 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> When decoding a 10bits bitstreams HEVC driver should only expose
> 10bits pixel formats.
> To fulfill this requirement it is needed to call 
> hantro_reset_raw_fmt()
> when bit depth change and to correctly set match_depth in pixel 
> formats
> enumeration.
> 
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c   | 11 +++++++++--
>  drivers/media/platform/verisilicon/imx8m_vpu_hw.c |  2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c 
> b/drivers/media/platform/verisilicon/hantro_drv.c
> index 6d8bc55ea627..fa31b200b097 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -326,8 +326,15 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl 
> *ctrl)
> 
>  	switch (ctrl->id) {
>  	case V4L2_CID_STATELESS_HEVC_SPS:
> -		ctx->bit_depth = ctrl->p_new.p_hevc_sps->bit_depth_luma_minus8 + 8;
> -		break;
> +	{

Should be:

case V4L2_CID_STATELESS_HEVC_SPS: {

...

Same for VP9.

Thanks,
Ezequiel

> +		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
> +		int bit_depth = sps->bit_depth_luma_minus8 + 8;
> +
> +		if (ctx->bit_depth == bit_depth)
> +			return 0;
> +
> +		return hantro_reset_raw_fmt(ctx, bit_depth);
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c 
> b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index b390228fd3b4..f850d8bddef6 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -152,6 +152,7 @@ static const struct hantro_fmt 
> imx8m_vpu_g2_postproc_fmts[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_NV12,
>  		.codec_mode = HANTRO_MODE_NONE,
> +		.match_depth = true,
>  		.postprocessed = true,
>  		.frmsize = {
>  			.min_width = FMT_MIN_WIDTH,
> @@ -165,6 +166,7 @@ static const struct hantro_fmt 
> imx8m_vpu_g2_postproc_fmts[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_P010,
>  		.codec_mode = HANTRO_MODE_NONE,
> +		.match_depth = true,
>  		.postprocessed = true,
>  		.frmsize = {
>  			.min_width = FMT_MIN_WIDTH,
> --
> 2.34.1
> 


