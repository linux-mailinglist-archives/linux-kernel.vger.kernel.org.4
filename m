Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C36C8209
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjCXQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCXQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:00:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9565222C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:00:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j7so2755761ybg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679673624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dksB5iUeGdRvRQe9WabXTIoiziL1Tg7lbGcFiUozL5I=;
        b=LtkMFara10dgLjAbxXPq+4fMco9nzBsbyzzfzOyehY8TOr93VzM63jajwq22UizIL4
         xgCwBPlf/97VxpY7EYWgJjEZrNYx2QrwcLKeRp6sjxO/F+n6bDtACh4a3jRrOdBraziL
         gBfVaKb6HLn0K+V7jGWcKvtoKBDYSXhjBlrql2FX0nEsdpiA/BPbphLO6B7J1h+74Vx4
         MT9vMggeF3VWIx8H/oZjwDuWD8DE4nFJtEtUHWHvvNlVczk0BxJgK8kEUqYxKi7OR/Bq
         jAyKLIH/mtdJKopJT48+aYsPy1wfUUUjm0ZoHwmQsYMoIiG0cAwtHtW0snJpsovlk0Wy
         EHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679673624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dksB5iUeGdRvRQe9WabXTIoiziL1Tg7lbGcFiUozL5I=;
        b=mgEe8prXunlE62ZFTvGeZlfsYgWYeCzE0j+jVaRs3blg8qecQu10AxpYaBOTx6Gzct
         /fVJSAJ/4Ld5LOzITEQMR3nqSLWVzd5vUZG7YYMf1omck5fHCpq9tdkkEpsJq5dcvHFE
         iLM71jBAxfa6tsGwNYJCZHi4pCrkk87WGqa7G1UkQ7hbjY8zurU+9+ugt/6k9RO6WH++
         yDDArU3qEI5gprCySipdqcAiwyNXsCTm1LPZn4pSAs7cY9MYknGFWv7mAUJHzPErOcrs
         25CX4KQIJMgnYMQ0DAEMffmHnK8cfjuDnIyycrQo7pmhvZOTACA8Tt6aG12AT1PF1XIE
         1gjg==
X-Gm-Message-State: AAQBX9cXtQA056lTcYKnk8iTpOIbVme0RFDJeD5OwRZvwxSkkgdcoEro
        voBxIG65bfTSp+xfaXv4P3owVaN9Dfhf/cHLtbQTUA==
X-Google-Smtp-Source: AKy350ZoxswfuZe1V0eDrNYugY+teAimH2xnIykHhpuOjIfpxFVli6q2uii5Xx2zsLdj7tAw829/nisfatey66SbkeY=
X-Received: by 2002:a25:db91:0:b0:b75:8ac3:d5d9 with SMTP id
 g139-20020a25db91000000b00b758ac3d5d9mr1586805ybf.3.1679673623712; Fri, 24
 Mar 2023 09:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230324095502.3289094-1-arnd@kernel.org>
In-Reply-To: <20230324095502.3289094-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Mar 2023 16:59:48 +0100
Message-ID: <CAPDyKFok_k=M8-g4kgm+5CT7vzrqfbZYfLWCD1oU3W6r-2fsog@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: add CONFIG_PM dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 at 10:55, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Selecting CONFIG_PM_GENERIC_DOMAINS causes a build failure when CONFIG_PM
> is not enabled:
>
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
>   Depends on [n]: PM [=3Dn]
>   Selected by [m]:
>   - DRM_MSM [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && (ARCH_QCOM [=3Dy]=
 || SOC_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT =
[=3Dy] && (QCOM_OCMEM [=3Dy] || QCOM_OCMEM [=3Dy]=3Dn) && (QCOM_LLCC [=3Dn]=
 || QCOM_LLCC [=3Dn]=3Dn) && (QCOM_COMMAND_DB [=3Dy] || QCOM_COMMAND_DB [=
=3Dy]=3Dn) && DEVFREQ_GOV_SIMPLE_ONDEMAND [=3Dy]
>
> drivers/base/power/domain.c:654:13: error: use of undeclared identifier '=
pm_wq'
>         queue_work(pm_wq, &genpd->power_off_work);
>                    ^
> drivers/base/power/domain.c:853:26: error: no member named 'ignore_childr=
en' in 'struct dev_pm_info'
>                 if (!dev || dev->power.ignore_children)
>                             ~~~~~~~~~~ ^
>
> Fixes: c11fa1204fe9 ("drm/msm/a6xx: Use genpd notifier to ensure cx-gdsc =
collapse")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/gpu/drm/msm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 1c417ba53b5b..85f5ab1d552c 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -9,6 +9,7 @@ config DRM_MSM
>         depends on QCOM_OCMEM || QCOM_OCMEM=3Dn
>         depends on QCOM_LLCC || QCOM_LLCC=3Dn
>         depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=3Dn
> +       depends on PM
>         select IOMMU_IO_PGTABLE
>         select QCOM_MDT_LOADER if ARCH_QCOM
>         select REGULATOR
> --
> 2.39.2
>
