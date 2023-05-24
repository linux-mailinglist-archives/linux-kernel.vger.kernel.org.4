Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8470F33D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjEXJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjEXJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:41:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0910E7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:41:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso5930335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684921270; x=1687513270;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ErW9NMbDGzoThqImOmG7s5Odyeq8qYdmpGC8NT19/Nc=;
        b=BvSdEkZbEnXTT5vZ0s6A1P1tS7/qH7oyJMcXvPqKZ9irOLjxlmYfDhQRy1eoJkGARz
         UQnQ4BguPBoZq1Sncy4iYpvkFgBbj6I1ua7nZtx7vy2z0wgw0BqoX3vl7TLA5OO2mrww
         8SqKzm1X9WwkUMBsrSBYibY40EosHmeMPvpt/U9+icQJ35fEzLd2quZXCIlhIAO9wE80
         DIaoVZbdEZ7iygxj9cP64jIqsB9++EUsmrHmKNYrdvryFNqWV5afDxfQD1TaqrAprD4H
         4F+QSs26rX/NCiJMPsAWXHQnmROCHlfyoz5/bfMrrPJZPRqyFoWpynVrXS7hwg0baIHk
         YUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921270; x=1687513270;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErW9NMbDGzoThqImOmG7s5Odyeq8qYdmpGC8NT19/Nc=;
        b=XNiYGxZjRwYvqBZg8xfqGGocNiNKOGqhpjg3FajMpyNZc8VhTFwBqbxLpgxv0ScnU2
         E8PbKQKSs5TAr7gYNQ4JeVVi04wNcT2bPzxQgj8mCg7H8NQxXT44kY+u2raEGI7AzAxW
         YHDm70gN1OM6gVTFkYP7Q0IfOxZ2jVqaRmnadFhWGV2ENCha4oQdhn77ynQzXeHfDZGN
         ksaVHApl/EMpUOZmQHiKt0x4VA0WF/51GrH3LZP2X6P3bXSMX9HN0T5uMdIEc+ktVQxJ
         nvc1vvT+srgI73Lo6CFt6aF6ypbThw6pfUA6uvkApfNsM+/H0UnWzL3X467YAJjADp7R
         h+PA==
X-Gm-Message-State: AC+VfDzr5pWtHp+69PR0MRR1aa6ZNefesHLvM0Mpqhxt38uCXTPrjGbc
        E6w/zxvOJ6sNYtQzO/E+7VCuxQ==
X-Google-Smtp-Source: ACHHUZ4zPGK/aZ1Oc+Mc3MMO4uiV5TDtl3sq+rjmAn1IepzoMa90hFCmvMsOlVzVuHZcZOzpqjUFZg==
X-Received: by 2002:a05:600c:28b:b0:3f6:69f:75cd with SMTP id 11-20020a05600c028b00b003f6069f75cdmr6081323wmk.0.1684921269955;
        Wed, 24 May 2023 02:41:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:39c7:394c:5a3:4047? ([2a01:e0a:982:cbb0:39c7:394c:5a3:4047])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b003f4f1b884cdsm1654296wmg.36.2023.05.24.02.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:41:09 -0700 (PDT)
Message-ID: <d618bf50-816a-336d-6617-a0299cb59d61@linaro.org>
Date:   Wed, 24 May 2023 11:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: samsung-s6d7aa0: use pointer for drm_mode
 in panel desc struct
