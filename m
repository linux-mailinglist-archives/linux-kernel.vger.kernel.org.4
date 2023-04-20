Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C06E9F53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjDTWu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjDTWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:50:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03693C0D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:50:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec94eb6dcaso972684e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682031021; x=1684623021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68FCGKUyFaiFbG/iXo9yWgITnRfiZGq9Rg8NWDS09CU=;
        b=Hm9MQY+d3zWJ8HGp6gmLD/00DgcjBJwatAr7+3XYRS59EtbFDERsBX8/Ks3EPh6BG3
         fQgoE2PFsLatuu5MA9UVvUlYPHKCcdjQ8E6SrVHzXj4Qs1mMw1EkHdacE/NdiUh8tfL5
         LAKAHQABx64AXh8gWtXf1KIQFq1tsUa9uQY9PFxebAD67U7c5bHoSUbUc/Bn1jQDbS9n
         Qf/iewahUJEDdjqzt+IFOixdGJwc2vN7gAfzL1LA7fLqCYA95/RQaLb5JvrgzBC1AH9K
         OO0+VY1ADaQmiqr7YH+tv2T84hDNPMSaCgIKwTazyvmrQlot1YlBbzgv+pnfUckh3UJS
         h3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031021; x=1684623021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68FCGKUyFaiFbG/iXo9yWgITnRfiZGq9Rg8NWDS09CU=;
        b=L2BtJesDACdRsCjY2gI6nDeG8Gts2kdtQpoC0uiM1oYF4+JBQayrpooJqwR7puY+aG
         Yf3n60yd3kk1V9XewlE1mMawk7FMW0zwZMPQnVlVPnNpZFYNVmsUskyE4RClsKoMERup
         YjICHnIqBuCiWxp3xAMZit+CmstoAfhzuMKD0Hg4GfoeJbhXxM8gW9zS3J4sC/XQWxRZ
         lEoA0Qxqeejcnvkuc4kSDmNlr8XzW6+rIQXprItPcPpYdPnz2pP3qh/X/P2Mpp8kbjpn
         BKk5bk5kQGG5lJEJVTaB6rWWaCNdQg0BmxqK1hYp9jBiJEmEXSo/0DjeK937ZDj+e+01
         qlwQ==
X-Gm-Message-State: AAQBX9fiv0ghwRyledYS9QD35Kl6YnepPBki0RI/wPYd6kL3hvkibj90
        nT7ZLCuFyVFkTX3NYP1fdijRsQ==
X-Google-Smtp-Source: AKy350a7P9jnq3r/leHVLSe7itJb11Vk9eHPCVoGdSGTSX6RhfhyYLjGpLCW3dojQzCUqmMeF0OUDQ==
X-Received: by 2002:ac2:5a4a:0:b0:4d7:ccef:6b52 with SMTP id r10-20020ac25a4a000000b004d7ccef6b52mr817486lfn.39.1682031021097;
        Thu, 20 Apr 2023 15:50:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o14-20020a2e730e000000b002a8d41c8ebdsm404990ljc.122.2023.04.20.15.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:50:20 -0700 (PDT)
Message-ID: <26832d5c-f55c-1dd0-947a-0278bcbf08de@linaro.org>
Date:   Fri, 21 Apr 2023 01:50:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/13] drm/msm: mdss: Add SM6375 support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 01:31, Konrad Dybcio wrote:
> Add support for MDSS on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 4e3a5f0c303c..f2470ce699f7 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -546,6 +546,15 @@ static const struct msm_mdss_data sm6350_data = {
>   	.highest_bank_bit = 1,
>   };
>   
> +static const struct msm_mdss_data sm6375_data = {
> +	.ubwc_version = UBWC_2_0,
> +	.ubwc_dec_version = UBWC_2_0,
> +	.ubwc_swizzle = 6,
> +	.ubwc_static = 0x1e,
> +	/* Possibly 0 for LPDDR3 */
> +	.highest_bank_bit = 1,
> +};

Nit: we can use sm6350 data here, can't we?

> +
>   static const struct msm_mdss_data sm8150_data = {
>   	.ubwc_version = UBWC_3_0,
>   	.ubwc_dec_version = UBWC_3_0,
> @@ -580,6 +589,7 @@ static const struct of_device_id mdss_dt_match[] = {
>   	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
>   	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
>   	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
> +	{ .compatible = "qcom,sm6375-mdss", .data = &sm6375_data },
>   	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
>   	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
>   	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },
> 

-- 
With best wishes
Dmitry

