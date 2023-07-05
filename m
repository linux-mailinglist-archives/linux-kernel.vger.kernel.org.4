Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8574858C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGENzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjGENza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:55:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE5319AC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:55:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31438512cafso3389872f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688565325; x=1691157325;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QDtJCKqfKjcaKFw75l+br9FSk3/UDaoY4ROK4bND+g4=;
        b=bMY4zcmVkRkJZuGTA/33qY4pDQWVLuUTDNqW/Ux6jP9erW+UhwIf8QtmjuEgBm2vsv
         ghUmFqo7e48R9GIW9Tv1zVyXNUmvK/H7vYx8tZ73fxSftzxvB0D/fENKY5xY+uUVP2gK
         oxS8XvPWaS326vR+V8PJvOIhZr59gE5i7ZPhyRlgpf6FGMihAysHqNhkw2MzhxKQRYQ+
         ynmXBDhPXypo8gW7b0viowmjJanw3tmV74qmbkMLTP2pFGg3Q3llS3m75Qat1+yR6y34
         8WiXgiGWQpcBc+BprKeMv3lLlUkl4A8DdI/0xx2+VNWrtvOTpHozakUvW7U7TI+dG7Y4
         NncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688565325; x=1691157325;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDtJCKqfKjcaKFw75l+br9FSk3/UDaoY4ROK4bND+g4=;
        b=WfzI3uDgjKc86QTPJic6kh47ScGlvYoBkDzcyUUtdYzkYlLHbf6kzWvtbzKjlr5z3q
         6oZvm6Rf0UYX3jiIB9qDOKRAdfnhbY/8+T/f46jDJkH2zf/xGeYPqwYErczZdicXIbQL
         4GTMKTHUBtU65l4wj895thC4ep1W0K2bwjzEEXAutCddmu2a4BpxJtn3mNe9HAU9dUED
         j1NOoEtS4W5P5IrqeW8qsO3PbGF/29gojs3wLz74D+MXPSotr7nFRnDvtNrlGqjfA0aO
         WoXRiVjSli57JScOSxrMW3m2fJxJeAIVQuj+3aEGQJ6DiB8U1lzTFzrbqpAqXwdiIysJ
         RlUw==
X-Gm-Message-State: ABy/qLbTFQuvrDiBnX65MXfs7LY3Pt8OjmXyHZ6vgdPkMfrJk1jBrG4g
        QWYzp0u7378lqELY7Oo4keBqhT8JZ6qupi5N+qVBvuaK
X-Google-Smtp-Source: APBJJlEDj7353XXfmQuL/K85xJsW2fbnWCsuq5RfNgpui++UqX0DPWU+I7uxm15VgnfHX9RGnjKMLg==
X-Received: by 2002:adf:e747:0:b0:314:2f5b:2ce with SMTP id c7-20020adfe747000000b003142f5b02cemr10156381wrn.12.1688565325537;
        Wed, 05 Jul 2023 06:55:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:65eb:d140:2d45:ee85? ([2a01:e0a:982:cbb0:65eb:d140:2d45:ee85])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdd4b000000b003143765e207sm8251847wrm.49.2023.07.05.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 06:55:25 -0700 (PDT)
Message-ID: <f7bf6f1a-1cc6-55e3-82a2-ecc6818be5c4@linaro.org>
Date:   Wed, 5 Jul 2023 15:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] drm/panel: ld9040: Use better magic values
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230703214715.623447-1-paul@crapouillou.net>
 <20230703214715.623447-2-paul@crapouillou.net>
Organization: Linaro Developer Services
In-Reply-To: <20230703214715.623447-2-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 03/07/2023 23:47, Paul Cercueil wrote:
> I have no idea what the prior magic values mean, and I have no idea
> what my replacement (extracted from [1]) magic values mean.
> 
> What I do know, is that these new values result in a much better
> picture, where the blacks are really black (as you would expect on an
> AMOLED display) instead of grey-ish.
> 
> [1] https://github.com/dorimanx/Dorimanx-SG2-I9100-Kernel/blob/master-jelly-bean/arch/arm/mach-exynos/u1-panel.h
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/gpu/drm/panel/panel-samsung-ld9040.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> index 01eb211f32f7..7fd9444b42c5 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
> @@ -180,17 +180,18 @@ static void ld9040_init(struct ld9040 *ctx)
>   {
>   	ld9040_dcs_write_seq_static(ctx, MCS_USER_SETTING, 0x5a, 0x5a);
>   	ld9040_dcs_write_seq_static(ctx, MCS_PANEL_CONDITION,
> -		0x05, 0x65, 0x96, 0x71, 0x7d, 0x19, 0x3b, 0x0d,
> -		0x19, 0x7e, 0x0d, 0xe2, 0x00, 0x00, 0x7e, 0x7d,
> -		0x07, 0x07, 0x20, 0x20, 0x20, 0x02, 0x02);
> +		0x05, 0x5e, 0x96, 0x6b, 0x7d, 0x0d, 0x3f, 0x00,
> +		0x00, 0x32, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x07, 0x05, 0x1f, 0x1f, 0x1f, 0x00, 0x00);
>   	ld9040_dcs_write_seq_static(ctx, MCS_DISPCTL,
> -		0x02, 0x08, 0x08, 0x10, 0x10);
> +		0x02, 0x06, 0x0a, 0x10, 0x10);
>   	ld9040_dcs_write_seq_static(ctx, MCS_MANPWR, 0x04);
>   	ld9040_dcs_write_seq_static(ctx, MCS_POWER_CTRL,
>   		0x0a, 0x87, 0x25, 0x6a, 0x44, 0x02, 0x88);
> -	ld9040_dcs_write_seq_static(ctx, MCS_ELVSS_ON, 0x0d, 0x00, 0x16);
> +	ld9040_dcs_write_seq_static(ctx, MCS_ELVSS_ON, 0x0f, 0x00, 0x16);
>   	ld9040_dcs_write_seq_static(ctx, MCS_GTCON, 0x09, 0x00, 0x00);
>   	ld9040_brightness_set(ctx);
> +

You can drop this spurious new line for v2

>   	ld9040_dcs_write_seq_static(ctx, MIPI_DCS_EXIT_SLEEP_MODE);
>   	ld9040_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_ON);
>   }

And add

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
