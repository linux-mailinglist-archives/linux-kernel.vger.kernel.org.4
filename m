Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0E671968
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjARKnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjARKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:41:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2C3C9253
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:45:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so24082045wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bxTEriY1MvSGeJlo84GqMLFfzsCCLCqbUF/mz0HRuGk=;
        b=U0+jiQ8YZms1L9R000j+kcQGuYANmrpPeAz3lPkkDReAp1VJSpkw9WHC28jnRnKNfb
         8VkT9GftcWVhL/zjhpnm+mD/UMtaS+xOCNfriKRE4u2V4zNDUBAUab618FlYViuDlbeM
         ddzPzmSXN4M/5kwRERUEiPeTIGRdllkk6IObfw7vyzdg+Ejx6+NakqWwI+/MsFOrkSuk
         DedVYbdWBbwdtZfWG5bqzN2BBG58HtK4tFdTUqbSUzwG4BgtNwlSdtWzlrkbb/ii1JoS
         KIDt5bA2Jd7Jx5YfTTSzBOfqOgYmikhTJNxgAdP2u7/3H/K9XvlCoovACTY3Vl5Z+Ur2
         TUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxTEriY1MvSGeJlo84GqMLFfzsCCLCqbUF/mz0HRuGk=;
        b=ZKq+Jou2pF3ufHu9lJujq2wD2IT88byAXUNGTjo32xuygYelgDuGWFgGwL2WSioq+c
         iHBIEUqv+SP9Mt6EONtb1kdKMrzEAI48hjGAyj/xglXZq+xI+YNOzPlMFblffkMtnGzs
         hx4GSmEBXm6SVz4xV4JQdfFY4VNpiDo4iOBU5X8eZiYWVb2bLH5cYwpWKRFh0f/aJbkj
         S+sGjSEIwNW95rqbmt3tF2UAWREUAAgKKfPnyJWDwd04vIQO0PvSWQwUjWPNmLtGYbAt
         dWmo58H6l5MjVoTW7k63LD++zWX9dN0+MajcKaPU62c9eWdLwx6s0X7xcET/FW3Lkn6s
         TMTA==
X-Gm-Message-State: AFqh2kq4b+lihGueoQ0AjLMIWSfQSw0BjnV583n6+ikBOp9yvdLsIBar
        oPlrYU3w0WvQrrVI5uW9BW92Lw==
X-Google-Smtp-Source: AMrXdXvPz5Z0HWf4/hGC7pwgdDdiwlsH0fE3k2waPcVeYNniv7Eo/9HnxV3PHkpgZZY+1Ca0flYlNQ==
X-Received: by 2002:a5d:4446:0:b0:2ba:c946:868b with SMTP id x6-20020a5d4446000000b002bac946868bmr5416810wrr.23.1674035133127;
        Wed, 18 Jan 2023 01:45:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe38a000000b002bc7fcf08ddsm23460721wrm.103.2023.01.18.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 01:45:32 -0800 (PST)
Message-ID: <47b70ca1-2601-0e71-80bd-6d3f3f845601@linaro.org>
Date:   Wed, 18 Jan 2023 10:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH v3 3/3] drm/panel: vtdr6130: Use 16-bit brightness
 function
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>
References: <20230116224909.23884-1-mailingradian@gmail.com>
 <20230116224909.23884-4-mailingradian@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230116224909.23884-4-mailingradian@gmail.com>
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

On 16/01/2023 23:49, Richard Acayan wrote:
> This panel communicates brightness in big endian. This is not a quirk of
> the panels themselves, but rather, a part of the MIPI standard. Use the
> new mipi_dsi_dcs_set_display_brightness_large() function that properly
> handles 16-bit brightness instead of bypassing the brightness functions
> entirely.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> index f9a6abc1e121..1092075b31a5 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -243,12 +243,9 @@ static int visionox_vtdr6130_bl_update_status(struct backlight_device *bl)
>   {
>   	struct mipi_dsi_device *dsi = bl_get_data(bl);
>   	u16 brightness = backlight_get_brightness(bl);
> -	/* Panel needs big-endian order of brightness value */
> -	u8 payload[2] = { brightness >> 8, brightness & 0xff };
>   	int ret;
>   
> -	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
> -				 payload, sizeof(payload));
> +	mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>   	if (ret < 0)
>   		return ret;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-MTP

Thanks !
