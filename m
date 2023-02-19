Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355169C350
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBSXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBSXJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:09:49 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBFEE38F;
        Sun, 19 Feb 2023 15:09:48 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id k13so1530445oil.1;
        Sun, 19 Feb 2023 15:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28a8B8Fp7+D1JO9Fuegh+FMpqwFzGd+RsgVRY+bgRU4=;
        b=X++hY1TU1rA72KqeeDf2LcbCBg2B6O/X/muDVFp3OFoeohaj4fBXqjbgItNXU5rCYz
         Sv1rcqIxKPRtJ0Mdqm7S7am19lru1byAYDDz1ApNqybEw4uWEVuvqaT2IlSgL6fDbin/
         +ukxY7552yZBQ5hdW9Hmk343jONTP0etFjI0sp4s/L2Yv94Xu3XSAQQ+sgQd4EJvTFE1
         5CkneXnnptvaar+ca4/rYYkciNaFDkm9eA6Hw4cJQlPMq8fWNfyvtr7c06avQaVdVTiX
         YHumFn/y8/cM2eK37gpbcBbO6lwkWe4pY4O78KOwN+0N5UUMeB7LZXegnbbJ29qKE18s
         jGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28a8B8Fp7+D1JO9Fuegh+FMpqwFzGd+RsgVRY+bgRU4=;
        b=WnR36k5XdXd7WUCmJjhxCESmx25pWaL/fQlefu8pcQI15KdL2DrWyltN/p8TGOElRc
         /15ViNOW/Tielb/qCQt6+67hXLrLddqcwKQ8HmVZq193wlyK96Mfxlgq3l+Y3CfoQtX8
         tJ75Ho787RfvjD9GmXr0vCIU3cpuAG29m/VKi/gabST3/5bhyfkfF/sdYRZ19imikVXO
         S7prHMf8HcBuVzYOPt7lcBX9bbsQREAwKHZko37dMSv+nzb6V0UMJ2Gaun4HKOipu1YV
         fiZA+2rCW0nWAIW+6n9OjhAulxnex0CJYNsC4EImQSQumYo87TgQLWGrLp+mch3R2DGp
         XP7A==
X-Gm-Message-State: AO0yUKU1/Zk65RysMElm0TNOAAT2MW9qcGavI06GuqnYq/GqgYxTRD3L
        eWLCL8hBH9u6bTMVfdDyHMPER6jNziJhM6u+lcA=
X-Google-Smtp-Source: AK7set9iYVFVecNn2E8x5CkWhPIgcgrPQHPs8+TJQs4BfkkeohxATSwZMyalt1uv7OJQ/q2Gq4Qkyzv18JzRzNcN3gc=
X-Received: by 2002:a05:6808:ec7:b0:364:c0a5:1fcf with SMTP id
 q7-20020a0568080ec700b00364c0a51fcfmr923596oiv.58.1676848187246; Sun, 19 Feb
 2023 15:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20230219185401.10479-1-rdunlap@infradead.org>
In-Reply-To: <20230219185401.10479-1-rdunlap@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 19 Feb 2023 15:09:36 -0800
Message-ID: <CAF6AEGv7xU2vhSi95MbsjzpRv4ANQ-vOOrchjJ=-uwW9f2q6Eg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix new Konfig dependency warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 10:54 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> DEVFREQ_GOV_SIMPLE_ONDEMAND depends on PM_DEVFREQ, so in order to
> select the former safely, this symbol should also depend on
> PM_DEVFREQ to avoid a Kconfig dependency warning.
>
> WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDEMA=
ND
>   Depends on [n]: PM_DEVFREQ [=3Dn]
>   Selected by [m]:
>   - DRM_MSM [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && (ARCH_QCOM || SOC=
_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=3Dy] =
&& (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dy] || QCO=
M_LLCC [=3Dy]=3Dn) && (QCOM_COMMAND_DB [=3Dn] || QCOM_COMMAND_DB [=3Dn]=3Dn=
)
>

Actually, I fixed devfreq[1] so that we no longer depend on
DEVFREQ_GOV_SIMPLE_ONDEMAND .. probably we should just drop
DEVFREQ_GOV_SIMPLE_ONDEMAND from the kconfig instead, sorry I forgot
to do that already

BR,
-R

[1] https://patchwork.freedesktop.org/series/113232/

> Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> ---
>  drivers/gpu/drm/msm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -9,6 +9,7 @@ config DRM_MSM
>         depends on QCOM_OCMEM || QCOM_OCMEM=3Dn
>         depends on QCOM_LLCC || QCOM_LLCC=3Dn
>         depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=3Dn
> +       depends on PM_DEVFREQ
>         select IOMMU_IO_PGTABLE
>         select QCOM_MDT_LOADER if ARCH_QCOM
>         select REGULATOR
