Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BEF642D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLEQpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiLEQpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:45:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0DE20BCA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:43:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so29198665ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T6ZUg9Uts/RCycJHNnU8zCmKcz9otv2yooZkgV/xEU=;
        b=Hxf6ckTx/c9ffNaO6EJZVXKMHXYgAllbIT83I+FhPvda0enX81HjSLXcVncB/kIZXy
         y7dH0rONJeGnSkh54tMeyIT3ypay8TyFiSFQXwlI5rCzGebgG9JMygMZjSDTd6duJ+WW
         3zw0JselUsVxZIn484XFKVnFaQuEF6VLnGG5LiZ04OAaltGl4U1DNcrvEzuvaCJIBCJz
         eovtEsjDyYtwOw57TGsTiiNiXn5r1Ze7VilXhV1fAsEIyzBjmfWNHOVkWrHSsg4GcB7Z
         8TZxXt4JH/TGVWSTamS8NIl/RWXDcoKzCCe/0cZZ0gx/2KN1puFz7qDdVjbShH8meKdF
         jo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+T6ZUg9Uts/RCycJHNnU8zCmKcz9otv2yooZkgV/xEU=;
        b=kEApCXk4SrG3imVoUSozGaE9s0bMA1lmwSuJGj1IE32JYnCoiH0ZhxPH+XjAm1HOgI
         4YOVMy1um0e1fqosbu2E2/zg9EIa4toYkY+dA/jMJvo3GpdqKV2RDN5T24+z9htLg8aL
         C0oPQoCR2wSOZ3//R9HekJcpUIjGEHielqoOml96IGVQipuaGyMlWttfCcUayOSl2U66
         srE6bOZnv2+wIcTAbyUUkUwHM6zZciWSLhfWJHauQPb6JgKPqFmJ4X0Fdl8DpdoJ5hLZ
         1PAFK4Gb0J6vR0jLQ8Za4AKU7ZQaHQqbyB25CELRRhi3y244aFDJOWKsSy89OQ0Vhqdl
         phAQ==
X-Gm-Message-State: ANoB5pmvJ4dz613rz8O8YteoM+/kfU/0xGcmi66ON3O2T9sSwV9ZLzdU
        hvobMeIxZw65RtgXbaL8SIvKyA==
X-Google-Smtp-Source: AA0mqf7pPnPhnBxvry/tioTaBmpBBDvwmqAlEex+xduk5phI5NL2OfmBidmBJ6uVRoYg0YjMdARM3g==
X-Received: by 2002:a17:907:9555:b0:7c0:b87f:95c5 with SMTP id ex21-20020a170907955500b007c0b87f95c5mr14978369ejc.86.1670258631856;
        Mon, 05 Dec 2022 08:43:51 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm4652996ejb.41.2022.12.05.08.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 08:43:50 -0800 (PST)
Message-ID: <f448712f-6915-eeb0-2f9a-37658512db37@linaro.org>
Date:   Mon, 5 Dec 2022 17:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 05/11] drm/msm: Add support for SM8350
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-6-robert.foss@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221205163754.221139-6-robert.foss@linaro.org>
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



On 05/12/2022 17:37, Robert Foss wrote:
> Add compatibles string, "qcom,sm8350-mdss", for the multimedia display
> subsystem unit used on Qualcomm SM8350 platform.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/gpu/drm/msm/msm_mdss.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index a2264fb517a1..39746b972cdd 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -293,6 +293,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>   		/* UBWC_2_0 */
>   		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x1e);
>   		break;
> +	case DPU_HW_VER_700:
> +		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 1, 1);
> +		break;
>   	case DPU_HW_VER_720:
>   		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
>   		break;
> @@ -530,6 +533,7 @@ static const struct of_device_id mdss_dt_match[] = {
>   	{ .compatible = "qcom,sc8180x-mdss" },
>   	{ .compatible = "qcom,sm8150-mdss" },
>   	{ .compatible = "qcom,sm8250-mdss" },
> +	{ .compatible = "qcom,sm8350-mdss" },
>   	{ .compatible = "qcom,sm8450-mdss" },
>   	{}
>   };
