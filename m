Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121E74ABE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGGH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGGH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:27:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414E1FE6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:27:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so1577127f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688714854; x=1691306854;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V6/TmvtoicuV2apOBPHtZufSiXvw1S4gApp22mcNi6U=;
        b=XyvzBlFnBIOWefRp007o8pmr8u8XYuh/QVE9r4HkFTAAwWtvXmG3TX/x15HRpiQHO7
         kkg75ZXUds2jBbqil8ddysVwrsH/OdIVdAOOQh85teh5KSqIxaknMlAFbEy+oudFEnty
         Ks7VWTz4ic2Bq1KDSW3ApfNoTwt4tYVbFZaaK5C1XfrfXIsiDuqVKCkYTyjr4K/gbGI2
         cKvnmPz+eQyils3bchYxE68Wf7nsn4pMaV1JBtj22m8XbYHonAoUn/iwBLxE4lydntsw
         3cLgc8N0tLhCnVrp6PYLzYHgMutvZRqVgykv7hTo/RQU5TIsV8uZ6Nddm5aVztUnYYFv
         whmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688714854; x=1691306854;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6/TmvtoicuV2apOBPHtZufSiXvw1S4gApp22mcNi6U=;
        b=EB8ZN3BKlVve3aDVteqor89dSiGytHGR43LIqygu1UuM8Qh40pOapDqgDvMY6TKPun
         Ql7bw15SExYxs4QsU3OjDZR+ArDFRfDAttPWaZjM/DjsbFxuRaNgKFunv6/blg06TyHr
         zJ2bZMAXh4awS+hIsIKkLWg/4M+5AbHJU79/GzZKKNOp+NWcETR3bxzcSgFO0wxbzFmx
         70cIwRmh4tRwZlLUrPDgKLVSXHgycMCsR5XigCHwPfiYSO6BADGG2Eqsp+hRfykEOjj4
         p7+WK4zjPsc+lvqlxYhB3huD2FoHq8ieRBBgIAFsRJ39OrKdsvtY82nGkzx1ihXKgxS+
         F//w==
X-Gm-Message-State: ABy/qLbp7B0xNAjjnQ24gt97zIgL3HNA+C0XF0D/UX5Kzb3nZAG4vhjT
        nFKyj+tlkb+jxxpnwnyuqxX2Rw==
X-Google-Smtp-Source: APBJJlGZN7kAXBI0my9y3hTT0kqV5/03t70IF0sl2M02nL+hdZFtQm8jYwkkU3qiO3T+oA3tYnNQlA==
X-Received: by 2002:a05:6000:4e4:b0:313:f61c:42ab with SMTP id cr4-20020a05600004e400b00313f61c42abmr3457106wrb.56.1688714854622;
        Fri, 07 Jul 2023 00:27:34 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d5683000000b0030ae499da59sm3700320wrv.111.2023.07.07.00.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:27:34 -0700 (PDT)
Message-ID: <9c777340-5e3a-0d8e-87b5-ab535f17544b@linaro.org>
Date:   Fri, 7 Jul 2023 09:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 06/18] drm: bridge: dw_hdmi: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230707072034.48977-1-frank.li@vivo.com>
 <20230707072034.48977-6-frank.li@vivo.com>
Organization: Linaro Developer Services
In-Reply-To: <20230707072034.48977-6-frank.li@vivo.com>
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

On 07/07/2023 09:20, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 7b66f362afd8..b2b320ba2196 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3417,8 +3417,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>   			return ERR_PTR(-EINVAL);
>   		}
>   
> -		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		hdmi->regs = devm_ioremap_resource(dev, iores);
> +		hdmi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &iores);
>   		if (IS_ERR(hdmi->regs)) {
>   			ret = PTR_ERR(hdmi->regs);
>   			goto err_res;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
