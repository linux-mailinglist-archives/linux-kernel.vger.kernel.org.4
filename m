Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B779A67DAE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjA0ApQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjA0ApP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:45:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793C457CD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A2C2B81F6D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93AFC433A4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674780311;
        bh=y9mD289SL86gW1Qx8+svxq3Jdqzqo8lV4lWXHSdyUw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kXTFc2ZVvV6nrb/N0J6IqkkgM5CktBRtGoW2j4HrS65BgeX4fSn91HoIOYRvRebaV
         ru8LU3MeHYNUAH46mLPNRJJkQHGySv0GsPo6lklh0/BViK6CcdG5MgnpRGjTpzNZ2I
         r00mMCGRt12oi1EfFDFCcyp8rsBvkxFgBm05PjoJm6xhs9waCOTd6eagQZoEy3kGld
         qz3HXafxehbI4xlHIe+z+bx4UOKwhQKXzgzAPT6Bm2A/op8dmRfehBB6NZ/F/WvTZ6
         oYmrvNkp6pkiiZsxTdnHzmcbpZx4266ye6WjDp9YyNrJ7J26wxdd5/FBVRzMSRbLwC
         SxFmRIWlHGvSQ==
Received: by mail-lj1-f175.google.com with SMTP id a37so3941866ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:45:11 -0800 (PST)
X-Gm-Message-State: AFqh2kr+aJLdnXczbOWKS/SVZcGCaeUmakaZjBrlMUuY/9mCklJWREGX
        vat9nYuOCKokk+YoAXWxDm+ocN1MoCFfPu2xqA==
X-Google-Smtp-Source: AMrXdXuvkx1XDqmQrDK35Brew8JLnKkqQAQNvYpsKpbztY/Rn3PnkwInSSUI7HPk0s6JeW5soyPV5j77OmFHHMbZNjI=
X-Received: by 2002:a2e:bd13:0:b0:287:4eeb:53dc with SMTP id
 n19-20020a2ebd13000000b002874eeb53dcmr2199731ljq.27.1674780309880; Thu, 26
 Jan 2023 16:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20230111024443.24559-1-miles.chen@mediatek.com>
In-Reply-To: <20230111024443.24559-1-miles.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Jan 2023 08:44:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9SzkF7j5Zj5WpQRbcHeR3FO8Z7sYdm5-8FSZqQNAjfoQ@mail.gmail.com>
Message-ID: <CAAOTY_9SzkF7j5Zj5WpQRbcHeR3FO8Z7sYdm5-8FSZqQNAjfoQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: stop using 0 as NULL pointer
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
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

Hi, Miles:

Miles Chen <miles.chen@mediatek.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8811=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Use NULL for NULL pointer to fix the following sparse warning:
> drivers/gpu/drm/mediatek/mtk_drm_gem.c:265:27: sparse: warning: Using pla=
in integer as NULL pointer

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap funct=
ion")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> ---
>
> Change since v1:
> Add Fixes tag
>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 47e96b0289f9..06aadd5e7f5b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -262,6 +262,6 @@ void mtk_drm_gem_prime_vunmap(struct drm_gem_object *=
obj,
>                 return;
>
>         vunmap(vaddr);
> -       mtk_gem->kvaddr =3D 0;
> +       mtk_gem->kvaddr =3D NULL;
>         kfree(mtk_gem->pages);
>  }
> --
> 2.18.0
>
