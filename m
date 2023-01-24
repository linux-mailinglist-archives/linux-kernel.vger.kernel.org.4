Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598EF679CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjAXPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjAXPG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:06:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428537F02
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:06:58 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so13057968wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7/EYg58ZEi6wo6vHWDJ74Nuw88AJuXUzyRDyPwYpunA=;
        b=wawGcYyIMtorBdGqsxAaApCCiA/YhFEoe7Sge0UQdtlURJIcyG5JaTKYEOkG7Eulwc
         JqqlAh77+vcOZSYbqXLJfLNA0rWXmetjECJ2Z832t8fztANv7g5TW+5rcYaVEPi958r0
         cO7UYauV/JuesHawrR6ampiSpBfIP4oVUyMCg157BXuQGE1oJuw86qqcoNrPj9aySq3p
         ezLavg2y32H4+dDLbVj5u2wqRKwE8KapQWWblaApOKG7lHoAfyN73Tq+s0gEUFjzbk6E
         yR+7IihwWweUOJ30SQOAP8cQH0lqwqOGk7YvuaiRgQK9Hzf2BBfLGHHne+aH/P7krBhx
         7TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/EYg58ZEi6wo6vHWDJ74Nuw88AJuXUzyRDyPwYpunA=;
        b=0cK/mqG92D9BjhoCqRWHc+VJZjCi0qeun5dTS8h1g3R61A6mC4JEifMsZ6RCBjRiis
         BFq/Cmex0cJYF3Q3sJI/KkIcBeUJo1ycZQjoGxy8wUljLcW7/IVFriUZ0Qxjd0HzDyus
         aVx9zeesGrj9z/4I5H1MriuGaWDn11bY6zqk9OJhkuuyVhfcDlwf2bOfbGG4/jUKSr/+
         qAjH5BWQkWbTGdyeu+YxpPz3Hp6VGgnnzrDr2McmE/SG9Qo/oeOll8DtJbZRrXiozD6S
         wtEVu2G5eMi/8L/gv1iUgni8K7JA3w+eKmD0Gb9wF84fkPFrDZn2e97B0smHFZdfiTLr
         5/Kg==
X-Gm-Message-State: AFqh2koyGoblF37YuZhbQTk51S8+SXsV2wJq/pelcMKt7eUO/SmH/kEV
        m7CXzyI8JnzrGzestpa38anueQ==
X-Google-Smtp-Source: AMrXdXvRnlFvQMkb7ZfpLZqBPgyj05m/eyNF8ULcjvlyjPNyNjXfbc5l1/dHhIZA9aTOOWwVKApo6w==
X-Received: by 2002:a7b:ce15:0:b0:3da:2932:b61a with SMTP id m21-20020a7bce15000000b003da2932b61amr28118110wmc.18.1674572816066;
        Tue, 24 Jan 2023 07:06:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ebd2:15b:f444:7985? ([2a01:e0a:982:cbb0:ebd2:15b:f444:7985])
        by smtp.gmail.com with ESMTPSA id c40-20020a05600c4a2800b003db16770bc5sm13138509wmp.6.2023.01.24.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:06:55 -0800 (PST)
Message-ID: <986b49bd-6e97-107c-b3de-a04077e12ac4@linaro.org>
Date:   Tue, 24 Jan 2023 16:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 09/14] drm/msm/dsi: export struct msm_compression_info
 to dpu encoder
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-10-git-send-email-quic_khsieh@quicinc.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <1674498274-6010-10-git-send-email-quic_khsieh@quicinc.com>
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

