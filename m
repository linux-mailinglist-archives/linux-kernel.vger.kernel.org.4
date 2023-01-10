Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A5663AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjAJI1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjAJI0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:26:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881DC634B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:26:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja17so8173898wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wawoO53rvJlk1mkrEk3Mn7XLvK6KEeT6tqX3/48e1U8=;
        b=Pr9agmqsqknAJz4q08X2fSpPXl8kZ8Z5uKdN4Vv71jNwgsf/nNe86VXEyygxPjlS1+
         gh/phTG0PdLsHhZdshqlb5kYaQvTDXCXFwOhBsnXxIcWteCMcYoy5Qfs3SsrxkWLLx3W
         hugOFc5Hcu3lEo7HJkKfdm+xi9R4ToC5ofhUwt8yR7aTMtheBUy8nXzk+YeSc4/MIGmj
         iD/UurKfMlWmDuUgf0tfMLblapSoqUpYumCISSHxfU0vA0+iib6EPvbgXmkBVX5aLl6K
         b+wkefGVbEhaGjydfCcfx2NBpZjUVLA14rAOF6IeuLZdbqp88gk3Nlm2m5/UhHvPAel0
         I72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wawoO53rvJlk1mkrEk3Mn7XLvK6KEeT6tqX3/48e1U8=;
        b=o5Pss3dwV+whbaScNgWLL0qi0cgSi7TKrcEB2JWx5zW8Ft+ai7hU0vmJCaO6G7UtYy
         fanBRGOhX7MlwNp4fWEvs6XeXoTybRMr9sNOO5tL6g8RrR22u6ZEZCCTqqsZbVdUhY8X
         1OLHmssmb7LxgoLk1jKzaV6/qT/8bt8DDhsT7+aXzhTf0XY/oaiejytCTcdJe5xn00Gr
         64wcbaEz6mo8MozrGxMzYbugie952YFV1U01adj7fPYVP+Au3JFxCNffg4/T0NXeoVeF
         lnFsMGu9696wFe7RG97uOY5hBj8rSea6kXz8F+87lpE2LyzoSbBlj9nOuRr2R4mldfWX
         4cIA==
X-Gm-Message-State: AFqh2krJmd9zmtiIX9bmJHTlzKyVDQyoUTDt4mm85Fp81DyVScodaQBm
        w9k2YCSrGg0V9nOUdaNQ+FNs1w==
X-Google-Smtp-Source: AMrXdXt2gDqizNUTxd+mOomuKh6q+bSdCe2n3FEqcVtnbcChDYNm1xQohVp5HnaiBOhdC0GfD1EAIQ==
X-Received: by 2002:a05:600c:1d23:b0:3d9:fb59:c16b with SMTP id l35-20020a05600c1d2300b003d9fb59c16bmr190317wms.36.1673339212077;
        Tue, 10 Jan 2023 00:26:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:26cc:e5e1:3044:b226? ([2a01:e0a:982:cbb0:26cc:e5e1:3044:b226])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm19917256wmn.28.2023.01.10.00.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 00:26:51 -0800 (PST)
Message-ID: <71924012-8955-92f2-5fcc-4632a01bba29@linaro.org>
Date:   Tue, 10 Jan 2023 09:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: meson_sm: stop using 0 as NULL pointer
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230110031242.4917-1-miles.chen@mediatek.com>
Organization: Linaro Developer Services
In-Reply-To: <20230110031242.4917-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 04:12, Miles Chen wrote:
> Use NULL for NULL pointer to fix the following sparse warning:
> drivers/firmware/meson/meson_sm.c:85:24: sparse: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   drivers/firmware/meson/meson_sm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 77aa5c6398aa..3f5ff9ed668e 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -82,7 +82,7 @@ static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
>   
>   	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
>   	if (!sm_phy_base)
> -		return 0;
> +		return NULL;
>   
>   	return ioremap_cache(sm_phy_base, size);
>   }


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
