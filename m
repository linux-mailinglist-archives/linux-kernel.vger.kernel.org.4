Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0E70B84A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjEVJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjEVJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:02:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD410C3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:01:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3667674f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684746088; x=1687338088;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oh7mdsuOL7H7gOrXFRel5Jq/6EKWLVhMC8a5/8h8WZo=;
        b=HLp85cy8rppc/poFiFPivVgWVSJETEatbW3RUzyalnjapNdcR1TZLQWG6nmqWras1a
         WziaQA/t0fQEQzUeZANlXUzGtKHqJQv54xHTcD5Lj1FirkzjbhMD7zQl9G5zzNmXEyaJ
         QAi4egNtZw6NbhUXLFR7hHFpYhC4DyMnEH0ZEPKJJ/9djnyrHb+h/KOxz4Us9GgjzOxe
         C6TF5ouSZDy/0hBfkZrjfhVz0xmBRAwDyabdprfcnw34gdxSIt5db0ChSW/hJlS0g6Qh
         AjZhqPWWRYVL0mcvTvtizvwbVvJ7n02sGWu6TJxHtPfBzqMIJCoYb9izmSPIMFyO3dQX
         liCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684746088; x=1687338088;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh7mdsuOL7H7gOrXFRel5Jq/6EKWLVhMC8a5/8h8WZo=;
        b=LiT8cVGPnEOnDRCRxM4cyckKuJ3bI2bO8Dw8gui9O8FdeYqKFhU6waXe+0keAaKqDN
         pRwScdchY0kLeA3L804txK+4SGMeo6DTTgeWrv0ZeQyxr1m1bU7TcWmSd3eRXgbbDboI
         MyzQdTiKSko/808SFJT6LHc/p6X7TJvwzAhbBE1IKhM2FI2Rou2f+nzx2SxHzEZQPPSl
         alThl0L05b1bRTUe96dGxYUpE0pFcq/8L7cfZobn0HzWWXZV7bOFbiyp2AXWFC53cwdV
         gsbEuccuDWE3UDV4GyvxbbBXbOqQ8N1vzgG5U2RdCEDe5IgPoRJqRVufuoBwP8hop/yt
         SE0Q==
X-Gm-Message-State: AC+VfDwSElVH0O9UGO/ePI/uNUnPzhNUdvaXLw6vsfqzsusWZI3/hUq7
        ouKabhFx7yf4BiwAEh2bme4heg==
X-Google-Smtp-Source: ACHHUZ4tSDVVpYCjEIBTjilRMO6W9tA8i/VqvF0ipfGxgq2yBbZSmlHIEMyxKj2YJMU2g29qmHcmPQ==
X-Received: by 2002:adf:fc43:0:b0:307:839a:335e with SMTP id e3-20020adffc43000000b00307839a335emr6254283wrs.44.1684746088328;
        Mon, 22 May 2023 02:01:28 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id i10-20020adfe48a000000b002fed865c55esm6993892wrm.56.2023.05.22.02.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 02:01:27 -0700 (PDT)
Message-ID: <7c1a7897-48ee-f991-314e-3a88c51bbcc9@linaro.org>
Date:   Mon, 22 May 2023 11:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 01/10] drm/panel: Clean up SOFEF00 config dependencies
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-1-541c341d6bee@somainline.org>
Organization: Linaro Developer Services
In-Reply-To: <20230521-drm-panels-sony-v1-1-541c341d6bee@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2023 23:23, Marijn Suijten wrote:
> As per the config name this Display IC features a DSI command-mode
> interface (or the command to switch to video mode is not
> known/documented) and does not use any of the video-mode helper
> utilities, hence should not select VIDEOMODE_HELPERS.  In addition it
> uses devm_gpiod_get() and related functions from GPIOLIB.
> 
> Fixes: 5933baa36e26 ("drm/panel/samsung-sofef00: Add panel for OnePlus 6/T devices")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/panel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 2b9d6db7860ba..67ef898d133f2 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -608,10 +608,10 @@ config DRM_PANEL_SAMSUNG_S6E8AA0
>   
>   config DRM_PANEL_SAMSUNG_SOFEF00
>   	tristate "Samsung sofef00/s6e3fc2x01 OnePlus 6/6T DSI cmd mode panels"
> +	depends on GPIOLIB
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> -	select VIDEOMODE_HELPERS
>   	help
>   	  Say Y or M here if you want to enable support for the Samsung AMOLED
>   	  command mode panels found in the OnePlus 6/6T smartphones.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
