Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B067E74A812
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGGAYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGAYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:24:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A7E19A7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:24:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso1908758e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688689454; x=1691281454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CKFofg2COVa+3UsVzZ5/g1kQLOvyhdMC9h7juZx0uI=;
        b=ZlZv+jkzIZRP8kaNc9pGucbnh2+3Sw1ja8PUlhBmxWGfOdYXJ58MAd3ot/ccZhBCQm
         CrdIEV+DwTtz9PerJB7y9iU9wujsRLYD4o5vsSn+roDlIAeXHMN9y2dR7mzzGZ9CbsmJ
         K0Jl0Dcio7V/1qQK5ItSXQdcmtut06MwCU+P2jefAV/kIwuuZe9ceRnotgnj8lvVRjH+
         lUwXkTke0u/vyT/CBFxKZPqNeC0xATiBVN3lSCYh06NJLpWLWUxxJC+Qlpb32gFEeFKe
         cJCE4VluTUJMqZP9h7LJnepVruGR5J9Rj/pCyb+MXkpQIWRNiuU6e2aSvQmgEEjBMhnI
         IiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688689454; x=1691281454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CKFofg2COVa+3UsVzZ5/g1kQLOvyhdMC9h7juZx0uI=;
        b=deexwlHU/0O/Bw/5HjN1EqaEXHUJza9KZGVLK7UpEVWi7DyzAoLuhCAjHec2LuqZwT
         oY1b13X+/34P+X2NMTGt3AO7VZHEZcnYmuVUJdW0Ogngem+ZNBytK9TbPpnxfE3hAlAX
         UpzeYxQK6Wk1ZspGkitf3bN6Dml8deptlPcCMpSHGu31RqHA5FKCcU9jPc7OWkZmfv8g
         k56VUrS30OBiWVWGYHfsctAdbtEeu2dYI0sXAnHriSKK88/Sg+TGIJMGOFz4C2d97wrQ
         UXksKt5Yk0fRRiC4Sgz1BNCUae2rcTidzm7DgFR1n+DBtXNVk33aQS9U19EJEQJhb8pt
         qjrg==
X-Gm-Message-State: ABy/qLYbCiysGJBeG41Eey2t0+/NUSVt2a6aJJMy4QQWSh8jSYI0O5lR
        Zr00is+cP+J9JsoTRctBfOow4Q==
X-Google-Smtp-Source: APBJJlGAZ9rak/oL5Iz0pWx+xIf+r+efjcI9Mj+vqpbMKBZFyG34mvxSZloyT0NRwGp4SpeFIhSmOA==
X-Received: by 2002:a05:6512:220e:b0:4f8:442c:de25 with SMTP id h14-20020a056512220e00b004f8442cde25mr3033179lfu.5.1688689453964;
        Thu, 06 Jul 2023 17:24:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b12-20020ac247ec000000b004fa52552c82sm452171lfp.155.2023.07.06.17.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 17:24:13 -0700 (PDT)
