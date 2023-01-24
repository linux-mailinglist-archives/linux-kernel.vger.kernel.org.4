Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96393679DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjAXPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjAXPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:37:29 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0F4ABDD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:37:24 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id k1-20020a056830150100b006864d1cb279so9404882otp.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZs4QBKM1DAEVrzUs2jgyYCzPM0eV7x/4GAFS4lm3sQ=;
        b=l9Z8T0E2m5/mSQ3JKltSSk5jXmaDoT8SCPv2k/xVjK3bo2HCD4bGJS5eS8HeMMnDxZ
         uaXs8u1YOJ0IgfRx4WonW12V3wa1/mGM9GHQAHfB5zaIjpXJSo40R4Ktsht8VINaLzCA
         Nr6S64pRCKqNt4kBz1JGkQhtB3Pu+YVAShmrIg1o5yTY7IuYJszLTS/ET/kXdz8TP6+s
         vb00KOToHsQJR+ZtVJDciiDT57IGFoqGkyXM/WxQxhSv2VrAymz9sXwU5LhrC4u4H+vH
         wmjlyzQAgXNKc34tWPMBJ3IUnPr8NlJhhQTIk3km3Zg2+i98zQhbSmXEB4QnrQ2+Zojc
         TNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZs4QBKM1DAEVrzUs2jgyYCzPM0eV7x/4GAFS4lm3sQ=;
        b=jrjRCf4y/bdpZQDkw9QqM86X1Vg2olpfk1AhVqlUTUf5Q4+hCaLjIEyRdVg7JZ2FOu
         iobjU2Aexg5X3FyFOB7kFtqKC9fuMvwgCqgU2mFQzt4+nc12tfvu0fHygsVi2IWDCZzV
         5xLihpMdqLSwsFQ0KdQJMaCbIs1c2sanHkJlNZLejgFWXO8GT/Aoa2C4si//oNfIDD3M
         1RXrX7Koetb1EsFW4sS2HEIm2qCk4/d2YCXyK+scck70GVciBSj66AGlDxkYD9si711y
         ZcB1O6rnDTF6A95HbcuItKWWbRb20VHphceG/JQt/aTmADtlwFr+PGlPu1stKpC6u8Z7
         Cn3Q==
X-Gm-Message-State: AFqh2kqX8F/jf8cv7SOpT4E1vvKF1ti6zbg4s315PP17vAY40XuAjBg4
        oqYBZpiAPvMWvTWjcTf8M14pNx1RCNDKSsLO
X-Google-Smtp-Source: AMrXdXu8iW/3doONUVQAUXPJo0FcqzleAkSPPX1xT9hUa07o6/qMBY63nUdCriPGj4RXhUCLdfr3Vg==
X-Received: by 2002:a9d:4c95:0:b0:686:5246:acd7 with SMTP id m21-20020a9d4c95000000b006865246acd7mr12336918otf.3.1674574643339;
        Tue, 24 Jan 2023 07:37:23 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.253])
        by smtp.gmail.com with ESMTPSA id m1-20020a9d6ac1000000b0068655f477a6sm1035562otq.50.2023.01.24.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:37:22 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:37:11 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v3] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Message-Id: <Z1YZOR.ZWVAJWRXN40J@vanguardiasur.com.ar>
In-Reply-To: <-263646320144248448@unknownmsgid>
References: <20230119084723.133576-1-benjamin.gaignard@collabora.com>
        <-263646320144248448@unknownmsgid>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks for the patch.

On Tue, Jan 24 2023 at 12:04:25 PM -0300, Ezequiel Garcia 
<ezequiel@vanguardiasur.com.ar> wrote:
> 
> 
> On Thu, Jan 19 2023 at 09:47:23 AM +0100, Benjamin Gaignard 
> <benjamin.gaignard@collabora.com> wrote:
>> When decoding a 10bits bitstreams HEVC driver should only expose
>> 10bits pixel formats.
>> To fulfill this requirement it is needed to call 
>> hantro_reset_raw_fmt()
>> when bit depth change and to correctly set match_depth in pixel 
>> formats
>> enumeration.
>> 
>> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
>> 
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> 
>> ---
>> version 3:
>> - Propagate hantro_reset_raw_fmt() error.
>>   I hope I have correctly understood Ezekiel's thoughts
>>   in the way I have implemented them.
>> 
>> version 2:
>> - Remove struct hantro_ctx *ctx variable in hantro_try_ctrl()
>>   because it isn't used anymore.
>> 
>>  .../media/platform/verisilicon/hantro_drv.c   | 40 
>> +++++++++++++++----
>>  .../media/platform/verisilicon/hantro_v4l2.c  |  6 +--
>>  .../media/platform/verisilicon/hantro_v4l2.h  |  1 +
>>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>>  4 files changed, 38 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c 
>> b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 8cb4a68c9119..a713a45c0108 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue 
>> *src_vq, struct vb2_queue *dst_vq)
>> 
>>  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>> -	struct hantro_ctx *ctx;
>> -
>> -	ctx = container_of(ctrl->handler,
>> -			   struct hantro_ctx, ctrl_handler);
>> -
>>  	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>>  		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>> 
>> @@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl 
>> *ctrl)
>>  		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 
>> != 2)
>>  			/* Only 8-bit and 10-bit are supported */
>>  			return -EINVAL;
>> -
>> -		ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;

