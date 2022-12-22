Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3F6544D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiLVQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiLVQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:06:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9172A528
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:06:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d3so2408021plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pd8J2dbi+nJa0nIAVQiZbGW+egYRsIjDjMr2P+LE6ac=;
        b=jbNC/iaFj19aD9UAvXbaxGHFITNg/Oj13sTSy6nq0qcRIcNCqRgD22hu4q3750DMBB
         sGtesb8aHe3Abg3JriFsX0FlA2qiL85lQgcm5RLsguxSk2RggrkPRH5rxcKTy4kCTOOu
         0q+qe96uDDe32oSEIX0oNaQ2fxssFQE/X7/hbkGrVfRRZ/nCTJff2+P00kbhkg+/ydmg
         cqM1NE4qKxxinOCaOguLjDXZOBGJ0XIilHYe7Lu9DeGvMzvPbuLxu6H4iivb3sCKbX8x
         WG/Kpa1a0apkv33M+emZvyfd5F7lxGhgVaQ8Q52vxLT1PySXYTimlQiT8p/kKu92mN1M
         9DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd8J2dbi+nJa0nIAVQiZbGW+egYRsIjDjMr2P+LE6ac=;
        b=gWRaG+l2COZn6zY+TF0iQm1rt4oVV7PO30HBXLO+g+FPB1EYcGoxkIbBvqYX1s1H2V
         QXohTDUuKU7cPPiis9cjtDsiSFvuQk95HAnVYqdXMjvhHsCp9lKoc2230JIGkQYZv2dJ
         IrqtN8/RdxcVBAO1bP4Z/zR2gyrk0w8uH4pIQFP9ol5z3TYiaCtvOvY4uLvR+3cLNtdk
         zdKWmE4gLM5CL4sAvMm1HYCMDoXOaMJ4XajfSAua8B1mCA+Y2bp8sscEylRaUn665bvD
         dOKgZIy02YI9khJj8IsljYQgzcTG8+KLdRnWUBE20qFZq7T/PCjR3QqtAMHqtG29tbZW
         OpWg==
X-Gm-Message-State: AFqh2krFrHHYNZlAkjw5wz+ZtPeCiQBN9NuAdOXRnLfXVPH2oL7dmVOv
        FSmeI498fflzzNUaDUFP5YSN8blFqVkRWYYhT+czSQ==
X-Google-Smtp-Source: AMrXdXs+kPSuX6elbHX0wwdBF6E2KD4a5x3vO5J56BnBpITPhp5hbb1eOlxVKC42QFy7/VnsQMdZzD4OttJDFfJ0X68=
X-Received: by 2002:a17:90a:be0c:b0:219:ef02:a5eb with SMTP id
 a12-20020a17090abe0c00b00219ef02a5ebmr636078pjs.84.1671725178987; Thu, 22 Dec
 2022 08:06:18 -0800 (PST)
MIME-Version: 1.0
References: <1671642843-5244-1-git-send-email-quic_akhilpo@quicinc.com> <20221221224338.v4.4.I96e0bf9eaf96dd866111c1eec8a4c9b70fd7cbcb@changeid>
In-Reply-To: <20221221224338.v4.4.I96e0bf9eaf96dd866111c1eec8a4c9b70fd7cbcb@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Dec 2022 17:05:42 +0100
Message-ID: <CAPDyKFoZB0tmbZwgVnmcbMvV9RNWVQJ+bnkxC7sc4M4yxk-n=Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/msm/a6xx: Remove cx gdsc polling using 'reset'
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 at 18:14, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> Remove the unused 'reset' interface which was supposed to help to ensure
> that cx gdsc has collapsed during gpu recovery. This is was not enabled
> so far due to missing gpucc driver support. Similar functionality using
> genpd framework will be implemented in the upcoming patch.
>
> This effectively reverts commit 1f6cca404918
> ("drm/msm/a6xx: Ensure CX collapse during gpu recovery").
>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Updated commit msg (Philipp)
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ----
>  drivers/gpu/drm/msm/msm_gpu.c         | 4 ----
>  drivers/gpu/drm/msm/msm_gpu.h         | 4 ----
>  3 files changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 36c8fb699b56..4b16e75dfa50 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -10,7 +10,6 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/devfreq.h>
> -#include <linux/reset.h>
>  #include <linux/soc/qcom/llcc-qcom.h>
>
>  #define GPU_PAS_ID 13
> @@ -1298,9 +1297,6 @@ static void a6xx_recover(struct msm_gpu *gpu)
>         /* And the final one from recover worker */
>         pm_runtime_put_sync(&gpu->pdev->dev);
>
> -       /* Call into gpucc driver to poll for cx gdsc collapse */
> -       reset_control_reset(gpu->cx_collapse);
> -
>         pm_runtime_use_autosuspend(&gpu->pdev->dev);
>
>         if (active_submits)
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 30ed45af76ad..97e1319d4577 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -16,7 +16,6 @@
>  #include <generated/utsrelease.h>
>  #include <linux/string_helpers.h>
>  #include <linux/devcoredump.h>
> -#include <linux/reset.h>
>  #include <linux/sched/task.h>
>
>  /*
> @@ -933,9 +932,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>         if (IS_ERR(gpu->gpu_cx))
>                 gpu->gpu_cx = NULL;
>
> -       gpu->cx_collapse = devm_reset_control_get_optional_exclusive(&pdev->dev,
> -                       "cx_collapse");
> -
>         gpu->pdev = pdev;
>         platform_set_drvdata(pdev, &gpu->adreno_smmu);
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 651786bc55e5..fa9e34d02c91 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -13,7 +13,6 @@
>  #include <linux/interconnect.h>
>  #include <linux/pm_opp.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/reset.h>
>
>  #include "msm_drv.h"
>  #include "msm_fence.h"
> @@ -282,9 +281,6 @@ struct msm_gpu {
>         bool hw_apriv;
>
>         struct thermal_cooling_device *cooling;
> -
> -       /* To poll for cx gdsc collapse during gpu recovery */
> -       struct reset_control *cx_collapse;
>  };
>
>  static inline struct msm_gpu *dev_to_gpu(struct device *dev)
> --
> 2.7.4
>
