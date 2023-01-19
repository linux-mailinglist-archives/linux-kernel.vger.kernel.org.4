Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB5A6732E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjASHtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjASHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:48:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE46677A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:46:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so600293wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IKjU9sspsf28Hk2aKvoFXfSKYmIhjsIllQAH1SIEjsw=;
        b=qCbSaKk7rAY0sKG9D/SOamGLKKWKMPakUwco4tWRa62tDjZGLza4tMWGFMQ8lSVXnf
         bzcsYT7ZglZMCW9FfUUGW5WHo8yGMEINMIGgEzVZmSsrB1dm89We8DlHoATCfE+3dFAL
         5/rDHkto2NaE1Ib/EM20EaKbtO8kcaPkIOZStKI/V3dMb6uPaIEVH4iCDvaXdRrH9pPi
         ynPnap1wqWgzG9hEGWLNE+/hz0uLcwY5xQsA+W05Z3lXY4Qy44zHolsHXAXfXqxtbPZb
         pHvA2JQ5NYWGewMHyx9vKWZkcarVa2e8tbfr91l9ro9a7IJaXpOb/jzLDm3jSarOIe2m
         mQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKjU9sspsf28Hk2aKvoFXfSKYmIhjsIllQAH1SIEjsw=;
        b=6UK7T+xYZPrLZ0ij96Qs0PpXvndr0EnFPxeuJSbn26308IoWppJK4Yim22gNj1w34a
         fte2l+hzVnK7EVk8IvsfQzuzD1v5E9gALFPjF+qDmGEzmwN1KCZsweW7rY2DUGl+fy2y
         5qCgprEwcDnEqc0gUlSVneLlVR+JHJ4IqrJ4BAuVcDw7mrammb019WVS+aqfUmzDgk2M
         HSsFBW1p8euJ3b1Z/kW/Y7AoKehoRt51y7xGx1/XpkxR7URhW02XZSqMyFYd+kXzPHxn
         IxE9MLxwPU1D/1xQDIdSa26igup7w8n9OTSwOilg6k7DNaZGEKsL0wRk0/AuH38v8Mmm
         2vxA==
X-Gm-Message-State: AFqh2kos/PGKGYMOQmC1oyqnztYUKISEd3BegakDOvyJu1af3SzAWeJw
        4AVA6HceLpcwSApc7ZAdBux/tw==
X-Google-Smtp-Source: AMrXdXvc3NeEoiLd8D8KqsJcg9fSMBEl08AQvfegFco5mi9BdmEa1jbGUetwNcqdQ+fORVzz1unj4w==
X-Received: by 2002:a05:600c:1c83:b0:3da:fbd8:59a0 with SMTP id k3-20020a05600c1c8300b003dafbd859a0mr9312653wms.11.1674114399474;
        Wed, 18 Jan 2023 23:46:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3936:d49c:4a01:ee1e? ([2a01:e0a:982:cbb0:3936:d49c:4a01:ee1e])
        by smtp.gmail.com with ESMTPSA id i16-20020a1c5410000000b003db01178b62sm3926002wmb.40.2023.01.18.23.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:46:39 -0800 (PST)
Message-ID: <d259a28d-ba7e-9725-c0dd-86239fd2ed53@linaro.org>
Date:   Thu, 19 Jan 2023 08:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/bridge: tc358767: Use devm_clk_get_enabled()
 helper
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <208546ce4e01973da1eb9ad7bc0f9241f650b3af.1672415956.git.christophe.jaillet@wanadoo.fr>
Organization: Linaro Developer Services
In-Reply-To: <208546ce4e01973da1eb9ad7bc0f9241f650b3af.1672415956.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 30/12/2022 17:00, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
> Change in v2:
>    - Convert to dev_err_probe()    [Andrzej Hajda]
>    - Update the error message    [Andrzej Hajda]
>    - Add R-b tag    [Andrzej Hajda]

This doesn't apply on drm-misc-next, please re-spin.

Thanks.
Neil

> 
> v1:
> https://lore.kernel.org/all/4f855984ea895e1488169e77935fa6e044912ac2.1672414073.git.christophe.jaillet@wanadoo.fr/
> ---
>   drivers/gpu/drm/bridge/tc358767.c | 25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 2a58eb271f70..99f3d5ca7257 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2022,13 +2022,6 @@ static int tc_probe_bridge_endpoint(struct tc_data *tc)
>   	return -EINVAL;
>   }
>   
> -static void tc_clk_disable(void *data)
> -{
> -	struct clk *refclk = data;
> -
> -	clk_disable_unprepare(refclk);
> -}
> -
>   static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   {
>   	struct device *dev = &client->dev;
> @@ -2045,20 +2038,10 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   	if (ret)
>   		return ret;
>   
> -	tc->refclk = devm_clk_get(dev, "ref");
> -	if (IS_ERR(tc->refclk)) {
> -		ret = PTR_ERR(tc->refclk);
> -		dev_err(dev, "Failed to get refclk: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(tc->refclk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, tc_clk_disable, tc->refclk);
> -	if (ret)
> -		return ret;
> +	tc->refclk = devm_clk_get_enabled(dev, "ref");
> +	if (IS_ERR(tc->refclk))
> +		return dev_err_probe(dev, PTR_ERR(tc->refclk),
> +				     "Failed to get and enable the ref clk\n");
>   
>   	/* tRSTW = 100 cycles , at 13 MHz that is ~7.69 us */
>   	usleep_range(10, 15);

