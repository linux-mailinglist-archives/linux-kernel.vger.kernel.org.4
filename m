Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206E71FD6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjFBJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjFBJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:16:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B69D194
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:16:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f623adec61so18796035e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697379; x=1688289379;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XCSBt06ODCOO6aeVJ2PlXGU7kys31a0U2ya2eb1ukWw=;
        b=Z+ctFkEefF0e4doqq0Ug4bfRYfV4IApiuCj62wHwH5KpnMjImkCKEMD6dqT7PNRqck
         1KxgSYzQW+icJWnxf2IK5Zp6wkBYQ4bRr7wuvKK94lbSyRpz8wwAkskcQMj24qiM1v0M
         GAluuGomAl2RCXaT9ZNXSrDGVZapBa7+Jq9d18QJrscreKDrwX3flFnK43x57UYOsIv7
         zbcespmhVHncyojB36fAyNh5rqJJzl51FFFHTVKe35+DnbdMKCKo7o58rfG7d9pVH8OQ
         EDdUTisqSCde7B8cMJMJtg/sm2DSAVQCSVe5ZJZSZNK6PQkM3H4WEQBgjLvVos0fww56
         a6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697379; x=1688289379;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCSBt06ODCOO6aeVJ2PlXGU7kys31a0U2ya2eb1ukWw=;
        b=SMpoEdJZRZYsRCKhRFfUCvN4EohOnpQt+avSOarEuwEIdTGlvC6VbzOgD7Kgi5EwAP
         AWARRk7VbVbvpRlPlOoot4OHW6KXTlnaLvmtmc19ULx3sv6DtK6+JqCNEzBJxwIFqwsB
         472zY9z9OVNf6NEBVVNWiY1JqnqL2r1A/YLZc05B/I4atoFWWQKgtMFE1B2WvxEERPf7
         lwaTYXc4wtTPjYvDR/SoqMxvUqBx8J2vqiiwYh2fzYJ7Ej3ss+gz1NumteqQRBeITEzP
         u1Zv0ZTxHxtMBzHG70vqGtgk/B8jOHEZAFlAM6gYVlXe+6CcR5R0XYYu6IYdtSSXaI0z
         rDYQ==
X-Gm-Message-State: AC+VfDxHtDWeRoVYjS4rSOgbJZElHsazrsfegKQnMDMCCrJc3tX3Mc/W
        b9HIL3HkxU5oTh2tDzfPZ39lUw==
X-Google-Smtp-Source: ACHHUZ5kFDVkTijAYhopCOawiE08DDNzoy6papAmWv1662nnpG5t1S72iJGGObX98yTOLoivrgSqwg==
X-Received: by 2002:a05:600c:3798:b0:3f6:244:55df with SMTP id o24-20020a05600c379800b003f6024455dfmr1508463wmr.29.1685697378846;
        Fri, 02 Jun 2023 02:16:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cabd:b6f:39ae:51a2? ([2a01:e0a:982:cbb0:cabd:b6f:39ae:51a2])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003f60119ee08sm4895391wmc.43.2023.06.02.02.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:16:18 -0700 (PDT)
Message-ID: <1ed84d1f-d999-f0f2-bd84-d56f46efa384@linaro.org>
Date:   Fri, 2 Jun 2023 11:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH -next] drm/meson: Remove unneeded semicolon
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230602091416.107850-1-yang.lee@linux.alibaba.com>
Organization: Linaro Developer Services
In-Reply-To: <20230602091416.107850-1-yang.lee@linux.alibaba.com>
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

On 02/06/2023 11:14, Yang Li wrote:
> ./drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:117:2-3: Unneeded semicolon
> ./drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:231:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5392
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> index dd505ac37976..57447abf1a29 100644
> --- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> @@ -114,7 +114,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>   	case MIPI_DSI_FMT_RGB666_PACKED:
>   	case MIPI_DSI_FMT_RGB565:
>   		return -EINVAL;
> -	};
> +	}
>   
>   	/* Configure color format for DPI register */
>   	writel_relaxed(FIELD_PREP(MIPI_DSI_TOP_DPI_COLOR_MODE, dpi_data_format) |
> @@ -228,7 +228,7 @@ static int meson_dw_mipi_dsi_host_attach(void *priv_data,
>   	case MIPI_DSI_FMT_RGB565:
>   		dev_err(mipi_dsi->dev, "invalid pixel format %d\n", device->format);
>   		return -EINVAL;
> -	};
> +	}
>   
>   	ret = phy_init(mipi_dsi->phy);
>   	if (ret)

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