Oh dammit this is wrong! The try_ctrl shouldn't be changing state!
I missed this when I reviewed the patch.

Please keep in mind, a "try" API in V4L2 typically just
validates but shouldn't set state.

I'm sure we will soon have a Hantro Rust driver and we will be able
to enforce state mutation rules :)

>>  	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>>  		const struct v4l2_ctrl_vp9_frame *dec_params = 
>> ctrl->p_new.p_vp9_frame;
>> 
>> @@ -286,6 +279,32 @@ static int hantro_try_ctrl(struct v4l2_ctrl 
>> *ctrl)
>>  	return 0;
>>  }
>> 
>> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +	struct hantro_ctx *ctx;
>> +
>> +	ctx = container_of(ctrl->handler,
>> +			   struct hantro_ctx, ctrl_handler);
>> +
>> +	vpu_debug(1, "s_ctrl: id = %d, val = %d\n", ctrl->id, ctrl->val);
>> +
>> +	switch (ctrl->id) {
>> +	case V4L2_CID_STATELESS_HEVC_SPS:
>> +		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
>> +		int bit_depth = sps->bit_depth_luma_minus8 + 8;
>> +
>> +		if (ctx->bit_depth != bit_depth) {
>> +			ctx->bit_depth = bit_depth;
>> +			return hantro_reset_raw_fmt(ctx);

You cannot simply return hantro_reset_raw() and set the bit_depth
in hantro_ctx.

If hantro_reset_raw fails, you would leave a bad state behind.

>> +		}
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>  	struct hantro_ctx *ctx;
>> @@ -328,6 +347,11 @@ static const struct v4l2_ctrl_ops 
>> hantro_ctrl_ops = {
>>  	.try_ctrl = hantro_try_ctrl,
>>  };
>> 
>> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
>> +	.s_ctrl = hantro_hevc_s_ctrl,
>> +	.try_ctrl = hantro_try_ctrl,
>> +};
>> +
>>  static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
>>  	.s_ctrl = hantro_jpeg_s_ctrl,
>>  };
>> @@ -470,7 +494,7 @@ static const struct hantro_ctrl controls[] = {
>>  		.codec = HANTRO_HEVC_DECODER,
>>  		.cfg = {
>>  			.id = V4L2_CID_STATELESS_HEVC_SPS,
>> -			.ops = &hantro_ctrl_ops,
>> +			.ops = &hantro_hevc_ctrl_ops,
>>  		},
>>  	}, {
>>  		.codec = HANTRO_HEVC_DECODER,
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c 
>> b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 2c7a805289e7..cd85877bbbe2 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -398,7 +398,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>>  		hantro_set_fmt_out(ctx, fmt);
>>  }
>> 
>> -static void
>> +int
>>  hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>>  {
>>  	const struct hantro_fmt *raw_vpu_fmt;
>> @@ -420,9 +420,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>>  	raw_fmt->width = encoded_fmt->width;
>>  	raw_fmt->height = encoded_fmt->height;
>>  	if (ctx->is_encoder)
>> -		hantro_set_fmt_out(ctx, raw_fmt);
>> +		return hantro_set_fmt_out(ctx, raw_fmt);
>>  	else
>> -		hantro_set_fmt_cap(ctx, raw_fmt);
>> +		return hantro_set_fmt_cap(ctx, raw_fmt);

And same here, you cannot simply return from hantro_reset_raw_fmt.
You need to unroll the changes to ctx->vpu_dst_fmt,
and ctx->vpu_src_fmt.

Thanks!

>>  }
>> 
>>  void hantro_reset_fmts(struct hantro_ctx *ctx)
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h 
>> b/drivers/media/platform/verisilicon/hantro_v4l2.h
>> index 64f6f57e9d7a..cb8e1fe3422d 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
>> @@ -21,6 +21,7 @@
>>  extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>>  extern const struct vb2_ops hantro_queue_ops;
>> 
>> +int hantro_reset_raw_fmt(struct hantro_ctx *ctx);
>>  void hantro_reset_fmts(struct hantro_ctx *ctx);
>>  int hantro_get_format_depth(u32 fourcc);
>>  const struct hantro_fmt *
>> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c 
>> b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> index b390228fd3b4..f850d8bddef6 100644
>> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> @@ -152,6 +152,7 @@ static const struct hantro_fmt 
>> imx8m_vpu_g2_postproc_fmts[] = {
>>  	{
>>  		.fourcc = V4L2_PIX_FMT_NV12,
>>  		.codec_mode = HANTRO_MODE_NONE,
>> +		.match_depth = true,
>>  		.postprocessed = true,
>>  		.frmsize = {
>>  			.min_width = FMT_MIN_WIDTH,
>> @@ -165,6 +166,7 @@ static const struct hantro_fmt 
>> imx8m_vpu_g2_postproc_fmts[] = {
>>  	{
>>  		.fourcc = V4L2_PIX_FMT_P010,
>>  		.codec_mode = HANTRO_MODE_NONE,
>> +		.match_depth = true,
>>  		.postprocessed = true,
>>  		.frmsize = {
>>  			.min_width = FMT_MIN_WIDTH,
>> --
>> 2.34.1
>> 


