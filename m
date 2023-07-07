Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E574A7FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGGAHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGGAHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:07:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE619A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:07:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso20576811fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688688467; x=1691280467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F28CkGKtrRq/JphfDh7W7gy1EaRmjF7asRrwFDHSU+M=;
        b=u//N4ir1xng6mEM/eKQJ5eJvg5rAqP+U1AmMbhXJH4tsBRdMVb7BN7YcA9luS/TNWx
         HtcugFRngOELojkyPok/BOpic45TluwMwoOSDVH1KeA0DMoqDHe0PqGJAbr9J/+0K4jV
         Qj7ubBVTxCkM73QLP3xTWnaVR7TNHR2TJg82MIUl5DaU3XasRdVRmohd1okQ+TNBv8MI
         iOBAxjlup+FJ/pS0DC5YQq3j4fe5iy6EuQ8MjHNCuQ8fTXRIh5Py31nTWZHFjnK2OO3d
         sa3kfiDlSv9Fq7sLQhp+/OqyjhQsBLk0hF6A6GSh199HMIm3aul+2tb6rjRJRKwCR+3A
         IIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688688467; x=1691280467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F28CkGKtrRq/JphfDh7W7gy1EaRmjF7asRrwFDHSU+M=;
        b=UjmnGzRAizWNhNS4J2h1wpSxt/zBtUjmtYOAk1k03YdVgKs0Bl9iYNRUVZLzPTGUJv
         YHquvN2dZPO5f24WDMjOzpWsLXSPH4WppRZHemdmtdqiyZmX8Ltb3gvrGVhZKcHdw+bB
         myjJwlR0TCkmFQBd2gRVtDZ7S4em6Diurn2FcZ9XdJxOfQmz8Cy7OfKEutpVtd/u81Be
         Qh28Cvbt9WtYxYOOxuXRlOX1aWREZaafavr4Z8f+ImCS2Bngh91NPtGp/CV15nxtTNWi
         /+n5t8X3z9ELiBWux2naCtU5+CIwlFxwBh+nh9/3avMvnq1fmc7cKHfzGrmkUIVHn0Nz
         qwyw==
X-Gm-Message-State: ABy/qLaFFAj65F65P8wkiLiXNWoFQTsH5GtPCfkx5RzKP+jQrLiMOY6g
        L8USp2zZfKh5tZEH97JkOTC4yg==
X-Google-Smtp-Source: APBJJlHXU91JXNbEGC9i57r6waY7jofkpsgKwMCjYlKv0bIz5bxi/IhwM6btGXEIQYBnwXvN56xuTA==
X-Received: by 2002:a2e:2405:0:b0:2b6:ce35:2e9e with SMTP id k5-20020a2e2405000000b002b6ce352e9emr2408610ljk.44.1688688467134;
        Thu, 06 Jul 2023 17:07:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x22-20020a2e8396000000b002b700952298sm530462ljg.33.2023.07.06.17.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 17:07:46 -0700 (PDT)
Message-ID: <deb38d54-bf7f-f42a-8b61-f6c8f46370b0@linaro.org>
Date:   Fri, 7 Jul 2023 03:07:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/6] drm/msm/dpu: Refactor printing of main blocks in
 device core dump
Content-Language: en-GB
To:     Ryan McCann <quic_rmccann@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, quic_jesszhan@quicinc.com
References: <20230622-devcoredump_patch-v4-0-e304ddbe9648@quicinc.com>
 <20230622-devcoredump_patch-v4-5-e304ddbe9648@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v4-5-e304ddbe9648@quicinc.com>
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

On 06/07/2023 23:48, Ryan McCann wrote:
> Currently, the names of main blocks are hardcoded into the
> msm_disp_snapshot_add_block function rather than using the name that
> already exists in the catalog. Change this to take the name directly from
> the catalog instead of hardcoding it.
> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index aa8499de1b9f..70dbb1204e6c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -899,38 +899,38 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   
>   	/* dump CTL sub-blocks HW regs info */
>   	for (i = 0; i < cat->ctl_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len,
> -				dpu_kms->mmio + cat->ctl[i].base, "ctl_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len, dpu_kms->mmio +
> +					    cat->ctl[i].base, cat->ctl[i].name);

Splitting on the `+' sign is a bad idea. It makes it harder to read the 
code. Please keep the first line as is, it is perfectly fine on its own, 
and do just what you have stated in the commit message: change printed 
block name.

>   
>   	/* dump DSPP sub-blocks HW regs info */
>   	for (i = 0; i < cat->dspp_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len,
> -				dpu_kms->mmio + cat->dspp[i].base, "dspp_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len, dpu_kms->mmio +
> +					    cat->dspp[i].base, cat->dspp[i].name);
>   
>   	/* dump INTF sub-blocks HW regs info */
>   	for (i = 0; i < cat->intf_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->intf[i].len,
> -				dpu_kms->mmio + cat->intf[i].base, "intf_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->intf[i].len, dpu_kms->mmio +
> +					    cat->intf[i].base, cat->intf[i].name);
>   
>   	/* dump PP sub-blocks HW regs info */
>   	for (i = 0; i < cat->pingpong_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len,
> -				dpu_kms->mmio + cat->pingpong[i].base, "pingpong_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len, dpu_kms->mmio +
> +					    cat->pingpong[i].base, cat->pingpong[i].name);
>   
>   	/* dump SSPP sub-blocks HW regs info */
>   	for (i = 0; i < cat->sspp_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len,
> -				dpu_kms->mmio + cat->sspp[i].base, "sspp_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len, dpu_kms->mmio +
> +					    cat->sspp[i].base, cat->sspp[i].name);
>   
>   	/* dump LM sub-blocks HW regs info */
>   	for (i = 0; i < cat->mixer_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len,
> -				dpu_kms->mmio + cat->mixer[i].base, "lm_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len, dpu_kms->mmio +
> +					    cat->mixer[i].base, cat->mixer[i].name);
>   
>   	/* dump WB sub-blocks HW regs info */
>   	for (i = 0; i < cat->wb_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->wb[i].len,
> -				dpu_kms->mmio + cat->wb[i].base, "wb_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->wb[i].len, dpu_kms->mmio +
> +					    cat->wb[i].base, cat->wb[i].name);
>   
>   	if (cat->mdp[0].features & BIT(DPU_MDP_PERIPH_0_REMOVED)) {
>   		msm_disp_snapshot_add_block(disp_state, MDP_PERIPH_TOP0,
> @@ -944,8 +944,8 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   
>   	/* dump DSC sub-blocks HW regs info */
>   	for (i = 0; i < cat->dsc_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
> -				dpu_kms->mmio + cat->dsc[i].base, "dsc_%d", i);
> +		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, dpu_kms->mmio +
> +					    cat->dsc[i].base, cat->dsc[i].name);
>   
>   	pm_runtime_put_sync(&dpu_kms->pdev->dev);
>   }
> 

-- 
With best wishes
Dmitry

