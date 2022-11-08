Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55E46211B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiKHNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiKHNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:00:32 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA2152898
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:00:31 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b9so20976154ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kDjx/qzL2eh0m5wmlwsVx4x6L1R0dhYWzrrpOUccM0=;
        b=BQCNeJKIieoDBIAbTLQmr5SsfrzWxJdQ8odb739ZpsbXnIIoXJ6kKQ/uR5prOyAsIG
         E30yRLq11cpGe2l49t1UE5Anm28aOSCFL8ol1Mv2clj500sTbHvTz/+HqpzWjuvVE4mh
         lzxVUAG3FEKOwMU3Eo8n2YSjIwzipRG0K0eAuolBakV6utWJ3dhNe4gseNClVc4PD17P
         DNnOLCEKqJIu5AFswLkR2bFMniFJTvYL+NSfBdHlryHJtQteSOuUgcA+1QhEKSxl1/sk
         oJstNBKCEyiAEJ+APCyg0uVqXTrGpfLA0k6ca6mGu2Wem87mbFak5IoAcMX5He0Ibrah
         9yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kDjx/qzL2eh0m5wmlwsVx4x6L1R0dhYWzrrpOUccM0=;
        b=GMGT5/1zGP8local/Hh/8qK3RTZ2pXjLEVVgU1dYh44yvEQVH5xUFYRfxkXsAWeutx
         NrHjVyUNT7ZsC+xCEkWxX/eWF+DzcTtTbm6dSijzefIXRZJ0pPhO4Yag7s1DFYV0N8eJ
         TwJyol7EfdEiAAy/MhVvmgj78ttx2HRrmFVZPXgaGpDwwPw/cYdgmgQt5hf356uBzji6
         tCadTtnk7uAouAMrHWzhkTkvv3qfAwXja+InC6aFT8HG1+uCE5671KiH09vKHFtEo3lH
         96TOZGY+GJ58zX0/+28WwXPU3VBy4o5HHb1sELrdykigvEZ/XeCZKMPRPzq1nnQz/R/A
         WBEw==
X-Gm-Message-State: ACrzQf2JeG2/etmd+sVLhoWO4lIuYkAJ4+BWPG5mKP6UaIP7V8+yE+kv
        M4q2LzppFUJsBvZnUlhAW77WoA==
X-Google-Smtp-Source: AMsMyM6qrseYnJvmYhGPEvo2m0jeaZaM8yLMkfFFJSe2l9UtWRUdVcy9J/LnwHDzusZVXXYtM7zxpw==
X-Received: by 2002:a2e:98d0:0:b0:277:979:85da with SMTP id s16-20020a2e98d0000000b00277097985damr18057672ljj.23.1667912429363;
        Tue, 08 Nov 2022 05:00:29 -0800 (PST)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512114400b0049480c8e7bcsm1774176lfg.176.2022.11.08.05.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:00:29 -0800 (PST)
Message-ID: <eb36741a-6e07-402e-b707-0eb0708f6b9d@linaro.org>
Date:   Tue, 8 Nov 2022 16:00:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 04/18] dt-bindings: msm: dsi-controller-main: Fix clock
 declarations
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-5-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221107235654.1769462-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 02:56, Bryan O'Donoghue wrote:
> When converting from .txt to .yaml dt-binding descriptions we appear to
> have missed some of the previous detail on the number and names of
> permissible clocks.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

However it might be easier to move this patch after the patch adding the 
per-platform compat strings. Then you can push these items into the 
clauses where they are required.

> ---
>   .../bindings/display/msm/dsi-controller-main.yaml         | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 0f7747e55b9be..cab38a20a54b0 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -35,6 +35,10 @@ properties:
>         - description: Display escape clock
>         - description: Display AHB clock
>         - description: Display AXI clock
> +      - description: Core MultiMedia SubSystem clock
> +      - description: MDP Core clock
> +      - description: MNOC clock
> +    minItems: 6
>   
>     clock-names:
>       items:
> @@ -44,6 +48,10 @@ properties:
>         - const: core
>         - const: iface
>         - const: bus
> +      - const: core_mmss
> +      - const: mdp_core
> +      - const: mnoc
> +    minItems: 6
>   
>     phys:
>       maxItems: 1

-- 
With best wishes
Dmitry