To:     Artur Weber <aweber.kernel@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     thierry.reding@gmail.com, Nikita Travkin <nikita@trvn.ru>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci . org bot" <bot@kernelci.org>
References: <20230524084324.11840-1-aweber.kernel@gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230524084324.11840-1-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 10:43, Artur Weber wrote:
> Fixes compilation issues with older GCC versions and Clang after
> changes introduced in commit 6810bb390282 ("drm/panel: Add Samsung
> S6D7AA0 panel controller driver"). Tested with GCC 13.1.1, GCC 6.4.0
> and Clang 16.0.3.
> 
> Fixes the following errors with Clang:
> 
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: error: initializer element is not a compile-time constant
>            .drm_mode = s6d7aa0_lsl080al02_mode,
>                        ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: error: initializer element is not a compile-time constant
>            .drm_mode = s6d7aa0_lsl080al03_mode,
>                        ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: error: initializer element is not a compile-time constant
>            .drm_mode = s6d7aa0_ltl101at01_mode,
>                        ^~~~~~~~~~~~~~~~~~~~~~~
>    3 errors generated.
> 
> Fixes the following errors with GCC:
> 
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: error: initializer element is not constant
>      .drm_mode = s6d7aa0_lsl080al02_mode,
>                  ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: note: (near initialization for 's6d7aa0_lsl080al02_desc.drm_mode')
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: error: initializer element is not constant
>      .drm_mode = s6d7aa0_lsl080al03_mode,
>                  ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: note: (near initialization for 's6d7aa0_lsl080al03_desc.drm_mode')
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: error: initializer element is not constant
>      .drm_mode = s6d7aa0_ltl101at01_mode,
>                  ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: note: (near initialization for 's6d7aa0_ltl101at01_desc.drm_mode')
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/20230523180212.GA1401867@dev-arch.thelio-3990X
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Link: https://lore.kernel.org/llvm/646c6def.a70a0220.58c1a.903d@mx.google.com
> Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> v2: expanded commit message
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index f532aa018428..102e1fc7ee38 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -37,7 +37,7 @@ struct s6d7aa0_panel_desc {
>   	unsigned int panel_type;
>   	int (*init_func)(struct s6d7aa0 *ctx);
>   	int (*off_func)(struct s6d7aa0 *ctx);
> -	const struct drm_display_mode drm_mode;
> +	const struct drm_display_mode *drm_mode;
>   	unsigned long mode_flags;
>   	u32 bus_flags;
>   	bool has_backlight;
> @@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
>   	.panel_type = S6D7AA0_PANEL_LSL080AL02,
>   	.init_func = s6d7aa0_lsl080al02_init,
>   	.off_func = s6d7aa0_lsl080al02_off,
> -	.drm_mode = s6d7aa0_lsl080al02_mode,
> +	.drm_mode = &s6d7aa0_lsl080al02_mode,
>   	.mode_flags = MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_NO_HFP,
>   	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
>   
> @@ -412,7 +412,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al03_desc = {
>   	.panel_type = S6D7AA0_PANEL_LSL080AL03,
>   	.init_func = s6d7aa0_lsl080al03_init,
>   	.off_func = s6d7aa0_lsl080al03_off,
> -	.drm_mode = s6d7aa0_lsl080al03_mode,
> +	.drm_mode = &s6d7aa0_lsl080al03_mode,
>   	.mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET,
>   	.bus_flags = 0,
>   
> @@ -440,7 +440,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_ltl101at01_desc = {
>   	.panel_type = S6D7AA0_PANEL_LTL101AT01,
>   	.init_func = s6d7aa0_lsl080al03_init, /* Similar init to LSL080AL03 */
>   	.off_func = s6d7aa0_lsl080al03_off,
> -	.drm_mode = s6d7aa0_ltl101at01_mode,
> +	.drm_mode = &s6d7aa0_ltl101at01_mode,
>   	.mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET,
>   	.bus_flags = 0,
>   
> @@ -458,7 +458,7 @@ static int s6d7aa0_get_modes(struct drm_panel *panel,
>   	if (!ctx)
>   		return -EINVAL;
>   
> -	mode = drm_mode_duplicate(connector->dev, &ctx->desc->drm_mode);
> +	mode = drm_mode_duplicate(connector->dev, ctx->desc->drm_mode);
>   	if (!mode)
>   		return -ENOMEM;
>   
> 
> base-commit: 37cee4876a45a5c3da79a83d34ed4f3c68548aef

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
