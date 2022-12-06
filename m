Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07860644000
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiLFJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiLFJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:41:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DE1EADE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:41:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso13836557wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FxokdyaSTsdEUZeAO0dhrrdDTQh5fW0PAMkusaqbnNI=;
        b=hgKt/N5djRerT1RlOcMWnFpuJQ4bX2M6JA9wzFXO6HtaVliekexNJE17RJ88EUN4MZ
         UZg9sFwVIJoZfDmb70Y6nemKwx9p1fMrZV5ncdr3oqCWRxndOEuHEWbWgASwXIIVLK2t
         +SENYm0ShHRRBGfZ3bQ9AD38zn1H/nB4cWJJSRrlBDfKWLVMEmJ/3QOKGLf0+NnMB3UW
         uXr7RihODsoehrFECd7vfHFmevEritm/0bpC64hgwRM10Wn4C8Pd2Ab7WVvUdlwNQY0C
         YvNUV6RdF5gEXafU4GOCRKbDOr8V8g61KBmLFIP9u0yJxT/Bk7tMIdxidPvx66yYGFHX
         zQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxokdyaSTsdEUZeAO0dhrrdDTQh5fW0PAMkusaqbnNI=;
        b=NaqfkQ839imbkrtOMGyt2bmYU3TIGEf74lejA9xw9GNpqptXDBzgXLsGSWaIb0J+o+
         1spq590nHC1XA4NwQF1i9pp3lj+skd2FottN3mncFo4jwGl4h173ze1rxCOyQnXVt3QY
         zL55RanIqQnWnJa+f/EBySg29Yq77uSpHGK8x+dHx3QSwyV9M2xqa59U5s6V4bt0586v
         4LzdNiZaMN4cYl8vpPqImG+Jq4nlN0D1Kz3JfzWxnEjiTDbofZd8D4CHNe4XHUkUjN4p
         m6b6gbjDHWYFJa7cDGRloLri4ssLMSr1KZzQmVCu8SrLn8Arn9aXLIBZ4eu1iFG1QF22
         c+9w==
X-Gm-Message-State: ANoB5pl3jwuS/fT3MiwV7EWqEUaVwJJPk60H1EVwmAvfbd9+hbQ4QJ8s
        GEqLvDEI0EnHAB98+1+inwLkqA==
X-Google-Smtp-Source: AA0mqf4shAeXN1wG69orKehuFKdhFboW8rWmjTs2IHUubgXM5BC17QT0CVMzYAocd2isflrozlyBYA==
X-Received: by 2002:a7b:c00f:0:b0:3cf:7066:cf53 with SMTP id c15-20020a7bc00f000000b003cf7066cf53mr49237478wmb.135.1670319674510;
        Tue, 06 Dec 2022 01:41:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2d5b:61d6:a067:f8e9? ([2a01:e0a:982:cbb0:2d5b:61d6:a067:f8e9])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c1d0900b003cf878c4468sm27382120wms.5.2022.12.06.01.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:41:14 -0800 (PST)
Message-ID: <14e5c4e4-30dd-8efd-81e4-d680664ab04a@linaro.org>
Date:   Tue, 6 Dec 2022 10:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] drm/tiny: ili9486: remove conflicting framebuffers
Content-Language: en-US
To:     Carlo Caione <ccaione@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com>
 <20221116-s905x_spi_ili9486-v3-3-59c6b58cbfe3@baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <20221116-s905x_spi_ili9486-v3-3-59c6b58cbfe3@baylibre.com>
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

Hi Carlo,

On 06/12/2022 09:34, Carlo Caione wrote:
> For platforms using simplefb / efifb, call
> drm_aperture_remove_framebuffers() to remove the conflicting
> framebuffer.

Conflicting framebuffer on the SPI display ? How is that possible ?

The meson_drm should already do this, no ?

Neil

> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   drivers/gpu/drm/tiny/ili9486.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
> index 14a9e6ad2d15..6fd4d42437fd 100644
> --- a/drivers/gpu/drm/tiny/ili9486.c
> +++ b/drivers/gpu/drm/tiny/ili9486.c
> @@ -14,6 +14,7 @@
>   
>   #include <video/mipi_display.h>
>   
> +#include <drm/drm_aperture.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_fb_helper.h>
> @@ -238,6 +239,10 @@ static int ili9486_probe(struct spi_device *spi)
>   	if (ret)
>   		return ret;
>   
> +	ret = drm_aperture_remove_framebuffers(false, &ili9486_driver);
> +	if (ret)
> +		return ret;
> +
>   	drm_mode_config_reset(drm);
>   
>   	ret = drm_dev_register(drm, 0);
> 

