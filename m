Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCE7720AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjFBVFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjFBVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:05:51 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B7E62
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 14:05:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9a7e639656so2732380276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685739939; x=1688331939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bGtOFR2mphGb3w/SKqqatTcmK2Pjhu9d+mT6IMF2bsA=;
        b=O8cWtf9dK3IVBtCzRm56Bvob5Vhhmtc5jm/bwtrzzNg5NFGeACg0/roonLuhnaKj9w
         l9zK+/K1wWpvLNvKbUMpYKoE5GSPi2MzMfZLq2V8rYqnQdDI79ckTFzhENhOotuajVBx
         rZLnuOHFhJdTfuviF+xyrGeIZowEG6c591jS++W2CWKFRNVKmG8W4l6ucVyIz0hqICLn
         1SJduWUuUDVhlUWYgc8KpFRBJyi/pdoJtLxorMHFCbmjaHgvsxBC8jZMAsTfAOIcK9Ta
         rxXWbKQojO6qVCNjmvwICCaFkBklLVyIxuyXU1of/N+71b5mF2YPzLb5Uln13dIpUknZ
         feUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685739939; x=1688331939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGtOFR2mphGb3w/SKqqatTcmK2Pjhu9d+mT6IMF2bsA=;
        b=gHB8Ft/iMuBJfBAiLcKnwp/cimCCkjappV4iY0S+svxGfsS95l8O3b1rQEiUf66QCg
         YvOXDnHcYZrQEdguQ+J0hjBmU824LHrE62KE82b5uigbsIpnY/aWWZPqwoigsJIOkfQO
         AITCmaGHIey7+hVgmiRsH30enuWYGvJpYpCI8Ip4HF+t2o91A1ksZxLuyUa7xzQPEGLX
         EggnvPyI6/b5O3ye1xrIzrky8aAllPWQZwBq98Yy4iiU+FHQB90AM5sWMC7Rfz9+Ifjg
         qpvk0llFfQanD+lvtjALnfB3dsncSXV61rTR9R5cJ4R7VAetgEpnZtoX2lEVrbHNvgfV
         MBzw==
X-Gm-Message-State: AC+VfDzNBdu4D1+Uh2bfEMtSHirI6iOFkk622T5GXoQz+IG1esPRgbro
        f74KxpPn7SeHqPjUoS+tK/oYLoYNQ8dpSKNk0Z/gyg==
X-Google-Smtp-Source: ACHHUZ7Gn7c4DGB7V9sdrivTf8wBNtf7tCUcHwzPgc4kwSOC01IapgteGYaVZI1W8k3JxzfxAXKuXpFOGHc0YMbxFh8=
X-Received: by 2002:a25:768a:0:b0:ba9:6b90:e551 with SMTP id
 r132-20020a25768a000000b00ba96b90e551mr4566101ybc.50.1685739938909; Fri, 02
 Jun 2023 14:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
 <1685464318-25031-3-git-send-email-quic_khsieh@quicinc.com>
 <dfa12c8b-ccec-261c-9c83-54536e17c02d@linaro.org> <157e8219-7af2-c7ed-6d99-3caa6fbc11ba@quicinc.com>
 <CAA8EJponkEne2vVsNP=2Fxmv=Uc6i_LzAGBSEz9hPPotCEpGzg@mail.gmail.com>
 <e69f02b7-eba9-5f33-5ca1-eb0638928414@quicinc.com> <CAA8EJpr9dfrrEsFf8heOvG3BWRTVCY-q1QYNH_3OBeMAWEwotA@mail.gmail.com>
 <d1a320c4-d851-ba75-ef7b-80dc369d1cfd@quicinc.com> <CAA8EJpqzyYQAg+VXLzttan7zGWv4w+k6kgS2SbRo26hFZ_9Efg@mail.gmail.com>
 <32aa41ee-4ab0-0915-a77f-5b0d6874b3e1@quicinc.com>
In-Reply-To: <32aa41ee-4ab0-0915-a77f-5b0d6874b3e1@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 3 Jun 2023 00:05:27 +0300
Message-ID: <CAA8EJpp0aWd2i4vkbURgDx+s99KNZYeEkd9RK0+fP+QfzDgZKg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v1 2/3] drm/msm/dpu: retrieve DSI DSC struct
 at atomic_check()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     freedreno@lists.freedesktop.org,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

Generic note: please use reply-to-all instead of any other options to
answer the email. You have dropped all recipients (except the
freedreno@) in the message
<d1a320c4-d851-ba75-ef7b-80dc369d1cfd@quicinc.com> (and it was left
unnoticed).


On Fri, 2 Jun 2023 at 20:00, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> There is one option which is keep current
> >>
> >> 1) keep struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi
> >> *msm_dsi) at dsi.c
> >>
> >> 2) use  struct msm_display_info *disp_info saved at dpu_enc to locate
> >> struct msm_dsi from priv->dsi[] list (see item #3)
> >>
> >> 3)  info.dsc = msm_dsi_get_dsc_config(priv->dsi[info.h_tile_instance[0]]);
> >>
> >> 4) ballistically, keep original code but move  info.dsc =
> >> msm_dsi_get_dsc_config(priv->dsi[i]); to other place sush as
> >> atomic_check() and atomic_enable().
> >>
> > 5) leave drm_dsc_config handling as is, update the dsc config from the
> > DP driver as suitable. If DSC is not supported, set
> > dsc->dsc_version_major = 0 and dsc->dsc_version_minor = 0 on the DP
> > side. In DPU driver verify that dsc->dsc_version_major/_minor != 0.
>
> I am confusing with item 5)
>
> Currently, msm_dsi_get_dsc_config() of dsi side return dsc pointer if
> dsc enabled and NULL if dsc not enabled.
>
> Should checking dsc == NULL is good enough to differentiate between dsc
> is supported and not supported?

This is called a "shared memory area". Instead of either providing a
dynamic data pointer, one can provide a pointer to the static area
which is filled by DP or DSI. If there is no DSC available, one flags
'data not valid' by setting major,minor to 0.

>
> Why need to set both dsc->dsc_version_major = 0 and
> dsc->dsc_version_minor = 0 for dsc is not supported?

6) Another option (which is more in style of what is done in the
vendor kernel, if I'm not mistaken):

Enhance struct drm_display_mode to contain a pointer to the DSC
config. Use this pointer to check whether DSC should be enabled for
the particular mode or not. The panels with the static DSC
configuration can use a static data pointer.


-- 
With best wishes
Dmitry
