Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592AC6777B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAWJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAWJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:48:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFC126D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:47:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so10139335wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iIfSs1QU1y62hh19vUyf32vrywpZMGQTYBDrvO1iiAw=;
        b=SgDrQSwGjXxTU2UClar2sLKGiAclP9O53rWoeJS/htmHdHmj221R1PfCZvV6sxhIoM
         scZnK8u5Fdu++gqz0qBCFSrK8mAAy5IlNSbApeKcNbbBtydSs8h0XPMlMdR2wQ9fc327
         smRhFO1m+aKBuYbA6906CKaewlaoExJxuRrJazRjmq9evys+5Hx+KZchZKGmuP4zZfJs
         BhHGYp3fXsjvdZiCRuOrLUYAOdC4UHUtnpmCoknonMdD7vDSaYQnxYWTegPJ0bA+xSNN
         BQjVmTifXvQoK6mmzJFGaRTQS79LcU0U8KO7DZW0pfEYqd5MCg/Wz4tjHkO1bVkQMiO5
         bCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIfSs1QU1y62hh19vUyf32vrywpZMGQTYBDrvO1iiAw=;
        b=iZ3cxNzU3BM9PgkvaNexPqUbVnmDdWKoVg12kbnbaHU/Z78dXYAp40rrtBTf4yv2a0
         Lyhk+mj7pnMRuO3lB37lsQ5IRRuQRacFRHOV5janQaV5cfoVmxK7Uff/D5xUTsDPx2z5
         FUmstlCChKpoY16TNDgeX/4btBYwcYWRBXTVVFX8q3VGlORq8FTewXs7S93DEeyJChFu
         bh8V3hlREtlKi3OcCwG9cfegGC+cLosyQKYmv+ty9YYdOl6X02M3YSVkqrwx6WT9/BM3
         /6eA2sTMIjATCLEadQLIXPjrGz6lwy9kdM/rw71GmtFa23495GiWxM+r1pE8p6wyj4Vg
         ezog==
X-Gm-Message-State: AFqh2krHDs57RtVHSwsLAFqGbwI/z5WJvmpZksp4AzYG/eN1V4qqd6PT
        tZXA805+fCFuTZg3Qc7cH+icGoi5zIc7oXJd1NQ=
X-Google-Smtp-Source: AMrXdXstCCqiov4SnLO9YPRF6ilbaVnOwBM7iOZselENPe8gfNIr7OzYice+0ciH9jM+ocDeKZ2tgA==
X-Received: by 2002:a05:600c:21c4:b0:3da:fcf1:d4cc with SMTP id x4-20020a05600c21c400b003dafcf1d4ccmr23134268wmj.30.1674467278075;
        Mon, 23 Jan 2023 01:47:58 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id ba9-20020a0560001c0900b002b57bae7174sm4078111wrb.5.2023.01.23.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:47:57 -0800 (PST)
Message-ID: <3a3d9fc5-0f61-8da7-dc4c-7b57b0272230@linaro.org>
Date:   Mon, 23 Jan 2023 10:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] media: meson: vdec: esparser: check parsing state with
 hardware write pointer
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
References: <20230123094300.2816812-1-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230123094300.2816812-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 10:43, Christian Hewitt wrote:
> From: Neil Armstrong <narmstrong@baylibre.com>
> 
> Also check the hardware write pointer to check if ES Parser has stalled.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   drivers/staging/media/meson/vdec/esparser.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
> index df5956c6141d..41b705f999b2 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -300,6 +300,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>   	u32 num_dst_bufs = 0;
>   	u32 offset;
>   	u32 pad_size;
> +	u32 wp, wp2;
>   
>   	/*
>   	 * When max ref frame is held by VP9, this should be -= 3 to prevent a
> @@ -354,15 +355,21 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>   	}
>   
>   	pad_size = esparser_pad_start_code(core, vb, payload_size);
> +	wp = amvdec_read_parser(core, PARSER_VIDEO_WP);
>   	ret = esparser_write_data(core, phy, payload_size + pad_size);
> +	wp2 = amvdec_read_parser(core, PARSER_VIDEO_WP);
>   
>   	if (ret <= 0) {
> -		dev_warn(core->dev, "esparser: input parsing error\n");
> -		amvdec_remove_ts(sess, vb->timestamp);
> -		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>   		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
>   
> -		return 0;
> +		if (ret < 0 || wp2 == wp) {
> +			dev_err(core->dev, "esparser: input parsing error ret %d (%x <=> %x)\n",
> +				ret, wp, wp2);
> +			amvdec_remove_ts(sess, vb->timestamp);
> +			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +
> +			return 0;
> +		}
>   	}
>   
>   	atomic_inc(&sess->esparser_queued_bufs);

It's weird, but:

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks Christian for handling those changes

Neil
