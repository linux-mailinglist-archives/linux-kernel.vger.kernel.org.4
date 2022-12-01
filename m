Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73863EB42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLAIid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLAIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:38:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25485651
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:38:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso2787353wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KiIz3+tb5zv7p7JFple9ARBjQPwBUaGHUgkQfj8cO3Y=;
        b=G0uvG+UozMloOv4hJ2f4eRDg2VXq9xUMtPyoelMSC/3wCA1HAoHAMYHzLZZUfOYI0z
         7ms6BGLp5zKK7TW7Aklt14VVxMcsAWJvoS8UEZpfqX9TVNcQExVmUlqyFGQXoVP4b7cO
         ILsYLXREzwL3vYwHCNVjMOtsxMaAKXk4kMR23EJ8eYLzxxd75lrwmIyz9BSu4ETNvZTu
         NTEjl+hreNOUAu7aMvc1etdC6jmMKcUEezYelGnpD5dPE+AxwtVf5cEkHmHKd4XBHtzf
         qgJpHNSxrUsVwBOiWs2v5bUB8UPcFoKBKKEwSSgUC9hmWRVZj5PIriG2HHfFINs1zEp0
         /2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiIz3+tb5zv7p7JFple9ARBjQPwBUaGHUgkQfj8cO3Y=;
        b=tOOIRm/gB4qsI5IHTnvXHX0Qsz1V8Jv3fY6jL0GRzrhBiJ960b4059otGN/x12RA95
         +7jvLZVAtsA5w94eZ8PTpom78Cxv5YBKKun19s+SfohVm6ckJ1z17FECvkaerIp9pXiW
         pPia6ZInopz/Q+RuP+6uI6423JPEDtO0FIuScKN8hlmVvTx+qBzg1caTmvK+WVFQf4cG
         d0wcXencn7sUNeRvd4dqIkF66a45BkOGzTTZcxxBpoEiogLDAU6ITLS4jusg/y9xnTp4
         3EIQEchnA1RwO0orczBlsuttINqW4H+6z0RYpB1AXUyhhHGzEOofZdycCsW93F4cuVgf
         c24A==
X-Gm-Message-State: ANoB5plYmBiqxHNomU57D8+gqYakL8XN/KSi0BCc0fDfg4KOo2xz9wgW
        ls04D3G4QV8HY9s5R9tBsgNHcg==
X-Google-Smtp-Source: AA0mqf6vKwxrLoekKlS7jsHZjr1A/9hOVYcrZDL6KM2Yio2b2pW7B7Keg7XYP+2wYu9j+JJollwTBA==
X-Received: by 2002:a05:600c:548b:b0:3cf:b0e4:30d9 with SMTP id iv11-20020a05600c548b00b003cfb0e430d9mr40406640wmb.66.1669883907845;
        Thu, 01 Dec 2022 00:38:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bec0:73a:70e1:228f? ([2a01:e0a:982:cbb0:bec0:73a:70e1:228f])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b003c83465ccbfsm7551042wmm.35.2022.12.01.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 00:38:27 -0800 (PST)
Message-ID: <7b7a7e34-af6a-cb09-e094-e42e45f45b8b@linaro.org>
Date:   Thu, 1 Dec 2022 09:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND2 v4 2/2] drm/meson: dw-hdmi: Use
 devm_regulator_*get_enable*()
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1669799805.git.mazziesaccount@gmail.com>
 <df0096b5aea2a18d1540cde379c5abf589ccd7c4.1669799805.git.mazziesaccount@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <df0096b5aea2a18d1540cde379c5abf589ccd7c4.1669799805.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 10:23, Matti Vaittinen wrote:
> Simplify using the devm_regulator_get_enable_optional(). Also drop the
> now unused struct member 'hdmi_supply'.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Missing Acked-by, I'll add it while applying.

Neil

> 
> ---
> v4 resend 2:
> Respinning unchanged code with the commit title changed as wa suggested
> by Robert Foss and commit message changed as was suggested by Martin.
> 
> I am doing a clean-up for my local git and encountered this one.
> Respinning as it seems this one fell through the cracks.
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 5cd2b2ebbbd3..7642f740272b 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -140,7 +140,6 @@ struct meson_dw_hdmi {
>   	struct reset_control *hdmitx_apb;
>   	struct reset_control *hdmitx_ctrl;
>   	struct reset_control *hdmitx_phy;
> -	struct regulator *hdmi_supply;
>   	u32 irq_stat;
>   	struct dw_hdmi *hdmi;
>   	struct drm_bridge *bridge;
> @@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>   
>   }
>   
> -static void meson_disable_regulator(void *data)
> -{
> -	regulator_disable(data);
> -}
> -
>   static void meson_disable_clk(void *data)
>   {
>   	clk_disable_unprepare(data);
> @@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	meson_dw_hdmi->data = match;
>   	dw_plat_data = &meson_dw_hdmi->dw_plat_data;
>   
> -	meson_dw_hdmi->hdmi_supply = devm_regulator_get_optional(dev, "hdmi");
> -	if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
> -		if (PTR_ERR(meson_dw_hdmi->hdmi_supply) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -		meson_dw_hdmi->hdmi_supply = NULL;
> -	} else {
> -		ret = regulator_enable(meson_dw_hdmi->hdmi_supply);
> -		if (ret)
> -			return ret;
> -		ret = devm_add_action_or_reset(dev, meson_disable_regulator,
> -					       meson_dw_hdmi->hdmi_supply);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = devm_regulator_get_enable_optional(dev, "hdmi");
> +	if (ret != -ENODEV)
> +		return ret;
>   
>   	meson_dw_hdmi->hdmitx_apb = devm_reset_control_get_exclusive(dev,
>   						"hdmitx_apb");

