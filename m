Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A27173EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjEaCx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjEaCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:53:54 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43561D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:53:53 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56896c77434so21786847b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685501632; x=1688093632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ViIfA1VTYU+Yivg6ZJf5R1ts4ZLw0POYEP4bI9c+UkE=;
        b=zTd/4K06RJiKkwb/mq+FXTJA3prplNzKfgdknPOO1NEXBZuEsdTvUvDtzbf4+LdOZ3
         F6tMVkCXMxKv+x2Q0u3a+7OQIsWuTiDxty86U5wKLr5tC0I+AN9IhVEXIarJ1p6tktTq
         zK9KDbWBHNU4Q7t3dN9TTasVVMnPLLtIz/LjsTbn3lyGCKQV7tTZF1BjoeS0fhi/Yq2G
         qKZyPLQgaGUpUJ1BqecnebEOHK8GGEUJUptJmE+jQJYcydHaweGX6CxB4ApCBrAEoYuj
         hTKicrmB2q7jzH/mXiMR+meq86B0+XZm66UW25tthhTZZVIXqeihDnJYQQmE9GD0lZOT
         xj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685501632; x=1688093632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViIfA1VTYU+Yivg6ZJf5R1ts4ZLw0POYEP4bI9c+UkE=;
        b=QFWCPvDN2ZgNDx9y39LomuUBXIU6CGcGT0gMxPaFN9K8ByQuCzabESp26oXEbPM42d
         CRFvJOHQU5w9piDhKp/iCmQrwzaZXCGNnuXfE/wd7zBtFfaZ+P+sGQu7Jj65ahBWUjEc
         2dXwCsDjwegnJHaQbUfVJXwp7yskAiUu0w45bBYjd29x7sFZYYf5tOw1YsvFVlw2PPCi
         0WYRI1bbBTn4WkYfiU6yVOJE2O3CCrrTrItUbYuek2ggCGwkPdM9/ML3PPioNNxOQAV+
         1mH4aq1QrPysP2Qp/ezzDrlcO86GzpIMVXGQlflj0DCpk1wycrAi31xolUkRGiPUR06D
         5ldg==
X-Gm-Message-State: AC+VfDxg5jANa6WnkzFCRT8SshSSdLeF2jPIeDOvja5Uc7ouYaDRV5LN
        UlcBvNH05iaFRjd6mXCATRWT8HPEXfloaDKvVx4RWA==
X-Google-Smtp-Source: ACHHUZ728biKo2DvqcBWyirrVo1tJbcLxBxYyxJIDbjfmZY1pX1eelSsAlNo2jih4g90gVRlugntll0kCVm1hUBDDec=
X-Received: by 2002:a81:c310:0:b0:568:4918:a9b7 with SMTP id
 r16-20020a81c310000000b005684918a9b7mr4698875ywk.23.1685501631004; Tue, 30
 May 2023 19:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230531005358.18090-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20230531005358.18090-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 31 May 2023 05:53:40 +0300
Message-ID: <CAA8EJpryw0h8TgpJ+SFJ7s0=LCjkQ6oqAjCKsm60dk_Q5e+wWA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: re-introduce dpu core revision to the catalog
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_khsieh@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 at 03:54, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> With [1] dpu core revision was dropped in favor of using the
> compatible string from the device tree to select the dpu catalog
> being used in the device.
>
> This approach works well however also necessitates adding catalog
> entries for small register level details as dpu capabilities and/or
> features bloating the catalog unnecessarily. Examples include but
> are not limited to data_compress, interrupt register set, widebus etc.
>
> Introduce the dpu core revision back as an entry to the catalog so that
> we can just use dpu revision checks and enable those bits which
> should be enabled unconditionally and not controlled by a catalog
> and also simplify the changes to do something like:
>
> if (dpu_core_revision > xxxxx && dpu_core_revision < xxxxx)
>         enable the bit;
>
> Also, add some of the useful macros back to be able to use dpu core
> revision effectively.
>
> [1]: https://patchwork.freedesktop.org/patch/530891/?series=113910&rev=4
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../msm/disp/dpu1/catalog/dpu_3_0_msm8998.h   |  1 +
>  .../msm/disp/dpu1/catalog/dpu_4_0_sdm845.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_5_0_sm8150.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h   |  1 +
>  .../msm/disp/dpu1/catalog/dpu_6_0_sm8250.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_6_2_sc7180.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_6_3_sm6115.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h   |  1 +
>  .../msm/disp/dpu1/catalog/dpu_7_0_sm8350.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_7_2_sc7280.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h  |  1 +
>  .../msm/disp/dpu1/catalog/dpu_8_1_sm8450.h    |  1 +
>  .../msm/disp/dpu1/catalog/dpu_9_0_sm8550.h    |  1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    | 31 ++++++++++++++++++-
>  14 files changed, 43 insertions(+), 1 deletion(-)
>

