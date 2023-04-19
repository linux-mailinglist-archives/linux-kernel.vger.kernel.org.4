Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CAC6E85C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjDSXTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDSXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:19:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C871FF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:18:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso202871e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681946338; x=1684538338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wdq0P8U8MGiTGVZIVQ7vaI+OvTE8h6U0BpG3f9uUAk=;
        b=IJigncWb9EWcQl3A6d88q5mSsCJYdQmggTgHA1WKw3mvBEnyhf4PJNWk22ZQ7R+cZE
         1NrH9cfHNyIjR5OkOuKptJlKDJDEKZn5bkG95BOlTeALMtnewj83sj1hyhjY6F6K93W7
         yrEsGy68U468ViQpfgbxyl3rrOLxwo0uuko3AbPOiVVMCSKlZhdp70Ec3CGDfVgFaQOk
         YIta8MciphZXh+JZt/nEfDhHruKkdDAYfxpDalB27ppKvOrxkhODIEV0aLV1wgL2YwiV
         Ageb9gKryWJTnh3XZOg6DRIcv9pSDRVvgQpbywD2XuSXo80QT+rnQGBNo/5G2wNFDYO/
         rKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681946338; x=1684538338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wdq0P8U8MGiTGVZIVQ7vaI+OvTE8h6U0BpG3f9uUAk=;
        b=IHvHob/aBxgWLQcAUxYCwqAP9X89f0hj2QbtVX6DXq7K+R+cENWP/mEV80nGaH+gLf
         haJqDh6q3ACRjE1dRHNKH0zHRSibed3EfcHKCbt39UepQOLYR1i/s91/wSB75yR5p9xY
         lMM3unVMxL92e2dSLGuWa53H4RLuxBhKl0tRHiM2yjlOB3JFMIjQiggcRPt2MRkEZ38/
         IdllDLUq7e+l/N5e4dr70jSlBCye3qvfLtn3b7CnWOnDzcEOUviEfrNof6DuieQumEYA
         CEkgAuqgYO5WPaO6E/9JTiDBfuVTNSVJkwA4psEd+v7vSxAL+lpr/h/Tp4RlROYQ1WfW
         /tyg==
X-Gm-Message-State: AAQBX9fiXUBQYrb+/hU1JSiDRejqurRRo6tubj1IlSDT/66NkqV8bLrw
        CYngOVjBwpUSSaGd7iyejepXcQ==
X-Google-Smtp-Source: AKy350bOIyYXKa0fdwi85GvVfLkfqOtAP38hPIJi97ZpdTN8D/CTgttmmrFWABpVOGmBJJEY7o3qBw==
X-Received: by 2002:a19:760e:0:b0:4cb:13d7:77e2 with SMTP id c14-20020a19760e000000b004cb13d777e2mr5274677lff.26.1681946337815;
        Wed, 19 Apr 2023 16:18:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m10-20020a19520a000000b0048a982ad0a8sm40430lfb.23.2023.04.19.16.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 16:18:57 -0700 (PDT)
Message-ID: <08e79278-ad30-73e3-a56c-f569b3fea407@linaro.org>
Date:   Thu, 20 Apr 2023 02:18:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/11] drm/msm/dpu: do not use mixer that supports dspp
 when not required
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-11-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-11-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> This avoids using lm blocks that support DSPP when not needed, to
> keep those resources available.

This will break some of the platforms. Consider qcm2290 which has a 
single LM with DSPP. So, _dpu_rm_check_lm_and_get_connected_blks should 
be performed in two steps: first skip non-DSPP-enabled LMs when DSPP is 
not required. Then, if the LM (pair) is not found, look for any suitable 
LM(pair).

> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index f4dda88a73f7d..4b393d46c743f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -362,7 +362,7 @@ static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
>   	*pp_idx = idx;
>   
>   	if (!reqs->topology.num_dspp)
> -		return true;
> +		return !lm_cfg->dspp;
>   
>   	idx = lm_cfg->dspp - DSPP_0;
>   	if (idx < 0 || idx >= ARRAY_SIZE(rm->dspp_blks)) {
> 

-- 
With best wishes
Dmitry

