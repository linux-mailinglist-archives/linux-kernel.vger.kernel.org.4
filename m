Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF667FC49
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjA2CNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjA2CND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:13:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8878D537
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:13:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C6CB80C80
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302BEC433A7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674958380;
        bh=bDBCMu/zp8KjdqS3kbfEEJifaegCwLaj9SYK4obytd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IO5XW3WULpEnzd4xFl9C0XW1AThAkrj3dsblKaf5+atHlkwaAzHJter9AKUKFPJX2
         /JRAtIpxSoZaMxMp+b9wFdLnTyIKQAVHgRwVqEUKr56HjFH9tr8M8Cy6dnImwVctGa
         krhNjbI21aohw0IufJ6X0mCnKlMUgIwIPFFlH5ePp1KEIyNopVd4WsLz5lI3arsKFx
         DeDlyzBiXvI3Qz+h4jraJZvow2tofh36qELB0cm0WPhNsBDamZoZeBBe41uaicDicX
         O24ez/nFrxyGXl5EssymlMLJbfqu1d4BPjQ0yMvJOjyFIPt+XnxCu2uJcn7atOj58S
         1WS/YKZ2EvC2g==
Received: by mail-lj1-f178.google.com with SMTP id t12so9469678lji.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:13:00 -0800 (PST)
X-Gm-Message-State: AFqh2krpL7eBdNBJrgIuEBPdK3HVBm0e+kzOdFAO9+AtmYctc2yxceQ2
        rd+zGWQwtP3HSrVBVR6NJH5P61NPQhNi/kLMwA==
X-Google-Smtp-Source: AMrXdXshUXXA9XhEjUJCThTvj3W2ig/URidG30bwfoNNiTptwiWYB7juno5yIjwBpSxxDjxTUvjSkRcPFqRJH6TADrA=
X-Received: by 2002:a2e:a80b:0:b0:28b:802d:ecee with SMTP id
 l11-20020a2ea80b000000b0028b802deceemr2952306ljq.259.1674958378087; Sat, 28
 Jan 2023 18:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20230127165409.3512501-1-robdclark@gmail.com>
In-Reply-To: <20230127165409.3512501-1-robdclark@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 29 Jan 2023 10:12:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-fCTpZs9-LU+MaMd0EMrQQW51OLjQwnixupEVu-Vr5Ug@mail.gmail.com>
Message-ID: <CAAOTY_-fCTpZs9-LU+MaMd0EMrQQW51OLjQwnixupEVu-Vr5Ug@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Remove unused GEM DMA header include
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Doug Anderson <dianders@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:DRM DRIVERS FOR MEDIATEK" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

Rob Clark <robdclark@gmail.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Rob Clark <robdclark@chromium.org>
>
> No longer needed since the removal of dependency on DMA helper.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 2ea8aec56bf1 ("drm/mediatek: Remove dependency on GEM DMA helper")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index cd5b18ef7951..7e2fad8e8444 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -20,8 +20,8 @@
>  #include <drm/drm_fbdev_generic.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem.h>
> -#include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_ioctl.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> --
> 2.38.1
>
