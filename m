Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000B7022D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbjEOERN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbjEOERL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:17:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2E10C1;
        Sun, 14 May 2023 21:17:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so21665219a12.2;
        Sun, 14 May 2023 21:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684124227; x=1686716227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUag73btUuB8LmzKHUfEj0izB5dA8C+cF7zWWtW7WKM=;
        b=ExyvUQYU1tuyY35h0jfdinlYAVsQKQxoEVzcLVTkK4o5Zr2rgAuMRES0ix8cEY06oJ
         HLALJwcBmzrcI/1VOnC0G2tOk/l0jV+waE8IptWGDdzN6LZz5eMuZK9SdtCPDqO171YA
         Cj+xNNu/CfvMWEzBfGc804G3CI/hGZFuTku5qx239SnRLdALTpHnG78O8el1baFK4h9L
         goHqFSJMpceKqRsZZ/mC1dgsxWjCj+vOB9clOyfdDSLTTM2J3/UQq2Isw/tNXbqdb2Ud
         Y5TMcR2FirW2d6kTUtlkBflktxxeLN0C8ovzv05mWkHIbFhBw+fUkD6Aau3blP/5z6Fz
         Cb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684124227; x=1686716227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUag73btUuB8LmzKHUfEj0izB5dA8C+cF7zWWtW7WKM=;
        b=AnsKhqaheVFWpc8WJN9jEL/jqsc7jxqi1aIqBfguL6eDv6BuflMStE5Yvok+dlzdeq
         O9Xgi5QWT6H+eBbp54N2E5GbyEpz9I5jz3eieutnXLigFkiwL3txcYq2htC6LA7QurDk
         pZNDJWgM4y99xlEktYAdK5IN0qhfJavvD5YIT/4lr8LD8QpqfXOR0ZPX/yZqwuwgTlpd
         UNtarkG4fSEaF5To+6JSs9vnmdvsBljaUaFqjuNpS5tLJ4Y7HYKmz59i/svoQTXKAchG
         zQ3TZ+Cif8F7ucTlRJi8HVHjmNlTj4XJD4Gn3lUeysyUVIgfwQRo/Z6fi+giaEbHE6Ij
         Vxmw==
X-Gm-Message-State: AC+VfDzA+KvGY9Do8RfN2Mp4USBWAwpO/0TMao88iyifeTucl4/wAakf
        +Akg4uvk2KvI9qwj9NDlyDuuH/0vl//z/8gfXlI=
X-Google-Smtp-Source: ACHHUZ6r2BzwpIgitKkdrxJvQRqzaXlHpTU+BnUZs8GvPdgtATRrC8nS67ISzTWLFCUxIM49EI9Yj2sxhXviVj/dx6I=
X-Received: by 2002:a05:6402:886:b0:50d:b7e5:fde8 with SMTP id
 e6-20020a056402088600b0050db7e5fde8mr14816027edy.26.1684124227281; Sun, 14
 May 2023 21:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230507144753.192959-1-krzysztof.kozlowski@linaro.org> <CAAQKjZNx2xp-tzfpEhA4ET94bTtaV_P6P+P6bQiDTnR_4zG3Ew@mail.gmail.com>
In-Reply-To: <CAAQKjZNx2xp-tzfpEhA4ET94bTtaV_P6P+P6bQiDTnR_4zG3Ew@mail.gmail.com>
From:   Inki Dae <daeinki@gmail.com>
Date:   Mon, 15 May 2023 13:16:30 +0900
Message-ID: <CAAQKjZP7T6864R4V9GAGbL60-e-VFohPqONB7V=fTXVSX+=jWw@mail.gmail.com>
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

2023=EB=85=84 5=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:13, I=
nki Dae <daeinki@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Krzysztof,
>
> 2023=EB=85=84 5=EC=9B=94 7=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 11:48,=
 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Stubs for !CONFIG_DRM_EXYNOS_G2D case in the header should be static
> > inline:
>
> Same patch[1] was posted before so I picked up the previous one.
>
> [1] [PATCH] drm/exynos: fix g2d_open/close helper function definitions
> (kernel.org)

[1] https://lore.kernel.org/lkml/20230425165618.2ztg4mecuvpkdg3a@intel.inte=
l/T/

Just corrected the link.

>
> Thanks,
> Inki Dae
>
> >
> >   drivers/gpu/drm/exynos/exynos_drm_g2d.h:37:5: warning: no previous pr=
ototype for =E2=80=98g2d_open=E2=80=99 [-Wmissing-prototypes]
> >   drivers/gpu/drm/exynos/exynos_drm_g2d.h:42:6: warning: no previous pr=
ototype for =E2=80=98g2d_close=E2=80=99 [-Wmissing-prototypes]
> >
> > Fixes: eb4d9796fa34 ("drm/exynos: g2d: Convert to driver component API"=
)
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_g2d.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.h b/drivers/gpu/drm/=
exynos/exynos_drm_g2d.h
> > index 74ea3c26dead..1a5ae781b56c 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.h
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
> > @@ -34,11 +34,11 @@ static inline int exynos_g2d_exec_ioctl(struct drm_=
device *dev, void *data,
> >         return -ENODEV;
> >  }
> >
> > -int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
> > +static inline int g2d_open(struct drm_device *drm_dev, struct drm_file=
 *file)
> >  {
> >         return 0;
> >  }
> >
> > -void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
> > +static inline void g2d_close(struct drm_device *drm_dev, struct drm_fi=
le *file)
> >  { }
> >  #endif
> > --
> > 2.34.1
> >
