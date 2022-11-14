Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19346273AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiKNADS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:03:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4B4FCFD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:03:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49440B80C9D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B36C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668384191;
        bh=Y6+GesINiuVpEDuqYdsy5iev4MVdI1Uu35S43Ufbsfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pHR9XXS3jciNgcTlJe4f8U6qRQubEv/9wFdbpipVtW9H3ufdxALFDsKKrsPl8RTNH
         veSGQPkphxJU4IyIsY5qFZN4s953ZZYAeVaoeorksvV/kAX7oXZ6FGWAqFE8QCTgF2
         S4MOashNnZBGTtvwa9S62atATbfCtC/aMFdDB0viGiXrxOpDOQLV0WszHer8MxKxzt
         hOjzInM+pQN5E/J1iocH8WKSt3DLAgmKA0uEBoH5jHaqSR0+VqzMUBhhUW79b4AukJ
         UbEBVMlcBNgzjbXEKRvRgfxbRzbHtOJPD8pQdjKdOmPmMMrQbYl65DscvL4KR6Es5k
         pAJCtg/UF6/bw==
Received: by mail-ot1-f46.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso5842785otb.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:03:11 -0800 (PST)
X-Gm-Message-State: ANoB5pkVq3HVgVSE2DuiJ/PopUytqkbH3cuiXqRmGVu9vXagSoO+u3qF
        8a9vZ/eg6mGx40jPsAxKJL1piWiwFR6u/LA76g==
X-Google-Smtp-Source: AA0mqf4gu4W/Men7HSJ8Gnbjz5l/uOk6f5sN2spmarR43u5YDzmkrtAca4fKVNC6ZOOoT9otESBFHAQKHzDDPV0mrKQ=
X-Received: by 2002:a9d:4b02:0:b0:661:b04c:41d9 with SMTP id
 q2-20020a9d4b02000000b00661b04c41d9mr5409278otf.92.1668384190909; Sun, 13 Nov
 2022 16:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20221102154712.540548-1-nathan@kernel.org>
In-Reply-To: <20221102154712.540548-1-nathan@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 14 Nov 2022 08:02:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9nH8tW6yP=3giQmSKQjnQ+pmaGRQ0N3_ODFg1uS-rvCA@mail.gmail.com>
Message-ID: <CAAOTY_9nH8tW6yP=3giQmSKQjnQ+pmaGRQ0N3_ODFg1uS-rvCA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix return type of mtk_hdmi_bridge_mode_valid()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

 Hi, Nathan:

Nathan Chancellor <nathan@kernel.org> =E6=96=BC 2022=E5=B9=B411=E6=9C=882=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A11:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
>
>   drivers/gpu/drm/mediatek/mtk_hdmi.c:1407:16: error: incompatible functi=
on pointer types initializing 'enum drm_mode_status (*)(struct drm_bridge *=
, const struct drm_display_info *, const struct drm_display_mode *)' with a=
n expression of type 'int (struct drm_bridge *, const struct drm_display_in=
fo *, const struct drm_display_mode *)' [-Werror,-Wincompatible-function-po=
inter-types-strict]
>           .mode_valid =3D mtk_hdmi_bridge_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
>
> ->mode_valid() in 'struct drm_bridge_funcs' expects a return type of
> 'enum drm_mode_status', not 'int'. Adjust the return type of
> mtk_hdmi_bridge_mode_valid() to match the prototype's to resolve the
> warning and CFI failure.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Chun-Kuang.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 4c80b6896dc3..6e8f99554f54 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1202,9 +1202,10 @@ static enum drm_connector_status mtk_hdmi_detect(s=
truct mtk_hdmi *hdmi)
>         return mtk_hdmi_update_plugged_status(hdmi);
>  }
>
> -static int mtk_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
> -                                     const struct drm_display_info *info=
,
> -                                     const struct drm_display_mode *mode=
)
> +static enum drm_mode_status
> +mtk_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
> +                          const struct drm_display_info *info,
> +                          const struct drm_display_mode *mode)
>  {
>         struct mtk_hdmi *hdmi =3D hdmi_ctx_from_bridge(bridge);
>         struct drm_bridge *next_bridge;
>
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> --
> 2.38.1
>
