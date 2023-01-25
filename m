Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA567AD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjAYJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:07:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEEB10C6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:07:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vw16so45745648ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKu5XZz7u2vQluk0wiBXt/jibZCJ575k7sd/mK+gYBA=;
        b=JVvUoukpLNZULb1QoQgEZpWnSkyzcEpnmgyyeQVW7kDi5R2tPPJUt/nE+pH4KHwBFw
         HbozwFvdFAJ0ivKQOI4KHQLmhOlEeIZZeqKSgb7CCP6PVq+2NFfDIJfiG3URNOHWr4xo
         yMDBmA60y0l9I16Dhslz1UmiuIs8nEli5sTYNiSgC6/PDzohBci4UU/rYwYRU+oyHx/u
         ih0rCqTpwVBoPGdrpgz2Y0wyiaaIzViYlCgCzQmViWUrKCzEe6T4qpE4WnxeqUKQpgXi
         S6+QlHwTroqFofRFSXmsv4Z7wxJ1foCFtIVf227S8lmfqnyGp9PhRE1M6pEFUHWrIfNA
         6Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKu5XZz7u2vQluk0wiBXt/jibZCJ575k7sd/mK+gYBA=;
        b=pH8P5+Ax0hCUSsBpNEgg1ai9vB2K2nlG16F3Q4hev5IM4047RfwO6wbU6BoVLZ0NPB
         oWhBdwpv215qRT8zO7r/ZFTMN1A46oga30T+cXeesHu7CYLpY++K9lX4L4b9PcIRJJzx
         B+hgts71brDv5GGIMxP+B1uwDzhN+Pq5SFYPVj5Tlfu2sVx1XFcyICCMuTeby5edxIKe
         RMy4WVuBGo7IuIvK0XG8vT6aODRFL2pBV78Qc3YTIwV0j1PPH/Jixb4SjzBcuDAf+7Fj
         3q45R3/ICJGhQ1M6v5cKAl9/rvBGvMnWTIvcLgjHVF10KRsqeqiL6IPiYpStpPHR/NTG
         cHQQ==
X-Gm-Message-State: AFqh2kohxtuXmO6jjAWNMlsA+ljd0IZ+OUjnQXYwNksiXkhTC3i+FYJy
        S2WRGWCaBz0jGiX9vx+VjH4kUlAYeklqCRq6
X-Google-Smtp-Source: AMrXdXsnQLZ23qpR2JimTLucc55uxZMyxQK/8Jvh5OAwwsC0v820usa9Kszc66Ucea2kIz1B5s7wYQ==
X-Received: by 2002:a17:906:6c97:b0:870:34c:97cd with SMTP id s23-20020a1709066c9700b00870034c97cdmr33699292ejr.25.1674637645203;
        Wed, 25 Jan 2023 01:07:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kv15-20020a17090778cf00b00877df3eea64sm2092760ejc.155.2023.01.25.01.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:07:24 -0800 (PST)
Message-ID: <d3c362ce-48bd-696f-d7a0-45890695facd@linaro.org>
Date:   Wed, 25 Jan 2023 11:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/7] soc: qcom: rpmpd: Hook up VDDMX as parent of SM6375
 VDDGX
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
 <20230125032728.611640-4-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230125032728.611640-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 05:27, Konrad Dybcio wrote:
> The GPU core clock requires that both VDDGX and VDDMX domains are scaled
> at the same rate at the same time (well, MX just before GX but you get
> the idea). Set MX as parent of GX to take care of that.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/soc/qcom/rpmpd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 9a7da7cead9e..a69182618b76 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -1027,6 +1027,7 @@ static struct rpmpd sm6375_vddgx_ao;
>   static struct rpmpd sm6375_vddgx = {
>   	.pd = {	.name = "vddgx", },
>   	.peer = &sm6375_vddgx_ao,
> +	.parent = &sm6125_vddmx.pd,
>   	.res_type = RPMPD_RWGX,
>   	.res_id = 0,
>   	.key = KEY_LEVEL,
> @@ -1035,6 +1036,7 @@ static struct rpmpd sm6375_vddgx = {
>   static struct rpmpd sm6375_vddgx_ao = {
>   	.pd = {	.name = "vddgx_ao", },
>   	.peer = &sm6375_vddgx,
> +	.parent = &sm6125_vddmx_ao.pd,
>   	.active_only = true,
>   	.res_type = RPMPD_RWGX,
>   	.res_id = 0,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

