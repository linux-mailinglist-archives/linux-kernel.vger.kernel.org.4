Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879DA7022C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbjEOEOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbjEOEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:14:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B55170A;
        Sun, 14 May 2023 21:14:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so22744161a12.0;
        Sun, 14 May 2023 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684124039; x=1686716039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAfAyWJM6kDeKOF0uWuVmOKeYtigMn9m5Gm4oYh5/1k=;
        b=in7SNlKvFLMHyBOPoGWT0A0A43nuv+Y8QLz/dXuudygoMg757DOFucNKj5GDVHE3Py
         xyjFGk9HqZ/jTOgUZ2ektMx3/DYT95Fi09HJDTbEn2PoTlBY8gDzcACcjb+imJE6zEC7
         o7nL4LBROMfhX0j2GDBKUl29lPF51ddML2i1JeVqbXgRPpQcV5w05PTOOuyBnEBZZrVq
         doB5tnq6jAePO4qECM0pAiHy0Hk2XZGRJgCQ2e1Y+8eBIg8UfFbQkUwwubd4kPjPtpcv
         p9I4KKbg1DjeUFSnjXd1zb6nbNwWbbkTY2PHVC9nq/s6s9eRWVOBPjFNs58ll9numVaI
         3Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684124039; x=1686716039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAfAyWJM6kDeKOF0uWuVmOKeYtigMn9m5Gm4oYh5/1k=;
        b=Y++BvhOzilVMfbuvARcOlS+hdWeG9H0JBmU47EvQ64Ppg/y4Sj40Fr5wapTr6P2WNz
         C+R8tSDE1Nc7VzJgJoqkTIUnRn1GtysZ7c8lIiqY/q/GvQ5PribNcn9v7kAuJoMPk/l9
         Q5DjrzoczrZejqUjtNaWRSR9KznmDQF55zzk109hhjoK0wkVYx8pFgUswCA33hE/AiOf
         rcWZj+2tqQUyQpaEQjXGE8P545IgAIE7aLnKu7Tp3nTJUxoUGuysCSi4kyNYAIMd073n
         fVL6qcduwbSnhimwSrX6lt8VIHkFUDuH8G/HWk4IgCXec5Soi8KPYbRhfQ7oVHdMWF1Y
         GaXg==
X-Gm-Message-State: AC+VfDwQik9xhGKthJSprCxw5+1R6jkl7D/18hJiVnjxEevn2ef7/CW+
        M2H16z52mMLxGWlOcSekthfTNBdmNjztzhCvcgE=
X-Google-Smtp-Source: ACHHUZ6voWTaTMIowSruvmBEdLbuJphCoWLq/VwBTeCuUyR+0/V6maMf2Q702YBKlZOG7A4qipBa10dRKNUwfdaW8t0=
X-Received: by 2002:aa7:d058:0:b0:510:503e:1a1b with SMTP id
 n24-20020aa7d058000000b00510503e1a1bmr2489031edo.25.1684124039494; Sun, 14
 May 2023 21:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230507144753.192959-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507144753.192959-1-krzysztof.kozlowski@linaro.org>
From:   Inki Dae <daeinki@gmail.com>
Date:   Mon, 15 May 2023 13:13:23 +0900
Message-ID: <CAAQKjZNx2xp-tzfpEhA4ET94bTtaV_P6P+P6bQiDTnR_4zG3Ew@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: g2d: staticize stubs in header
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

2023=EB=85=84 5=EC=9B=94 7=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 11:48, K=
rzysztof Kozlowski
<krzysztof.kozlowski@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Stubs for !CONFIG_DRM_EXYNOS_G2D case in the header should be static
> inline:

Same patch[1] was posted before so I picked up the previous one.

[1] [PATCH] drm/exynos: fix g2d_open/close helper function definitions
(kernel.org)

Thanks,
Inki Dae

>
>   drivers/gpu/drm/exynos/exynos_drm_g2d.h:37:5: warning: no previous prot=
otype for =E2=80=98g2d_open=E2=80=99 [-Wmissing-prototypes]
>   drivers/gpu/drm/exynos/exynos_drm_g2d.h:42:6: warning: no previous prot=
otype for =E2=80=98g2d_close=E2=80=99 [-Wmissing-prototypes]
>
> Fixes: eb4d9796fa34 ("drm/exynos: g2d: Convert to driver component API")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.h b/drivers/gpu/drm/ex=
ynos/exynos_drm_g2d.h
> index 74ea3c26dead..1a5ae781b56c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
> @@ -34,11 +34,11 @@ static inline int exynos_g2d_exec_ioctl(struct drm_de=
vice *dev, void *data,
>         return -ENODEV;
>  }
>
> -int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
> +static inline int g2d_open(struct drm_device *drm_dev, struct drm_file *=
file)
>  {
>         return 0;
>  }
>
> -void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
> +static inline void g2d_close(struct drm_device *drm_dev, struct drm_file=
 *file)
>  { }
>  #endif
> --
> 2.34.1
>
