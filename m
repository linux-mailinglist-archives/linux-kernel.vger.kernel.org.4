Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4217740518
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF0UpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF0UpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:45:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CBA1BC8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:45:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so3657911e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687898719; x=1690490719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9ru+T8nqazYLMXoRwumR/NEoX/XtATe6EB1G8ho0j8=;
        b=I1sqwLXpbcEnd1wwXIyCuZmDCkWngc0WHqtkEX7lhATSOCkzGZPyXXudHbRlj6S4Tm
         dgqboRx9azvvaCgIhKJO7CSJ9rKiKRNSOt1WoSgyxgpMBOzlFvuFP7uU7FmyKbrAW0e8
         3iAwaZ7l+Wf7tPHmP50bHVOcEdoFfUrlIgaidJ5Q/eQI/PK7ZheDATT77ObZPIYMSEeG
         afk86XXovYzh7fxatbtNUKRJKaIMDEM/94X4FTpNfq/pHPHJX0UkZX8Zaw1ahP9jcl+O
         Kfrm1hggGP/Obj41qCM6qxK7MmTdXR/lSNjgsrdm7pH50GwWRwT1nA2dS/9nVO3SUxzF
         hJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687898719; x=1690490719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9ru+T8nqazYLMXoRwumR/NEoX/XtATe6EB1G8ho0j8=;
        b=QVhf1s4mADjcTVmEhGk75WGyCHAIosueFJWpFS4cDYiy59ijpTou36L2nt1MBJcx9c
         cW5yY2WDpDkJ+EkJRrLipLLAwJr+4hSqePuASke6PBKjZDTSNq7a3J9bG9PCxUVt8URA
         QQbDOuKJ4pP1DHomTQfYiN4ESo8z9mnHbzIK65RLzFQoocglTbAVfZ7AVMcwENfclKew
         I/qLeqmsPs1vBUrWJ2PIY10vySEO7TJm39+Y/idK0vhPY4bcXya7xn4XNOZmBt+V1pXS
         z4yEYyvTyOzF34DV609iALwgChTv8vxdHc5nce8RPasqK2FHp7fE8wcBZsw0ABUOeZDw
         WOsA==
X-Gm-Message-State: AC+VfDxwOc+W5owGP4jgM6EAbghN4SyyN1QiLv1eB2Y52+c8ia0STdDL
        +PoEK5hsKna3R9rXxWHFFsOoEw==
X-Google-Smtp-Source: ACHHUZ6qN2iNek8NXD76EZBE61ieXN9cwzO56UAAW6jMnswfTYAqk4dn5HUYqWPvmwhAL5P3u7hIAw==
X-Received: by 2002:a05:6512:4029:b0:4f9:6b94:3cb9 with SMTP id br41-20020a056512402900b004f96b943cb9mr10197467lfb.16.1687898718760;
        Tue, 27 Jun 2023 13:45:18 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id eo27-20020a056512481b00b004f874e12e72sm1663888lfb.224.2023.06.27.13.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:45:17 -0700 (PDT)
Message-ID: <4ba0cd62-e629-581c-e332-01c068901ca4@linaro.org>
Date:   Tue, 27 Jun 2023 22:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/15] drm/msm/dsi: Drop unused regulators from QCM2290
 14nm DSI PHY config
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-1-03e430a2078c@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230627-sm6125-dpu-v2-1-03e430a2078c@somainline.org>
Content-Type: text/plain; charset=UTF-8
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

On 27.06.2023 22:14, Marijn Suijten wrote:
> The regulator setup was likely copied from other SoCs by mistake.  Just
> like SM6125 the DSI PHY on this platform is not getting power from a
> regulator but from the MX power domain.
> 
> Fixes: 572e9fd6d14a ("drm/msm/dsi: Add phy configuration for QCM2290")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> index 3ce45b023e63..31deda1c664a 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
> @@ -1087,8 +1087,6 @@ const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs = {
>  
>  const struct msm_dsi_phy_cfg dsi_phy_14nm_2290_cfgs = {
>  	.has_phy_lane = true,
> -	.regulator_data = dsi_phy_14nm_17mA_regulators,
> -	.num_regulators = ARRAY_SIZE(dsi_phy_14nm_17mA_regulators),
>  	.ops = {
>  		.enable = dsi_14nm_phy_enable,
>  		.disable = dsi_14nm_phy_disable,
> 
