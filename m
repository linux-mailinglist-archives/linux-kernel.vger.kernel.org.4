Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545DA70401D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbjEOV4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbjEOV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:56:18 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DFBA275
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:56:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a829411b5so123310547b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684187775; x=1686779775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lPlc4qEgFtAyauRuU20afGpSG3CXt4C4kt+lMYU99Q=;
        b=HKVOb41nnA/UURo70T56UwgUW5N8aPA/Od/3f9DMurCvqTPRFwzp06QhjpRKC/tpDJ
         mKJSg2QW1JZwTG0CsufHAPqFJpfeCfYbQ7la3zkUe3xUWpnC1wbVxXfiL8rguIhS8xW8
         DfWtLmIZ0w8DgPpf2KiOYF85IO8AZ8xQNbCfxsCt4IMVagwXxGUZQkFZEzbd4/SPggpq
         +pWmN1nNFJZvGjdIj4i8Kktz5DGzyQZuRMblMBGApcDJcQxvzWhZ2ZbZvHXvFkW6M7/O
         /kEkAl/yrprKPWxTkthiJVgI452TMlpR9h9Jv+FyV9mJqNp6YpVgT/kW8SagISVSz/9N
         H7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187775; x=1686779775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lPlc4qEgFtAyauRuU20afGpSG3CXt4C4kt+lMYU99Q=;
        b=RstmWKphoc3KKocsHnM73hT+JjuuSSEn4PYMNW5vgNH2CpyMbRlYW6/PnR6f/AZDe9
         UBJJmZ4D/QzbNHra7mNuCQcfEF8YWcAbzHhGSqLPanuONQSCgZ1uoWl9eSpODy8p2iFu
         hoEnVBYFKI3g2bkQ1QFZgNog99v/htLM6N/sP4og85+aodVSV7T13zBneU4jJuFsTY2a
         +s1TdrP5DlOxXt4eTkO6vuXRZoJsySL8YOCwvsO5zrR855o7a6PT87VxsFr1xn1/3Xy2
         +esVmiMqyfRoiEzz2YJGjdYuvJPSMzjamu3sapKHoIqVV4g/RAlM9Z9mhBBxji00S5Ja
         gwlA==
X-Gm-Message-State: AC+VfDw3s8CotAl0kx9X2CNHNeOudUEFaxh+2ibbCZvRHhaRvWIp0dQ0
        JpFzoWNIS7ejqstXGRWhuR36QMU9aEOhn7DczEewEA==
X-Google-Smtp-Source: ACHHUZ5yRt2IrPj/LNDhSE6gz+54j5EsXLzffnQwJylOHzaeRQYt5+9R+AGRcrxk8JfJEEUtBcf4z+r1GNt2r5ohhhs=
X-Received: by 2002:a0d:ef03:0:b0:55a:7c7:a2e1 with SMTP id
 y3-20020a0def03000000b0055a07c7a2e1mr30708227ywe.4.1684187775600; Mon, 15 May
 2023 14:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <1684185928-24195-1-git-send-email-quic_khsieh@quicinc.com> <1684185928-24195-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1684185928-24195-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 00:56:04 +0300
Message-ID: <CAA8EJprT23Bp+Mfm6XOMn4MfqdexWEjnBEC4mp144=r_cmZTTg@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for
 DPU < 7.0.0
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 00:25, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> DPU < 7.0.0 requires the PINGPONG block to be involved during
> DSC setting up. Since DPU >= 7.0.0, enabling and starting the DSC
> encoder engine was moved to INTF with the help of the flush mechanism.
> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
> available on DPU 7.0.0 and higher anymore.
> Add DPU_PINGPONG_DSC to PINGPONG_SDM845_MASK, PINGPONG_SDM845_TE2_MASK
> and PINGPONG_SM8150_MASK which is used for all DPU < 7.0 chipsets.
>
> changes in v6:
> -- split patches and rearrange to keep catalog related files at this patch
>
> changes in v9:
> -- delete add BIT(DPU_PINGPONG_DSC)  to PINGPONG_SDM845_TE2_MASK
>
> changes in v7:
> -- rewording commit text as suggested at review comments

This is definitely not in an order. Please keep the changelogs sorted
in way easy for other people to read.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 82b58c6..f2a1535 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -76,13 +76,13 @@
>         (BIT(DPU_DIM_LAYER) | BIT(DPU_MIXER_COMBINED_ALPHA))
>
>  #define PINGPONG_SDM845_MASK \
> -       (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE))
> +       (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE) | BIT(DPU_PINGPONG_DSC))
>
>  #define PINGPONG_SDM845_TE2_MASK \
>         (PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
>
>  #define PINGPONG_SM8150_MASK \
> -       (BIT(DPU_PINGPONG_DITHER))
> +       (BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_DSC))
>
>  #define CTL_SC7280_MASK \
>         (BIT(DPU_CTL_ACTIVE_CFG) | \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 6ee48f0..83854e8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -144,7 +144,8 @@ enum {
>   * @DPU_PINGPONG_TE2        Additional tear check block for split pipes
>   * @DPU_PINGPONG_SPLIT      PP block supports split fifo
>   * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
> - * @DPU_PINGPONG_DITHER,    Dither blocks
> + * @DPU_PINGPONG_DITHER     Dither blocks
> + * @DPU_PINGPONG_DSC        PP block supports DSC
>   * @DPU_PINGPONG_MAX
>   */
>  enum {
> @@ -153,6 +154,7 @@ enum {
>         DPU_PINGPONG_SPLIT,
>         DPU_PINGPONG_SLAVE,
>         DPU_PINGPONG_DITHER,
> +       DPU_PINGPONG_DSC,
>         DPU_PINGPONG_MAX
>  };
>
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
