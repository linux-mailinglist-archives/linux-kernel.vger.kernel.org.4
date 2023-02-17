Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B369A8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBQKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBQKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:20:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93760A57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:20:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id z1-20020a1c4c01000000b003e206711347so520720wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WBDuZ1YsthJFSmgGckbyCZ1GxJY3h4+AR0nDnSv5p9E=;
        b=WuRKgVx/abcZcK0HucJ8OjzXyIpHTyHaEz58egQAstY1ADJVR1JsTDjiROMTeDn2Uq
         UFIxDNUqOqEYb/Yh98Skh8i1EqZD8J5voak28hEzBJTErFxFz5IgwFpGgX2F5MQNSjFe
         FH6yX2PU0TFCrYpUIpN+7qXCdgFPKkYVbeywTF4aZPBS6awLEgJj+eyHNp3kT3oQgWDx
         e/+OLuHHd/o/NEBP3PkabCf0j0O2twILyrxffS5tRO4ngZqMN24Bm/svmGh5Wt7JBRj2
         v0YU+wG5jBK66ZAAGj9BYlTjvdWp5WTmq6SMTfeUTvkr0DYn+iacsV0QtDe6Zj8pkhjP
         8hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBDuZ1YsthJFSmgGckbyCZ1GxJY3h4+AR0nDnSv5p9E=;
        b=t4dobjmkLmrzq2+aNvtNLlwW9sAUByP+WSdfNKnW5yPQbmDiUJl+CNQq0AXhfXDMjZ
         Ro+v6Auf4SZPGulJG3G10Ems6e+E7JxsEk9TnD98LV4wgXR0wjT0CP84A8B+TwWYjE2m
         KaY6JnV2gv28WEwmka5UwueQ57U58DdcCT+eYAPMgYm/p7j87Hyde/Jd+TY5FcSpUaxD
         QWR6uCli6NUqkTffT7fNQPjcOpRpUvHpMh50uBjuXJETOt1WO0HrIdAe95fHY/+80pLo
         q+Ots60R54BVXs3yQLKSt58UqKE8Jwme9CR258pgUdRDmbQmJDjApUYidNtoWy9MVoxB
         voWQ==
X-Gm-Message-State: AO0yUKV8xanbUgavP3IZXNObE5P/Y4cIEqEHsgdET6G4kTc/UPA6yCbS
        Npa/VoLly/Y/3ggb2S5UIwFtBg==
X-Google-Smtp-Source: AK7set/NxxmCSIJR7gO1gNoNDErjpfId+Gjra9KrBytdDA56fqSSwlfB1IfuBIhwiAKMe6dJjTWjZA==
X-Received: by 2002:a05:600c:4d06:b0:3dc:1ad6:55fd with SMTP id u6-20020a05600c4d0600b003dc1ad655fdmr893227wmp.32.1676629214411;
        Fri, 17 Feb 2023 02:20:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f65e:92aa:85d5:15c5? ([2a01:e0a:982:cbb0:f65e:92aa:85d5:15c5])
        by smtp.gmail.com with ESMTPSA id v5-20020adff685000000b002c559def236sm3028656wrp.57.2023.02.17.02.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 02:20:13 -0800 (PST)
Message-ID: <86b55b41-3faf-dbb8-a072-9a905d111eaa@linaro.org>
Date:   Fri, 17 Feb 2023 11:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/meson/meson_venc: Relax the supported mode checks
Content-Language: en-US
To:     Carlo Caione <ccaione@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@lessconfused.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230210-relax_dmt_limits-v2-1-318913f08121@baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <20230210-relax_dmt_limits-v2-1-318913f08121@baylibre.com>
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

On 13/02/2023 10:32, Carlo Caione wrote:
> Relax a bit the supported modes list by including also 480x1920 and
> 400x1280. This was actually tested on real hardware and it works
> correctly.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
> In particular relax the resolution checks to allow more resolutions like
> 480x1920 and 400x1280.
> ---
> Changes in v2:
> - Lower the hdisplay limit to support 400x1280 as well.
> - Link to v1: https://lore.kernel.org/r/20230210-relax_dmt_limits-v1-0-a1474624d530@baylibre.com
> ---
>   drivers/gpu/drm/meson/meson_venc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 3c55ed003359..fcd532db19c1 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -866,10 +866,10 @@ meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode)
>   			    DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC))
>   		return MODE_BAD;
>   
> -	if (mode->hdisplay < 640 || mode->hdisplay > 1920)
> +	if (mode->hdisplay < 400 || mode->hdisplay > 1920)
>   		return MODE_BAD_HVALUE;
>   
> -	if (mode->vdisplay < 480 || mode->vdisplay > 1200)
> +	if (mode->vdisplay < 480 || mode->vdisplay > 1920)
>   		return MODE_BAD_VVALUE;
>   
>   	return MODE_OK;
> 
> ---
> base-commit: 38c1e0c65865426676123cc9a127526fa02bcac6
> change-id: 20230210-relax_dmt_limits-355e2a1c7ccf
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
