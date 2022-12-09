Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C497647C63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLICt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLICtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:49:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9B7124A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:49:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so8392735ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=53YW0ORFneqyG93srJ8jF+XX7zmPAnIboOzrEPTG0Ts=;
        b=THue66vB24/bYK1OKRCFn3bh/J/RhSIiO/22Xzu3S1OMJvLXwxUmZzaqbERTDmNPxX
         QG0p0q4606ivku/eGXQWQOeiIDGlgB5VSdhbxtsaFHyeVmlMcQ41A6JCmWrIFMjeLbed
         1QPWt9QMzlb32nmtD26qU5ryEWB5T3z82YP51rFbEtE90bFRGxb4WH0CwWFZ9sNZBDie
         YpGntb2COBf6JNsjRbynRwGQ5E9OEJXMlPt6aroZeRuLOjBeyF6GVdtPNDf/rxNqW9gD
         L5jh4FvWCbafrPqPi9eRB4EyDyH9EMgnUDC9O/kvvfbe8z/Ww1BknWX/k4YRHHKzjFg+
         S5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53YW0ORFneqyG93srJ8jF+XX7zmPAnIboOzrEPTG0Ts=;
        b=QS/gYd//BFk6rb9eP7eWCYuCVDcJQ8EEsaCIWLiPh3IpzudabPE1HT0CaA+/gzbt5W
         WvN8Hg6k+5/SCviC7l+smmklUoRM12VrRQWZzUnIKPkK4hoNQTnBngPsj4Kjs0COw5xp
         HAPwWgyRzWEw6Yddp2CoaYWRAysQItBBuQKRpo8i9ewMAATIZ3cfzQbZb2cmrVdk+KPP
         qeGC06xK6CgLTZnJXg+3haBsXB9lkqpAiSqnp/dJY9L9B/K/XVQ21nHvRmDKLf8e0lYs
         wdRfLYFUTpYOikaJe8T8DH61/l67OKzhwnNp1MkIbRMy0pAXNUEvcI7nKBdrdc8oyMAs
         qjrA==
X-Gm-Message-State: ANoB5pnP2qbTiPO42K4EgXk5oyCal2y5r5wYJZmyTOV3ZdCfD2H8Tzfh
        vvf4c+y/KFpbDF2tWaMT/C/8SIpyROyAjQEbKv3RmQ==
X-Google-Smtp-Source: AA0mqf6doDwZB2F+lKd6wShNarKCxmm1N6/epMJ03LBGs+paMSVEE2cZP89QidB84RL5HCl7NJLWWsopNGHRAj14smU=
X-Received: by 2002:a17:906:c44a:b0:7c0:d6bb:fd7 with SMTP id
 ck10-20020a170906c44a00b007c0d6bb0fd7mr18360425ejb.726.1670554161785; Thu, 08
 Dec 2022 18:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
In-Reply-To: <20221207220012.16529-1-quic_bjorande@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 8 Dec 2022 20:49:10 -0600
Message-ID: <CAKXuJqirYDCGfOP=YMOGdacB_v0GNty7HZ+p0U19a8DpBMDGKQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] drm/msm: Add SC8280XP support
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 4:00 PM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> This introduces support for the SC8280XP platform in the MDSS, DPU and
> DP driver. It reworks the HDP handling in the DP driver to support
> external HPD sources - such as the dp-connector, or USB Type-C altmode.
>
> It then introduces the display clock controllers, mdss, dpu and
> displayport controllers and link everything together, for both the MDSS
> instances on the platform, and lastly enables EDP on the compute
> reference device and 6 of the MiniDP outputs on the automotive
> development platform.
>
>
> The patches was previously sent separately, but submitting them together
> here as they (except dts addition) goes in the same tree.
>
> Bjorn Andersson (12):
>   dt-bindings: display/msm: Add binding for SC8280XP MDSS
>   drm/msm/dpu: Introduce SC8280XP
>   drm/msm: Introduce SC8280XP MDSS
>   dt-bindings: msm/dp: Add SDM845 and SC8280XP compatibles
>   drm/msm/dp: Stop using DP id as index in desc
>   drm/msm/dp: Add DP and EDP compatibles for SC8280XP
>   drm/msm/dp: Add SDM845 DisplayPort instance
>   drm/msm/dp: Rely on hpd_enable/disable callbacks
>   drm/msm/dp: Implement hpd_notify()
>   arm64: dts: qcom: sc8280xp: Define some of the display blocks
>   arm64: dts: qcom: sc8280xp-crd: Enable EDP
>   arm64: dts: qcom: sa8295-adp: Enable DP instances
>
>  .../bindings/display/msm/dp-controller.yaml   |   3 +
>  .../display/msm/qcom,sc8280xp-dpu.yaml        | 122 +++
>  .../display/msm/qcom,sc8280xp-mdss.yaml       | 143 +++
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 243 ++++-
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  72 +-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 838 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 217 +++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c |  18 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |   3 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
>  drivers/gpu/drm/msm/dp/dp_display.c           | 151 ++--
>  drivers/gpu/drm/msm/dp/dp_display.h           |   1 +
>  drivers/gpu/drm/msm/dp/dp_drm.c               |   3 +
>  drivers/gpu/drm/msm/dp/dp_drm.h               |   4 +
>  drivers/gpu/drm/msm/msm_drv.h                 |   1 +
>  drivers/gpu/drm/msm/msm_mdss.c                |   4 +
>  18 files changed, 1770 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml
>
> --
> 2.37.3
>

Tested on Lenovo Thinkpad X13s
Tested-by: Steev Klimaszewski <steev@kali.org>
