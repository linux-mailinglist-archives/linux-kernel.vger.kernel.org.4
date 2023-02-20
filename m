Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF94F69D202
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjBTRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBTRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:16:54 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998AC2055B;
        Mon, 20 Feb 2023 09:16:43 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w7so1792873oik.13;
        Mon, 20 Feb 2023 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yCCqN4WenreXQXaeokHFsokNS6R/AL5lZmu0td1QuDM=;
        b=T/wKTsaR8S2ExYBfdLknydchelnrA7/8OtWu4AOGznMnirYrEmHNuNs3B0sFTty2eW
         xL/Hxt8dQLloqzyOW+V+xJl3jLy1EMXMXLJPcpt7NeoOfFphvGsbJ2vUGD4Gnj6lm+6y
         YCLtKRuT3rW3DwB4rKgO+gzQKY/km+yioOJ1dvHyTKR9+fippc/NCmmWPDt/v6EpC7R1
         xjjRDhDQ15kg+zG4Y+G0foQ4pY+kLSdc5mhDnHHy6cvxb8buwz0L+P4oQ5bSYnhOuX+U
         KDq8Cv+PKFbSU7sTSl3vxZRK8niYisurLaNVLKFO2ax+MqwYa7fMMvqCCscnMhia2aiM
         U8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCCqN4WenreXQXaeokHFsokNS6R/AL5lZmu0td1QuDM=;
        b=5MJZj1RGXGVOmrUBAXBfUjlbnmm2axxhZWjf+lUmnxvKIGKw1K84K2gKuuKCTshtUk
         GxQ+EjBJ3hop0r3Yth/vTIJd6OI95dkEO/7AaHHtQ6wiabmfPAPYlaVbuRgAVqmJJ5KH
         bJymsJ/Mf1oZHXQBfDEVww5yw6lEJ277l3y/BJ5HhN4Ak16dk4rR5bKwEhnJGdl0IzEp
         hBMUq8zz+d8Z41e6Ha52jGt47IrGLghswvLi036bjO/8W0YyRghokzEcpTNyreH1bM6Y
         wEsVik11TdFY1aeQw5mk/nrhoF5SomOTpL2lyvUAL6+8OIi5gyra0itth+dSSvKwqqbi
         ZgVQ==
X-Gm-Message-State: AO0yUKW0LUxMMSpFZCCdY1c7AUfPKjy5GuL09QGbuxvgzNaxgzyNfHVA
        un/qC4p2aCZ1v6CXy0/4UIe88RZUhlpXL889STiJXEI5
X-Google-Smtp-Source: AK7set9QL2QkQ49Qhg6uKjBzP+LgUwTc0wS8D8yBzOZ4kzLBpGFz7I7lfHxcyo2UhLdIflGXC8hUib6BQMD5ha+mcIE=
X-Received: by 2002:a05:6808:ec7:b0:364:c0a5:1fcf with SMTP id
 q7-20020a0568080ec700b00364c0a51fcfmr1118930oiv.58.1676913402910; Mon, 20 Feb
 2023 09:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20230220010428.16910-1-rdunlap@infradead.org>
In-Reply-To: <20230220010428.16910-1-rdunlap@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Feb 2023 09:16:32 -0800
Message-ID: <CAF6AEGvFsDmFnWzg09Mpk3BkaiKwZvJRKAi=YQAp=WLz+sE4Cw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: DEVFREQ_GOV_SIMPLE_ONDEMAND is no longer needed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 5:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> DRM_MSM no longer needs DEVFREQ_GOV_SIMPLE_ONDEMAND (since dbd7a2a941b8
> in linux-next: PM / devfreq: Fix build issues with devfreq disabled),
> so remove that select from the DRM_MSM Kconfig file.
>
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

Thanks

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
> v2: since <linux/devfreq.h> has been patched, this select is no longer
>     needed (Rob Clark)
>
>  drivers/gpu/drm/msm/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
>
> diff -- a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -23,7 +23,6 @@ config DRM_MSM
>         select SHMEM
>         select TMPFS
>         select QCOM_SCM
> -       select DEVFREQ_GOV_SIMPLE_ONDEMAND
>         select WANT_DEV_COREDUMP
>         select SND_SOC_HDMI_CODEC if SND_SOC
>         select SYNC_FILE
