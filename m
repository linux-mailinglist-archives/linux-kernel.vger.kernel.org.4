Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9873CAC7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjFXMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjFXMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:18:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11E2120
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:18:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f122ff663eso2042150e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609121; x=1690201121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyRsruu/fUl28iBCglQYvT1qo6koSkW+AIpv6R1I2FA=;
        b=GlFHGJ5PYlqtxRmpMpF9BN0uiktSeJlAI5+solMso4bic0eMrU0nyivHh0cgJ/Ue/s
         OlLrNin6J7xuHM6Cw+Ud2qOcd8aDBKXRvlrf1cs7oyaygDiFeUkrRN1C3erZ6cyrBKUR
         dG1tEtOsxVWW1wpwLRO9LpWIsnYjdadOI9wDDR9GDRLAy4ZG3VdqQypr3OrTIF7qTs8X
         7wwcV8/FyrNR90po7Akcg1gIbgfeQiHfgs0mnYMW8UVlN32pSXz0hF1vLl/z70P/0s7X
         DUo5LnWPzN4cwvBGFbAj4OotmJ/zvHwnz4avyzJKIG4jL4eXWwJ4IOEditBL7j3h0kcC
         7NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609121; x=1690201121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyRsruu/fUl28iBCglQYvT1qo6koSkW+AIpv6R1I2FA=;
        b=QXC9mWweDZbNguos4PM246p0o159AeVBMR5IP7mdcnyT5vpxEoDw6m8BGGfP667bVN
         QxWhiL0tE5UEp8uO2XKVAFJS0u7/0A6DBbgxexKaxu89d8AdmdUbhuIFYLfIapJlHNY2
         3/ufZyzzKIpWRdNfY3zBPKbeolDjFqMJ7RqlchY4Xubva3eN4CCzqLUPZZB6ByP0YHX7
         OvGl6GaW6/EfInZFDIuQ1QsYJ+XC1qEmEl283IaW+uI7tY1mFCIlIo61cVQalxtHnaK6
         0LyaRk913KVUSjFPiMd6xM3WPHug6GvSh5c2MnzQVXdeEinLPxh2WZ9uzs+a4GUp/Q4U
         bPXw==
X-Gm-Message-State: AC+VfDzmXYRJiM20nthKBQK+eiGl0a0z4uL69AsLpFRYIaU5Tjw208Ff
        JoGhFCyM/baG2aQQ1lSIyOSpzg==
X-Google-Smtp-Source: ACHHUZ49NuQFxuHSMwb/k6ad4SwMsFTMzPRyNGgul5vDsPTqUU6T0lwn6hy04G8TlTnz5+ZvcMsfrQ==
X-Received: by 2002:a05:6512:3ca6:b0:4f9:69e9:4fa6 with SMTP id h38-20020a0565123ca600b004f969e94fa6mr5394016lfv.23.1687609121104;
        Sat, 24 Jun 2023 05:18:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k3-20020ac24563000000b004f80030c219sm265629lfm.10.2023.06.24.05.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 05:18:39 -0700 (PDT)
Message-ID: <834b4ef3-0589-7265-f170-d67121575ccd@linaro.org>
Date:   Sat, 24 Jun 2023 15:18:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] drm/msm/dpu: Update dev core dump to dump registers
 of sub blocks
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
References: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
 <20230622-devcoredump_patch-v1-6-3b2cdcc6a576@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v1-6-3b2cdcc6a576@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/06/2023 02:48, Ryan McCann wrote:
> Currently, the device core dump mechanism does not dump registers of sub
> blocks within the DSPP, SSPP, DSC, and PINGPONG blocks. Add wrapper
> function to dump hardware blocks that contain sub blocks.
> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 194 +++++++++++++++++++++++++++-----
>   1 file changed, 168 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index aa8499de1b9f..9b1b1c382269 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -885,6 +885,154 @@ static int dpu_irq_postinstall(struct msm_kms *kms)
>   	return 0;
>   }
>   
> +static void dpu_kms_mdp_snapshot_add_block(struct msm_disp_state *disp_state,
> +					   void __iomem *mmio, void *blk,
> +					   enum dpu_hw_blk_type blk_type)
> +{
> +	u32 base;
> +
> +	switch (blk_type) {
> +	case DPU_HW_BLK_TOP:
> +	{
> +		struct dpu_mdp_cfg *top = (struct dpu_mdp_cfg *)blk;

Block configuration is constant, so these should be constant pointers. 
Not to mention that such type conversions are usually considered to be a 
bad idea. We loose type information, so compiler can not catch any 
errors here.

> +
> +		if (top->features & BIT(DPU_MDP_PERIPH_0_REMOVED)) {
> +			msm_disp_snapshot_add_block(disp_state, MDP_PERIPH_TOP0,
> +						    mmio + top->base, "top");
> +			msm_disp_snapshot_add_block(disp_state, top->len - MDP_PERIPH_TOP0_END,
> +						    mmio + top->base + MDP_PERIPH_TOP0_END,
> +						    "top_2");
> +		} else {
> +			msm_disp_snapshot_add_block(disp_state, top->len, mmio + top->base, "top");
> +		}
> +		break;

[skipped]

	default:
> +		DPU_ERROR("Block type not supported.");

Which block type?

> +	}
> +}
> +
>   static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_kms *kms)
>   {
>   	int i;
> @@ -899,53 +1047,47 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   
>   	/* dump CTL sub-blocks HW regs info */
>   	for (i = 0; i < cat->ctl_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len,
> -				dpu_kms->mmio + cat->ctl[i].base, "ctl_%d", i);
> +		dpu_kms_mdp_snapshot_add_block(disp_state, dpu_kms->mmio, (void *)&cat->ctl[i],

Here we are loosing the const property, which is a bad idea.

> +					       DPU_HW_BLK_CTL);

-- 
With best wishes
Dmitry