[skipped catalog changes]

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 677048cc3b7d..cc4aa75a1219 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -19,6 +19,33 @@
>   */
>  #define MAX_BLOCKS    12
>
> +#define DPU_HW_VER(MAJOR, MINOR, STEP)\
> +                 ((((unsigned int)MAJOR & 0xF) << 28) |\
> +                 ((MINOR & 0xFFF) << 16) |\
> +                 (STEP & 0xFFFF))
> +
> +#define DPU_HW_MAJOR(rev)((rev) >> 28)
> +#define DPU_HW_MINOR(rev)(((rev) >> 16) & 0xFFF)
> +#define DPU_HW_STEP(rev)((rev) & 0xFFFF)
> +#define DPU_HW_MAJOR_MINOR(rev)((rev) >> 16)
> +
> +#define IS_DPU_MAJOR_MINOR_SAME(rev1, rev2)   \
> +(DPU_HW_MAJOR_MINOR((rev1)) == DPU_HW_MAJOR_MINOR((rev2)))
> +
> +#define DPU_HW_VER_300 DPU_HW_VER(3, 0, 0) /* 8998 v1.0 */
> +#define DPU_HW_VER_400 DPU_HW_VER(4, 0, 0) /* sdm845 v1.0 */
> +#define DPU_HW_VER_500 DPU_HW_VER(5, 0, 0) /* sm8150 v1.0 */
> +#define DPU_HW_VER_510 DPU_HW_VER(5, 1, 1) /* sc8180 */
> +#define DPU_HW_VER_600 DPU_HW_VER(6, 0, 0) /* sm8250 */
> +#define DPU_HW_VER_620 DPU_HW_VER(6, 2, 0) /* sc7180 v1.0 */
> +#define DPU_HW_VER_630 DPU_HW_VER(6, 3, 0) /* sm6115|sm4250 */
> +#define DPU_HW_VER_650 DPU_HW_VER(6, 5, 0) /* qcm2290|sm4125 */
> +#define DPU_HW_VER_700 DPU_HW_VER(7, 0, 0) /* sm8350 */
> +#define DPU_HW_VER_720 DPU_HW_VER(7, 2, 0) /* sc7280 */
> +#define DPU_HW_VER_800 DPU_HW_VER(8, 0, 0) /* sc8280xp */
> +#define DPU_HW_VER_810 DPU_HW_VER(8, 1, 0) /* sm8450 */
> +#define DPU_HW_VER_900 DPU_HW_VER(9, 0, 0) /* sm8550 */

Instead of having defines for all SoCs (which can quickly become
unmanageable) and can cause merge conflicts, I'd suggest inlining all
the defines into respective catalog files.

Also, I'm not sure that the "step" should be a part of the catalog. I
know that this follows the hardware revision. However, please correct
me if I'm wrong, different step levels are used for revisions of the
same SoC. The original code that was reading the hw revision from the
hardware register, listed both 5.0.0 and 5.0.1 for sm8150.

> +
>  #define DPU_HW_BLK_NAME_LEN    16
>
>  #define MAX_IMG_WIDTH 0x3fff
> @@ -769,7 +796,7 @@ struct dpu_perf_cfg {
>  /**
>   * struct dpu_mdss_cfg - information of MDSS HW
>   * This is the main catalog data structure representing
> - * this HW version. Contains number of instances,
> + * this HW version. Contains dpu core revision, number of instances,
>   * register offsets, capabilities of the all MDSS HW sub-blocks.
>   *
>   * @dma_formats        Supported formats for dma pipe
> @@ -778,6 +805,8 @@ struct dpu_perf_cfg {
>   * @mdss_irqs:         Bitmap with the irqs supported by the target
>   */
>  struct dpu_mdss_cfg {
> +       u32 core_rev;
> +
>         const struct dpu_caps *caps;
>
>         const struct dpu_ubwc_cfg *ubwc;
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
