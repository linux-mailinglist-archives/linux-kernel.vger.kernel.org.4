Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D102B717B88
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjEaJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEaJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:15:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED2D9
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:15:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso57401835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685524531; x=1688116531;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhUEIe/6jVYKIhcwPw65eyzwSFNkodI6e5UfoL8epWs=;
        b=jhV57lScxsr9IeKjBixIWVvCjBf+0owXdN0K/fqaH0X1HEd4WO2RnICxwAEgxpVMwP
         uEieZr5gSeH18agiJ50So9Wjy5NJeUCLaQypfjjJMvgpaHAp4lOpIS5b5y7SmyMZfdac
         64IoQLDP4HS70afhLp+IZL//JXl0OZf/A8aJKRziw04AaY70HvVmyul267OrhHEE57Kj
         Gchi1UK4Q60CH6FgtMm1VGAqYhqojjTXyycbuDZv8TVaLAbl9xbcbPu2MqUSBBsERfTS
         WozLmmTyPrPWx0RPZcLGhIKGrhvqREP1EgCru2vSeOu8M5+VLV0yR5HBmYH7nW/r9EjB
         UqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524531; x=1688116531;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhUEIe/6jVYKIhcwPw65eyzwSFNkodI6e5UfoL8epWs=;
        b=l78phMiex6PGg2uTmmaOrjwDf8HZgPfOH+AeTHJDxDxN8sa6cb9c9I5gDKiZN/yJ6g
         wbOjmPyNATlOJaYwhZVI23HdhWeMnMFSnJZHOgt59Z+0c7h7Nx0ly/1FcWnvJYsJYvf8
         /oLPPlxg7Dg27P7LBKVGSQOLkXzBHMvGplfigr6ONtDsUQpQtcUc+nCHlTeK7f+KvGd6
         YaHiuUBFmKNg5+55PcKkM5kAOsNYye3hpxmvLhdOonsnC6QTQu6bPJo1c2Uzag4UDjtB
         2GBJSSSIXh5gak2AIQVB4eBfXcrocQGWbS8X7BJxhdIuBYfdFsbrv7U7qGUutxQXIv3X
         UMrQ==
X-Gm-Message-State: AC+VfDyhCDrXPCyMonbmtmb1y96R8tRA/TBcqPK8eDr0Ap/ndHRcRPaQ
        Sn1tXP5fy22bT8UK0P4xqA1ROg==
X-Google-Smtp-Source: ACHHUZ7+HdgzP4NlSBpNC603KAdhtElqbx4tgguvZ8r0eKVgpGDmzybK5nMtKWtN3fjuqJ8po2beIg==
X-Received: by 2002:a7b:cb91:0:b0:3f6:476:915 with SMTP id m17-20020a7bcb91000000b003f604760915mr3141483wmi.6.1685524530762;
        Wed, 31 May 2023 02:15:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5c28:3ad5:fcda:7779? ([2a01:e0a:982:cbb0:5c28:3ad5:fcda:7779])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f18b942338sm20163471wmc.3.2023.05.31.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:15:30 -0700 (PDT)
Message-ID: <2c6b5c55-92dc-4f7d-758b-5b4f69f28482@linaro.org>
Date:   Wed, 31 May 2023 11:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] gpu: drm/panel: Change the return value of s6d7aa0_lock
 to void
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Artur Weber <aweber.kernel@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230531073751.48451-1-luhongfei@vivo.com>
Organization: Linaro Developer Services
In-Reply-To: <20230531073751.48451-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 09:37, Lu Hongfei wrote:
> The return value of s6d7aa0_lock is meaningless,

It is not, mipi_dsi_dcs_write_seq() can return an error value:

https://github.com/torvalds/linux/blob/master/include/drm/drm_mipi_dsi.h#L320

Neil

> it is better to modify it to void.
> This patch fixes this issue and modifies the place
> where s6d7aa0_lock is called.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 29 ++++---------------
>   1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 102e1fc7ee38..c5924e7b9e36
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -63,10 +63,9 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>   	msleep(50);
>   }
>   
> -static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
> +static void s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi;
> -	int ret = 0;
>   
>   	if (lock) {
>   		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> @@ -79,8 +78,6 @@ static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>   		if (ctx->desc->use_passwd3)
>   			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
>   	}
> -
> -	return ret;
>   }
>   
>   static int s6d7aa0_on(struct s6d7aa0 *ctx)
> @@ -238,11 +235,7 @@ static int s6d7aa0_lsl080al02_init(struct s6d7aa0 *ctx)
>   
>   	usleep_range(20000, 25000);
>   
> -	ret = s6d7aa0_lock(ctx, false);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to unlock registers: %d\n", ret);
> -		return ret;
> -	}
> +	s6d7aa0_lock(ctx, false);
>   
>   	mipi_dsi_dcs_write_seq(dsi, MCS_OTP_RELOAD, 0x00, 0x10);
>   	usleep_range(1000, 1500);
> @@ -266,11 +259,7 @@ static int s6d7aa0_lsl080al02_init(struct s6d7aa0 *ctx)
>   	msleep(120);
>   	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
>   
> -	ret = s6d7aa0_lock(ctx, true);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to lock registers: %d\n", ret);
> -		return ret;
> -	}
> +	s6d7aa0_lock(ctx, true);
>   
>   	ret = mipi_dsi_dcs_set_display_on(dsi);
>   	if (ret < 0) {
> @@ -327,11 +316,7 @@ static int s6d7aa0_lsl080al03_init(struct s6d7aa0 *ctx)
>   
>   	usleep_range(20000, 25000);
>   
> -	ret = s6d7aa0_lock(ctx, false);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to unlock registers: %d\n", ret);
> -		return ret;
> -	}
> +	s6d7aa0_lock(ctx, false);
>   
>   	if (ctx->desc->panel_type == S6D7AA0_PANEL_LSL080AL03) {
>   		mipi_dsi_dcs_write_seq(dsi, MCS_BL_CTL, 0xc7, 0x00, 0x29);
> @@ -370,11 +355,7 @@ static int s6d7aa0_lsl080al03_init(struct s6d7aa0 *ctx)
>   		return ret;
>   	}
>   
> -	ret = s6d7aa0_lock(ctx, true);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to lock registers: %d\n", ret);
> -		return ret;
> -	}
> +	s6d7aa0_lock(ctx, true);
>   
>   	ret = mipi_dsi_dcs_set_display_on(dsi);
>   	if (ret < 0) {

