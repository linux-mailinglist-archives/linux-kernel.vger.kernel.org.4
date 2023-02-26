Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06656A2F85
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBZM6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:58:19 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54815FED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:58:15 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1723ab0375eso4916191fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffpsrszCFOl/BRtjybTqoxE9P3nhS9dZXtxaImYO5vg=;
        b=dqWOW2St4aVLEJLqa5JmQOlmCybBIZA05/zyaD7QHodPgszD+bv2NM1b4x9e+N8BeW
         yiz/6m9ss3+lutNumjFDpzCsJrBMJbfDeUEqmLd4lyQI13q9rw4fysXxvL8IoFFeffs/
         MmR6s0s3q1ZLy9uIzUzH8Pt4m+vJ2fcxKi5o4ZJBUqBFpiyfdWRKiBJ37SM05VJ/yIew
         GRznlkLZRHufEUixSffqcSTqC2DsceBnBPjIuFErxHQf3+zPdjZvqFZo95fvXbVcd0Jj
         NQteUnsiwDLA526NHKeMWupv3qTJRCKJf5f4rw1UYJUWfyQCUs61fJAjUJxOqGE0HL3z
         dg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffpsrszCFOl/BRtjybTqoxE9P3nhS9dZXtxaImYO5vg=;
        b=U7jTOD5d2VMabshRpm4Fze5QtxeDZxa3IEGRR3TUuAQNz/z1ccxZy5obJClIGiJVaF
         Hgvv3lmqBWBELeei7LrgSpLE+WVuav+nUspkjiGMeD4F67rN+98MAuV0lVTw5EmXlHEW
         Lse6pRfHcuwJx4Et+UV/6jj8C6SbqjFFwoDxAmQKGElAHq/2Zz82At7y5ElXz/YJEgH8
         +ejlNHBtcRkQ4gfp9W+p7dJz1BYnSWRvQDWtVjGFqQ63uNGWsVBwjkHp/NONBj+ScfL8
         fmYBigu91fbb+bP58WCKDEekvCR1fkNzSTBYP0ZbWYu0CneTBDoMrhwOnZZjRyS/G36u
         D8BA==
X-Gm-Message-State: AO0yUKU8HzrNgH7tvAy7xgz6tlvskyt8MG8TsJ+6mPTisfwgpfKYSHv4
        RfLgbRysucUtw6x0G0gMOi+0Tw==
X-Google-Smtp-Source: AK7set+3UDCiggks2X3Rf7tQ3w77M+xHmsbg68aKU3wQvTH0XSCtd2I15hi7ZekOgbUm1XvQ3siNyg==
X-Received: by 2002:a05:6870:b627:b0:171:e1c8:41e with SMTP id cm39-20020a056870b62700b00171e1c8041emr11742580oab.5.1677416295033;
        Sun, 26 Feb 2023 04:58:15 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.26])
        by smtp.gmail.com with ESMTPSA id a16-20020a9d6e90000000b0068bdfa56717sm1556902otr.36.2023.02.26.04.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:58:13 -0800 (PST)
Date:   Sun, 26 Feb 2023 09:58:01 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, robert.mader@collabora.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Message-Id: <POUOQR.U8N7XH00WJ8U3@vanguardiasur.com.ar>
In-Reply-To: <20230220104849.398203-2-benjamin.gaignard@collabora.com>
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
        <20230220104849.398203-2-benjamin.gaignard@collabora.com>
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



On Mon, Feb 20 2023 at 11:48:44 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> Setting context source and destination formats should only be done
> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
> the targeted queue is not busy.
> Remove these calls from hantro_reset_encoded_fmt() and
> hantro_reset_raw_fmt() to clean the driver.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c 
> b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index c0d427956210..d8aa42bd4cd4 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -382,13 +382,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
> 
>  	vpu_fmt = hantro_get_default_fmt(ctx, true);
> 
> -	if (ctx->is_encoder) {
> -		ctx->vpu_dst_fmt = vpu_fmt;
> +	if (ctx->is_encoder)
>  		fmt = &ctx->dst_fmt;
> -	} else {
> -		ctx->vpu_src_fmt = vpu_fmt;
> +	else
>  		fmt = &ctx->src_fmt;
> -	}
> 
>  	hantro_reset_fmt(fmt, vpu_fmt);
>  	fmt->width = vpu_fmt->frmsize.min_width;
> @@ -408,11 +405,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>  	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
> 
>  	if (ctx->is_encoder) {
> -		ctx->vpu_src_fmt = raw_vpu_fmt;
>  		raw_fmt = &ctx->src_fmt;
>  		encoded_fmt = &ctx->dst_fmt;
>  	} else {
> -		ctx->vpu_dst_fmt = raw_vpu_fmt;
>  		raw_fmt = &ctx->dst_fmt;
>  		encoded_fmt = &ctx->src_fmt;
>  	}
> --
> 2.34.1
> 


