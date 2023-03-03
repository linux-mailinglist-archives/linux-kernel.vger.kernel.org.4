Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57706AA3CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjCCWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjCCWG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:06:27 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0F7042C;
        Fri,  3 Mar 2023 13:56:45 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1763e201bb4so4671349fac.1;
        Fri, 03 Mar 2023 13:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677880541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6AFZEkYJ2SPZLOLjAy2GSQIbeAnHolJ0EeRAikdfL+4=;
        b=P3d2oihIqjPJuCposna/iUIlVvMp/CshgIa/46oePogW1VU1iA6kwOQDkuYw1vYVMG
         GTW8+NUonaE6nILgGlnJ0/4CGjZCM0Z9nVnzqfEXUqA7VA7xPbfi0Q4657v8yd4moT5K
         aRcTrSGk3s1D9w6H4A6yeAL33Yt4xR1Z3E3cFOVh170NzcifWddufl/LLqRDvyy+iAy1
         f78AtLxrWTcrvplFQYXzA0zLVmKnmuD0iDRA71HWr2siPdPWT02JEJLLYL7anyR/jxXY
         OXSvcMYvaMJDXNtnD5zfvdbZQjZWiTa36yUgwBy11TjYMPJEtAUA4YI/7K7Z75fgmlv2
         o2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677880541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AFZEkYJ2SPZLOLjAy2GSQIbeAnHolJ0EeRAikdfL+4=;
        b=gi2vNI4mdofQYfdpJjp+0OaMZxMWE6IJs1cOmg/W+JYaeCyLFkmONn9tZqL5sIVZkE
         alhWxE1ab82zneAIAhB5wBZ4Zan8PnE5QWRKaVAPhmMhFL19jskH4jBWDCO9tiyNLOJa
         fxfEHppnJSuwtoTyhOisVtIzzzB1fpH/NtjXM5QirQoI0d2rIgIv1oHYKGeAaTRharHO
         AwrQ8oVNkaDNxdRauE5rKSo1wlUjGxp1mgIrZTr5Tkj5n03KTGLPlOZlJpnmaw4xoO5k
         BTOW600oeftVOJeTbMS1khEcTmsaj/BpHcaFoiRLVqth1/OQVDSK65mt6DPccwpsEqAs
         J/4g==
X-Gm-Message-State: AO0yUKUip/FxSV38L/fbnvj9aTqQnr2JcwYx/kQ5uvDxd3RoTtGe5ael
        z32TLqlGOgU9O4aiA7iFJi8EKtL8xu3ftJqJOso=
X-Google-Smtp-Source: AK7set98BMz0wptKlJctbuyi8i0Ffce6eA9OhFewFlRnUKWKfPeYpxam4lXKQdp037LmrN3olRPSo6rPFsRvOqUB2cA=
X-Received: by 2002:a05:6871:6b9d:b0:175:4a1f:edff with SMTP id
 zh29-20020a0568716b9d00b001754a1fedffmr1100138oab.8.1677880540951; Fri, 03
 Mar 2023 13:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20230303120233.1878140-1-usama.anjum@collabora.com>
In-Reply-To: <20230303120233.1878140-1-usama.anjum@collabora.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 3 Mar 2023 16:55:29 -0500
Message-ID: <CADnq5_M_irvEL4Ggr4UaK2n5GeGD_EchqtZvumBtmdOUqqewhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove dead code
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Kun Liu <Kun.Liu2@amd.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        kernel@collabora.com
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

Applied.  Thanks!

Alex

On Fri, Mar 3, 2023 at 7:03 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The less than zero comparison of unsigned variable "value" is never
> true. Remove dead code.
>
> Fixes: c3ed0e72c872 ("drm/amdgpu: added a sysfs interface for thermal throttling")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f212cae0353f..0ffe351c1a1d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1738,7 +1738,7 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
>         if (ret)
>                 return ret;
>
> -       if (value < 0 || value > 100) {
> +       if (value > 100) {
>                 dev_err(dev, "Invalid argument !\n");
>                 return -EINVAL;
>         }
> --
> 2.39.2
>