On 23/01/2023 19:24, Kuogee Hsieh wrote:
> struct msm_compression_info is used to support several different
> compression mechanisms. It also contains customized info required
> to configure DSC encoder engine. This patch also make changes DSI
> module to have DSI exports struct msm_compreion_info to dpu encoder
> instead of struct drm_dsc_config.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  7 +++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 10 ++++++++--
>   drivers/gpu/drm/msm/dsi/dsi.c               |  3 ++-
>   drivers/gpu/drm/msm/dsi/dsi.h               |  3 ++-
>   drivers/gpu/drm/msm/dsi/dsi_host.c          | 14 ++++++++++++--
>   drivers/gpu/drm/msm/msm_drv.h               |  4 ++--
>   7 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 758261e..7f4a439 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright (C) 2013 Red Hat
>    * Copyright (c) 2014-2018, 2020-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    *
>    * Author: Rob Clark <robdclark@gmail.com>
>    */
> @@ -210,6 +210,7 @@ struct dpu_encoder_virt {
>   
>   	/* DSC configuration */
>   	struct drm_dsc_config *dsc;
> +	struct msm_compression_info *comp_info;
>   };
>   
>   #define to_dpu_encoder_virt(x) container_of(x, struct dpu_encoder_virt, base)
> @@ -2275,7 +2276,9 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
>   		dpu_enc->idle_pc_supported =
>   				dpu_kms->catalog->caps->has_idle_pc;
>   
> -	dpu_enc->dsc = disp_info->dsc;
> +	dpu_enc->comp_info = disp_info->comp_info;
> +	if (dpu_enc->comp_info)
> +		dpu_enc->dsc = &dpu_enc->comp_info->msm_dsc_info.drm_dsc;
>   
>   	mutex_lock(&dpu_enc->enc_lock);
>   	for (i = 0; i < disp_info->num_of_h_tiles && !ret; i++) {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 9e7236e..bd2da5e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    * Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
>    * Copyright (C) 2013 Red Hat
>    * Author: Rob Clark <robdclark@gmail.com>
> @@ -36,7 +36,7 @@ struct msm_display_info {
>   	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>   	bool is_cmd_mode;
>   	bool is_te_using_watchdog_timer;
> -	struct drm_dsc_config *dsc;
> +	struct msm_compression_info *comp_info;
>   };
>   
>   /**
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index d612419..70a74ed 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright (C) 2013 Red Hat
>    * Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    *
>    * Author: Rob Clark <robdclark@gmail.com>
>    */
> @@ -570,7 +570,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>   		info.h_tile_instance[info.num_of_h_tiles++] = i;
>   		info.is_cmd_mode = msm_dsi_is_cmd_mode(priv->dsi[i]);
>   
> -		info.dsc = msm_dsi_get_dsc_config(priv->dsi[i]);
> +		info.comp_info = msm_dsi_get_dsc_config(priv->dsi[i]);

This breaks DSC on DSI since before we had a pointer of the DSC struct that would be filled
by the DSI driver later in pre_enable(), and now we have a copy of it before it is filled.

Instead we should keep a pointer of the DSC struct in the comp_info, store the DP dsc struct in the
dp panel private and pass the dsc pointer back in dp_panel_dsc_prepare_basic_params().

>   
>   		if (msm_dsi_is_bonded_dsi(priv->dsi[i]) && priv->dsi[other]) {
>   			rc = msm_dsi_modeset_init(priv->dsi[other], dev, encoder);
> @@ -622,6 +622,8 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>   		info.num_of_h_tiles = 1;
>   		info.h_tile_instance[0] = i;
>   		info.intf_type = encoder->encoder_type;
> +		info.is_cmd_mode = 0; /* dp always video mode */
> +		info.comp_info = NULL;
>   		rc = dpu_encoder_setup(dev, encoder, &info);
>   		if (rc) {
>   			DPU_ERROR("failed to setup DPU encoder %d: rc:%d\n",
> @@ -892,6 +894,10 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   
>   	pm_runtime_get_sync(&dpu_kms->pdev->dev);
>   
> +	for (i = 0; i < cat->dsc_count; i++)
> +		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
> +				dpu_kms->mmio + cat->dsc[i].base, "dsc_%d", i);
> +
>   	/* dump CTL sub-blocks HW regs info */
>   	for (i = 0; i < cat->ctl_count; i++)
>   		msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len,
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 31fdee2..52b7e33 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #include "dsi.h"
> @@ -13,7 +14,7 @@ bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
>   	return !(host_flags & MIPI_DSI_MODE_VIDEO);
>   }
>   
> -struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
> +struct msm_compression_info *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
>   {
>   	return msm_dsi_host_get_dsc_config(msm_dsi->host);
>   }
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index bd3763a..79ada54 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -1,6 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
>    * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #ifndef __DSI_CONNECTOR_H__
> @@ -133,7 +134,7 @@ int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>   int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>   void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
>   void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host);
> -struct drm_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host);
> +struct msm_compression_info *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host);
>   
>   /* dsi phy */
>   struct msm_dsi_phy;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 18fa30e..6188f4b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #include <linux/clk.h>
> @@ -163,6 +164,7 @@ struct msm_dsi_host {
>   
>   	struct drm_display_mode *mode;
>   	struct drm_dsc_config *dsc;
> +	struct msm_compression_info comp_info;
>   
>   	/* connected device info */
>   	unsigned int channel;
> @@ -2600,9 +2602,17 @@ void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host)
>   				DSI_TEST_PATTERN_GEN_CMD_STREAM0_TRIGGER_SW_TRIGGER);
>   }
>   
> -struct drm_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host)
> +struct msm_compression_info *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host)
>   {
>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> +	struct msm_compression_info *comp_info = NULL;
>   
> -	return msm_host->dsc;
> +	if (msm_host->dsc) {
> +		comp_info = &msm_host->comp_info;
> +		comp_info->msm_dsc_info.drm_dsc = *msm_host->dsc;
> +		comp_info->comp_type = MSM_DISPLAY_COMPRESSION_DSC;
> +		comp_info->enabled = true;
> +	}
> +
> +	return comp_info;
>   }
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 6a46ed7..eab0901 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -430,7 +430,7 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
>   bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
>   bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
>   bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
> -struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
> +struct msm_compression_info *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
>   #else
>   static inline void __init msm_dsi_register(void)
>   {
> @@ -460,7 +460,7 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
>   	return false;
>   }
>   
> -static inline struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
> +static inline struct msm_compression_info *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
>   {
>   	return NULL;
>   }

