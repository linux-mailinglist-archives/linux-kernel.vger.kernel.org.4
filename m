Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE06A2542
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBXX5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:57:14 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16AF6EB29
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:57:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536c02eea4dso23397847b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTwH63vhsPUHCzwdo61GhnH28Y4i2//starUXdJIgb8=;
        b=DBw7IzE5NgvoWL7Yv3rGTZv8qnoe+Pzd9l8UT4RUfLxKwtC6hTLlnwF833rVKEmhSs
         9xOt/hKIX65JKE4DdsPv6FZLEN2rb/X2Bo342B2EThsKH1Dqer/Ovpscw1NgzpPLT8X7
         4emDysrEduOgZ9JLltkEdtPRBLVPtHgdAT0HNJkH5MZU2Dp+FgVixRp9E2nkmuv5gg/c
         2+6tW2XElSs5Zdb36sWnRpn0wTx56nEX+qF4y4JPeMLpVQJOZJKIo9MzhcpxIb9R/ATX
         +m/4KEPWint3sik9YaBKgH4CkikMVa+ad3Etdwzs5vMSmEMR9Nd8EEvy68/c9paG8HWm
         73QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTwH63vhsPUHCzwdo61GhnH28Y4i2//starUXdJIgb8=;
        b=F93IB90cgTnBvF6MLFcSCFAUNOmst5OSi99riMgJUGyIOkjsq87bx9dw8kFomGgojI
         p71SfjUbrE0D6O2QsYESsGSe8FWfMWfeIRGRM/29KKyKLktPfaJdGpblK1/eKWA3WmLA
         ibPB3pZLRXwXX1UThfYsrxAXrPNm1wEfy4YUvAvObK8e1gOcSLKp5KXXYDuBqwIHT3W4
         Sf2RsUEfsQ4PndmRV8XugUSQRr+vGmx/KZ2p54yiP7GmXeB+t0QiN0epeOwIcFREtxkc
         D8CLFUUhaE2cnlTcw75aCfNiiqgynX/z1NcxB4+lnC0Oi7aF5p+VuUYEepjyu3ZL5IEd
         KjYQ==
X-Gm-Message-State: AO0yUKWxHlAWUz51tRGhHmwKpyFJ3kGtClDsgOOgjrkwiluIOTM5smTz
        dKiG/ACoEpmAR6VixHV9BrsVYyQlfijQ5tRuD4WjBg==
X-Google-Smtp-Source: AK7set+CKAAk4bPnyFYIOvxwz2JBmKTwmgqC3ZbR6JqTCAuMnOEE9zP/DONxCqzL8Q5pCNfKGzrSvc/9xN/AN4WKfEw=
X-Received: by 2002:a05:6902:43:b0:9f2:a18c:90ed with SMTP id
 m3-20020a056902004300b009f2a18c90edmr4212261ybh.10.1677283032150; Fri, 24 Feb
 2023 15:57:12 -0800 (PST)
MIME-Version: 1.0
References: <1677267647-28672-1-git-send-email-quic_khsieh@quicinc.com>
 <1677267647-28672-2-git-send-email-quic_khsieh@quicinc.com>
 <42b3c193-8897-cfe9-1cae-2f9a66f7983a@linaro.org> <1b5afec9-454d-e1b9-0274-f0476edb4d21@quicinc.com>
