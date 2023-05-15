Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FBF704024
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbjEOV5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbjEOV5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:57:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261724483
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:57:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-559e317eef1so190196417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684187860; x=1686779860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjFA8JG+boBHtApx1W1Y1Xhnw+KcbpR1DWdRqTv9O08=;
        b=whHh4H0na5gYCL8b5GzIJnareJWs9QEZGYrfFV4AaQaY8C2oGojtV0xpPAGdtZbFyh
         CdSDukMo9OWdIsJ+GzgLUW7m7mijnipvAAn6NLfYnYdzndDawGxhX3zKHsAH2hC7TqdJ
         uRJZlw1ShqYNQfRkVJXiJ5N0sFnOI+tVYN96rQ0rRxoPTuoauLlAgGmlSUdTTlOp4MZu
         BaqzBscIH6qM29AlXU2TeoNvyyrFnbYznPKL+T3gMUsNtEjf24VfOuy/8TcGaIEtrzSo
         LYWnMbQaSn3BVr2a4MjOF2w1y0/INjddCDp6k21CELNkt959rBc8/5/QnKHA6IrpZFMx
         XPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187860; x=1686779860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjFA8JG+boBHtApx1W1Y1Xhnw+KcbpR1DWdRqTv9O08=;
        b=KYQ2Dx6k6Ti2sE0RdmTvu3xTJUA0uCioUwVpUV4ts6Ow7iFJX1JcxF4s11NB9tErhT
         K9Vla45mzgmyxw0NuCbSBzEOsFTgF7wx9j0O3/NhKm/AUh63YCQcQv1f/69UexZUKNDi
         l83SO1Rc4+RZR8SZYOSxQjH46g9H3PIVPxzF+IyylnVIDKON7BD941NcRziGXuxnv7iV
         6Un1KuIvtkb749rPSMWNg5eswz5YNKozDsUA4Ub+NRw9pr5ZxtDdWSgsGDuYSzDXJhwb
         EtTbya5tFSlnZx24r2OGeX1H37/zTKsR2uHqhIw2aDT8akyujaRFZttV0NhhqAALwFXi
         Mwrw==
X-Gm-Message-State: AC+VfDy7unaTeQRhry+JAVAYpbhUmwbFh4e/drFdjbjLhdBeACbryilO
        MiquqL2jT3/HOaHLIBPprPXFdxikA8C3UZSi3TWsYg==
X-Google-Smtp-Source: ACHHUZ6z8gNR0nAgnuyg7d/9En/fNuzcDBO2CeB5DEkDrKfL8s5sR+oPsHGOSU9ePGTe37Ap4f810X8xaCup6UkhSJ0=
X-Received: by 2002:a81:6046:0:b0:561:7cb7:6fb4 with SMTP id
 u67-20020a816046000000b005617cb76fb4mr891313ywb.7.1684187860372; Mon, 15 May
 2023 14:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <1684185928-24195-1-git-send-email-quic_khsieh@quicinc.com> <1684185928-24195-4-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1684185928-24195-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 00:57:29 +0300
Message-ID: <CAA8EJppREQYCnCiA-2vTTmiyEa+ZN8Tj5-Q3Zq=dWEg+T3SLGw@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] drm/msm/dpu: test DPU_PINGPONG_DSC bit before
 assign DSC ops to PINGPONG
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 00:25, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> DPU < 7.0.0 has DPU_PINGPONG_DSC feature bit set to indicate it requires
> both dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() to be
> executed to complete DSC configuration if DSC hardware block is present.
> Hence test DPU_PINGPONG_DSC feature bit and assign DSC related functions
> to the ops of PINGPONG block accordingly if DPU_PINGPONG_DSC bit is set.
>
> changes in v6:
> -- split patches, this patch has function handles DPU_PINGPONG_DSC bit
>
> changes in v9:
> -- remove un condition assign dsc related functions to pingpong ops

Huh? This is beyond my parsing skills.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)


-- 
With best wishes
Dmitry
