Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE56CB2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjC1AI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjC1AI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F41BDC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DCF6155A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F46C433A0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679962134;
        bh=a31qX3NPls8wS2xJkkUjJbLbCkTAHR0yJQrhzHN95uQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ELOsIYVzr3dlf8MLwTWo+T+RusazaiiuHRDol9TXBh4fbDBJK+GNKWSE1LC+/9VrM
         LcCcltI4oWxtVPZJ+HtgeZC1BIPt6LaYnTOJ7R1PuRJ3wDbEoB6LBpC63d+Y+EXcdE
         U5TX5gYCtIYzDN7fyYckFePfFs8o+MmVxwC2G/wh/ZQmOZmYCPhhFjdg4l3DH6dEqB
         POOznS6kg0BqdLl4BzSP7W2+B1DrlMUMF9ChcjpLb1BAqYIixadQNsuhPMT7+fa1PH
         IcuP/muA+NfGtQ1ilYvQBo5sgZnlQyzEgSoz2sbcOGophPfAcDHifHLhLuOfgUPluP
         AhRwFbWsGOKEg==
Received: by mail-lf1-f52.google.com with SMTP id q16so13623959lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:08:54 -0700 (PDT)
X-Gm-Message-State: AAQBX9fY6+3zAKQmIQfp7CAVgjucQslzDWKTzjBhnbZLGFKlkdgNLkIb
        OLXuMEt9x8mTwh8/UumUs0zOfesp9oyNYEOyDw==
X-Google-Smtp-Source: AKy350av9yZ1UX2KgeS/t4F1MQbA9AYH8XTj7NFPLZQKNqahnuiPNmwDXnSuMi0m/W4u7+bF7CY8qSEaKUT25OBRpTA=
X-Received: by 2002:ac2:596a:0:b0:4e8:6261:58c2 with SMTP id
 h10-20020ac2596a000000b004e8626158c2mr3860399lfp.7.1679962132705; Mon, 27 Mar
 2023 17:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230324100553.13719-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20230324100553.13719-1-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 28 Mar 2023 08:08:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY__tPtvdf+CEdnzY09Cu2PT0tmfdH_a9MD8UWnxZEu-v_A@mail.gmail.com>
Message-ID: <CAAOTY__tPtvdf+CEdnzY09Cu2PT0tmfdH_a9MD8UWnxZEu-v_A@mail.gmail.com>
Subject: Re: [PATCH v6] drm/mediatek: add mediatek-drm of vdosys0 support for mt8188
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        amy zhang <Amy.Zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

Jason-JH.Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=882=
4=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:06=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Nathan Lu <nathan.lu@mediatek.com>
>
> add driver data of mt8188 vdosys0 to mediatek-drm and the sub driver.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

>
> Signed-off-by: amy zhang <Amy.Zhang@mediatek.com>
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> Rebase on maintainer's tree[1]
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.gi=
t/log/?h=3Dmediatek-drm-next
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index dce2d86df6d9..6dcb4ba2466c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -176,6 +176,18 @@ static const unsigned int mt8186_mtk_ddp_ext[] =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
> +static const unsigned int mt8188_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_POSTMASK0,
> +       DDP_COMPONENT_DITHER0,
> +       DDP_COMPONENT_DP_INTF0,
> +};
> +
>  static const unsigned int mt8192_mtk_ddp_main[] =3D {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
> @@ -272,6 +284,11 @@ static const struct mtk_mmsys_driver_data mt8186_mms=
ys_driver_data =3D {
>         .mmsys_dev_num =3D 1,
>  };
>
> +static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data =3D=
 {
> +       .main_path =3D mt8188_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt8188_mtk_ddp_main),
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =3D {
>         .main_path =3D mt8192_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt8192_mtk_ddp_main),
> @@ -308,6 +325,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8183_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8186-mmsys",
>           .data =3D &mt8186_mmsys_driver_data},
> +       { .compatible =3D "mediatek,mt8188-vdosys0",
> +         .data =3D &mt8188_vdosys0_driver_data},
>         { .compatible =3D "mediatek,mt8192-mmsys",
>           .data =3D &mt8192_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8195-mmsys",
> @@ -677,6 +696,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8186-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8188-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8192-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8195-disp-mutex",
> --
> 2.18.0
>
