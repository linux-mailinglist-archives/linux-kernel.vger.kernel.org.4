Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55E6F227B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbjD2CrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 22:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjD2CrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 22:47:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D6E7A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:46:55 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f9d6eccf3so7875307b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682736415; x=1685328415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AvvVOSHUebik0pK4etJRGnSRHrTFQ2KZK3q3Gebd0I=;
        b=oRptrL/V3bqyA6xemD7/7y08vO70rrFqiY7PWFElSjPjxYpT+FLfD3gxcbQiXTJFUj
         ZOrwu5bkUeF3bLt+4MpLm+SclHRghJT/1tTK6ERtnW1dzNVboJmGTG202he4/ScubhQI
         OlNZ9fsDjlAFMWG2CO9jp+CGQB7gc76EzFCbp4f+OU9kbbZtiJyA3vZ/X0f1cBeqFfYO
         kM0+Kc7b1L/ijSyoUSMGRY7fgvVP0wB8A+h0hQvE+hw/NrELaVnpwk7AwsyCXmUtMONW
         33hnZAoljh48s9FwI9h08694PlGB+VmCpfWUvkkQgaU1kwWL/QcS4X0nTMr2Dd87f5ej
         +zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682736415; x=1685328415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AvvVOSHUebik0pK4etJRGnSRHrTFQ2KZK3q3Gebd0I=;
        b=Hq+oTT8wODQGeGHtGrOgz4pkHBTFKHpRIAdzzR41FZ9/rQlMtObXqeEwmG38+blm1k
         7OQIN32RDqTqU+ynyh8Krw161Bg26q9WeHXhhzLa4FNU7dOYgU41JY3dbbEaURtzeLj5
         WyYxWPsya37TQqcGqmkzhgn08vGqQ+ZbEPWhGJ1CMm1yrTiCyqIr0FSzYI5y1Akm8/He
         OlvLyBvmkRqs7ae/OB5XHj0oUWSvLlqS2hiMcGmrnXBAX/k4M04abSQl7vXn2tbXk448
         FDpSs3UR9q0yEVXrsTrC36xl/P8x4mGjZmsPnym/GclQoetr8SRP7qEjjbYa3QlH5bbg
         az6g==
X-Gm-Message-State: AC+VfDypQtmqs7R+OJygalsTfxndPUfqiKQXvZdikh/jQliMCSOVWguh
        qFE/2kkvxWvrx7ksGHsIX97EfOvV1yA1qYdr5d2Q/w==
X-Google-Smtp-Source: ACHHUZ4fpFXcDhl7AERIyphFBcqD8k3JHX9VYqDS9GgofysSi3/+l65xDHeI+LnYc5Am7SNLLN46EdMm0xmKPRQjn/8=
X-Received: by 2002:a81:6c4e:0:b0:54c:288a:a2a1 with SMTP id
 h75-20020a816c4e000000b0054c288aa2a1mr5593718ywc.27.1682736415063; Fri, 28
 Apr 2023 19:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 29 Apr 2023 05:46:44 +0300
Message-ID: <CAA8EJpqqhP1QL7TuW8JXeVFqukWggYmB1XU8OeB65fQA+jhLAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] add DSC 1.2 dpu supports
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 at 02:45, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from [3].
>
> [1]: https://patchwork.freedesktop.org/series/116851/
> [2]: https://patchwork.freedesktop.org/series/116615/
> [3]: https://patchwork.freedesktop.org/series/112332/
>
> Abhinav Kumar (2):
>   drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
>   drm/msm/dpu: add dsc blocks for remaining chipsets in catalog
>
> Kuogee Hsieh (5):
>   drm/msm/dpu: add support for DSC encoder v1.2 engine
>   drm/msm/dpu: separate DSC flush update out of interface
>   drm/msm/dpu: add DPU_PINGPONG_DSC feature PP_BLK and PP_BLK_TE
>   drm/msm/dpu: save dpu topology configuration
>   drm/msm/dpu: calculate DSC encoder parameters dynamically

Another generic comment: this patchset doesn't have discussed RM
changes to allocate DSC blocks in proper pairs as required by DCE.

>
>  drivers/gpu/drm/msm/Makefile                       |   1 +
>  .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  19 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |   8 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  26 +-
>  .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  35 ++-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  26 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |   4 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |   2 +-
>  .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |   2 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  14 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   7 +
>  .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  16 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  14 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  14 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 102 ++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  35 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  36 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  22 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  14 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 335 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   9 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
>  23 files changed, 642 insertions(+), 116 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