In-Reply-To: <1b5afec9-454d-e1b9-0274-f0476edb4d21@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Feb 2023 01:57:01 +0200
Message-ID: <CAA8EJprowFyBMdW5QC2zG0gYUtxJ-hHXqhPfYTct2GzYJKLSHg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/msm/dpu: add dsc helper functions
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 at 01:51, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 2/24/2023 1:13 PM, Dmitry Baryshkov wrote:
> > On 24/02/2023 21:40, Kuogee Hsieh wrote:
> >> Add DSC helper functions based on DSC configuration profiles to produce
> >> DSC related runtime parameters through both table look up and runtime
> >> calculation to support DSC on DPU.
> >>
> >> There are 6 different DSC configuration profiles are supported
> >> currently.
> >> DSC configuration profiles are differiented by 5 keys, DSC version
> >> (V1.1),
> >> chroma (444/422/420), colorspace (RGB/YUV), bpc(8/10),
> >> bpp (6/7/7.5/8/9/10/12/15) and SCR (0/1).
> >>
> >> Only DSC version V1.1 added and V1.2 will be added later.
> >
> > These helpers should go to drivers/gpu/drm/display/drm_dsc_helper.c
> > Also please check that they can be used for i915 or for amdgpu
> > (ideally for both of them).
> >
> > I didn't check the tables against the standard (or against the current
> > source code), will do that later.
> >
> >>
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/Makefile                   |   1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c | 209
> >> +++++++++++++++++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h |  34 ++++
> >>   3 files changed, 244 insertions(+)
> >>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
> >>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
> >>
> >> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> >> index 7274c412..28cf52b 100644
> >> --- a/drivers/gpu/drm/msm/Makefile
> >> +++ b/drivers/gpu/drm/msm/Makefile
> >> @@ -65,6 +65,7 @@ msm-$(CONFIG_DRM_MSM_DPU) += \
> >>       disp/dpu1/dpu_hw_catalog.o \
> >>       disp/dpu1/dpu_hw_ctl.o \
> >>       disp/dpu1/dpu_hw_dsc.o \
> >> +    disp/dpu1/dpu_dsc_helper.o \
> >>       disp/dpu1/dpu_hw_interrupts.o \
> >>       disp/dpu1/dpu_hw_intf.o \
> >>       disp/dpu1/dpu_hw_lm.o \
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
> >> b/drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
> >> new file mode 100644
> >> index 00000000..88207e9
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
> >> @@ -0,0 +1,209 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights
> >> reserved
> >> + */
> >> +
> >> +#include <drm/display/drm_dsc_helper.h>
> >> +#include "msm_drv.h"
> >> +#include "dpu_kms.h"
> >> +#include "dpu_hw_dsc.h"
> >> +#include "dpu_dsc_helper.h"
> >> +
> >> +
> >
> > Extra empty line
> >
> >> +#define DPU_DSC_PPS_SIZE       128
> >> +
> >> +enum dpu_dsc_ratio_type {
> >> +    DSC_V11_8BPC_8BPP,
> >> +    DSC_V11_10BPC_8BPP,
> >> +    DSC_V11_10BPC_10BPP,
> >> +    DSC_V11_SCR1_8BPC_8BPP,
> >> +    DSC_V11_SCR1_10BPC_8BPP,
> >> +    DSC_V11_SCR1_10BPC_10BPP,
> >> +    DSC_RATIO_TYPE_MAX
> >> +};
> >> +
> >> +
> >> +static u16 dpu_dsc_rc_buf_thresh[DSC_NUM_BUF_RANGES - 1] = {
> >> +        0x0e, 0x1c, 0x2a, 0x38, 0x46, 0x54,
> >> +        0x62, 0x69, 0x70, 0x77, 0x79, 0x7b, 0x7d, 0x7e
> >
> > Weird indentation
> >
> >> +};
> >> +
> >> +/*
> >> + * Rate control - Min QP values for each ratio type in
> >> dpu_dsc_ratio_type
> >> + */
> >> +static char
> >> dpu_dsc_rc_range_min_qp[DSC_RATIO_TYPE_MAX][DSC_NUM_BUF_RANGES] = {
> >> +    /* DSC v1.1 */
> >> +    {0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 7, 13},
> >> +    {0, 4, 5, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 11, 17},
> >> +    {0, 4, 5, 6, 7, 7, 7, 7, 7, 7, 9, 9, 9, 11, 15},
> >> +    /* DSC v1.1 SCR and DSC v1.2 RGB 444 */
> >
> > What is SCR? Is there any reason to use older min/max Qp params
> > instead of always using the ones from the VESA-DSC-1.1 standard?
>
> Standards change request, some vendors may use scr to work with their panel.
>
> These table value are provided by system team.

So, what will happen if we use values from 1.2 standard (aka 1.1 SCR
1) with the older panel?

> >> +    {0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 9, 12},
> >> +    {0, 4, 5, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 13, 16},
> >> +    {0, 4, 5, 6, 7, 7, 7, 7, 7, 7, 9, 9, 9, 11, 15},


-- 
With best wishes
Dmitry
