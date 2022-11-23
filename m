Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5A6352A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiKWI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiKWI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:28:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E965288F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:28:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so753998wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zsa6X0bJBSeI5SJRXVN9RfXeuhhHKtuQ+n10vqBddU=;
        b=W+ihjKp9cTQKRJ3YDH/877OHZJg9vU8/HHZlsLAPCpvSL0kAKndm70/m02bdhFuzSp
         X9sQpLD785YHshgIkFrOJtdENKQlN41degI+v/cfxSxpuB4j0OVxqbbfl3yVnGQSjjSb
         ScZfsPwc12zNbTrrdm0MMZ5zWW+VZkv7DiFhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zsa6X0bJBSeI5SJRXVN9RfXeuhhHKtuQ+n10vqBddU=;
        b=4OE///Thy/X4bFQf0toYAFXYCn4SbNKwnK7wKEWUxFecQi/CeBtmbA9QS/fSeArzzb
         edIYohAlerxgu5TM0eryMMtjYCdAhURRxJIarTGhHxLsjD4GtcQxF7WW8THbEjRxFDX7
         m2Y0hBtnnIFZ28Bgd2cPWoq71kp8/Ktt6WKqGUDfgeTD0UJsCL/C7g/RLd2/Xi8Z1U6J
         eCkGEwYnxfhT6s+ATvf3LKZYlx+2xY4aZNKba3mhUuAQXBt1JVym+pVTBstw4HzL53ae
         K9MNb/fd6K10K/UTxH9ZO4y9r3lNw+BpzFwbtMO96Lm65Je8mBWcUK19OrgPHJU+u3Y7
         XDnA==
X-Gm-Message-State: ANoB5plFfE4pYbOyedrDeR28SKaAnowKsrm1UXK5okD4oML5r15SlHiV
        D0jMZJ6zTGYSSPdXZkqLBJi9hw==
X-Google-Smtp-Source: AA0mqf4h6G/PTAeQFiW5ZlfDJ8DIM/Eqep75hP7lJmpHXeFc8ORiMP49ipOMR+ht6BQHBWycaH5qhQ==
X-Received: by 2002:a05:600c:538b:b0:3b4:7e87:895f with SMTP id hg11-20020a05600c538b00b003b47e87895fmr19332071wmb.30.1669192107146;
        Wed, 23 Nov 2022 00:28:27 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-55-94.cust.vodafonedsl.it. [188.217.55.94])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b003b50428cf66sm1448192wmq.33.2022.11.23.00.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:28:26 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:28:24 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: imx: remove code for non-existing config
 IMX_GPT_ICAP
Message-ID: <20221123082824.GD39395@tom-ThinkPad-T14s-Gen-2i>
References: <20221123075216.28193-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123075216.28193-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Wed, Nov 23, 2022 at 08:52:16AM +0100, Lukas Bulwahn wrote:
> There never was a config IMX_GPT_ICAP in the repository. So remove the code
> conditional on this config and simplify the callers that just called empty
> functions.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20221122132330.30408-1-lukas.bulwahn@gmail.com/
> 
> v1 -> v2:
>   - addressed Tommaso's feedback: remove braces for single statement blocks
> 
>  drivers/staging/media/imx/imx-media-fim.c | 57 +----------------------
>  1 file changed, 1 insertion(+), 56 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> index 3a9182933508..fb6590dcfc36 100644
> --- a/drivers/staging/media/imx/imx-media-fim.c
> +++ b/drivers/staging/media/imx/imx-media-fim.c
> @@ -187,54 +187,6 @@ static void frame_interval_monitor(struct imx_media_fim *fim,
>  		send_fim_event(fim, error_avg);
>  }
>  
> -#ifdef CONFIG_IMX_GPT_ICAP
> -/*
> - * Input Capture method of measuring frame intervals. Not subject
> - * to interrupt latency.
> - */
> -static void fim_input_capture_handler(int channel, void *dev_id,
> -				      ktime_t timestamp)
> -{
> -	struct imx_media_fim *fim = dev_id;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fim->lock, flags);
> -
> -	frame_interval_monitor(fim, timestamp);
> -
> -	if (!completion_done(&fim->icap_first_event))
> -		complete(&fim->icap_first_event);
> -
> -	spin_unlock_irqrestore(&fim->lock, flags);
> -}
> -
> -static int fim_request_input_capture(struct imx_media_fim *fim)
> -{
> -	init_completion(&fim->icap_first_event);
> -
> -	return mxc_request_input_capture(fim->icap_channel,
> -					 fim_input_capture_handler,
> -					 fim->icap_flags, fim);
> -}
> -
> -static void fim_free_input_capture(struct imx_media_fim *fim)
> -{
> -	mxc_free_input_capture(fim->icap_channel, fim);
> -}
> -
> -#else /* CONFIG_IMX_GPT_ICAP */
> -
> -static int fim_request_input_capture(struct imx_media_fim *fim)
> -{
> -	return 0;
> -}
> -
> -static void fim_free_input_capture(struct imx_media_fim *fim)
> -{
> -}
> -
> -#endif /* CONFIG_IMX_GPT_ICAP */
> -
>  /*
>   * In case we are monitoring the first frame interval after streamon
>   * (when fim->num_skip = 0), we need a valid fim->last_ts before we
> @@ -434,15 +386,8 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
>  		update_fim_nominal(fim, fi);
>  		spin_unlock_irqrestore(&fim->lock, flags);
>  
> -		if (icap_enabled(fim)) {
> -			ret = fim_request_input_capture(fim);
> -			if (ret)
> -				goto out;
> -			fim_acquire_first_ts(fim);
> -		}
> -	} else {
>  		if (icap_enabled(fim))
> -			fim_free_input_capture(fim);
> +			fim_acquire_first_ts(fim);
>  	}
>  
>  	fim->stream_on = on;
> -- 
> 2.17.1
> 

Looks good to me.
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Thanks & Regards,
Tommaso


-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
