Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9485E8E86
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiIXQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiIXQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:39:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316F7CB67
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:39:02 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so4683673lff.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UN7dIy5bKqPGCHAvZ6RCx2KKfneFm8jKTHL6ecufoDA=;
        b=mVderDBC0HH08MVkJlNWWaMuX9Uy+dZ09IDw5z/QycijWXh4HJdYAakyKlkZVqZltK
         ib+yGSQXrCRHVF24k8Z8r1/6/BwogwRVz0y3Nn6aNO/suC0R+PpAY/bw2edm1EHOd4EX
         fDakEc4Mjb9wd4T3ew3OebRtfB96/0TfQUeilsx+P5AF0Re0F6i3vYBR2Tw8EYnjNnNL
         WDq3Bzzr6oioNdAe2h3GzgIai4NZ8W0Hogj/uj1iM4zIfraw6GrHxANDdXJq6evs1d5k
         ZIr6dHheJABrNzwiIyUjmzkh1GsbnzBf1M4PTh0wiveN8bZRoLHYS98q2uUgnKksh2iw
         WiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UN7dIy5bKqPGCHAvZ6RCx2KKfneFm8jKTHL6ecufoDA=;
        b=YUcntMlR0T2Rf+HrXrxrCCMutjkkAyE30KAiitaqWlydISlxHjh1BCdDnvbWAHNj4X
         CYoFfaDSKci1Blp6cHLn2ArEg2eqndoKCCsKjNiEjJFGRG6fg54WGrLLtV2OaF7ulDC8
         HKK4leUM3oNsK7MKeQl7As+5kooeOHjRoD45py2sE8MLY6hE3lWuGyoV9k2bE87msFv9
         CMqhl/QkwqYk9n7reP+TY1dkkHj8W3ktHXEaPqsYbDlUjT+EUoKguVVYJDEa0zzCgvpi
         WRZn/O6hpNCT8xWsjSx8HGZ5iLynXccuQfy7cMWQmgXYFjQtUgjN3ItsRdZEaC+WxF6W
         aZaA==
X-Gm-Message-State: ACrzQf1E6z46vKpx2YJnzUKIToLiMvxczDLIdoPz1KDBSIjHDHKO7NCe
        sIsa4/bKLXucCFXOls2lBPX2LRTkC7LXaw==
X-Google-Smtp-Source: AMsMyM4LUkwxRtPvLlV/99Vshl39R68/lx1p+A7GnsUxLlQYo5FCnzw6uQgxz4o7vtVVbIQ7nmPieg==
X-Received: by 2002:a05:6512:308f:b0:49a:5a59:aa25 with SMTP id z15-20020a056512308f00b0049a5a59aa25mr5220074lfd.44.1664037540847;
        Sat, 24 Sep 2022 09:39:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512344c00b00494a1b242dasm1946332lfr.14.2022.09.24.09.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 09:39:00 -0700 (PDT)
Message-ID: <9ef673f2-4296-8761-4d7a-dca323ba272e@linaro.org>
Date:   Sat, 24 Sep 2022 19:38:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] thermal: qcom: tsens-v0_1: Fix MSM8939 fourth sensor
 hw_id
Content-Language: en-GB
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20220811105014.7194-1-vincent.knecht@mailoo.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220811105014.7194-1-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 13:50, Vincent Knecht wrote:
> Reading temperature from this sensor fails with 'Invalid argument'.
> 
> Looking at old vendor dts [1], its hw_id should be 3 instead of 4.
> Change this hw_id accordingly.
> 
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/master/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L511
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Daniel, gracious ping for getting this patch into 6.1.

> ---
> Fixes reading GPU temperature on msm8939 idol3 with current WIP dtsi
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..327f37202c69 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -604,7 +604,7 @@ static const struct tsens_ops ops_8939 = {
>   struct tsens_plat_data data_8939 = {
>   	.num_sensors	= 10,
>   	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
>   
>   	.feat		= &tsens_v0_1_feat,
>   	.fields	= tsens_v0_1_regfields,

-- 
With best wishes
Dmitry