Message-ID: <0493c891-9cde-8284-a988-b6e95135db85@linaro.org>
Date:   Fri, 7 Jul 2023 03:24:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/6] drm/msm/dpu: Update dev core dump to dump
 registers of sub-blocks
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
 <20230622-devcoredump_patch-v4-6-e304ddbe9648@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v4-6-e304ddbe9648@quicinc.com>
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
> Currently, the device core dump mechanism does not dump registers of
> sub-blocks within the DSPP, SSPP, DSC, and PINGPONG blocks. Edit
> dpu_kms_mdp_snapshot function to account for sub-blocks.
> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 66 ++++++++++++++++++++++++++++++---
>   1 file changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 70dbb1204e6c..afc45d597d65 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -903,25 +903,58 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   					    cat->ctl[i].base, cat->ctl[i].name);
>   
>   	/* dump DSPP sub-blocks HW regs info */
> -	for (i = 0; i < cat->dspp_count; i++)
> +	for (i = 0; i < cat->dspp_count; i++) {
>   		msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len, dpu_kms->mmio +
>   					    cat->dspp[i].base, cat->dspp[i].name);
>   
> +		if (cat->dspp[i].sblk && cat->dspp[i].sblk->pcc.len > 0)
> +			msm_disp_snapshot_add_block(disp_state, cat->dspp[i].sblk->pcc.len,
> +						    dpu_kms->mmio + cat->dspp[i].base +
> +						    cat->dspp[i].sblk->pcc.base, "%s_%s",

This might look simpler in the following form. Could you please consider it?


void *base =  dpu_kms + cat->dspp[i].base;

msm_disp_snapshot_add_block(..., base, cat->dspp[i].name)

if (!cat->dspp[i].sblk)
     continue;

if (cat->dspp[i].sblk->pcc.len)
     msm_disp_snapshot_add_block(..., base + 
cat->dspp[i].sblk->pcc.base, ...);

> +						    cat->dspp[i].name,
> +						    cat->dspp[i].sblk->pcc.name);
> +	}
> +
>   	/* dump INTF sub-blocks HW regs info */
>   	for (i = 0; i < cat->intf_count; i++)
>   		msm_disp_snapshot_add_block(disp_state, cat->intf[i].len, dpu_kms->mmio +
>   					    cat->intf[i].base, cat->intf[i].name);
>   
>   	/* dump PP sub-blocks HW regs info */
> -	for (i = 0; i < cat->pingpong_count; i++)
> +	for (i = 0; i < cat->pingpong_count; i++) {
>   		msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len, dpu_kms->mmio +
>   					    cat->pingpong[i].base, cat->pingpong[i].name);
>   
> +		/* TE2 block has length of 0, so will not print it */
> +
> +		if (cat->pingpong[i].sblk && cat->pingpong[i].sblk->dither.len > 0)
> +			msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].sblk->dither.len,
> +						    dpu_kms->mmio + cat->pingpong[i].base +
> +						    cat->pingpong[i].sblk->dither.base, "%s_%s",
> +						    cat->pingpong[i].name,
> +						    cat->pingpong[i].sblk->dither.name);
> +	}
> +
>   	/* dump SSPP sub-blocks HW regs info */
> -	for (i = 0; i < cat->sspp_count; i++)
> +	for (i = 0; i < cat->sspp_count; i++) {
>   		msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len, dpu_kms->mmio +
>   					    cat->sspp[i].base, cat->sspp[i].name);
>   
> +		if (cat->sspp[i].sblk && cat->sspp[i].sblk->scaler_blk.len > 0)
> +			msm_disp_snapshot_add_block(disp_state, cat->sspp[i].sblk->scaler_blk.len,
> +						    dpu_kms->mmio + cat->sspp[i].base +
> +						    cat->sspp[i].sblk->scaler_blk.base, "%s_%s",
> +						    cat->sspp[i].name,
> +						    cat->sspp[i].sblk->scaler_blk.name);
> +
> +		if (cat->sspp[i].sblk && cat->sspp[i].sblk->csc_blk.len > 0)
> +			msm_disp_snapshot_add_block(disp_state, cat->sspp[i].sblk->csc_blk.len,
> +						    dpu_kms->mmio + cat->sspp[i].base +
> +						    cat->sspp[i].sblk->csc_blk.base, "%s_%s",
> +						    cat->sspp[i].name,
> +						    cat->sspp[i].sblk->csc_blk.name);
> +	}
> +
>   	/* dump LM sub-blocks HW regs info */
>   	for (i = 0; i < cat->mixer_count; i++)
>   		msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len, dpu_kms->mmio +
> @@ -943,9 +976,30 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   	}
>   
>   	/* dump DSC sub-blocks HW regs info */
> -	for (i = 0; i < cat->dsc_count; i++)
> -		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, dpu_kms->mmio +
> -					    cat->dsc[i].base, cat->dsc[i].name);
> +	for (i = 0; i < cat->dsc_count; i++) {
> +		if (cat->dsc[i].features & BIT(DPU_DSC_HW_REV_1_2)) {
> +			struct dpu_dsc_blk enc = cat->dsc[i].sblk->enc;
> +			struct dpu_dsc_blk ctl = cat->dsc[i].sblk->ctl;
> +
> +			/* For now, pass in a length of 0 because the DSC_BLK register space
> +			 * overlaps with the sblks' register space.
> +			 *
> +			 * TODO: Pass in a length of 0 to DSC_BLK_1_2 in the HW catalog where
> +			 * applicable.

Please assume that https://patchwork.freedesktop.org/series/119776/ and 
rebase your code on top of it.

> +			 */
> +			msm_disp_snapshot_add_block(disp_state, 0, dpu_kms->mmio +
> +						    cat->dsc[i].base, cat->dsc[i].name);
> +			msm_disp_snapshot_add_block(disp_state, enc.len, dpu_kms->mmio +
> +						    cat->dsc[i].base + enc.base, "%s_%s",
> +						    cat->dsc[i].name, enc.name);
> +			msm_disp_snapshot_add_block(disp_state, ctl.len, dpu_kms->mmio +
> +						    cat->dsc[i].base + ctl.base, "%s_%s",
> +						    cat->dsc[i].name, ctl.name);
> +		} else {
> +			msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, dpu_kms->mmio +
> +						    cat->dsc[i].base, cat->dsc[i].name);
> +		}
> +	}
>   
>   	pm_runtime_put_sync(&dpu_kms->pdev->dev);
>   }
> 

-- 
With best wishes
Dmitry

