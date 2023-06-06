Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D6724CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjFFTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbjFFTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:15:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C93101
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:15:28 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-19fa4346498so4348792fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686078928; x=1688670928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAk03zc/P/OUBf9OltBs8qALiN+AwjCHAF6DHi78NMo=;
        b=DyvL9RFpz8GOU9YhwCfULntKPHtNrAUcARBUQCNBYhgoQiWWFdbW8uYOxkjgi8NDwA
         nn6zhs0SkIngskqmlTsmx3awaMXnKCq/k10SCpaCPy0P9+B5wMguf9Qk/TVvad5hL2F4
         6PrqYtC9g2v3hieAx44HLVuXpSnnf668JXvJXnswgzdFjzccf7reUATKqmtqilfU7wL2
         jd6qdNMgdvWUwNfP2GnXXXqRJIjo0HLwiLYhtKIhDzbSjdsY2wlAu1WAJB3MvCSNDntl
         bU6Z4wRrL2v5/y6Qp3urfT/S+KdSkMHOx5R3mK6oRciov1OP/9WSD5htLT4t/usqGpPp
         tKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078928; x=1688670928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAk03zc/P/OUBf9OltBs8qALiN+AwjCHAF6DHi78NMo=;
        b=Y8Ibay/5OxAdRQlaM7UgI97yX4Iz/DHZ4AVKAULyD/V0lNo0XcWOhB/cF7atOzaKCS
         OahWyMJ+TlB4hXBCvKViKi6HG4ZniflEqt+ualcerwT2ClwckyijeUXadqlsrZePXfEr
         lHq/TYjX1vcS4uDC9qzUW3KAIG57JOYr3Zj94rQSR9t6vmwyLAPOY5xvveQgCHgeJ7wz
         /prJCELj88Wd48ZQ/OqMc0SSHhQ4zRQP4cguiEdBXejMh6fQf0LUNmwpsiFSjQ1m9j4K
         0Ikj0AfXvKtdDSOsrcozoQ3bPAhaX8UTWAPL+RMxogRXNVtW+JchwWsRNOu7mi6Exh+/
         zBDg==
X-Gm-Message-State: AC+VfDw4WgFlanuVDU8Ta31yNwmjJxeLomDYwh401HznEFF4Wcf8TRgO
        tTsyWsCjGlRdEUgQanY9N9bfA9zTNEbYaZC9U50R0rXC
X-Google-Smtp-Source: ACHHUZ7Lkapm2zMouLuWDboS2854o1EUXzupJUtwa8UNGIhcc5zWPNz52eerIVZdGHIaFomZfJk728gzaKKw6No/oZM=
X-Received: by 2002:a05:6870:52d6:b0:1a3:125d:333b with SMTP id
 p22-20020a05687052d600b001a3125d333bmr1927975oak.56.1686078927962; Tue, 06
 Jun 2023 12:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230606133328.148490-1-suijingfeng@loongson.cn>
In-Reply-To: <20230606133328.148490-1-suijingfeng@loongson.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Jun 2023 15:15:16 -0400
Message-ID: <CADnq5_MdNSBJuNrJC2-fRByhEoUqEJmMGATT+OrFvjqA7k4F5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: display/Kconfig: replace leading spaces with tab
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Jun 6, 2023 at 9:33=E2=80=AFAM Sui Jingfeng <suijingfeng@loongson.c=
n> wrote:
>
> This patch replace the leading spaces with tab, make them keep aligned wi=
th
> the rest of the config options. No functional change.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/amd/display/Kconfig | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/di=
splay/Kconfig
> index 2d8e55e29637..04ccfc70d583 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -42,16 +42,13 @@ config DEBUG_KERNEL_DC
>           Choose this option if you want to hit kdgb_break in assert.
>
>  config DRM_AMD_SECURE_DISPLAY
> -        bool "Enable secure display support"
> -        depends on DEBUG_FS
> -        depends on DRM_AMD_DC_FP
> -        help
> -            Choose this option if you want to
> -            support secure display
> -
> -            This option enables the calculation
> -            of crc of specific region via debugfs.
> -            Cooperate with specific DMCU FW.
> +       bool "Enable secure display support"
> +       depends on DEBUG_FS
> +       depends on DRM_AMD_DC_FP
> +       help
> +         Choose this option if you want to support secure display
>
> +         This option enables the calculation of crc of specific region v=
ia
> +         debugfs. Cooperate with specific DMCU FW.
>
>  endmenu
> --
> 2.25.1
>
