Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAC607857
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJUNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiJUNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:24:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49463ECE3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:24:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so4759437wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihwjot/dYV8gpdncYn3dxDmC63eFQdqeYLHCPOfEipg=;
        b=tm6RE9W9SJfdGyaDYoyiP6dvRI1bG01hT9T7vOUAR/6SCfAUIf/dniBAdoXacXYEO0
         11+qXcvgk+8fXBxhGzAIz/Ztv2drf1js03K1OQyqi0cDxE29rgQEia7t8Rc9/dMnIkH+
         8dizoYr25a77m9AqcCAkUJM+8SvOqmnt5hb9tWxS5GykyBx0Wy5M4fu2Zlmflyalycbi
         RQ38cnfSgbNZn3Dmm2/VG0QUC21UpuoU5n0bu1e8yq16VxFFMN5QWyB3P2v8UIxbtGqw
         svOBAC0rS06KAPBfApjJnSJZNnfnQVLOAFtN99nJSvIXm+nRUvSpdragj8RRAdPyocil
         c65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ihwjot/dYV8gpdncYn3dxDmC63eFQdqeYLHCPOfEipg=;
        b=2ugbXHQNuhpMP+S+6kml26IuuS6ptO1xlvRKrHREiOhbqThLdIUUiyxGTYT0ic9QmW
         LEj/ROA9MwETM6G1mqoIORxyoslhPFEKvSIk83h97Ng9oQSQSZvXefVFX+aFL9K1x4zU
         KjqI04v1IEVHVzq50KtBesUxaxbbGb3SCdXx/Lj3kSPGCkFNsBievrb701/MAcUUYAvB
         wHpKPCSiXZp5gssX5iQqwOSZ80arM5/oQa51vfkxT1tVERSWOKzx42cD46NaxBZq6Fl2
         BgD3wf3b9+EoA7Nf0U2ZQxRr91+JukBEnBzFoHwqdJW4ozwQRqTd5IAM8GtgaMeEVNcR
         Y/OA==
X-Gm-Message-State: ACrzQf3ZOWQP1EDpql9maOC/SLKM6A+ey4ut4+je6ubW0IKL7lP2eVPV
        lThBnKcXNbx9wjfX1G2m0wv6Qg==
X-Google-Smtp-Source: AMsMyM5LAMpg+wQ8yeHpWlL27GjaAM7iPFACl30NQbSdsxzQ4u5vm8tvdXI3CordRzKGlvVAJRB2Bg==
X-Received: by 2002:adf:e189:0:b0:22e:cbf4:1148 with SMTP id az9-20020adfe189000000b0022ecbf41148mr12173858wrb.47.1666358688360;
        Fri, 21 Oct 2022 06:24:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8104:adb4:5d77:2050? ([2a01:e0a:982:cbb0:8104:adb4:5d77:2050])
        by smtp.gmail.com with ESMTPSA id z23-20020a1cf417000000b003c6b874a0dfsm3132370wma.14.2022.10.21.06.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:24:48 -0700 (PDT)
Message-ID: <21631637-6313-550e-dfd1-94b0c318a9ec@linaro.org>
Date:   Fri, 21 Oct 2022 15:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/4] gpu: drm: meson: Use devm_regulator_*get_enable*()
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
References: <cover.1666357434.git.mazziesaccount@gmail.com>
 <c14058c4b7018556a78455ffef484a7ebe4d8ea2.1666357434.git.mazziesaccount@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <c14058c4b7018556a78455ffef484a7ebe4d8ea2.1666357434.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 15:18, Matti Vaittinen wrote:
> Simplify using the devm_regulator_get_enable_optional(). Also drop the
> seemingly unused struct member 'hdmi_supply'.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> v3 => v4:
> - split meson part to own patch
> 
> RFCv1 => v2:
> - Change also sii902x to use devm_regulator_bulk_get_enable()
> 
> Please note - this is only compile-tested due to the lack of HW. Careful
> review and testing is _highly_ appreciated.
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

