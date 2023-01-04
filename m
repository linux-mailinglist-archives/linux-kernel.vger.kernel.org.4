Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011C65CFE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjADJqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjADJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:46:11 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67F13CCF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:46:10 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id g14so34822668ljh.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLn2bt9y0tlIr7p0iSmEuj9u/yaMgCFX32OBdxNgivg=;
        b=QesHGYAH3/oBzujE24SxNEFgv671Lygrg1IqLa48kTIW1bAZCao5PTjg3ZTQMGxVu9
         qbtAXGqFRz59RlNBmTXCgJgScChAAmFYIWdbqk9l17dRWsZkKrbLaJBujo8dBXDLlk0B
         NgpooMW07nLSoZ41/a/5We5sRcBSw6itCUeuNT7LmzQt7BckIuQM4rIDAh/5YYQIEXa1
         RwWGYYzA7XjFD+nVZcPl5VGbHlBP5Gd+4qQcUTLmt8gDA8jLYOx8wJwQ9DPQaz/0XK25
         4wFMQOU/iIpFvm4PB+3CclA12V39T20KcJ18g3PL8fNfDIaGuYr1lCLcXJLdrbpwRcOI
         t46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLn2bt9y0tlIr7p0iSmEuj9u/yaMgCFX32OBdxNgivg=;
        b=WDqdEtVzAQVVabBGHKVe5OuN2yK0s2sKTTiAXBoMyGdbFKYOHsNodwSgEDD0rvwvH6
         X8X8P5CEwuEAOt/NahICusXNHGeOQ6J5oaqsYxGnWPn74ifHJMmt4BVI+yDBFig1nSM8
         pjjpte2zfrJOV8Mm1rjLS5GHVRoRzry3v5Pyi9cpINICUkUgjNSEbonVMUyc8jUEzeMV
         2nMZkrL4lPaY8Om241dQEVAZ89PsMEnMHoXndx4c2bJHiWxZFbiMfToMvHZWSZxn39ym
         0UInOPlC8iGC7TusCVzv6XBeZT13vP6Abdf7bxDQ+aCrQnWY09338Bquwe1UNTtqfwMm
         f3iw==
X-Gm-Message-State: AFqh2kowp7BdfX5LOwHurlvK65wDv9X/1D+jzzoPvSstySKoUfQvioEv
        y86iFgK+lkKmi8yJEFGNVv3W0g==
X-Google-Smtp-Source: AMrXdXtVOq8Byz0bWtV2/2hZ7V337JltXS2U1orF9hGxvAEjfykXA0Z3HJKdyd/cKK6hWH10tGShVg==
X-Received: by 2002:a05:651c:1a29:b0:280:b13e:8e84 with SMTP id by41-20020a05651c1a2900b00280b13e8e84mr537926ljb.16.1672825568416;
        Wed, 04 Jan 2023 01:46:08 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z4-20020a2ebe04000000b0027fd65e4faesm1636051ljq.108.2023.01.04.01.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 01:46:08 -0800 (PST)
Message-ID: <97ca4286-09c2-6883-f480-fbf6f94f74f2@linaro.org>
Date:   Wed, 4 Jan 2023 11:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/6] drm/msm: mdss: add support for SM8550
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-4-9ccd7e652fcd@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v1-4-9ccd7e652fcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 11:08, Neil Armstrong wrote:
> Add support for the MDSS block on SM8550 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 144c8dd82be1..54483fe30ffd 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -288,6 +288,7 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>   		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
>   		break;
>   	case DPU_HW_VER_810:
> +	case DPU_HW_VER_900:
>   		/* TODO: highest_bank_bit = 2 for LP_DDR4 */
>   		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 3, 1);
>   		break;
> @@ -521,6 +522,7 @@ static const struct of_device_id mdss_dt_match[] = {
>   	{ .compatible = "qcom,sm8150-mdss" },
>   	{ .compatible = "qcom,sm8250-mdss" },
>   	{ .compatible = "qcom,sm8450-mdss" },
> +	{ .compatible = "qcom,sm8550-mdss" },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, mdss_dt_match);
> 

-- 
With best wishes
Dmitry

