Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692BC72A2BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFITDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFITDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:03:50 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF38B3A80
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:03:48 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a49716e9c5so826537fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686337428; x=1688929428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB940f4muHJWORGyH4neqULh88IjnoNoST1yjCNDlT4=;
        b=L/qpe2IwGUdKq298Sx7UGN+KI97pjXNbdkQXkeMOXJYo6NpEj72QLkoF7c4xv2As08
         vjWJcDwFrQcvvk1/Gv3asfx0OhTu/FahxxeTyMGZ5UU1zHho6i9fEm45NxAhP2CrhnV7
         66vrTVSvo39siWmYCSk/N/kBkesrQyuM8VO52NJI3QZEbOtJDtsWt1Jkbc0OW0EbO/+5
         sv8PJ/ZKgy+bwlDYLxMFFf/ktQQwaIeet2CGf9YEm0DCb7NEZS0zAQ9s2pksrcfynD7m
         aq7xgolR8ukRt4DzUlUndtZW5Sog33ownLyjfoOh9GyeuLKlNuhQQcpZWvzgKaz4HWWA
         2hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337428; x=1688929428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB940f4muHJWORGyH4neqULh88IjnoNoST1yjCNDlT4=;
        b=J637tVAjRv4JQm4UdlWCeveb+oX2PTNITaWow+xCYUCOXa61USR7VZhpASAQTPZEgv
         hY+zXdOKVvQtgxwyLdUCMTFuIi4v6wRYD8a2gBxiYZGY09qNV9+KaPvZv8Zm/B6tvTUH
         1HVBQ4pyQM5rwCyaaHWXeRL0EO/onEfvAPdpoIoB4quo8wnIzAjVslWSXmtzSmeRsU3P
         b1h/UztCXHOGr7PV4k/RLWnbDF9Okipt5bIYs41HNSM+wrxsZ1YK16SsUPSZ90hYc9Sx
         5m19IY0ieW9zu6CrLS8PB2nlnHCjPEz7XkCntrtN49Ob6umYAgJ824Z0FGpMJwmnm2RZ
         fM3g==
X-Gm-Message-State: AC+VfDzKTTnOtvznAriWhwv7vVLc/vpMaj1Sr+cbS7uB8H/gYqzJX/QB
        QS2Heqi2I98wErl35IPaSDDQBivLYUX91z2EmOVD7n6F
X-Google-Smtp-Source: ACHHUZ7lt542r64vRRZ6FrtQ3T3tYd1s0VYWalwcDu9UbyWKq6grTawJybrXl3hxCgMjRiPYRrxXK51HcuPyesLRSnM=
X-Received: by 2002:a05:6870:710:b0:19f:ae40:6492 with SMTP id
 ea16-20020a056870071000b0019fae406492mr2195427oab.5.1686337427804; Fri, 09
 Jun 2023 12:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-15-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-15-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Jun 2023 15:03:36 -0400
Message-ID: <CADnq5_OpT29qg+dbqEmkRKP1-OqEV1QqPU7Wyd0AV1idHAJ4Sw@mail.gmail.com>
Subject: Re: [RESEND 14/15] drm/radeon/radeon_ttm: Remove unused variable
 'rbo' from radeon_bo_move()
To:     Lee Jones <lee@kernel.org>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Jerome Glisse <glisse@freedesktop.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

This patch is no longer applicable.

Alex

On Fri, Jun 9, 2023 at 4:18=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_ttm.c: In function =E2=80=98radeon_bo_move=
=E2=80=99:
>  drivers/gpu/drm/radeon/radeon_ttm.c:201:27: warning: variable =E2=80=98r=
bo=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jerome Glisse <glisse@freedesktop.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index 4eb83ccc4906a..de4e6d78f1e12 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -197,7 +197,6 @@ static int radeon_bo_move(struct ttm_buffer_object *b=
o, bool evict,
>  {
>         struct ttm_resource *old_mem =3D bo->resource;
>         struct radeon_device *rdev;
> -       struct radeon_bo *rbo;
>         int r;
>
>         if (new_mem->mem_type =3D=3D TTM_PL_TT) {
> @@ -210,7 +209,6 @@ static int radeon_bo_move(struct ttm_buffer_object *b=
o, bool evict,
>         if (r)
>                 return r;
>
> -       rbo =3D container_of(bo, struct radeon_bo, tbo);
>         rdev =3D radeon_get_rdev(bo->bdev);
>         if (!old_mem || (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
>                          bo->ttm =3D=3D NULL)) {
> --
> 2.41.0.162.gfafddb0af9-goog
>
